#数据结构

    struct Order {
        string orderId; // 订单编号
        uint8 orderType; // 订单类型
        uint8 orderStatus; // 订单状态
        uint64 feeTotal; // 订单总金额
        uint16 passengerAmount; // 乘客数
        uint distance; // 行程距离
        string locationOrigin; // 出发地详情
        string locationDest; // 目标地详情
        uint64 createTime; // 创建时间（UTC时间戳）
        uint64 departureTime; // 出发时间，仅顺风车（UTC时间戳）
        bool isValid; //标记位 判断结构体是否存在与mapping当中
    }

#API接口
1. 创建订单  
   createOrder(string memory orderId, uint8 orderType, uint8 orderStatus, 
    uint64 feeTotal, uint16 passengerAmount, uint distance, string memory locationOrigin, string memory locationDest,
    uint64 createTime, uint64 departureTime)  
   参数:  
   1) 与Order数据结构对应对相关字段  

2. 修改订单  
   modifyOrder(string memory orderId, uint8 newOrderStatus)  
   参数:  
   1) 订单编号  
   2) 订单状态  

3. 查询订单  
   getOrderById(string memory orderId)  
   参数:  
   1) 订单编号  
