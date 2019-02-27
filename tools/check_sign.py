#!/usr/bin/python
# -*- coding: utf-8 -*-

import hashlib

test_str = 'callback=&prepay_id=20190227110910100173010123041877687066&service_id=100173&to=0x218ab2bf2b25ba8ea0d98eecf52c0dfc35bcd7d8&value=0&key=4e16194261bc17c076a0d4cb24daa2e4'

temp = hashlib.sha512(test_str.encode('utf8'))

result = hashlib.md5(temp.hexdigest().encode('utf8'))

print(result.hexdigest())
