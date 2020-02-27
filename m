Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87459172977
	for <lists+linux-spi@lfdr.de>; Thu, 27 Feb 2020 21:32:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbgB0UcO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 27 Feb 2020 15:32:14 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45179 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729421AbgB0UcO (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 27 Feb 2020 15:32:14 -0500
Received: by mail-lf1-f66.google.com with SMTP id z5so371322lfd.12
        for <linux-spi@vger.kernel.org>; Thu, 27 Feb 2020 12:32:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:cc:references:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9ISG63/75ZnqFjCBjboMyogPm7Ic4pLFsII9ijv4S5c=;
        b=y2Jzgj5wXfLKcV0mzl8aS8r5DHCPwq9BmPz15LFBZjZ8XjkhlCaac+qc62Pfzxw9Hm
         VTPa/RgF10v6XrHXE7hDnx3Ru0j8l3Jrbnqua8a1f6t8QInpvqNMJjGVkU4Ka//t7i54
         fDZFXhrURno8K6qqD2Klj2lbzdz3TFPKZay8b3ivDQn/bkFQ3Np+f97T+Y1QyCfzw5+R
         fpCWL8AIf9zt5++8Cf9GVbKvOAKmK86IE2xK9cflXhcwUHapVRUvzLlKRChRClEhyOc9
         PpUFEN2s0yw0hghIUJ7uc1OCspVFp/7ri01v41yjNyuDxrSSCI1jJV8Sd+FYAi008+Nf
         I48A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=9ISG63/75ZnqFjCBjboMyogPm7Ic4pLFsII9ijv4S5c=;
        b=QgSkmfrKJIHcLsyT7N/cKrAHlsEqGouInh1O0d8QHd75FJUHSI5gIJ2AL9ogknuAzS
         HnaGpo/KHnUYsuLHGD4hXA04yE9mlcxDdEYlK/FUdwnwvq8AjYg5enpeoRuUj9efm0oO
         8abOgcah7L72N1GgL+xTFE9p/faEYQfsLajYsA2yagwEZUYPfwkSZl46eYKm2HoBrERo
         ZLohQVhBRHiw7x1gJ1CITme174EHAWtgFqkXYTHhvTmiERLUlpkBi9A9iq/FlTXZBw3d
         0Krk+qfqqFg4/D2p/oH4g+k8Z/u2AQByhOJfQY6vtWJkazWy6UKT8OBJYyzXHUbxX4Tv
         iEYA==
X-Gm-Message-State: ANhLgQ2nW/vSaFpkWvWk7zBpXuQTAWrYo+Cy3fJVpscpA71T08nrC4B/
        yv6xJ7j2egcVqm12Iv6IaWxzbcamT/4=
X-Google-Smtp-Source: ADFU+vv3qE+rnPwQ2pWW4DGqSfg7kiHpjIaGxXI8Vzew8ZjMQ2/4y2mDx/Bw+c5R1UDuJR7Y1uhtFQ==
X-Received: by 2002:ac2:5492:: with SMTP id t18mr648914lfk.184.1582835530138;
        Thu, 27 Feb 2020 12:32:10 -0800 (PST)
Received: from wasted.cogentembedded.com ([2a00:1fa0:8d0:2529:4e81:e74e:4b97:1620])
        by smtp.gmail.com with ESMTPSA id s10sm4303057ljp.35.2020.02.27.12.32.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Feb 2020 12:32:09 -0800 (PST)
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH RFC 2/2] memory: add Renesas RPC-IF driver
To:     "Behme Dirk (CM/ESO2)" <dirk.behme@de.bosch.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mason Yang <masonccyang@mxic.com.tw>,
        linux-spi@vger.kernel.org, Chris Brandt <chris.brandt@renesas.com>,
        linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
References: <cb7022c9-0059-4eb2-7910-aab42124fa1c@cogentembedded.com>
 <4db876ed-1ccc-e3be-311d-30cd52f40259@cogentembedded.com>
 <5760bcdb-e44b-6f18-7262-9526684e5780@de.bosch.com>
 <5603f393-554d-e2a8-c2d8-6bafc20f4169@cogentembedded.com>
 <cba1e2ec-4896-23ef-ef7b-0f80d4310127@de.bosch.com>
 <ec545462-54ed-9e23-049e-1807d24ec084@cogentembedded.com>
 <3a182ac7-8d41-cdc7-2b87-7c503f68a426@de.bosch.com>
 <f21a9444-9541-6558-f5f5-ca0b733768ff@cogentembedded.com>
 <b7d64c11-473c-e703-0e5e-55b909861175@de.bosch.com>
Organization: Cogent Embedded
Message-ID: <cc60b321-9040-0962-e955-7212689d9a4a@cogentembedded.com>
Date:   Thu, 27 Feb 2020 23:32:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <b7d64c11-473c-e703-0e5e-55b909861175@de.bosch.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello!

On 02/26/2020 12:54 PM, Behme Dirk (CM/ESO2) wrote:

>>>>>>>    From d72b805cc461ab1e9747c973e9be84e7abb8f828 Mon Sep 17 00:00:00 2001
>>>>>>> From: Dirk Behme <dirk.behme@de.bosch.com>
>>>>>>> Date: Tue, 4 Feb 2020 08:39:31 +0100
>>>>>>> Subject: [PATCH] memory: renesas-rpc-if: Correct the STRTIM and some other
>>>>>>>     clean up
>>>>>>>
>>>>>>> This is required to make the driver work correctly in my M3 environment.
>>>>>>>
>>>>>>> Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
>>>>>>> ---
>>>>>>>     drivers/memory/renesas-rpc-if.c | 42 ++++++++++++++++++++-------------
>>>>>>>     1 file changed, 25 insertions(+), 17 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/memory/renesas-rpc-if.c b/drivers/memory/renesas-rpc-if.c
>>>>>>> index 04be92b64bfa..f4356b066384 100644
>>>>>>> --- a/drivers/memory/renesas-rpc-if.c
>>>>>>> +++ b/drivers/memory/renesas-rpc-if.c
>>>>>> [...]
>>>>>>> @@ -513,19 +525,15 @@ ssize_t rpcif_dirmap_read(struct rpcif *rpc, u64 offs, size_t len, void *buf)
>>>>>>>         pm_runtime_get_sync(rpc->dev);
>>>>>>>
>>>>>>>         regmap_update_bits(rpc->regmap, RPCIF_CMNCR, RPCIF_CMNCR_MD, 0);
>>>>>>> -    regmap_write(rpc->regmap, RPCIF_DRCR,
>>>>>>> -             RPCIF_DRCR_RBURST(32) | RPCIF_DRCR_RBE);
>>>>>>> -    regmap_write(rpc->regmap, RPCIF_DRCMR, rpc->command);
>>>>>>> -    regmap_write(rpc->regmap, RPCIF_DREAR,
>>>>>>> -             RPCIF_DREAR_EAV(offs >> 25) | RPCIF_DREAR_EAC(1));
>>>>>>> -    regmap_write(rpc->regmap, RPCIF_DROPR, rpc->option);
>>>>>>> -    regmap_write(rpc->regmap, RPCIF_DRENR,
>>>>>>> -             rpc->enable & ~RPCIF_SMENR_SPIDE(0xF));
>>>>>>> -    regmap_write(rpc->regmap, RPCIF_DRDMCR, rpc->dummy);
>>>>>>> -    regmap_write(rpc->regmap, RPCIF_DRDRENR, rpc->ddr);
>>>>>>
>>>>>>       The driver somehow works only with this left in place (with 2 bytes eaten
>>>>>> as before), otherwise all the flash reads all 0xff (via dirmap).
>>>>>
>>>>>
>>>>> Do you boot from hyperflash?
>>>>
>>>>      No, I have arewto say 'cpld write 30 1' in U-Boot before a boot a kernel.
>>
>>     s/arewto/to/. :-)
>>
>>>> Normally, the V3x Starter Kit boards are wired for the QSPI flash chips.
>>>>
>>>>> The system I'm using for testing boots from hyperflash. So most probably all registers
>>>>> I don't touch in the driver are put into a reasonable state by the boot code, already.
>>>>> If you don't boot from hyperflash, that at least would explain our different behavior.
>>>>
>>>>      Yes. Mind dumping the registers and sending to me?
>>>
>>> Using the attached debug patch (0001-memory-renesas-rpc-if-DEBUG-Dump-register-
>>> content.patch) on a r8a7796 system booting from Hyperflash with above register
>> dropping reverted (i.e. including touching these registers) I get
>>>
>>> Before:
>>> RPCIF_DRCR:    0x00000000
>>> RPCIF_DRCMR:   0x00a00000
>>> RPCIF_DREAR:   0x00000000
>>> RPCIF_DROPR:   0x00000000
>>> RPCIF_DRENR:   0xa222d400
>>> RPCIF_DRDMCR:  0x0000000e
>>> RPCIF_DRDRENR: 0x00005101
>>>
>>> After:
>>> RPCIF_DRCR:    0x001f0100
>>> RPCIF_DRCMR:   0x00a00000
>>> RPCIF_DREAR:   0x00010001
>>> RPCIF_DROPR:   0x00000000
>>> RPCIF_DRENR:   0xa202d400
>>> RPCIF_DRDMCR:  0x0000000e
>>> RPCIF_DRDRENR: 0x00005101
>>>
>>> Comparing that, just 3 registers are different between my working version ("Before") and the version which shows the 2-byte offset ("After"): RPCIF_DRCR, RPCIF_DREAR and RPCIF_DRENR. With try & error, at least in my setup, I was able to reduce this to just RPCIF_DRCR. Dropping the burst mode I was able to 'fix' the two byte offset issue.
>>
>>     ACK! Thanks a lot for finding it! :-)
>>     That's what I get on the first dirmap read:
>>
>> Before:
>> RPCIF_CMNCR:   0x81fff301
>> RPCIF_DRCR:    0x00000000
>> RPCIF_DRCMR:   0x00030000
>> RPCIF_DREAR:   0x00000000
>> RPCIF_DROPR:   0x00000000
>> RPCIF_DRENR:   0x00004700
>> RPCIF_DRDMCR:  0x00000000
>> RPCIF_DRDRENR: 0x00000000
>>
>> After:
>> RPCIF_CMNCR:   0x01fff301
>> RPCIF_DRCR:    0x001f0100
>> RPCIF_DRCMR:   0x00800000
>> RPCIF_DREAR:   0x00000001
>> RPCIF_DROPR:   0x00000000
>> RPCIF_DRENR:   0xa202d400
>> RPCIF_DRDMCR:  0x0000000e
>> RPCIF_DRDRENR: 0x00005101
>>
>>> Do you like to give the attached 0001-memory-renesas-rpc-if-Don-t-use-burst-mode-on-read.patch a try in your setup?
>>
>>     Works like charm! :-)
> 
> 
> Good news, thanks! :)
> 
> 
>>     Unfortunately, the SPI dirmap and/or writes are still broken.
> 
> 
> I'm unsure about which function we are talking for "SPI dirmap"?

   The same, rpcif_dirmap_read(). I'm now thinking it works correctly, it's just
the writes that are borked.

> Regarding writes, in rpcif_io_xfer() in RPCIF_DATA_IN we have an additional place where burst mode is enabled:

   This works around the hardware bug where the SPI NOR RDID command's data bytes get
spoiled, leading to unrecognized flash chip. Well, there's a comment before this *if*. 

> if (!(smenr & RPCIF_SMENR_ADE(0xf)) && rpc->dirmap) {
> ...
> regmap_write(rpc->regmap, RPCIF_DRCR,
>     RPCIF_DRCR_RBURST(32) | RPCIF_DRCR_RBE);
> ...
> 
> Maybe it's worth a try to replace this by just 0, as well:
> 
> regmap_write(rpc->regmap, RPCIF_DRCR, 0);

   I've just tried that, here's the result:

spi-nor spi0.0: unrecognized JEDEC id bytes: 01 01 01 01 01 01                  

(and the flash doesn't get registered).

> But of course, this is guessing, as I'm not sure if this
> 
> if (!(smenr & RPCIF_SMENR_ADE(0xf)) && rpc->dirmap) {
> 
> path is taken, at all?

   It's taken but only with SPI NOR.

> Or even better, if you could adapt the "before / after" debug patch to the path which are still not working for you and share it and the results, we could compare it with my setup, too :)

  I'll try doing that tomorrow...

> Dirk

MBR, Sergei
