Return-Path: <linux-spi+bounces-11576-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BDFD3C88E8E
	for <lists+linux-spi@lfdr.de>; Wed, 26 Nov 2025 10:23:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1EDD5355A25
	for <lists+linux-spi@lfdr.de>; Wed, 26 Nov 2025 09:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D45993019C5;
	Wed, 26 Nov 2025 09:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="ppmCTh9m"
X-Original-To: linux-spi@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53EF72E03F2
	for <linux-spi@vger.kernel.org>; Wed, 26 Nov 2025 09:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764148999; cv=none; b=nGgFBUpGaRgnNBYUTjHry87zeKyvcnozX7ojEp88E3AXIg/KZ/jdkFHfkHJ6z6wSsCyDRJzvVUl6ywoto/AL9ctEopRW6Ut/kFfEkPBf5f8idLnWfkt8TybonBbl+4wSYJ2KmAWcs0sT9dBmegdIF04QJmC+o2xhva2k8glsdsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764148999; c=relaxed/simple;
	bh=wixrgdMWvektAfki4LUuIuIMAc6wkVwerFO7SvnDyfg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qz7qJA+qsSieX3vI/zQbDErtPP1ccixgoPmgAFZT9ebFa252DiUvYt/UQt64xfhc7DS1DZIh4KCskAKRwTexHQ2kQf0OAdz3oZDxquZif5SLKEEq8J3s0jKCwjVzA8bHswK472lefoanc1BP3Z5NBhl8x44rVDnHTWsKaEglEIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=runbox.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=ppmCTh9m; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=runbox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight@runbox.com>)
	id 1vOBk2-008zoe-1B; Wed, 26 Nov 2025 10:23:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date;
	bh=X7mv+EDXWUYP656BAyXTbXpNq08vOgz9UAI+XYQ2FOo=; b=ppmCTh9m6vlJvqJpoKUsFkw4BB
	6CAlfmZ8tqjNpfd9DRduyfzVhfVAA87Fw+KAoQqM2n034UoVO1H26HYUW00ONFwcuaq5I8oWHBJYp
	R9il0+Xw6nE7ijwwN75chYVKEPejDE9xItYmhi32ZcckeZGmbOgWEayJRTfN9iAaaa70zB/GEy8xu
	YLn05HhtcysOFoBjZG+zkaBXisCs2W0sVmWSj9G0mZUAWokm2C2xeBfpZmnOChLv3Vp4D0jPGAL1o
	BIuGKLdmSbJX8bQk8NrbiXQFEBMFHj+7SJjLxhI+y0hpGV9Re2ewAWBjbTbZBhh31MBOqeaHTW9Ar
	yLMUZvOg==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight@runbox.com>)
	id 1vOBk1-0001o0-FJ; Wed, 26 Nov 2025 10:23:13 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vOBjs-00DGBa-IJ; Wed, 26 Nov 2025 10:23:04 +0100
Date: Wed, 26 Nov 2025 09:22:58 +0000
From: david laight <david.laight@runbox.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>,
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown
 <broonie@kernel.org>
Subject: Re: [PATCH v2 1/6] spi: microchip-core: use min() instead of
 min_t()
Message-ID: <20251126092258.3bc4d92e@pumpkin>
In-Reply-To: <20251126075558.2035012-2-andriy.shevchenko@linux.intel.com>
References: <20251126075558.2035012-1-andriy.shevchenko@linux.intel.com>
	<20251126075558.2035012-2-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Nov 2025 08:54:39 +0100
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> min_t(int, a, b) casts an 'unsigned int' to 'int'. This might lead
> to the cases when big number is wrongly chosen. On the other hand,
> the SPI transfer length is unsigned and driver uses signed type for
> an unknown reason. Change the type of the transfer length to be
> unsigned and convert use min() instead of min_t().
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: David Laight <david.laight.linux@gmail.com>

> ---
>  drivers/spi/spi-microchip-core-spi.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/spi/spi-microchip-core-spi.c b/drivers/spi/spi-microchip-core-spi.c
> index 16e0885474a0..08ccdc5f0cc9 100644
> --- a/drivers/spi/spi-microchip-core-spi.c
> +++ b/drivers/spi/spi-microchip-core-spi.c
> @@ -74,8 +74,8 @@ struct mchp_corespi {
>  	u8 *rx_buf;
>  	u32 clk_gen;
>  	int irq;
> -	int tx_len;
> -	int rx_len;
> +	unsigned int tx_len;
> +	unsigned int rx_len;
>  	u32 fifo_depth;
>  };
>  
> @@ -214,7 +214,7 @@ static irqreturn_t mchp_corespi_interrupt(int irq, void *dev_id)
>  		       spi->regs + MCHP_CORESPI_REG_INTCLEAR);
>  		finalise = true;
>  		dev_err(&host->dev,
> -			"RX OVERFLOW: rxlen: %d, txlen: %d\n",
> +			"RX OVERFLOW: rxlen: %u, txlen: %u\n",
>  			spi->rx_len, spi->tx_len);
>  	}
>  
> @@ -223,7 +223,7 @@ static irqreturn_t mchp_corespi_interrupt(int irq, void *dev_id)
>  		       spi->regs + MCHP_CORESPI_REG_INTCLEAR);
>  		finalise = true;
>  		dev_err(&host->dev,
> -			"TX UNDERFLOW: rxlen: %d, txlen: %d\n",
> +			"TX UNDERFLOW: rxlen: %u, txlen: %u\n",
>  			spi->rx_len, spi->tx_len);
>  	}
>  
> @@ -283,7 +283,7 @@ static int mchp_corespi_transfer_one(struct spi_controller *host,
>  	spi->rx_len = xfer->len;
>  
>  	while (spi->tx_len) {
> -		int fifo_max = min_t(int, spi->tx_len, spi->fifo_depth);
> +		unsigned int fifo_max = min(spi->tx_len, spi->fifo_depth);
>  
>  		mchp_corespi_write_fifo(spi, fifo_max);
>  		mchp_corespi_read_fifo(spi, fifo_max);


