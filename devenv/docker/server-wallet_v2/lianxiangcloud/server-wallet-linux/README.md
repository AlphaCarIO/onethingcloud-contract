# server-wallet使用说明
## 目录结构介绍
- bin
  - server-wallet
  - wallet.conf //服务配置
  - wallet.xml  //log配置
  - passwd.json //启动服务时，预解锁的账户和密码对 示例：{"0x7eff122b94897ea5b0e2a9abf47b86337fafebdc":"1234",  "0xd7e9ff289d2e1405e1bd825168d36ec917aea971":"1234"}
  - keystore    //账户的秘钥文件
    - UTC--2016-10-21T22-30-03.071787745Z--7eff122b94897ea5b0e2a9abf47b86337fafebdc
    - UTC--2016-10-21T22-30-03.071787745Z--d7e9ff289d2e1405e1bd825168d36ec917aea971

- log

  - wallet_debug.log

- sbin

  - wallet.sh //服务启动脚本

- wallet.conf 配置文件说明

  ```
  测试环境配置
  
  log ./wallet.xml                                   // 日志配置文件
  maxproc 4                                          // 程序线程数设置
  http.addr 0.0.0.0:8080                             // http服务地址
  http.read.timeout 10s                              // http服务读超时时间
  http.write.timeout 10s                             // http服务写超时时间
  keystore  ./keystore                               // 私钥存储文件
  dnscache.updateinterval 300                        // XRoute DNS刷新周期 单位：秒
  rpc.protocal https                                 // XRoute http协议
  xhost sandbox-blockchain.xunlei.com                // XRoute Host
  chain_id 30261                                     // 链ID
  ```

  ```
  正式环境配置
  
  log ./wallet.xml                                   // 日志配置文件
  maxproc 4                                          // 程序线程数设置
  http.addr 0.0.0.0:8080                             // http服务地址
  http.read.timeout 10s                              // http服务读超时时间
  http.write.timeout 10s                             // http服务写超时时间
  keystore  ./keystore                               // 私钥存储文件
  dnscache.updateinterval 300                        // XRoute DNS刷新周期 单位：秒
  rpc.protocal https                                 // XRoute http协议
  xhost rpc-blockchain.xunlei.com                    // XRoute Host
  chain_id 30261                                     // 链ID
  ```

   

## 服务启动

启动服务前更新账号秘钥文件keystore、passwd.json与服务配置文件wallet.conf

```
cd /your/path/thunderchain-server-sdk/sbin/
将启动脚本wallet.sh第5行修改为当前程序路径 '/your/path/thunderchain-server-sdk'
./wallet.sh start 启动服务
```




## API说明

#### 接口错误码

```
{
"errcode": -1001,
"errmsg": "params err",
"id": 6,
"jsonrpc": "2.0",
"result": ""
}
```

errcode：[错误码定义](#错误码定义)



### accounts

功能描述：

获取钱包管理的全部账户地址

参数：

none

返回结果：

账户地址数组

示例：
```
//request
curl -H "Content-Type:application/json" --data '{"jsonrpc":"2.0","method": "accounts", "params": [], "id": 6}' localhost:8080
//result
{
 "id": 6,
 "jsonrpc": "2.0",
 "errcode": 0,
 "errmsg": "success",
 "result": ["0x33d4fcb75ce608920c7e5755304c282141dfc4dc", "0x7a4877494b59c0bd929747800ab86a8b89380ac5", "0x36419474a02a507e236dc473648197f07ab4722e", "0x7fc423bd7ed1f5d17a92bdb8c39ed620f48f7559", "0x8f470d7f2b2db7b83accd008ddabc5423c06044b", "0x622bc0938fae8b028fcf124f9ba8580719009fdc"]
}

```

### newAccount
功能描述：

创建新的账户

参数：

账户密码

返回结果：

新账户地址

示例：
```
//request
curl -H "Content-Type:application/json" --data '{"jsonrpc":"2.0","method": "newAccount", "params": ["123456"], "id": 6}' localhost:8080
//result
{
 "id": 6,
 "jsonrpc": "2.0",
 "errcode": 0,
 "errmsg": "success",
 "result": "0x84d8698746dbe68c97965c48c7b56979c577df11"
}

```

### getBalance
功能描述：

查询账户余额

参数：

账户地址

返回结果：

账户地址余额

示例：
```
//request
curl -H "Content-Type:application/json" --data '{"jsonrpc":"2.0","method": "getBalance", "params": ["0x33d4fcb75ce608920c7e5755304c282141dfc4dc"], "id": 6}' localhost:8080
//result
{
 "id": 6,
 "jsonrpc": "2.0",
 "errcode": 0,
 "errmsg": "success",
 "result": 99030093892100000000170
}

```

### getTransactionCount
功能描述：

查询账户nonce值

参数：

账户地址

返回结果：

账户地址当前nonce值

示例：
```
//request
curl -H "Content-Type:application/json" --data '{"jsonrpc":"2.0","method": "getTransactionCount", "params": ["0x622bc0938fae8b028fcf124f9ba8580719009fdc"], "id": 6}' localhost:8080
//result
{
 "id": 6,
 "jsonrpc": "2.0",
 "errcode": 0,
 "errmsg": "success",
 "result": 26
}

```

### sendTransaction
功能描述：

普通转账交易

参数：

- Object： 交易对象
  - from: 转出账户地址
  - to: 转入账户地址
  - value: 转账金额 (推荐使用十进制)
  - nonce: (可选) from地址nonce值

- from账户密码(可选)

示例：
```
params: [{
  "from": "0x622bc0938fae8b028fcf124f9ba8580719009fdc",
  "to": "0x33d4fcb75ce608920c7e5755304c282141dfc4dc",
  "value": "0x10", // 16 wei
}，“12345678”]
```

说明：**如果启动服务时，已经解锁了from账户，可以不用再传密码参数**

返回结果：

交易hash

示例：
```
//request
curl -H "Content-Type:application/json" --data '{"jsonrpc":"2.0","method": "sendTransaction", "params": [{"from": "0x622bc0938fae8b028fcf124f9ba8580719009fdc", "to": "0x33d4fcb75ce608920c7e5755304c282141dfc4dc", "value":"1200"},"12345678"], "id": 6}' localhost:8080
//result
{
 "id": 6,
 "jsonrpc": "2.0",
 "errcode": 0,
 "errmsg": "success",
 "result": "0x517490b857200702453f32ed0574487b44587958ff39b26554df4f4991cae18c"
}

```

### sendThirdTransaction
功能描述：

第三方转账交易

参数：

- Object： 交易对象
  - from: 转出账户地址
  - to: 转入账户地址
  - value: 转账金额
  - nonce: (可选) from地址nonce值

- from账户密码(可选)
- Object:  扩展对象
  - callback:  回调地址
  - prepay_id: 预交易id
  - order_id: 第三方交易id
  - service_id: 第三方服务号
  - sign：交易签名(签名方式：**MD5(SHA512(callback=XXX&prepay_id=XXX&service_id=XXX&to=XXX&value=XXX&key=XXX)), key为第三方服务号密匙**)
  - tx_type：交易类型描述
  - title：交易主题
  - desc：主题描述

示例：
```
[{
 "from": "0x622bc0938fae8b028fcf124f9ba8580719009fdc",
 "to": "0x33d4fcb75ce608920c7e5755304c282141dfc4dc",
 "value": "0x10"
}, "12345678", {
 "callback": "http://www.baidu.com",
 "prepay_id": "201805171750490000010186329868060670",
 "order_id": "88888888",
 "service_id": "0",
 "sign": "ca0c245b04fd26ddf8ed622afc247bf6",
 "tx_type": "tx_third",
 "title": "test",
 "desc": "this is a test by skl"
}]
```

说明：**如果启动服务时，已经解锁了from账户，可以不用再传密码参数**

返回结果：

交易hash

示例：
```
//request
curl -H "Content-Type:application/json" --data '{"jsonrpc":"2.0","method": "sendThirdTransaction", "params": [{"from": "0x622bc0938fae8b028fcf124f9ba8580719009fdc", "to": "0x33d4fcb75ce608920c7e5755304c282141dfc4dc", "value":"0x10"},"12345678",{"callback":"http://www.baidu.com","prepay_id":"201805171750490000010186329868060670","order_id":"88888888","service_id":"0","sign":"ca0c245b04fd26ddf8ed622afc247bf6","tx_type":"tx_third","title":"test","desc":"this is a test by skl"}], "id": 6}' localhost:8080
//result
{
 "id": 6,
 "jsonrpc": "2.0",
 "errcode": 0,
 "errmsg": "success",
 "result": "0x517490b857200702453f32ed0574487b44587958ff39b26554df4f4991cae18c"
}

```

### sendContractTransaction
功能描述：

合约执行交易

参数：

- Object： 交易对象
  - from: 转出账户地址
  - to: 转入账户地址
  - gas：(可选，默认90000)手续费
  - gasPrice：(可选，默认1e11)
  - value: 转账金额
  - data：执行合约code
  - nonce: (可选) from地址nonce值
- from账户密码(可选)
- Object:  扩展对象
  - callback:  回调地址
  - prepay_id: 预交易id
  - service_id: 第三方服务号
  - sign：交易签名(签名方式：**MD5(SHA512(callback=XXX&prepay_id=XXX&service_id=XXX&to=XXX&value=XXX&key=XXX)), key为第三方服务号密匙**)
  - tx_type：交易类型描述
  - title：交易主题
  - desc：主题描述

示例：
```
[{
 "from": "0x622bc0938fae8b028fcf124f9ba8580719009fdc",
 "to": "0x7f7f7dbf351d4272eb282f16091c96b4819007f5",
 "data": "0x49f3870b0000000000000000000000000000000000000000000000000000000000000001"
}, "12345678", {
 "callback": "http://www.baidu.com",
 "prepay_id": "201805171922030000010176643187014087",
 "service_id": "0",
 "sign": "80fa49b1c7e5ec06ab595850dc8e8f87",
 "tx_type": "contract",
 "title": "test",
 "desc": "this is a test by skl"
}]
```

说明：**如果启动服务时，已经解锁了from账户，可以不用再传密码参数**

返回结果：

交易hash

示例：
```
//request
curl -H "Content-Type:application/json" --data '{"jsonrpc":"2.0","method": "sendContractTransaction", "params": [{"from": "0x622bc0938fae8b028fcf124f9ba8580719009fdc", "to": "0x7f7f7dbf351d4272eb282f16091c96b4819007f5", "data":"0x49f3870b0000000000000000000000000000000000000000000000000000000000000001"},"12345678",{"callback":"http://www.baidu.com","prepay_id":"201805171922030000010176643187014087","service_id":"0","sign":"80fa49b1c7e5ec06ab595850dc8e8f87","tx_type":"contract","title":"test","desc":"this is a test by skl"}], "id": 6}' localhost:8080
//result
{
 "id": 6,
 "jsonrpc": "2.0",
 "errcode": 0,
 "errmsg": "success",
 "result": "0x517490b857200702453f32ed0574487b44587958ff39b26554df4f4991cae18c"
}

```

## 错误说明
- method invalid  接口名有误
- params err    参数有误
- could not decrypt key with given passphrase   账户密码错误



#### 错误码定义

| 错误码 | 错误信息                             | 说明                                      |
| ------ | ------------------------------------ | ----------------------------------------- |
| 0      | success                              | 请求成功                                  |
| -1000  | invalid method                       | 接口请求方法错误                          |
| -1001  | params err                           | 参数错误， 一般由Params参数个数不一致导致 |
| -1002  | find account err                     | 账号查找错误                              |
| -1003  | rpc getBalance err                   | 查看余额 rpc调用失败                      |
| -1004  | ks.NewAccount err                    | 新建账号错误                              |
| -1005  | rpc getNonce err                     | 获取Nonce值 rpc调用失败                   |
| -1006  | wallet SignTx err                    | 交易签名错误                              |
| -1007  | rlp EncodeToBytes err                | RLP编码错误                               |
| -1008  | rpc sendTransaction err              | 发送交易 rpc调用失败                      |
| -1009  | wallet SignTxWithPassphrase err      | 钱包签名交易错误                          |
| -1010  | third extension err                  | 第三方交易参数解析错误                    |
| -1011  | rpc sendThirdTransaction err         | 发送第三方交易 rpc调用失败                |
| -1012  | ContractExtension err                | 合约交易参数解析错误                      |
| -1013  | rpc sendContractTransaction err      | 发送合约交易 rpc调用失败                  |
| -1014  | SignDataArgs err                     | 签名数据解析错误                          |
| -1015  | wallet SignHash512 err               | sha512加密错误                            |
| -1016  | wallet SignHash512WithPassphrase err | sha512加密错误                            |
| -1017  | RecoverPubkey512 err                 | 公钥恢复错误                              |
| -1018  | json unmarshal err                   | json解析错误                              |
| -1019  | rpc getTransactionByHash err         | 查询交易 rpc调用失败                      |
| -1020  | rpc getTransactionReceipt err        | 查询收据 rpc调用失败                      |
| -1021  | SendTxArgs err                       | 发送交易参数解析错误 或 获取Nonce值错误   |

注：xroute api 错误码透传返回
