Roles in Ansible
In Ansible, a role is a way of organizing and reusing automation tasks into separate units of functionality. 
Roles allow you to group tasks, variables, files, templates, and handlers in a structured manner, making it easier to manage complex automation.

Using the Role in a Playbook::

---
- hosts: webservers
  become: yes
  roles:
    - apache

---
- hosts: dbservers
  become: yes
  roles:
    - mysql


Using a Role from Ansible Galaxy: Ansible Galaxy is a community hub where you can find roles developed by others. For example, let's say you want to install Nginx using an existing role from Ansible Galaxy.

ansible-galaxy install geerlingguy.nginx

---
- hosts: webservers
  become: yes
  roles:
    - geerlingguy.nginx

