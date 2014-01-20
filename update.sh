#!/bin/sh

cd /etc/puppet
git pull 
librarian-puppet install
puppet apply --verbose /etc/puppet/manifests/config.pp
cd - >/dev/null
