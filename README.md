
# Database S3 backups
This script provides a simple all-in-one automated way to back up your databases to AWS S3.

[![Deploy on Railway](https://railway.app/button.svg)](https://railway.app/template/U_wjYd?referralCode=lukeliasi)

Supported databases:
- `postgres`
- `mysql`
- `mongodb`

## Features
- Define multiple databases of different types in your configuration, and the script will automatically handle the backup process for all of them in one execution.
- Backups can be initiated either upon the script execution or on a scheduled basis using a cron job. 
- Backups are compressed to reduce file size.

## How it works 
1. Define database connection URI strings for each database you want backed up and the backup schedule 
2. The script will connect to the database(s) and do a dump
3. The dump is compressed and uploaded to your defined AWS S3 Bucket
4. Finally, the dumps are cleaned up on the local file system


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

### Environment variables

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
