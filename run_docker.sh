#!/bin/bash

docker run \
--rm \
-v "$(pwd)/main.robot:/test/main.robot" \
-v "$(pwd)/config.py:/test/config.py" \
-v "$(pwd)/output:/test/output" \
--user pwuser \
marketsquare/robotframework-browser:latest \
bash -c "robot --outputdir /test/output /test"