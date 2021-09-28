Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8A9841B7D9
	for <lists+linux-spi@lfdr.de>; Tue, 28 Sep 2021 21:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242390AbhI1UAC (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 28 Sep 2021 16:00:02 -0400
Received: from mout.gmx.net ([212.227.15.18]:40437 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242525AbhI1UAB (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 28 Sep 2021 16:00:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1632859067;
        bh=950+H6zcMyRuuZltaXExuXwLbPiKm4N7Nqzoz5IS+ho=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=PeM1eF0KvzKhjLNc/CRJVBq5UyevRkFIyO3oWgbjhBe1NyJKSfBUORjx5o6gxgxeu
         89HM5VbaDswa0WrdyeqyIPABzMmAdwYiQIbyZYp6JCRXVX94IyvwJVKMclymDcZ0ZQ
         IVOYQ5FngkFN3VU8q4AskHaadJNDO0GaORE8qC54=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from Venus.fritz.box ([46.223.119.124]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MmlXA-1nDxds43JW-00jv95; Tue, 28
 Sep 2021 21:57:47 +0200
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     broonie@kernel.org, f.fainelli@gmail.com
Cc:     rjui@broadcom.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com, nsaenz@kernel.org,
        linux-spi@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        jgg@ziepe.ca, p.rosenberger@kunbus.com,
        linux-integrity@vger.kernel.org,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>, stable@vger.kernel.org
Subject: [PATCH] spi: bcm2835: do not unregister controller in shutdown handler
Date:   Tue, 28 Sep 2021 21:56:57 +0200
Message-Id: <20210928195657.5573-1-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1://1RGDldizjVvhp5TlhlUqpmOlMqfM8sYBCBHUC1cik40Y8GcTk
 lcIte5jutwp0x3rEhG1X1ppsUbnmx1C4qE6I+Uwy5peQWZKzPyTfGSk92HP97c2LuZHHJ5P
 jNtjj5D4vkb98QtkEDMx9rl6Hlsngg/LyPPRtXsYr7SgoeV4JDGBDd5Rjj67FvwDlvqffCj
 BTk2JZWLnH8GpOaBuFRqg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:fK/50CUMqaU=:zV/lz+hruJoKMFgNqPcCWH
 SlMDruu2kYUlUXHnbj0YGzdTV+j2PhGIaFVp9Z0XaboQ6Wg3TIQrL4rtIh+WqEgmuOOC4DK5t
 YawyTJ8OOCbSWjOciF9SlejrSKHBTckpcS9gTJj4JGUNy10pyWwpNKwinGLIYq2uGJKscnjP5
 qMcRH/qoh2EYcGqWSLZF/PKR1Ui63NgT479RkwvAEtWIYc3XhzS/1/KCTzUdfkPldomjFhP8o
 e81JWm263XwjzQGB8J51E6vh2IkzTtooi4mZsCvoshMKtFCS+bY1V/+cPDaPLXS3GenLwbi2l
 KkurxveLH0fN2cCuib6vfYD4xH7loN1jsHMaqF8224I8nuUIVCe0HdOJcx1zDIRiMbdBgoo5M
 zpkfNgEHIXNJUaDu8Tif32I8uDIN+fqSOyq2K4NDWxWcXUfM+qw4DF580u0dkG/sUsQhnhicF
 CkiYyH5JYOCH4o58xP0xT3/Xs6oD8hSoYZbJIawhYKMrJVgePMi/wCi4BV9+AdVTMEuIBQeY4
 KR4tjANETdFHrTDvx+zUeSQajB4fC2AEji23eGM37LqKq1P78HDdzOHR3KJdac9P1+55al4Ai
 gneWNNc4TUi5hW5llenFDQs43Nt6I5yLxyomb/cJn/yKrYqoVy8PK1fz1TyrC/GqV1K2Honn0
 sLpuvQTHJhrG0DTnvrngj3hUYfQJDoGOxoRH6TnZoKO+Kyq0zhp6W0oPCYX33OpOOr0Hu3+wx
 we6kTtrW+icAL5xTru2mes16WIqV/FiGmgV6TXZ0DFd1deVKdOT75B4bMwcfSMdbAtAQT/Jmg
 QTGETr05qXsTH7+ch1CaVAP1jxbKfwA14mKBFOZGIKMz/5XgujLS8K3A3hijqF6vOSfLPM3e5
 1lJJfR1M9YfxlK1hRrSIE8mgfUoeOiYBb+cDdOnqWHEEnCkXBSC8BzXD358OAv60RL3BR0HWx
 FuiatnbUyPbBXowr2Tq+68NfqsoU5WR5NFRhXffk+yXjMrbXN6kNdF1/auhHbXwGtNZ7QWp4p
 NfCuGKTZSPvGhDSTCXOV+dzFM2n6g6zawOG218GOB96hihQd68JBejodY75LRgBLQifC0oh3i
 crUetjzl8hWyjE=
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

RG8gbm90IHVucmVnaXN0ZXIgdGhlIFNQSSBjb250cm9sbGVyIGluIHRoZSBzaHV0ZG93biBoYW5k
bGVyLiBUaGUgcmVhc29uCnRvIGF2b2lkIHRoaXMgaXMgdGhhdCBjb250cm9sbGVyIHVucmVnaXN0
cmF0aW9uIHJlc3VsdHMgaW4gdGhlIHNsYXZlCmRldmljZXMgcmVtb3ZlKCkgaGFuZGxlciBiZWlu
ZyBjYWxsZWQgd2hpY2ggbWF5IGJlIHVuZXhwZWN0ZWQgZm9yIHNsYXZlCmRyaXZlcnMgYXQgc3lz
dGVtIHNodXRkb3duLgoKT25lIGV4YW1wbGUgaXMgaWYgdGhlIEJDTTI4MzUgZHJpdmVyIGlzIHVz
ZWQgdG9nZXRoZXIgd2l0aCB0aGUgVFBNIFNQSQpkcml2ZXI6CkF0IHN5c3RlbSBzaHV0ZG93biBm
aXJzdCB0aGUgVFBNIGNoaXAgZGV2aWNlcyAocHJlKSBzaHV0ZG93biBoYW5kbGVyCih0cG1fY2xh
c3Nfc2h1dGRvd24pIGlzIGNhbGxlZCwgc3RvcHBpbmcgdGhlIGNoaXAgYW5kIHNldHRpbmcgYW4g
b3BlcmF0aW9ucwpwb2ludGVyIHRvIE5VTEwuClRoZW4gc2luY2UgdGhlIEJDTTI4MzUgc2h1dGRv
d24gaGFuZGxlciB1bnJlZ2lzdGVycyB0aGUgU1BJIGNvbnRyb2xsZXIgdGhlClRQTSBTUEkgcmVt
b3ZlIGZ1bmN0aW9uICh0cG1fdGlzX3NwaV9yZW1vdmUpIGlzIGFsc28gY2FsbGVkLiBJbiBjYXNl
IG9mClRQTSAyIHRoaXMgZnVuY3Rpb24gYWNjZXNzZXMgdGhlIG5vdyBudWxsaWZpZWQgb3BlcmF0
aW9ucyBwb2ludGVyLApyZXN1bHRpbmcgaW4gdGhlIGZvbGxvd2luZyBOVUxMIHBvaW50ZXIgYWNj
ZXNzOgoKWyAgMTc0LjA3ODI3N10gODwtLS0gY3V0IGhlcmUgLS0tClsgIDE3NC4wNzgyODhdIFVu
YWJsZSB0byBoYW5kbGUga2VybmVsIE5VTEwgcG9pbnRlciBkZXJlZmVyZW5jZSBhdCB2aXJ0dWFs
IGFkZHJlc3MgMDAwMDAwMzQKWyAgMTc0LjA3ODI5M10gcGdkID0gNTU3YTVmYzkKWyAgMTc0LjA3
ODMwMF0gWzAwMDAwMDM0XSAqcGdkPTAzMWNmMDAzLCAqcG1kPTAwMDAwMDAwClsgIDE3NC4wNzgz
MTddIEludGVybmFsIGVycm9yOiBPb3BzOiAyMDYgWyMxXSBTTVAgQVJNClsgIDE3NC4wNzgzMjNd
IE1vZHVsZXMgbGlua2VkIGluOiB0cG1fdGlzX3NwaSB0cG1fdGlzX2NvcmUgdHBtIHNwaWRldiBn
cGlvX3BjYTk1M3ggbWNwMzIweCBydGNfcGNmMjEyNyBpbmR1c3RyaWFsaW8gcmVnbWFwX2kyYyBy
ZWdtYXBfc3BpIDgwMjFxIGdhcnAgc3RwIGxsYyBmdGRpX3NpbzYKWyAgMTc0LjA3ODQ0MV0gQ1BV
OiAzIFBJRDogMSBDb21tOiBzeXN0ZW1kLXNodXRkb3cgVGFpbnRlZDogRyAgICAgICAgV0MgICAg
ICAgIDUuMTAuMjctcnQzNi1DNExTKyAjMQpbICAxNzQuMDc4NDQ4XSBIYXJkd2FyZSBuYW1lOiBC
Q00yODM1ClsgIDE3NC4wNzg0NTFdIFBDIGlzIGF0IHRwbV9jaGlwX3N0YXJ0KzB4MWMvMHhjMCBb
dHBtXQpbICAxNzQuMDc4NDkyXSBMUiBpcyBhdCB0cG1fY2hpcF91bnJlZ2lzdGVyKzB4YzAvMHhl
MCBbdHBtXQpbICAxNzQuMDc4NTI1XSBwYyA6IFs8YmYyNDQwODA+XSAgICBsciA6IFs8YmYyNDQ3
Yzg+XSAgICBwc3I6IDIwMDAwMDEzClsgIDE3NC4wNzg1MjldIHNwIDogYzE5MDNjMzggIGlwIDog
YzE5MDNjNTAgIGZwIDogYzE5MDNjNGMKWyAgMTc0LjA3ODUzM10gcjEwOiBjMWFjYTA1NCAgcjkg
OiBjMGU3N2IyOCAgcjggOiBjMzExYzAwMApbICAxNzQuMDc4NTM3XSByNyA6IDAwMDAwMDAwICBy
NiA6IGJmMjYyMDEwICByNSA6IGMzMjNmYmY4ICByNCA6IGMzMjNmODAwClsgIDE3NC4wNzg1NDFd
IHIzIDogMDAwMDAwMDAgIHIyIDogMDAwMDAwMDAgIHIxIDogMDAwMDAwMDAgIHIwIDogYzMyM2Y4
MDAKWyAgMTc0LjA3ODU0Nl0gRmxhZ3M6IG56Q3YgIElSUXMgb24gIEZJUXMgb24gIE1vZGUgU1ZD
XzMyICBJU0EgQVJNICBTZWdtZW50IG5vbmUKWyAgMTc0LjA3ODU1M10gQ29udHJvbDogMzBjNTM4
M2QgIFRhYmxlOiAwMmE0Nzk4MCAgREFDOiBmN2JkMzMxMwpbICAxNzQuMDc4NTU2XSBQcm9jZXNz
IHN5c3RlbWQtc2h1dGRvdyAocGlkOiAxLCBzdGFjayBsaW1pdCA9IDB4YTA1NTFiMWQpClsgIDE3
NC4wNzg1NjFdIFN0YWNrOiAoMHhjMTkwM2MzOCB0byAweGMxOTA0MDAwKQpbICAxNzQuMDc4NTY2
XSAzYzIwOiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBjMzIzZjgwMCBjMzIzZmJmOApbICAxNzQuMDc4NTc0XSAzYzQwOiBjMTkwM2M2NCBjMTkw
M2M1MCBiZjI0NDdjOCBiZjI0NDA3MCBjMzIzZjgwMCBjMzQ5ODgwMCBjMTkwM2M3YyBjMTkwM2M2
OApbICAxNzQuMDc4NTgxXSAzYzYwOiBiZjI2MDE5MCBiZjI0NDcxNCBjMzQ5ODgwMCBjMzQ5ODgw
MCBjMTkwM2M5NCBjMTkwM2M4MCBjMDhiOWZhOCBiZjI2MDE3YwpbICAxNzQuMDc4NTg4XSAzYzgw
OiBjMzQ5ODgwMCAwMDAwMDAwMCBjMTkwM2NiNCBjMTkwM2M5OCBjMDg2MmIyMCBjMDhiOWY3YyBj
MWFhZjczMCBjMzQ5ODgwMApbICAxNzQuMDc4NTk1XSAzY2EwOiBjMTJmYzlkMCAwMDAwMDAwMCBj
MTkwM2NjNCBjMTkwM2NiOCBjMDg2MmJmNCBjMDg2MmExYyBjMTkwM2NlNCBjMTkwM2NjOApbICAx
NzQuMDc4NjAyXSAzY2MwOiBjMDg2MTJkMCBjMDg2MmJlMCBjMzQ5ODgwMCAwMDAwNTc0NCBjMDhi
YTI5OCAwMDAwMDAwMCBjMTkwM2QyYyBjMTkwM2NlOApbICAxNzQuMDc4NjA5XSAzY2UwOiBjMDg1
YzYxYyBjMDg2MTIwMCBmZmZmZTAwMCBjMTM0MDRjMCBjMDc4MWY0MCBjMGU3N2IyOCBjMTkwM2Qy
YyBjMTIwNTA0OApbICAxNzQuMDc4NjE2XSAzZDAwOiBjMDMzMmMzYyBjMzQ5ODgwMCAwMDAwMDAw
MCBjMDhiYTI5OCBjMTNmZGQ3YyBjMTM1NjAxOCBjMGU3N2IyOCBjMWFjYTA1NApbICAxNzQuMDc4
NjIzXSAzZDIwOiBjMTkwM2Q0NCBjMTkwM2QzMCBjMDg1YzhkMCBjMDg1YzQ5OCBjMzQ5ODgwMCAw
MDAwMDAwMCBjMTkwM2Q1YyBjMTkwM2Q0OApbICAxNzQuMDc4NjMwXSAzZDQwOiBjMDhiYTI5NCBj
MDg1YzhjMCBjMzExYzAwMCAwMDAwMDAwMCBjMTkwM2Q2YyBjMTkwM2Q2MCBjMDhiYTJiMCBjMDhi
YTI1YwpbICAxNzQuMDc4NjM4XSAzZDYwOiBjMTkwM2Q5YyBjMTkwM2Q3MCBjMDg1YmI5MCBjMDhi
YTJhNCBjMTkwM2Q4YyBjMzY5YTA4MCBjMzY5YTExNCBjMTIwNTA0OApbICAxNzQuMDc4NjQ1XSAz
ZDgwOiBjMTkwM2RhNCBjMzExYzAwMCBjMzExYzAwMCAwMDAwMDAwMCBjMTkwM2RiYyBjMTkwM2Rh
MCBjMDhiYTc0OCBjMDg1YmIyYwpbICAxNzQuMDc4NjUxXSAzZGEwOiBjMzExYzM4MCBjMzExYzAw
MCAwMDAwMDAwMCBjMTNmZGQ3YyBjMTkwM2RkYyBjMTkwM2RjMCBiZjE2ODUzNCBjMDhiYTcxOApb
ICAxNzQuMDc4NjU5XSAzZGMwOiBjMWFjYTAwMCBjMWE3NTAxMCBjMWFjYTAxMCBjMTNmZGQ3YyBj
MTkwM2RmNCBjMTkwM2RlMCBiZjE2ODU4OCBiZjE2ODUwYwpbICAxNzQuMDc4NjY2XSAzZGUwOiBj
MWFjYTAxNCBjMWE3NTAxMCBjMTkwM2UwNCBjMTkwM2RmOCBjMDg2M2NhMCBiZjE2ODU3OCBjMTkw
M2UzYyBjMTkwM2UwOApbICAxNzQuMDc4NjczXSAzZTAwOiBjMDg1ZmM5MCBjMDg2M2M4MCBjMTkw
M2UzYyBjMGU3N2IxOCBjMDI0ODg4OCAwMDAwMDAwMCAwMDAwMDAwMCA4ODU1YTYwMApbICAxNzQu
MDc4NjgwXSAzZTIwOiBjMTIwZjFjYyBmZWUxZGVhZCBjMTkwMjAwMCAwMDAwMDA1OCBjMTkwM2U0
YyBjMTkwM2U0MCBjMDI0OWViMCBjMDg1ZmIwMApbICAxNzQuMDc4Njg3XSAzZTQwOiBjMTkwM2U2
NCBjMTkwM2U1MCBjMDI0OWZhMCBjMDI0OWU3OCAwMTIzNDU2NyAwMDAwMDAwMCBjMTkwM2Y5NCBj
MTkwM2U2OApbICAxNzQuMDc4Njk0XSAzZTYwOiBjMDI0YTI0NCBjMDI0OWY5MCBjMTkwM2VkNCBj
MmVjNTE4MCAwMDAwMDAyNCBjMTkwM2Y1OCAwMDAwMDAwNSBjMDQ0MWY1MApbICAxNzQuMDc4NzAx
XSAzZTgwOiBjMTkwM2VjNCBjMTkwM2U5MCBjMDQ0MWQ5NCBjMDQ5ODM1MCAwMDAwMDAwMCBjMTkw
M2VhMCBjMDczOWZhNCAwMDAwMDAyNApbICAxNzQuMDc4NzA4XSAzZWEwOiBjMmVjNTE4MCBjMTkw
M2Y1OCBjMTkwM2VkNCBjMmVjNTE4MCAwMDAwMDAwNSAwMDAwMDAwMCBjMTkwM2Y0YyBjMTkwM2Vj
OApbICAxNzQuMDc4NzE1XSAzZWMwOiBjMDQ0MWY1MCBjMDQyNTkzOCBjMTkwM2VkMCBjMTkwM2Vk
NCAwMDAwMDAwMCAwMDAwMDAwNSAwMDAwMDAwMCAwMDAwMDAyNApbICAxNzQuMDc4NzIyXSAzZWUw
OiBjMTkwM2VlYyAwMDAwMDAwNSBjMDIwMDA3YyBiZWM4MTI1MCAwMDAwMDAwNCBiZWM4MWY2MiAw
MDAwMDAxMCBiZWM4MTI2NApbICAxNzQuMDc4NzI5XSAzZjAwOiAwMDAwMDAwNSBiZWM4MTMxYyAw
MDAwMDAwYSBiNmQwZWY1MCAwMDAwMDAwMSBjMDIwMGU3MCBmZmZmZTAwMCBjMTM0MDRjMApbICAx
NzQuMDc4NzM2XSAzZjIwOiAwMDAwMDAwMCBjMDQ2NzNlOCBjMTkwM2Y0YyBjMTIwNTA0OCBjMmVj
NTE4MCBiZWM4MTI4YyAwMDAwMDAwMCAwMDAwMDAwMApbICAxNzQuMDc4NzQzXSAzZjQwOiBjMTkw
M2Y5NCBjMTkwM2Y1MCBjMDQ0MjBkMCBjMDQ0MWViNCAwMDAwMDAwMCBjMTM0MDRjMCAwMDAwMDAw
MCAwMDAwMDAwMApbICAxNzQuMDc4NzUwXSAzZjYwOiBjMTkwM2Y5NCBjMTIwNTA0OCBjMDMzMmMz
YyBjMTIwNTA0OCBiZWM4MTMxYyAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMApbICAxNzQuMDc4
NzU3XSAzZjgwOiAwMDAwMDA1OCBjMDIwMDIwNCBjMTkwM2ZhNCBjMTkwM2Y5OCBjMDI0YTM5OCBj
MDI0YTEzYyAwMDAwMDAwMCBjMTkwM2ZhOApbICAxNzQuMDc4NzY0XSAzZmEwOiBjMDIwMDA0MCBj
MDI0YTM4YyAwMDAwMDAwMCAwMDAwMDAwMCBmZWUxZGVhZCAyODEyMTk2OSAwMTIzNDU2NyA4ODU1
YTYwMApbICAxNzQuMDc4NzcxXSAzZmMwOiAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAw
MDA1OCAwMDAwMGZmZiBiZWM4MWJlOCAwMDAwMDAwMCAwMDQ1NmI4MApbICAxNzQuMDc4Nzc4XSAz
ZmUwOiAwMDQ2OGUzYyBiZWM4MWI2OCAwMDQ1MzRhOCBiNmU0YmEzOCA2MDAwMDAxMCBmZWUxZGVh
ZCAwMDAwMDAwMCAwMDAwMDAwMApbICAxNzQuMDc4NzgyXSBCYWNrdHJhY2U6ClsgIDE3NC4wNzg3
ODZdIFs8YmYyNDQwNjQ+XSAodHBtX2NoaXBfc3RhcnQgW3RwbV0pIGZyb20gWzxiZjI0NDdjOD5d
ICh0cG1fY2hpcF91bnJlZ2lzdGVyKzB4YzAvMHhlMCBbdHBtXSkKWyAgMTc0LjA3ODg1M10gIHI1
OmMzMjNmYmY4IHI0OmMzMjNmODAwClsgIDE3NC4wNzg4NTVdIFs8YmYyNDQ3MDg+XSAodHBtX2No
aXBfdW5yZWdpc3RlciBbdHBtXSkgZnJvbSBbPGJmMjYwMTkwPl0gKHRwbV90aXNfc3BpX3JlbW92
ZSsweDIwLzB4MzAgW3RwbV90aXNfc3BpXSkKWyAgMTc0LjA3ODg5OV0gIHI1OmMzNDk4ODAwIHI0
OmMzMjNmODAwClsgIDE3NC4wNzg5MDFdIFs8YmYyNjAxNzA+XSAodHBtX3Rpc19zcGlfcmVtb3Zl
IFt0cG1fdGlzX3NwaV0pIGZyb20gWzxjMDhiOWZhOD5dIChzcGlfZHJ2X3JlbW92ZSsweDM4LzB4
NTApClsgIDE3NC4wNzg5MjNdICByNTpjMzQ5ODgwMCByNDpjMzQ5ODgwMApbICAxNzQuMDc4OTI2
XSBbPGMwOGI5ZjcwPl0gKHNwaV9kcnZfcmVtb3ZlKSBmcm9tIFs8YzA4NjJiMjA+XSAoZGV2aWNl
X3JlbGVhc2VfZHJpdmVyX2ludGVybmFsKzB4MTEwLzB4MWM0KQpbICAxNzQuMDc4OTQyXSAgcjU6
MDAwMDAwMDAgcjQ6YzM0OTg4MDAKWyAgMTc0LjA3ODk0NV0gWzxjMDg2MmExMD5dIChkZXZpY2Vf
cmVsZWFzZV9kcml2ZXJfaW50ZXJuYWwpIGZyb20gWzxjMDg2MmJmND5dIChkZXZpY2VfcmVsZWFz
ZV9kcml2ZXIrMHgyMC8weDI0KQpbICAxNzQuMDc4OTU5XSAgcjc6MDAwMDAwMDAgcjY6YzEyZmM5
ZDAgcjU6YzM0OTg4MDAgcjQ6YzFhYWY3MzAKWyAgMTc0LjA3ODk2Ml0gWzxjMDg2MmJkND5dIChk
ZXZpY2VfcmVsZWFzZV9kcml2ZXIpIGZyb20gWzxjMDg2MTJkMD5dIChidXNfcmVtb3ZlX2Rldmlj
ZSsweGRjLzB4MTA4KQpbICAxNzQuMDc4OTczXSBbPGMwODYxMWY0Pl0gKGJ1c19yZW1vdmVfZGV2
aWNlKSBmcm9tIFs8YzA4NWM2MWM+XSAoZGV2aWNlX2RlbCsweDE5MC8weDQyOCkKWyAgMTc0LjA3
ODk4OV0gIHI3OjAwMDAwMDAwIHI2OmMwOGJhMjk4IHI1OjAwMDA1NzQ0IHI0OmMzNDk4ODAwClsg
IDE3NC4wNzg5OTJdIFs8YzA4NWM0OGM+XSAoZGV2aWNlX2RlbCkgZnJvbSBbPGMwODVjOGQwPl0g
KGRldmljZV91bnJlZ2lzdGVyKzB4MWMvMHgzMCkKWyAgMTc0LjA3OTAwOV0gIHIxMDpjMWFjYTA1
NCByOTpjMGU3N2IyOCByODpjMTM1NjAxOCByNzpjMTNmZGQ3YyByNjpjMDhiYTI5OCByNTowMDAw
MDAwMApbICAxNzQuMDc5MDEzXSAgcjQ6YzM0OTg4MDAKWyAgMTc0LjA3OTAxNV0gWzxjMDg1Yzhi
ND5dIChkZXZpY2VfdW5yZWdpc3RlcikgZnJvbSBbPGMwOGJhMjk0Pl0gKHNwaV91bnJlZ2lzdGVy
X2RldmljZSsweDQ0LzB4NDgpClsgIDE3NC4wNzkwMzBdICByNTowMDAwMDAwMCByNDpjMzQ5ODgw
MApbICAxNzQuMDc5MDMzXSBbPGMwOGJhMjUwPl0gKHNwaV91bnJlZ2lzdGVyX2RldmljZSkgZnJv
bSBbPGMwOGJhMmIwPl0gKF9fdW5yZWdpc3RlcisweDE4LzB4MjApClsgIDE3NC4wNzkwNDhdICBy
NTowMDAwMDAwMCByNDpjMzExYzAwMApbICAxNzQuMDc5MDUwXSBbPGMwOGJhMjk4Pl0gKF9fdW5y
ZWdpc3RlcikgZnJvbSBbPGMwODViYjkwPl0gKGRldmljZV9mb3JfZWFjaF9jaGlsZCsweDcwLzB4
YjQpClsgIDE3NC4wNzkwNjRdIFs8YzA4NWJiMjA+XSAoZGV2aWNlX2Zvcl9lYWNoX2NoaWxkKSBm
cm9tIFs8YzA4YmE3NDg+XSAoc3BpX3VucmVnaXN0ZXJfY29udHJvbGxlcisweDNjLzB4MTM0KQpb
ICAxNzQuMDc5MDgxXSAgcjY6MDAwMDAwMDAgcjU6YzMxMWMwMDAgcjQ6YzMxMWMwMDAKWyAgMTc0
LjA3OTA4M10gWzxjMDhiYTcwYz5dIChzcGlfdW5yZWdpc3Rlcl9jb250cm9sbGVyKSBmcm9tIFs8
YmYxNjg1MzQ+XSAoYmNtMjgzNV9zcGlfcmVtb3ZlKzB4MzQvMHg2YyBbc3BpX2JjbTI4MzVdKQpb
ICAxNzQuMDc5MTA0XSAgcjc6YzEzZmRkN2MgcjY6MDAwMDAwMDAgcjU6YzMxMWMwMDAgcjQ6YzMx
MWMzODAKWyAgMTc0LjA3OTEwN10gWzxiZjE2ODUwMD5dIChiY20yODM1X3NwaV9yZW1vdmUgW3Nw
aV9iY20yODM1XSkgZnJvbSBbPGJmMTY4NTg4Pl0gKGJjbTI4MzVfc3BpX3NodXRkb3duKzB4MWMv
MHgzOCBbc3BpX2JjbTI4MzVdKQpbICAxNzQuMDc5MTMwXSAgcjc6YzEzZmRkN2MgcjY6YzFhY2Ew
MTAgcjU6YzFhNzUwMTAgcjQ6YzFhY2EwMDAKWyAgMTc0LjA3OTEzMl0gWzxiZjE2ODU2Yz5dIChi
Y20yODM1X3NwaV9zaHV0ZG93biBbc3BpX2JjbTI4MzVdKSBmcm9tIFs8YzA4NjNjYTA+XSAocGxh
dGZvcm1fZHJ2X3NodXRkb3duKzB4MmMvMHgzMCkKWyAgMTc0LjA3OTE1MF0gIHI1OmMxYTc1MDEw
IHI0OmMxYWNhMDE0ClsgIDE3NC4wNzkxNTNdIFs8YzA4NjNjNzQ+XSAocGxhdGZvcm1fZHJ2X3No
dXRkb3duKSBmcm9tIFs8YzA4NWZjOTA+XSAoZGV2aWNlX3NodXRkb3duKzB4MTljLzB4MjRjKQpb
ICAxNzQuMDc5MTY0XSBbPGMwODVmYWY0Pl0gKGRldmljZV9zaHV0ZG93bikgZnJvbSBbPGMwMjQ5
ZWIwPl0gKGtlcm5lbF9yZXN0YXJ0X3ByZXBhcmUrMHg0NC8weDQ4KQpbICAxNzQuMDc5MTgzXSAg
cjEwOjAwMDAwMDU4IHI5OmMxOTAyMDAwIHI4OmZlZTFkZWFkIHI3OmMxMjBmMWNjIHI2Ojg4NTVh
NjAwIHI1OjAwMDAwMDAwClsgIDE3NC4wNzkxODZdICByNDowMDAwMDAwMApbICAxNzQuMDc5MTg5
XSBbPGMwMjQ5ZTZjPl0gKGtlcm5lbF9yZXN0YXJ0X3ByZXBhcmUpIGZyb20gWzxjMDI0OWZhMD5d
IChrZXJuZWxfcmVzdGFydCsweDFjLzB4NjApClsgIDE3NC4wNzkyMDNdIFs8YzAyNDlmODQ+XSAo
a2VybmVsX3Jlc3RhcnQpIGZyb20gWzxjMDI0YTI0ND5dIChfX2RvX3N5c19yZWJvb3QrMHgxMTQv
MHgxZjgpClsgIDE3NC4wNzkyMThdICByNTowMDAwMDAwMCByNDowMTIzNDU2NwpbICAxNzQuMDc5
MjIxXSBbPGMwMjRhMTMwPl0gKF9fZG9fc3lzX3JlYm9vdCkgZnJvbSBbPGMwMjRhMzk4Pl0gKHN5
c19yZWJvb3QrMHgxOC8weDFjKQpbICAxNzQuMDc5MjM4XSAgcjg6YzAyMDAyMDQgcjc6MDAwMDAw
NTggcjY6MDAwMDAwMDAgcjU6MDAwMDAwMDAgcjQ6MDAwMDAwMDAKWyAgMTc0LjA3OTI0MV0gWzxj
MDI0YTM4MD5dIChzeXNfcmVib290KSBmcm9tIFs8YzAyMDAwNDA+XSAocmV0X2Zhc3Rfc3lzY2Fs
bCsweDAvMHgyOCkKWyAgMTc0LjA3OTI1NF0gRXhjZXB0aW9uIHN0YWNrKDB4YzE5MDNmYTggdG8g
MHhjMTkwM2ZmMCkKWyAgMTc0LjA3OTI2MF0gM2ZhMDogICAgICAgICAgICAgICAgICAgMDAwMDAw
MDAgMDAwMDAwMDAgZmVlMWRlYWQgMjgxMjE5NjkgMDEyMzQ1NjcgODg1NWE2MDAKWyAgMTc0LjA3
OTI2N10gM2ZjMDogMDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAwNTggMDAwMDBmZmYg
YmVjODFiZTggMDAwMDAwMDAgMDA0NTZiODAKWyAgMTc0LjA3OTI3M10gM2ZlMDogMDA0NjhlM2Mg
YmVjODFiNjggMDA0NTM0YTggYjZlNGJhMzgKWyAgMTc0LjA3OTI4MF0gQ29kZTogZTUyZGUwMDQg
ZThiZDQwMDAgZTU5MDM0MTAgZTFhMDQwMDAgKGU1OTMyMDM0KQpbICAxNzQuMDc5Mjg1XSAtLS1b
IGVuZCB0cmFjZSAzM2UxMDQyMjE5ZjM4MjEwIF0tLS0KWyAgMTc0Ljg3OTQyOF0gS2VybmVsIHBh
bmljIC0gbm90IHN5bmNpbmc6ClsgIDE3NC44Nzk0MzJdIEF0dGVtcHRlZCB0byBraWxsIGluaXQh
IGV4aXRjb2RlPTB4MDAwMDAwMGIKCkZpeCB0aGlzIGJ5IG9ubHkgc2h1dHRpbmcgZG93biB0aGUg
aGFyZHdhcmUgYW5kIG5vdCB1bnJlZ2lzdGVyaW5nIHRoZSBTUEkKY29udHJvbGxlciBpbiB0aGUg
ZHJpdmVycyBzaHV0ZG93biBoYW5kbGVyLgoKRml4ZXM6IDExOGViMGU1MmViNyAoInNwaTogYmNt
MjgzNTogSW1wbGVtZW50IHNodXRkb3duIGNhbGxiYWNrIikKQ2M6IHN0YWJsZUB2Z2VyLmtlcm5l
bC5vcmcKU2lnbmVkLW9mZi1ieTogTGlubyBTYW5maWxpcHBvIDxMaW5vU2FuZmlsaXBwb0BnbXgu
ZGU+Ci0tLQoKVGhlIGZpcnN0IGF0dGVtcHQgdG8gZml4IHRoaXMgd2FzIHdpdGggYW4gZXh0cmEg
Y2hlY2sgaW4gdGhlIHRwbSBjaGlwCmRyaXZlciAoc2VlIGh0dHBzOi8vbWFyYy5pbmZvLz9sPWxp
bnV4LWludGVncml0eSZtPTE2MzEyOTcxODQxNDExOCZ3PTIpIHRvCmF2b2lkIHRoZSBOVUxMIHBv
aW50ZXIgYWNjZXNzLgpUaGVuIEphc29uIEd1bnRob3JwZSBub3RlZCB0aGF0IHRoZSByZWFsIGlz
c3VlIHdhcyB0aGUgQkNNIGRyaXZlcgp1bnJlZ2lzdGVyaW5nIHRoZSBjaGlwIGluIHRoZSBzaHV0
ZG93biBoYW5kbGVyKHNlZQpodHRwczovL21hcmMuaW5mby8/bD1saW51eC1pbnRlZ3JpdHkmbT0x
NjMxMjk3MTg0MTQxMTgmdz0yKSB3aGljaCBsZWQKbWUgdG8gdGhpcyBzb2x1dGlvbi4KClRoaXMg
cGF0Y2ggaGFzIGJlZW4gdGVzdGVkIG9uIGEgUmFzcGJlcnJ5IFBpIDUuMTAga2VybmVsIHdpdGgg
YSBTTEIgOTY3MApUUE0gY2hpcC4KCgogZHJpdmVycy9zcGkvc3BpLWJjbTI4MzUuYyB8IDIzICsr
KysrKysrKysrLS0tLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwg
MTIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9zcGkvc3BpLWJjbTI4MzUuYyBi
L2RyaXZlcnMvc3BpL3NwaS1iY20yODM1LmMKaW5kZXggNzc1YzBiZjJmOTIzLi5hMmU0ZGFmYzdk
ZmYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvc3BpL3NwaS1iY20yODM1LmMKKysrIGIvZHJpdmVycy9z
cGkvc3BpLWJjbTI4MzUuYwpAQCAtMTM5MCwxNSArMTM5MCwxMSBAQCBzdGF0aWMgaW50IGJjbTI4
MzVfc3BpX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpCiAJcmV0dXJuIGVycjsK
IH0KIAotc3RhdGljIGludCBiY20yODM1X3NwaV9yZW1vdmUoc3RydWN0IHBsYXRmb3JtX2Rldmlj
ZSAqcGRldikKK3N0YXRpYyB2b2lkIGJjbTI4MzVfc3BpX3NodXRkb3duKHN0cnVjdCBwbGF0Zm9y
bV9kZXZpY2UgKnBkZXYpCiB7CiAJc3RydWN0IHNwaV9jb250cm9sbGVyICpjdGxyID0gcGxhdGZv
cm1fZ2V0X2RydmRhdGEocGRldik7CiAJc3RydWN0IGJjbTI4MzVfc3BpICpicyA9IHNwaV9jb250
cm9sbGVyX2dldF9kZXZkYXRhKGN0bHIpOwogCi0JYmNtMjgzNV9kZWJ1Z2ZzX3JlbW92ZShicyk7
Ci0KLQlzcGlfdW5yZWdpc3Rlcl9jb250cm9sbGVyKGN0bHIpOwotCiAJYmNtMjgzNV9kbWFfcmVs
ZWFzZShjdGxyLCBicyk7CiAKIAkvKiBDbGVhciBGSUZPcywgYW5kIGRpc2FibGUgdGhlIEhXIGJs
b2NrICovCkBAIC0xNDA2LDE3ICsxNDAyLDIwIEBAIHN0YXRpYyBpbnQgYmNtMjgzNV9zcGlfcmVt
b3ZlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpCiAJCSAgIEJDTTI4MzVfU1BJX0NTX0NM
RUFSX1JYIHwgQkNNMjgzNV9TUElfQ1NfQ0xFQVJfVFgpOwogCiAJY2xrX2Rpc2FibGVfdW5wcmVw
YXJlKGJzLT5jbGspOwotCi0JcmV0dXJuIDA7CiB9CiAKLXN0YXRpYyB2b2lkIGJjbTI4MzVfc3Bp
X3NodXRkb3duKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpCitzdGF0aWMgaW50IGJjbTI4
MzVfc3BpX3JlbW92ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQogewotCWludCByZXQ7
CisJc3RydWN0IHNwaV9jb250cm9sbGVyICpjdGxyID0gcGxhdGZvcm1fZ2V0X2RydmRhdGEocGRl
dik7CisJc3RydWN0IGJjbTI4MzVfc3BpICpicyA9IHNwaV9jb250cm9sbGVyX2dldF9kZXZkYXRh
KGN0bHIpOwogCi0JcmV0ID0gYmNtMjgzNV9zcGlfcmVtb3ZlKHBkZXYpOwotCWlmIChyZXQpCi0J
CWRldl9lcnIoJnBkZXYtPmRldiwgImZhaWxlZCB0byBzaHV0ZG93blxuIik7CisJYmNtMjgzNV9k
ZWJ1Z2ZzX3JlbW92ZShicyk7CisKKwlzcGlfdW5yZWdpc3Rlcl9jb250cm9sbGVyKGN0bHIpOwor
CisJYmNtMjgzNV9zcGlfc2h1dGRvd24ocGRldik7CisKKwlyZXR1cm4gMDsKIH0KIAogc3RhdGlj
IGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgYmNtMjgzNV9zcGlfbWF0Y2hbXSA9IHsKCmJhc2Ut
Y29tbWl0OiAwNTEzZTQ2NGY5MDA3YjcwYjk2NzQwMjcxYTk0OGNhNWFiNmU3ZGQ3Ci0tIAoyLjMz
LjAKCg==
