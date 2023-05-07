# wordpress-chef
Deploy Wordpress Using Vagrant and Chef

To Run use
```
vagrant up
```
this vagrant file recognizes the OS and depending on it uses virtual box or Parallels.

For Parallels we are using an image of type ARM.

At the beginning of the display you can see an image like the following one.

```
==> wordpress:  _________________________________             
==> wordpress: / Provisioning Wordpress By Jairo \       
==> wordpress: \ Martinez                        /           
==> wordpress:  ---------------------------------            
==> wordpress:         \   ^__^      
==> wordpress:          \  (oo)\_______
==> wordpress:             (__)\       )\/\
==> wordpress:                 ||----w |
==> wordpress:                 ||     ||
```

And in the end, if everything went well, you will be able to see something like this.

```
==> wordpress:  ____________
==> wordpress: < Its Done ! >
==> wordpress:  ------------
==> wordpress:               \   ^__^
==> wordpress:                \  (oo)\_______
==> wordpress:                   (__)\       )\/\
==> wordpress:                       ||----w |
==> wordpress:                       ||     ||
```

Sometimes you can see well formed shapes and sometimes you can't, the formatting is lost.

I don't know what it depends on 😅.

For this exercise I used a mysql cookbook as a module from https://supermarket.chef.io/cookbooks/mysql 

For check it :

http://192.168.33.10:80/

or

http://localhost:80/