Return-Path: <linux-spi+bounces-5056-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2782798AB4F
	for <lists+linux-spi@lfdr.de>; Mon, 30 Sep 2024 19:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1AD4B241B8
	for <lists+linux-spi@lfdr.de>; Mon, 30 Sep 2024 17:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 368F8198A0D;
	Mon, 30 Sep 2024 17:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L3E5kif4"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F13A194083;
	Mon, 30 Sep 2024 17:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727718319; cv=none; b=F5iWvoYdPJi0LOyWjzu8UGdUJXkL0DbnPEwtSeyeJIZWeCxAKLAfGuTHubPjfJuHsf8QXfbauapquEKo1spkTGjjJrihUAQVNCf0y1UyaoYOzmfCLqx6gxU9kU7LGcwboG9d3A18Db81VrWkwnNm/QAFUH3qKBsGeD0xfz8/OF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727718319; c=relaxed/simple;
	bh=N9PcVf6d20XVgwqXUKJQ/WsjzZiQvzlNNHjxcrEJbos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oV8317uS9BG052cmeF+SYQrD22iJDlh2bu02+1RzTR7/bx6QC5KdJ6KG7gL/yqwqDPiCML8EvKScwQjlj7STRf4S393pdmDRfH6yfIjleeS4VFp8ivGxEaLInyVLhGXFKrfFDhCFJkNPqKfi9fTh9vN74lEBEBh/AJ4+2IdqK60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L3E5kif4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 046A0C4CEC7;
	Mon, 30 Sep 2024 17:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727718318;
	bh=N9PcVf6d20XVgwqXUKJQ/WsjzZiQvzlNNHjxcrEJbos=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L3E5kif4FekWKp4jQ8Nd/PHkquJXE8NyTc4PdmB24Ug/hajOrrI0x8Y7rHgUsTXsP
	 15GFEAkQGjCyKc+Irt4WIWygIM5HVFhfgtwHf7CxtRZRa+VnJlkdD5r1wm3WaP8Gxs
	 GgTgLC0SCh1unx3fpHOxzpPmjYeU7S/BuDF9V8avG+vlt4Ay9307JZBBgrMy3MQU58
	 QtvfLUrat5QIBhz9K7WCc6tU7HYPGQdEm4aLiVWei7MuwFf0QG9y6zEpT5JZEzehIx
	 HIYPD4ErIF27o69PWCMBs4IpAm9JioYtXWKDgn0NWOVm82GUQHu47tqeOSBhFqjN63
	 0/EEIW0Q8T5wQ==
Date: Mon, 30 Sep 2024 19:45:14 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Alim Akhtar <alim.akhtar@samsung.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] spi: s3c64xx: fix timeout counters in flush_fifo
Message-ID: <bnni7zksylihkrtd5kje3hjy2wg2rt5pnbyxrxgwdn73mkadav@fogqavrpxqzm>
References: <20240924134009.116247-1-ben.dooks@codethink.co.uk>
 <20240924134009.116247-2-ben.dooks@codethink.co.uk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240924134009.116247-2-ben.dooks@codethink.co.uk>

Hi Ben,

On Tue, Sep 24, 2024 at 02:40:08PM GMT, Ben Dooks wrote:
> In the s3c64xx_flush_fifo() code, the loops counter is post-decremented
> in the do { } while(test && loops--) condition. This means the loops is
> left at the unsigned equivalent of -1 if the loop times out. The test
> after will never pass as if tests for loops == 0.
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

Fixes: 230d42d422e7 ("spi: Add s3c64xx SPI Controller driver")
Cc: <stable@vger.kernel.org> # v2.6.33+

> ---
>  drivers/spi/spi-s3c64xx.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
> index 833c58c88e40..6ab416a33966 100644
> --- a/drivers/spi/spi-s3c64xx.c
> +++ b/drivers/spi/spi-s3c64xx.c
> @@ -245,7 +245,7 @@ static void s3c64xx_flush_fifo(struct s3c64xx_spi_driver_data *sdd)
>  	loops = msecs_to_loops(1);
>  	do {
>  		val = readl(regs + S3C64XX_SPI_STATUS);
> -	} while (TX_FIFO_LVL(val, sdd) && loops--);
> +	} while (TX_FIFO_LVL(val, sdd) && --loops);

Do you think a better fix would be to have a "long loops" as I
don't think we need such a big data type for basically 4 * HZ.

And this becomes (loops >= 0);

The same below.

BTW, it's good you sent these patches separately as this needs to
be ported to the stable kernels.

In any case,

Reviewed-by: Andi Shyti <andi.shyti@kernel.org>

Thanks,
Andi

>  
>  	if (loops == 0)
>  		dev_warn(&sdd->pdev->dev, "Timed out flushing TX FIFO\n");
> @@ -258,7 +258,7 @@ static void s3c64xx_flush_fifo(struct s3c64xx_spi_driver_data *sdd)
>  			readl(regs + S3C64XX_SPI_RX_DATA);
>  		else
>  			break;
> -	} while (loops--);
> +	} while (--loops);
>  
>  	if (loops == 0)
>  		dev_warn(&sdd->pdev->dev, "Timed out flushing RX FIFO\n");
> -- 
> 2.37.2.352.g3c44437643
> 

