Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1E6C2ABEC2
	for <lists+linux-spi@lfdr.de>; Mon,  9 Nov 2020 15:34:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729879AbgKIOeB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Nov 2020 09:34:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729454AbgKIOeB (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 9 Nov 2020 09:34:01 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDC2FC0613CF;
        Mon,  9 Nov 2020 06:34:00 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id q5so3842154qkc.12;
        Mon, 09 Nov 2020 06:34:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gCiC2QrGVvZy6BwdDI/CgCdt1CEU+tvmWRC0OlmD6aQ=;
        b=GO1W2N1Lhx6B35DzuioiX1IL1gYxYF/NV0G2br2yrCL8YfBggWUCc5bjFfmZWrqz7z
         HOd66TVxwyWL2wkpkErivuAIq+QYley8KI7NkWaTvT2tkpEvpFjJhoMT5TkgLjCBORza
         KwtNLAblWGukGY2Pp8fXxl5NQ9cqU1XA8+NO2OBDklyFkxt0J20sB7UA9ylhnO5elEAD
         PpZhSASeBiSqFwuSO9Tsd7hoRTM3wNJq7xOdNgYIfy0OSA/N5PuVNfH/ccqlK4HrtoCW
         ufmMWMl4Uqjg5XWET9hNDV5KVL9omZoYG9ak0ZNOm3lNl63JREO0wUrVcYboHGkzkAvM
         VkVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=gCiC2QrGVvZy6BwdDI/CgCdt1CEU+tvmWRC0OlmD6aQ=;
        b=Hvo67QM476u9AhF7Wh4P8jQUssyzI7TSDv0bYB33FYeyCVjzguqdLEedE/FtF2TijZ
         JdAP9UGqCPGeqpxR/B44npOj4kWJPM02l6bT8M+sNR8+RWbFmHLiGS7p7bOLqDVJY3fJ
         jFQvqu1S98vNgWPIyqv3gukb6GNX1f8387KvhBYwEhlyUI9UvSFFMH9kwFjZGIuxBddy
         p8ZwWzSTchr3z0wAyoKvmNGMspEXFP7ZkjDYfKWpls/b0Wnw1uhsCjqqIzj2lryUoA+r
         iO98EDejMe2dOxHkNehOLsOpozzsD4+amw27VSNaVNB8sTysZ3H16D80YPCTzRUnAQn/
         5dvg==
X-Gm-Message-State: AOAM532oSJH6PNc77TN2wkAqCCTP3dLBiYTbl5AZnmhGytwBoNkXD3pz
        ZPqbHRIKMGj039zhCwP6/CQ=
X-Google-Smtp-Source: ABdhPJxo/WB/L7eXPNeaCbSiryg8v9P4QGKxwW8YxKhE4WVSlxSctLpNASiDqlkv7bI6AVaruoW+7A==
X-Received: by 2002:a37:b07:: with SMTP id 7mr14383632qkl.370.1604932440032;
        Mon, 09 Nov 2020 06:34:00 -0800 (PST)
Received: from [192.168.1.201] (pool-108-51-35-162.washdc.fios.verizon.net. [108.51.35.162])
        by smtp.googlemail.com with ESMTPSA id b4sm2517971qti.64.2020.11.09.06.33.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2020 06:33:59 -0800 (PST)
Subject: Re: [PATCH 02/32] spi: dw: Add support for 32-bits ctrlr0 layout
To:     Serge Semin <fancer.lancer@gmail.com>,
        Damien Le Moal <damien.lemoal@wdc.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        linux-clk@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>
References: <20201107081420.60325-1-damien.lemoal@wdc.com>
 <20201107081420.60325-3-damien.lemoal@wdc.com>
 <20201109142529.tt5ojjyn36vd3ohe@mobilestation>
From:   Sean Anderson <seanga2@gmail.com>
Autocrypt: addr=seanga2@gmail.com; prefer-encrypt=mutual; keydata=
 mQENBFe74PkBCACoLC5Zq2gwrDcCkr+EPGsT14bsxrW07GiYzQhLCgwnPdEpgU95pXltbFhw
 46GfyffABWxHKO2x+3L1S6ZxC5AiKbYXo7lpnTBYjamPWYouz+VJEVjUx9aaSEByBah5kX6a
 lKFZWNbXLAJh+dE1HFaMi3TQXXaInaREc+aO1F7fCa2zNE75ja+6ah8L4TPRFZ2HKQzve0/Y
 GXtoRw97qmnm3U36vKWT/m2AiLF619F4T1mHvlfjyd9hrVwjH5h/2rFyroXVXBZHGA9Aj8eN
 F2si35dWSZlIwXkNu9bXp0/pIu6FD0bI+BEkD5S7aH1G1iAcMFi5Qq2RNa041DfQSDDHABEB
 AAG0K1NlYW4gR2FsbGFnaGVyIEFuZGVyc29uIDxzZWFuZ2EyQGdtYWlsLmNvbT6JAVcEEwEK
 AEECGwMFCwkIBwIGFQgJCgsCBBYCAwECHgECF4ACGQEWIQSQYR1bzo1I0gPoYCg+6I/stKEQ
 bgUCXT+S2AUJB2TlXwAKCRA+6I/stKEQbhNOB/9ooea0hU9Sgh7PBloU6CgaC5mlqPLB7NTp
 +JkB+nh3Fqhk+qLZwzEynnuDLl6ESpVHIc0Ym1lyF4gT3DsrlGT1h0Gzw7vUwd1+ZfN0CuIx
 Rn861U/dAUjvbtN5kMBqOI4/5ea+0r7MACcIVnKF/wMXBD8eypHsorT2sJTzwZ6DRCNP70C5
 N1ahpqqNmXe0uLdP0pu55JCqhrGw2SinkRMdWyhSxT56uNwIVHGhLTqH7Q4t1N6G1EH626qa
 SvIJsWlNpll6Y3AYLDw2/Spw/hqieS2PQ/Ky3rPZnvJt7/aSNYsKoFGX0yjkH67Uq8Lx0k1L
 w8jpXnbEPQN3A2ZJCbeM
Message-ID: <6dc6d52e-a39d-c351-5280-71b9e8eafe37@gmail.com>
Date:   Mon, 9 Nov 2020 09:33:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201109142529.tt5ojjyn36vd3ohe@mobilestation>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 11/9/20 9:25 AM, Serge Semin wrote:
> Hello Damien,
> Thanks for your patches. My comments are below.
> 
> On Sat, Nov 07, 2020 at 05:13:50PM +0900, Damien Le Moal wrote:
>> Synopsis DesignWare DW_apb_ssi version 4 defines a 32-bit layout of
>> the ctrlr0 register for SPI masters. The layout of ctrlr0 is:
>>
>> |   31 .. 23  | 22 .. 21 | 20 .. 16 |
>> | other stuff | spi_frf  |  dfs_32  |
>>
>> |   15 .. 10  | 9 .. 8 | 7 .. 6 | 5 .. 4 | 3 .. 0 |
>> | other stuff |  tmod  |  mode  |  frf   |  dfs   |
>>
> 
>> Th main difference of this layout with the 16-bits version is the data
>     ^
>     |
>     e
> 
>> frame format field which resides in bits 16..20 instead of bits 3..0.
>>
> 
> Are you sure they have been moved from [0, 3] to [16, 20]? I don't have the
> manual for the 4.0x version of the core, but according to this patch:
> https://patchwork.kernel.org/project/spi-devel-general/patch/1575907443-26377-7-git-send-email-wan.ahmad.zainie.wan.mohamad@intel.com/
> it has been ok to use the lowest four bits for DFS setting. Is the commit
> message misleading there?

This commit message is a truncated version of [1]. Importantly, DFS is
valid when SSI_MAX_XFER_SIZE=16. When it =32, then DFS_32 must be used
(since DFS is constant 0xF). Since SSI_MAX_XFER_SIZE is a synthesis
parameter, there exist devices where DFS must be used, and also where
DFS_32 must be used. 

[1] https://patchwork.ozlabs.org/project/uboot/patch/20201016225755.302659-10-seanga2@gmail.com/

--Sean

> 
>> Introduce the DW SPI capability flag DW_SPI_CAP_DFS_32 to let a
>> platform signal that this layout is in use. Modify
>> dw_spi_update_config() to test this capability flag to set the data
>> frame format field at the correct register location.
>>
>> Suggested-by: Sean Anderson <seanga2@gmail.com>
>> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
>> ---
>>  drivers/spi/spi-dw-core.c | 8 ++++++--
>>  drivers/spi/spi-dw.h      | 9 +++++++++
>>  2 files changed, 15 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
>> index 2e50cc0a9291..841c85247f01 100644
>> --- a/drivers/spi/spi-dw-core.c
>> +++ b/drivers/spi/spi-dw-core.c
>> @@ -311,8 +311,12 @@ void dw_spi_update_config(struct dw_spi *dws, struct spi_device *spi,
>>  	u32 speed_hz;
>>  	u16 clk_div;
>>  
> 
>> -	/* CTRLR0[ 4/3: 0] Data Frame Size */
>> -	cr0 |= (cfg->dfs - 1);
>> +	if (!(dws->caps & DW_SPI_CAP_DFS_32))
>> +		/* CTRLR0[ 4/3: 0] Data Frame Size */
>> +		cr0 |= (cfg->dfs - 1);
>> +	else
>> +		/* CTRLR0[20: 16] Data Frame Size */
>> +		cr0 |= (cfg->dfs - 1) << DWC_APB_CTRLR0_32_DFS_OFFSET;
> 
> If you extend the dfs field from four to five bits, then
> controller->bits_per_word_mask field should be properly updated too.
> 
> Alas it hasn't been done for the DWC_ssi version of the core. So I suppose it
> should be fixed for the both of them.
> 
> Just for the record. There are very handy macros for setting and getting bit fields
> to/from a variable. This is a good place to use them instead of manually
> shifting and defining the offsets. The macros are defined in linux/bitfield.h .
> Alas this driver hasn't been converted to using them. So I won't insist on using
> them here. But I hope someone will fix it sometime in future...

I second that request.

> -Sergey
> 
>>  
>>  	if (!(dws->caps & DW_SPI_CAP_DWC_SSI))
>>  		/* CTRLR0[ 9:8] Transfer Mode */
>> diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
>> index faf40cb66498..48a11a51a407 100644
>> --- a/drivers/spi/spi-dw.h
>> +++ b/drivers/spi/spi-dw.h
>> @@ -9,6 +9,7 @@
>>  #include <linux/io.h>
>>  #include <linux/scatterlist.h>
>>  #include <linux/spi/spi-mem.h>
>> +#include <linux/bitfield.h>
>>  
>>  /* Register offsets */
>>  #define DW_SPI_CTRLR0			0x00
>> @@ -72,6 +73,13 @@
>>  #define DWC_SSI_CTRLR0_FRF_OFFSET	6
>>  #define DWC_SSI_CTRLR0_DFS_OFFSET	0
>>  
>> +/*
>> + * Bit fields in CTRLR0 for DWC_apb_ssi v4 32-bits ctrlr0.
>> + * Based on DW_apb_ssi Databook v4.02a.
>> + */
>> +#define DWC_APB_CTRLR0_32_DFS_OFFSET	16
>> +#define DWC_APB_CTRLR0_32_DFS_MASK	GENMASK(20, 16)
>> +
>>  /*
>>   * For Keem Bay, CTRLR0[31] is used to select controller mode.
>>   * 0: SSI is slave
>> @@ -121,6 +129,7 @@ enum dw_ssi_type {
>>  #define DW_SPI_CAP_CS_OVERRIDE		BIT(0)
>>  #define DW_SPI_CAP_KEEMBAY_MST		BIT(1)
>>  #define DW_SPI_CAP_DWC_SSI		BIT(2)
>> +#define DW_SPI_CAP_DFS_32		BIT(3)
>>  
>>  /* Slave spi_transfer/spi_mem_op related */
>>  struct dw_spi_cfg {
>> -- 
>> 2.28.0
>>

