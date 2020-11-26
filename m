Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFA312C4E1C
	for <lists+linux-spi@lfdr.de>; Thu, 26 Nov 2020 05:57:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387616AbgKZEz0 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 25 Nov 2020 23:55:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387550AbgKZEzZ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 25 Nov 2020 23:55:25 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2449DC0613D4;
        Wed, 25 Nov 2020 20:55:24 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id i199so631974qke.5;
        Wed, 25 Nov 2020 20:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YT3iMqUBEOsrQBEMcM3xgcHTlT9VcWQO2mepiTz1M78=;
        b=ovANhIJTpO7fmsp58F4IUQf2jcyxJhYbLESq7UGnEetBkWa6LjSG9cSFpmsoDTmhoV
         5Iot0yMmbEZaikwRjOsejk0izZCMd5B3FvLhSFWtnNj/cJgr6/x/PRAkejntVi4cL0Ga
         JlnnNxGCXab1IpY5YWkOj/qT41yAFcjQZidkxR5e9o10SZ2qYQtc/MnZdFS2HEWv7wBY
         nCPMYsdvcfZ6u/VJx9ADXu1miqqOJoD8tfdWYYaD4A0OHMm8yrert1+g0qVMWQNluZgu
         2k6wFbHyv7CaNj1OLavuhXVc+7YAdqgFrJOyYm1XxQ7NbzO1+2yO7XIetQ84E6OTD3m7
         bV5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YT3iMqUBEOsrQBEMcM3xgcHTlT9VcWQO2mepiTz1M78=;
        b=pYoWrU/m1KyCOCVSc09f9ify1yUPBHqI8sBoiuqQMFOiY4E8m7nfbAxQF2szr5ZcYL
         kyfkXBjGNywWEloVSLZKf8CtBEqCawuVcH3tq01q1ryLzTPCw3UeZYEAG6+/JrjwERNg
         8l++Jfko5fz2Ek2dfhlPRT1q+TdxbZ6SJAyEmXtaoYQ04LEPBSEl1v8m8MY63nnyGq/c
         EHCoYw2Vg21KIaJ7mb4QKOP5gk9KQBeiVP/NaXrygANsc0o/1dn2dOW4hE7o9/mNUVZR
         Dzjxm8ewSyquge70zG62/Qpgi4mgkDStTmiQFWCUlKnKFTrdtSfo8UJzMEKJXFZOZRMM
         CnVQ==
X-Gm-Message-State: AOAM533/wxWlfnFp1aTgQ+NWUm7v0C+/AEJw8+lCgNA7Cg+xGh2Fkg21
        FIyu8IITKawMLoSDHbSF8JKTieJu++X06Q==
X-Google-Smtp-Source: ABdhPJyoZnYOX9kgrpEdgSDDbp47RSnP4VQ6KP/r9UA1FCHr+38CwZYiUS/Hr7Um7wWUqe8piGoacQ==
X-Received: by 2002:a05:620a:559:: with SMTP id o25mr1513434qko.475.1606366522888;
        Wed, 25 Nov 2020 20:55:22 -0800 (PST)
Received: from [192.168.1.201] (pool-108-51-35-162.washdc.fios.verizon.net. [108.51.35.162])
        by smtp.googlemail.com with ESMTPSA id t2sm1873611qkb.2.2020.11.25.20.55.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2020 20:55:22 -0800 (PST)
Subject: Re: [PATCH 1/3] spi: dw: Add support for 32-bits max xfer size
To:     Serge Semin <fancer.lancer@gmail.com>,
        Damien Le Moal <damien.lemoal@wdc.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
References: <20201119120253.390883-1-damien.lemoal@wdc.com>
 <20201119120253.390883-2-damien.lemoal@wdc.com>
 <20201125195221.3pnqipxej3ta7rlc@mobilestation>
From:   Sean Anderson <seanga2@gmail.com>
Message-ID: <82628758-d7a0-299c-51d1-4960dcea2809@gmail.com>
Date:   Wed, 25 Nov 2020 23:55:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201125195221.3pnqipxej3ta7rlc@mobilestation>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 11/25/20 2:52 PM, Serge Semin wrote:
> Damien,
> 
> Thanks for sending the patch. My comments are below.
> 
> On Thu, Nov 19, 2020 at 09:02:51PM +0900, Damien Le Moal wrote:
>> Synopsis DesignWare DW_apb_ssi version 3.23 onward defines a 32-bits
>> maximum transfer size synthesis parameter (SSI_MAX_XFER_SIZE=32) in
>> addition to the legacy 16-bits configuration (SSI_MAX_XFER_SIZE=16) for
>> SPI controllers.  When SSI_MAX_XFER_SIZE=32, the layout of the ctrlr0
>> register changes and RX/TX FIFO words can be up to 32-bits.
>>
>> The layout of ctrlr0 change for the 32-bits configuration moves the
>> data frame format field to bits 16..20 instead of bits 3..0
>> when the controller is configured with SSI_MAX_XFER_SIZE=16.
>>
>> Introduce the DW SPI capability flag DW_SPI_CAP_DWC_APB_XFER32 to
>> indicate in that the controller is configured with SSI_MAX_XFER_SIZE=32.
>> Since the SSI_MAX_XFER_SIZE parameter is a controller synthesis
>> parameter not accessible through a register, the detection of this
>> parameter value is done in spi_hw_init() by writing and reading the
>> ctrlr0 register and testing the value of bits 20..16.
>>
>> The DW_SPI_CAP_DWC_APB_XFER32 flag is used in dw_spi_update_config() to
>> set the data frame size field at the correct position and in
>> dw_spi_add_host() to extend bits_per_word_mask to 32-bits.
>> dw_reader() and dw_writer() are also modified to handle 32-bits FIFO
>> words.
>>
>> Suggested-by: Sean Anderson <seanga2@gmail.com>
>> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
>> ---
>>   drivers/spi/spi-dw-core.c | 40 ++++++++++++++++++++++++++++++++-------
>>   drivers/spi/spi-dw.h      |  8 ++++++++
>>   2 files changed, 41 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
>> index 2e50cc0a9291..4c16832b16fd 100644
>> --- a/drivers/spi/spi-dw-core.c
>> +++ b/drivers/spi/spi-dw-core.c
>> @@ -137,14 +137,16 @@ static inline u32 rx_max(struct dw_spi *dws)
>>   static void dw_writer(struct dw_spi *dws)
>>   {
>>   	u32 max = tx_max(dws);
>> -	u16 txw = 0;
>> +	u32 txw = 0;
>>   
>>   	while (max--) {
>>   		if (dws->tx) {
>>   			if (dws->n_bytes == 1)
>>   				txw = *(u8 *)(dws->tx);
>> -			else
>> +			else if (dws->n_bytes == 2)
>>   				txw = *(u16 *)(dws->tx);
>> +			else
>> +				txw = *(u32 *)(dws->tx);
>>   
>>   			dws->tx += dws->n_bytes;
>>   		}
>> @@ -156,15 +158,17 @@ static void dw_writer(struct dw_spi *dws)
>>   static void dw_reader(struct dw_spi *dws)
>>   {
>>   	u32 max = rx_max(dws);
>> -	u16 rxw;
>> +	u32 rxw;
>>   
>>   	while (max--) {
>>   		rxw = dw_read_io_reg(dws, DW_SPI_DR);
>>   		if (dws->rx) {
>>   			if (dws->n_bytes == 1)
>>   				*(u8 *)(dws->rx) = rxw;
>> -			else
>> +			else if (dws->n_bytes == 2)
>>   				*(u16 *)(dws->rx) = rxw;
>> +			else
>> +				*(u32 *)(dws->rx) = rxw;
>>   
>>   			dws->rx += dws->n_bytes;
>>   		}
>> @@ -311,8 +315,12 @@ void dw_spi_update_config(struct dw_spi *dws, struct spi_device *spi,
>>   	u32 speed_hz;
>>   	u16 clk_div;
>>   
> 
>> -	/* CTRLR0[ 4/3: 0] Data Frame Size */
>> -	cr0 |= (cfg->dfs - 1);
>> +	if (!(dws->caps & DW_SPI_CAP_DWC_APB_XFER32))
>> +		/* CTRLR0[ 4/3: 0] Data Frame Size */
>> +		cr0 |= (cfg->dfs - 1);
>> +	else
>> +		/* CTRLR0[20: 16] Data Frame Size */
>> +		cr0 |= FIELD_PREP(DWC_APB_CTRLR0_DFS32_MASK, cfg->dfs - 1);
> 
> Instead of constantly checking the capability flag here I'd suggest to add
> a new dfs_off member to the private data. Like this:
> --- a/drivers/spi/spi-dw.h
> +++ b/drivers/spi/spi-dw.h
> @@ -148,6 +148,7 @@ struct dw_spi {
>          unsigned long           paddr;
>          int                     irq;
>          u32                     fifo_len;       /* depth of the FIFO buffer */
> +       int                     dfs_off;        /* DFS field offset */
>          u32                     max_mem_freq;   /* max mem-ops bus freq */
>          u32                     max_freq;       /* max bus freq supported */
> 
> Then the only thing you'd need to add here is:
> -	/* CTRLR0[ 4/3: 0] Data Frame Size */
> -	cr0 |= (cfg->dfs - 1);
> +	/* CTRLR0[ 4/3: 0]/CTRLR0[ 20: 16] Data Frame Size */
> +	cr0 |= (cfg->dfs - 1) << dws->dfs_off;
> 
> * Note SPI core guarantees that bits_per_word is within the bits_per_word_mask
> * initialized in the SPI controller descriptor.
> 
>>   
>>   	if (!(dws->caps & DW_SPI_CAP_DWC_SSI))
>>   		/* CTRLR0[ 9:8] Transfer Mode */
>> @@ -828,6 +836,21 @@ static void spi_hw_init(struct device *dev, struct dw_spi *dws)
>>   		dev_dbg(dev, "Detected FIFO size: %u bytes\n", dws->fifo_len);
>>   	}
>>   
>> +	if (!(dws->caps & DW_SPI_CAP_DWC_SSI)) {
>> +		u32 cr0;
>> +
>> +		/*
>> +		 * Detect APB SSI CTRLR0 size by looking at the data
>> +		 * frame size field.
>> +		 */
> 
>> +		dw_writel(dws, DW_SPI_CTRLR0, 0xffffffff);
> 
> This isn't going to work because you need to disable the SSI controller
> first. Then please revert the change or cleanup the register and disable
> the controller back after finishing the detection.

In U-Boot at least, ctrlr0 is written before every transfer, so there is
no need to restore it afterward. Same for enr. I don't know whether this
holds true for Linux.

--Sean

> 
>> +		cr0 = dw_readl(dws, DW_SPI_CTRLR0);
> 
>> +		if (FIELD_GET(DWC_APB_CTRLR0_DFS32_MASK, cr0)) {
> 
> Instead of reading the DFS_32 field state I'd suggest to read the normal
> DFS bits as Sean does in the patch:
> https://patchwork.ozlabs.org/project/uboot/patch/20201016225755.302659-10-seanga2@gmail.com/
> 
> That'd be better because we can't guarantee what some older versions of
> the DW APB SSI controller preserve zeros in the upper part of CTRLR0, but
> we are sure the DFS field will always have zeros if DW APB SSI is
> synthesized with SSI_MAX_XFER_SIZE == 32.
> 
> So instead of having a new DWC_APB_CTRLR0_DFS32_MASK mask declared you'll
> need to add the macros as following:
> --- a/drivers/spi/spi-dw.h
> +++ b/drivers/spi/spi-dw.h
> @@ -41,6 +41,7 @@
>   
>   /* Bit fields in CTRLR0 */
>   #define SPI_DFS_OFFSET                 0
> +#define SPI_DFS_MASK                   GENMASK(3, 0)
> +#define SPI_DFS32_OFFSET		16
>   
>   #define SPI_FRF_OFFSET                 4
>   #define SPI_FRF_SPI                    0x0
> 
> The SPI_DFS32_OFFSET macro will be needed to initialize the dfs_off member
> if DFS32 capability is detected.
> 
>> +			dev_dbg(dev, "Detected 32-bits max data frame size\n");
> 
>> +			dws->caps |= DW_SPI_CAP_DWC_APB_XFER32;
> 
> I suggest to rename the flag to DW_SPI_CAP_DFS32, because it will be
> set for both DW APB SSI v4 (in fact for v3.23a and newer (see the Sean'
> patch log), but never mind) and DW SSI controllers. See the next comment
> for details of implementation.
> 
>> +		}
>> +	}
> 
> To sum up what I said above the detection procedure would look like this
> (note it's untested...):
> 
> +	/*
> +	 * Detect CTRLR0.DFS field size and offset by testing the lowest bits
> +	 * writability. Note DW SSI controller also has the extended DFS, but
> +	 * with zero offset.
> +	 */
> +	if (!(dws->caps & DW_SPI_CAP_DWC_SSI)) {
> +		u32 cr0, tmp = dw_readl(dws, DW_SPI_CTRLR0);
> +
> +		spi_enable_chip(dws, 0);
> +		dw_writel(dws, DW_SPI_CTRLR0, 0xffffffff);
> +		cr0 = dw_readl(dws, DW_SPI_CTRLR0);
> +		dw_writel(dws, DW_SPI_CTRLR0, tmp);
> +		spi_enable_chip(dws, 1);
> +		if (!(cr0 & SPI_DFS_MASK)) {
> +			dev_dbg(dev, "Detected 32-bits max data frame size\n");
> +			dws->caps |= DW_SPI_CAP_DFS32;
> *			dws->dfs_off = SPI_DFS32_OFFSET;
> +		}
> +	} else {
> +		dws->caps |= DW_SPI_CAP_DFS32;
> +	}
> 
> Note I've added the DW SSI fix here as it was suggested in a comment to
> your previous patchset revision...
> 
>> +
>>   	/* enable HW fixup for explicit CS deselect for Amazon's alpine chip */
>>   	if (dws->caps & DW_SPI_CAP_CS_OVERRIDE)
>>   		dw_writel(dws, DW_SPI_CS_OVERRIDE, 0xF);
>> @@ -864,7 +887,10 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
>>   
>>   	master->use_gpio_descriptors = true;
>>   	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_LOOP;
>> -	master->bits_per_word_mask =  SPI_BPW_RANGE_MASK(4, 16);
> 
>> +	if (dws->caps & DW_SPI_CAP_DWC_APB_XFER32)
> 
> Please use the DW_SPI_CAP_DFS32 capability flag here.
> 
>> +		master->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 32);
>> +	else
>> +		master->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 16);
> 
> So this part of your fix will work for all types of controllers:
> - DW APB SSI v3.22a and older
> - DW APB SSI v3.23a and newer with SSI_MAX_XFER_SIZE == 16
> - DW APB SSI v3.23a and newer with SSI_MAX_XFER_SIZE == 32
> - DW SSI v1.*
> 
>>   	master->bus_num = dws->bus_num;
>>   	master->num_chipselect = dws->num_cs;
>>   	master->setup = dw_spi_setup;
>> diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
>> index faf40cb66498..cba5c1f8c456 100644
>> --- a/drivers/spi/spi-dw.h
>> +++ b/drivers/spi/spi-dw.h
>> @@ -9,6 +9,7 @@
>>   #include <linux/io.h>
>>   #include <linux/scatterlist.h>
>>   #include <linux/spi/spi-mem.h>
>> +#include <linux/bitfield.h>
>>   
>>   /* Register offsets */
>>   #define DW_SPI_CTRLR0			0x00
>> @@ -72,6 +73,12 @@
>>   #define DWC_SSI_CTRLR0_FRF_OFFSET	6
>>   #define DWC_SSI_CTRLR0_DFS_OFFSET	0
>>
>   
>> +/*
>> + * Data frame size bits mask in CTRLR0 for DWC_apb_ssi v4 when the
>> + * controller capability supports DW_SPI_CAP_DWC_APB_XFER32.
>> + */
> 
>> +#define DWC_APB_CTRLR0_DFS32_MASK	GENMASK(20, 16)
> 
> This won't be needed if you implement the fix as I suggest.
> 
>> +
>>   /*
>>    * For Keem Bay, CTRLR0[31] is used to select controller mode.
>>    * 0: SSI is slave
>> @@ -121,6 +128,7 @@ enum dw_ssi_type {
>>   #define DW_SPI_CAP_CS_OVERRIDE		BIT(0)
>>   #define DW_SPI_CAP_KEEMBAY_MST		BIT(1)
>>   #define DW_SPI_CAP_DWC_SSI		BIT(2)
> 
>> +#define DW_SPI_CAP_DWC_APB_XFER32	BIT(3)
> 
> Please replace it with DW_SPI_CAP_DFS32, since the capability flag
> will be used for the DW APB SSI v3.23a and newer and DW SSI controllers.
> 
> -Sergey
> 
>>   
>>   /* Slave spi_transfer/spi_mem_op related */
>>   struct dw_spi_cfg {
>> -- 
>> 2.28.0
>>

