# Docker NGINX with Modules

This project provides a set of scripts that simplify the process of creating a Docker image of NGINX with desired modules.

This project uses Dockerfiles provided by NGINX maintainers to easily generate NGINX images with modules. It supports both Debian and Alpine base images, as well as both regular NGINX and Unprivileged images.

## Usage

To use the script, you need to provide three parameters, either as environment variables or in a .env file:

1. `MODULES_TO_ADD_LIST`: A list of modules you want to include, separated by spaces. These modules should be available on pkg-oss.
2. `BASE_NGINX_IMAGE`: The NGINX base image to which you want to add the modules. Defaults to the mainline image.
3. `IMAGE_NAME_GENERATED`: The name of the generated image.

Here's an example command:

```bash
./nginx-alpine.sh
```

## More information

- The GitHub project for the NGINX Docker image : https://github.com/nginxinc/docker-nginx
    - The modules part : https://github.com/nginxinc/docker-nginx/tree/master/modules

- I have written an article about how to create a Docker Image with modules (in French 🇫🇷) : https://bastienbyra.fr/blog/comment-modifier-ou-retirer-le-header-server-de-nginx/