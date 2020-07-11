#!/bin/sh
set -e

echo Pushing action changes

if [[ -z "${INPUT_GITHUB_TOKEN}" ]]; then
  echo 'Missing input "github_token: ${{ secrets.GITHUB_TOKEN }}".';
  exit 1;
fi

remote_repo="https://${GITHUB_ACTOR}:${INPUT_GITHUB_TOKEN}@github.com/${GITHUB_REPOSITORY}.git"

git push "${remote_repo}" HEAD:master;

echo Pushed 🚀!