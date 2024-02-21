Return-Path: <linux-spi+bounces-1457-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4464285E500
	for <lists+linux-spi@lfdr.de>; Wed, 21 Feb 2024 18:56:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFCBE1F23D49
	for <lists+linux-spi@lfdr.de>; Wed, 21 Feb 2024 17:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D316D7FBD5;
	Wed, 21 Feb 2024 17:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PpTetLSO"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CF884FCB
	for <linux-spi@vger.kernel.org>; Wed, 21 Feb 2024 17:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708538182; cv=none; b=syORV7g6Q9AKkKh7FEMv8EH9os2LeVh3R5Dg7f0tHz10VjzIWX79OF4NqpDDmUhVGKMHFLn+JNQ6Tut8dGBeChkbzz3ToF6MRceqTdbUDWWWmX4A2CpfJW2ydFdu48lmEq0JeZzfwmF+SGCS7AYVVUqbY+d8w2qUeD52QYdHNUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708538182; c=relaxed/simple;
	bh=BVFBq8MbvqfaIxtlUennLRCVo9CZPL/TUigQ6CV2aZk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q1I3qk1ES7aIL79oLjclkH5u8FV2LFLL5PITcNjsYYPH7y9cDl2QVy4DkO+94yaN/X22GwU+dE1bXxSmaMJOw90pAKce8WtClMR2dHiHYJuUzwmhVh2bhcb11D41i9xgXDXOfOFPBHVsX3Q4ft5HZvnLcZwk3d5ejAs3IsAX3pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PpTetLSO; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a3e72ec566aso120860566b.2
        for <linux-spi@vger.kernel.org>; Wed, 21 Feb 2024 09:56:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708538179; x=1709142979; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=it/RVOfJK4MjxrALV/dDH3SHkP5fEcXIOdKDJod6bwg=;
        b=PpTetLSOkvJvzbUgo7YABJIGoDL0eqEBVZ/64PwD9QaSovxw8cYNI2WSJOdR64S9Bm
         xNYCZPwkAFm2I2nN+Aw5AQ6yBUAebcB7AwypfqPg01YzfIR9+RHAkVRlZPOB/+WieTNi
         Zhdtq55BSmPvm2J3L3FzyFlFZNkZw73D4oD9kTeX/0+1gj88X2mmjxkEAughodEjJPPN
         zy95aig64qgaxsgha4wT4xwgnuu8zxmZTzVkucWYEp0H0BsZaQ2HYcJxdcnj6AHyub8Y
         6wM6W88XZWTFHF65OT2TmpITydBK7Pmpjiot3O7m9+OaOanTuo1Vy73UwzkaWvNiLYPU
         MmFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708538179; x=1709142979;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=it/RVOfJK4MjxrALV/dDH3SHkP5fEcXIOdKDJod6bwg=;
        b=uwIHB8ach0lS7UAzHep9KRLtrhdcCJuoAU3Eofrn3fULVJqEQkfWJKbWSrHstQbZOC
         2NbykaY+rKIJDJE4200WDo4iQmtfy3E26yGnNkhfHxjM1L7aoixNOV2eHKRGF5Sc+GVO
         MumGaE6BWDbYLbblP7RcR1UabaVaC937HenPCJX+hBEHfnbbVv0XFtVkB8uQK+/rItIX
         a9r5Eba17sx4pmWrSZUR8x9Ci4wJ6gJ8T0OkZe0PGPIbPo4px8936B4/1VQE13oh7dJ4
         szsV6AwVwRoY633qq6cPq3WHzpyxhU/4tOA7QBLpWkbfzsVx49wBCGdx3bl3AU95Wiho
         b83Q==
X-Forwarded-Encrypted: i=1; AJvYcCVlTyuj3PnOrHc8oPK3C2CHVJvExEUo0kMU/SELgbrdERvpXVzT3fFvSXfaQiwigQbZzaUT+Z7WXxBJR9/KKDxEBLbyYMMvO8P7
X-Gm-Message-State: AOJu0Yz984lEiDp3AD+RDBatrTEnrk6QazG+EZ3f4YmzbHhjV/Yy1r6c
	PXuzgyqdPGem5UN/SM4JssPv9gg8nPNJMQmFutfnm++EPRInR/d/DxOZAlg7yjk=
X-Google-Smtp-Source: AGHT+IGqE47uiLD78T1yQU2qNPN6dVRDsaT5Rxu1kmz28dCgLQ7tsFftgT+1AISRebYrTKMrx/S7WA==
X-Received: by 2002:a17:906:b094:b0:a3c:a4ba:7917 with SMTP id x20-20020a170906b09400b00a3ca4ba7917mr11807476ejy.0.1708538179316;
        Wed, 21 Feb 2024 09:56:19 -0800 (PST)
Received: from [192.168.2.107] ([79.115.63.202])
        by smtp.gmail.com with ESMTPSA id qo3-20020a170907874300b00a3e4efbfdacsm4234766ejc.225.2024.02.21.09.56.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Feb 2024 09:56:18 -0800 (PST)
Message-ID: <10f692ae-ac7a-4243-aadc-80712f781d39@linaro.org>
Date: Wed, 21 Feb 2024 17:56:16 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/12] spi: s3c64xx: switch exynos850 to new port
 config data
Content-Language: en-US
To: broonie@kernel.org, robh@kernel.org, andi.shyti@kernel.org,
 krzysztof.kozlowski@linaro.org, semen.protsenko@linaro.org,
 conor+dt@kernel.org
Cc: alim.akhtar@samsung.com, linux-spi@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, andre.draszik@linaro.org,
 peter.griffin@linaro.org, kernel-team@android.com, willmcvicker@google.com,
 devicetree@vger.kernel.org
References: <20240216070555.2483977-1-tudor.ambarus@linaro.org>
 <20240216070555.2483977-13-tudor.ambarus@linaro.org>
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20240216070555.2483977-13-tudor.ambarus@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


Hey, Sam,


On 2/16/24 07:05, Tudor Ambarus wrote:
> Exynos850 has the same version of USI SPI (v2.1) as GS101.

I tested GS101 and it worked, I guess exynos850 SPI shall work too as it
uses the same SPI version, v2.1. Can you run a test on your side too see
if works? If not, Mark can drop this patch I guess. Please let us know
your preference.

Cheers,
ta

> Drop the fifo_lvl_mask and rx_lvl_offset and switch to the new port
> config data.
> 
> Backward compatibility with DT is not broken because when alises are
> set:
> - the SPI core will set the bus number according to the alias ID
> - the FIFO depth is always the same size for exynos850 (64 bytes) no
>   matter the alias ID number.
> 
> Advantages of the change:
> - drop dependency on the OF alias ID.
> - FIFO depth is inferred from the compatible. Exynos850 integrates 3 SPI
>   IPs, all with 64 bytes FIFO depths.
> - use full mask for SPI_STATUS.{RX, TX}_FIFO_LVL fields. Using partial
>   masks is misleading and can hide problems of the driver logic.
> 
> Just compiled tested.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---
>  drivers/spi/spi-s3c64xx.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
> index 784786407d2e..9fcbe040cb2f 100644
> --- a/drivers/spi/spi-s3c64xx.c
> +++ b/drivers/spi/spi-s3c64xx.c
> @@ -1576,10 +1576,9 @@ static const struct s3c64xx_spi_port_config exynos5433_spi_port_config = {
>  };
>  
>  static const struct s3c64xx_spi_port_config exynos850_spi_port_config = {
> -	/* fifo_lvl_mask is deprecated. Use {rx, tx}_fifomask instead. */
> -	.fifo_lvl_mask	= { 0x7f, 0x7f, 0x7f },
> -	/* rx_lvl_offset is deprecated. Use {rx, tx}_fifomask instead. */
> -	.rx_lvl_offset	= 15,
> +	.fifo_depth	= 64,
> +	.rx_fifomask	= S3C64XX_SPI_ST_RX_FIFO_RDY_V2,
> +	.tx_fifomask	= S3C64XX_SPI_ST_TX_FIFO_RDY_V2,
>  	.tx_st_done	= 25,
>  	.clk_div	= 4,
>  	.high_speed	= true,

