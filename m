Return-Path: <linux-spi+bounces-10148-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A46DCB86AF0
	for <lists+linux-spi@lfdr.de>; Thu, 18 Sep 2025 21:32:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67A874666B7
	for <lists+linux-spi@lfdr.de>; Thu, 18 Sep 2025 19:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F1E42D8791;
	Thu, 18 Sep 2025 19:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Ih3qsp01"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F1F2D46DC
	for <linux-spi@vger.kernel.org>; Thu, 18 Sep 2025 19:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758223949; cv=none; b=X2JPgIS6qkhbLuF3+um4ar8JSmYKxtYaoIQqA523xX9RoVS+q3Rff3dS7rYVX4MlQiQhkZ1aH/O1Saj47uqJKfnfQTwwz5BUOzON3CYJYdWAZ9b/iIRjkdN7xyjBJHODPUp06hQDsMBl33lPxelLElpXDsJXqR02v0EvdgmgsEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758223949; c=relaxed/simple;
	bh=qivYkST2C7b7yAkJHzipE9NJQefbbXWWzWHSNDOD73w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i2GYDXzebflvYZFwdrfhFJBEweNSlxApWSz0HUZMZ6p2m37lWvA2JhdNM8+e/2kfPJfj44L6Geg3AoCG74GIX0yMWVDjRR3x5dtJFTFmRBy6J+xAeMOi6wrDYQ66/fHvbRmYsbsXoXZQa1BLYT51Q2pCSNwbsqMqR5bLVmIBOHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Ih3qsp01; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-3357b8aeddaso2010043fac.0
        for <linux-spi@vger.kernel.org>; Thu, 18 Sep 2025 12:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1758223945; x=1758828745; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8uC46HYcJYoz9+sBv/kVNcz3yRxRfTKz6LdiKNeN6Wo=;
        b=Ih3qsp01kdSLJ2q/2QwIxMJN0GL/kcgzGrUyckPu227ZjWJJL6W5yap9lRy34m11MB
         vGh3SJARh2b92Ugt2v4SFw9IZmd+529d+jyiTZpZeRJdPCTrBy88Meg9O0cOaww1R6Qh
         chRmJ9UYbcR/ZXARIo7Jk9E27jp4RBVgBWQz6Cmz9V/bJmYHlffS7Q2xZsMdoY/5ub0+
         kvPCv7ecBYr5MId493prXKdRR7MtW70zR3yfDi5WP+6JiVNJE1g/+8kM7BZzsfB4vSyZ
         V+OYmP/VIUhL9oznThYpmBe5OHyFZ6Ryd4pRfqhZm21ILSWP54hW++EyF0Nv5dZcAeic
         ERrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758223945; x=1758828745;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8uC46HYcJYoz9+sBv/kVNcz3yRxRfTKz6LdiKNeN6Wo=;
        b=BDZoB/JvLxLmbqyuloQl+L+k9QixH/Xj8KA8QbByH56+0KQhZP8eSTg4QJnP0EHeuK
         QG4saGQfXoPKj+q6cEeRkKBc9mz4/loJU5WXYvTmPYH+Id+/fZ0hybR2XyUI2HS9sXQw
         blxQubrLkFZHjXZRhHs8KcOEsGu7IdtckowX+NxCnTptc5r7FxWdzjXgwKrGh16b0Zt6
         zbvdeToZnUcdqYbmQARnRclZXw2XgJvMdp2dYWYGSLScG3QdrPfU24sA+nSZ/rTEeQv8
         kbcXI7BCFXaBXIO1zMw/mj+njPcEu2F00S6ALVyujdiKE0mnn/AYAIQK3iqmb0PzNVEM
         Of+A==
X-Forwarded-Encrypted: i=1; AJvYcCVGY89yoDk5NZU3/0oCvXOcV2C0NvhQaTX/Jp6GRPHR9uTe/nQQH3cNunBjzE0jdmCMLgx/2QgNttE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcbZPSoo8AhmaYCWLNc6WXUPTUN1cUNjlSte5dU7+dPSBEdPOc
	+3mNOgb1EX4Q2NDv92rnEeZiRMjfpjRuA8C0Ehgx0Xhzto+SCVVy7YkCmnjzrnvVcF/4iUrXyKY
	jnT9L+1A=
X-Gm-Gg: ASbGnctLwwtmHBiceAJDonuBrh36w9o22VqHeNyVp3AKhtJZ34y9TXWv6Vt4CaZTCkR
	3G86l/N/yex01wseMREowA2xxa+22agPVtwYobg4Y/8DKSfSqpTsoxCUOthZbeP6z9N46J94EUu
	5oizrHY1gK71hzjRSePSXgmdsNfMQEnLh6tEaJvmERZVYEFbdrWoGbs7csjQDpA51LFs6kBM+yp
	ABcqYyhpBzmwyLat9cMrtadN1wseNxap1wAwBa9fbugfrUPvHPfYNorbcf5chAL2ujVQUKwRs4P
	Nmet2XMT5oUo82/Gtsoejmi1C7GYDkQ4hZp5YxE1TRNTtPvC/tt43/rn5jUccj1xfJCw5O3rfRy
	EjGTB1e0u5NVP/rV2ZKNJ7cW3rrgnx+9EGUy+BsrIOMrI0iHctuRCYEam5yNGfaOa85sE8vdKLL
	+hgGpsVsIUbacYSViHbA==
X-Google-Smtp-Source: AGHT+IERFs5Dq//LaVtzyCCdTNAhiZ4f4o05CjfcgmjDwNiiOFdseuqJHqY+PhbFovbfmMpCoV8JxQ==
X-Received: by 2002:a05:6808:f94:b0:437:e3ab:fa02 with SMTP id 5614622812f47-43d6c24f008mr346527b6e.26.1758223944929;
        Thu, 18 Sep 2025 12:32:24 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:55b7:b662:4c5b:a28e? ([2600:8803:e7e4:1d00:55b7:b662:4c5b:a28e])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-43d5c6bcb8asm1132156b6e.8.2025.09.18.12.32.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 12:32:24 -0700 (PDT)
Message-ID: <280f7145-8800-4f50-b316-3a604150a980@baylibre.com>
Date: Thu, 18 Sep 2025 14:32:23 -0500
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/8] iio: adc: ad4030: Fix _scale value for common-mode
 channels
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jic23@kernel.org, michael.hennerich@analog.com, nuno.sa@analog.com,
 eblanc@baylibre.com, andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, corbet@lwn.net, marcelo.schmitt1@gmail.com
References: <cover.1758214628.git.marcelo.schmitt@analog.com>
 <b05f763506fdecf0d21a53dde82355418d6fb915.1758214628.git.marcelo.schmitt@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <b05f763506fdecf0d21a53dde82355418d6fb915.1758214628.git.marcelo.schmitt@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/18/25 12:37 PM, Marcelo Schmitt wrote:
> Previously, the driver always used the amount of precision bits of
> differential input channels to provide the scale to mV. Though,
> differential and common-mode voltage channels have different amount of
> precision bits and the correct number of precision bits must be considered
> to get to a proper mV scale factor for each one. Use channel specific
> number of precision bits to provide the correct scale value for each
> channel.
> 
> Fixes: de67f28abe58 ("iio: adc: ad4030: check scan_type for error")
> Fixes: 949abd1ca5a4 ("iio: adc: ad4030: add averaging support")
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
Reviewed-by: David Lechner <dlechner@baylibre.com>


