#!/usr/bin/env bash

if [ "$DEV_MODE" = "dev" ];
then
    npm run dev
else
    npm run build
    npm run start
fi