Return-Path: <linux-spi+bounces-7676-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AFD4A93891
	for <lists+linux-spi@lfdr.de>; Fri, 18 Apr 2025 16:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FBDB1765BF
	for <lists+linux-spi@lfdr.de>; Fri, 18 Apr 2025 14:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF8D148316;
	Fri, 18 Apr 2025 14:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="nrsmk/M0"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9E1156237
	for <linux-spi@vger.kernel.org>; Fri, 18 Apr 2025 14:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744986019; cv=none; b=u+BCGqylBwhUhimxSWY7f4B3mQpjNUjv7NITyRd+xfqZraJrukTgZeDKWNy5bfs7Meznd0aG8nf5TyHIRKTosfwCaAuqoxn0WOulYoUGjKW/hjBMilruMAUEhLjbbJ4gZknBCI7tfnowaMmMCUROQB3N+/GIeNyiNcntdHjnd6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744986019; c=relaxed/simple;
	bh=Vzmgb2YVSAC09WUYdKxYwuz1OWECRrGPzIaX9sFbqSw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QRCrcVZQo5OwkPyMlK8hAypzZcNSSGqw01ikBx3ojw/b8r3dIh1gbiAVkf4ImsQfgltL0TwBXw2ps95ZOCFO3RlN32bKJdbiepJfXi3AZPmMKboyDkQMKJF7QQKR0Xvatnh2lvBX1PfVccg6H+EYf/He96xPYDRfOlFmkXYz/oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=nrsmk/M0; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-601c469cce3so433603eaf.2
        for <linux-spi@vger.kernel.org>; Fri, 18 Apr 2025 07:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1744986015; x=1745590815; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H1eba4P1qVaLqn42Ksru3y0UuXsYFhqPkLqomasx6Gs=;
        b=nrsmk/M0hU8jrLs5E3dY0P2di2JaCUXnS0cG6p3vJwD4/fnKQOkvL3NAgABzwTbQb8
         Oluvrg4oZ5NYHanBOMy3YeBFnz1dpMF4loEUPEFY5emLFk/M26Kf5c3OBhX9zcHlVoP8
         uF8NHuCTHIALTX4Kx8GKsC8CtpZUKRIcV2JXw1NZyRncpNAUrclzr5TOk3gS5ExDknC3
         SriUseYe07DN9L+i111grjS3OLgnkBmBXj8k/z1FTlfinNNjLXZgXlPc3Wtj2v5IwJyK
         bAR1AD47JA6Rb0DCeAiSjBoXJN+o82p6HJK05pJeQwpMuKpg+y5z7mqYdmfnn13uTUaj
         0j2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744986015; x=1745590815;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H1eba4P1qVaLqn42Ksru3y0UuXsYFhqPkLqomasx6Gs=;
        b=SQm2tjLdQYOJ3GGsdKVr8kEVkDsZQMDWhd3EutNMBi7S8DVmZV7gWcM2ohZsibcB/4
         mNcPpiaeG8amLt9GPdSNlyBEQd+2PsA/ic8tcyCxy7Sxkty4F9OrNazkYwFs88DC7Syu
         reBlIObPGsH+4MbdhVtfRk0WUYhpwebU0nYtdONz9WNvkl1MTBUVK63mzypxZvUGQ0HN
         tFGU7ysTIvyw1duktPIJS5h3fuqcbWpOQXT9XJaE654JdQPJ5SyfjBcFnMUDt8+7d8dH
         TTV8IKY7QzfsAPshXrsQY+0RBihyMyIVamnTmBpOKYOyEJa0Zqd4CgghzMCT0HbQe/NG
         e3IA==
X-Forwarded-Encrypted: i=1; AJvYcCXOf09l6mjmVmvJSCRf/LTcv494LG5TC7L+7NBECbOiJoXTpNuWlYBHIbX0BDwZ+ezT8nBlzREImBY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMA99TN3LzxipYjG07ciaf9sTA2bpaZ72zk0fGZKe8VacaCH6y
	oi+wbF3EGN5hswkdggutfqmRPePrCznHo4FL8yeJw1RMBCk8itpBP27ZPs0E1/c=
X-Gm-Gg: ASbGncuQPk7yXwDYcvlnaALenXEbQfOC6LjXDIZSdj1Gp9gXIVVuPhXTn4S3VsrAwwf
	HyfACoO5h02McRZ+K3WRXSlKSU87HQgFSQ7p1xXnQnWSsSptTn9GG88sbjU96b82Tu3mGZuZw6W
	BOekNfEw2aQlP1FFnEy4rUbIcTU84+jJ1l8JrSSs0zLyssLcULPP1ESRy0TONVnmBd+KctblT/5
	nSARjl1JL3UaLsZqOsbGoNvvcP3I3swKEMmcE8myl+1xihhLbRXfa+PnbAdi2WvaGEX3XJ73zBD
	c7/BZXRTeOzMCoT7sp7slLcpTQ7xZebajlIpTWG7lPbbvszQDmUs3sfU15peO2lKKv8BP8Suhbq
	1f0YRbkt+G9f6ciKD0Q==
X-Google-Smtp-Source: AGHT+IGZNYOSy4+ZxjGRZbyK6GcilX43zc3tXRiFObJ2vk5IWBB5E1kA60wbllmKw1SCTFCJfNM7aA==
X-Received: by 2002:a05:6820:2224:b0:5fe:9edb:eafe with SMTP id 006d021491bc7-606005cb343mr1439651eaf.5.1744986015309;
        Fri, 18 Apr 2025 07:20:15 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:dcdf:46e0:18e5:c279? ([2600:8803:e7e4:1d00:dcdf:46e0:18e5:c279])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-605ff5fd242sm387307eaf.21.2025.04.18.07.20.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Apr 2025 07:20:13 -0700 (PDT)
Message-ID: <6d6b5ea4-0f08-4618-9fe2-d681cd2f51ea@baylibre.com>
Date: Fri, 18 Apr 2025 09:20:12 -0500
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: offload: check ops and match pointers before use
To: Andres Urian Florez <andres.emb.sys@gmail.com>, broonie@kernel.org
Cc: skhan@linuxfoundation.org, linux-spi@vger.kernel.org
References: <20250417232319.384094-1-andres.emb.sys@gmail.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250417232319.384094-1-andres.emb.sys@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/17/25 6:23 PM, Andres Urian Florez wrote:
> Before checking if one of the triggers matches, check if 'ops' and 'match'
> exist

Can you please explain in more detail why this change is needed? For example,
show the code path where we could actually have null pointer de-reference here
that would be fixed by this change.

> 
> Signed-off-by: Andres Urian Florez <andres.emb.sys@gmail.com>
> ---
>  drivers/spi/spi-offload.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-offload.c b/drivers/spi/spi-offload.c
> index 6bad042fe437..fcb226887488 100644
> --- a/drivers/spi/spi-offload.c
> +++ b/drivers/spi/spi-offload.c
> @@ -173,7 +173,9 @@ static struct spi_offload_trigger
>  		if (trigger->fwnode != args->fwnode)
>  			continue;
>  
> -		match = trigger->ops->match(trigger, type, args->args, args->nargs);
> +		if (trigger->ops && trigger->ops->match)

The check for trigger->ops != NULL here should not be necessary. The only place
where trigger->ops = NULL is when the trigger is removed from the list and that
operation is done with the spi_offload_triggers_lock held. The same lock is also
currently held here, so it should not be possible for ops to be set to NULL here.

In fact, there is this later in the same function:

	if (!trigger->ops)
		return ERR_PTR(-ENODEV);

that could be removed (since we have shown that the condition can never be true).


> +			match = trigger->ops->match(trigger, type, args->args, args->nargs);
> +
>  		if (match)
>  			break;
>  	}

If trigger->ops->match == NULL then the trigger could never be used because it
would never be matched. So instead, I think it would be better to check for
that in devm_spi_offload_trigger_register() and fail registration if it is
missing. In other words, make match a required callback.

