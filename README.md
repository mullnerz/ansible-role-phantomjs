ansible-role-phantomjs
=========

This role installs the latest version of the PhantomJS package from GitHub.

Requirements
------------

No special requirements, but note that this role requires root access, so either run it in a playbook with a global `become: yes`, or invoke the role in your playbook like:

    - hosts: servers
      roles:
        - role: ansible-role-phantomjs
          become: yes

Role Variables
--------------

Available variables are listed below, along with default values (see `defaults/main.yml`):

    phantomjs_version: 1.9.8

Dependencies
------------

None.

Example Playbook
----------------

Install default version:

    - hosts: servers
      become: yes
      roles:
        - ansible-role-phantomjs

Install specific version:

    - hosts: servers
      become: yes
      roles:
        - role: ansible-role-phantomjs
          phantomjs_version: 2.1.1

License
-------

BSD

Author Information
------------------

This role was created in 2016 by [Zoltán Müllner](http://zoltan.mullner.hu/).
