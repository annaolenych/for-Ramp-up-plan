
# 1. Nginx Monitor Script

This script is a simple curl-based monitor to check the status of an Nginx proxy running in an Ubuntu container. It logs the status of the Nginx server to a log file and can be scheduled to run at regular intervals using cron.

## Prerequisites

- Docker
- curl
- bash

## Getting Started

### 1. Run Nginx in an Ubuntu Container

First, ensure you have Docker installed and running. Then, create and start an Nginx container:

```bash
docker run -d --name nginx-container -p 80:80 nginx
```

### 2. Create the Monitor Script

Create a script named `nginx_monitor.sh` .

### 3. Make the Script Executable

Change the permissions of the script to make it executable:

```bash
chmod +x ~/nginx_monitor.sh
```

### 4. Run the Script

You can manually run the script to check if it works:

```bash
./nginx_monitor.sh
```

Check the log file to see the output:

```bash
cat ~/nginx_monitor.log
```

<img width="448" alt="Screenshot 2024-07-09 at 15 39 14" src="https://github.com/annaolenych/for-Ramp-up-plan/assets/95705808/3452970c-c9e4-4d7b-a6d3-c5db5fa1b106">

### 5. Automate the Script with Cron

To automate the script to run every 5 minutes, edit the cron jobs:

```bash
crontab -e
```

Add the following line to schedule the script:

```bash
*/5 * * * * /path/to/nginx_monitor.sh
```

Replace `/path/to/nginx_monitor.sh` with the actual path to your script.

### 6. Verify the Cron Job

After a few minutes, check the log file again to ensure that the script is running as expected:

```bash
cat ~/nginx_monitor.log
```





# 2. Timezone Conversion Script

This script converts a given date and time from one timezone to another. It takes the date and time, the original timezone, and the target timezone as inputs and outputs the converted date and time.

## Usage

```bash
./timezone_conversion.sh -d 'date and time' -f from_timezone -t to_timezone
```

### Example

```bash
./timezone_conversion.sh -d '2024-07-09 14:00:00' -f UTC -t America/New_York
```

## Script Explanation

The script accepts three arguments:
- `-d` for the date and time to be converted.
- `-f` for the original timezone.
- `-t` for the target timezone.

If any of these arguments are missing, the script will display usage instructions and exit.

## Requirements

Ensure you have `date` command available on your system. This script is compatible with Unix-like operating systems such as macOS and Linux.

## Example Output

When you run the script with the example provided, it will output:

```
Original datetime: 2024-07-09 14:00:00 UTC
Converted datetime: 2024-07-09 10:00:00 America/New_York
```

## Script Code

Here is the complete script code - `time.sh`

## How to Run

1. Save the script to a file, for example, `timezone_conversion.sh`.
2. Make the script executable:
   ```bash
   chmod +x timezone_conversion.sh
   ```
3. Run the script with the desired date, time, and timezones:
   ```bash
   ./timezone_conversion.sh -d '2024-07-09 14:00:00' -f UTC -t America/New_York
   ```
Result:
<img width="689" alt="Screenshot 2024-07-09 at 12 49 00" src="https://github.com/annaolenych/for-Ramp-up-plan/assets/95705808/4c8ea422-fd37-4487-a3a3-2114baf5f146">
