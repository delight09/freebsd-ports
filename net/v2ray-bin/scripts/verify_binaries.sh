#!/bin/sh
# Verify the binary against .sig files

pwd >/tmp/myout2
verify_signature_target() {
    gpg --verify "$1".sig "$1"
}


# Init keyring
fetch -o - \
  https://raw.githubusercontent.com/v2ray/v2ray-core/master/release/verify/official_release.asc \
  | gpg --import

verify_signature_target "v2ctl"
verify_signature_target "v2ray"
