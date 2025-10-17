Increase max_map_count on your host (Linux). This command must be run with root permissions:

```
$ sysctl -w vm.max_map_count=262144
```

Clone Repo

```
git clone https://github.com/wazuh/wazuh-docker.git -b v4.13.1
```

Opting for single node deployment option

```
cd wazuh-docker/single-node/
```

Generate certs

```
docker run --rm --hostname wazuh-certs-generator -v "./config/wazuh_indexer_ssl_certs/:/certificates/" -v "./config/certs.yml:/config/certs.yml" wazuh/wazuh-certs-generator:0.0.2
```

Delete all other folders
