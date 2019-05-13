contract for onething cloud.

说明:  
1. contracts目录  
包含合约代码  
OrderManager.sol为主要业务逻辑合约，支持创建，修改，查询订单操作；  
Ownable.sol为辅助合约，提供权限控制功能；

2. devenv目录  
Dockerfile以及k8s配置相关文件；

3. test目录  
单元测试目录；

4. tools目录  
辅助脚本相关文件；

curl -H "Content-Type:application/json" --data '{"jsonrpc":"2.0","method": "getBalance", "params": ["0x9ee248c0097b03d8c2e49c5e5e01f825643f94f7"], "id": 6}' http://172.19.207.178:31080

curl -H "Content-Type:application/json" --data '{"jsonrpc":"2.0","method": "getBalance", "params": ["0x9ee248c0097b03d8c2e49c5e5e01f825643f94f7"], "id": 6}' http://0.0.0.0:8080

curl -H "Content-Type:application/json" --data '{"jsonrpc":"2.0","method": "getBalance", "params": ["0x3032df8704ee2ebab4e4176de4e7e7312ef9472e"], "id": 6}' http://0.0.0.0:8080
