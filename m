Return-Path: <linux-spi+bounces-8042-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1781AB19E8
	for <lists+linux-spi@lfdr.de>; Fri,  9 May 2025 18:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EBAF1C60352
	for <lists+linux-spi@lfdr.de>; Fri,  9 May 2025 16:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86373234973;
	Fri,  9 May 2025 16:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="idJY/O0/"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A235230D01;
	Fri,  9 May 2025 16:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746806684; cv=none; b=n30izbbBWwAuZ1/tK0efUxV5pk/ElUttWW2bDU+jVFxqFRSVa1zT0v7ZdxQWfZGskjL58bKU8amLW1QMMsplG9eD7Drx4OAKH/mcW5cI2EwYWT2lkNlAlTbKemtvNaMsi87vMNPYI1qpYf3Vu65GlPm8BEwR+E9nmIZyUqcc6Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746806684; c=relaxed/simple;
	bh=UWT3e7uRPGygOVjf8h2Eu768cYnpXn0Oj3p6hUoKpp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CqKgoKqpB3xi2gRoVfnS80Vq2XClCeYRvDSnktxgftGqDCPXxYVRovREg6wxH5QNnu3MtIi7p4pIrunQyTT9FHyspoLR8vXjDU/5i1nhX1QwBgG8Hgo1hmBLy3VpPY73ED7QrtPPXIi38LRIZXlJOhyXfOZBDw6izU3STsK++tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=idJY/O0/; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ac30d4ee128so35772466b.0;
        Fri, 09 May 2025 09:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746806681; x=1747411481; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pX1Xn48JWPNWwoKS70iDCarEMhnhyPor/kZZ40HpF8o=;
        b=idJY/O0/fatA+6TH+Gyxgj2XlssMSpuxlPhcPqh5jmG+bnM/I71LNwbheCTE8EhgUp
         RkQxjTExsYwOB3jIVbb3fS0Gu43j5u4DNG2i2PkF0OJCw9E/XDjJ7cBtLWU6ZjXlyOXb
         c9MQ+mYTCETWWlaVhGaeUcRUt0Ch6W5Rc22G4IFnf7Lltn8Wv23rvqKz2hr/97nIHcv3
         C3I1AtO2U8xhAS4e0Tc1Y0FVJY1Rh6IXqVJTp52cEQywin1zZQ6wfeuo/DkqLzwMNFsf
         dIAojB+Kf3AJxsFNFcrWX1oXoy7WligXi4DRUKv07VrL248CikD1AJmr4OUQdZ6ZWppo
         yOEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746806681; x=1747411481;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pX1Xn48JWPNWwoKS70iDCarEMhnhyPor/kZZ40HpF8o=;
        b=nnW8HyrpsW2PhrG3hO/Xs8NVNJMVKSsKXKp45aICLEBilgGuYbnCWdvi50icCk40Vs
         zh5KjYWr6+NVbWWQF7z5TVQVvDRrfoR+qzDo97Dfj/C++wIdFTI9P3yL4V/4bBDVR8UW
         f7J2fk9WMpdAjvKdA8qnetISZrXBLmHD7ba6xjWPGM4y+7B8LwtRrDRsaiaBUkH1/TnF
         qRKnE+Mz83YBpgudcRv2PIuWKdCVgO4HUujpnA2a6Esz+8bhl3TZ73DBbu3LssRDmqNv
         9Hw42u1+k/K2irS4hlAKqg4Rqe00PjS8hW+Sp8SkU1zTQezeG1FmnFfCMZDA02rxwxDw
         UskQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOb9L5bpI/oG38x36nJyI1tlWavfpcdcGJXQqFI9O96HQyxxrNIRUmFIV7c+qrqN0Pr1ZDaMf1FLL7V+H9@vger.kernel.org, AJvYcCWny2LI6o+KOuellrBc4H0HtHMP/OTzjCoovnh6E8IvSeRYyaW7co9vxDwmaRx/egkCXEXHm7pp0x4N@vger.kernel.org, AJvYcCXu+aKc1Lzi90jr+PQohMXMQgYp74C8UPybDRcRVhEdJlOy0m2VuMRKXEn4gE6UsgsBIApIQbP1jPKG@vger.kernel.org
X-Gm-Message-State: AOJu0YxTqh5WQjQjVBP4R/hBBpxwzxXTZS0+DfL6+r/1tTUTiDPKaPzb
	obnXroe7LiDVTQ0Z51vi9uD2ey6NJIRuvQY8r5aTNKDCAZSGDV6Ltl8g4Qlg
X-Gm-Gg: ASbGncsp6GBpgA6lhS6XFcZRSlunSriuroXIgxNHijQqvOnSfONoiYh8vybdvsw4/IA
	o31hfKT1O5x4emmEOGF0qjV2XEobJmKqy07en4c95CHhBzSuz92BrUk0wx1FrkKpg4klJFrqYHc
	S8s9kJhBD1dR9AVrFkVQZR2Dvjg8IWV93CFkeCrabfBvfNo2K92mDzI2n7UpTfyHO054HZnvwSD
	LIbgvIpY+4fp7AY+pTAoKqZXF6vOP8VENkQZgn7/eXS1fbxDF1grlAH7aZn4ouiZ/RS2x0ics3D
	OQ5NPThMJC6WcGqaAIHJ1/enDh3G
X-Google-Smtp-Source: AGHT+IF3sn8zNRPNDYSOtNhbc70HEDVqm9+kB+9U0d1DvOs91XcZhkaM1rCdhEtleM44NPXP0GTkbA==
X-Received: by 2002:a17:907:75f2:b0:ad2:2493:8361 with SMTP id a640c23a62f3a-ad2249383e7mr65020566b.11.1746806680433;
        Fri, 09 May 2025 09:04:40 -0700 (PDT)
Received: from skbuf ([188.25.50.178])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad2192c8f98sm172443166b.10.2025.05.09.09.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 09:04:39 -0700 (PDT)
Date: Fri, 9 May 2025 19:04:36 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: James Clark <james.clark@linaro.org>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Chester Lin <chester62515@gmail.com>,
	Matthias Brugger <mbrugger@suse.com>,
	Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>,
	NXP S32 Linux Team <s32@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, larisa.grigore@nxp.com,
	arnd@linaro.org, andrei.stefanescu@nxp.com,
	dan.carpenter@linaro.org, linux-spi@vger.kernel.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 01/14] spi: spi-fsl-dspi: Define regmaps per device
Message-ID: <20250509160436.ohx57lp7a3w2dhog@skbuf>
References: <20250509-james-nxp-spi-v1-0-32bfcd2fea11@linaro.org>
 <20250509-james-nxp-spi-v1-1-32bfcd2fea11@linaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250509-james-nxp-spi-v1-1-32bfcd2fea11@linaro.org>

On Fri, May 09, 2025 at 12:05:48PM +0100, James Clark wrote:
>  static const struct fsl_dspi_devtype_data devtype_data[] = {
>  	[VF610] = {
>  		.trans_mode		= DSPI_DMA_MODE,
>  		.max_clock_factor	= 2,
>  		.fifo_size		= 4,
> +		.regmap			= &dspi_regmap_config[DSPI_REGMAP]

Comma at the end, please. Just like you didn't have to modify the
previous line to add this new assignment, so shouldn't any future
contributor. The comment applies throughout the entire patch set.

>  	},
>  	[LS1021A] = {
>  		/* Has A-011218 DMA erratum */
>  		.trans_mode		= DSPI_XSPI_MODE,
>  		.max_clock_factor	= 8,
>  		.fifo_size		= 4,
> +		.regmap			= &dspi_regmap_config[DSPI_XSPI_REGMAP]
>  	},
>  	[LS1012A] = {
>  		/* Has A-011218 DMA erratum */
>  		.trans_mode		= DSPI_XSPI_MODE,
>  		.max_clock_factor	= 8,
>  		.fifo_size		= 16,
> +		.regmap			= &dspi_regmap_config[DSPI_XSPI_REGMAP]
>  	},
>  	[LS1028A] = {
>  		.trans_mode		= DSPI_XSPI_MODE,
>  		.max_clock_factor	= 8,
>  		.fifo_size		= 4,
> +		.regmap			= &dspi_regmap_config[DSPI_XSPI_REGMAP]
>  	},
>  	[LS1043A] = {
>  		/* Has A-011218 DMA erratum */
>  		.trans_mode		= DSPI_XSPI_MODE,
>  		.max_clock_factor	= 8,
>  		.fifo_size		= 16,
> +		.regmap			= &dspi_regmap_config[DSPI_XSPI_REGMAP]
>  	},
>  	[LS1046A] = {
>  		/* Has A-011218 DMA erratum */
>  		.trans_mode		= DSPI_XSPI_MODE,
>  		.max_clock_factor	= 8,
>  		.fifo_size		= 16,
> +		.regmap			= &dspi_regmap_config[DSPI_XSPI_REGMAP]
>  	},
>  	[LS2080A] = {
>  		.trans_mode		= DSPI_XSPI_MODE,
>  		.max_clock_factor	= 8,
>  		.fifo_size		= 4,
> +		.regmap			= &dspi_regmap_config[DSPI_XSPI_REGMAP]
>  	},
>  	[LS2085A] = {
>  		.trans_mode		= DSPI_XSPI_MODE,
>  		.max_clock_factor	= 8,
>  		.fifo_size		= 4,
> +		.regmap			= &dspi_regmap_config[DSPI_XSPI_REGMAP]
>  	},
>  	[LX2160A] = {
>  		.trans_mode		= DSPI_XSPI_MODE,
>  		.max_clock_factor	= 8,
>  		.fifo_size		= 4,
> +		.regmap			= &dspi_regmap_config[DSPI_XSPI_REGMAP]
>  	},
>  	[MCF5441X] = {
>  		.trans_mode		= DSPI_DMA_MODE,
>  		.max_clock_factor	= 8,
>  		.fifo_size		= 16,
> +		.regmap			= &dspi_regmap_config[DSPI_REGMAP]
>  	},
>  };
>  
> @@ -1167,54 +1231,6 @@ static int dspi_resume(struct device *dev)
>  
>  static SIMPLE_DEV_PM_OPS(dspi_pm, dspi_suspend, dspi_resume);
>  
> -static const struct regmap_range dspi_volatile_ranges[] = {
> -	regmap_reg_range(SPI_MCR, SPI_TCR),
> -	regmap_reg_range(SPI_SR, SPI_SR),
> -	regmap_reg_range(SPI_PUSHR, SPI_RXFR3),
> -};
> -
> -static const struct regmap_access_table dspi_volatile_table = {
> -	.yes_ranges	= dspi_volatile_ranges,
> -	.n_yes_ranges	= ARRAY_SIZE(dspi_volatile_ranges),
> -};
> -
> -static const struct regmap_config dspi_regmap_config = {
> -	.reg_bits	= 32,
> -	.val_bits	= 32,
> -	.reg_stride	= 4,
> -	.max_register	= 0x88,
> -	.volatile_table	= &dspi_volatile_table,
> -};
> -
> -static const struct regmap_range dspi_xspi_volatile_ranges[] = {
> -	regmap_reg_range(SPI_MCR, SPI_TCR),
> -	regmap_reg_range(SPI_SR, SPI_SR),
> -	regmap_reg_range(SPI_PUSHR, SPI_RXFR3),
> -	regmap_reg_range(SPI_SREX, SPI_SREX),
> -};
> -
> -static const struct regmap_access_table dspi_xspi_volatile_table = {
> -	.yes_ranges	= dspi_xspi_volatile_ranges,
> -	.n_yes_ranges	= ARRAY_SIZE(dspi_xspi_volatile_ranges),
> -};
> -
> -static const struct regmap_config dspi_xspi_regmap_config[] = {
> -	{
> -		.reg_bits	= 32,
> -		.val_bits	= 32,
> -		.reg_stride	= 4,
> -		.max_register	= 0x13c,
> -		.volatile_table	= &dspi_xspi_volatile_table,
> -	},
> -	{
> -		.name		= "pushr",
> -		.reg_bits	= 16,
> -		.val_bits	= 16,
> -		.reg_stride	= 2,
> -		.max_register	= 0x2,
> -	},
> -};
> -
>  static int dspi_init(struct fsl_dspi *dspi)
>  {
>  	unsigned int mcr;
> @@ -1272,7 +1288,6 @@ static int dspi_target_abort(struct spi_controller *host)
>  static int dspi_probe(struct platform_device *pdev)
>  {
>  	struct device_node *np = pdev->dev.of_node;
> -	const struct regmap_config *regmap_config;
>  	struct fsl_dspi_platform_data *pdata;
>  	struct spi_controller *ctlr;
>  	int ret, cs_num, bus_num = -1;
> @@ -1355,11 +1370,7 @@ static int dspi_probe(struct platform_device *pdev)
>  		goto out_ctlr_put;
>  	}
>  
> -	if (dspi->devtype_data->trans_mode == DSPI_XSPI_MODE)
> -		regmap_config = &dspi_xspi_regmap_config[0];
> -	else
> -		regmap_config = &dspi_regmap_config;
> -	dspi->regmap = devm_regmap_init_mmio(&pdev->dev, base, regmap_config);
> +	dspi->regmap = devm_regmap_init_mmio(&pdev->dev, base, dspi->devtype_data->regmap);

I know there are other coding conventions floating around, but for this
driver please try to stick to a limit of ~80 characters limit for lines
which don't contain strings.

>  	if (IS_ERR(dspi->regmap)) {
>  		dev_err(&pdev->dev, "failed to init regmap: %ld\n",
>  				PTR_ERR(dspi->regmap));
> @@ -1370,7 +1381,7 @@ static int dspi_probe(struct platform_device *pdev)
>  	if (dspi->devtype_data->trans_mode == DSPI_XSPI_MODE) {
>  		dspi->regmap_pushr = devm_regmap_init_mmio(
>  			&pdev->dev, base + SPI_PUSHR,
> -			&dspi_xspi_regmap_config[1]);
> +			&dspi_regmap_config[DSPI_PUSHR]);
>  		if (IS_ERR(dspi->regmap_pushr)) {
>  			dev_err(&pdev->dev,
>  				"failed to init pushr regmap: %ld\n",
> 
> -- 
> 2.34.1
> 

With the change request addressed, please add my tag and keep it in
subsequent submissions.

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

