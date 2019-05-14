Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 080D81C36E
	for <lists+linux-spi@lfdr.de>; Tue, 14 May 2019 08:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbfENGwV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 14 May 2019 02:52:21 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53006 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726324AbfENGwV (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 14 May 2019 02:52:21 -0400
Received: by mail-wm1-f67.google.com with SMTP id y3so1548784wmm.2
        for <linux-spi@vger.kernel.org>; Mon, 13 May 2019 23:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=nc1AT9QHLViQtI9mMaQ7ovxvK7zuTsBcT1i7PoGDlCc=;
        b=xrd1sHia8e0xNr+dj/10VK2b7xJdS4fagL8pZaGgZoB/KsMend2rW8Ymg1FNDGFq6x
         QfRlGS8MIL/M67sPSr3LgA0N1+ZHjbFSElo0EK+yPRSEWK+GlugW9WNxmPXcjPZdTctZ
         joAeBYnfxHVQw7GHykIsK4rRbJA8v1YwiljMVXyvIqxuAaXzXCSIKOWcD9wbXtBvSWyV
         lcRT4QRyiQYGekFi92x10zoo6IIGZQX4AK/JfcLHbi8NoKT0ZMLYxNGrmY/ZFo80vWlG
         f8kbw2HtTjua7Id8c92QCQxy/Z+7/Gus3Ws6aQAuLKRfChB8te92czBAEA/1kdaROMZ9
         uOIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=nc1AT9QHLViQtI9mMaQ7ovxvK7zuTsBcT1i7PoGDlCc=;
        b=UiXOn4mC9Xze2COs83kRcw/WahbfGzMwQzhfXm/cw1jD76pRzcTmb7Fpu7YCxcvt0S
         nf3GvB/46eOkLPsVnY9vtkSEr8qa+skX98R2mwaiRW8MyFlsO+N/JHdXCF397+k9Ty93
         5xeYGG886+6Grm00yUTSxn1qvotvF5y9O7C9FNnmzBn2wCN9b+6CZ5XVbQfY8hcgLM48
         7znkMccOehvp2/Bt8zVKlBdqRXrLIc37SzKOI0uewssw68qaEGOM4cv4Ls9xG+xPwRMP
         ygMUFu34fB5CNSbVOseVwbn3DW2CfkHqkbcyIup4LVh1+y/zDu4pcWjVOTBkWnJujgJ7
         rLBg==
X-Gm-Message-State: APjAAAUNuSERqP2SmCEeDwh01hyrg4TqLyiUlUIIGpkvqfsNvZeEwLd7
        fdcyrJUz1+kxoK+FWcrKbwQprw==
X-Google-Smtp-Source: APXvYqyxzx7+zkK9CsHaTlkS3oQgg2TaUpQ5iJps/9Iep8Joa7x7rdKPDOe/37WF/phHJvAynRfjKw==
X-Received: by 2002:a05:600c:22cc:: with SMTP id 12mr6410903wmg.141.1557816738473;
        Mon, 13 May 2019 23:52:18 -0700 (PDT)
Received: from dell ([2.27.167.43])
        by smtp.gmail.com with ESMTPSA id h8sm1859415wmf.5.2019.05.13.23.52.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 May 2019 23:52:17 -0700 (PDT)
Date:   Tue, 14 May 2019 07:52:16 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Mason Yang <masonccyang@mxic.com.tw>
Cc:     broonie@kernel.org, marek.vasut@gmail.com,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        bbrezillon@kernel.org, linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        sergei.shtylyov@cogentembedded.com, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        juliensu@mxic.com.tw, Simon Horman <horms@verge.net.au>,
        zhengxunli@mxic.com.tw
Subject: Re: [PATCH v12 2/3] spi: Add Renesas R-Car Gen3 RPC-IF SPI
 controller driver
Message-ID: <20190514065216.GL4319@dell>
References: <1556092536-17095-1-git-send-email-masonccyang@mxic.com.tw>
 <1556092536-17095-3-git-send-email-masonccyang@mxic.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1556092536-17095-3-git-send-email-masonccyang@mxic.com.tw>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 24 Apr 2019, Mason Yang wrote:

> Add a driver for Renesas R-Car Gen3 RPC-IF SPI controller.
> 
> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> ---
>  drivers/spi/Kconfig           |   6 +
>  drivers/spi/Makefile          |   1 +
>  drivers/spi/spi-renesas-rpc.c | 571 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 578 insertions(+)
>  create mode 100644 drivers/spi/spi-renesas-rpc.c
> 
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index f761655..1f52bcf 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -564,6 +564,12 @@ config SPI_RSPI
>  	help
>  	  SPI driver for Renesas RSPI and QSPI blocks.
>  
> +config SPI_RENESAS_RPC
> +	tristate "Renesas R-Car Gen3 RPC-IF controller"
> +	depends on ARCH_RENESAS || COMPILE_TEST
> +	help
> +	  SPI driver for Renesas R-Car Gen3 RPC-IF.
> +
>  config SPI_QCOM_QSPI
>  	tristate "QTI QSPI controller"
>  	depends on ARCH_QCOM
> diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
> index d8fc03c..b3a3deb 100644
> --- a/drivers/spi/Makefile
> +++ b/drivers/spi/Makefile
> @@ -86,6 +86,7 @@ obj-$(CONFIG_SPI_QUP)			+= spi-qup.o
>  obj-$(CONFIG_SPI_ROCKCHIP)		+= spi-rockchip.o
>  obj-$(CONFIG_SPI_RB4XX)			+= spi-rb4xx.o
>  obj-$(CONFIG_SPI_RSPI)			+= spi-rspi.o
> +obj-$(CONFIG_SPI_RENESAS_RPC)		+= spi-renesas-rpc.o
>  obj-$(CONFIG_SPI_S3C24XX)		+= spi-s3c24xx-hw.o
>  spi-s3c24xx-hw-y			:= spi-s3c24xx.o
>  spi-s3c24xx-hw-$(CONFIG_SPI_S3C24XX_FIQ) += spi-s3c24xx-fiq.o
> diff --git a/drivers/spi/spi-renesas-rpc.c b/drivers/spi/spi-renesas-rpc.c
> new file mode 100644
> index 0000000..c2202d4
> --- /dev/null
> +++ b/drivers/spi/spi-renesas-rpc.c
> @@ -0,0 +1,571 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// Copyright (C) 2018 ~ 2019 Renesas Solutions Corp.
> +// Copyright (C) 2019 Macronix International Co., Ltd.
> +//
> +// R-Car Gen3 RPC-IF SPI/QSPI/Octa driver
> +//
> +// Author:
> +//	Mason Yang <masonccyang@mxic.com.tw>
> +//
> +
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +#include <linux/log2.h>
> +#include <linux/iopoll.h>
> +#include <linux/mfd/renesas-rpc.h>
> +#include <linux/module.h>
> +#include <linux/mtd/mtd.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/regmap.h>
> +#include <linux/reset.h>
> +#include <linux/spi/spi.h>
> +#include <linux/spi/spi-mem.h>
> +
> +#include <asm/unaligned.h>
> +
> +struct rpc_spi {
> +	struct rpc_mfd *mfd;

The term MFD isn't a real thing.  What you're obtaining below is
driver data and is normally articulated as 'ddata' in drivers.

> +	u32 cur_speed_hz;
> +	u32 cmd;
> +	u32 addr;
> +	u32 dummy;
> +	u32 smcr;
> +	u32 smenr;
> +	u32 xferlen;
> +	u32 totalxferlen;
> +	enum spi_mem_data_dir xfer_dir;
> +};

[...]

> +static void rpc_spi_hw_init(struct rpc_spi *rpc)
> +{
> +	//
> +	// NOTE: The 0x260 are undocumented bits, but they must be set.
> +	//	 RPC_PHYCNT_STRTIM is strobe timing adjustment bit,
> +	//	 0x0 : the delay is biggest,
> +	//	 0x1 : the delay is 2nd biggest,
> +	//	 On H3 ES1.x, the value should be 0, while on others,
> +	//	 the value should be 6.
> +	//

C++ style comments?  Is that a thing now?

> +	regmap_write(rpc->mfd->regmap, RPC_PHYCNT, RPC_PHYCNT_CAL |
> +				  RPC_PHYCNT_STRTIM(6) | 0x260);
> +
> +	//
> +	// NOTE: The 0x1511144 are undocumented bits, but they must be set
> +	//       for RPC_PHYOFFSET1.
> +	//	 The 0x31 are undocumented bits, but they must be set
> +	//	 for RPC_PHYOFFSET2.
> +	//
> +	regmap_write(rpc->mfd->regmap, RPC_PHYOFFSET1,
> +		     RPC_PHYOFFSET1_DDRTMG(3) | 0x1511144);
> +	regmap_write(rpc->mfd->regmap, RPC_PHYOFFSET2, 0x31 |
> +		     RPC_PHYOFFSET2_OCTTMG(4));
> +	regmap_write(rpc->mfd->regmap, RPC_SSLDR, RPC_SSLDR_SPNDL(7) |
> +		     RPC_SSLDR_SLNDL(7) | RPC_SSLDR_SCKDL(7));
> +	regmap_write(rpc->mfd->regmap, RPC_CMNCR, RPC_CMNCR_MD |
> +		     RPC_CMNCR_SFDE | RPC_CMNCR_MOIIO_HIZ | RPC_CMNCR_IOFV_HIZ |
> +		     RPC_CMNCR_BSZ(0));
> +}

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
