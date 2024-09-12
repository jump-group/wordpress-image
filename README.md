# PHP 8.1-FPM Docker Image with Additional Extensions and Tools

This Dockerfile sets up a PHP 8.1-FPM environment with various PHP extensions and tools, such as Imagick, Memcached, and WP-CLI. It also configures Mailhog for email testing and includes some optimizations for performance and error logging.

## Features

- **PHP Extensions**:
  - `bcmath`
  - `exif`
  - `gd` (with freetype and jpeg support)
  - `mysqli`
  - `soap`
  - `zip`

- **Installed Libraries and Tools**:
  - `ghostscript`
  - `imagemagick` (with the `imagick` PHP extension)
  - `memcached` (with the `memcached` PHP extension)
  - `mariadb-client` (for database connectivity)
  - `WP-CLI` (WordPress command line interface)
  - `Mailhog` integration for email testing
  
- **PHP Opcache**: Optimized settings for better performance.
  
- **Non-root User**: The container runs with a non-root user (`web`) for security reasons.

## Installation

To build the Docker image, run the following command:

```bash
docker push jumpgroupit/wordpress-image:tagname
