Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C19C62CFBD5
	for <lists+linux-spi@lfdr.de>; Sat,  5 Dec 2020 16:52:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbgLEPlr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 5 Dec 2020 10:41:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbgLEOy1 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 5 Dec 2020 09:54:27 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02BE2C02B8DC;
        Sat,  5 Dec 2020 05:42:31 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id u18so11582542lfd.9;
        Sat, 05 Dec 2020 05:42:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PDCzWdLZZA1axQreot7zsOdbyWCaWe7wBryFmM/ZFaM=;
        b=qwbFubC9WoZvusbf1097U5V7gpHzlauouM2r19t42FKNyUglkvN3Ua+mY5QpeyIymJ
         uFg6V1Cq9QuHRJrrhCwuslXO2UEy1ZWNf1VakqPO92WUr1E8BRlUxkOkNsVTwxkmJp/S
         SMls9Nvf7PF0ctJcjBTOg9lrnOx29SUm1WrHomNXk6WVroEJs6D6dvliLkQdorSKOyIA
         7hgRULwPQyGCm9yxdBENAdsvv4QSAPQqpHNKKHbDio9EC66uxeHVG+9UnQ+NQ4NMC/4z
         20fpLJnc9vb5K/ioghAVE7l1H3GJ3eJMGolzBmGcE9I0wEuLfPCisjcUmwa3vhjw2VWc
         3sXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PDCzWdLZZA1axQreot7zsOdbyWCaWe7wBryFmM/ZFaM=;
        b=HWGYXAyUEe7+NVo3batw11P6vbuU8w6yctpJHFQQoP17Zpw39Fm7Ip3zK2zJL2d6tn
         WA0Z7Avq9gisQNwwZP4WYCy5Doe1KejCBxY3xek+3O+6tZvnGTX3o7rZo6GzIqdnMNsx
         7WFt+1N64CNVRewc26poX0zv+MZEMHBjjqeW4gsY3Apa7lMODxYn71UWXUXX2gGduyPi
         srJ+7hIW6MJugHhnRxF6UieNzZSJVZX2jHN2PtBqFDjVemmtJ1nphIJ+LwdqWaQ5t8nK
         Sv4tDgl445nhUgCHmrpuFX2RYjfGhFlVXQgfD/uFGmbGMjlvrXR68GnLS/QzGiNNUNgZ
         uYyw==
X-Gm-Message-State: AOAM533oZwZ/thZjWuYmE/8T0HrgbY1ETjsNhImNU05FiewkTD5fz64O
        e8GOrlzJ+ZxPanWmVSDYPHc=
X-Google-Smtp-Source: ABdhPJw2VRWID2gxQggjnyOheoxl1knRVcWmmUWrGxpCB4cHD3xNFhcMV2dPNs4qA2N61NowSiL1ng==
X-Received: by 2002:a05:6512:6d0:: with SMTP id u16mr4847355lff.497.1607175750317;
        Sat, 05 Dec 2020 05:42:30 -0800 (PST)
Received: from mobilestation ([95.79.141.114])
        by smtp.gmail.com with ESMTPSA id t3sm139634lfe.263.2020.12.05.05.42.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Dec 2020 05:42:29 -0800 (PST)
Date:   Sat, 5 Dec 2020 16:42:27 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Sean Anderson <seanga2@gmail.com>
Subject: Re: [PATCH v2 1/3] spi: dw: Add support for 32-bits max xfer size
Message-ID: <20201205134227.cuhjofkjm6k6k27d@mobilestation>
References: <20201126020049.35712-1-damien.lemoal@wdc.com>
 <20201126020049.35712-2-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201126020049.35712-2-damien.lemoal@wdc.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello Damien,
Sorry for a delay with response. Just a few nitpick below.

On Thu, Nov 26, 2020 at 11:00:47AM +0900, Damien Le Moal wrote:
> The Synopsis DesignWare DW_apb_ssi specifications version 3.23 onward
> define a 32-bits maximum transfer size synthesis parameter
> (SSI_MAX_XFER_SIZE=32) in addition to the legacy 16-bits configuration
> (SSI_MAX_XFER_SIZE=16) for SPI controllers. When SSI_MAX_XFER_SIZE=32,
> the layout of the ctrlr0 register changes, moving the data frame format
> field from bits [3..0] to bits [16..20], and the RX/TX FIFO word size
> can be up to 32-bits.
> 
> To support this new format, introduce the DW SPI capability flag
> DW_SPI_CAP_DFS32 to indicate that a controller is configured with
> SSI_MAX_XFER_SIZE=32. Since SSI_MAX_XFER_SIZE is a controller synthesis
> parameter not accessible through a register, the detection of this
> parameter value is done in spi_hw_init() by writing and reading the
> ctrlr0 register and testing the value of bits [3..0]. These bits are
> ignored (unchanged) for SSI_MAX_XFER_SIZE=16, allowing the detection.
> If a DFS32 capable SPI controller is detected, the new field dfs_offset
> in struct dw_spi is set to SPI_DFS32_OFFSET (16).
> 
> dw_spi_update_config() is modified to set the data frame size field at
> the correct position is the CTRLR0 register, as indicated by the
> dfs_offset field of the dw_spi structure.
> 

> The DW_SPI_CAP_DFS32 flag is also unconditionally set for SPI slave
> controllers, e.g. controllers that have the DW_SPI_CAP_DWC_SSI
> capability flag set. However, for these ssi controllers, the dfs_offset
> field is set to 0 as before (as per specifications).

DW_SPI_CAP_DWC_SSI is set for an enhanced version of the Synopsys DW
APB SPI controller called just DWC SSI. Please see the patch log for
details:
https://patchwork.kernel.org/project/spi-devel-general/patch/1575907443-26377-7-git-send-email-wan.ahmad.zainie.wan.mohamad@intel.com/

Since we indeed set the DW_SPI_CAP_DFS32 flag for the DWC SSI
controllers unconditionally then the code should have a corresponding
commented about it. Please see my next comment.

> 
> Finally, for any controller with the DW_SPI_CAP_DFS32 capability flag
> set, dw_spi_add_host() extends the value of bits_per_word_mask from
> 16-bits to 32-bits. dw_reader() and dw_writer() are also modified to
> handle 32-bits iTX/RX FIFO words.
> 
> Suggested-by: Sean Anderson <seanga2@gmail.com>
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> ---
>  drivers/spi/spi-dw-core.c | 44 ++++++++++++++++++++++++++++++++-------
>  drivers/spi/spi-dw.h      |  5 +++++
>  2 files changed, 42 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
> index 0b2236ade412..54166fcb2e5b 100644
> --- a/drivers/spi/spi-dw-core.c
> +++ b/drivers/spi/spi-dw-core.c
> @@ -137,14 +137,16 @@ static inline u32 rx_max(struct dw_spi *dws)
>  static void dw_writer(struct dw_spi *dws)
>  {
>  	u32 max = tx_max(dws);
> -	u16 txw = 0;
> +	u32 txw = 0;
>  
>  	while (max--) {
>  		if (dws->tx) {
>  			if (dws->n_bytes == 1)
>  				txw = *(u8 *)(dws->tx);
> -			else
> +			else if (dws->n_bytes == 2)
>  				txw = *(u16 *)(dws->tx);
> +			else
> +				txw = *(u32 *)(dws->tx);
>  
>  			dws->tx += dws->n_bytes;
>  		}
> @@ -156,15 +158,17 @@ static void dw_writer(struct dw_spi *dws)
>  static void dw_reader(struct dw_spi *dws)
>  {
>  	u32 max = rx_max(dws);
> -	u16 rxw;
> +	u32 rxw;
>  
>  	while (max--) {
>  		rxw = dw_read_io_reg(dws, DW_SPI_DR);
>  		if (dws->rx) {
>  			if (dws->n_bytes == 1)
>  				*(u8 *)(dws->rx) = rxw;
> -			else
> +			else if (dws->n_bytes == 2)
>  				*(u16 *)(dws->rx) = rxw;
> +			else
> +				*(u32 *)(dws->rx) = rxw;
>  
>  			dws->rx += dws->n_bytes;
>  		}
> @@ -311,8 +315,8 @@ void dw_spi_update_config(struct dw_spi *dws, struct spi_device *spi,
>  	u32 speed_hz;
>  	u16 clk_div;
>  
> -	/* CTRLR0[ 4/3: 0] Data Frame Size */
> -	cr0 |= (cfg->dfs - 1);
> +	/* CTRLR0[ 4/3: 0] or CTRLR0[ 20: 16] Data Frame Size */
> +	cr0 |= (cfg->dfs - 1) << dws->dfs_offset;
>  
>  	if (!(dws->caps & DW_SPI_CAP_DWC_SSI))
>  		/* CTRLR0[ 9:8] Transfer Mode */
> @@ -828,6 +832,29 @@ static void spi_hw_init(struct device *dev, struct dw_spi *dws)
>  		dev_dbg(dev, "Detected FIFO size: %u bytes\n", dws->fifo_len);
>  	}
>  

+       /*
+        * Detect CTRLR0.DFS field size and offset by testing the lowest bits
+        * writability. Note DWC SSI controller also has the extended DFS, but
+        * with zero offset.
+        */
> +	if (!(dws->caps & DW_SPI_CAP_DWC_SSI)) {
> +		u32 cr0, tmp = dw_readl(dws, DW_SPI_CTRLR0);
> +
> +		/*
> +		 * Detect APB SSI CTRLR0 DFS offset by looking at the data
> +		 * frame size field: for 32-bits data frame size, bits [3..0]
> +		 * (SPI_DFS_MASK) are ignored.
> +		 */

Please replace the comment you placed here with the comment above,
which aside of the DFS field usage for the maximum frame size
detection also states that the DWC SSI controller has the
extended frame size capability. After that feel free to add:

Acked-by: Serge Semin <fancer.lancer@gmail.com>

Please also note, that normally all the DTB-related patches should
come before the actual changes in patchset [1]. So the patch 3 in this
series should be at least first.

[1] Documentation/devicetree/bindings/submitting-patches.rst, line 40.

-Sergey

> +		spi_enable_chip(dws, 0);
> +		dw_writel(dws, DW_SPI_CTRLR0, 0xffffffff);
> +		cr0 = dw_readl(dws, DW_SPI_CTRLR0);
> +		dw_writel(dws, DW_SPI_CTRLR0, tmp);
> +		spi_enable_chip(dws, 1);
> +
> +		if (!(cr0 & SPI_DFS_MASK)) {
> +			dws->caps |= DW_SPI_CAP_DFS32;
> +			dws->dfs_offset = SPI_DFS32_OFFSET;
> +			dev_dbg(dev, "Detected 32-bits max data frame size\n");
> +		}
> +	} else {
> +		dws->caps |= DW_SPI_CAP_DFS32;
> +	}
> +
>  	/* enable HW fixup for explicit CS deselect for Amazon's alpine chip */
>  	if (dws->caps & DW_SPI_CAP_CS_OVERRIDE)
>  		dw_writel(dws, DW_SPI_CS_OVERRIDE, 0xF);
> @@ -864,7 +891,10 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
>  
>  	master->use_gpio_descriptors = true;
>  	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_LOOP;
> -	master->bits_per_word_mask =  SPI_BPW_RANGE_MASK(4, 16);
> +	if (dws->caps & DW_SPI_CAP_DFS32)
> +		master->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 32);
> +	else
> +		master->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 16);
>  	master->bus_num = dws->bus_num;
>  	master->num_chipselect = dws->num_cs;
>  	master->setup = dw_spi_setup;
> diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
> index faf40cb66498..b665e040862c 100644
> --- a/drivers/spi/spi-dw.h
> +++ b/drivers/spi/spi-dw.h
> @@ -9,6 +9,7 @@
>  #include <linux/io.h>
>  #include <linux/scatterlist.h>
>  #include <linux/spi/spi-mem.h>
> +#include <linux/bitfield.h>
>  
>  /* Register offsets */
>  #define DW_SPI_CTRLR0			0x00
> @@ -41,6 +42,8 @@
>  
>  /* Bit fields in CTRLR0 */
>  #define SPI_DFS_OFFSET			0
> +#define SPI_DFS_MASK			GENMASK(3, 0)
> +#define SPI_DFS32_OFFSET		16
>  
>  #define SPI_FRF_OFFSET			4
>  #define SPI_FRF_SPI			0x0
> @@ -121,6 +124,7 @@ enum dw_ssi_type {
>  #define DW_SPI_CAP_CS_OVERRIDE		BIT(0)
>  #define DW_SPI_CAP_KEEMBAY_MST		BIT(1)
>  #define DW_SPI_CAP_DWC_SSI		BIT(2)
> +#define DW_SPI_CAP_DFS32		BIT(3)
>  
>  /* Slave spi_transfer/spi_mem_op related */
>  struct dw_spi_cfg {
> @@ -148,6 +152,7 @@ struct dw_spi {
>  	unsigned long		paddr;
>  	int			irq;
>  	u32			fifo_len;	/* depth of the FIFO buffer */
> +	unsigned int		dfs_offset;     /* CTRLR0 DFS field offset */
>  	u32			max_mem_freq;	/* max mem-ops bus freq */
>  	u32			max_freq;	/* max bus freq supported */
>  
> -- 
> 2.28.0
> 
