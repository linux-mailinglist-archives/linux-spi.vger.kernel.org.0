Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 936EE169DDD
	for <lists+linux-spi@lfdr.de>; Mon, 24 Feb 2020 06:46:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgBXFqa (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 24 Feb 2020 00:46:30 -0500
Received: from de-deferred1.bosch-org.com ([139.15.180.216]:53256 "EHLO
        de-deferred1.bosch-org.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725809AbgBXFq3 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 24 Feb 2020 00:46:29 -0500
Received: from de-out1.bosch-org.com (unknown [139.15.180.215])
        by si0vms0224.rbdmz01.com (Postfix) with ESMTPS id 48QrfB5klpzH1kl;
        Mon, 24 Feb 2020 06:46:26 +0100 (CET)
Received: from si0vm1947.rbesz01.com (unknown [139.15.230.188])
        by fe0vms0187.rbdmz01.com (Postfix) with ESMTPS id 48Qrf86J2Nz1XLDR9;
        Mon, 24 Feb 2020 06:46:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=de.bosch.com;
        s=key3-intmail; t=1582523184;
        bh=4zzSi3oc1nybh5U0A3SoXL3ulL+B5W3XOqaTm7/syr0=; l=10;
        h=Subject:From:From:Reply-To:Sender;
        b=ZfWWeksKNRnr86A3lzJ7JJHOJC3ryvp5XA42XzY4IIQdwaAn6XgQ2kY6p2rFVMmDs
         SScayvh93C2+yR66H/IfOTeZDc/jJundQnssskudrviYdZd0c09s1e8VgValEyRjkq
         jSO4nNndmLWSmeR3F2P575gvFPNGxvZ4D7nTi8U4=
Received: from si0vm4642.rbesz01.com (unknown [10.58.172.176])
        by si0vm1947.rbesz01.com (Postfix) with ESMTPS id 48Qrf85qcjz6CjR3T;
        Mon, 24 Feb 2020 06:46:24 +0100 (CET)
X-AuditID: 0a3aad12-d5bff70000002fbb-be-5e5363301aa2
Received: from si0vm1950.rbesz01.com ( [10.58.173.29])
        (using TLS with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by si0vm4642.rbesz01.com (SMG Outbound) with SMTP id 1D.73.12219.033635E5; Mon, 24 Feb 2020 06:46:24 +0100 (CET)
Received: from FE-HUB2000.de.bosch.com (unknown [10.4.103.109])
        by si0vm1950.rbesz01.com (Postfix) with ESMTPS id 48Qrf84MHrzW7C;
        Mon, 24 Feb 2020 06:46:24 +0100 (CET)
Received: from [10.34.222.178] (10.34.222.178) by FE-HUB2000.de.bosch.com
 (10.4.103.109) with Microsoft SMTP Server id 15.1.1847.3; Mon, 24 Feb 2020
 06:46:23 +0100
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
From:   "Behme Dirk (CM/ESO2)" <dirk.behme@de.bosch.com>
Message-ID: <cba1e2ec-4896-23ef-ef7b-0f80d4310127@de.bosch.com>
Date:   Mon, 24 Feb 2020 06:46:23 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <5603f393-554d-e2a8-c2d8-6bafc20f4169@cogentembedded.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.34.222.178]
X-Brightmail-Tracker: H4sIAAAAAAAAA22SfUwTdxjH+7te22vXM9ejHc+qdePYskUdlo6ZZipbsmUhmcsM7C8nzBYO
        2lha0itM3ZIVIwxMFiCxdFQCE7qXiGyCwtDqwApmODOn01VeuldMBjjElW7LWtLdWbD9w/+e
        fL/P5/n+nueOENMxmZaw2l2s026yMVIFrnihV/esvrSoRP9l8wZjp/dD3Ng5+p3E+MPZdqlx
        YHYBM9bem5AZGy/NI2P4p29w45Xjk7KXiIJfPAms4Ht/r7SgaVlf8PeVFrwg0r9+p2SXYlsZ
        a7PWsM7N+XsUlsDsMl41APuiv/dI3SiUcRjJCaDy4PT4oPgwUhA05cWg19eJCQZN9SC4fcmQ
        ND5DEL42hQQjg8qHO3X1EqFWU0YI13bhQpOYSiBYPNOAkkQEweD181KhS0ptgXm/jzcIgqRe
        hF/jWwUZp56CsYFuXKg1VDHcamu4n0xSKhhvm7mvy6lXYSwaEAu1mA9r67yKknUmTM4kXyqm
        Hoev/mwXJ9fJgoHwEVkzon1po3xpuC8N96XhHyP8ONJwVn1NZd6WPEOO08xyB/S5OaWOyn6U
        /Dj0EOr7sTyIMAIF0fMExmjI0l1FJfQas6Nsv8XEWd52VttYjtGS799pLKYzHshctbnSynFW
        hz2IgBAzavI1VFhCk2Wm/QdYpyOJBdFaAmcyyQrijd00VWFysXtZtop1rrpbCYIBcqOZD1Q5
        2Qp2X7nV5lq1GR2JRCIR/Wi6kx6LEfIgeo5Q8tlZxfwIkqsyVXLWihX8sSROr6op9DJ6mZi4
        6+8S07jdYWe1meR7e3ieEjot1fYHL9CuIztofilNmpGaModuIQIxGeQFEw8r+b8+lQ2kWziX
        akVMQQY/z1CHlNBx0AlzP48jiJ2fRtAxFEVwMjSMwfi3/ThM/ntSAmMnFiRw/axPBtHpERkM
        X2gl4Gj3X3Jo/6RZCV+3xpQwHWlRQTQwREP08wANs8Ojakj0RdRw5tCgFhaODa2FU+4TOuiK
        fqGDYc8/WVDnaWKg5/LU0xC8MfEMxAP/bYSG0bubYKlxcRM0eaZywHc1nDPH3xXj75pN7BTu
        6jK5HnLXFTW1nNaNjpFPNtZitlfOxd9R765V5B35I7Qjdu1mnWxpb7339fou30d47sWa7hKb
        +a35pTHFp0/ci5zz2Yzv5i8OxkZur/OykgbLREsoM/tionm5fX344ObS1sQp0ZrC6tkd8TdV
        bdt/2+Y1aD54JDRzwy0Ceez0TY9hROfPzi4fnSwq7IszOGcx5W4QOznT/zpakt6OBAAA
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 22.02.2020 21:42, Sergei Shtylyov wrote:
> On 02/10/2020 01:21 PM, Behme Dirk (CM/ESO2) wrote:
> 
>>> Add the memory driver for Renesas RPC-IF which registers either SPI or
>>> HyperFLash device depending on the contents of the device tree subnode.
>>> It also provides the absract "back end" device APIs that can be used by
>>> the "front end" SPI/MTD drivers to talk to the real hardware.
>>>
>>> Based on the original patch by Mason Yang <masonccyang@mxic.com.tw>.
>>>
>>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>>
>>
>> FYI, please find below [1] the changes I did locally on this driver. It seems to read & write successfully on my custom M3 (R8A7796) device, now.
> 
>     Not for me...
>     BTW, your patch had whitespace ruined, I had to apply it by hand, you'd better
> attach the patches, not paste. :-/


Ok. There are other mailing lists complaining about attachments ;)

Even better, maybe we should put what we have so far publicly anywhere, 
e.g. github.


>> Best regards
>>
>> Dirk
>>
>> [1]
>>
>>  From d72b805cc461ab1e9747c973e9be84e7abb8f828 Mon Sep 17 00:00:00 2001
>> From: Dirk Behme <dirk.behme@de.bosch.com>
>> Date: Tue, 4 Feb 2020 08:39:31 +0100
>> Subject: [PATCH] memory: renesas-rpc-if: Correct the STRTIM and some other
>>   clean up
>>
>> This is required to make the driver work correctly in my M3 environment.
>>
>> Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
>> ---
>>   drivers/memory/renesas-rpc-if.c | 42 ++++++++++++++++++++-------------
>>   1 file changed, 25 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/memory/renesas-rpc-if.c b/drivers/memory/renesas-rpc-if.c
>> index 04be92b64bfa..f4356b066384 100644
>> --- a/drivers/memory/renesas-rpc-if.c
>> +++ b/drivers/memory/renesas-rpc-if.c
> [...]
>> @@ -513,19 +525,15 @@ ssize_t rpcif_dirmap_read(struct rpcif *rpc, u64 offs, size_t len, void *buf)
>>       pm_runtime_get_sync(rpc->dev);
>>
>>       regmap_update_bits(rpc->regmap, RPCIF_CMNCR, RPCIF_CMNCR_MD, 0);
>> -    regmap_write(rpc->regmap, RPCIF_DRCR,
>> -             RPCIF_DRCR_RBURST(32) | RPCIF_DRCR_RBE);
>> -    regmap_write(rpc->regmap, RPCIF_DRCMR, rpc->command);
>> -    regmap_write(rpc->regmap, RPCIF_DREAR,
>> -             RPCIF_DREAR_EAV(offs >> 25) | RPCIF_DREAR_EAC(1));
>> -    regmap_write(rpc->regmap, RPCIF_DROPR, rpc->option);
>> -    regmap_write(rpc->regmap, RPCIF_DRENR,
>> -             rpc->enable & ~RPCIF_SMENR_SPIDE(0xF));
>> -    regmap_write(rpc->regmap, RPCIF_DRDMCR, rpc->dummy);
>> -    regmap_write(rpc->regmap, RPCIF_DRDRENR, rpc->ddr);
> 
>     The driver somehow works only with this left in place (with 2 bytes eaten
> as before), otherwise all the flash reads all 0xff (via dirmap).


Do you boot from hyperflash?

The system I'm using for testing boots from hyperflash. So most probably 
all registers I don't touch in the driver are put into a reasonable 
state by the boot code, already. If you don't boot from hyperflash, that 
at least would explain our different behavior.

Best regards

Dirk

