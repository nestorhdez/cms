#!/bin/sh
set -e

if [[ ! -z "${GITHUB_TOKEN}" ]]; then
  echo "Github token exists!"  
elif [[ ! -z "${INPUT_GITHUB_TOKEN}" ]]; then
  echo "Input github token exists!"
else
  echo 'Missing input "github_token: ${{ secrets.GITHUB_TOKEN }}".';
  exit 1;
fi

echo "User name:"
echo $(git config user.name)
