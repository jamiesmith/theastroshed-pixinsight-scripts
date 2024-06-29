#!/usr/local/bin/bash

shopt -s globstar


scriptsDir="src/scripts"
releasesDir="$(pwd)/releases"

buildDir=tmpBuild
rm -rf "${buildDir}"
mkdir -p "${buildDir}"
cp -r src "${buildDir}/"
cd "${buildDir}"

release=v0.1.5

for file in $(find . -type f -name *.js)
do
    echo $file
    sed -i "" "s|<VERSION>|${release}|g" $file
done

pluginName="TheAstroShedScripts"
today=$(date +"%Y-%m-%d")

# figure out if we need a suffix
#
suffix=""
baseZipFileName="${pluginName}-${today}"
if [ -f "${releasesDir}/${baseZipFileName}.zip" ]
then
    suffix="-$(ls "${releasesDir}" | grep -c "${baseZipFileName}")"
    echo "Needs a suffix [$suffix]"
fi
zipFileName="${baseZipFileName}${suffix}.zip"
zip -v "${releasesDir}/${zipFileName}" ${scriptsDir}/*
sha1=$(sha1sum ${releasesDir}/${zipFileName} | awk '{print $1}')
echo $sha1

exit
releaseDate=${today}
version="${today}-${suffix}"

cat << EOF > $releasesDir/updates.xri
<?xml version="1.0" encoding="UTF-8"?>
<xri version="1.0">
    <description>
        <p>This is the repository for PixInsight scripts by theastroshed.com, featuring "Fixed Tiled Zoom" and "Smart Rename View".</p>
    </description>
    <platform os="all" arch="noarch" version="1.8.8:1.9.9">
        <package fileName="${zipFileName}" 
                sha1="${sha1}" 
                type="script" 
                releaseDate="${releaseDate}">
            <title>
                The Astroshed Plugins version $version 
            </title>
            <description>
                <p>
                    ${version}: Fixed an issue for files without filters, leaving the view named "null"
                </p>
            </description>
        </package>
    </platform>
</xri>
EOF

echo "Don't forget to sign the updates file!"