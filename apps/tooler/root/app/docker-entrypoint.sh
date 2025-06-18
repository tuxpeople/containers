#set -x

# Where is the config
CONFIGFILE="/config/config.yaml"
OUTPUTFILE="/output/index.html"
TEMPLATEDIR="/defaults"

urlencode_grouped_case () {
  string=$1; format=; set --
  while
    literal=${string%%[!-._~0-9A-Za-z]*}
    case "$literal" in
      ?*)
        format=$format%s
        set -- "$@" "$literal"
        string=${string#$literal};;
    esac
    case "$string" in
      "") false;;
    esac
  do
    tail=${string#?}
    head=${string%$tail}
    format=$format%%%02x
    set -- "$@" "'$head"
    string=$tail
  done
  printf "$format\\n" "$@"
}

write_line() {
    cat <<EOF >> ${OUTPUTFILE}
    <tr>
      <th scope="row">${LINE}</th>
      <td>${1}</td>
      <td>${2}</td>
      <td><a href="${3}">${4}</a></td>
      <td>${5}</td>
      <td class="${6}">${7}</td>
      <td><a href="${8}">${9}</a></td>
    </tr>
EOF
    LINE=$(( $LINE + 1 ))
}

version_check() {
  OLD_CLEAN=`echo $1 | sed "s/^v//g"`
  NEW_CLEAN=`echo $2 | sed "s/^v//g"`
  [ "$NEW_CLEAN" = "$OLD_CLEAN" ] && COLOR="$UPDATE_FALSE_COLOR" || COLOR="$UPDATE_TRUE_COLOR"
  echo $COLOR
}

LINE=0
COMMANDS="awk case cat command curl cut echo false grep jq printf sed set tr yq"

for cmd in $COMMANDS
do 
  if ! command -v "$cmd" >/dev/null; then
    echo "Cannot find required command $cmd."
    exit 1
  fi
done

UPDATE_FALSE_COLOR=`yq e ".settings.colors.update_false" ${CONFIGFILE}`
UPDATE_TRUE_COLOR=`yq e ".settings.colors.update_true" ${CONFIGFILE}`

cat ${TEMPLATEDIR}/header.html > ${OUTPUTFILE}


# get the number of Github Releases we need to loop through
GITHUB_NO=`yq e ".github | length - 1" ${CONFIGFILE}`

# set loop counter to 0
x=0

# while counter is less or equal the number of releases, loop
while [ $x -le $GITHUB_NO ]
do
  # load entry from config file
  NAME=`yq e ".github[$x].name" ${CONFIGFILE}`
  CURRENT_VERSION=`yq e ".github[$x].version" ${CONFIGFILE}`
  ORG=`yq e ".github[$x].gh_repo" ${CONFIGFILE} | cut -d'/' -f1`
  REPO=`yq e ".github[$x].gh_repo" ${CONFIGFILE} | cut -d'/' -f2`

  # get latest version from GitHub
  LATEST_VERSION=`curl --silent -qI https://github.com/$ORG/$REPO/releases/latest | grep ^location | tr -d '\r' |  cut -d'/' -f8-`

  # URL encode Version, as some people (eg. kustomize) do slashes into their versions!
  CLEAN_LATEST_VERSION=$(urlencode_grouped_case $LATEST_VERSION)

  # Load filter from config file and replace placeholders
  FILTER=`yq e ".github[$x].filter" ${CONFIGFILE} | sed "s/{{VERSION}}/$CLEAN_LATEST_VERSION/" | sed "s/{{ORG}}/$ORG/" | sed "s/{{REPO}}/$REPO/"`

  # Get list of all assets of the release and filter them
  DL=`curl -sL https://github.com/$ORG/$REPO/releases/expanded_assets/$CLEAN_LATEST_VERSION | sed -n 's/.*href="\([^"]*\).*/\1/p' | grep "$FILTER"`

  # Add Baseurl to the asset URL to form the full download url
  DL_URL=https://github.com$DL
  
  #################
  # SPECIAL CASES #
  #################
  # Helm does not put the binaries on Github
  if [ $REPO == "helm" ]
  then
    DL_URL=https://get.helm.sh/helm-$LATEST_VERSION-windows-amd64.zip
  fi

  # Everything after the last / of the download URL is the filename
  FILENAME=`echo $DL_URL | awk -F '/' '{print  substr($NF, 1, length($NF))}'`

  # check if the new version is newer than the current version
  COLOR=`version_check "$CURRENT_VERSION" "$LATEST_VERSION"`

  # write line to HTML table
  write_line "$NAME" "Github Release" "https://github.com/$ORG/$REPO" "$ORG/$REPO" "$CURRENT_VERSION" "$COLOR" "$LATEST_VERSION" "$DL_URL" "$FILENAME"
  echo "$NAME Github Release https://github.com/$ORG/$REPO $ORG/$REPO $CURRENT_VERSION $COLOR $LATEST_VERSION $DL_URL $FILENAME"

  # count one up to loop the next item
  x=$(( $x + 1 ))
done


# get the number of VSCode Extensions we need to loop through
VSCODE_NO=`yq e ".vscode | length - 1" ${CONFIGFILE}`

# set loop counter to 0
x=0

# while counter is less or equal the number of extensions, loop
while [ $x -le $VSCODE_NO ]
do
  # load entry from config file
  NAME=`yq e ".vscode[$x].name" ${CONFIGFILE}`
  EXTENSION=`yq e ".vscode[$x].extension" ${CONFIGFILE}`
  CURRENT_VERSION=`yq e ".vscode[$x].version" ${CONFIGFILE}`

  # Split extension into publisher and extension name
  EXTENSION_NAME=`echo $EXTENSION | cut -d'.' -f2`
  PUBLISHER=`echo $EXTENSION | cut -d'.' -f1`

  # Get the latest version by scraping the page, cuting out the embedded json and parse it
  LATEST_VERSION=`curl -s https://marketplace.visualstudio.com/items?itemName=$EXTENSION | grep jiContent | cut -d'>' -f2- | cut -d'<' -f1 | jq -r .AssetUri | cut -d'/' -f7`

  # Put together the download URL
  DL_URL="https://marketplace.visualstudio.com/_apis/public/gallery/publishers/${PUBLISHER}/vsextensions/${EXTENSION_NAME}/${LATEST_VERSION}/vspackage"
  # Alternative download URL which will not provide the correct filename when downloading
  # DL_URL="https://${PUBLISHER}.gallery.vsassets.io/_apis/public/gallery/publisher/${PUBLISHER}/extension/${EXTENSION_NAME}/${LATEST_VERSION}/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage"

  # Put together the filename
  FILENAME="${EXTENSION}-${LATEST_VERSION}.vsix"

  # check if the new version is newer than the current version
  COLOR=`version_check "$CURRENT_VERSION" "$LATEST_VERSION"`

  # write line to HTML table
  write_line "$NAME" "VSCode Extension" "https://marketplace.visualstudio.com/items?itemName=$EXTENSION" "$EXTENSION" "$CURRENT_VERSION" "$COLOR" "$LATEST_VERSION" "$DL_URL"  "$FILENAME"
  echo "$NAME VSCode Extension https://marketplace.visualstudio.com/items?itemName=$EXTENSION $EXTENSION $CURRENT_VERSION $COLOR $LATEST_VERSION $DL_URL $FILENAME"

  # count one up to loop the next item
  x=$(( $x + 1 ))
done

cat ${TEMPLATEDIR}/footer.html >> ${OUTPUTFILE}
