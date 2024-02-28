Return-Path: <linux-spi+bounces-1568-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B133186BA16
	for <lists+linux-spi@lfdr.de>; Wed, 28 Feb 2024 22:37:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5B801C21644
	for <lists+linux-spi@lfdr.de>; Wed, 28 Feb 2024 21:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FEBE71ECE;
	Wed, 28 Feb 2024 21:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mdLfMxMq"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8349070047
	for <linux-spi@vger.kernel.org>; Wed, 28 Feb 2024 21:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709156260; cv=none; b=cIUr06s1L4+X50ENX0e4P2alt2U+l+Zjn1aAeRv3snN9EVpQ4YumU1ek/xhR72sv6QrJ7wjgzsBoQyMWrb+YzsfHDbkaaupmREpcuykq1YHBE00abdx8Foo+kHSoviq9xDosJozxuKgAYkoVU5VKku5TWBNnNbcQvUenljJk6m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709156260; c=relaxed/simple;
	bh=d8Cs4AIhxa9LtAUDzhoaGCHGHqQ8MrLQncAkWORK/Kg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VynbW/XKmzkEfpljRVVoL92Q/Q2qi9+7I5nZPz8HG738c/FGz7Krx3HdsdffcWEgkTJAa+RQdc4rr8q6fDA3YUHUCzA5tYK82Fq7h+tyLlmaq4fK4atKu9nZXzD+Kemg6d+CEcgpRnfct/tFr2lfmp9JJZ4z8y5kS3p5fjTpLzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mdLfMxMq; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1dcafff3c50so2529695ad.0
        for <linux-spi@vger.kernel.org>; Wed, 28 Feb 2024 13:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709156258; x=1709761058; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mxMa3ysfVhpuWlSkP2rUbxFtq6lVsWzk+l7tYIpoG5M=;
        b=mdLfMxMq5au2Z/pH9efFJnu2asPAYhHDd168nDdjOTLe05N48Pa+4kDmonuDnvDRbM
         1f8DRxDE8y7zLHsF9mS5qGpRVDqjaLRdoponNMrEZ9+bSTuLqPZb3juAp20eDsgMkqSZ
         F5gFDQ0UhPL88E3ew/K33a2HNBHTxvAxVI1Pk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709156258; x=1709761058;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mxMa3ysfVhpuWlSkP2rUbxFtq6lVsWzk+l7tYIpoG5M=;
        b=NmWwJ9d6o0mPq2SDdV26Xsbjht1ID0dKra/xpd4hMcv3JQioSGFFnVv3HYtQCRqtmi
         7fz5hcf6pXv3KN53Sz/U2pDy4VozZKqLIesqJWyoIscnp67y62/JkJ543b8HIdAkHwHA
         oD46y9X2l9ol/wY82OJX0JpsSf3em1w5YNVm0reWk1wNwOZq84UOrWee3Mu6fjNfudh/
         kKbAAGO/OEb6CrFp5MdoPIZrszqR3M2uJZNXKDwx/STcTbLMsZMPUPI0PMYp3HrYFv6Z
         C4cgwI+8XCdpA9kSPGkTrfs7PTmKIyoZCsHfDoI+32aXAr64QOc8UMI4mFC+I1fSKVwy
         lRfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzeK3rml0PwGXVELHYEdMUjPzG5UKTcR1w8OcRjbEW3RATcuT+ulj409rjHAgmR8WQT1+h2S5bsruKqMTtZMEHhWK6VlZvuLz/
X-Gm-Message-State: AOJu0YwGzN1r2W+QCfZu49zGpjLj9l5WjdsPxpbyxApFI9DLvIaZEv5z
	I/Fi496cX9Z5NXPTV0JEzVlUUUXwI6k5K9kqISdgMjEQD14S0tLHPApRXFlJ2w==
X-Google-Smtp-Source: AGHT+IEutCCddWBfZZf+Zq/1ILDM/Qx+dYsp5vYX2jxxagWboMTFdshkkBQuR0Dtvr+YU4cuJ4wNtA==
X-Received: by 2002:a17:902:8d8a:b0:1db:e7a7:63f4 with SMTP id v10-20020a1709028d8a00b001dbe7a763f4mr163725plo.19.1709156257805;
        Wed, 28 Feb 2024 13:37:37 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id r20-20020a170903411400b001d8f111804asm3781604pld.113.2024.02.28.13.37.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 13:37:36 -0800 (PST)
Date: Wed, 28 Feb 2024 13:37:36 -0800
From: Kees Cook <keescook@chromium.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Vinod Koul <vkoul@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Mark Brown <broonie@kernel.org>,
	linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-spi@vger.kernel.org, netdev@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v4 2/8] overflow: Add struct_size_with_data() and
 struct_data_pointer() helpers
Message-ID: <202402281334.876DC89@keescook>
References: <20240228204919.3680786-1-andriy.shevchenko@linux.intel.com>
 <20240228204919.3680786-3-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228204919.3680786-3-andriy.shevchenko@linux.intel.com>

On Wed, Feb 28, 2024 at 10:41:32PM +0200, Andy Shevchenko wrote:
> Introduce two helper macros to calculate the size of the structure
> with trailing aligned data and to retrieve the pointer to that data.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  include/linux/overflow.h | 27 ++++++++++++++++++++++++++-
>  1 file changed, 26 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/overflow.h b/include/linux/overflow.h
> index bc390f026128..b93bbf1b6aaa 100644
> --- a/include/linux/overflow.h
> +++ b/include/linux/overflow.h
> @@ -2,9 +2,10 @@
>  #ifndef __LINUX_OVERFLOW_H
>  #define __LINUX_OVERFLOW_H
>  
> +#include <linux/align.h>
>  #include <linux/compiler.h>
> -#include <linux/limits.h>
>  #include <linux/const.h>
> +#include <linux/limits.h>
>  
>  /*
>   * We need to compute the minimum and maximum values representable in a given
> @@ -337,6 +338,30 @@ static inline size_t __must_check size_sub(size_t minuend, size_t subtrahend)
>   */
>  #define array3_size(a, b, c)	size_mul(size_mul(a, b), c)
>  
> +/**
> + * struct_size_with_data() - Calculate size of structure with trailing aligned data.
> + * @p: Pointer to the structure.
> + * @a: Alignment in bytes before trailing data.
> + * @s: Data size in bytes (must not be 0).
> + *
> + * Calculates size of memory needed for structure of @p followed by an
> + * aligned data of size @s.
> + *
> + * Return: number of bytes needed or SIZE_MAX on overflow.
> + */
> +#define struct_size_with_data(p, a, s)	size_add(ALIGN(sizeof(*(p)), (a)), (s))

I don't like this -- "p" should have a trailing flexible array. (See
below.)

> +
> +/**
> + * struct_data_pointer - Calculate offset of the trailing data reserved with
> + * struct_size_with_data().
> + * @p: Pointer to the structure.
> + * @a: Alignment in bytes before trailing data.
> + *
> + * Return: offset in bytes to the trailing data reserved with
> + * struct_size_with_data().
> + */
> +#define struct_data_pointer(p, a)	PTR_ALIGN((void *)((p) + 1), (a))

I'm not super excited about propagating the "p + 1" code pattern to find
things after an allocation. This leads to the compiler either being
blind to accesses beyond an allocation, or being too conservative about
accesses beyond an object. Instead of these helpers I would much prefer
that data structures that use this code pattern be converted to using
trailing flexible arrays, at which point the compiler is in a much
better position to reason about sizes.

-- 
Kees Cook

