#Copyright © 2020, Oracle and/or its affiliates.

#The Universal Permissive License (UPL), Version 1.0


#/bin/bash

zipfile="hyperion.zip"

if [ -f $zipfile ]; then
    rm -f $zipfile
fi
zip -r  $zipfile . -x  pack.sh .gitignore  terraform*  .terraform\* _docs\* orm\* .git\* .idea\* env-vars hyperion.zip *.zip README.md
