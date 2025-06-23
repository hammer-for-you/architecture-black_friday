#!/bin/bash

docker exec -i configSrv1 mongosh --port 27031 <<EOF
rs.initiate(
  {
    _id : "config_server",
    configsvr: true,
    members: [
      { _id : 0, host : "configSrv1:27031" },
      { _id : 1, host : "configSrv2:27032" },
      { _id : 2, host : "configSrv3:27033" },
    ]
  }
);
exit();
EOF

docker exec -i shard1_1 mongosh --port 27011 <<EOF
rs.initiate(
  {
    _id : "shard1",
    members: [
      { _id : 10, host : "shard1_1:27011" },
      { _id : 11, host : "shard1_2:27012" },
      { _id : 12, host : "shard1_3:27013" }
    ]
  }
);
exit();
EOF

docker exec -i shard2_1 mongosh --port 27021 <<EOF
rs.initiate(
  {
    _id : "shard2",
    members: [
      { _id : 20, host : "shard2_1:27021" },
      { _id : 21, host : "shard2_2:27022" },
      { _id : 22, host : "shard2_3:27023" },
    ]
  }
);
exit();
EOF

