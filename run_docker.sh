#!/bin/bash

docker run \
--rm \
--platform linux/amd64 \
-v "$(pwd)/main.robot:/test/main.robot" \
-v "$(pwd)/config.py:/test/config.py" \
-v "$(pwd)/output:/test/output" \
--user pwuser \
marketsquare/robotframework-browser:18 \
bash -c "robot --outputdir /test/output /test"
