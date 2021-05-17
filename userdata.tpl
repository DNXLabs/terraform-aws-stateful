#!/bin/bash

set -eux

${efs}

${eip}

${ebs}

${cwlogs}

${userdata_extra}