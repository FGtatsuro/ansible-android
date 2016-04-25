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

NOTE: All variables are valid on only Linux. On OSX, they aren't used.

|name|description|type|default|
|---|---|---|---|
|android_home|Home directory of Android.<br>You should also set this value as environment `ANDROID_HOME`.|str|/opt/android|
|android_sdk_download_url|Download URL of Android SDK archive.<br>Different version has different URL.|str|http://dl.google.com/android/android-sdk_r24.4.1-linux.tgz|
|android_sdk_sha1|SHA1 signature of Android SDK archive.<br>This is used for idempotency.|str|725bb360f0f7d04eaccff5a2d57abdd49061326d|
|android_sdk_download_tmppath|Path downloaded Android SDK archive is put temporary.|str|/tmp/android_sdk.tgz|
|android_sdk_update_timeout|If the time of SDK components installation(with `android update sdk`) exceeds this value,<br>correspond tasks are failed.|int|120|
|android_extra_components_lockpath|Path of file created after extra components are installed.<br>Playbook skips correspond tasks if this file exists.|str|/tmp/ansible_android_extra_components.lock|
|android_extra_components|Extra components installed by this role.<br>This role installs `platform-tools` and components of this value.|list|It isn't defined in default. No extra component is installed.|

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

- Ansible (>= 2.0.0)
- Docker (>= 1.10.1)

Notes
-----

- On OSX, role variable `android_sdk_download_url` is ignored. This means that this role DOESN'T install specified version on OSX.
  - Latest SDK is installed when no SDK is installed.
  - If SDK is already installed before this role, this role DOESN'T overwrite it.

License
-------

MIT
