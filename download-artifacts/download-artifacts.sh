#!/bin/bash

# Variables
ARTIFACTORY_URL="https://global-artifacts.se.com/artifactory"
REPO_KEY="em-dgedge-generic-dev-virtual/3pp-gme"
ARTIFACTS_FILE="artifacts.txt"
DOWNLOAD_DIR="3pp-gme"

mkdir "$DOWNLOAD_DIR"

# Request the Artifactory user
read -p "Input the Artifactory user: " USERNAME

# Request the API to the user
read -s -p "Input the API key for the Artifactory user: " API_KEY
echo

# Read the text file with the artifact list
while IFS= read -r artifact_name
do
    # Download the artifacts
    curl -u "$USERNAME:$API_KEY" -k -L -o "$DOWNLOAD_DIR/$artifact_name" "$ARTIFACTORY_URL/$REPO_KEY/$artifact_name"
done < "$ARTIFACTS_FILE"
