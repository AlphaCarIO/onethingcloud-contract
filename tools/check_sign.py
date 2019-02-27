#!/usr/bin/python
# -*- coding: utf-8 -*-

import hashlib

test_str = 'callback=&prepay_id=20190227095706100173010143637494880975&service_id=100173&to=0xff5bc31be5ca320c8f6563a87b3e033305cf3509&value=&key=4e16194261bc17c076a0d4cb24daa2e4'

temp = hashlib.sha512(test_str.encode('utf8'))

result = hashlib.md5(temp.hexdigest().encode('utf8'))

print(result.hexdigest())
