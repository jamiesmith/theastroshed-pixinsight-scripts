#!/bin/sh


scriptsDir="src/scripts"
releasesDir="releases"
plugins=""
plugins="$plugins FixTiledZoom.js"
plugins="$plugins SmartRenameView.js"



# for plugin in $plugins
# do
#     pluginName=$(basename $plugin .js)
#     zipFileName="${pluginName}-$(date "+%Y-%m-%d").zip"
#     echo zip -v "${releasesDir}/${pluginName}.zip" ${scriptsDir}/${pluginName}*
#     zip -v "${releasesDir}/${zipFileName}" ${scriptsDir}/${pluginName}*
#     echo "$plugin $pluginName"
#
# done

pluginName="TheAstroShedScripts"
zipFileName="${pluginName}-$(date "+%Y-%m-%d")-2.zip"
zip -v "${releasesDir}/${zipFileName}" ${scriptsDir}/*
sha1=$(sha1sum ${releasesDir}/${zipFileName} | awk '{print $1}')
echo $sha1
releaseDate=$(date +"%Y%m%d")
version=$(date +"%Y-%m-%d")

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
                    2024-06-21-1: Initial release fix
                </p>
            </description>
        </package>
    </platform>
</xri>
EOF

echo "Don't forget to sign the updates file!"