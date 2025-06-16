Return-Path: <linux-spi+bounces-8568-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D82CADABFE
	for <lists+linux-spi@lfdr.de>; Mon, 16 Jun 2025 11:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 244993ADBC9
	for <lists+linux-spi@lfdr.de>; Mon, 16 Jun 2025 09:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D60273805;
	Mon, 16 Jun 2025 09:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MFidEgOK"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4103226D4DF
	for <linux-spi@vger.kernel.org>; Mon, 16 Jun 2025 09:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750066460; cv=none; b=CoGV5MPeoPO9wkyU+rdDlIGRybH5FMqf/AFbAzcr6Bxn4F6xm2Dg3ElLCbgt/1N6NW+ljmbxPfbQ5TXTlZxA7ZEqqRQzB3K/pCk7k7cpb7teFSm740jPyepQS1nHe5n3jrFoi0ulyD37TRIpUMVZBM8S83wbvf07x6HVye/JAN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750066460; c=relaxed/simple;
	bh=yWuVND4T3UIjH81QGhsgSpvTzpQOmi6MbpEzktgkuI0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gSAXiDg9n3o9JnuNp2XdRJVRn0cKmBsbPXIk/VZ8O4jYHoIM5pw5z6f/6P62wk/5yhuFvRQgIVBtksNGNt4lsFjIo/381H9R3xadKsYBvtmi8ARjkQorsc5qW+YC4IyA7AThHJV0SEVsR1VmrLjUsJTDJlNnqDiiCXYNOZs8TyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MFidEgOK; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3a54700a46eso2809022f8f.1
        for <linux-spi@vger.kernel.org>; Mon, 16 Jun 2025 02:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750066456; x=1750671256; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t9CmXx7Jox2MTWDj8UZuRJKz6FA45h7DTh7MdX7eUyU=;
        b=MFidEgOKkpw4Z9O7KVk0KUuUoWwhFn/l6i4WUoKLxlApenc/ehCs3ENMT8hJZW/5sp
         s/6SrY22821PTS/QPYyc1teFOUQ71TodgN73+Ga+bCbHLMKY0DnJaEj2DgDVPLRvDUbY
         4pFdELkO8z7K3jArSU5t6ZvHf8Ay6W23Skp/St87bxPTEoGQNoxvoMgAbbSGt073Dp8I
         Ro6YqzOAN7+vLVc6EUqzxw4VNJBJSEJ3px9MnrhQH5ET9XMRBGwG2KbG7oQ2FUlktDUU
         C35LdAqQEiiUhe0s2LI68DBMIWZEYLE7SWgWLsATa6BfwNslDhuxQpzYmdid+r5KUK2D
         EI/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750066456; x=1750671256;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t9CmXx7Jox2MTWDj8UZuRJKz6FA45h7DTh7MdX7eUyU=;
        b=ww+iGg9rlrAoWOUj7+ZjUFkXrVY9cLvvkdWMpaObzQ2aFxoM844VDtcLrsQCeXxySd
         UmZ+YWWnU5hvqQMJ/5+bmVdSQTa/pDUWW+RsFbTV9bfjkZHKlpOC+jMZKeCHQgznu6og
         u3PY5u8FDxvLghKq82esB2hnwp33eCDIKcyfBVbCm0lqTtPiHAou1E7CPSiPJDsOK4NW
         NgIE/xCBeAlO1ZThdsWPhrcDh5dHqQYrIQ0XLyVqwIPubdxE9K36g33e1G8Q3BcCSgum
         1wTYHuKSx7j/ieU0Wr5QblIzyJ9uyGuT285PuL1eaDqgeNvhw1s9UEq97NiRT4YZzxff
         AuvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjzpOr5WU4W6O66Pdrt0XfDnQF1TnXqP4scVdRhcZPibov6mlqkwWFRph/1lSdYYmgEa73XtkB70o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7PtxlpZLGWXDqNjNu1CLCrYEKxV1l2pUS6Y/NLo7NalNFRpJB
	6gHEIKIDDrEzzOjfAq+wWzD9inzM+3OorRzjoL8K+Du53SYT1OMNkGpc7DoZjhw33KE=
X-Gm-Gg: ASbGncvkPrOv3jFlcwIDJaS50QdETTeZN12R/PE+H7aDWDVLiLniNQ1uVk/bYYMHdfO
	oozYlqxAsvshrD8q0XpbPAeOeOFYWRCJihrnKzRkeQ3UPBddoew9mZFcemkOT6QOGmiPlZOMzM4
	Vld4qphOIIauRUgEXGhQFEHw8xai7QbHqah1or2EPU5zCYVwtVsnz44JoHJEwye/h+eU7kuj3xb
	n4Wy9f6+rUkAe1vk4ksaIKhBITVlNRMP4e6Q+5rlLpXCCgGGTQes49bQkvMZOujSq0u8Y/RJdCG
	wJ4DMz6uWRoNyWV7RaWT3KBMyIbRmrTAHNhGZoFmbTIHOaeLs0McZpnZI5dkkiWn1IRTxJDWUsP
	Ytw==
X-Google-Smtp-Source: AGHT+IH2eCAan9hr2z5r64aFmnkOfZ0VQQsGBIwNUvdyfgouIqWaqapfX02p+ntb3Jt3ejJMX+pmLw==
X-Received: by 2002:a5d:5f8d:0:b0:3a5:5270:a52c with SMTP id ffacd0b85a97d-3a57189727dmr7228368f8f.0.1750066456498;
        Mon, 16 Jun 2025 02:34:16 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.136.128])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568b403b4sm10327273f8f.80.2025.06.16.02.34.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jun 2025 02:34:16 -0700 (PDT)
Message-ID: <9af5522e-02e3-4a82-a9df-20c71ebb3875@linaro.org>
Date: Mon, 16 Jun 2025 10:34:15 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: spi-fsl-dspi: Revert unintended dependency change in
 config SPI_FSL_DSPI
To: Lukas Bulwahn <lbulwahn@redhat.com>, Mark Brown <broonie@kernel.org>,
 Ciprian Marian Costea <ciprianmarian.costea@nxp.com>,
 Larisa Grigore <Larisa.Grigore@nxp.com>,
 Stoica Cosmin-Stefan <cosmin.stoica@nxp.com>, linux-spi@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 Lukas Bulwahn <lukas.bulwahn@redhat.com>
References: <20250616091955.20547-1-lukas.bulwahn@redhat.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250616091955.20547-1-lukas.bulwahn@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 16/06/2025 10:19 am, Lukas Bulwahn wrote:
> From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
> 
> Commit 9a30e332c36c ("spi: spi-fsl-dspi: Enable support for S32G
> platforms") reworks the dependencies of config SPI_FSL_DSPI, but introduces
> a typo changing the dependency to M5441x to a dependency on a non-existing
> config M54541x.
> 
> Revert the unintended change to depend on the config M5441x.
> 
> Fixes: 9a30e332c36c ("spi: spi-fsl-dspi: Enable support for S32G platforms")
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
> ---
>   drivers/spi/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index 60eb65c927b1..f2d2295a5501 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -647,7 +647,7 @@ config SPI_FSL_SPI
>   config SPI_FSL_DSPI
>   	tristate "Freescale DSPI controller"
>   	select REGMAP_MMIO
> -	depends on ARCH_MXC || ARCH_NXP || M54541x || COMPILE_TEST
> +	depends on ARCH_MXC || ARCH_NXP || M5441x || COMPILE_TEST
>   	help
>   	  This enables support for the Freescale DSPI controller in master
>   	  mode. S32, VF610, LS1021A and ColdFire platforms uses the controller.

How did that get there... Sorry for the breakage

Reviewed-by: James Clark <james.clark@linaro.org>


