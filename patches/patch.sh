#!/bin/sh

pushd /magnum && patch < /patches/project_name.patch; popd
exit 0
