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

if [[ ! -z "${SOME_OTHER}" ]]; then
  echo "Some other exists!"  
elif [[ ! -z "${INPUT_SOME_OTHER}" ]]; then
  echo "Input some other exists!"
else
  echo 'Missing input "some_other".';
  exit 1;
fi
