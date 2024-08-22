
# MariaDB Replication Setup

## Before You Begin
1. Update security rules:
   - `MASTER-MARIADB = CUSTOM TCP - 3306 IP (PRIVATE IP OF SLAVE-MARIADB/32)`
   - `SLAVE-MARIADB = CUSTOM TCP - 3306 IP (PRIVATE IP OF MASTER-MARIADB/32)`

## Step 0: Preparation
Before starting with Step 0, complete Step 1 first. After that, test the connectivity:

- From the master instance: `telnet <slave_private_ip> 3306`
- From the slave instance: `telnet <master_private_ip> 3306`

If the connection fails, continue with the following steps.

On each instance, open the MariaDB configuration file:
```bash
sudo vi /etc/mysql/mariadb.conf.d/50-server.cnf
```

Find the `[mysqld]` section and modify the `bind-address` setting to:
```ini
bind-address = 0.0.0.0
```
After this, restart MariaDB on both instances:
```bash
sudo systemctl restart mariadb
```
If the problem persists, you may also need to run:
```bash
sudo ufw allow 3306/tcp
```

## Step 1: Install and Start MariaDB on All Hosts

1. Update the package manager and install MariaDB server:
    ```bash
    sudo apt update
    sudo apt install mariadb-server -y
    ```

2. Start MariaDB and enable it to start automatically:
    ```bash
    sudo systemctl start mariadb
    sudo systemctl enable mariadb
    ```

## Step 2: Configure the Primary (Master) Instance

1. Open the MariaDB configuration file:
    ```bash
    sudo vi /etc/mysql/mariadb.conf.d/50-server.cnf
    ```

2. Add or update the following parameters in the `[mysqld]` section:
    ```ini
    [mysqld]
    log-bin=mysql-bin
    server-id=101
    ```

3. Restart MariaDB:
    ```bash
    sudo systemctl restart mariadb
    ```

4. Log in to MariaDB and create a replication user:
    ```bash
    sudo mysql -u root -p
    ```

5. Run the following SQL commands:
    ```sql
    GRANT REPLICATION SLAVE ON *.* TO 'repl_user'@'%' IDENTIFIED BY 'password';
    FLUSH PRIVILEGES;
    EXIT;
    ```

## Step 3: Configure the Replica (Slave) Instance

1. Open the MariaDB configuration file:
    ```bash
    sudo vi /etc/mysql/mariadb.conf.d/50-server.cnf
    ```

2. Add or update the following parameters in the `[mysqld]` section:
    ```ini
    [mysqld]
    log-bin=mysql-bin
    server-id=102
    read_only=1
    report-host=node01.srv.world
    ```

3. Restart MariaDB:
    ```bash
    sudo systemctl restart mariadb
    ```

4. Set up replication so that the Replica (Slave) can connect to the Primary (Master). Log in to MariaDB on the Replica instance:
    ```bash
    sudo mysql -u root -p
    ```

5. Run the following SQL commands:
    ```sql
    CHANGE MASTER TO 
    MASTER_HOST='10.0.0.31',  -- Replace with the Private IP of the Primary instance
    MASTER_USER='repl_user',
    MASTER_PASSWORD='password',
    MASTER_LOG_FILE='mysql-bin.000001',  -- Replace with the log file name from SHOW MASTER STATUS on the Primary instance
    MASTER_LOG_POS=<position>;  -- Replace with the log position from SHOW MASTER STATUS on the Primary instance

    START SLAVE;
    SHOW SLAVE STATUS\G;
    ```

6. Check the replication status to ensure everything is working correctly:
    ```sql
    SHOW SLAVE STATUS\G;
    ```
<img width="974" alt="Screenshot 2024-08-14 at 00 29 59" src="https://github.com/user-attachments/assets/90c139d4-00b7-4d5c-8fbf-ca1e8d31e521">
<img width="974" alt="Screenshot 2024-08-14 at 00 29 59" src="https://github.com/user-attachments/assets/9bd8f20a-ae97-463a-b515-0645e5fc203f">

7. result(test data):
<img width="688" alt="Screenshot 2024-08-14 at 00 30 47" src="https://github.com/user-attachments/assets/6cfffb89-8f01-43a5-9a39-91e926173d35">
<img width="974" alt="Screenshot 2024-08-14 at 00 29 59" src="https://github.com/user-attachments/assets/1af66583-848a-41fe-904a-31b4c95e90b4">
