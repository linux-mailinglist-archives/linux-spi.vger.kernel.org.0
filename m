Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97D1B2C409A
	for <lists+linux-spi@lfdr.de>; Wed, 25 Nov 2020 13:53:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728786AbgKYMw5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 25 Nov 2020 07:52:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728220AbgKYMw4 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 25 Nov 2020 07:52:56 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45521C0613D4;
        Wed, 25 Nov 2020 04:52:56 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id s30so2985443lfc.4;
        Wed, 25 Nov 2020 04:52:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=urPGq1a0K3HV+G//N3k7ThR99vOri/JPZU0hkomczSg=;
        b=L+Fn/QTFrZ8ugu/pvw2dOx6UvuY6zXb7/cd2lrQiynPzORXZ0hzG8JwXmExNPdieZ0
         be8fJwqgd8TdMh3ovL2vYuQJtrRPWCpyP9E4KerVZntSAyjGKEHNKUvovxgv2rnZRYJ9
         oaezu4py74nE9A58/XP8M6tEwGqN4aHDJjjnzkjpNh5CLpsraAJz9pueDLXvcw8fItLK
         F7aHC3Yqfsss4e/+NB+x6Wzdz8PMdGMTxXq+PZpJML6+dr64FFmv+havPtz/gy+zXTnR
         l0vaha00e85McAVyZF9QZ0Wt3J/nNvUvRUtbpfM8OvdIEfJaGlSaJxFDUCPK1Z1g01z4
         YZzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=urPGq1a0K3HV+G//N3k7ThR99vOri/JPZU0hkomczSg=;
        b=qoMiZgks7iIiPNUo8vMfpb3b5FmeK7i0Lazk7iYg/Sac6Vd6j6fbujiFl6LdmxU0VT
         n7MKesw93SdALevPPbEOtRqMAtT6jV1/yDP7mj0GpQKNlBs/cNsh+zOg3jBvzg9MopAZ
         u3MLXlUISMCsNuPP6+1PNEmXch7sWEnGiYAUpe7qj9ui5vL7pR9BZ5l80yBKmTc3cvuB
         ILF43NhZ/n3JiN1MkuErsDBllIkcgctIL+30JHI0xvLoNELi5s52dkyEY5tc9olQ3ZPs
         E/7aAi2VwOAklz7ptwFik6x5yg2miH9YKQ1+Q8QqfyemVvhk4XNsAhrRr3SCKn+aUZFj
         PLrg==
X-Gm-Message-State: AOAM531z5Ru480LsGBVYdnpGCdCbczwQlSpkkWFG7lLzKPQJPOyqbpG+
        daUazH8og/1SWuAmlzA24w2WzhiK6ys=
X-Google-Smtp-Source: ABdhPJx5hjy4wX/v/+pc7HFEppTdxfl6AEa7clGrms7A41AK10tlx7NvbhWQn20KSTVSe0lPMEhabQ==
X-Received: by 2002:ac2:4844:: with SMTP id 4mr1215581lfy.64.1606308774773;
        Wed, 25 Nov 2020 04:52:54 -0800 (PST)
Received: from mobilestation ([95.79.141.114])
        by smtp.gmail.com with ESMTPSA id q13sm251503lfn.15.2020.11.25.04.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 04:52:53 -0800 (PST)
Date:   Wed, 25 Nov 2020 15:52:52 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Sean Anderson <seanga2@gmail.com>
Subject: Re: [PATCH 2/3] spi: dw: Add support for the Canaan K210 SoC SPI
Message-ID: <20201125125252.s4ui5x2xxt2djdtp@mobilestation>
References: <20201119120253.390883-1-damien.lemoal@wdc.com>
 <20201119120253.390883-3-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201119120253.390883-3-damien.lemoal@wdc.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Nov 19, 2020 at 09:02:52PM +0900, Damien Le Moal wrote:
> The Canaan Kendryte K210 RISC-V SoC includes a DW apb_ssi v4 controller
> which is documented to have a 32 words deep TX and RX FIFO. The FIFO
> length detection in spi_hw_init() correctly detects this value.
> However, when the controller RX FIFO is filled up to 32 entries
> (RXFLR = 32), an RX FIFO overrun error occurs. This likely due to a
> hardware bug which can be avoided by force setting the fifo_len field of
> struct dw_spi to 31.
> 
> Define the dw_spi_canaan_k210_init() function to force set fifo_len to
> 31 when the device node compatible string is "canaan,k210-spi".

Looking good. Thanks.
Acked-by: Serge Semin <fancer.lancer@gmail.com>

> 
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> ---
>  drivers/spi/spi-dw-mmio.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
> index d0cc5bf4fa4e..17c06039a74d 100644
> --- a/drivers/spi/spi-dw-mmio.c
> +++ b/drivers/spi/spi-dw-mmio.c
> @@ -222,6 +222,21 @@ static int dw_spi_keembay_init(struct platform_device *pdev,
>  	return 0;
>  }
>  
> +static int dw_spi_canaan_k210_init(struct platform_device *pdev,
> +				   struct dw_spi_mmio *dwsmmio)
> +{
> +	/*
> +	 * The Canaan Kendryte K210 SoC DW apb_ssi v4 spi controller is
> +	 * documented to have a 32 word deep TX and RX FIFO, which
> +	 * spi_hw_init() detects. However, when the RX FIFO is filled up to
> +	 * 32 entries (RXFLR = 32), an RX FIFO overrun error occurs. Avoid this
> +	 * problem by force setting fifo_len to 31.
> +	 */
> +	dwsmmio->dws.fifo_len = 31;
> +
> +	return 0;
> +}
> +
>  static int dw_spi_mmio_probe(struct platform_device *pdev)
>  {
>  	int (*init_func)(struct platform_device *pdev,
> @@ -335,6 +350,7 @@ static const struct of_device_id dw_spi_mmio_of_match[] = {
>  	{ .compatible = "snps,dwc-ssi-1.01a", .data = dw_spi_dwc_ssi_init},
>  	{ .compatible = "intel,keembay-ssi", .data = dw_spi_keembay_init},
>  	{ .compatible = "microchip,sparx5-spi", dw_spi_mscc_sparx5_init},
> +	{ .compatible = "canaan,k210-spi", dw_spi_canaan_k210_init},
>  	{ /* end of table */}
>  };
>  MODULE_DEVICE_TABLE(of, dw_spi_mmio_of_match);
> -- 
> 2.28.0
> 
