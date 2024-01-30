Return-Path: <linux-spi+bounces-919-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7800842A79
	for <lists+linux-spi@lfdr.de>; Tue, 30 Jan 2024 18:08:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AF64283304
	for <lists+linux-spi@lfdr.de>; Tue, 30 Jan 2024 17:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28D81292D6;
	Tue, 30 Jan 2024 17:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grimler.se header.i=@grimler.se header.b="Gxw1Mf0g"
X-Original-To: linux-spi@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B691272AF;
	Tue, 30 Jan 2024 17:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706634501; cv=none; b=fMeM6DcXYksa2nxaiwQnbo/mc71WxuXFARkr9NBlsf4VMIiGkvDuOvMra/af8Dohsv/AMziWDgulrNt9Fe7lMUvzgU/v1n17YrxdxUb8hSXFlo0yGkoVLEbT2DHDQZNwXv1ua5rakapN1xpk5CPjRNmrkD9YGHjNI09YQzuFggE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706634501; c=relaxed/simple;
	bh=VCe4wdJUupOt5anELrGbzw6RnuJXnfEeZcgS/1Dpf1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kXtqJrgO8S0n0EP6LfRCmnDZtB9NdsyPkCDWSMvV5AF44pUrybCtjJxj/PAoPKtWc7cIEXbHN6athsGLiO1zbZSVEiIIB/ooL/HJ+8ivZerh8+EqwIvm9on2YRj0vesmcTmihfkyrKkAKe1TRwEDD4BvtMuCTkAX1Bv95omXcZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=grimler.se; spf=pass smtp.mailfrom=grimler.se; dkim=pass (1024-bit key) header.d=grimler.se header.i=@grimler.se header.b=Gxw1Mf0g; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=grimler.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grimler.se
Date: Tue, 30 Jan 2024 18:08:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grimler.se; s=key1;
	t=1706634494;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Cc4Rh3v8bRmTdkupUJZkGEVgAAt9wYdcDz/4Mk3tmng=;
	b=Gxw1Mf0gnkNpOu8rUdqR4wwsPWlpb/9d6u/SQz8YEY/TlnSVE/7X13czUlN8Rrjtv6hkvj
	+kxbwUXzty9yxRrBTi3tv3xrrf6Z4Mw13xTdMfctl21hTDLw5AR/OaPB/evL8pxaCr7ZPG
	UNRZe9+ptxAicq4mLGZ+JBpbdmxy1a0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Henrik Grimler <henrik@grimler.se>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: krzysztof.kozlowski+dt@linaro.org, broonie@kernel.org,
	robh+dt@kernel.org, conor+dt@kernel.org, alim.akhtar@samsung.com,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org, andre.draszik@linaro.org,
	peter.griffin@linaro.org, semen.protsenko@linaro.org,
	kernel-team@android.com, willmcvicker@google.com
Subject: Re: [PATCH 5/7] ARM: dts: samsung: exynos5450: specify the SPI
 fifosize
Message-ID: <Zbks+eihEIK+Jyd2@L14.lan>
References: <20240125151630.753318-1-tudor.ambarus@linaro.org>
 <20240125151630.753318-6-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240125151630.753318-6-tudor.ambarus@linaro.org>
X-Migadu-Flow: FLOW_OUT

Hi Tudor,

There is a typo in the subject of this patch, exynos 5450 instead of
5420.  Maybe that is something krzk can fix when applying.

Best regards,
Henrik Grimler

On Thu, Jan 25, 2024 at 03:16:28PM +0000, Tudor Ambarus wrote:
> Up to now the SPI alias was used as an index into an array defined in
> the SPI driver to determine the SPI FIFO size. Drop the dependency on
> the SPI alias and specify the SPI FIFO size directly into the SPI node.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---
>  arch/arm/boot/dts/samsung/exynos5420.dtsi | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/samsung/exynos5420.dtsi b/arch/arm/boot/dts/samsung/exynos5420.dtsi
> index 25ed90374679..e22692063aa9 100644
> --- a/arch/arm/boot/dts/samsung/exynos5420.dtsi
> +++ b/arch/arm/boot/dts/samsung/exynos5420.dtsi
> @@ -658,6 +658,7 @@ spi_0: spi@12d20000 {
>  			pinctrl-0 = <&spi0_bus>;
>  			clocks = <&clock CLK_SPI0>, <&clock CLK_SCLK_SPI0>;
>  			clock-names = "spi", "spi_busclk0";
> +			samsung,spi-fifosize = <256>;
>  			status = "disabled";
>  		};
>  
> @@ -674,6 +675,7 @@ spi_1: spi@12d30000 {
>  			pinctrl-0 = <&spi1_bus>;
>  			clocks = <&clock CLK_SPI1>, <&clock CLK_SCLK_SPI1>;
>  			clock-names = "spi", "spi_busclk0";
> +			samsung,spi-fifosize = <64>;
>  			status = "disabled";
>  		};
>  
> @@ -690,6 +692,7 @@ spi_2: spi@12d40000 {
>  			pinctrl-0 = <&spi2_bus>;
>  			clocks = <&clock CLK_SPI2>, <&clock CLK_SCLK_SPI2>;
>  			clock-names = "spi", "spi_busclk0";
> +			samsung,spi-fifosize = <64>;
>  			status = "disabled";
>  		};
>  
> -- 
> 2.43.0.429.g432eaa2c6b-goog
> 
> 

