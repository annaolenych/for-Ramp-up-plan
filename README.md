Sure! Here's the README file in English, tailored to your provided files and setup:

---

# Setting Up a BIND DNS Server Using Docker on Ubuntu

This README provides instructions for setting up a BIND DNS server on Ubuntu using a Docker container.

## Prerequisites

- Docker: Installed on your computer.

## Setup Steps

### 1. Prepare Dockerfile

Create a Dockerfile to build an image with BIND 9:

```Dockerfile
# Use the latest official Ubuntu image
FROM ubuntu:latest

# Update package list and install BIND 9
RUN apt-get update && \
    apt-get install -y bind9 bind9utils bind9-doc

# Expose DNS ports
EXPOSE 53/udp 53/tcp

# Run BIND 9
CMD ["/usr/sbin/named", "-g", "-c", "/etc/bind/named.conf"]

# Copy configuration files to the container
COPY named.conf /etc/bind/named.conf
COPY named.conf.options /etc/bind/named.conf.options
COPY db.local /etc/bind/db.local
COPY db.127 /etc/bind/db.127
```

### 2. Configure `named.conf.options`

Create a `named.conf.options` file with the basic BIND settings:

```plaintext
options {
    directory "/var/cache/bind";

    dnssec-validation auto;

    recursion yes;

    listen-on-v6 { any; };

    // Uncomment the following block to use forwarders (optional)
    // forwarders {
    //     8.8.8.8;
    //     8.8.4.4;
    // };
};
```

### 3. Configure `named.conf`

Create a `named.conf` file with zone settings:

```plaintext
options {
    directory "/var/cache/bind";
    recursion yes;
    allow-query { any; };
    forwarders {
        8.8.8.8;
        8.8.4.4;
    };
};

zone "local" IN {
    type master;
    file "/etc/bind/db.local";
};

zone "0.0.127.in-addr.arpa" IN {
    type master;
    file "/etc/bind/db.127";
};
```

### 4. Configure `db.local`

Create a `db.local` file for the `local` zone:

```plaintext
$TTL    604800
@       IN      SOA     local. root.local. (
                    2         ; Serial
               604800         ; Refresh
                86400         ; Retry
              2419200         ; Expire
               604800 )       ; Negative Cache TTL
;
@       IN      NS      local.
@       IN      A       127.0.0.1
```

### 5. Configure `db.127`

Create a `db.127` file for the `0.0.127.in-addr.arpa` zone:

```plaintext
$TTL    604800
@       IN      SOA     local. root.local. (
                    2         ; Serial
               604800         ; Refresh
                86400         ; Retry
              2419200         ; Expire
               604800 )       ; Negative Cache TTL
;
@       IN      NS      local.
1.0.0   IN      PTR     localhost.
```

### 6. Build and Run the Container

Build and run the Docker container with the configured BIND:

```bash
# Build the image
docker build -t my-bind-server .

# Run the container
docker run -d --name bind-server -p 53:53/tcp -p 53:53/udp my-bind-server
```

### 7. Verify DNS Server Operation

After starting the container, verify that the DNS server is working correctly:

```bash
# Verify with dig
dig @127.0.0.1 local

# Verify with ping
ping local.
```

You should receive responses with the IP address `127.0.0.1` for the domain `local`.

---

This file provides detailed instructions for setting up a BIND DNS server using Docker on Ubuntu. It can be expanded to include additional features and configurations according to your needs.
