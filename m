Return-Path: <linux-spi+bounces-6275-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 795C2A08970
	for <lists+linux-spi@lfdr.de>; Fri, 10 Jan 2025 08:56:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79FDF168C96
	for <lists+linux-spi@lfdr.de>; Fri, 10 Jan 2025 07:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F17205E32;
	Fri, 10 Jan 2025 07:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b="hCtfg57d"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210482905;
	Fri, 10 Jan 2025 07:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.92.40.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736495803; cv=none; b=bZcgefUnu6NudIB0M3dl11VxRSgPMcwVxRI+uLPhPlshm8+RnGbsLUGKFnjS3eQ5hcObR46XjsbIncNxaboB2jppLCbTBpc6JZSKPszOyi7AxR2wW+wEVebRODVgLdiIkQgDeE+onZ2SaPMgDP2X84bOBV1dJ1v3hnGhMu4RSwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736495803; c=relaxed/simple;
	bh=EAaulJ2Ldtk+tbgYL8kFf/W30nz2IOiufWllhRV2E0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pasCHYuWSOvwRNQt6sBHUHMit6cVLACKjLW7oXcmZIGpqmjvLAgavVpBOFiTfo6IU98MW4RoDENumty42Jw88tYOUsTfRepitD9PA8LIFji/XtVbACLRXz4e6WnjikB3BICw3zQyK1MHpxE+2NVp5C9hi9xb4fGeqn8CMco/lhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com; spf=pass smtp.mailfrom=thorsis.com; dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b=hCtfg57d; arc=none smtp.client-ip=217.92.40.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AA47F1484594;
	Fri, 10 Jan 2025 08:56:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
	t=1736495797;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Coy02//KS7MYK7jX90haXrVAAKw75veVepRFuvAw9mQ=;
	b=hCtfg57dLN+Tf8kjrLOlVV72y4rYNehARxRiXWkcOPcGRI4HFu/z7OyCg/BbOFCmrQ7aqW
	mW7I8eGfSWo7iwHoghbswWkUX+eZZ6Z24j1WG/zr4ETu5VDjgM/Vtwtt21790wS4t41Wo6
	BlSicHzLRm/rCzkhmrMWLpWBwfOltaQC+LYu8/iOH67JOztV6ZFxta9yFuVxSNtNAFKsgp
	55u6bt+Wm1MTofTcFMZeCW0XO8x10QX4dWoq+utfbDY4jR1CoQWWh668Y4rJQHGLcShByf
	LKoD+zUcraIQ0xD7rmKoKyPxgxKLmsYN8wC3+wRDDk5MGV9135zNZq1Byjl1dg==
Date: Fri, 10 Jan 2025 08:56:29 +0100
From: Alexander Dahl <ada@thorsis.com>
To: =?iso-8859-1?B?Q3Pza+FzLA==?= Bence <csokas.bence@prolan.hu>
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Tudor Ambarus <tudor.ambarus@microchip.com>,
	Varshini Rajendran <varshini.rajendran@microchip.com>,
	Mark Brown <broonie@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>
Subject: Re: [PATCH v3 2/2] spi: atmel-quadspi: Add support for sama7g5 QSPI
Message-ID: <20250110-paycheck-irregular-bcddab1276c7@thorsis.com>
Mail-Followup-To: =?iso-8859-1?B?Q3Pza+FzLA==?= Bence <csokas.bence@prolan.hu>,
	linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Tudor Ambarus <tudor.ambarus@microchip.com>,
	Varshini Rajendran <varshini.rajendran@microchip.com>,
	Mark Brown <broonie@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>
References: <20241128174316.3209354-1-csokas.bence@prolan.hu>
 <20241128174316.3209354-3-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241128174316.3209354-3-csokas.bence@prolan.hu>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Last-TLS-Session-Version: TLSv1.3

Hello,

found another suspicious area regarding pm_runtime in
atmel_qspi_probe(), see below (irrelevant stuff dropped this time) …

Am Thu, Nov 28, 2024 at 06:43:15PM +0100 schrieb Csókás, Bence:
> From: Tudor Ambarus <tudor.ambarus@microchip.com>
> 

[…]

> @@ -726,18 +1411,32 @@ static int atmel_qspi_probe(struct platform_device *pdev)
>  				"failed to enable the QSPI system clock\n");
>  			goto disable_pclk;
>  		}
> +	} else if (aq->caps->has_gclk) {
> +		/* Get the QSPI generic clock */
> +		aq->gclk = devm_clk_get(&pdev->dev, "gclk");
> +		if (IS_ERR(aq->gclk)) {
> +			dev_err(&pdev->dev, "missing Generic clock\n");
> +			err = PTR_ERR(aq->gclk);
> +			goto disable_pclk;
> +		}
> +	}
> +
> +	if (aq->caps->has_dma) {
> +		err = atmel_qspi_dma_init(ctrl);
> +		if (err == -EPROBE_DEFER)
> +			goto disable_qspick;
>  	}
>  
>  	/* Request the IRQ */
>  	irq = platform_get_irq(pdev, 0);
>  	if (irq < 0) {
>  		err = irq;
> -		goto disable_qspick;
> +		goto dma_release;
>  	}
>  	err = devm_request_irq(&pdev->dev, irq, atmel_qspi_interrupt,
>  			       0, dev_name(&pdev->dev), aq);
>  	if (err)
> -		goto disable_qspick;
> +		goto dma_release;
>  
>  	pm_runtime_set_autosuspend_delay(&pdev->dev, 500);
>  	pm_runtime_use_autosuspend(&pdev->dev);
> @@ -745,7 +1444,9 @@ static int atmel_qspi_probe(struct platform_device *pdev)
>  	pm_runtime_enable(&pdev->dev);
>  	pm_runtime_get_noresume(&pdev->dev);
>  
> -	atmel_qspi_init(aq);
> +	err = atmel_qspi_init(aq);
> +	if (err)
> +		goto dma_release;

This error handling leads to unbalanced pm_runtime right?  The block
below rolls back pm_runtime before jumping to 'dma_release', this here
does not.

>  	err = spi_register_controller(ctrl);
>  	if (err) {
> @@ -753,13 +1454,16 @@ static int atmel_qspi_probe(struct platform_device *pdev)
>  		pm_runtime_disable(&pdev->dev);
>  		pm_runtime_set_suspended(&pdev->dev);
>  		pm_runtime_dont_use_autosuspend(&pdev->dev);
> -		goto disable_qspick;
> +		goto dma_release;
>  	}

This hunk got it right?

>  	pm_runtime_mark_last_busy(&pdev->dev);
>  	pm_runtime_put_autosuspend(&pdev->dev);
>  
>  	return 0;
>  
> +dma_release:
> +	if (aq->caps->has_dma)
> +		atmel_qspi_dma_release(aq);
>  disable_qspick:
>  	clk_disable_unprepare(aq->qspick);
>  disable_pclk:
> @@ -768,6 +1472,44 @@ static int atmel_qspi_probe(struct platform_device *pdev)
>  	return err;
>  }

I think this is another issue of forwarding porting.  The pm_runtime
stuff was added in mainline after the original patch was forked of,
and not entirely considered when porting?

Greets
Alex

