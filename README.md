# S3 Minio
This application is a forked version of Minio, an open source object storage server compatible with Amazon S3 APIs.

## Technology Stack Used
Minio

## Third-Party Products/Libraries used and the the License they are covered by
Minio, covered by Apache Licence Version 2.0.

## Project Status
Minio has been released, and used by multiple organizations on mutiple platforms.   This fork has been tested and runs on BC Gov OpenShift containers.

## Documentation

Special environment variables are used (note that environment variables are case sensitive)

### MINIO_ACCESS_KEY 
Access key acting as a user ID that uniquely identifies the account.  Set as part of deployment but then used in the deployed pod to connect to the internal (private) Minio Server.

### MINIO_SECRET_KEY 
Secret key acting as the password to the account.  Set as part of deployment but then used in the deployed pod to connect to the internal (private) Minio Server.

## Security

S3 clients will access the Minio server using the Access and Secret Keys.

## Files in this repository

The only file is a text document, containing all the commands a user could call on the command line to assemble the image.  This Dockerfile supports automated build that executes several command-line instructions in succession. 
```
Dockerfile           
```

## Deployment (Local Development)

No special local deployment instructions, other than setting the environment variables above.

## Deployment (OpenShift)

No special openshift deployment instructions.

## Getting Help or Reporting an Issue

To report bugs/issues/feature requests, please file an [issue](../../issues).

## How to Contribute

If you would like to contribute, please see our [CONTRIBUTING](./CONTRIBUTING.md) guidelines.

Please note that this project is released with a [Contributor Code of Conduct](./CODE_OF_CONDUCT.md). 
By participating in this project you agree to abide by its terms.

## License

    Copyright 2016 Province of British Columbia

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
