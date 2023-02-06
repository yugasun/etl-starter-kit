## DataX

## Installation

```shell
wget https://datax-opensource.oss-cn-hangzhou.aliyuncs.com/202210/datax.tar.gz
tar xvf datax.tar.gz
```

After unzip installation zip file, copy `datax` directory to current project `datax` directory.

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
