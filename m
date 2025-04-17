Return-Path: <linux-spi+bounces-7642-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E0F9A92195
	for <lists+linux-spi@lfdr.de>; Thu, 17 Apr 2025 17:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F36319E8453
	for <lists+linux-spi@lfdr.de>; Thu, 17 Apr 2025 15:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02C50253B7D;
	Thu, 17 Apr 2025 15:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="o43DZNAR"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C1324DFF3
	for <linux-spi@vger.kernel.org>; Thu, 17 Apr 2025 15:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744903747; cv=none; b=JZ2d9jWWwDfHhNdLAEWWw5ELNoSi0L1x+lCxwQgCh+S8gcGPv8m3Rabqd4lriW1LuKHopMiCWwNnDJbrz3sXIT+xedOP79yV3Z01RdbsuNvE3YPNKEWRtY/AaX7+yW4OlGytOoJvrPDIPPO26i6QS4uvCh15CLnb1pwU3A5UzbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744903747; c=relaxed/simple;
	bh=0gB/pwrbPQGErQqmcgc3iIvczx2VIEh9MQ+dCK6zl94=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ioqUXJcr/FNrrJB4Wmq3RlO2ULj8TzV1cRGE7wifqc4Krn+ViRNxQO7U3w4Juq8KqTJ97kRe/RQJ9yXb8Qc/izUJknUhZB0QbQIgCpdPLNOgwUYQ2RKSgZCjn1DfI2JLFoR1MDUdLKChqe1hJvHXdombRNqqQR34ohGi2hhtj24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=o43DZNAR; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-60288fd4169so431358eaf.3
        for <linux-spi@vger.kernel.org>; Thu, 17 Apr 2025 08:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1744903743; x=1745508543; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n/z01Qthe3TkovfBZc3mh75wCgUL0F0cKT48OArWJrc=;
        b=o43DZNAR1G9Iv+pWAeqOP/UnO1uUQCKq4zwMsyNjqNCmGRTNM8VpUg0tJ28PG4qyUS
         8NRSFq/pf9jEJseuWy5n7hIx8I2FC+8du1s0CXFjYpHBi6fyxoyBTN8Qeb3LvpVBJZGk
         qocLoCRpciVSjRVOD+MczVBaSRSB70c+bFiw4P2h5WYji8a7oUZ0oU9XWuxeCju8B3xd
         cKBvbA5+TiuG36pUReyrTFTHbBB76ZR2F15Un6uA7vgtbtWUjEtMf8PYZy9EoJNpJSQX
         RiXRsXo2/g/Abm5z+X4U991gXxRXSHgXn8xAyNsVcoKOGpTFen4bsfE4AOrzjT1AAReM
         eOtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744903743; x=1745508543;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n/z01Qthe3TkovfBZc3mh75wCgUL0F0cKT48OArWJrc=;
        b=tcO3ERvEUvHnB0jPwHBMlv5qJKjxsqyyMay2/5od9g+plsAR7F0ublYGlgJPzupKGR
         d6gCfs8UgPqEZ/xXAcprQL7gYnfxM1rF1Pk3XzrApjZZWg3Nm0eix3kbOG3I3MYPo3mG
         LVZEHrnoQlijfGPNX47EzKUeXV0TCv3SNAcvXRWABko5Sz+eEBeDRP56i9FYMTCj3Ksp
         KtFB5Qb9dbsMj1gnFlu6p6LX3Dr6nK3CS/KXRlcD+wZP/BDpi2uqXzRhmej9ikg1o9pG
         BaDzKkXb1Q2cqnuTxCtMn0r3YE/HTV3opVFn+vEDHAjXn0zZljnOQ/UmD24RPpk457u4
         394A==
X-Forwarded-Encrypted: i=1; AJvYcCUNF7p6ZFbZpyvZH17/ivFj3uy+EQ2RouC4+p8RnyxaHJrNLIHQmo9Gvj6TFefSvVHqvKJEUcbFibI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/KgGskzHlSG6XsNUVJABH38kzAgdyWk1Aqvh2ezEU5wv+2lkw
	96VG/CNU/Oh0n75Vm5AJcjLGR3CYfWjkN9MxIuw4e332+qfgFXVmwg8APXzJSkp0kzrYLDbIegq
	4MVg=
X-Gm-Gg: ASbGncsJWaYq2frpauSl+6cO1IjMfB/y7x0tqbZcj++vbJwiVWIdW4XvxaaLshMHql2
	GpMJu3u6bBwL6flf/kRVM4DA1DdAP9tnWP04pKa5WSchYN0owgj6WVyWRoxZtBQyK2Pam7whwIx
	C6a7WvBXa5KNBqP2loyIvNydWTrRdMTmeiKveT8j/Wg4xo1rtibWvlbyj0UHJHjau0x59CX6FzG
	lYueW5Nr/x1hluqHQsEL6xpJF2QVBAdD+Qfj5PpkI7b3vBYQ3ZD6eHkVN4YzM+mtIwnFMfpwSgJ
	6ZPt6Ynw5LNLmLQ9/woLKNZH6GonmVd32/KcozaVogGVzIGdi5gHjF9DjSDTV+EGkI/3wz1Qh7o
	iGRRob/I3Ot1EcoG6aQ==
X-Google-Smtp-Source: AGHT+IFOBWtQneAONCr2U2SOb9RBNnXfC2q7v7nNNBJo664tswwBOhWsnSsu0vdpPGeutlf06qG6Bg==
X-Received: by 2002:a05:6820:1993:b0:603:f191:a93c with SMTP id 006d021491bc7-604a9360a55mr3503816eaf.6.1744903743664;
        Thu, 17 Apr 2025 08:29:03 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:c91b:eea3:7afd:2dee? ([2600:8803:e7e4:1d00:c91b:eea3:7afd:2dee])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-604a5c66b95sm819465eaf.38.2025.04.17.08.29.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Apr 2025 08:29:03 -0700 (PDT)
Message-ID: <85e51ff2-4fe8-45a2-9993-2faf4afa9665@baylibre.com>
Date: Thu, 17 Apr 2025 10:29:02 -0500
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] spi: Introduce and use spi_bpw_to_bytes()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250417151958.490174-1-andriy.shevchenko@linux.intel.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250417151958.490174-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/17/25 10:17 AM, Andy Shevchenko wrote:
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
> In v2:
> - improved examples in the code comment and commit message (David)

With the typos fixed:

Reviewed-by: David Lechner <dlechner@baylibre.com>


