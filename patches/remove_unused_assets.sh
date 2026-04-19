#!/bin/bash
#
# Removes a handful of unused assets from our submodules,
# since Flutter doesn't offer that flexibility in pubspec.yaml.

truncate -s 0 submodules/Delta-Icons/app/src/main/res/drawable-nodpi/ic_*
