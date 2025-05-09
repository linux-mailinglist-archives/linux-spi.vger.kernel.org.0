Return-Path: <linux-spi+bounces-8043-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 55865AB19CB
	for <lists+linux-spi@lfdr.de>; Fri,  9 May 2025 18:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 154EA7A66B4
	for <lists+linux-spi@lfdr.de>; Fri,  9 May 2025 16:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C63AA235046;
	Fri,  9 May 2025 16:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O87CAUak"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA58136672;
	Fri,  9 May 2025 16:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746806858; cv=none; b=CHUKig31N20Fyny9cYlHAE7Z8YqNJTsotHYMoGpRnORxc6vM3iC4LPwM0yjTNzaRSpBkdnEZavvPPCPytvPYyCBkPvg9dpIAksM2ekOnLaMf0K+13nSJoY/tKlYCHCmxCo4BbQji4Tse5nOeNT9MSD9AWVEP7aqRDxx5JagIjD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746806858; c=relaxed/simple;
	bh=+/1IQ2oCinigP5CnNh1S1UQ2fww1RQQZshyDjBgmy6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AO1l/vK+kTQ7pTW0k+HfSb3sBjDuBHAjaPjI3dTYuRHRE+QiZYlnshincjTmuxKlGoWMata5lk/gimc27BbCe/bB+ZynrnSr9K54eFlTMTY0GvF5UsQMf8hXIr2YV2hRKANSWfSFLjIBEiI9p1JdgHLOYaq/AaPwQdKSur798cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O87CAUak; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ac79fa6e1c2so42278466b.1;
        Fri, 09 May 2025 09:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746806855; x=1747411655; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O1aSEKZ9GPjDBpZIq0+eebFymFhGTQv6JnpJUamgLSU=;
        b=O87CAUakz8SdLclbOjBaWkkMNqGAV3A3D60cC7CFNALMpEZkApO3vJRFSrgpzG4g4L
         NY5giBbgAOvZokqmam5ZBO3zWJK+3UcLbzp6V+9ZXdWEDpjg9rXXFNCP6r3Dx779Pi2A
         VQdAXCryLDUvhN3zbEp9C7/zXlG/8pyScCmKFHCnSsO+Hq2mYgLAjvhwdBXs2933MWZo
         CSMLVAJ61k1h6tqUPa6WEAF3FhlKxVq8FzYKv7VREGvN/7SxW9wYG/t8A1HjmQRBmf69
         FeLv5+wXOOfrgbcPVoE8ujThSpLK4Fi1dV6nUZn9FMiWEFrxDVF9mETidClI5GDGewoL
         QHcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746806855; x=1747411655;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O1aSEKZ9GPjDBpZIq0+eebFymFhGTQv6JnpJUamgLSU=;
        b=HLllruEOTgHzghjll/E2whEChwyv+DnYaIftLBJ3+Tz51p8dSP1SlGMqe4nyO9ZEvc
         ZuE1DRi324U5+rveeQzOJO1Vv3OcW51FMDySJnw0gVPK+Wl34cS024a6qwYw9vhLIqxf
         2gyk2BO853DHS/Ag5VxXhkwAtbRoGYq0QeTv7OHwGXz8xyw/pBobM+JAGd8bVdGD1XXk
         7hVcq/zTHbDNnkkrt6iSRkqpEHW8V3nT1r3OGU02sxp+s+6IWuhzXMBFXrREb7adygU1
         m156ZnJU/YEmDnwlHwavoScCKWKRUGoggbHbovko11lyZ5A/tuW6aNKnrrUk1FJ0OXYI
         Lj0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVuhy6CN3aG0XP4AS8x8DY57NBsP1+vsyxg4Pt77BAzpNz87jZ22uXjb6bVYEc0/PmPb3tIKrBfhxpgcukF@vger.kernel.org, AJvYcCXGpTu37nRWyjELdE4YSd3TT/LfFRuQ0gBH+dA0E5nkXzElF281udghssqcgXlelzf0o2dNQYA2DF3H@vger.kernel.org, AJvYcCXiND/RO1kf627sHNhAva4DU4/3tGkgYtVrzbJXfy0WCiDBkOVgiBuHahHT8xxdDCHdaOd8ymiAbG+O@vger.kernel.org
X-Gm-Message-State: AOJu0YzEe++tBFPjSZsRawtQ1rUAIKtS7LtIg1gpifHHooWqdYkmuyfk
	YvS3rlTUP/YohBeXPCkqgswBPXeX5GPo4XjBI3/HvlFfnNGbD8g5
X-Gm-Gg: ASbGnctqM05zvj8faAX8YjP8bfVdRaLZh9SLmJiJUJBV5cn4gNuNecctUFNWmxavYCC
	z0xOV6xlgOU9w9JJNFxITxXzpCn2VIBov1amI4AIH+SBiy9xuzFh3RSXCMv1AXK5NiOXIM8sgYX
	Te+sg9jzvdnTNU6mu75FjfIhBf82saEH2MJDdd94SVorUSZNtzsUBks7LHbG0h/doq6i/6tTOUX
	VjRluzbB6XYhzBtm9SUfzFL0WwuFMKeXsp9JfL874FbdHwK49SdE/FCgLPXBmkvMf4FUNmoy+17
	XklLAh5ol+l1ysSFcmiFfJIxLq39
X-Google-Smtp-Source: AGHT+IFfblZ5zyybW8Zc1JXlu3gaLC6XU1AeC2AshGGFeE3SDeA+ieQda1+l7upR9+VJ3d7Jl2trlg==
X-Received: by 2002:a17:906:84ef:b0:ad1:e9fb:e78 with SMTP id a640c23a62f3a-ad219121b47mr132183266b.10.1746806854983;
        Fri, 09 May 2025 09:07:34 -0700 (PDT)
Received: from skbuf ([188.25.50.178])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad22562ed61sm84950466b.31.2025.05.09.09.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 09:07:34 -0700 (PDT)
Date: Fri, 9 May 2025 19:07:31 +0300
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
Subject: Re: [PATCH 02/14] spi: spi-fsl-dspi: Re-use one volatile regmap for
 both device types
Message-ID: <20250509160731.wibhaumyialjloz3@skbuf>
References: <20250509-james-nxp-spi-v1-0-32bfcd2fea11@linaro.org>
 <20250509-james-nxp-spi-v1-0-32bfcd2fea11@linaro.org>
 <20250509-james-nxp-spi-v1-2-32bfcd2fea11@linaro.org>
 <20250509-james-nxp-spi-v1-2-32bfcd2fea11@linaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250509-james-nxp-spi-v1-2-32bfcd2fea11@linaro.org>
 <20250509-james-nxp-spi-v1-2-32bfcd2fea11@linaro.org>

On Fri, May 09, 2025 at 12:05:49PM +0100, James Clark wrote:
> max_register overrides anything in the volatile ranges, so we can get
> away with sharing the same one for both types. In a later commit we'll
> add more devices and also read/write ranges which also override volatile
> ranges so this avoids adding even more duplication.
> 
> No functional changes.
> 
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
>  drivers/spi/spi-fsl-dspi.c | 15 ++-------------
>  1 file changed, 2 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
> index 31ea8ce81e98..cb0e55a49eea 100644
> --- a/drivers/spi/spi-fsl-dspi.c
> +++ b/drivers/spi/spi-fsl-dspi.c
> @@ -141,6 +141,7 @@ static const struct regmap_range dspi_volatile_ranges[] = {
>  	regmap_reg_range(SPI_MCR, SPI_TCR),
>  	regmap_reg_range(SPI_SR, SPI_SR),
>  	regmap_reg_range(SPI_PUSHR, SPI_RXFR3),
> +	regmap_reg_range(SPI_SREX, SPI_SREX)

Same idea, don't take the review tag as a sign that I don't have any
change request here.

>  };
>  
>  static const struct regmap_access_table dspi_volatile_table = {
> @@ -148,18 +149,6 @@ static const struct regmap_access_table dspi_volatile_table = {
>  	.n_yes_ranges	= ARRAY_SIZE(dspi_volatile_ranges),
>  };
>  
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
>  enum {
>  	DSPI_REGMAP,
>  	DSPI_XSPI_REGMAP,
> @@ -179,7 +168,7 @@ static const struct regmap_config dspi_regmap_config[] = {
>  		.val_bits	= 32,
>  		.reg_stride	= 4,
>  		.max_register	= 0x13c,
> -		.volatile_table	= &dspi_xspi_volatile_table
> +		.volatile_table	= &dspi_volatile_table
>  	},
>  	[DSPI_PUSHR] = {
>  		.name		= "pushr",
> 
> -- 
> 2.34.1
> 

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

