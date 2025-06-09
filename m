Return-Path: <linux-spi+bounces-8395-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C34AD1F92
	for <lists+linux-spi@lfdr.de>; Mon,  9 Jun 2025 15:47:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBC25188F526
	for <lists+linux-spi@lfdr.de>; Mon,  9 Jun 2025 13:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC0F7257452;
	Mon,  9 Jun 2025 13:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="BSkAtvuD"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9E8253F35
	for <linux-spi@vger.kernel.org>; Mon,  9 Jun 2025 13:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749476782; cv=none; b=KHlnfoaNv55uET3mPW3WHONsGjqskHZ/K3P+trM9RUK+AwRPX4qBOb4PJRmRiP51X2H2tNgCKOKcKdGfnlnJh/WjnlMIkaYvVQjQBJVTVLwU8nSuK4SesaHBfcAAvL1uY68laDzPwRwv6kSmkblE6mHs5LQT/BZfyms/EdjzQUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749476782; c=relaxed/simple;
	bh=GBEKj6eJWaaE7cvFETzfPc86aZ4RP1bV4B1Miyqzsbo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fnIKvYC5VcM3f41MAB46z/o/CqN+bss43Nu9kGUqNjGdNsxEbe59ZSFvKpF6yxOfPQtarJ7olIZ4yXO1EqqaJwo9D+MhHBLeIE28xPtQ5De9pqSEd89cUNuMImNgFdgc5l19p3RCsWGTQY1+vzngFAiYoio7EVjTgNXsdBUX0UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=BSkAtvuD; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-73044329768so3359821a34.3
        for <linux-spi@vger.kernel.org>; Mon, 09 Jun 2025 06:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1749476777; x=1750081577; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ptOAEZwd5Fw/VdmARM5svKvaL7+utDTM2cSLfdqSd48=;
        b=BSkAtvuDvZSiLJogZYY8jLfnW3Va5viPmmpJvAPKYmahTqeezkMx0YhDO0Jct/zGSE
         q8Cho1W4vKiMqB8tB9/QNX4RH4hRKhlx87kbziVgGq6X2x5XQfLDqoCIhc/pA9KZ7hwj
         L0txEuukmAYcR2vYmVJmrybtE/CqYdR+XYDMVdC0hixyBjESTtRa/SLnL75I0xv3kNyj
         eCANFt/Y99D17Cm6EgmCmBdUfkPfrcqaxriMvwiZVFHdXh6qN/w4qVuvCNYozzO11Mer
         cbAVAuekSz7DM3BdERUU6YSx7OhPqMM5X1EhvmKNdE8Ju6tB4JW46rwH0Cyicro7O0oM
         9G0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749476777; x=1750081577;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ptOAEZwd5Fw/VdmARM5svKvaL7+utDTM2cSLfdqSd48=;
        b=YD4JbuidzH0dUH0Auw/XrRgzGrHQH5lE65UlTykk+6X6UkQM2gbjAKtV1D0y2ElG1Z
         z3v0fRaXecCECbH7/Mh4YZbJkME4+Fy0nT65kIwmtw2szpkeTP7NzkIBRkL/QmzIN14/
         xs3eXbadks01pwgckoNoCSQYSWzxTaRglrtep/umt+SYRLcVX8KSvvknvkkVcvhAvYzX
         0EvpqVTKHxMqE7RUVYxgcO/+PKe6fxA+FdiLLa0DbmAdCEgWMDB9IpUZ0w4Cu/iZTYWB
         ortY1GbfZB8vrmsOmEDzOutDXjYlizykDLcZhoNe+VdVXdgcso3jylS1Ikh9z1aOxrh7
         jNSw==
X-Forwarded-Encrypted: i=1; AJvYcCULhyO4GF5HkG+ptczU/uqZcK2q+R/nyRnN/ubFou32/2M+EUZr6eH7yfDI/hVrMwTGXQkRBdavFYI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7ApYOD/DlKwrvKtUCMOQj1Ev8rYre1p8XCp5L/ImkC/lFNC1N
	Wkp9nG3cQaOG7ICATKHxurdwIs1oV4ln06jLMZqlXakbfUEK4EYqPfdZH7CTtE1J68w=
X-Gm-Gg: ASbGncuDMxCbofpAAD6VZ36vi+EcjeOlSkxg1pJlrN3H8pFfGZJJmtBcEHEwB3l2fwl
	+i0jigPQRZK046ti4bo4rZjBxdixoSmlR4YI91L4mNJaHb+TOArxnaVaSAIzuNUGnv08gbRscnf
	+7bKlG/BaQDqV2wGsl75xxAekAHvv5OoRardi8Uj1Sp9NZshIMUD8snioGDg2nAxHQVWG8qWJyi
	qk/r9wUwkejLMCdWL8HjZnnQKYWFmcswur5FL5EvqANuHy8x51PDzSp4S9xsnoycvwfH7sYV2dc
	joBlaWO8t2eKz3AWieyJrrUUfrDdo0GJD0JyXqWbjZ08H4CBVYmgCO4MYVMe6EovC8oWn6xelPt
	U/ccP6bvraeGnF/R0Bxs70g/CeDEv
X-Google-Smtp-Source: AGHT+IHd/v00BXad/269Rqd/0cC9wm7vQ4on/F/C+9GFMyd6zzEEXFcWPZmMIilxMsQs+3+D+WxGQA==
X-Received: by 2002:a9d:3e16:0:b0:72b:9c34:1361 with SMTP id 46e09a7af769-73888df8abdmr8003832a34.15.1749476777408;
        Mon, 09 Jun 2025 06:46:17 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:c2e7:1c16:22c5:b461? ([2600:8803:e7e4:1d00:c2e7:1c16:22c5:b461])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73889f7ba55sm1584743a34.30.2025.06.09.06.46.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jun 2025 06:46:17 -0700 (PDT)
Message-ID: <756de913-e9c6-443b-844c-8b06eb00ab80@baylibre.com>
Date: Mon, 9 Jun 2025 08:46:16 -0500
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: offload: check offload ops existence before
 disabling the trigger
To: Andres Urian Florez <andres.emb.sys@gmail.com>, broonie@kernel.org
Cc: skhan@linuxfoundation.org, linux-spi@vger.kernel.org
References: <20250608230422.325360-1-andres.emb.sys@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250608230422.325360-1-andres.emb.sys@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/8/25 6:04 PM, Andres Urian Florez wrote:
> Add a safe guard in spi_offload_trigger to check the existence of
> offload->ops before invoking the trigger_disable callback
> 
> Signed-off-by: Andres Urian Florez <andres.emb.sys@gmail.com>
> ---
>  drivers/spi/spi-offload.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-offload.c b/drivers/spi/spi-offload.c
> index e674097bf3be..d336f4d228d5 100644
> --- a/drivers/spi/spi-offload.c
> +++ b/drivers/spi/spi-offload.c
> @@ -297,7 +297,7 @@ int spi_offload_trigger_enable(struct spi_offload *offload,
>  	if (trigger->ops->enable) {
>  		ret = trigger->ops->enable(trigger, config);
>  		if (ret) {
> -			if (offload->ops->trigger_disable)
> +			if (offload->ops && offload->ops->trigger_disable)
>  				offload->ops->trigger_disable(offload);
>  			return ret;
>  		}

It would be unusual to have an enable callback without also having
a disable callback, but to be symmetric with the same call in
spi_offload_trigger_disable(), it seems fine to add this check.

Reviewed-by: David Lechner <dlechner@baylibre.com>

