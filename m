Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 707792ABE99
	for <lists+linux-spi@lfdr.de>; Mon,  9 Nov 2020 15:25:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730354AbgKIOZf (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Nov 2020 09:25:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730035AbgKIOZe (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 9 Nov 2020 09:25:34 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58691C0613CF;
        Mon,  9 Nov 2020 06:25:34 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id s9so8801102ljo.11;
        Mon, 09 Nov 2020 06:25:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=URtdoNVy8gkPjkFeamValqRKNNb6u2NGeKTyfcPlO98=;
        b=DLaQop/BJeZDkogr8fvQz6LbxsL33OhxD4lqAi9SvHtRmZNBf2xTIyRTZyFGwyhiDl
         G9qOu8XSWJ+rZwZGks9jJwuWlBETaNerCEkGHK1/OzHxZhOXheXU1ffD8dsYrRpgGMF5
         +wS933P8s6M68Uwyf9RbC4q57O/2zbOyfsUPIPHMTjAbNXTTU90mhPNyCBlALqmRzhSp
         19brjatCQSXL7+vDornRUks5ZE/rv9Bnc8P8IeWJ1zdGcx9N7rtG9KwaTifYHv4Pgy9K
         ne+oXHaMtJYLd2O3IfEQ1sGoaUqOEtzGeTMgAurOtR52+4G0gUFk55IsVvleliEwWMdI
         +VNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=URtdoNVy8gkPjkFeamValqRKNNb6u2NGeKTyfcPlO98=;
        b=OQtLydJAvAYGJY3EpYz0JvtNoxyT9iSSfn8zXW6YpfqLCoG2nBbFbdOtRZZm9l4aF+
         47wEgAGCSPA+WoOH5O+lHBjPKC/Txp2z74VB4ZsPGmtdZU3viZyZ7ITPQJCdIk05BL3r
         oWjiz6Fes/i3aDaOwUmaRimXP861xJLTjk9csC/4f8IULOxb5HiYfIyGkZaBeTCmOjZM
         THGDdOizSNZdgkqBMa+3THx6+rM+iIiMcFmv9mZVrc9RBQ88admpYLl3z4XsHIN4NZNL
         tZTq6yXE/DJAg5t7jkWEwIQ+BFqKUpXj3evp1gTv+QDh4AwDBKv5WuEvtRjl9iWBpt0T
         NYug==
X-Gm-Message-State: AOAM531wxzAI12kgVq3oVDZnQB6nylK61Ga3HXaWT43X721WCYXVc21R
        0PzONCI9ThYXWFRlz6rOBMY=
X-Google-Smtp-Source: ABdhPJxzl/GFY/rQuAZ6payfqwMabYYZkaNwAFBFjC9q1uKdg7lmxSJpUdStg7dfVfrnJnzAPGbTPA==
X-Received: by 2002:a2e:9096:: with SMTP id l22mr2683281ljg.199.1604931932805;
        Mon, 09 Nov 2020 06:25:32 -0800 (PST)
Received: from mobilestation ([95.79.141.114])
        by smtp.gmail.com with ESMTPSA id 78sm2196319ljf.64.2020.11.09.06.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 06:25:32 -0800 (PST)
Date:   Mon, 9 Nov 2020 17:25:29 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        linux-clk@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>,
        Sean Anderson <seanga2@gmail.com>
Subject: Re: [PATCH 02/32] spi: dw: Add support for 32-bits ctrlr0 layout
Message-ID: <20201109142529.tt5ojjyn36vd3ohe@mobilestation>
References: <20201107081420.60325-1-damien.lemoal@wdc.com>
 <20201107081420.60325-3-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201107081420.60325-3-damien.lemoal@wdc.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello Damien,
Thanks for your patches. My comments are below.

On Sat, Nov 07, 2020 at 05:13:50PM +0900, Damien Le Moal wrote:
> Synopsis DesignWare DW_apb_ssi version 4 defines a 32-bit layout of
> the ctrlr0 register for SPI masters. The layout of ctrlr0 is:
> 
> |   31 .. 23  | 22 .. 21 | 20 .. 16 |
> | other stuff | spi_frf  |  dfs_32  |
> 
> |   15 .. 10  | 9 .. 8 | 7 .. 6 | 5 .. 4 | 3 .. 0 |
> | other stuff |  tmod  |  mode  |  frf   |  dfs   |
> 

> Th main difference of this layout with the 16-bits version is the data
    ^
    |
    e

> frame format field which resides in bits 16..20 instead of bits 3..0.
> 

Are you sure they have been moved from [0, 3] to [16, 20]? I don't have the
manual for the 4.0x version of the core, but according to this patch:
https://patchwork.kernel.org/project/spi-devel-general/patch/1575907443-26377-7-git-send-email-wan.ahmad.zainie.wan.mohamad@intel.com/
it has been ok to use the lowest four bits for DFS setting. Is the commit
message misleading there?

> Introduce the DW SPI capability flag DW_SPI_CAP_DFS_32 to let a
> platform signal that this layout is in use. Modify
> dw_spi_update_config() to test this capability flag to set the data
> frame format field at the correct register location.
> 
> Suggested-by: Sean Anderson <seanga2@gmail.com>
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> ---
>  drivers/spi/spi-dw-core.c | 8 ++++++--
>  drivers/spi/spi-dw.h      | 9 +++++++++
>  2 files changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
> index 2e50cc0a9291..841c85247f01 100644
> --- a/drivers/spi/spi-dw-core.c
> +++ b/drivers/spi/spi-dw-core.c
> @@ -311,8 +311,12 @@ void dw_spi_update_config(struct dw_spi *dws, struct spi_device *spi,
>  	u32 speed_hz;
>  	u16 clk_div;
>  

> -	/* CTRLR0[ 4/3: 0] Data Frame Size */
> -	cr0 |= (cfg->dfs - 1);
> +	if (!(dws->caps & DW_SPI_CAP_DFS_32))
> +		/* CTRLR0[ 4/3: 0] Data Frame Size */
> +		cr0 |= (cfg->dfs - 1);
> +	else
> +		/* CTRLR0[20: 16] Data Frame Size */
> +		cr0 |= (cfg->dfs - 1) << DWC_APB_CTRLR0_32_DFS_OFFSET;

If you extend the dfs field from four to five bits, then
controller->bits_per_word_mask field should be properly updated too.

Alas it hasn't been done for the DWC_ssi version of the core. So I suppose it
should be fixed for the both of them.

Just for the record. There are very handy macros for setting and getting bit fields
to/from a variable. This is a good place to use them instead of manually
shifting and defining the offsets. The macros are defined in linux/bitfield.h .
Alas this driver hasn't been converted to using them. So I won't insist on using
them here. But I hope someone will fix it sometime in future...

-Sergey

>  
>  	if (!(dws->caps & DW_SPI_CAP_DWC_SSI))
>  		/* CTRLR0[ 9:8] Transfer Mode */
> diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
> index faf40cb66498..48a11a51a407 100644
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
> @@ -72,6 +73,13 @@
>  #define DWC_SSI_CTRLR0_FRF_OFFSET	6
>  #define DWC_SSI_CTRLR0_DFS_OFFSET	0
>  
> +/*
> + * Bit fields in CTRLR0 for DWC_apb_ssi v4 32-bits ctrlr0.
> + * Based on DW_apb_ssi Databook v4.02a.
> + */
> +#define DWC_APB_CTRLR0_32_DFS_OFFSET	16
> +#define DWC_APB_CTRLR0_32_DFS_MASK	GENMASK(20, 16)
> +
>  /*
>   * For Keem Bay, CTRLR0[31] is used to select controller mode.
>   * 0: SSI is slave
> @@ -121,6 +129,7 @@ enum dw_ssi_type {
>  #define DW_SPI_CAP_CS_OVERRIDE		BIT(0)
>  #define DW_SPI_CAP_KEEMBAY_MST		BIT(1)
>  #define DW_SPI_CAP_DWC_SSI		BIT(2)
> +#define DW_SPI_CAP_DFS_32		BIT(3)
>  
>  /* Slave spi_transfer/spi_mem_op related */
>  struct dw_spi_cfg {
> -- 
> 2.28.0
> 
