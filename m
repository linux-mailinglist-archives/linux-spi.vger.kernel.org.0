Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0CC16BD56
	for <lists+linux-spi@lfdr.de>; Tue, 25 Feb 2020 10:33:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729306AbgBYJdR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 25 Feb 2020 04:33:17 -0500
Received: from de-out1.bosch-org.com ([139.15.230.186]:49508 "EHLO
        de-out1.bosch-org.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727114AbgBYJdR (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 25 Feb 2020 04:33:17 -0500
X-Greylist: delayed 100007 seconds by postgrey-1.27 at vger.kernel.org; Tue, 25 Feb 2020 04:33:13 EST
Received: from fe0vm1649.rbesz01.com (unknown [139.15.230.188])
        by fe0vms0186.rbdmz01.com (Postfix) with ESMTPS id 48RYdM2T2Hz1XLFrl;
        Tue, 25 Feb 2020 10:33:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=de.bosch.com;
        s=key3-intmail; t=1582623191;
        bh=WQzLc8ik3inJZMK5lCJ26mkvaboYo4pT75ge25HpFt4=; l=10;
        h=Subject:From:From:Reply-To:Sender;
        b=U1ERJ/S2r91Id0F5sgo60BDJXyoxBx6MgP93B4JlySLPvqOn8QfGFDe3QjKbJJ/54
         Vctb/Q5pJMCgaWGoxBdD1M1/m0iyH1k3ZaQViyLLOg3NyW6+3uZ7wY1ircIa+vRFXv
         s5aEsGGqJuanrGXtV/2+b8rPE+cOX6N1mz5QFUg8=
Received: from fe0vm1740.rbesz01.com (unknown [10.58.172.176])
        by fe0vm1649.rbesz01.com (Postfix) with ESMTPS id 48RYdM2CG1z1xD;
        Tue, 25 Feb 2020 10:33:11 +0100 (CET)
X-AuditID: 0a3aad14-a97ff700000047f7-00-5e54e9d61bdb
Received: from si0vm1949.rbesz01.com ( [10.58.173.29])
        (using TLS with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by fe0vm1740.rbesz01.com (SMG Outbound) with SMTP id 04.0F.18423.7D9E45E5; Tue, 25 Feb 2020 10:33:11 +0100 (CET)
Received: from FE-HUB2000.de.bosch.com (fe-hub2000.de.bosch.com [10.4.103.109])
        by si0vm1949.rbesz01.com (Postfix) with ESMTPS id 48RYdL6W4Fz6CjZNt;
        Tue, 25 Feb 2020 10:33:10 +0100 (CET)
Received: from [10.34.222.178] (10.34.222.178) by FE-HUB2000.de.bosch.com
 (10.4.103.109) with Microsoft SMTP Server id 15.1.1847.3; Tue, 25 Feb 2020
 10:33:10 +0100
Subject: Re: [PATCH RFC 2/2] memory: add Renesas RPC-IF driver
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mason Yang <masonccyang@mxic.com.tw>,
        <linux-spi@vger.kernel.org>,
        Chris Brandt <chris.brandt@renesas.com>,
        <linux-renesas-soc@vger.kernel.org>
References: <cb7022c9-0059-4eb2-7910-aab42124fa1c@cogentembedded.com>
 <4db876ed-1ccc-e3be-311d-30cd52f40259@cogentembedded.com>
 <5760bcdb-e44b-6f18-7262-9526684e5780@de.bosch.com>
 <5603f393-554d-e2a8-c2d8-6bafc20f4169@cogentembedded.com>
 <cba1e2ec-4896-23ef-ef7b-0f80d4310127@de.bosch.com>
 <ec545462-54ed-9e23-049e-1807d24ec084@cogentembedded.com>
From:   "Behme Dirk (CM/ESO2)" <dirk.behme@de.bosch.com>
Message-ID: <3a182ac7-8d41-cdc7-2b87-7c503f68a426@de.bosch.com>
Date:   Tue, 25 Feb 2020 10:33:10 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <ec545462-54ed-9e23-049e-1807d24ec084@cogentembedded.com>
Content-Type: multipart/mixed;
        boundary="------------A266F512431D32413D4D0BF3"
Content-Language: en-US
X-Originating-IP: [10.34.222.178]
X-Brightmail-Tracker: H4sIAAAAAAAAA21TfUwTdxjmd73Sa8e560HltSKERrLEOCzqtkYX3D9zTZZFM82WMMGVcaUd
        0GJbnLAv2AJiRT6GgBQsG6uToI2EzYE6Hal1sYwBUzYYH4KEDSiIHwRlImN3XLFNtn/ePL/n
        fZ/n/bgcIaAnCDmhN1gYk0GTrgiW4JJtznXP907uTVKWFSBVXdUxXFXn7hSqbl6sDVadn5zB
        VHn3/xCpjvw0hVRDt67jqo7GftErhHqkYglTdzucweqSRaX6YUcZrp5tjtwtTJC8nMKk6w8y
        pk3x70p0BdZiLLPhjUMPB4rxXOTZaUViAqitMHmuJdiKJARNVWHw26MSEf+4gqD47je+x2kE
        3950CDhJKBUP0/kFQg6HUSoYyqvHuSIBtYTg3oVCxCv+xOBc07CIqwqmXoQphw1xmKR2wI2G
        XIzDOBUDVV1Ty1hGJUJfdSHG10jBUz3GuhKEmNoJLQMxHC2gdsPtvxpEPA6H/rE6jN8hGs4P
        HReVIqktQG0LkNgCJDxWQXVdF+JxFLTcqRXwOBM67k0LeRwNx4/e9mnfh/HefB8+AP0FV7H/
        1nwCRZcLhV+iZxqRTMsoD2bEvbRVGWtKZsw5yrjY94wZzYj/ymGtaMGldSGMQC70AoEpZCQa
        2ZtEr0o2pmTrNGbdflNWOmNWyMlPp48k0qFPaXNWcobebNYbDS60nu042nSmG8lxg9HAKMLI
        19GbSTSZosnOYUxG3sKF1hK4IpxMJXbto6lUjYVJY5hMxrSS3U4QCiAHJ9jmUhOTyhzS6tMt
        K2nFOhIFBQXRqwMzgSNghNiFthAhbO+iUdaCNGdqMsz6VJ98DS+nV1i/tB29Q0w7HfUC4s5y
        dJ88xcaCW0NsPMxFenkneTh5NoP1pTgHXZbh6WTyCNJOs8vKAhJ+dy/qQwRShJKJ3F4h7C/m
        nwnIXO6kUh/pF212sBrqAgn2z0zgHfYgWLg8iMDeOoegz1sqgB7nrwKwdZ3EwfNzMw7uS5VC
        6J9vEsK1szMs8hSJ4MZFmwjmBttEUP5DOQH2+W4xjD6YEUPN1w/EUHuqNASuVC6EQFPNExLm
        R75/FrxL5RS42gqlMDhbJoW5S600uCt6aZj80R0GJ1pPA8x81boWPD31EZD/S0mkl703xt77
        zJM93L0tGsv/3NvH+peT5yKX0ij7Dotoe63zat7m3z/oxXQnNiZEz/2zuLhqg9rafm04ZmFf
        1I7OdkNao7hyPOtj5+ED9mNbsJQP3x5fQ6n/nrVWrk54HCm3tCTj15/7oqYUbd//uaUHv5vz
        1key+qNj8/clVn3N+j3batI3PtIujby6Keqx1ikYSMuumDDOxMbnKnCzThO3QWAya/4FVm96
        CPsEAAA=
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

--------------A266F512431D32413D4D0BF3
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit

On 24.02.2020 19:59, Sergei Shtylyov wrote:
>>>>   From d72b805cc461ab1e9747c973e9be84e7abb8f828 Mon Sep 17 00:00:00 2001
>>>> From: Dirk Behme <dirk.behme@de.bosch.com>
>>>> Date: Tue, 4 Feb 2020 08:39:31 +0100
>>>> Subject: [PATCH] memory: renesas-rpc-if: Correct the STRTIM and some other
>>>>    clean up
>>>>
>>>> This is required to make the driver work correctly in my M3 environment.
>>>>
>>>> Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
>>>> ---
>>>>    drivers/memory/renesas-rpc-if.c | 42 ++++++++++++++++++++-------------
>>>>    1 file changed, 25 insertions(+), 17 deletions(-)
>>>>
>>>> diff --git a/drivers/memory/renesas-rpc-if.c b/drivers/memory/renesas-rpc-if.c
>>>> index 04be92b64bfa..f4356b066384 100644
>>>> --- a/drivers/memory/renesas-rpc-if.c
>>>> +++ b/drivers/memory/renesas-rpc-if.c
>>> [...]
>>>> @@ -513,19 +525,15 @@ ssize_t rpcif_dirmap_read(struct rpcif *rpc, u64 offs, size_t len, void *buf)
>>>>        pm_runtime_get_sync(rpc->dev);
>>>>
>>>>        regmap_update_bits(rpc->regmap, RPCIF_CMNCR, RPCIF_CMNCR_MD, 0);
>>>> -    regmap_write(rpc->regmap, RPCIF_DRCR,
>>>> -             RPCIF_DRCR_RBURST(32) | RPCIF_DRCR_RBE);
>>>> -    regmap_write(rpc->regmap, RPCIF_DRCMR, rpc->command);
>>>> -    regmap_write(rpc->regmap, RPCIF_DREAR,
>>>> -             RPCIF_DREAR_EAV(offs >> 25) | RPCIF_DREAR_EAC(1));
>>>> -    regmap_write(rpc->regmap, RPCIF_DROPR, rpc->option);
>>>> -    regmap_write(rpc->regmap, RPCIF_DRENR,
>>>> -             rpc->enable & ~RPCIF_SMENR_SPIDE(0xF));
>>>> -    regmap_write(rpc->regmap, RPCIF_DRDMCR, rpc->dummy);
>>>> -    regmap_write(rpc->regmap, RPCIF_DRDRENR, rpc->ddr);
>>>
>>>      The driver somehow works only with this left in place (with 2 bytes eaten
>>> as before), otherwise all the flash reads all 0xff (via dirmap).
>>
>>
>> Do you boot from hyperflash?
> 
>     No, I have arewto say 'cpld write 30 1' in U-Boot before a boot a kernel.
> Normally, the V3x Starter Kit boards are wired for the QSPI flash chips.
> 
>> The system I'm using for testing boots from hyperflash. So most probably all registers
>> I don't touch in the driver are put into a reasonable state by the boot code, already.
>> If you don't boot from hyperflash, that at least would explain our different behavior.
> 
>     Yes. Mind dumping the registers and sending to me?


Using the attached debug patch 
(0001-memory-renesas-rpc-if-DEBUG-Dump-register-content.patch) on a 
r8a7796 system booting from Hyperflash with above register dropping 
reverted (i.e. including touching these registers) I get

Before:
RPCIF_DRCR:    0x00000000
RPCIF_DRCMR:   0x00a00000
RPCIF_DREAR:   0x00000000
RPCIF_DROPR:   0x00000000
RPCIF_DRENR:   0xa222d400
RPCIF_DRDMCR:  0x0000000e
RPCIF_DRDRENR: 0x00005101

After:
RPCIF_DRCR:    0x001f0100
RPCIF_DRCMR:   0x00a00000
RPCIF_DREAR:   0x00010001
RPCIF_DROPR:   0x00000000
RPCIF_DRENR:   0xa202d400
RPCIF_DRDMCR:  0x0000000e
RPCIF_DRDRENR: 0x00005101

Comparing that, just 3 registers are different between my working 
version ("Before") and the version which shows the 2-byte offset 
("After"): RPCIF_DRCR, RPCIF_DREAR and RPCIF_DRENR. With try & error, at 
least in my setup, I was able to reduce this to just RPCIF_DRCR. 
Dropping the burst mode I was able to 'fix' the two byte offset issue.

Do you like to give the attached 
0001-memory-renesas-rpc-if-Don-t-use-burst-mode-on-read.patch a try in 
your setup?

Best regards

Dirk


--------------A266F512431D32413D4D0BF3
Content-Type: text/plain; charset="UTF-8";
	name="0001-memory-renesas-rpc-if-DEBUG-Dump-register-content.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="0001-memory-renesas-rpc-if-DEBUG-Dump-register-content.patch"

RnJvbSA4OTQyYzc3MWY4ZWE4OTU3YTE0ZmM2ZjZlNDQ0MzY3NWM0YjZiMjYwIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBEaXJrIEJlaG1lIDxkaXJrLmJlaG1lQGRlLmJvc2No
LmNvbT4KRGF0ZTogVHVlLCAyNSBGZWIgMjAyMCAwNzo1NzoxMiArMDEwMApTdWJqZWN0OiBb
UEFUQ0hdIG1lbW9yeTogcmVuZXNhcy1ycGMtaWY6IERFQlVHOiBEdW1wIHJlZ2lzdGVyIGNv
bnRlbnQKCkR1bXAgcmVnaXN0ZXIgY29udGVudCBiZWZvcmUgYW5kIGFmdGVyIGJlaW5nIG1v
ZGlmaWVkIGJ5IHRoZSBkcml2ZXIuCgpTaWduZWQtb2ZmLWJ5OiBEaXJrIEJlaG1lIDxkaXJr
LmJlaG1lQGRlLmJvc2NoLmNvbT4KLS0tCiBkcml2ZXJzL21lbW9yeS9yZW5lc2FzLXJwYy1p
Zi5jIHwgMjEgKysrKysrKysrKysrKysrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgMjEgaW5z
ZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWVtb3J5L3JlbmVzYXMtcnBjLWlm
LmMgYi9kcml2ZXJzL21lbW9yeS9yZW5lc2FzLXJwYy1pZi5jCmluZGV4IDQ4NTNlN2Y3ODk4
NS4uNDQ4NmRlMGI1MTdiIDEwMDY0NAotLS0gYS9kcml2ZXJzL21lbW9yeS9yZW5lc2FzLXJw
Yy1pZi5jCisrKyBiL2RyaXZlcnMvbWVtb3J5L3JlbmVzYXMtcnBjLWlmLmMKQEAgLTUxNywx
MiArNTE3LDIzIEBAIHNzaXplX3QgcnBjaWZfZGlybWFwX3JlYWQoc3RydWN0IHJwY2lmICpy
cGMsIHU2NCBvZmZzLCBzaXplX3QgbGVuLCB2b2lkICpidWYpCiB7CiAJbG9mZl90IGZyb20g
PSBvZmZzICYgKFJQQ0lGX0RJUk1BUF9TSVpFIC0gMSk7CiAJc2l6ZV90IHNpemUgPSBSUENJ
Rl9ESVJNQVBfU0laRSAtIGZyb207CisJdTMyIGRhdGE7CiAKIAlpZiAobGVuID4gc2l6ZSkK
IAkJbGVuID0gc2l6ZTsKIAogCXBtX3J1bnRpbWVfZ2V0X3N5bmMocnBjLT5kZXYpOwogCisJ
cHJfZXJyKCJCZWZvcmU6XG4iKTsKKwlyZWdtYXBfcmVhZChycGMtPnJlZ21hcCwgUlBDSUZf
Q01OQ1IsICZkYXRhKTsgICBwcl9lcnIoIlJQQ0lGX0NNTkNSOiAgIDB4JTA4eFxuIiwgZGF0
YSk7CisJcmVnbWFwX3JlYWQocnBjLT5yZWdtYXAsIFJQQ0lGX0RSQ1IsICZkYXRhKTsgICAg
cHJfZXJyKCJSUENJRl9EUkNSOiAgICAweCUwOHhcbiIsIGRhdGEpOworCXJlZ21hcF9yZWFk
KHJwYy0+cmVnbWFwLCBSUENJRl9EUkNNUiwgJmRhdGEpOyAgIHByX2VycigiUlBDSUZfRFJD
TVI6ICAgMHglMDh4XG4iLCBkYXRhKTsKKwlyZWdtYXBfcmVhZChycGMtPnJlZ21hcCwgUlBD
SUZfRFJFQVIsICZkYXRhKTsgICBwcl9lcnIoIlJQQ0lGX0RSRUFSOiAgIDB4JTA4eFxuIiwg
ZGF0YSk7CisJcmVnbWFwX3JlYWQocnBjLT5yZWdtYXAsIFJQQ0lGX0RST1BSLCAmZGF0YSk7
ICAgcHJfZXJyKCJSUENJRl9EUk9QUjogICAweCUwOHhcbiIsIGRhdGEpOworCXJlZ21hcF9y
ZWFkKHJwYy0+cmVnbWFwLCBSUENJRl9EUkVOUiwgJmRhdGEpOyAgIHByX2VycigiUlBDSUZf
RFJFTlI6ICAgMHglMDh4XG4iLCBkYXRhKTsKKwlyZWdtYXBfcmVhZChycGMtPnJlZ21hcCwg
UlBDSUZfRFJETUNSLCAmZGF0YSk7ICBwcl9lcnIoIlJQQ0lGX0RSRE1DUjogIDB4JTA4eFxu
IiwgZGF0YSk7CisJcmVnbWFwX3JlYWQocnBjLT5yZWdtYXAsIFJQQ0lGX0RSRFJFTlIsICZk
YXRhKTsgcHJfZXJyKCJSUENJRl9EUkRSRU5SOiAweCUwOHhcbiIsIGRhdGEpOworCiAJcmVn
bWFwX3VwZGF0ZV9iaXRzKHJwYy0+cmVnbWFwLCBSUENJRl9DTU5DUiwgUlBDSUZfQ01OQ1Jf
TUQsIDApOwogCXJlZ21hcF93cml0ZShycGMtPnJlZ21hcCwgUlBDSUZfRFJDUiwKIAkJICAg
ICBSUENJRl9EUkNSX1JCVVJTVCgzMikgfCBSUENJRl9EUkNSX1JCRSk7CkBAIC01MzUsNiAr
NTQ2LDE2IEBAIHNzaXplX3QgcnBjaWZfZGlybWFwX3JlYWQoc3RydWN0IHJwY2lmICpycGMs
IHU2NCBvZmZzLCBzaXplX3QgbGVuLCB2b2lkICpidWYpCiAJcmVnbWFwX3dyaXRlKHJwYy0+
cmVnbWFwLCBSUENJRl9EUkRNQ1IsIHJwYy0+ZHVtbXkpOwogCXJlZ21hcF93cml0ZShycGMt
PnJlZ21hcCwgUlBDSUZfRFJEUkVOUiwgcnBjLT5kZHIpOwogCisJcHJfZXJyKCJBZnRlcjpc
biIpOworCXJlZ21hcF9yZWFkKHJwYy0+cmVnbWFwLCBSUENJRl9DTU5DUiwgJmRhdGEpOyAg
IHByX2VycigiUlBDSUZfQ01OQ1I6ICAgMHglMDh4XG4iLCBkYXRhKTsKKwlyZWdtYXBfcmVh
ZChycGMtPnJlZ21hcCwgUlBDSUZfRFJDUiwgJmRhdGEpOyAgICBwcl9lcnIoIlJQQ0lGX0RS
Q1I6ICAgIDB4JTA4eFxuIiwgZGF0YSk7CisJcmVnbWFwX3JlYWQocnBjLT5yZWdtYXAsIFJQ
Q0lGX0RSQ01SLCAmZGF0YSk7ICAgcHJfZXJyKCJSUENJRl9EUkNNUjogICAweCUwOHhcbiIs
IGRhdGEpOworCXJlZ21hcF9yZWFkKHJwYy0+cmVnbWFwLCBSUENJRl9EUkVBUiwgJmRhdGEp
OyAgIHByX2VycigiUlBDSUZfRFJFQVI6ICAgMHglMDh4XG4iLCBkYXRhKTsKKwlyZWdtYXBf
cmVhZChycGMtPnJlZ21hcCwgUlBDSUZfRFJPUFIsICZkYXRhKTsgICBwcl9lcnIoIlJQQ0lG
X0RST1BSOiAgIDB4JTA4eFxuIiwgZGF0YSk7CisJcmVnbWFwX3JlYWQocnBjLT5yZWdtYXAs
IFJQQ0lGX0RSRU5SLCAmZGF0YSk7ICAgcHJfZXJyKCJSUENJRl9EUkVOUjogICAweCUwOHhc
biIsIGRhdGEpOworCXJlZ21hcF9yZWFkKHJwYy0+cmVnbWFwLCBSUENJRl9EUkRNQ1IsICZk
YXRhKTsgIHByX2VycigiUlBDSUZfRFJETUNSOiAgMHglMDh4XG4iLCBkYXRhKTsKKwlyZWdt
YXBfcmVhZChycGMtPnJlZ21hcCwgUlBDSUZfRFJEUkVOUiwgJmRhdGEpOyBwcl9lcnIoIlJQ
Q0lGX0RSRFJFTlI6IDB4JTA4eFxuIiwgZGF0YSk7CisKIAltZW1jcHlfZnJvbWlvKGJ1Ziwg
cnBjLT5kaXJtYXAgKyBmcm9tLCBsZW4pOwogCiAJcG1fcnVudGltZV9wdXQocnBjLT5kZXYp
OwotLSAKMi4yMC4wCgo=
--------------A266F512431D32413D4D0BF3
Content-Type: text/plain; charset="UTF-8";
	name="0001-memory-renesas-rpc-if-Don-t-use-burst-mode-on-read.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename*0="0001-memory-renesas-rpc-if-Don-t-use-burst-mode-on-read.patc";
	filename*1="h"

RnJvbSAxODlkMzBhOGU5NjcwZjFhNWExZTlkM2IyNTdmMTRiN2RmN2JjMTcyIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBEaXJrIEJlaG1lIDxkaXJrLmJlaG1lQGRlLmJvc2No
LmNvbT4KRGF0ZTogVHVlLCAyNSBGZWIgMjAyMCAwODo0MTowNiArMDEwMApTdWJqZWN0OiBb
UEFUQ0hdIG1lbW9yeTogcmVuZXNhcy1ycGMtaWY6IERvbid0IHVzZSBidXJzdCBtb2RlIG9u
IHJlYWQKClRlc3Rpbmcgc2hvd3MgdGhhdCBlbmFibGluZyB0aGUgYnVyc3QgbW9kZSByZXN1
bHRzIGluIGEgIjItYnl0ZSBvZmZzZXQiCmluIHJlYWQgZGF0YS4gRHJvcHBpbmcgdGhlIGJ1
cnN0IG1vZGUgc2VlbXMgdG8gZml4IHRoaXMuCgpTaWduZWQtb2ZmLWJ5OiBEaXJrIEJlaG1l
IDxkaXJrLmJlaG1lQGRlLmJvc2NoLmNvbT4KLS0tCiBkcml2ZXJzL21lbW9yeS9yZW5lc2Fz
LXJwYy1pZi5jIHwgMyArLS0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMiBk
ZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL21lbW9yeS9yZW5lc2FzLXJwYy1p
Zi5jIGIvZHJpdmVycy9tZW1vcnkvcmVuZXNhcy1ycGMtaWYuYwppbmRleCA0ODUzZTdmNzg5
ODUuLjJkNzdlY2E3YWFhNSAxMDA2NDQKLS0tIGEvZHJpdmVycy9tZW1vcnkvcmVuZXNhcy1y
cGMtaWYuYworKysgYi9kcml2ZXJzL21lbW9yeS9yZW5lc2FzLXJwYy1pZi5jCkBAIC01MjQs
OCArNTI0LDcgQEAgc3NpemVfdCBycGNpZl9kaXJtYXBfcmVhZChzdHJ1Y3QgcnBjaWYgKnJw
YywgdTY0IG9mZnMsIHNpemVfdCBsZW4sIHZvaWQgKmJ1ZikKIAlwbV9ydW50aW1lX2dldF9z
eW5jKHJwYy0+ZGV2KTsKIAogCXJlZ21hcF91cGRhdGVfYml0cyhycGMtPnJlZ21hcCwgUlBD
SUZfQ01OQ1IsIFJQQ0lGX0NNTkNSX01ELCAwKTsKLQlyZWdtYXBfd3JpdGUocnBjLT5yZWdt
YXAsIFJQQ0lGX0RSQ1IsCi0JCSAgICAgUlBDSUZfRFJDUl9SQlVSU1QoMzIpIHwgUlBDSUZf
RFJDUl9SQkUpOworCXJlZ21hcF93cml0ZShycGMtPnJlZ21hcCwgUlBDSUZfRFJDUiwgMCk7
CiAJcmVnbWFwX3dyaXRlKHJwYy0+cmVnbWFwLCBSUENJRl9EUkNNUiwgcnBjLT5jb21tYW5k
KTsKIAlyZWdtYXBfd3JpdGUocnBjLT5yZWdtYXAsIFJQQ0lGX0RSRUFSLAogCQkgICAgIFJQ
Q0lGX0RSRUFSX0VBVihvZmZzID4+IDI1KSB8IFJQQ0lGX0RSRUFSX0VBQygxKSk7Ci0tIAoy
LjIwLjAKCg==
--------------A266F512431D32413D4D0BF3--
