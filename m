Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7391691CC
	for <lists+linux-spi@lfdr.de>; Sat, 22 Feb 2020 21:42:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbgBVUmd (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 22 Feb 2020 15:42:33 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39061 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726884AbgBVUmd (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 22 Feb 2020 15:42:33 -0500
Received: by mail-lf1-f65.google.com with SMTP id n30so3207634lfh.6
        for <linux-spi@vger.kernel.org>; Sat, 22 Feb 2020 12:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8/dqp+6ZkvRRmpmaUZJPJGMl+JnMMGYivypZ+qu1IdQ=;
        b=KfFZENIHa1kD6D/djqtV3blmirkAzxujGlBUFJP08Yxr+SBEzFzJLYLcEkkSqydT8X
         WcrEABFsSj/iama8pmWwrD0OkIPADuTDhFwjkBQNCgz/X0EWGkD1A4XiSLivvtseRDn3
         TYiTvAMUlNv9hyetNnMvhIBTGGb1OuWpsVfnhJ58Ho9wGJ0wB9TYgJ5UCENxnu42+3oN
         6xdXDF7aUEKvAcq1gbBTewL0jcm8+bY6gCsU9i2lqP/47SV9kF6bH2y1LxAWkiCHpe0t
         kV/STK4XxyKUpd3IzE0SYkQyeH3TH8R8H0taoZJWSQCs2wPxYJJrzMW7vncAb+rmRqgS
         m6ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=8/dqp+6ZkvRRmpmaUZJPJGMl+JnMMGYivypZ+qu1IdQ=;
        b=HsEjwzn0JqY6/oBogaucmfAqwJGeCCX8jq2iCJuJ6UYzRKjidaEaYqhlCZQlttHs3j
         zmEHE2hqvhmEVs1pzEL7b1zi9qsM6Vq/eIIS+0ebT2N/+/mGECipgIjK5vtHaVIDiufJ
         DnCeT3DUm7OWC3OQuOhenPoIarq5m5/0BSh58thhf/AS9hbmwHOsZMHODQ6Z6UVkWCwt
         lZsSxAiR5FQ9iAW0lQmzFmBC7AjrqD+4SwDifpebO9bAezY0FPvC3Qf/uGsvZZThwwqy
         1QuOpb1aw8CKDzWaT5UUGKkK1z/jdVfBCjlMs+3cwHgUeV5ldtgvnLnYTZJzJYp8VuLs
         dEgA==
X-Gm-Message-State: APjAAAXf+MUhyfHIpqwUa+yZnrbdnWtCOmmKNZcay74pEiN/YbIvihRo
        7fkxdXUpC9tluoQUmdvWfEwU/Q==
X-Google-Smtp-Source: APXvYqx/B38YxteGwSNzJbkis53V2cy++o3q6ZdclQVcDwud+2NQuhy0RoD9Gg/qpGXsI9f1WGPORw==
X-Received: by 2002:a19:6b0e:: with SMTP id d14mr4043585lfa.46.1582404149341;
        Sat, 22 Feb 2020 12:42:29 -0800 (PST)
Received: from wasted.cogentembedded.com ([2a00:1fa0:4621:26b8:f6bb:b31c:6567:7228])
        by smtp.gmail.com with ESMTPSA id v16sm3543019lfp.92.2020.02.22.12.42.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Feb 2020 12:42:28 -0800 (PST)
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
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <5603f393-554d-e2a8-c2d8-6bafc20f4169@cogentembedded.com>
Date:   Sat, 22 Feb 2020 23:42:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <5760bcdb-e44b-6f18-7262-9526684e5780@de.bosch.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 02/10/2020 01:21 PM, Behme Dirk (CM/ESO2) wrote:

>> Add the memory driver for Renesas RPC-IF which registers either SPI or
>> HyperFLash device depending on the contents of the device tree subnode.
>> It also provides the absract "back end" device APIs that can be used by
>> the "front end" SPI/MTD drivers to talk to the real hardware.
>>
>> Based on the original patch by Mason Yang <masonccyang@mxic.com.tw>.
>>
>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> 
> FYI, please find below [1] the changes I did locally on this driver. It seems to read & write successfully on my custom M3 (R8A7796) device, now.

   Not for me...
   BTW, your patch had whitespace ruined, I had to apply it by hand, you'd better
attach the patches, not paste. :-/

> Best regards
> 
> Dirk
> 
> [1]
> 
> From d72b805cc461ab1e9747c973e9be84e7abb8f828 Mon Sep 17 00:00:00 2001
> From: Dirk Behme <dirk.behme@de.bosch.com>
> Date: Tue, 4 Feb 2020 08:39:31 +0100
> Subject: [PATCH] memory: renesas-rpc-if: Correct the STRTIM and some other
>  clean up
> 
> This is required to make the driver work correctly in my M3 environment.
> 
> Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
> ---
>  drivers/memory/renesas-rpc-if.c | 42 ++++++++++++++++++++-------------
>  1 file changed, 25 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/memory/renesas-rpc-if.c b/drivers/memory/renesas-rpc-if.c
> index 04be92b64bfa..f4356b066384 100644
> --- a/drivers/memory/renesas-rpc-if.c
> +++ b/drivers/memory/renesas-rpc-if.c
[...]
> @@ -513,19 +525,15 @@ ssize_t rpcif_dirmap_read(struct rpcif *rpc, u64 offs, size_t len, void *buf)
>      pm_runtime_get_sync(rpc->dev);
> 
>      regmap_update_bits(rpc->regmap, RPCIF_CMNCR, RPCIF_CMNCR_MD, 0);
> -    regmap_write(rpc->regmap, RPCIF_DRCR,
> -             RPCIF_DRCR_RBURST(32) | RPCIF_DRCR_RBE);
> -    regmap_write(rpc->regmap, RPCIF_DRCMR, rpc->command);
> -    regmap_write(rpc->regmap, RPCIF_DREAR,
> -             RPCIF_DREAR_EAV(offs >> 25) | RPCIF_DREAR_EAC(1));
> -    regmap_write(rpc->regmap, RPCIF_DROPR, rpc->option);
> -    regmap_write(rpc->regmap, RPCIF_DRENR,
> -             rpc->enable & ~RPCIF_SMENR_SPIDE(0xF));
> -    regmap_write(rpc->regmap, RPCIF_DRDMCR, rpc->dummy);
> -    regmap_write(rpc->regmap, RPCIF_DRDRENR, rpc->ddr);

   The driver somehow works only with this left in place (with 2 bytes eaten
as before), otherwise all the flash reads all 0xff (via dirmap).

> +    ret = wait_msg_xfer_end(rpc);
> +    if (ret) {
> +        len = 0;
> +        goto err_out;
> +    }
> 
>      memcpy_fromio(buf, rpc->dirmap + from, len);
> 
> +err_out:
>      pm_runtime_put(rpc->dev);
> 
>      return len;

MBR, Sergei
