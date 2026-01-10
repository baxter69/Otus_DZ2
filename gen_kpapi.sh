#!/bin/sh

#  gen_wizardapi.sh
#  otus_hw2
#
#  Created by Владимир on 22.12.2025.
#
MODULE="otus_hw2/KinopoiskAPI/Sources/KinopoiskAPI"

openapi-generator generate -i "kpapi.yaml" -g swift6 -o "api_kinopoiskapi"
rm -r $MODULE""*
cp -R "api_kinopoiskapi/Sources/OpenAPIClient/". $MODULE
rm -r "api_kinopoiskapi"
 
