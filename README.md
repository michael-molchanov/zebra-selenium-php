[![Build Status](https://img.shields.io/travis/michael-molchanov/zebra-selenium-php.svg?style=flat-square)](https://travis-ci.org/michael-molchanov/zebra-selenium-php)

# Usage

```
docker run --rm -v "$PWD:$PWD" --workdir "$PWD" -e SCREEN_WIDTH="1920" -e SCREEN_HEIGHT="1080" -e SCREEN_DEPTH="24" --entrypoint "/opt/bin/entry_point.sh" --shm-size=2g michaeltigr/zebra-selenium-php-travis:latest "start command"
```
