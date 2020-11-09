Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45D132AC72A
	for <lists+linux-spi@lfdr.de>; Mon,  9 Nov 2020 22:23:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730847AbgKIVWH (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Nov 2020 16:22:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727311AbgKIVWH (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 9 Nov 2020 16:22:07 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BDF2C0613CF;
        Mon,  9 Nov 2020 13:22:07 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id f11so8227703lfs.3;
        Mon, 09 Nov 2020 13:22:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=erGCDfk1T8jj0P66ygwuQHbBulQ+TeFa6YVDO6ZXBrI=;
        b=HG+R+afcnVk+JjnjUT4bLntCCRkeqWjO387aQAi+qWzlwVcG+x3ZmJm9yTlfS8vZnY
         wmuDwnkEnegAgv6C5dTgRaW1B7M92a6LzgvNvuyaXmkItwo+wXXyWwHn2SXlLrmNgytF
         qlsNWkDzkkolZpnHrU1Gx23bcfr0Gc27muvTkFm2qe0XjIkSYs9P2Z2Qr5mY5ToXiKL3
         A6VKW4z2BA3xUKuP7belL/6Zl25hG6zOzmMeVSMZsKEQC2mZqIL8VNFq+PvL0uefMuen
         0BW33KF7X6JHunCeDl42YzJDddCRT+W5fGfoFVHtG1If9YgyJZKzR0lOPJ/jeARFvqCk
         kJyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=erGCDfk1T8jj0P66ygwuQHbBulQ+TeFa6YVDO6ZXBrI=;
        b=AAW2rpmqKGLxRR6o92FWbaqvnccLpGK7RqCllqwPtLqmDw/coMHuHQWsdvuows3W0Q
         zQQAwYdbGckyEcCGbOCWt5HOpYxDYTsoL36VOrcRmSwC4qN4akKn/QqzwcpmTloXrqp/
         e6Oia2DnGBJOtNlzcMtrid3IXzIzk3MsAcVQvLxCWoAUwggaEYAU6bs3lcZcg2W5MqgP
         HiqvmfjlCdyPjeoRU/4Z87Pii4/jQGAFeSr8hW8qmf/GzKTIpUjVMbjl+UE9XUHU09bF
         nAYcyRYbm6R7s0Yl/UHlPWRJ1oy+MBwzbjNJkcnr89P3jeBL58U9yPCYPHNi7HnDtfzT
         edbQ==
X-Gm-Message-State: AOAM531MX9VYrFXUqWguGqJoeS9Pi9B7S37dr6g+33TWt9ezM2ypClBN
        J3Pg9QvLmAEeL5x7YM1B3Fw=
X-Google-Smtp-Source: ABdhPJyckhHVzvlbB8NBnv1YJ+bafHBWpymTA8AujTFSZMEi2aaWRiumfgLTTGBMDdsK6VkU/3Xfgw==
X-Received: by 2002:a19:3ce:: with SMTP id 197mr6794065lfd.364.1604956925708;
        Mon, 09 Nov 2020 13:22:05 -0800 (PST)
Received: from mobilestation ([95.79.141.114])
        by smtp.gmail.com with ESMTPSA id x8sm1400561lff.196.2020.11.09.13.22.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 13:22:05 -0800 (PST)
Date:   Tue, 10 Nov 2020 00:21:58 +0300
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
Subject: Re: [PATCH 06/32] spi: dw: Add support for the Kendryte K210 SoC
Message-ID: <20201109212158.y34otj3uy2hev75c@mobilestation>
References: <20201107081420.60325-1-damien.lemoal@wdc.com>
 <20201107081420.60325-7-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201107081420.60325-7-damien.lemoal@wdc.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sat, Nov 07, 2020 at 05:13:54PM +0900, Damien Le Moal wrote:
> The DW SPI master of the Kendryte K210 RISC-V SoC uses the 32-bits
> ctrlr0 register format. This SoC is also quite slow and gets significant
> SD card performance improvements from using no-delay polled transfers.
> Add the dw_spi_k210_init() function tied to the
> "canaan,kendryte-k210-spi" compatible string to set the
> DW_SPI_CAP_DFS_32 and DW_SPI_CAP_POLL_NODELAY DW SPI capability fields
> for this SoC.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> ---
>  drivers/spi/spi-dw-mmio.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
> index 3f1bc384cb45..a00def6c5b39 100644
> --- a/drivers/spi/spi-dw-mmio.c
> +++ b/drivers/spi/spi-dw-mmio.c
> @@ -223,6 +223,14 @@ static int dw_spi_keembay_init(struct platform_device *pdev,
>  	return 0;
>  }
>  
> +static int dw_spi_k210_init(struct platform_device *pdev,
> +			    struct dw_spi_mmio *dwsmmio)
> +{
> +	dwsmmio->dws.caps = DW_SPI_CAP_DFS_32 | DW_SPI_CAP_POLL_NODELAY;
> +
> +	return 0;
> +}
> +
>  static int dw_spi_mmio_probe(struct platform_device *pdev)
>  {
>  	int (*init_func)(struct platform_device *pdev,
> @@ -340,6 +348,7 @@ static const struct of_device_id dw_spi_mmio_of_match[] = {
>  	{ .compatible = "snps,dwc-ssi-1.01a", .data = dw_spi_dwc_ssi_init},
>  	{ .compatible = "intel,keembay-ssi", .data = dw_spi_keembay_init},
>  	{ .compatible = "microchip,sparx5-spi", dw_spi_mscc_sparx5_init},

> +	{ .compatible = "canaan,kendryte-k210-spi", .data = dw_spi_k210_init},

Other than the comments from Sean and Mark regarding the DFS_32
feature runtime detectability, I couldn't find a patch with adding the
new new compatible string into the DW APB SSI DT schema. Have I missed
it? If I haven't could you add one to the next version of the series?

-Sergey

>  	{ /* end of table */}
>  };
>  MODULE_DEVICE_TABLE(of, dw_spi_mmio_of_match);
> -- 
> 2.28.0
> 
