Return-Path: <linux-spi+bounces-8793-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B5544AEAE04
	for <lists+linux-spi@lfdr.de>; Fri, 27 Jun 2025 06:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 766407B001A
	for <lists+linux-spi@lfdr.de>; Fri, 27 Jun 2025 04:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E791D514B;
	Fri, 27 Jun 2025 04:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tpHtyE/4"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79783194098
	for <linux-spi@vger.kernel.org>; Fri, 27 Jun 2025 04:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750999080; cv=none; b=VbKxFMpoif0fQInrlxbQwb3s2pV+f8euDeqY9UsJSnOnX0BTNanAG7Y9C0trjpkdtAabn3noxCFtnrQKz1yqcn29z6BuJEde18pcEaXGf22Qhq+WO57BHEYSEWubAXNLgGACjuRuH/ZbfMUr90bNZKW+ZcoavgU4veT09tm7s8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750999080; c=relaxed/simple;
	bh=lbDfR0M6F2JbnvzyAx2Qg3otQW0pIDhNNDg/RQfomBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GCD4lYKHMr7O/AMihN4r65dQLVc4pQkmJQkAD/ar9ac2q8JUOPWx0WBwvg7HWeTBbKe603leScU8RJ7DVOiH60bFQgM5VtPn5Ol/Ee4CpDJsFlayxStazmNdMu51N/EF1sOHWVvfU6qhs1qGqe89yPyXCshwyJjOYQfCin4s3PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tpHtyE/4; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-2e95ab2704fso1203997fac.3
        for <linux-spi@vger.kernel.org>; Thu, 26 Jun 2025 21:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750999077; x=1751603877; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TyE67c3xK1K5sXtasghRqBYlwpIPHXfPSwBOJU15tFo=;
        b=tpHtyE/4ufaQ7GLgF8HZCb9UTCJp/OZIo882op8rDmxEmcxIt15L/vvPepq8a6MZh2
         JYrBet5tU2XCvH7f8x1X4aJRq2ra97ctXutFumWsi/OwwD56i+EkhC0oVdG4OfqaRPog
         iZI2yBdEPZZAYuDwM2rDBF5KEpQUIWxpGUc3m/3SmIj0klSsfOYqrbjc6aFpBFte4U8H
         L/NjT/5CFQ62gCx1xTHaLdKnolrxQ0B4iyZtQ62s5iSMiMXgRUFkoSKXblkbACGT7d3r
         DphKGkQ2cbrPqTYnL72oRxLu4anX+ryIb+b0Bs2PZaaqv406DDC98nhdUo1vzb43NlER
         fAeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750999077; x=1751603877;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TyE67c3xK1K5sXtasghRqBYlwpIPHXfPSwBOJU15tFo=;
        b=AP0BDgrZZltaB7dw4k5acTx6Ak3S1t1y4UAGwP+hLND38c7dZMZC5/VqDDkfV7jTWq
         R0aBgVyTwKS18+pJ7VFEStCncZssgHVKbtvlGMlQbm7A0yvZ1SQR4Kfcgx/A1VnO8zOS
         VuC3gdOT8h6s12y9F87VLrfRWtDJh8N7aYEHrclU2sCbxOR5IgJKjDsPgXerXXxft8wP
         KJC+5p419kLDHIUdIPM3Dhvgx907wH64XiOUS8CW5WNmK5mYqcKfW75y2eQSEAmTG3jV
         mNqJp+FyAS8alHPZ2m6/qN87FDprRUYN6jQwLMpFA6h4jvx7F+9grwZevwlWYrcV48/6
         m5Og==
X-Forwarded-Encrypted: i=1; AJvYcCW/AqKqlVuP8BL4ojBCT3nlTwRY12bNKJVqt9Gg5EXB+S6Rdmp4h02izd+dXb6r6aqvBc1Ssg25k/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxozNLaHD9f+94KfebNoZQ/bWM/lFcItsjLR1Ol4sSF3vYbpArU
	22p9B6oZnai0QqKyylwDRBh99O5Kq0iWpFbLvhoch4Pl7/ReV52bHDyTEROaJRP49KA=
X-Gm-Gg: ASbGnctCsjXOa7RVyFV3vFkuMk3Z+DP5mZ62K8bE1qOwe8pDVPSAc09RKjfVifDzH0t
	+JgzT5ROLCQcFahj4qb7KeaKPA01ICsrSrsDtsfbiQ6M/pHiTTLc2DHQxlg2mWEoTeg9Ck/biu2
	GWpktx1EeRgDP2UKjCrsdzQ+5nHRe0s9y38aVn9nRBPcCAwk02g10RFgn+hXwwAib+5aB2QrdND
	VeQTAxtgYOIz1+A/R4rTQDWMn6MxI3/X4eTpJqX3/Cm+ghyq5e+2aH4kPsBn84QiFTq7Y9Ude2P
	rw43+XWMrtNe+wAvMYhiVHFCyhKqcqHsOi7TdpJ3MZNlVUJD2vrBPwE80W1l694XoiUrNw==
X-Google-Smtp-Source: AGHT+IHo2Jt+2kbCf9W2+f8umYHBvpInEdU81oNGE0Zmzd1jhDArDCGS8XYCy9XsRrBNkXVAklM5cg==
X-Received: by 2002:a05:6870:d8cd:b0:29d:c764:f873 with SMTP id 586e51a60fabf-2efed877494mr1037657fac.31.1750999077563;
        Thu, 26 Jun 2025 21:37:57 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:2146:7e21:238a:e0ed])
        by smtp.gmail.com with UTF8SMTPSA id 586e51a60fabf-2efd512f0cdsm707303fac.46.2025.06.26.21.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 21:37:56 -0700 (PDT)
Date: Thu, 26 Jun 2025 23:37:53 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: khairul.anuar.romli@altera.com
Cc: Mark Brown <broonie@kernel.org>,
	"open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	Matthew Gerlach <matthew.gerlach@altera.com>,
	Khairul Anuar Romli <khairulanuar.romli@altera.com>
Subject: Re: [PATCH v3 1/1] spi: spi-cadence-quadspi: Fix pm runtime unbalance
Message-ID: <ab51dfce-a7d1-4eb3-b469-af35529dfbbb@sabinyo.mountain>
References: <cover.1749601877.git.khairul.anuar.romli@altera.com>
 <4e7a4b8aba300e629b45a04f90bddf665fbdb335.1749601877.git.khairul.anuar.romli@altera.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4e7a4b8aba300e629b45a04f90bddf665fbdb335.1749601877.git.khairul.anuar.romli@altera.com>

On Mon, Jun 16, 2025 at 09:13:53AM +0800, khairul.anuar.romli@altera.com wrote:
> From: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
> 
> Having PM put sync in remove function is causing PM underflow during
> remove operation. This is caused by the function, runtime_pm_get_sync,
> not being called anywhere during the op. Ensure that calls to
> pm_runtime_enable()/pm_runtime_disable() and
> pm_runtime_get_sync()/pm_runtime_put_sync() match.
> 
> echo 108d2000.spi > /sys/bus/platform/drivers/cadence-qspi/unbind
> [   49.644256] Deleting MTD partitions on "108d2000.spi.0":
> [   49.649575] Deleting u-boot MTD partition
> [   49.684087] Deleting root MTD partition
> [   49.724188] cadence-qspi 108d2000.spi: Runtime PM usage count underflow!
> 
> Continuous bind/unbind will result in an "Unbalanced pm_runtime_enable" error.
> Subsequent unbind attempts will return a "No such device" error, while bind
> attempts will return a "Resource temporarily unavailable" error.
> 
> [   47.592434] cadence-qspi 108d2000.spi: Runtime PM usage count underflow!
> [   49.592233] cadence-qspi 108d2000.spi: detected FIFO depth (1024) different from config (128)
> [   53.232309] cadence-qspi 108d2000.spi: Runtime PM usage count underflow!
> [   55.828550] cadence-qspi 108d2000.spi: detected FIFO depth (1024) different from config (128)
> [   57.940627] cadence-qspi 108d2000.spi: Runtime PM usage count underflow!
> [   59.912490] cadence-qspi 108d2000.spi: detected FIFO depth (1024) different from config (128)
> [   61.876243] cadence-qspi 108d2000.spi: Runtime PM usage count underflow!
> [   61.883000] platform 108d2000.spi: Unbalanced pm_runtime_enable!
> [  532.012270] cadence-qspi 108d2000.spi: probe with driver cadence-qspi failed1
> 
> Also, change clk_disable_unprepare() to clk_disable() since continuous
> bind and unbind operations will trigger a warning indicating that the clock is
> already unprepared.
> 
> Fixes: 4892b374c9b7 ("mtd: spi-nor: cadence-quadspi: Add runtime PM support")
> cc: stable@vger.kernel.org # 6.6+
> Signed-off-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
> Reviewed-by: Matthew Gerlach <matthew.gerlach@altera.com>
> ---
> Changes in v3:
>     - v2 was sent without a "Changes in v2" section.
> 
> Changes in v2:
>     - Remove the runtime_pm variable from the struct, as it’s not needed for the fix.
> ---
>  drivers/spi/spi-cadence-quadspi.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
> index c90462783b3f..506a139fbd2c 100644
> --- a/drivers/spi/spi-cadence-quadspi.c
> +++ b/drivers/spi/spi-cadence-quadspi.c
> @@ -1958,10 +1958,10 @@ static int cqspi_probe(struct platform_device *pdev)
>  			goto probe_setup_failed;
>  	}
>  
> -	ret = devm_pm_runtime_enable(dev);
> -	if (ret) {
> -		if (cqspi->rx_chan)
> -			dma_release_channel(cqspi->rx_chan);
> +	pm_runtime_enable(dev);
> +
> +	if (cqspi->rx_chan) {
> +		dma_release_channel(cqspi->rx_chan);
>  		goto probe_setup_failed;
>  	}

This will totally break the driver.  It was supposed to be

	if (ret) {
		if (cqspi->rx_chan)
			dma_release_channel(cqspi->rx_chan);
		goto probe_setup_failed;
  	}

In other words, if we failed there was some slightly complicated
cleanup to do.  But now it will do the cleanup and free things on the
success path if we're in cqspi->use_direct_mode.

regards,
dan carpenter


>  
> @@ -1981,6 +1981,7 @@ static int cqspi_probe(struct platform_device *pdev)
>  	return 0;
>  probe_setup_failed:
>  	cqspi_controller_enable(cqspi, 0);
> +	pm_runtime_disable(dev);
>  probe_reset_failed:
>  	if (cqspi->is_jh7110)
>  		cqspi_jh7110_disable_clk(pdev, cqspi);
> @@ -1999,7 +2000,8 @@ static void cqspi_remove(struct platform_device *pdev)
>  	if (cqspi->rx_chan)
>  		dma_release_channel(cqspi->rx_chan);
>  
> -	clk_disable_unprepare(cqspi->clk);
> +	if (pm_runtime_get_sync(&pdev->dev) >= 0)
> +		clk_disable(cqspi->clk);
>  
>  	if (cqspi->is_jh7110)
>  		cqspi_jh7110_disable_clk(pdev, cqspi);
> -- 
> 2.35.3
> 

