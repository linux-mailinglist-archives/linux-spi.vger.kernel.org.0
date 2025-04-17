Return-Path: <linux-spi+bounces-7643-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A36A0A9219F
	for <lists+linux-spi@lfdr.de>; Thu, 17 Apr 2025 17:30:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 487281B601A1
	for <lists+linux-spi@lfdr.de>; Thu, 17 Apr 2025 15:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EEF6253B43;
	Thu, 17 Apr 2025 15:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ozlSgqsR"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E12024E003
	for <linux-spi@vger.kernel.org>; Thu, 17 Apr 2025 15:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744903850; cv=none; b=fe7DlJuRa3fqmfawsoxeI/dyYf/Jw/f8VFnb0xkWrBJUgAuY1wupG29Z0bcK3+uOmDkIHIu83MJv6L6d4Segz99GI0HFkW34s7gN7+cZiHKqAYH4GUp8oI+WxWbgToG9iZl3z+OUFCKKebMLngETpQQBiwoo3H6283u6FuEQfvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744903850; c=relaxed/simple;
	bh=1/T6eTWyjdWP8JXLFox7jHloAnTqxA+En1HzeLc8tMc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jKXOGM3cIV+sxL+IrdN8nsgM4CPyGYxeuwnBxQm2IKQBNEpJlzVDZRuzn/G9E2ypphT+U+fLKzx9yfQBuVzjLkMAiVETf4f/oDsT5QThKy6Ioi6JAoaxzhdc9ApiceF/h5MMkbp/bMgzQ2Np8FXRU7lEr566S7hNX9PvhzRNghI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ozlSgqsR; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3f6dccdcadaso561970b6e.2
        for <linux-spi@vger.kernel.org>; Thu, 17 Apr 2025 08:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1744903847; x=1745508647; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XOeGPuCuer24nPs3jiXqTFKRA2f4CnIaphU/0fLPogg=;
        b=ozlSgqsRIAI8kucwGHF1c0gSxmM++NWPIlGor3E+KpGDKrULaH6dmu+soYKX2gvhXx
         v52T74HyF7n0U4TmRj9DPVV+aHZkw3WuVVlZGhKApKad10eZRsFP+Jty5kp/2RbsXhdl
         L1WRewnVypSIqrCqMaUNWEKXqqSmOjU2D8bH/KJVgHa4U0l3bCiQgxJTch6s93NqY/FF
         fVuUYkE44vTcEwlX8TQ6v5LwZOg8s/uLS31WOgEcKZqCyzvRWXh7/g/EGbvJ5jKOZW1e
         A8IstxVW3mYKBqC+trsmkrzzQBm/wuFvwu2CO0BDaF872O9EYKGhdAn0oxX72P07Lf82
         TyWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744903847; x=1745508647;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XOeGPuCuer24nPs3jiXqTFKRA2f4CnIaphU/0fLPogg=;
        b=rdRjb2m/v3zQFaC2QKf4zVJJ+ZTd9ZU+x4Du9vfITvxzWZ581IW2F0nKl2jrq5Zmwu
         KtmHXxbJIKe7JAB7XjQN6lLIdL/GAF+fTR+eBRIp/QwT0IFpDinVADttZHFmwUKeofbs
         j04W4zNAYfTVS+ZUyngd1Zf9Df4Zhd1fgA7/Ihq36dMflH3hUTr4i0cqlmRq+taDnkOa
         fTE46xgGXkTuhT6dNTg+weN01aB/m69F8/WuMZowoUjkr4xej9rbLRJ1uIRHEIw1X579
         MPPfH4mi/ZOh/nwmLuUvfjaF7im0mrOIs6fi5+xr2jQ8cCwpDXAIqhsPgoKoZb1u6faZ
         NVww==
X-Forwarded-Encrypted: i=1; AJvYcCWbSsDn60bnboeE6UpWddMfIiELQolA5PbVAFcjnFji8LCq9MluJlgwOqLjbXKK8gI7DjShgA7w2HU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqlXTUIAXOdGNp5EOSUllXNef9GnWqdmwaErc7YPNZau/j24HM
	WVBzJL1522rNcuD/oF3GVGlczUssZ6+Am0Q5OxQ48Lixvl6Hd1EN1mPaovHU1ZqqVdBdGuHqULg
	DwcE=
X-Gm-Gg: ASbGncutaddixaCYN8cs5eC+F108DK/rHQBlurMlPdfnc46OjEa5hXs0ThLj8eVXi3M
	9cDz7i71jqoekeY6gG8PWe0GpzuRzx7zUH2eQMZCYhoAEzwpWwGCJCtVuHJMOaMIyfN+wc+pjqo
	G6+MEOLRAI3Dlai1yCaf0QXhkaycde+k5GGSIf2A9x1StYvCo5CMbcLCjZccCfA5TVU8uUKNz5w
	YM14jlhIIMQFY0YP+uhkmgyat5IjtWkrAbo17wZQWsqXDPiWGzleV4ni259YNNRlU41MhuAKIG/
	ZxcRI53+XYtJGGoyBJwBD9tp4fiKDcnBUgv6uYz1yBqV7B7zLZbqYV6Q+nlyfUGG+FghP1qMr9E
	gov5zMTxbK34NichXZQ==
X-Google-Smtp-Source: AGHT+IGAfa1PX8vDkTnj8WdCvrzF5q7nd7OzjW4lFji9+sTfZfkL3x0sCXY/RLK+4LCF+9aRtpGwLQ==
X-Received: by 2002:a05:6808:23c2:b0:3f7:e553:56c6 with SMTP id 5614622812f47-400b0242959mr3658195b6e.37.1744903847383;
        Thu, 17 Apr 2025 08:30:47 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:c91b:eea3:7afd:2dee? ([2600:8803:e7e4:1d00:c91b:eea3:7afd:2dee])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4007639de56sm3244201b6e.34.2025.04.17.08.30.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Apr 2025 08:30:46 -0700 (PDT)
Message-ID: <1e22baf9-303e-4e49-9e9a-0daa3cd4caec@baylibre.com>
Date: Thu, 17 Apr 2025 10:30:46 -0500
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] spi: Introduce and use spi_bpw_to_bytes()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250417152529.490582-1-andriy.shevchenko@linux.intel.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250417152529.490582-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/17/25 10:24 AM, Andy Shevchenko wrote:
> Recently in the discussion with David the idea of having
> a common helper popped up. The helper converts the given
> bits per word to bytes. The result will always be power-of-two
> (e.g. for 37 bits it returns 8 bytes) or 0 for 0 input.
> More details are in the respective code comment.
> 
> This mini-series introduces it and replaces current users
> under drivers/spi and we expect more (and possibly some
> lurking in other subsystems).
> 
> Mark, if you okay with the idea, please, make this to be
> an immutable branch or tag for others to pull.
> 
> In v3:
> - fixed the typos in the examples
> 
> In v2:
> - improved examples in the code comment and commit message (David)
> 

Reviewed-by: David Lechner <dlechner@baylibre.com>


