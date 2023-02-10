# Pentaho Kettle

## Pre-requisites for building the project:

```
Maven, version 3+
Java JDK 11
```

## Apple Silicon(M1/M2)(Optional)

```shell
# 1. install rosetta
softwareupdate --install-rosetta

# 2. start x86_64 shell
env /usr/bin/arch -x86_64 ``/bin/zsh --login
```

## Installation

```shell
git clone https://github.com/pentaho/pentaho-kettle.git
cd ./pentaho-kettle
mvn clean package
```

Below commands will build a installation file `assemblies/client/target/pdi-ce-*-SNAPSHOT.zip`, after unzip it, please copy directory `data-integration` to `etl-starter-kit` project `kettle` directory。

## Start kettle client

```
cd data-integration && sh ./spoon.sh
```

## Demo

`kettle/examples` directory contains many examples.

## Official document

[Pentaho](https://help.hitachivantara.com/Documentation/Pentaho/9.4/Products)
