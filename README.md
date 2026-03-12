# PHP 8.4-FPM Docker Image for WordPress

This Dockerfile sets up a production-ready PHP 8.4-FPM environment optimized for WordPress, with various PHP extensions and tools including Imagick, Memcached, and WP-CLI. It also configures Mailhog for email testing and includes performance optimizations and security best practices.

## Features

- **PHP 8.4-FPM**: Latest stable PHP version with FPM (FastCGI Process Manager)

- **PHP Extensions**:
  - `bcmath` - Arbitrary precision mathematics
  - `exif` - EXIF metadata from images
  - `gd` - Image processing with freetype, jpeg, **WebP**, and **AVIF** support
  - `imagick` - ImageMagick integration via PECL
  - `mysqli` & `pdo_mysql` - MySQL database connectivity
  - `memcached` - Memcached caching support via PECL
  - `opcache` - PHP opcode caching for performance
  - `soap` - SOAP protocol support
  - `zip` - ZIP archive handling

- **Modern Image Format Support**:
  - WebP - Next-generation image format
  - AVIF - Advanced image compression format
  - Perfect for WordPress media optimization

- **Installed Tools**:
  - `WP-CLI` - WordPress command line interface
  - `ghostscript` - PDF and PostScript processing
  - `imagemagick` - Advanced image manipulation
  - `mariadb-client` - Database client
  - `git` - Version control
  - `unzip` - Archive extraction
  
- **Email Testing**: 
  - `Mailhog` integration for development email testing

- **Performance Optimizations**:
  - **Opcache**: 256MB memory, 10,000 cached files, optimized for production
  - **PHP Settings**: 256M memory limit, 64M max upload size, 300s execution time
  
- **Security**:
  - Non-root user (`web`) for container execution
  - Error logging to stderr (no sensitive data exposure)
  - Display errors disabled in production mode

## Installation

To build the Docker image, run the following command:

```bash
docker push jumpgroupit/wordpress-image:tagname
````

## Usage

### Building the Image

To build the Docker image locally:

```bash
docker build -t jumpgroupit/wordpress-image:8.4-fpm .
```

### Pushing to Registry

To push the image to Docker Hub:

```bash
docker push jumpgroupit/wordpress-image:8.4-fpm
```

### Using in docker-compose.yml

```yaml
services:
  php:
    image: jumpgroupit/wordpress-image:8.4-fpm
    volumes:
      - ./wordpress:/var/www/html
    networks:
      - wordpress
```

## Configuration

### PHP Settings

The following PHP configuration files are included:

- **opcache-recommended.ini**: Opcache optimization for WordPress
- **error-logging.ini**: Error reporting and logging configuration
- **wordpress.ini**: WordPress-specific PHP settings (memory, upload limits, timeouts)
- **mailhog.ini**: Email forwarding to Mailhog for development

### WP-CLI

WP-CLI is pre-installed and accessible as user `web`:

```bash
docker exec -it <container_name> wp --info
```

## Version History

- **8.4-fpm**: PHP 8.4 with WebP/AVIF support, optimized opcache, and enhanced WordPress configuration
- **8.3-fpm**: Previous version with PHP 8.3
- **8.2-fpm**: PHP 8.2

## Requirements

- Docker Engine 20.10+
- Docker Compose 2.0+ (if using docker-compose)
