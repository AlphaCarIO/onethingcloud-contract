#api sandbox  
https://thunderchain.docs.apiary.io/#

#充值  
{  
    &emsp;"email": "test@alphacar.io",  
    &emsp;"address": "0x5875bf81ec70e9c0bce8345aa34b74ad7785dbb6",  
    &emsp;"sign": "b7faa0a74ced269a35bcb594227446f1"  
}

#部署参数  
{  
    &emsp;"email": "test@alphacar.io",  
    &emsp;"bytecode": "",  
    &emsp;"params": "",  
    &emsp;"sign": ""  
}

#测试链查询参数  
{  
  &emsp;"code": 0,  
  &emsp;"data":  
  &emsp;{  
    &emsp;&emsp;"id": 12063  
  &emsp;},  
  &emsp;"msg": ""  
}

#docker cmd  
cd docker  
./gen_img.sh  
docker run -it -p 18080:8080 onethingcloud-wallet-test
