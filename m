Return-Path: <linux-spi+bounces-5066-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E4698B087
	for <lists+linux-spi@lfdr.de>; Tue,  1 Oct 2024 00:51:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D993F2820E0
	for <lists+linux-spi@lfdr.de>; Mon, 30 Sep 2024 22:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21F51183CA5;
	Mon, 30 Sep 2024 22:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T1Cs+0nD"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED90D21373;
	Mon, 30 Sep 2024 22:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727736676; cv=none; b=FikMPdCQhNQtIOUQXsPLKFZWA1npiWRpQKIRbNANl+DqQ5d0I1GlYcyPbRFZfqzbTe/ORF6R1uhkkI9J3Q5Ss2AN6kFYsrZaBbKbetHOiroXTswUMw4qDVwu07atNiTm9H6ETtwoKdopGaViZM9BPzcjrR/LzudfoGjONbHxLbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727736676; c=relaxed/simple;
	bh=zp3v8+uw+c21EFh7Ft7ejmLCE36o281WJpfxDyHQqVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=loDoMK+3JMtnwVOCLjrNsjFXIJowKj1q1PPtI5fBuO0ei3/VLo6dSS4PZXbcuUWCxqp32NuvVmxPZtsLayUD3z5231Q1xKPKf41+ks3ULhdlBroYfRVQp555nj21v485hkgzGVxRg8OUe8k63HNcP2YrV8QcSFSb9W1q66HHrk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T1Cs+0nD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C250C4CEC7;
	Mon, 30 Sep 2024 22:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727736675;
	bh=zp3v8+uw+c21EFh7Ft7ejmLCE36o281WJpfxDyHQqVM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T1Cs+0nDsv/f0GiaCOxTOr8vVvLkOHOeuhZfD5C72U8CeoycALMysojk3PPxCTxoT
	 RQV8ImVowZr3clZIN63niG7soq26xj+4jIWBJdAoW+6NG0swrOb7/IqVpfI6GY3Drd
	 uXPyO+LwLeY5rG3yIPiFF1CCQITWDPRx7TzHjLG1SyIjUsZGVNVRMABrVvOYJ25giP
	 Ya/kKIP1r7L1khme7oj1M8B1aOFFXQKAWkS4UribBT4kt1wIkkqMo9IWJv5avzj05T
	 0eib3mV+22IWzrDyv/tRY0Nj7b9gtD1s2/uYDmLQ7MyW2nzBDaq7QRFaWbSlUg9D3c
	 LYqLrFBjfswqQ==
Date: Tue, 1 Oct 2024 00:51:12 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Alim Akhtar <alim.akhtar@samsung.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] spi: s3c64xx: update flush_fifo timeout code
Message-ID: <j53542aqpa72jqowtyinlueefhnwp6upz2li6btezygtjz5bz4@uivxzbfsvhy5>
References: <20240924134009.116247-1-ben.dooks@codethink.co.uk>
 <20240924134009.116247-3-ben.dooks@codethink.co.uk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240924134009.116247-3-ben.dooks@codethink.co.uk>

On Tue, Sep 24, 2024 at 02:40:09PM GMT, Ben Dooks wrote:
> The code that checks for loops in the s3c6xx_flush_fifo() checks
> for loops being non-zero as a timeout, however the code /could/
> finish with loops being zero and the fifo being flushed...

what is the possibility of this case?

> Also, it would be useful to know what is left in the fifo for this
> error case, so update the checks to see what is left, and then also
> print the number of entries.
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
>  drivers/spi/spi-s3c64xx.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
> index 6ab416a33966..7b244e1fd58a 100644
> --- a/drivers/spi/spi-s3c64xx.c
> +++ b/drivers/spi/spi-s3c64xx.c
> @@ -247,8 +247,8 @@ static void s3c64xx_flush_fifo(struct s3c64xx_spi_driver_data *sdd)
>  		val = readl(regs + S3C64XX_SPI_STATUS);
>  	} while (TX_FIFO_LVL(val, sdd) && --loops);
>  
> -	if (loops == 0)
> -		dev_warn(&sdd->pdev->dev, "Timed out flushing TX FIFO\n");
> +	if (TX_FIFO_LVL(val, sdd))
> +		dev_warn(&sdd->pdev->dev, "Timed out flushing TX FIFO (%d left)\n", TX_FIFO_LVL(val, sdd));
>  
>  	/* Flush RxFIFO*/
>  	loops = msecs_to_loops(1);
> @@ -260,8 +260,8 @@ static void s3c64xx_flush_fifo(struct s3c64xx_spi_driver_data *sdd)
>  			break;
>  	} while (--loops);
>  
> -	if (loops == 0)
> -		dev_warn(&sdd->pdev->dev, "Timed out flushing RX FIFO\n");
> +	if (RX_FIFO_LVL(val, sdd))
> +		dev_warn(&sdd->pdev->dev, "Timed out flushing RX FIFO (%d left)\n", RX_FIFO_LVL(val, sdd));

This change doesn't super excite me, but it's fine. Please add a
comment explaining the case when loops is '0' and the FIFO is
flushed.

With the comment given, you can have my r-b.

Thanks,
Andi

>  	val = readl(regs + S3C64XX_SPI_CH_CFG);
>  	val &= ~S3C64XX_SPI_CH_SW_RST;
> -- 
> 2.37.2.352.g3c44437643
> 

