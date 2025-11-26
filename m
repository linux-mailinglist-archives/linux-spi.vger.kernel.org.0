Return-Path: <linux-spi+bounces-11575-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C3FC88E81
	for <lists+linux-spi@lfdr.de>; Wed, 26 Nov 2025 10:22:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 494A93A24CF
	for <lists+linux-spi@lfdr.de>; Wed, 26 Nov 2025 09:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF8A22D949F;
	Wed, 26 Nov 2025 09:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="cUZ6mtuc"
X-Original-To: linux-spi@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1292D6619;
	Wed, 26 Nov 2025 09:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764148938; cv=none; b=WTP9JsdLXEO7kFWO4ckg9WKulQxD5RmnWVjCiJda3y2g317Va4yIm2ZhP0Hh977t52C2EViqTddA9lKGJjtGbxootSa64Gz4WieF6np30CFP/tVWRLNz9dHL/cPPjbdkcIwGBxXwAAYvvhHdTRvYXbGocBDBJsfKNPGH/hevfxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764148938; c=relaxed/simple;
	bh=wcbOC7cDNFpn+w2gg/QyHWOIUQBex10XFz2ofFQ/sRk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IJK7e6ZnWZQb8AQvrq4v4B3gi7b1VP0gJFTNxdzQmrBs7c/NOlnYWPbNgoqYRhca4XeDp01by9h330myN1NM4wtJQWIsc8SyoIBJvtVwc9q6uKLh9oodWPYNaD4Fe9/1YwGVXOK+p04+dPtqpLU7HSr5ALffFPH9W/5VT1N4VPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=runbox.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=cUZ6mtuc; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=runbox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight@runbox.com>)
	id 1vOBio-008q0B-Mc; Wed, 26 Nov 2025 10:21:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date;
	bh=m2z5jPUd1uZpxG5kCFJP4KqbQHAz8ShoNjHS8tLPV0g=; b=cUZ6mtucvDxtNZm+h7T8Ly9SxA
	mrynrBOR9oPzY5Z0VZhBJ8aROKhxFOwOc9bzYaZWbsG66WnF8UCApWHuOpI8N0sVaWj+qiocdFPe9
	tngv5Kvs3VWUXPSyVCkWiEzIKJsHBle4RtnHT8zwV/tM8xMKA0ywZEGR1RGQvQIpWH8y7hDOdKVS9
	L7nXT1vtXVYi/035oN7OULZv9JVNdip75wxJpEZW9z9f0IcCUQlvpapspriwt+WaNCr04pp8bEXir
	K/dtrgO3wDLVLm1FNdST9NOCyqvAwHDgEW/CO7Gdo3LakFVOZGJgVMSBQiLzCpAurTk0WHCRu32Fg
	h8G5qHag==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight@runbox.com>)
	id 1vOBio-0002Wa-AP; Wed, 26 Nov 2025 10:21:58 +0100
Received: by submission01.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vOBig-00D2ap-Ca; Wed, 26 Nov 2025 10:21:50 +0100
Date: Wed, 26 Nov 2025 09:21:45 +0000
From: david laight <david.laight@runbox.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>,
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown
 <broonie@kernel.org>
Subject: Re: [PATCH v2 2/6] spi: microchip-core: Refactor FIFO read and
 write handlers
Message-ID: <20251126092145.2f8e4c8d@pumpkin>
In-Reply-To: <20251126075558.2035012-3-andriy.shevchenko@linux.intel.com>
References: <20251126075558.2035012-1-andriy.shevchenko@linux.intel.com>
	<20251126075558.2035012-3-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Nov 2025 08:54:40 +0100
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Make both handlers to be shorter and easier to understand.
> While at it, unify their style.

The read code looks dubious... (nothing new though)

> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/spi/spi-microchip-core-spi.c | 32 +++++++++-------------------
>  1 file changed, 10 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/spi/spi-microchip-core-spi.c b/drivers/spi/spi-microchip-core-spi.c
> index 08ccdc5f0cc9..f8184b711272 100644
> --- a/drivers/spi/spi-microchip-core-spi.c
> +++ b/drivers/spi/spi-microchip-core-spi.c
> @@ -91,21 +91,14 @@ static inline void mchp_corespi_disable(struct mchp_corespi *spi)
>  static inline void mchp_corespi_read_fifo(struct mchp_corespi *spi, u32 fifo_max)
>  {
>  	for (int i = 0; i < fifo_max; i++) {
> -		u32 data;
> -
>  		while (readb(spi->regs + MCHP_CORESPI_REG_STAT) &
>  		       MCHP_CORESPI_STATUS_RXFIFO_EMPTY)
>  			;

This is a hard spin until data is available.
I think 'spi' is a bit like 'i2c' (etc) so is quite slow.
Even if the code thinks there are 'fifo_max' bytes in the fifo it seems
wrong to spin indefinitely.
If the code is trying to read a response that is still arriving from the
physical hardware is is positively wrong.
If some hardware has a glitch that FIFO_EMPTY is temporarily incorrectly set
after a read - then maybe you need some recovery code.
Otherwise I suspect FIFO_EMPTY should generate a short read.

The write code (below) does an 'early terminate'' on fifo full.
Presumably it is woken by an interrupt to continue the write?

I actually doubt that transferring messages that are larger than the
device fifo is ever going to be completely reliable.
You'd need to guarantee the interrupt latency to update the fifo be short
enough to guarantee the fifo won't underflow/overflow.
(Unless the spi hardware 'clock stops' the physical interface when the fifo
if full/empty - which is effectively what happens when software 'bit-bangs'
these serial interfaces.)

>  
> -		data = readb(spi->regs + MCHP_CORESPI_REG_RXDATA);
> +		if (spi->rx_buf)
> +			*spi->rx_buf++ = readb(spi->regs + MCHP_CORESPI_REG_RXDATA);
>  
>  		spi->rx_len--;
> -		if (!spi->rx_buf)
> -			continue;
> -
> -		*spi->rx_buf = data;
> -
> -		spi->rx_buf++;
>  	}
>  }
>  
> @@ -127,23 +120,18 @@ static void mchp_corespi_disable_ints(struct mchp_corespi *spi)
>  
>  static inline void mchp_corespi_write_fifo(struct mchp_corespi *spi, u32 fifo_max)
>  {
> -	int i = 0;
> -
> -	while ((i < fifo_max) &&
> -	       !(readb(spi->regs + MCHP_CORESPI_REG_STAT) &
> -		 MCHP_CORESPI_STATUS_TXFIFO_FULL)) {
> -		u32 word;
> -
> -		word = spi->tx_buf ? *spi->tx_buf : 0xaa;
> -		writeb(word, spi->regs + MCHP_CORESPI_REG_TXDATA);
> +	for (int i = 0; i < fifo_max; i++) {

unsigned int or u32 ??

> +		if (readb(spi->regs + MCHP_CORESPI_REG_STAT) &
> +		    MCHP_CORESPI_STATUS_TXFIFO_FULL)
> +			break;
>  
>  		if (spi->tx_buf)
> -			spi->tx_buf++;
> +			writeb(*spi->tx_buf++, spi->regs + MCHP_CORESPI_REG_TXDATA);
> +		elsespi->regs + MCHP_CORESPI_REG_TXDATA);
> +			writeb(0xaa, spi->regs + MCHP_CORESPI_REG_TXDATA);

I'm not sure I don't prefer the version with one writeb() call.
How about:
		writeb(spi->tx_buf ? *spi->tx_buf++ : 0xaa,
			spi->regs + MCHP_CORESPI_REG_TXDATA);

	David
			
>  
> -		i++;
> +		spi->tx_len--;
>  	}
> -
> -	spi->tx_len -= i;
>  }
>  
>  static void mchp_corespi_set_cs(struct spi_device *spi, bool disable)


