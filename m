Return-Path: <linux-spi+bounces-4980-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E2B986D7E
	for <lists+linux-spi@lfdr.de>; Thu, 26 Sep 2024 09:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3475E1F246AD
	for <lists+linux-spi@lfdr.de>; Thu, 26 Sep 2024 07:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47E8186298;
	Thu, 26 Sep 2024 07:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b="GtBFhMwl"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF71185B55;
	Thu, 26 Sep 2024 07:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.92.40.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727335529; cv=none; b=Alt7o2u8atNcroTO3dsCm6Hrbf45i3QFyuAAOsf5wK6D4iWQ/OaByST1vdyxkDcpZBo+WgYYaVFn5Tw2DatcJ/6XipJH05VPPREestZ5xlXvzF4+9anBFV/UuYwQpfm/2k/Raq3AE1TVf4Slk6ZBj28KhPFt2mSFT9xkBQeLP74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727335529; c=relaxed/simple;
	bh=UTP4AJIcfkshPFU/SQC+v0Q+oZVwMHnZQaBpKvG9x1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ntpvejw9qWxWj9mgDDG9uFfdkEGw2nLW7qSl9TP/aLBzNJxQq8zTJS96t+QsWq2c3ddF7StqiZffrFX7Zo57rQlQowv5j2+DDCn0ss+wA1TtlhMVaXA9nLK6t+6biy5ypk0xS4xLaBxju2lVGGTt8ojRtQSXrQKOJGFvzCcTUgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com; spf=pass smtp.mailfrom=thorsis.com; dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b=GtBFhMwl; arc=none smtp.client-ip=217.92.40.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D9EAD1483DC9;
	Thu, 26 Sep 2024 09:25:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
	t=1727335518; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=HofPiSPRsOq8IMdn+s0YrB3BCnkaGyRPRUXAn53i/Sk=;
	b=GtBFhMwlBlN39A/Znf/BuTGk1e6Lc8rdQgGtN2zCR+bozFDmd0NXgC8uc+1FbUVdyCq6rK
	pm8Idy158AIcp/e4QlpcJ1vfVUM0rS0+INO9XOnoircEIB0xgqKnUOMb2SXclusDkSnEZm
	+6KuL9XqItvicLwUSQSFVEFllTSqYIdVwypuwhHTp9ZveszKIrcT+OGw4G9MSpLg/hB3qq
	h6F17n1V0xRTqKirT6TbAt0eVPx4b2+xMjrL77cpLrxp1Q0BLUXHWDCBrBNKai1cw5UCvm
	Lhr8I/lxAO1vbGYzKInnYqP0n4qxE3FyU4k+gjr1LGVetnIE6dEzWjkv+8ltYA==
Date: Thu, 26 Sep 2024 09:25:10 +0200
From: Alexander Dahl <ada@thorsis.com>
To: Mark Brown <broonie@kernel.org>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	"open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>,
	"moderated list:ARM/Microchip (AT91) SoC support" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] spi: atmel-quadspi: Avoid overwriting delay register
 settings
Message-ID: <20240926-macarena-wincing-7c4995487a29@thorsis.com>
Mail-Followup-To: Mark Brown <broonie@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	"open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>,
	"moderated list:ARM/Microchip (AT91) SoC support" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
References: <20240918082744.379610-1-ada@thorsis.com>
 <20240918082744.379610-2-ada@thorsis.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240918082744.379610-2-ada@thorsis.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Last-TLS-Session-Version: TLSv1.3

Hello everyone,

Am Wed, Sep 18, 2024 at 10:27:43AM +0200 schrieb Alexander Dahl:
> Previously the MR and SCR registers were just set with the supposedly
> required values, from cached register values (cached reg content
> initialized to zero).
> 
> All parts fixed here did not consider the current register (cache)
> content, which would make future support of cs_setup, cs_hold, and
> cs_inactive impossible.
> 
> Setting SCBR in atmel_qspi_setup() erases a possible DLYBS setting from
> atmel_qspi_set_cs_timing().  The DLYBS setting is applied by ORing over
> the current setting, without resetting the bits first.  All writes to MR
> did not consider possible settings of DLYCS and DLYBCT.
> 
> Signed-off-by: Alexander Dahl <ada@thorsis.com>
> Fixes: f732646d0ccd ("spi: atmel-quadspi: Add support for configuring CS timing")
> ---
>  drivers/spi/atmel-quadspi.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
> index 5aaff3bee1b7..fcd57cf1f2cf 100644
> --- a/drivers/spi/atmel-quadspi.c
> +++ b/drivers/spi/atmel-quadspi.c
> @@ -375,9 +375,9 @@ static int atmel_qspi_set_cfg(struct atmel_qspi *aq,
>  	 * If the QSPI controller is set in regular SPI mode, set it in
>  	 * Serial Memory Mode (SMM).
>  	 */
> -	if (aq->mr != QSPI_MR_SMM) {
> -		atmel_qspi_write(QSPI_MR_SMM, aq, QSPI_MR);
> -		aq->mr = QSPI_MR_SMM;
> +	if (!(aq->mr & QSPI_MR_SMM)) {
> +		aq->mr |= QSPI_MR_SMM;
> +		atmel_qspi_write(aq->scr, aq, QSPI_MR);

On a second glance, this looks wrong, value for Mode Register (MR) is
written into Serial Clock Register (SCR), should be like this instead:

    atmel_qspi_write(aq->mr, aq, QSPI_MR);

This is somewhat embarrassing, because the patch was already applied
to master.  Should it be reverted, then I would send a v2 of the
series?  Or should I send a quick fixup?

Greets
Alex

>  	}
>  
>  	/* Clear pending interrupts */
> @@ -501,7 +501,8 @@ static int atmel_qspi_setup(struct spi_device *spi)
>  	if (ret < 0)
>  		return ret;
>  
> -	aq->scr = QSPI_SCR_SCBR(scbr);
> +	aq->scr &= ~QSPI_SCR_SCBR_MASK;
> +	aq->scr |= QSPI_SCR_SCBR(scbr);
>  	atmel_qspi_write(aq->scr, aq, QSPI_SCR);
>  
>  	pm_runtime_mark_last_busy(ctrl->dev.parent);
> @@ -534,6 +535,7 @@ static int atmel_qspi_set_cs_timing(struct spi_device *spi)
>  	if (ret < 0)
>  		return ret;
>  
> +	aq->scr &= ~QSPI_SCR_DLYBS_MASK;
>  	aq->scr |= QSPI_SCR_DLYBS(cs_setup);
>  	atmel_qspi_write(aq->scr, aq, QSPI_SCR);
>  
> @@ -549,8 +551,8 @@ static void atmel_qspi_init(struct atmel_qspi *aq)
>  	atmel_qspi_write(QSPI_CR_SWRST, aq, QSPI_CR);
>  
>  	/* Set the QSPI controller by default in Serial Memory Mode */
> -	atmel_qspi_write(QSPI_MR_SMM, aq, QSPI_MR);
> -	aq->mr = QSPI_MR_SMM;
> +	aq->mr |= QSPI_MR_SMM;
> +	atmel_qspi_write(aq->mr, aq, QSPI_MR);
>  
>  	/* Enable the QSPI controller */
>  	atmel_qspi_write(QSPI_CR_QSPIEN, aq, QSPI_CR);
> -- 
> 2.39.5
> 
> 

