Return-Path: <linux-spi+bounces-9092-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4043EB03149
	for <lists+linux-spi@lfdr.de>; Sun, 13 Jul 2025 15:57:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B786D7A9F7B
	for <lists+linux-spi@lfdr.de>; Sun, 13 Jul 2025 13:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CBCB230BFB;
	Sun, 13 Jul 2025 13:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TBzRyGkK"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418A01D5CD4;
	Sun, 13 Jul 2025 13:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752415013; cv=none; b=i7CNF8hlPebMWvhAFHsKo9HJPsUPuGK6RaThFEB7P+FOe+WlaiHbJvIW6jjouIOG6XKahJjIyik7QyBZBUnMwDCEAJtgd0flvg3jUNq0vl/jmglxr8s93uajyMxrCzzJ+8ilO2Ve7lmsrWGGJ6orGFeHY2jgD4Y1h5wFFcIYY+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752415013; c=relaxed/simple;
	bh=sxGOlGw9f9Nn+iBohPiVSpwerfEst28au/D2TuWZkF8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=nqQCMCQL8XofXk8OZSu12eGFTcQqlnkjSa0OczajlfWQUwwxiYocbAlF2zDZTe5ZFb0bNI6SUItTL40MAtxHPX2xcI6w7wpRl+6ebXRSl3CP3jPDOMGIXi1l0LI62yiEs770eEOhUM2juDARi8OhGQFCVAEpXeeQyjoQIWYnJtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TBzRyGkK; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4560cdf235cso4764945e9.1;
        Sun, 13 Jul 2025 06:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752415010; x=1753019810; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=24+mZaP2PpT8cb+WFgxg322K5Dhdl64D2ikrx5KgFBI=;
        b=TBzRyGkK/3nUFlu54Xxn+K+yBFX/fR6wClYADYRNsC1zLaDDymU7vfMSPr+O1m/+/z
         UWdZ565f/2Urh1XXzlzl+tm8VMObMBAEaVtHEzHB/4120nJvT0annt3CZot57pRI5bIX
         8oDmBIluAgZXPgResyrJjdOoI/yXcY/9e3BxEf7rdlrBesSqY442QwJfCGUMs3EVf42A
         raRJw6mfZGtdYztrT9t9nt+o75y59iQyVhkRhrEyCSOXbTj/acnE3d4k4U3tGi4963mQ
         q097+Gfz1JkZ+JEt2B/Umen9EpydZyKErt9ddWBPlRJ78pBhQnJeRlmUDxR9fSCsKAlP
         p+xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752415010; x=1753019810;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=24+mZaP2PpT8cb+WFgxg322K5Dhdl64D2ikrx5KgFBI=;
        b=GHDxiirzINN801/poVgoQT8ep7bBEjcHMppfsx81hSIk0Y56SSaH7FZdxmvK8YmAhv
         0RKMUTFi0MASnqKW0kZTKrBu1XzxMN4mc3bd6jXvKNX6VTgvg334WrxOOvhRITONKFzg
         cmYlIP1xSN9Nj1A9x+Q+oJmY6UTwVjD3Dhc1Rf1PiXez6YOYfc0srIqtOa5jWgKdNQeE
         9H6cgVV/rPtpvaRg7vJAujIEL2VEB4kOwmUM9vniB49A8fgJrjWAiWjJuiU86UOQZRZZ
         V9PHYgtTaFWqwf8BtLnhW/qRtgJfV1Sxpy3Jh333UVyWM8lZ62Pk+ZvCtzUILI4JD1Fm
         NAfA==
X-Forwarded-Encrypted: i=1; AJvYcCV0kR8OrbSk/FwuRnqz1RQRPrRHx1zl75yGAeiSdagr+dUJCejUSZK3G9EEOFmszRa8qIrRHBS57pRn9xM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOnI3c18diy+q6/0/ak0DY0Tc4aERmA2ZShFPFS+BhRWZ1THA2
	kRBr7+cJDlOCTi2lhKOniEDlGj8QUoOw/FIDJ+QfbwyYcZ4tOF5c+3fonqdLdQ==
X-Gm-Gg: ASbGnctjmUVXrwUh304LZ1s0T8dSK+JMe91nLmwSEfyPDDXet4gjwNGF+7yKNw9EQvq
	eO3K+hWhDtNVsR5UpjPhQAnDy1OeJIp+WCMc65uY4tj1ix/0a4PRhuscCsUnzUcZGvnMfX73qQ2
	nzWdOII8JKzS8/U9vHKXOwWeg4p9Yz68JXq8rmMmxF9XT7ku176LLnWltwF3jhBOLWdob+ba1cu
	CKumtKj8v/6l7gyAwLC+MQUT2Ro4VLYyBD+1mMdd73FNXu3MXirLgH3AZkH9BfHNBCP2/+P/TRI
	n0fQNfcSir0pAFpzSimua2otqXCR/4IxtaWsEIgNZtMxxIJ+i7lCylBda4IgyI2z0+SUi8L8qud
	M9oMC57o7NxZoEhHU9CDTLN/TWW9BmkjSja2VKOJueP8EY6EHL+1gJDDEgXQYGhFjKNF7oFY8Wx
	jbBw==
X-Google-Smtp-Source: AGHT+IGT8sg6H/LbB8YFIazWpn8JHxEzcyN5rAAPSGMyeFgc23Fo8QTlMzEDK7GrPvq322Ugi945QQ==
X-Received: by 2002:a05:600c:4f07:b0:442:dc75:5625 with SMTP id 5b1f17b1804b1-454f427333dmr89408235e9.5.1752415010412;
        Sun, 13 Jul 2025 06:56:50 -0700 (PDT)
Received: from ?IPV6:2001:861:3385:e20:6384:4cf:52c5:3194? ([2001:861:3385:e20:6384:4cf:52c5:3194])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e0d571sm9991761f8f.57.2025.07.13.06.56.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Jul 2025 06:56:50 -0700 (PDT)
Message-ID: <ed9e407e-22a8-49e4-b1ec-0525265351a6@gmail.com>
Date: Sun, 13 Jul 2025 15:56:48 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: st: Switch from CONFIG_PM_SLEEP guards to
 pm_sleep_ptr()
From: =?UTF-8?Q?Rapha=C3=ABl_Gallais-Pou?= <rgallaispou@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250609-update_pm_macro-v1-1-819a53ef0eed@gmail.com>
Content-Language: en-US, fr
In-Reply-To: <20250609-update_pm_macro-v1-1-819a53ef0eed@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 09/06/2025 à 23:21, Raphael Gallais-Pou a écrit :
> Letting the compiler remove these functions when the kernel is built
> without CONFIG_PM_SLEEP support is simpler and less error prone than the
> use of #ifdef based kernel configuration guards.
>
> Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>

Hi Mark,

Gentle ping ! :)

Thanks,
Raphaël
> ---
>   drivers/spi/spi-st-ssc4.c | 14 +++++---------
>   1 file changed, 5 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/spi/spi-st-ssc4.c b/drivers/spi/spi-st-ssc4.c
> index 4cff976ab16fbdf3708ab870176a04f2628b501b..49ab4c515156fbabe0761028a5cb4770b61ca508 100644
> --- a/drivers/spi/spi-st-ssc4.c
> +++ b/drivers/spi/spi-st-ssc4.c
> @@ -378,8 +378,7 @@ static void spi_st_remove(struct platform_device *pdev)
>   	pinctrl_pm_select_sleep_state(&pdev->dev);
>   }
>   
> -#ifdef CONFIG_PM
> -static int spi_st_runtime_suspend(struct device *dev)
> +static int __maybe_unused spi_st_runtime_suspend(struct device *dev)
>   {
>   	struct spi_controller *host = dev_get_drvdata(dev);
>   	struct spi_st *spi_st = spi_controller_get_devdata(host);
> @@ -392,7 +391,7 @@ static int spi_st_runtime_suspend(struct device *dev)
>   	return 0;
>   }
>   
> -static int spi_st_runtime_resume(struct device *dev)
> +static int __maybe_unused spi_st_runtime_resume(struct device *dev)
>   {
>   	struct spi_controller *host = dev_get_drvdata(dev);
>   	struct spi_st *spi_st = spi_controller_get_devdata(host);
> @@ -403,10 +402,8 @@ static int spi_st_runtime_resume(struct device *dev)
>   
>   	return ret;
>   }
> -#endif
>   
> -#ifdef CONFIG_PM_SLEEP
> -static int spi_st_suspend(struct device *dev)
> +static int __maybe_unused spi_st_suspend(struct device *dev)
>   {
>   	struct spi_controller *host = dev_get_drvdata(dev);
>   	int ret;
> @@ -418,7 +415,7 @@ static int spi_st_suspend(struct device *dev)
>   	return pm_runtime_force_suspend(dev);
>   }
>   
> -static int spi_st_resume(struct device *dev)
> +static int __maybe_unused spi_st_resume(struct device *dev)
>   {
>   	struct spi_controller *host = dev_get_drvdata(dev);
>   	int ret;
> @@ -429,7 +426,6 @@ static int spi_st_resume(struct device *dev)
>   
>   	return pm_runtime_force_resume(dev);
>   }
> -#endif
>   
>   static const struct dev_pm_ops spi_st_pm = {
>   	SET_SYSTEM_SLEEP_PM_OPS(spi_st_suspend, spi_st_resume)
> @@ -445,7 +441,7 @@ MODULE_DEVICE_TABLE(of, stm_spi_match);
>   static struct platform_driver spi_st_driver = {
>   	.driver = {
>   		.name = "spi-st",
> -		.pm = &spi_st_pm,
> +		.pm = pm_sleep_ptr(&spi_st_pm),
>   		.of_match_table = of_match_ptr(stm_spi_match),
>   	},
>   	.probe = spi_st_probe,
>
> ---
> base-commit: 475c850a7fdd0915b856173186d5922899d65686
> change-id: 20250609-update_pm_macro-b6def2446904
>
> Best regards,


