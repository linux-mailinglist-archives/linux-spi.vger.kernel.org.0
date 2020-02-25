Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9E0716F048
	for <lists+linux-spi@lfdr.de>; Tue, 25 Feb 2020 21:41:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729189AbgBYUlu (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 25 Feb 2020 15:41:50 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35050 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729182AbgBYUlt (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 25 Feb 2020 15:41:49 -0500
Received: by mail-lj1-f196.google.com with SMTP id q8so418285ljb.2
        for <linux-spi@vger.kernel.org>; Tue, 25 Feb 2020 12:41:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:cc:references:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=f1wxzQHgzbozsllzgNDGZLVCDjLuH9+6YSKgsfnh4N0=;
        b=J0Lq4tpycMq9o8u1bSrvUCSf0FdOD2Nyvd3Uo9ooIZeu3cp8b0a+4H56oOncPBS1R7
         GOw5V3B9Wt5Tn3PA/+5Y5Nw2El7pOACROliHYypQ2usaadr00To1fDV+i9SaaBPq8KF9
         JnLOYV2nhi7LSFyFMQGJZASywoO+ZoZa0qUB4jDWDyVWKuz8s5syYf4/3ASmAzLLMLGl
         2XBkjNhxfl4ATAYxSjNFijwCURknw0D0Eq3rjhgqAPpORoXGk/M6dd+Pfb+I2kA7bUV9
         z6Ho8xi5Wm3Q5qSVPjiqkTE+HPGGKN5NYjpnnQEsD5o969WyJ/RkywxbNHjHFmN694ta
         nyRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=f1wxzQHgzbozsllzgNDGZLVCDjLuH9+6YSKgsfnh4N0=;
        b=g5otOiqgR0gQemdI8qVt7z/Sq95Xre9i0K5NObxIBZ21EDeX9wHKYfiFyijA5eFXk0
         pOWJTEFy2QeBtFtFpjDIfTt7ZQ+b+sgnEzOFXJVWW0DtYR6OA9x/QqntVgnPLBFjJPzh
         WOBBWLkHsNT+DqbN1iwYGX/XK6SIdwkmntUxFmKDuuFFlMD4GuTQlZqn89icA3V6kbF4
         37oSQm4Wv2Y8EEOiL/66936diVJ8el6inqFfn/JmPVlwjXFt8ALYnZ/wi1nBXIuPXAAv
         wvH+/2mnofavxsOO+uaXRRwK+EIc5HZ2M/hsHWWiS8uBej2fZ7AOcKbo+2PzPLlncZdu
         l+qw==
X-Gm-Message-State: APjAAAX0K4bG2NchxudkfTw2ZcFMjjGMW7t2OyAOvN9hwn0QwcBGu/Is
        3vU2xjwrjsQ9aTGQp0+keKN4bw==
X-Google-Smtp-Source: ADFU+vsMS3caqJMbwRsF+MEpr24wt3YBnbgXGcWdeW2WuNzdWjviBCz6CpLXlq5tWMkXPS/oSyZFgw==
X-Received: by 2002:a2e:5854:: with SMTP id x20mr453488ljd.287.1582663307339;
        Tue, 25 Feb 2020 12:41:47 -0800 (PST)
Received: from wasted.cogentembedded.com ([2a00:1fa0:2ac:dee3:544c:cd2b:7405:7aec])
        by smtp.gmail.com with ESMTPSA id f14sm4247328lfh.40.2020.02.25.12.41.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Feb 2020 12:41:46 -0800 (PST)
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH RFC 2/2] memory: add Renesas RPC-IF driver
To:     "Behme Dirk (CM/ESO2)" <dirk.behme@de.bosch.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mason Yang <masonccyang@mxic.com.tw>,
        linux-spi@vger.kernel.org, Chris Brandt <chris.brandt@renesas.com>,
        linux-renesas-soc@vger.kernel.org
References: <cb7022c9-0059-4eb2-7910-aab42124fa1c@cogentembedded.com>
 <4db876ed-1ccc-e3be-311d-30cd52f40259@cogentembedded.com>
 <5760bcdb-e44b-6f18-7262-9526684e5780@de.bosch.com>
 <5603f393-554d-e2a8-c2d8-6bafc20f4169@cogentembedded.com>
 <cba1e2ec-4896-23ef-ef7b-0f80d4310127@de.bosch.com>
 <ec545462-54ed-9e23-049e-1807d24ec084@cogentembedded.com>
 <3a182ac7-8d41-cdc7-2b87-7c503f68a426@de.bosch.com>
Organization: Cogent Embedded
Message-ID: <f21a9444-9541-6558-f5f5-ca0b733768ff@cogentembedded.com>
Date:   Tue, 25 Feb 2020 23:41:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <3a182ac7-8d41-cdc7-2b87-7c503f68a426@de.bosch.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 02/25/2020 12:33 PM, Behme Dirk (CM/ESO2) wrote:

>>>>>   From d72b805cc461ab1e9747c973e9be84e7abb8f828 Mon Sep 17 00:00:00 2001
>>>>> From: Dirk Behme <dirk.behme@de.bosch.com>
>>>>> Date: Tue, 4 Feb 2020 08:39:31 +0100
>>>>> Subject: [PATCH] memory: renesas-rpc-if: Correct the STRTIM and some other
>>>>>    clean up
>>>>>
>>>>> This is required to make the driver work correctly in my M3 environment.
>>>>>
>>>>> Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
>>>>> ---
>>>>>    drivers/memory/renesas-rpc-if.c | 42 ++++++++++++++++++++-------------
>>>>>    1 file changed, 25 insertions(+), 17 deletions(-)
>>>>>
>>>>> diff --git a/drivers/memory/renesas-rpc-if.c b/drivers/memory/renesas-rpc-if.c
>>>>> index 04be92b64bfa..f4356b066384 100644
>>>>> --- a/drivers/memory/renesas-rpc-if.c
>>>>> +++ b/drivers/memory/renesas-rpc-if.c
>>>> [...]
>>>>> @@ -513,19 +525,15 @@ ssize_t rpcif_dirmap_read(struct rpcif *rpc, u64 offs, size_t len, void *buf)
>>>>>        pm_runtime_get_sync(rpc->dev);
>>>>>
>>>>>        regmap_update_bits(rpc->regmap, RPCIF_CMNCR, RPCIF_CMNCR_MD, 0);
>>>>> -    regmap_write(rpc->regmap, RPCIF_DRCR,
>>>>> -             RPCIF_DRCR_RBURST(32) | RPCIF_DRCR_RBE);
>>>>> -    regmap_write(rpc->regmap, RPCIF_DRCMR, rpc->command);
>>>>> -    regmap_write(rpc->regmap, RPCIF_DREAR,
>>>>> -             RPCIF_DREAR_EAV(offs >> 25) | RPCIF_DREAR_EAC(1));
>>>>> -    regmap_write(rpc->regmap, RPCIF_DROPR, rpc->option);
>>>>> -    regmap_write(rpc->regmap, RPCIF_DRENR,
>>>>> -             rpc->enable & ~RPCIF_SMENR_SPIDE(0xF));
>>>>> -    regmap_write(rpc->regmap, RPCIF_DRDMCR, rpc->dummy);
>>>>> -    regmap_write(rpc->regmap, RPCIF_DRDRENR, rpc->ddr);
>>>>
>>>>      The driver somehow works only with this left in place (with 2 bytes eaten
>>>> as before), otherwise all the flash reads all 0xff (via dirmap).
>>>
>>>
>>> Do you boot from hyperflash?
>>
>>     No, I have arewto say 'cpld write 30 1' in U-Boot before a boot a kernel.

   s/arewto/to/. :-)

>> Normally, the V3x Starter Kit boards are wired for the QSPI flash chips.
>>
>>> The system I'm using for testing boots from hyperflash. So most probably all registers
>>> I don't touch in the driver are put into a reasonable state by the boot code, already.
>>> If you don't boot from hyperflash, that at least would explain our different behavior.
>>
>>     Yes. Mind dumping the registers and sending to me?
> 
> Using the attached debug patch (0001-memory-renesas-rpc-if-DEBUG-Dump-register-
> content.patch) on a r8a7796 system booting from Hyperflash with above register
dropping reverted (i.e. including touching these registers) I get
> 
> Before:
> RPCIF_DRCR:    0x00000000
> RPCIF_DRCMR:   0x00a00000
> RPCIF_DREAR:   0x00000000
> RPCIF_DROPR:   0x00000000
> RPCIF_DRENR:   0xa222d400
> RPCIF_DRDMCR:  0x0000000e
> RPCIF_DRDRENR: 0x00005101
> 
> After:
> RPCIF_DRCR:    0x001f0100
> RPCIF_DRCMR:   0x00a00000
> RPCIF_DREAR:   0x00010001
> RPCIF_DROPR:   0x00000000
> RPCIF_DRENR:   0xa202d400
> RPCIF_DRDMCR:  0x0000000e
> RPCIF_DRDRENR: 0x00005101
> 
> Comparing that, just 3 registers are different between my working version ("Before") and the version which shows the 2-byte offset ("After"): RPCIF_DRCR, RPCIF_DREAR and RPCIF_DRENR. With try & error, at least in my setup, I was able to reduce this to just RPCIF_DRCR. Dropping the burst mode I was able to 'fix' the two byte offset issue.

   ACK! Thanks a lot for finding it! :-)
   That's what I get on the first dirmap read:

Before:
RPCIF_CMNCR:   0x81fff301
RPCIF_DRCR:    0x00000000
RPCIF_DRCMR:   0x00030000
RPCIF_DREAR:   0x00000000
RPCIF_DROPR:   0x00000000
RPCIF_DRENR:   0x00004700
RPCIF_DRDMCR:  0x00000000
RPCIF_DRDRENR: 0x00000000

After:                                                                          
RPCIF_CMNCR:   0x01fff301                                                       
RPCIF_DRCR:    0x001f0100                                                       
RPCIF_DRCMR:   0x00800000                                                       
RPCIF_DREAR:   0x00000001                                                       
RPCIF_DROPR:   0x00000000                                                       
RPCIF_DRENR:   0xa202d400                                                       
RPCIF_DRDMCR:  0x0000000e                                                       
RPCIF_DRDRENR: 0x00005101                                                       

> Do you like to give the attached 0001-memory-renesas-rpc-if-Don-t-use-burst-mode-on-read.patch a try in your setup?

   Works like charm! :-)
   Unfortunately, the SPI dirmap and/or writes are still broken.

> Best regards
> 
> Dirk

MBR, Sergei
