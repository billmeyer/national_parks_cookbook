# national_parks_cookbook

## Purpose
This cookbook is intended to be a demonstration of using Chef cookbooks to install a full-blown Java application (see below). A [Test Kitchen](http://kitchen.ci/) file is included in the cookbook that can be used to spin up __VirtualBox__ VM on the local desktop using __Vagrant__.  Test Kitchen will then configure the VM to download and install the sample application, JDK 8, Tomcat 8.5, MongoDB in the VM and run it.

## The Application

The National Parks [1] application is a JavaEE web application that runs on Tomcat 8.5 and uses MongoDB as its backend data store.  Its purpose is to render a map of the United States and place markers on all the National Park locations in the US.

[1] https://github.com/billmeyer/national-parks

## Software Required

Chef DK - [https://downloads.chef.io/chefdk]()
Vagrant - [https://www.vagrantup.com/downloads.html]()
Virtual Box - [https://www.virtualbox.org/wiki/Downloads]()
Git - [Windows](https://git-scm.com/download/win), [Linux](https://git-scm.com/download/linux), [Mac](https://git-scm.com/download/mac)

## Getting Started

1. Be sure to install the required software specified above.

2. Clone the Git repository to your local desktop:

        cd $HOME
        git clone https://github.com/billmeyer/national-parks.git

3. Change directory to the root of the cookbook:

        cd national_parks_cookbook

4.  The supplied __Test Kitchen__ configuration (in `.kitchen.yml`) contains support for creating either an Centos 7 or Ubuntu 16 VM.  You can verify this by executing the following:

        kitchen list
        Instance             Driver   Provisioner  Verifier  Transport  Last Action    Last Error
        default-ubuntu-1604  Vagrant  ChefZero     Inspec    Ssh        <Not Created>  <None>
        default-centos-73    Vagrant  ChefZero     Inspec    Ssh        <Not Created>  <None>        

5. Use __Test Kitchen__ to create the new VM on either Centos or Ubuntu:

        kitchen create centos

    --or--

        kitchen create ubuntu

6.  Once the new VM is created, the cookbook can be deployed into the new by executing:

        kitchen converge centos

    --or--

        kitchen converge ubuntu

7. After a few minutes, the cookbook will be applied and can be unit tested with __Test Kitchen__ by executing:

        kitchen verify

    This will apply all of the InSpec unit tests located in `national_parks_cookbook/test/smoke/default` to the running VM and confirm the application checks out correctly.

8. Connect to the App!  Using your favorite web browser, browse to [https://192.168.33.33/]() and you should see the National Parks application running on your desktop!