Return-Path: <linux-spi+bounces-8794-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B354AEAE05
	for <lists+linux-spi@lfdr.de>; Fri, 27 Jun 2025 06:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68BC9175C1B
	for <lists+linux-spi@lfdr.de>; Fri, 27 Jun 2025 04:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623D01CD1E4;
	Fri, 27 Jun 2025 04:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qEIXdiM1"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943401C5F10
	for <linux-spi@vger.kernel.org>; Fri, 27 Jun 2025 04:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750999171; cv=none; b=iVS/muWGqJc/zBV8fCC8CLuenekeX4Stwn4emyxO2K7phquCjO2fArRT03kqoClUiO+R+zh1jdZFYXYcQmSF4lRVKZNvVRLjhkwIAk5g0OyghMPg/qyt6zjbf/If6GIsArFD7VuqtgT0sv4Uqa0NtDhOSk/hmceYFx4c3VoUqsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750999171; c=relaxed/simple;
	bh=L8zH5DwFvKXg3d7sLBPHt5rWqwBS6q3Ktrm2ltBTuoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JlI827apzyuVbVnxCi5u72r0XeqiIoaD6zFE5QuYlBSO1iLXwmRVQ2XgernGhppmF+orIGbETnHe0Q5cl3yYZWhCS2m+o4f6sGBaaK99gjM+8kIiWy0EmP5EOvu/9LRD5YFFagMXALxn1pGy4/FMGCqjh4wJGRNHdxgAHbuIF5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qEIXdiM1; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-735ae68cc78so1074063a34.1
        for <linux-spi@vger.kernel.org>; Thu, 26 Jun 2025 21:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750999168; x=1751603968; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=22viup5EXH3YN9z+xYLRVBFubu8JD5YEOw2bjdLSidI=;
        b=qEIXdiM120hJjqP2Jz8Ktx1RhYHfzQNEhlxRmrHzAA9oEagO3037Y8jjJX85PpdBgN
         C7MvvSgf2Va24NY1IhUXm7X7qkxzDJk3a/71M2NX5xOEdslkXqvl4L8TK/WIEniJyAJZ
         xR05onoPLjsHRqaUdCNMywVgFqy7AAxmoYWh/s+1NIU9cyi6yv1qYSJF9c2NVhEDuEJC
         XA9jl7BtYj81cqMrEJ+xviUKrcEzaIdSvQ5HwgBcWjwZYUn+aJXUyJdp2eEWYyu11wOA
         01O/B0VWJiBNiSq3fy0IuOejGjs7dRdfG4Rt0mNL5O+p57ZatxsIRLJJMCSZavSt1FaY
         TFjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750999168; x=1751603968;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=22viup5EXH3YN9z+xYLRVBFubu8JD5YEOw2bjdLSidI=;
        b=rKDM3MyCUwraDlUsyDkaB7+RPCSO+Cc77EKPEIgkhfk1RFYnwUtI5c/JJWEGxebVar
         hTQS1bvwUxSzW91iuWWx6zzwAIloCGWTMSBancCA9jRM5OlIl8Hexh/YbS2BU5MeXI8W
         oGLPhsgng0a6S390vNV7RZXkYaN9M6VfSgmpVnVjvQVHYcPnJbiW6DZqStip7Ik8wlSl
         XYCeTqaQ2iMJQ/COX2kYJ2pdCayx0AVpjplzmPKk/5rNQVIoroeJu4HBNBQTsRWCDS9b
         9xhVrjjwaAZO7xtVyAEn9Ol4MhHetqHdfd8BYqMqP8sVrBFEWQ+at6mfyZPgtvazXDBJ
         6A8A==
X-Forwarded-Encrypted: i=1; AJvYcCWFWHbIszOTz+qjwyXxOo5bihX2wqcACaanixvgagKn/LBF365M5a9/d9/qvCAaaPlU5XAcixrMwdc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnOQZ68DYffnLj21tvNRewlGkkz8q0hwseL1sWNnmL61DN1dP4
	y0bFn+2W3n3YlxLod9TJOUeHxjH1HpPvZ5O+hjeDiooftv94v6y57MewuYlSy1RJtbY=
X-Gm-Gg: ASbGncvVNoyrw2L/WLpj388+Nk5ls3174dKHClftks+PTRnno3tzYKok/KOsRDAW+nx
	0O+bboDdGmOKVjIK9ywo1fkiUyqppRrvs+lcEQkAZQO75RRg33eoQF/XHZmfGaY7UVkQXsJoxuX
	0VI87RwXUDCnQBJ2W7mcXNIcmId7LIssJngCJOINCKZnp8oeJwpibFG+WR72IPD5u1kkYTfWAMB
	9WG/dbvhIzHyL4ieXjCQUfzyjRfOmwmmC5kMnIGwWD41tZ1O4tkP6wYXcbmH7TGaTk1FaYCCUmY
	2+CWwf0OcPD+zfKbqdMzfPlAwB5/hvapWfnH1MUroT8gtmdY97AslYTRNHpXwkMPjEULOp/C0up
	7NxY=
X-Google-Smtp-Source: AGHT+IEUCbNi4feI1aFKOFSYP6qJmEYOXaKIN2vxigszkCAtzMT0sreT8KDi8Yqi/eYn+vcsCnGVSA==
X-Received: by 2002:a05:6830:6082:b0:73a:6d48:dec6 with SMTP id 46e09a7af769-73afc43bb1cmr1259475a34.5.1750999168431;
        Thu, 26 Jun 2025 21:39:28 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:154:5a01:d5a1:16d6])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73afaff243dsm242619a34.13.2025.06.26.21.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 21:39:27 -0700 (PDT)
Date: Fri, 27 Jun 2025 07:39:24 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: khairul.anuar.romli@altera.com
Cc: Mark Brown <broonie@kernel.org>,
	"open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	Matthew Gerlach <matthew.gerlach@altera.com>,
	Khairul Anuar Romli <khairulanuar.romli@altera.com>
Subject: Re: [PATCH v3 1/1] spi: spi-cadence-quadspi: Fix pm runtime unbalance
Message-ID: <62b9964d-0f2c-4d26-9b35-bb7af3aa5c4f@suswa.mountain>
References: <cover.1749601877.git.khairul.anuar.romli@altera.com>
 <4e7a4b8aba300e629b45a04f90bddf665fbdb335.1749601877.git.khairul.anuar.romli@altera.com>
 <ab51dfce-a7d1-4eb3-b469-af35529dfbbb@sabinyo.mountain>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ab51dfce-a7d1-4eb3-b469-af35529dfbbb@sabinyo.mountain>

On Thu, Jun 26, 2025 at 11:37:53PM -0500, Dan Carpenter wrote:
> On Mon, Jun 16, 2025 at 09:13:53AM +0800, khairul.anuar.romli@altera.com wrote:
> > From: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
> > 
> > Having PM put sync in remove function is causing PM underflow during
> > remove operation. This is caused by the function, runtime_pm_get_sync,
> > not being called anywhere during the op. Ensure that calls to
> > pm_runtime_enable()/pm_runtime_disable() and
> > pm_runtime_get_sync()/pm_runtime_put_sync() match.
> > 
> > echo 108d2000.spi > /sys/bus/platform/drivers/cadence-qspi/unbind
> > [   49.644256] Deleting MTD partitions on "108d2000.spi.0":
> > [   49.649575] Deleting u-boot MTD partition
> > [   49.684087] Deleting root MTD partition
> > [   49.724188] cadence-qspi 108d2000.spi: Runtime PM usage count underflow!
> > 
> > Continuous bind/unbind will result in an "Unbalanced pm_runtime_enable" error.
> > Subsequent unbind attempts will return a "No such device" error, while bind
> > attempts will return a "Resource temporarily unavailable" error.
> > 
> > [   47.592434] cadence-qspi 108d2000.spi: Runtime PM usage count underflow!
> > [   49.592233] cadence-qspi 108d2000.spi: detected FIFO depth (1024) different from config (128)
> > [   53.232309] cadence-qspi 108d2000.spi: Runtime PM usage count underflow!
> > [   55.828550] cadence-qspi 108d2000.spi: detected FIFO depth (1024) different from config (128)
> > [   57.940627] cadence-qspi 108d2000.spi: Runtime PM usage count underflow!
> > [   59.912490] cadence-qspi 108d2000.spi: detected FIFO depth (1024) different from config (128)
> > [   61.876243] cadence-qspi 108d2000.spi: Runtime PM usage count underflow!
> > [   61.883000] platform 108d2000.spi: Unbalanced pm_runtime_enable!
> > [  532.012270] cadence-qspi 108d2000.spi: probe with driver cadence-qspi failed1
> > 
> > Also, change clk_disable_unprepare() to clk_disable() since continuous
> > bind and unbind operations will trigger a warning indicating that the clock is
> > already unprepared.
> > 
> > Fixes: 4892b374c9b7 ("mtd: spi-nor: cadence-quadspi: Add runtime PM support")
> > cc: stable@vger.kernel.org # 6.6+
> > Signed-off-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
> > Reviewed-by: Matthew Gerlach <matthew.gerlach@altera.com>
> > ---
> > Changes in v3:
> >     - v2 was sent without a "Changes in v2" section.
> > 
> > Changes in v2:
> >     - Remove the runtime_pm variable from the struct, as it’s not needed for the fix.
> > ---
> >  drivers/spi/spi-cadence-quadspi.c | 12 +++++++-----
> >  1 file changed, 7 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
> > index c90462783b3f..506a139fbd2c 100644
> > --- a/drivers/spi/spi-cadence-quadspi.c
> > +++ b/drivers/spi/spi-cadence-quadspi.c
> > @@ -1958,10 +1958,10 @@ static int cqspi_probe(struct platform_device *pdev)
> >  			goto probe_setup_failed;
> >  	}
> >  
> > -	ret = devm_pm_runtime_enable(dev);
> > -	if (ret) {
> > -		if (cqspi->rx_chan)
> > -			dma_release_channel(cqspi->rx_chan);
> > +	pm_runtime_enable(dev);
> > +
> > +	if (cqspi->rx_chan) {
> > +		dma_release_channel(cqspi->rx_chan);
> >  		goto probe_setup_failed;
> >  	}
> 
> This will totally break the driver.  It was supposed to be
> 
> 	if (ret) {
> 		if (cqspi->rx_chan)
> 			dma_release_channel(cqspi->rx_chan);
> 		goto probe_setup_failed;
>   	}
> 
> In other words, if we failed there was some slightly complicated
> cleanup to do.  But now it will do the cleanup and free things on the
> success path if we're in cqspi->use_direct_mode.
> 

I suck at email.  What I meant was delete the if block:

-	if (cqspi->rx_chan) {
-		dma_release_channel(cqspi->rx_chan);
-		goto probe_setup_failed;
-	}
-

regards,
dan carpenter


