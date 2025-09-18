Return-Path: <linux-spi+bounces-10147-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3B9B86A81
	for <lists+linux-spi@lfdr.de>; Thu, 18 Sep 2025 21:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C36B37A2A7C
	for <lists+linux-spi@lfdr.de>; Thu, 18 Sep 2025 19:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DA192C08B0;
	Thu, 18 Sep 2025 19:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="zQtHLl7I"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3813284663
	for <linux-spi@vger.kernel.org>; Thu, 18 Sep 2025 19:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758223181; cv=none; b=NvGJwRdrYGkWumZZg1+8nrTbTg9Im7qE47mGjvW6xdPFFXsRPM0wGI1nF1/jbf/owyvSLRq9Cj8m/+1JjQiXrsqVAHl8l0QxEUu+iFJJXs9Zq1ak01XxAf234Pktsu68IG1ArxWqiw4v0QTq9AbMcYs/Z60sg9gdx3yOM2KcuvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758223181; c=relaxed/simple;
	bh=VAds+2wzYTdgT84lPSyZuzQ1VykRr5iVJf9THaSbedk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MAYbAV5Y0eCTT8J9Ey4bJzKJAxxVaCu/PVyUXrYw7qf2/SZ6wxUv+cwAeGhrbbsrLts8pG5fNvv6cK4o7FyViBHkXagHWJY+Puf8SuPkF598OCP43UeeaWNFdayxLy/u9NZMogWPAELrgfwprwv/KjBEBCjlHmGnQy7H54fMxrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=zQtHLl7I; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-74c7d98935eso716061a34.1
        for <linux-spi@vger.kernel.org>; Thu, 18 Sep 2025 12:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1758223179; x=1758827979; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r74pu9DjNLXnTw+Oetk6FMAjK2ne5DYjMQsYnuscUPo=;
        b=zQtHLl7Iorfc9SfkZwEg/3fvbJiHAoF7kl3AnRY47ZIFEX6ytjMBBas/bT/S+U7a4M
         1DIMbb4aC4eaWscTqm6W7FevPXiKw+9b0WVdSR9P5PNeTblxszszWONnjXOldqAOobIf
         d4hpK692wbFMJiLK9JMG+N0uqzgJwJVnZv+wjf5QDDfTqXHbr0/Nqeqh+hCNZ6V63zK5
         UMaKPv5QkbWKTyeoowY41KZWsvfcVGut+/iCoQ9EfluvhXagxqHBVkwI1hFUrd3FLdDB
         YG1Rw2PfTnBZGSNZuDy8bad/yYxe3nKyEAlEe7S3iOY2ibT+dQtds4bKBmr1ZlCFQUov
         SiQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758223179; x=1758827979;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r74pu9DjNLXnTw+Oetk6FMAjK2ne5DYjMQsYnuscUPo=;
        b=HXDcZuqM1lhh7GqJ2mDgzkSfLY/BGImUKBe5TbxwXvgohZEsxWvLyvwx3xy+URCaOa
         ErCML4riRADbufgBGrVGdXb0k4UVYB/jDpt7vELqgnxPyE/VlUEZdTuc2emBVFCfiZzY
         k+5rV5gmREDUR4SsiFyN98xEZH19/DdoXHPGuz5ldEub9HhxyAbEncSNq+ar+CjA/dZD
         PX6Ublpxh41TK16fr2bQeBJiM5RwD0AhFGIT8oHq20EEBCefc/dNTJPewNAOatgJnOYT
         PEoT0AGDmvGW4QjN/IVxDKo32ahqt5+5mrQpw40h9FdP+Gp5B1bqsOhMKX/oTnCUxp8k
         a/lg==
X-Forwarded-Encrypted: i=1; AJvYcCXbd/XXOcAQViDEzvYwd1XJC047iQZtnp0lhBNaYYJoWgqVhEi7zqhCJVkG6/QA3KiqeZQp/oDA6tQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVvdagqcCgHW3ri0byKSP/Kzi++UEpANAbPRQAbmj81TEPeJ52
	y5OzfPeFJ9sg5LZWiE6UB/MdR8rhHsc0VTFBHJhklQuM1MQ81UsMBdqEBD0bfOFtmMQ=
X-Gm-Gg: ASbGncv+8n9f5qC/K+KubOgFUSvZ5JEpdYukl9yzvuTeKRgHkgMY9/BtbyxZn3/gLKI
	ue20ADx6CFkIT7BcbqcpcmwU9VXEkwXoe7IFaM/MHCW86phcYwbceGMvqg0dzlp2Nb61kPT845d
	+Gcw75SsEPsQClvN66/Q5uzjHpH9kt5HG1pFCwmPYaCnL/rD+Cr95G22nPX6p9buGRpV3QursxP
	0Q6Zfu64d83LatDP0wxLe0lULV92RoySP371VUY68mpq/JSEhPrTWF7lF9G3MblLf0PR1Sr/92S
	PGV6Bv6A5inYy/t+70tdKUB2OBF8YY/qLE6zz42DnjegVeEEIshK6BG/5nnNhj7/laFc3kCY8rS
	OcAQQvItIPbNISJjhCW60M7xvLD+ZkC2NRmqfjFWnZQveA6tSuPwRcIoWMX9+i3ZNXCUmVXqDcP
	DwutJQNdANSN2oq3fe2w==
X-Google-Smtp-Source: AGHT+IFYizUXzzXfO+m4EDIZA0JMmJrXu4MhcrJu81pFbRnpj6sLHpXHOc03v96Ezh1XqVDz3IUWwA==
X-Received: by 2002:a05:6808:1b26:b0:43d:24a5:e9ce with SMTP id 5614622812f47-43d6c2d02e5mr324464b6e.45.1758223178893;
        Thu, 18 Sep 2025 12:19:38 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:55b7:b662:4c5b:a28e? ([2600:8803:e7e4:1d00:55b7:b662:4c5b:a28e])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-336e5a2ab2esm1751557fac.17.2025.09.18.12.19.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 12:19:38 -0700 (PDT)
Message-ID: <813ddecb-efde-4c11-be45-e894fc52f752@baylibre.com>
Date: Thu, 18 Sep 2025 14:19:37 -0500
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] spi: spi-offload-trigger-pwm: Use duty offset
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-spi@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Axel Haslam <ahaslam@baylibre.com>, broonie@kernel.org, jic23@kernel.org,
 nuno.sa@analog.com, andy@kernel.org, marcelo.schmitt1@gmail.com
References: <cover.1758206554.git.marcelo.schmitt@analog.com>
 <181f64a4e9f0d6788f325a200b24b0166cb8c346.1758206554.git.marcelo.schmitt@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <181f64a4e9f0d6788f325a200b24b0166cb8c346.1758206554.git.marcelo.schmitt@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/18/25 12:34 PM, Marcelo Schmitt wrote:
> From: Axel Haslam <ahaslam@baylibre.com>
> 
> Pass the duty offset to the waveform pwm.
> 
> Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
>  drivers/spi/spi-offload-trigger-pwm.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/spi/spi-offload-trigger-pwm.c b/drivers/spi/spi-offload-trigger-pwm.c
> index 805ed41560df..3e8c19227edb 100644
> --- a/drivers/spi/spi-offload-trigger-pwm.c
> +++ b/drivers/spi/spi-offload-trigger-pwm.c
> @@ -51,12 +51,14 @@ static int spi_offload_trigger_pwm_validate(struct spi_offload_trigger *trigger,
>  	wf.period_length_ns = DIV_ROUND_UP_ULL(NSEC_PER_SEC, periodic->frequency_hz);
>  	/* REVISIT: 50% duty-cycle for now - may add config parameter later */
>  	wf.duty_length_ns = wf.period_length_ns / 2;
> +	wf.duty_offset_ns = periodic->offset_ns;
>  
>  	ret = pwm_round_waveform_might_sleep(st->pwm, &wf);
>  	if (ret < 0)
>  		return ret;
>  
>  	periodic->frequency_hz = DIV_ROUND_UP_ULL(NSEC_PER_SEC, wf.period_length_ns);
> +	periodic->offset_ns = wf.duty_offset_ns;
>  
>  	return 0;
>  }
> @@ -77,6 +79,7 @@ static int spi_offload_trigger_pwm_enable(struct spi_offload_trigger *trigger,
>  	wf.period_length_ns = DIV_ROUND_UP_ULL(NSEC_PER_SEC, periodic->frequency_hz);
>  	/* REVISIT: 50% duty-cycle for now - may add config parameter later */
>  	wf.duty_length_ns = wf.period_length_ns / 2;
> +	wf.duty_offset_ns = periodic->offset_ns;
>  
>  	return pwm_set_waveform_might_sleep(st->pwm, &wf, false);
>  }

Does this really need to be a separate patch from the one
that adds the field?

