# Database S3 Backups

This script provides a simple, automated way to back up your databases to AWS S3. It supports multiple database types and can be easily configured to run on a schedule.

[![Deploy on Railway](https://railway.app/button.svg)](https://railway.app/template/U_wjYd?referralCode=lukeliasi)

Supported databases:
- `postgres`
- `mysql`
- `mongodb`

## Features

- Define multiple databases of different types in your configuration
- Automatic backup process for all databases in one execution
- Backups can be initiated on script execution or scheduled using a cron job
- Backups are compressed to reduce file size

## Installation

1. Clone this repository
2. Install dependencies: `npm install`
3. Set up your `.env` file (see Configuration section)
4. Run the script: `npm run start`

## Usage

Standalone:

```bash
npm run start
```

or with Docker:

```bash
docker compose up --build
```

## How it Works

1. Define database connection URI strings and backup schedule
2. The script connects to the database(s) and performs a dump
3. The dump is compressed and uploaded to your AWS S3 Bucket
4. Dumps are cleaned up on the local file system

## Configuration

Create a `.env` file in the root directory with the following variables:

```
RUN_ON_STARTUP=true
CRON=0 0 * * *
AWS_ACCESS_KEY_ID=<ACCESS_KEY_ID>
AWS_SECRET_ACCESS_KEY=<SECRET_ACCESS_KEY>
AWS_S3_BUCKET=<S3_BUCKET>
AWS_S3_REGION=<S3_REGION>
AWS_S3_ENDPOINT=<S3_ENDPOINT>
DATABASES="mysql://user:password@host:port/database,postgresql://user:password@host:port/database,mongodb://user:password@host:port"
```

### Environment Variables

| Key                     | Description              | Optional | Default Value |
|-------------------------|--------------------------|----------|---------------|
| `DATABASES`             | Comma-separated connection strings list of database URIs that should be backed up. | No | `[]`|
| `RUN_ON_STARTUP`        | Boolean value that indicates if the script should run immediately on startup. | Yes | `false` |
| `CRON`                  | Cron expression for scheduling when the backup job will run for all databases. See [Crontab.guru](https://crontab.guru/) for help setting up schedules. | Yes | |
| `AWS_ACCESS_KEY_ID`     | [AWS access key ID](https://docs.aws.amazon.com/general/latest/gr/aws-sec-cred-types.html#access-keys-and-secret-access-keys). | No | |
| `AWS_SECRET_ACCESS_KEY` | [AWS secret access key](https://docs.aws.amazon.com/general/latest/gr/aws-sec-cred-types.html#access-keys-and-secret-access-keys). | No | |
| `AWS_S3_BUCKET`         | [Name of the S3 bucket](https://docs.aws.amazon.com/AmazonS3/latest/dev/Welcome.html). | No | |
| `AWS_S3_REGION`         | [Region of the S3 bucket](https://docs.aws.amazon.com/general/latest/gr/rande.html). | No | |
| `AWS_S3_ENDPOINT`       | [Endpoint for the S3 service](https://docs.aws.amazon.com/general/latest/gr/s3.html). | No | |

## FAQ

### Q: How do I backup local databases on the same server the script is running on?
A: If you're trying to backup databases that are running locally on the same server as this backup script, you may need to set the network mode to "host" in your Docker configuration. This allows the container to access the host's network stack directly. You can do this by adding `--network host` when running your Docker container, or by setting `network_mode: host` in your docker-compose.yml file.

Note: Using host network mode can have security implications, so only use it if necessary and understand the risks involved.

### Q: Why am I getting a "connection refused" error when trying to connect to my database?
A: This error can occur due to various reasons, including incorrect connection details, network issues, firewalls, VPN configurations, or database server status. Double-check your connection string, ensure network accessibility, verify firewall settings, and confirm the database server is running and accepting connections from your container's environment.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.