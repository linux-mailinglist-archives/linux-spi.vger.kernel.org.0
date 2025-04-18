Return-Path: <linux-spi+bounces-7682-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85CF1A93E6D
	for <lists+linux-spi@lfdr.de>; Fri, 18 Apr 2025 21:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB31A8E3CFF
	for <lists+linux-spi@lfdr.de>; Fri, 18 Apr 2025 19:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E1621B8F6;
	Fri, 18 Apr 2025 19:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="TKtehf4U"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF3129CE6
	for <linux-spi@vger.kernel.org>; Fri, 18 Apr 2025 19:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745005853; cv=none; b=oQx65GwFY+hUQflbbot3D795klJSy5qfzXvmA1hnsFyqdUBfaVmfABWH/Z7qx/OJpiyhWEVmgGJofYvvBHr99YEWAlxeupmGIbDEZML53TylhC16hWs06nkPnaVtrN12mbBh6XZVxzll5HsIszvVXershKZBdvLYvka8lwTz8kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745005853; c=relaxed/simple;
	bh=f7sw7TEnDrne8TDRvntMvtFZlIChH4DQ1HNONT3Zgdk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pbH7jwPhGGvH/le9FtksmwLrzEQTQ4XtSDs7VmFMEcRxmOJtV5nzgiheCYiUiJJ5IOYUgpfOgAih9DL+SQg8KZ4P4Kq0Zv/rqO12mh6nDkSFLv3gkDsEk5mPEaKAkxmhxZfTCL92OtOalnzlMYYQY0FfjPVF7j2hS0HC+9UyPxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=TKtehf4U; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-603ff8e915aso464746eaf.3
        for <linux-spi@vger.kernel.org>; Fri, 18 Apr 2025 12:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1745005850; x=1745610650; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bTbKkr1IdKn2D+jSB5rqPtoyb0dR1FyWUG/NodJYRm0=;
        b=TKtehf4Ufc3TB1R8Ufnegi7w8hVkakYmCSNi0vprU4dyId6BAvdsszOYd0dNsd2Dod
         CjDJKD6XlXk0avL0kHzNUWkuxkDfDqihfRAnEeCRvJAi2GaqCBriBPZ08V/Mspruy04C
         xuPGIUG7u43RgjL3GSYiyQUwncljOW4uz6uZWZ5ogHIqZhQ/UwK4n/3vw/xkIXMU8D6T
         bJscZGMoKdMFuqxmA5Kl4ns+EPEn/U1wEnYehq2WphmUhIEoKmc6JEL61QMYQVZ4si7o
         chcD4DgIqshQUhvsJ5MDi666ZFiD/NkWtAQua1zAkwJuQD7RhjTkUiHQ+RlppLn1JwBZ
         R23Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745005850; x=1745610650;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bTbKkr1IdKn2D+jSB5rqPtoyb0dR1FyWUG/NodJYRm0=;
        b=bKPxOcsTlNfwxa9Lyr3mLI1kBGsCXNHuGz8P/hyUZx8si7lvLhBd8+9U3W4FDZlHEe
         xsMaH5BOqRlhB0l7h78GSxXAGFheN4XsFp7mjoPjHzz9gMdh4PvG3veDgn1eacvU7WKm
         AkV/AlBMKoclbZsUSINkQMtpaZKYA9cZVb68swDMg+c/sEbS8hvC8EIxXW6oOYZ+5F0P
         kbK4bbiVUWxvnXGFoeF7yDuicTJukPoF+WZSodoJMrNIsyBTttpnopjnMZd/sIPAbiLv
         NC0PHZPh5SCmejL20Rkq7sVOwQgyG9KIogvYTrrci+ZhrJJvmCa4Ab/KBik9r29PSRUb
         sL7w==
X-Forwarded-Encrypted: i=1; AJvYcCVqv/fQw3VY7GwtW0uOW61L+7mFD3JM6drpLOIgVvYRnZ7N/W/q1akCxyeTkbk7UrVBTb7eWD66ymg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFAuL6tCsumFqk6eVSOCYZYlpopl+se+1aLWLoiDGFOihRxkzB
	5RjtVBLBwQdQqo8FiIPe8QBx7NQQ6SWa42Ki5E7oeOGslCAVDtQg2Ba81hR/7RU=
X-Gm-Gg: ASbGncuGHVpXKztBnYRyJJNdULt36Lc6+tamah4LyClPMlRjzIE+mfiMPtyo4BTj9LC
	6xcnl8+j59TDBvMAePOFN4Jkxj7/LDmhzAH5PrLgB9PkI1OpzLiEC36yFX+9npJzsAClAZRRxjx
	xaOgeRR8+wsyilVokyl+/B4MIXLA6fKdrQVZLNYfAWZIs7FPa6YQzKPKNE37YayKT2Xz/gy7bL1
	pUlezoUVRlp+/taIM98kr4KjCIrKVBFEecKEpo80Tz9YGqnsU05D03Ntj9y7UGq5fLMiMB9uenD
	OPdyXJiJ7CwusiXyRFJYHS1gfB/MV9f+rc9gkT4h1CM9XGhzrnTDfC7b17jgRuSHiy52uR6j8s1
	+RR/w+HkyiNL/DwST7w==
X-Google-Smtp-Source: AGHT+IHzioKBj2Sx8LA4jIKGjon67J1E5YqFJMAQDb0xQndcTTSuUVRlaYnzo1MU+k5/fuO7JYpRPw==
X-Received: by 2002:a05:6820:1621:b0:604:29f8:3cc with SMTP id 006d021491bc7-60600569213mr2069504eaf.8.1745005850605;
        Fri, 18 Apr 2025 12:50:50 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:dcdf:46e0:18e5:c279? ([2600:8803:e7e4:1d00:dcdf:46e0:18e5:c279])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-605ff5d8eb1sm483307eaf.7.2025.04.18.12.50.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Apr 2025 12:50:49 -0700 (PDT)
Message-ID: <bd3ebff4-591a-4ba3-81a6-28ca80f66af6@baylibre.com>
Date: Fri, 18 Apr 2025 14:50:47 -0500
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: offload: remove unnecessary check on trigger->ops
To: Andres Urian Florez <andres.emb.sys@gmail.com>, broonie@kernel.org
Cc: skhan@linuxfoundation.org, linux-spi@vger.kernel.org
References: <20250418171426.9868-1-andres.emb.sys@gmail.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250418171426.9868-1-andres.emb.sys@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/18/25 12:14 PM, Andres Urian Florez wrote:
> Considering that trigger->ops = NULL happens only when the trigger is
> being removed from the list, and at that point the operation is protected
> with the spi_offload_triggers_lock, it is possible to remove the
> !trigger->ops check because it will never be true in 
> spi_offload_trigger_get()
> 
> Signed-off-by: Andres Urian Florez <andres.emb.sys@gmail.com>
> ---

Thanks for the cleanup!

Reviewed-by: David Lechner <dlechner@baylibre.com>


