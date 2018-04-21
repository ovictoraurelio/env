# Ubuntu enviromnent configure

A shell script to config environment on Ubuntu 16.04

To execute latest version of this script, you just need execute the command below:

```shell
  bash <( curl -L bit.ly/envubuntu)
```

To install just one application like Telegram

```shell
  bash <( curl -L bit.ly/envubuntu) telegram
```

Thinking about overhead space caused on Computers of CIn because there's a lot of scripts like this installing things in Users Spaces.

I'm concerned this is a problem, I have changed this code to  install applications in the /tmp folder by default because this folder is deleted every startup.

If you want to install applications in your home folder, You just need use the parameter home after call script.

```shell
  bash <( curl -L bit.ly/envubuntu) home
```
To install just one application like Telegram in your home folder

```shell
  bash <( curl -L bit.ly/envubuntu) home telegram
```

## Contributing

Pull requests and stars are always welcome. For bugs and feature requests, [please create an issue](https://github.com/ovictoraurelio/env/issues)

## Authors

[Victor Aurélio]

[Victor Aurélio]: <http://victoraurelio.com>




