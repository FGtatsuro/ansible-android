ansible-android
====================================

[![Build Status](https://travis-ci.org/FGtatsuro/ansible-android.svg?branch=master)](https://travis-ci.org/FGtatsuro/ansible-android)

Ansible role for Android related components.(ex. SDK, Emulator and so on)

Requirements
------------

The dependencies on other softwares/librarys for this role.

- Debian
- Alpine Linux
- OSX
  - Homebrew (>= 0.9.5)

Role Variables
--------------

The variables we can use in this role.

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
