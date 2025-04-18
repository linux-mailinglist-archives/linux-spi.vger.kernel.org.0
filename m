Return-Path: <linux-spi+bounces-7681-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C24A93E68
	for <lists+linux-spi@lfdr.de>; Fri, 18 Apr 2025 21:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 650491B65506
	for <lists+linux-spi@lfdr.de>; Fri, 18 Apr 2025 19:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8813C214A9B;
	Fri, 18 Apr 2025 19:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="x6IdAl4+"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E6DE555
	for <linux-spi@vger.kernel.org>; Fri, 18 Apr 2025 19:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745005789; cv=none; b=uG2eitn5RGk3hqz2tqL5LH45/kdV+hJt0dcqNOBToDfM4Trg+tk1C5f3P+jrE7hFs0xgiOBaT5vPENHzfuYFVgXud4ZRBN15jvDHl1BUlOJ4xJWNjf2jcxAGq4cpfUARUjyJUxpb/9w0sba/2N9ahOpY7ankdouN1NvCtIkv3gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745005789; c=relaxed/simple;
	bh=kDgFsoOub6atXwy2TQPvT18mUih7OqCqr86u0U2c7lA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KmOGDB4Fe56h4lm7xtyHXf0AXpGqRSjxooHHwSOv4iz6/T7kQ9kgtSDSYBYN0ZiVEuz49sci/f62oUpKQMvZev+N6tQ0BeRPrmJCGPP2mhqbWZXEhWRLeHvyvxE2WmOxVrNHmOTTg8DI35ezGdu7szWcu5tY8XQMqx/IdkrBbh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=x6IdAl4+; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-601f3674116so557958eaf.2
        for <linux-spi@vger.kernel.org>; Fri, 18 Apr 2025 12:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1745005786; x=1745610586; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xce+3ONZaJRfvM0oQesZUAsNH90ggOpoeygxcmvydBI=;
        b=x6IdAl4++nbGyqWmLIKGjJt0YLQRv/6RL65jLungB9pUidecu/meg4HwlTLNBsbIh+
         xnEjdAw5n4VCsvP2C8nUh+RJa3jWDhwxmdH7jVFXHKn3ewvsVh84GGLLE/xdYBJKtDGE
         DDEZhs/V/abj85GO/3BMOhUfkxKtwWExXf045GQMX1A4g4jODOhmNKd67hem4ymd1KSF
         OiIetxeAx4R9b9IUaAQoVoxCidtVKFOjhxaLXjjYpSLz/AX7Gs8jJKE9ZmlxqLUQfo92
         e/tt1GZV2kPE0X1FpJBD/sxCig8Y+NZqdqpM54YIPJIWB99jGwwNMlczBR0oi9iFpco1
         F4KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745005786; x=1745610586;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xce+3ONZaJRfvM0oQesZUAsNH90ggOpoeygxcmvydBI=;
        b=m7644FAWVNFQNwgMfyp5jfjKeLlr4q2qpeGaCFkIyjxl6IJPVIhs9Yttl84QlWzrmC
         55TM8hF1Wjt+QkWM4PVKhrvCmIxMjnRe5umd/e0MyExTwHGoXYt2xAnpg/jaeasWjREP
         qYdtYAm6EB8rwiFjri6R/pOC+2pJ+VcmibbYmi7L7LCqnkcEd/dvos+nRb12eEMkAqYs
         mQ8SauBuRDAX0Aqzv94Lvh60uE7jOCM8j8dIq/YqqaF1rPqEiJuDzS4C4GhjQVgISwYd
         H1S3UbJTsyka8D/R89DlKy3FUfq3WfNgxHv4qkRI/f8v2/Bdu0zyJuM4EfR3m9n+Cx+V
         S3pA==
X-Forwarded-Encrypted: i=1; AJvYcCXkcLL5V/+aE98sC7QJhNn5d0KUSXSg3RmVBMOWmAbp4fHmwoIFNenCaK3uJGA4+/4kzVs5etry6nQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvS+0BvkAJ5OdWL6DReMx1FIlTCtNMnzWVNn6veJV9OzC9y3ev
	CnG+3BQblySLHGjQ4j0gov+4rc17dB8VIMWwjAKQMQ97zdq5xQkSnim/Bq0Qepg=
X-Gm-Gg: ASbGncudImvM4VfGj5LxxxgXp98shI8OyCIpgiDPbD7aXqoN//FsHupLLlE3OYeGr65
	n4cDsmCIMpRJa/s2++ygxsTt+dXieIm3ZWcyptAPOXx7DqBlDA8b0hTHQi6/6fLi7d6R/IdOagP
	uFrmu2YEp0koAFRr7GN3ICYDucGxVXv42W/TePoHPeGZ5bBHMd7K9/OldRhlgL5wiPg3/FE2q+P
	kUT4qioD9xiCEUspQmUq+i0EsUSBzuHglkwfLf7r3sFFkc+hjKFfeVuephx0V9ZTXD7lzmYqnSo
	cljp/IGQFIhTHaSplZ7dJngZyLQIh+RYlg+tYoVIYgHnfy4/C2IsUBIeQJq4Xf4ldcIzFHuwbbo
	rd1n27JiDpk3pFXvpMw==
X-Google-Smtp-Source: AGHT+IHkBE9x6K9CHVSmFNoUkttf7GGTIF4uFL71j4x2QN004+HgOqWE2ll6r49eUh31GcTibNVu8w==
X-Received: by 2002:a4a:ee8a:0:b0:603:ffc3:60f4 with SMTP id 006d021491bc7-606004dfe51mr1946737eaf.1.1745005785774;
        Fri, 18 Apr 2025 12:49:45 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:dcdf:46e0:18e5:c279? ([2600:8803:e7e4:1d00:dcdf:46e0:18e5:c279])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-605ff5fcd65sm491650eaf.23.2025.04.18.12.49.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Apr 2025 12:49:44 -0700 (PDT)
Message-ID: <e0fab22d-c929-4111-9f4c-fbf4fd525c58@baylibre.com>
Date: Fri, 18 Apr 2025 14:49:42 -0500
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: offload: check for match callback when a trigger is
 being registered
To: Andres Urian Florez <andres.emb.sys@gmail.com>, broonie@kernel.org
Cc: skhan@linuxfoundation.org, linux-spi@vger.kernel.org
References: <20250418175542.13820-1-andres.emb.sys@gmail.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250418175542.13820-1-andres.emb.sys@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/18/25 12:55 PM, Andres Urian Florez wrote:
> Make match a required callback when a new trigger is being registered,
> this allows that other functions like spi_offload_trigger_get() could
> safelly invoke the callback when it is required

s/safelly/safely/

> 
> Signed-off-by: Andres Urian Florez <andres.emb.sys@gmail.com>
> ---
>  drivers/spi/spi-offload.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-offload.c b/drivers/spi/spi-offload.c
> index 6bad042fe437..6f4c5188e6ad 100644
> --- a/drivers/spi/spi-offload.c
> +++ b/drivers/spi/spi-offload.c
> @@ -434,7 +434,7 @@ int devm_spi_offload_trigger_register(struct device *dev,
>  {
>  	struct spi_offload_trigger *trigger;
>  
> -	if (!info->fwnode || !info->ops)
> +	if (!info->fwnode || !(info->ops && info->ops->match))

IMHO, this would be easier to read and understand as:

	if (!info->fwnode || !info->ops || !info->ops->match)

>  		return -EINVAL;
>  
>  	trigger = kzalloc(sizeof(*trigger), GFP_KERNEL);


