#!/bin/bash

BASE_URI="s3://${DATACOURSE_BUCKET-dataincubator-course}/datacourse/${DATACOURSE_VERSION-latest}"

# Remove trailing slash, if present
module=${1%/}

if [ -z "$module" ]; then
  echo "Usage: ./update_modules.sh [module_name]"
  echo "Or, for all modules: ./update_modules.sh all"
  exit 1
else
  if [ "$module" == "all" ]; then
    directories=$(ls -d */ | grep -v 'bak' | cut -d / -f 1)
    for directory in $directories; do
      # if directory doesnt exist, it's something the student put there
      if [ -z "$(aws s3 ls ${BASE_URI}/${directory})" ]; then
        continue
      else
        aws s3 cp --recursive ${BASE_URI}/${directory} $directory.new
      fi
    done
  else
    aws s3 cp --recursive ${BASE_URI}/$module $module.new
  fi
fi

echo "=========================="
if [ "$module" != "all" ]; then
  echo "Done. New content is in $module.new"
else
  echo "Done. New content is in the .new directory for each module."
fi
echo "=========================="
