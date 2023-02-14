## DataX

## Installation

```shell
wget https://datax-opensource.oss-cn-hangzhou.aliyuncs.com/202210/datax.tar.gz
tar xvf datax.tar.gz
```

After unzip installation zip file, copy `datax` directory to current project `datax` directory.

## Options

Datax standardize config scheme contains `reader`, `writer`, `transformer`, like below:

```json
{
  "job": {
    "setting": {
      "speed": {
        "channel": 1
      }
    },
    "content": [
      {
        "reader": {},
        "writer": {},
        "transformer": []
      }
    ]
  }
}
```

```
reader - use to read data from source
writer - use to write data to target
transformer - use to transform data field
```

use `setting.speed` to control out syncing task:

```json
"setting": {
  "speed": {
    // control by channel
    "channel": 5,
    // control by byte size
    "byte": 1048576,
    // control by record size
    "record": 10000
  }
},
```

use `setting.errorLimit` to control error check:

```json
"setting": {
  "errorLimit": {
    // max error records <= 1
    "record": 1,
    // max error percentage <= 0.02
    "percentage": 0.02,
  }
},
```

### Notice!!!

If config `speed.record`, datax will run with a bug, we can config it like below:

```json
"core": {
  "transport": {
    "channel": {
      "speed": {
        "record": 10000
      }
    }
  }
},
"job": {
  "setting": {
    "speed": {
      "channel": 2
    }
  },
}
```

## Usage

### 1. Stream to Stream

```shell
python ./datax/bin/datax.py ./examples/stream2stream.json
```

### 2. MySQL to MySQL

```shell
python ./datax/bin/datax.py ./examples/mysql2mysql.json
```

### 3. MySQL to PostgreSQL

```shell
python ./datax/bin/datax.py ./examples/mysql2pg.json
```

### 4. PostgreSQL to MySQL

```shell
python ./datax/bin/datax.py ./examples/pg2mysql.json
```
