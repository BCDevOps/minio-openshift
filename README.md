# OpenShift Minio

This repo provides elements needed to build and run a minio instance in OpenShift.

Minio is an Amazon S3 compatible object storage server.  

Learn more here: https://minio.io/ 

## Technology Stack Used

Minio 
Red Hat Enterprise Linux

## Third-Party Products/Libraries used and the the License they are covered by

Minio, covered by Apache Licence Version 2.0.

## Project Status

Minio is an actively developed open source application sponsored by Minio, Inc. and has been used by multiple organizations on multiple platforms.   This artifacts in this repo have been tested and confirmed functional on the BC Gov OpenShift platform.

## Documentation

Documentation on how to use / interact with minio is available at https://docs.minio.io/.

The sections below describe how to deploy minio in OpenShift.

## Security

Minio/S3 clients access the Minio server using the Access and Secret Keys.

## Deployment (Local Development)

The environment variables below may be used to set/inject access credentials into the minio engine at runtime.

### MINIO_ACCESS_KEY 
Access key acting as a user ID that uniquely identifies the account.  

### MINIO_SECRET_KEY 
Secret key acting as the password to the account.  


```bash
docker build . -t minio-openshift
docker run minio-openshift -p 9000:9000 -e MINIO_ACCESS_KEY=<some ugly key> -e MINIO_SECRET_KEY=<some uglier key> 
```

## Deployment (OpenShift)

In general, users on the BC Gov OpenShift platform should use the image from the platform image repository and should *not* build their own image unless they have unique requirements.

The steps for deployment follow.

### Prerequisites

* a `minio` ImageStream should exist in the `openshift` namespace in your OpenShift cluster.
* the namespace where you plan to deploy minio should have `image-puller` permissions on the namespace where you are creating your "intermediate" minio image stream (generally your "-tools" namespace).

#### Create a "product-level" minio imagestream

In order to provide you with product-level (e.g. product / team) control over promotion of minio versions across your deployment environments, we recommend that you create an imagestream in your products's "-tools" environment, and ImageStreamTagS corresponding to each of your deployment envirionments.  An example of doing this is below:

```bash
oc project <your tools project>
oc tag --alias openshift/minio:stable minio:stable # cross-project aliases like this don't seem to work ATM, but maybe one day...in the meantime, you'll need to update/re-tag periodically   
oc tag --alias minio:stable minio:dev # use of --alias here is so dev will always be updated when stable is updated; omit --alias or use --reference if you prefer not to have this 
oc tag --reference minio:stable minio:test  # use of reference here is so you *have* to explicitly tag in order to affect test
oc tag --reference minio:stable minio:prod # use of reference here is so you *have* to explicitly tag in order to affect prod
```

*Note:* there are other ways to configure your image streams. The above is one possible strategy, but it gives you a good level of control so you know what version of your image is in what environment. 

#### Deploy using OpenShift deployment template

To deploy `minio` into a deployment project, use the template from this repo, substituting one of the tags you created above as the value for the `IMAGESTREAM_TAG` parameter:

```bash
oc process -f https://raw.githubusercontent.com/BCDevOps/minio-openshift/master/openshift/minio-deployment.json -p IMAGESTREAM_NAMESPACE=<your tools project> -p IMAGESTREAM_TAG=<dev|test|prod> | oc create -n <your deployment project> -f -
```

Additionally, you can use `oc new-app` to process a template stored in the catalogue:

```bash
oc -n <target-namespace> new-app --template=minio -p IMAGESTREAM_NAMESPACE=<your tools project> -p IMAGESTREAM_TAG=<dev|test|prod>
```

However, for simplicity, the `minio` image is available in the `bcgov` namespace:

```bash
oc process -f https://raw.githubusercontent.com/BCDevOps/minio-openshift/master/openshift/minio-deployment.json -p IMAGESTREAM_NAMESPACE=bcgov -p IMAGESTREAM_TAG=v1-latest | oc create -n <your deployment project> -f -
```

Alternatively, you may use the "Add to Project" feature in the OpenShift web console to achieve the same thing as above by entering values in a web form.  

## Building a minio image

*Note:* this is for advanced/special cases - most users of the BC Gov OpenShift platform should *not* be building their own image since one is provided in the platform image repository.

To configure a build for a minio image (typically in your -tools project), run the following:

```bash
cd openshift
oc process -f minio-bc.json | oc create -f -
``` 

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
