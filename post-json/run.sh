#!/bin/bash

racket post-json.rkt; jsonlint posts.json -i;
