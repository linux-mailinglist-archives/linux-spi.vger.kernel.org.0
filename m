Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16C6916FB5C
	for <lists+linux-spi@lfdr.de>; Wed, 26 Feb 2020 10:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbgBZJyh (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 26 Feb 2020 04:54:37 -0500
Received: from de-out1.bosch-org.com ([139.15.230.186]:44712 "EHLO
        de-out1.bosch-org.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbgBZJyh (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 26 Feb 2020 04:54:37 -0500
Received: from fe0vm1649.rbesz01.com (unknown [139.15.230.188])
        by si0vms0216.rbdmz01.com (Postfix) with ESMTPS id 48SB3X123bz1XLm4S;
        Wed, 26 Feb 2020 10:54:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=de.bosch.com;
        s=key3-intmail; t=1582710872;
        bh=hXz+af7JZXSKV0aRQtsoM6BXQxHvMRCVT482aSFP6FE=; l=10;
        h=Subject:From:From:Reply-To:Sender;
        b=Wyh3egjvY7BV0xbK8IrAWt4/uaPssBIg7BwaBV90eYwxWiGTlfsEsAK09jLQw3j0E
         9AEJgw1WDbtCDIfdpopOWat+64qOjQxi1C6MuG2k9X1UO05vpd1XN8hzjf7lfxvpkv
         ZMhVsehL/OUF2hvM6YtgUtXJCkadvZhad71wZI5I=
Received: from si0vm02576.rbesz01.com (unknown [10.58.172.176])
        by fe0vm1649.rbesz01.com (Postfix) with ESMTPS id 48SB3X0nH8z1N6;
        Wed, 26 Feb 2020 10:54:32 +0100 (CET)
X-AuditID: 0a3aad0d-f41ff700000047b3-51-5e564057eee6
Received: from fe0vm1652.rbesz01.com ( [10.58.173.29])
        (using TLS with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by si0vm02576.rbesz01.com (SMG Outbound) with SMTP id 95.32.18355.750465E5; Wed, 26 Feb 2020 10:54:31 +0100 (CET)
Received: from FE-HUB2000.de.bosch.com (unknown [10.4.103.109])
        by fe0vm1652.rbesz01.com (Postfix) with ESMTPS id 48SB3W64x0zB14;
        Wed, 26 Feb 2020 10:54:31 +0100 (CET)
Received: from [10.34.222.178] (10.34.222.178) by FE-HUB2000.de.bosch.com
 (10.4.103.109) with Microsoft SMTP Server id 15.1.1847.3; Wed, 26 Feb 2020
 10:54:31 +0100
Subject: Re: [PATCH RFC 2/2] memory: add Renesas RPC-IF driver
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mason Yang <masonccyang@mxic.com.tw>,
        <linux-spi@vger.kernel.org>,
        Chris Brandt <chris.brandt@renesas.com>,
        <linux-renesas-soc@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
References: <cb7022c9-0059-4eb2-7910-aab42124fa1c@cogentembedded.com>
 <4db876ed-1ccc-e3be-311d-30cd52f40259@cogentembedded.com>
 <5760bcdb-e44b-6f18-7262-9526684e5780@de.bosch.com>
 <5603f393-554d-e2a8-c2d8-6bafc20f4169@cogentembedded.com>
 <cba1e2ec-4896-23ef-ef7b-0f80d4310127@de.bosch.com>
 <ec545462-54ed-9e23-049e-1807d24ec084@cogentembedded.com>
 <3a182ac7-8d41-cdc7-2b87-7c503f68a426@de.bosch.com>
 <f21a9444-9541-6558-f5f5-ca0b733768ff@cogentembedded.com>
From:   "Behme Dirk (CM/ESO2)" <dirk.behme@de.bosch.com>
Message-ID: <b7d64c11-473c-e703-0e5e-55b909861175@de.bosch.com>
Date:   Wed, 26 Feb 2020 10:54:31 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <f21a9444-9541-6558-f5f5-ca0b733768ff@cogentembedded.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.34.222.178]
X-Brightmail-Tracker: H4sIAAAAAAAAA22Tb0wbdRjH+d1d22vHseuVPw9ldXIR50zEDhmcU3GyOJv4QpPF4T/QIgdt
        pC30CmGLxmIiY2SMYZxCYeAAg7LhBmHYYZBZGVkZbmyQbCsUicMllFnnliIKi14prH3hu+/z
        fJ/P8717LkfiTBWpJo1mG28164tZqYJQ7OjWPJGzc2+e9lT/Dq71i1qCax2+JOFueQYxbmKg
        WcqdmfdjXOWfN2TcwZEFxHlnLhDcWJdHtlOumz36L6Zz/VSNdOMd3VJd3X2tbnGsntDd633o
        VembimcL+GJjOW99MutdhaGp7goqqd9a0Vz3jcSO6pNrEEkCnQ4HjqbXIAXJ0A0YDFXZJaHi
        BIKrnsNEqOhEcH9sRSzkpIrOgtufVEmCOpbmwFvZtjqE0ydF/Nt/UIi4hsOUs32VkNIZsNDh
        QEFN0c9Ddd9ZFMwm6BRo64sPtuPoXLjeWI2FRpTgbpxbReX0bvhx4exqGC6GNbZeRiGdAJ65
        ViykN8N3vzfjQQ10MpzxfiY7ghhHxCpHBO6IwB0R+JeI6ELxglFbbtKmbc/MSLXm88J+7bbU
        9yymXhT6TpQTXVosdCGMRC60ncTYOOqRzL15TEy+pWCfQS8Y3rGWFfMCq6Y+un0wl1E9aAtl
        +SajIBgtZhcCEmdjqZ7Aa3kMVaDft5+3WkKYCyWRBJtAFZGvvM3QRXob/z7Pl/DWdfcZkmSB
        2p0lBiqtfBFfUWgstq3brIZCUVFRTHykExmLkXIXeoqMFrPfek5cQQklepNgLFrDE0M4s94N
        o6NoF3njj442nCHMFjOvTqB8aSJPBycNZeYHT6DeRNkVohEXYYS3+NB1RCJWRaUEw6PFHyCc
        DZQ9eC7lWjMMpXWIDH0qBlo+toLvFzeC5cFpBC3OAILJ7is4OC4fI8B9sZcAz9JpCZw/6ZfA
        zEW/FDzuQzK4OuCQQWD6nAya79wkoWVpXA6/3vXLoan9rhyavzoSDT98vhwNp5tWKFia7d8I
        rnPVSpi+V6+EwPdOBsb6WlQwPzQcCxe+vhMPDc5OAOe1nkRoWFxKBP9xZxK4J9s2+cS7YuJd
        T6zsCd7Vprf9z13XuuGXU9tR8qe1T2859MajuZqefq3vxcOe9AxvYLy2UzWQXZrTeeDvkUlX
        ZVThzaS4/sdm9wyPfjjRZRrELO2l0uMfbD62xTZTsVwz8XIFm6lNVb8+Q+7yzZdqfnshRzk0
        lV2esrV3jvNk/4yfd760oWlD1tStgrS/Gr0ayca6kdQuPz0a87BRxRKCQb/tcdwq6P8DGftx
        yJkEAAA=
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Sergei,

On 25.02.2020 21:41, Sergei Shtylyov wrote:
> On 02/25/2020 12:33 PM, Behme Dirk (CM/ESO2) wrote:
> 
>>>>>>    From d72b805cc461ab1e9747c973e9be84e7abb8f828 Mon Sep 17 00:00:00 2001
>>>>>> From: Dirk Behme <dirk.behme@de.bosch.com>
>>>>>> Date: Tue, 4 Feb 2020 08:39:31 +0100
>>>>>> Subject: [PATCH] memory: renesas-rpc-if: Correct the STRTIM and some other
>>>>>>     clean up
>>>>>>
>>>>>> This is required to make the driver work correctly in my M3 environment.
>>>>>>
>>>>>> Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
>>>>>> ---
>>>>>>     drivers/memory/renesas-rpc-if.c | 42 ++++++++++++++++++++-------------
>>>>>>     1 file changed, 25 insertions(+), 17 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/memory/renesas-rpc-if.c b/drivers/memory/renesas-rpc-if.c
>>>>>> index 04be92b64bfa..f4356b066384 100644
>>>>>> --- a/drivers/memory/renesas-rpc-if.c
>>>>>> +++ b/drivers/memory/renesas-rpc-if.c
>>>>> [...]
>>>>>> @@ -513,19 +525,15 @@ ssize_t rpcif_dirmap_read(struct rpcif *rpc, u64 offs, size_t len, void *buf)
>>>>>>         pm_runtime_get_sync(rpc->dev);
>>>>>>
>>>>>>         regmap_update_bits(rpc->regmap, RPCIF_CMNCR, RPCIF_CMNCR_MD, 0);
>>>>>> -    regmap_write(rpc->regmap, RPCIF_DRCR,
>>>>>> -             RPCIF_DRCR_RBURST(32) | RPCIF_DRCR_RBE);
>>>>>> -    regmap_write(rpc->regmap, RPCIF_DRCMR, rpc->command);
>>>>>> -    regmap_write(rpc->regmap, RPCIF_DREAR,
>>>>>> -             RPCIF_DREAR_EAV(offs >> 25) | RPCIF_DREAR_EAC(1));
>>>>>> -    regmap_write(rpc->regmap, RPCIF_DROPR, rpc->option);
>>>>>> -    regmap_write(rpc->regmap, RPCIF_DRENR,
>>>>>> -             rpc->enable & ~RPCIF_SMENR_SPIDE(0xF));
>>>>>> -    regmap_write(rpc->regmap, RPCIF_DRDMCR, rpc->dummy);
>>>>>> -    regmap_write(rpc->regmap, RPCIF_DRDRENR, rpc->ddr);
>>>>>
>>>>>       The driver somehow works only with this left in place (with 2 bytes eaten
>>>>> as before), otherwise all the flash reads all 0xff (via dirmap).
>>>>
>>>>
>>>> Do you boot from hyperflash?
>>>
>>>      No, I have arewto say 'cpld write 30 1' in U-Boot before a boot a kernel.
> 
>     s/arewto/to/. :-)
> 
>>> Normally, the V3x Starter Kit boards are wired for the QSPI flash chips.
>>>
>>>> The system I'm using for testing boots from hyperflash. So most probably all registers
>>>> I don't touch in the driver are put into a reasonable state by the boot code, already.
>>>> If you don't boot from hyperflash, that at least would explain our different behavior.
>>>
>>>      Yes. Mind dumping the registers and sending to me?
>>
>> Using the attached debug patch (0001-memory-renesas-rpc-if-DEBUG-Dump-register-
>> content.patch) on a r8a7796 system booting from Hyperflash with above register
> dropping reverted (i.e. including touching these registers) I get
>>
>> Before:
>> RPCIF_DRCR:    0x00000000
>> RPCIF_DRCMR:   0x00a00000
>> RPCIF_DREAR:   0x00000000
>> RPCIF_DROPR:   0x00000000
>> RPCIF_DRENR:   0xa222d400
>> RPCIF_DRDMCR:  0x0000000e
>> RPCIF_DRDRENR: 0x00005101
>>
>> After:
>> RPCIF_DRCR:    0x001f0100
>> RPCIF_DRCMR:   0x00a00000
>> RPCIF_DREAR:   0x00010001
>> RPCIF_DROPR:   0x00000000
>> RPCIF_DRENR:   0xa202d400
>> RPCIF_DRDMCR:  0x0000000e
>> RPCIF_DRDRENR: 0x00005101
>>
>> Comparing that, just 3 registers are different between my working version ("Before") and the version which shows the 2-byte offset ("After"): RPCIF_DRCR, RPCIF_DREAR and RPCIF_DRENR. With try & error, at least in my setup, I was able to reduce this to just RPCIF_DRCR. Dropping the burst mode I was able to 'fix' the two byte offset issue.
> 
>     ACK! Thanks a lot for finding it! :-)
>     That's what I get on the first dirmap read:
> 
> Before:
> RPCIF_CMNCR:   0x81fff301
> RPCIF_DRCR:    0x00000000
> RPCIF_DRCMR:   0x00030000
> RPCIF_DREAR:   0x00000000
> RPCIF_DROPR:   0x00000000
> RPCIF_DRENR:   0x00004700
> RPCIF_DRDMCR:  0x00000000
> RPCIF_DRDRENR: 0x00000000
> 
> After:
> RPCIF_CMNCR:   0x01fff301
> RPCIF_DRCR:    0x001f0100
> RPCIF_DRCMR:   0x00800000
> RPCIF_DREAR:   0x00000001
> RPCIF_DROPR:   0x00000000
> RPCIF_DRENR:   0xa202d400
> RPCIF_DRDMCR:  0x0000000e
> RPCIF_DRDRENR: 0x00005101
> 
>> Do you like to give the attached 0001-memory-renesas-rpc-if-Don-t-use-burst-mode-on-read.patch a try in your setup?
> 
>     Works like charm! :-)


Good news, thanks! :)


>     Unfortunately, the SPI dirmap and/or writes are still broken.


I'm unsure about which function we are talking for "SPI dirmap"?

Regarding writes, in rpcif_io_xfer() in RPCIF_DATA_IN we have an 
additional place where burst mode is enabled:

if (!(smenr & RPCIF_SMENR_ADE(0xf)) && rpc->dirmap) {
...
regmap_write(rpc->regmap, RPCIF_DRCR,
	RPCIF_DRCR_RBURST(32) | RPCIF_DRCR_RBE);
...

Maybe it's worth a try to replace this by just 0, as well:

regmap_write(rpc->regmap, RPCIF_DRCR, 0);

But of course, this is guessing, as I'm not sure if this

if (!(smenr & RPCIF_SMENR_ADE(0xf)) && rpc->dirmap) {

path is taken, at all?


Or even better, if you could adapt the "before / after" debug patch to 
the path which are still not working for you and share it and the 
results, we could compare it with my setup, too :)

Dirk
