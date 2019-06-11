#!/usr/bin/env bash

# If running on travis and processing a tag, work with curlbuildimages.
# If running on travis and processing anything else, work with
# curlbuildimagestemp.
# If running locally, work with the curlbuildimagestemp namespace.
if [[ -n "${TRAVIS:-}" ]]
then
  # Log into Docker.
  echo "${DOCKER_PASS}" | docker login -u "${DOCKER_USER}" --password-stdin

  if [[ -n "${TRAVIS_TAG:-}" ]]
  then
    # Processing a tagged build. Get the version from the version file.
    export VERSION=$(cat VERSION)

    # Use the main repository.
    export DOCKER_REPO=curlbuildimages
  else
    # Processing an untagged build. The version is the build ID, which is
    # shared between stages.
    export VERSION=${TRAVIS_BUILD_ID}

    # Use the temporary repository.
    export DOCKER_REPO=curlbuildimagestemp
  fi
else
  # Get the version from the version file.
  export VERSION=$(cat VERSION)

    # Use the temporary repository.
  export DOCKER_REPO=curlbuildimagestemp
fi


# Simple function which uses docker to build images.
build_image()
{
  TAG=$1
  BASE_IMAGE=$2
  DOCKER_SCRIPT=$3

  echo "Building ${TAG}:${VERSION} from ${BASE_IMAGE}"

  docker build --build-arg BASE_IMAGE=${BASE_IMAGE} \
               --build-arg DOCKER_SCRIPT=${DOCKER_SCRIPT} \
               -t ${DOCKER_REPO}/${TAG}:${VERSION}  \
               .
}

# Simple wrapper function which adds the REPOSITORY and VERSION to the given
# BASE_IMAGE, then builds.
build_image_versioned()
{
  TAG=$1
  BASE_IMAGE=$2
  DOCKER_SCRIPT=$3

  build_image ${TAG} ${DOCKER_REPO}/${BASE_IMAGE}:${VERSION} ${DOCKER_SCRIPT}
}


# Simple function which adds the REPOSITORY and VERSION to the given TAG,
# then pushes to Docker.
push_image_versioned()
{
  TAG=$1
  docker push ${DOCKER_REPO}/${TAG}:${VERSION}
}
