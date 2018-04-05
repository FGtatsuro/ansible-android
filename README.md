ansible-android
====================================

[![Build Status](https://travis-ci.org/FGtatsuro/ansible-android.svg?branch=master)](https://travis-ci.org/FGtatsuro/ansible-android)

Ansible role for Android related components.(ex. SDK, Emulator and so on)

Requirements
------------

The dependencies on other softwares/librarys for this role.

- Debian
- OSX
  - Homebrew (>= 0.9.5)

Role Variables
--------------

The variables we can use in this role.

|name|description|type|default|
|---|---|---|---|
|android_home|Home directory of Android.<br>You should also set this value as environment `ANDROID_HOME`.|str|/opt/android|
|android_sdk_download_url|Download URL of Android SDK archive.<br>Different version has different URL.|str|https://dl.google.com/android/repository/sdk-tools-linux-3859397.zip|
|android_sdk_sha256|SHA1 signature of Android SDK archive.<br>This is used for idempotency.|str|444e22ce8ca0f67353bda4b85175ed3731cae3ffa695ca18119cbacef1c1bea0|
|android_sdk_download_tmppath|Path downloaded Android SDK archive is put temporary.|str|/tmp/android_sdk.tgz|
|android_sdk_timeout|If the time of Android SDK/related components installation exceeds this value,<br>correspond tasks are failed.|int|120|
|android_extra_components_lockpath|Path of file created after extra components are installed.<br>Playbook skips correspond tasks if this file exists.|str|/tmp/ansible_android_extra_components.lock|
|android_extra_components|Extra components installed by this role.<br>This role installs `platform-tools` and components of this value.|list|Empty list. No extra component is installed.|
|android_license_src_dir|Directory including license files for Android components. These are needed to install `android_extra_components` automatically.|str|It isn't defined in default.|
|android_emulator_kvm_user|If this value is defined, setup for Android emulator with KVM is executed. <br>- `/dev/kvm` is created by `mknod` command. <br>- The user of this variable is appended to group `kvm`. And the members of this group can read/write `/dev/kvm`.|str|It isn't defined in default.|

- The value of `android_license_src_dir` is used as 'src' attribute of Ansible copy module. Thus, whether this value ends with '/' affects the behavior. (Ref. http://docs.ansible.com/ansible/copy_module.html)

Role Dependencies
-----------------

The dependencies on other roles for this role.

- FGtatsuro.python-requirements
- FGtatsuro.java

Example Playbook
----------------

    - hosts: all
      roles:
         - { role: FGtatsuro.android }

Test on local Docker host
-------------------------

This project run tests on Travis CI, but we can also run them on local Docker host.
Please check `install`, `before_script`, and `script` sections of `.travis.yml`.
We can use same steps of them for local Docker host.

Local requirements are as follows.

- Ansible (>= 2.2.x)
- Docker (>= 1.10.1)

Notes
-----

- On OSX, role variable `android_sdk_download_url` is ignored. This means that this role DOESN'T install specified version on OSX.
  - Latest SDK is installed when no SDK is installed.
  - If SDK is already installed before this role, this role DOESN'T overwrite it.

- On OSX, role variable `android_home` must be overwritten by path Homebrew installs Android SDK.
  - In default, `/usr/local/share/android-sdk` will be used.

- On Debian, SDK and related tools are re-installed when new Android SDK is given via `android_sdk_download_url` and `android_sdk_sha256`.
  - In this case, previous installed components in `android_home` are REMOVED. You should be careful!
  - This role DOES NOT support old version of SDK not including `sdkmanager` command. 

- About `android_emulator_kvm_user`,
  - On OSX, this is ignored.
  - If this variable is used for Docker, `MKNOD` capability is required. (Ref. https://docs.docker.com/engine/reference/run/#/runtime-privilege-and-linux-capabilities)

License
-------

MIT
