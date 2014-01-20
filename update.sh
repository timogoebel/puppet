#!/bin/sh

cd /etc/puppet
git pull 
puppet apply --verbose /etc/puppet/manifests/config.pp
cd - >/dev/null
