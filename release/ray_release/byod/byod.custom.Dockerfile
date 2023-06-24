# syntax=docker/dockerfile:1.3-labs
# shellcheck disable=SC2148

ARG BASE_IMAGE
FROM "$BASE_IMAGE"

ARG POST_BUILD_SCRIPT
ARG RAY_COMMIT

COPY "$POST_BUILD_SCRIPT" /tmp/post_build_script.sh
RUN /tmp/post_build_script.sh

RUN <<EOF
#!/bin/bash

COMMIT=${COMMIT_TO_TEST-${BUILDKITE_COMMIT}}
python -c "import ray; assert ray.__commit__ == \"${RAY_COMMIT}\", ray.__commit__"

EOF
