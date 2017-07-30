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
|android_sdk_download_url|Download URL of Android SDK archive.<br>Different version has different URL.|str|http://dl.google.com/android/android-sdk_r24.4.1-linux.tgz|
|android_sdk_sha1|SHA1 signature of Android SDK archive.<br>This is used for idempotency.|str|725bb360f0f7d04eaccff5a2d57abdd49061326d|
|android_sdk_download_tmppath|Path downloaded Android SDK archive is put temporary.|str|/tmp/android_sdk.tgz|
|android_sdk_timeout|If the time of Android SDK/related components installation exceeds this value,<br>correspond tasks are failed.|int|120|
|android_extra_components_lockpath|Path of file created after extra components are installed.<br>Playbook skips correspond tasks if this file exists.|str|/tmp/ansible_android_extra_components.lock|
|android_extra_components|Extra components installed by this role.<br>This role installs `platform-tools` and components of this value.|list|Empty list. No extra component is installed.|
|android_extra_components_pip_executable|Specified path of pip to install python libraries which are needed to install `android_extra_components` automatically. <br> If it is null, pip which Ansible finds automatically is used.|str|null|
|android_emulator_kvm_user|If this value is defined, setup for Android emulator with KVM is executed. <br>- `/dev/kvm` is created by `mknod` command. <br>- The user of this variable is appended to group `kvm`. And the members of this group can read/write `/dev/kvm`.|str|It isn't defined in default.|

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

- On Debian, SDK and related tools are re-installed when new Android SDK is given via `android_sdk_download_url` and `android_sdk_sha1`.
  - In this case, previous installed components in `android_home` are REMOVED. You should be careful!

- About `android_emulator_kvm_user`,
  - On OSX, this is ignored.
  - If this variable is used for Docker, `MKNOD` capability is required. (Ref. https://docs.docker.com/engine/reference/run/#/runtime-privilege-and-linux-capabilities)

License
-------

MIT
