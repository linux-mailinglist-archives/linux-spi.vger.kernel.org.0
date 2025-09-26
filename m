Return-Path: <linux-spi+bounces-10304-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE449BA50C0
	for <lists+linux-spi@lfdr.de>; Fri, 26 Sep 2025 22:11:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FCD82A8271
	for <lists+linux-spi@lfdr.de>; Fri, 26 Sep 2025 20:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 195AB2848AD;
	Fri, 26 Sep 2025 20:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="NIR2hyag"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DEA0284883
	for <linux-spi@vger.kernel.org>; Fri, 26 Sep 2025 20:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758917463; cv=none; b=HBRM+oKXDHdsdQZPP9wE5ULuP0uZHWNwiNb6az5wK+J1M75n9AkceLwrOcIr8IDkzwg/pCxzfqzB0V8Q8ZM+NcfFXk55eB0rbVBKlmKn1To+ptLIjGeBGPTH/gAAl/R01BjYH7kKA6EJ6EZD8zUyks+9X15gUe+c7I+ZAQsfdDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758917463; c=relaxed/simple;
	bh=1yQrANvKpY0ljywMGibLEmI7xpn2zjzMdiYcXzsnAYY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WIOX0e4mcG4yiZTc9GqopmEojzrtvCCf7V8s75M7eGNvk706SSjC880hPhlXIOmcOWB9+Wmc6lXjajU0E9m5aLSsEWa1Mw7mVFVHEJnLFMplYeC1KV8mfColSSJPlw18SSZ/gxeKQ3iC3lC5Tel+P3MfwvX6PVQHimOcwWsYR6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=NIR2hyag; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-3627a1979a0so2184594fac.1
        for <linux-spi@vger.kernel.org>; Fri, 26 Sep 2025 13:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1758917459; x=1759522259; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V+S0IT5rLN8S3zlzSf3mYl4iNyco/hSRX1g8S5jZJwo=;
        b=NIR2hyag1RqA8AF1uJamKoGp6Qxa1F7sW0kbnJez0PCJEj/dZiKozZ/eFP9Pvw0RLB
         /MQNX0kstKLVKRGLl7SDv0r6PrRpHouo1i+Fsoegz16Wh3S+KbawDZPSGzHrGYNqJA8N
         SdwMFlF+9Z8id2DXI/fjTK/M3gNJbTWKFhRbAUupFOKkjzCFPsjYUglUespA5MwW90Q9
         u/Z8bY/hDh4oW2fuNqwH5pZt1gf0HYP4amzfBs2ZOJMAxlJUArFDw9ihqt1N2PmezpP6
         vQk71EqtYYzmCVcGsmPw+cBWZTnUNbYYBKJ/+ABsfu/UGCwyRxFdtjLvYz5TAae1SfmB
         vV1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758917459; x=1759522259;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V+S0IT5rLN8S3zlzSf3mYl4iNyco/hSRX1g8S5jZJwo=;
        b=MKLO8v4ou2SmnyDxI7aSOG/H+FsdbkpcrQXzelNe4Zf3zvXpuSNR07X1UcxK7atDVI
         lptXfsIV4+mbsuAes7/Dotd/A0Ncd2BYcxxziymnXusXGcJMym0GZx4qBzHQnCMWxPth
         B0EBLX8GcXGjd5XgUUnpP5lLHXhp45ZU7IPyCQdjA6meqExPw+J7l6OF97OdZl/flsfO
         suncDElY3hfCzyWwq1H4c4XWAruuidbkEbb2STdKSkP7ZpxXesXyUY/MeYvimOd34Ihr
         pflpWgHooaBhzTrXNvDocn4F2+5JOkYJn1s4rGctPuF9Z85PCRjb9dZynPWpmDe62xD1
         pGPg==
X-Forwarded-Encrypted: i=1; AJvYcCUSp83eiBQ3X73wIw9Z/P3TQtT75NUUGnYpedxVIhmAHZrRu98vg+HDe61dOxJIruqPBlkdOCPUfVk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+xJfbgC0aVOGUPUFF6Pk3YIOyCXW5zsnsx/cTsvVdnBWX4MpU
	0rIQ7YRN74+9cizsbJCXcxO5ecfvgIa+EyEUXzuOVqcyMs4s0f2fhnlnDde80z40q3E=
X-Gm-Gg: ASbGnctezUEMmH6xX6yB6arsLqfYxNNy09I2Lz6N43OYGKyzAKRhVjVs81hqg0Hcs8M
	m7ovIgrzQHa8UFZoCSoZTMYAWWoutrNuLB049lyC4FzWl20UeCR3rkjvA7d2bTBfhtpt1Mlkoa6
	+XkYXEk2K5XW+Hgj0t4VmLsGVQspNGJAHMaXBk80MQ7Ulb3GaIyz1n70jnTIbkgAGGxEQW37h0p
	vk3Z2RDuPF3D09nYjQ3xRTraiDD7DrnLYouTjj5EpsNGL7LBWM6dtHHJ2RgIEUahD3O2Fy4l6mb
	GYB4WUM0ybNGtLqnbLBMO/S3WupRT2yi9MeTnxq8VpYmkjuDkMfkhpJbPKNAEN+8j/sTZlhI1Y2
	7Y8nKf3Wo26ZDgOmzZ5bkD0/u0tL39lpl1uKsqxfUJ7MzaXs8Xv7X3yieNB69qhenaqTcnqPFA5
	xPyWyq3rU=
X-Google-Smtp-Source: AGHT+IFcyHFcbzgQMQ366fdi1lF7AzQiOaOUKjLiAJa9T6IxReaoQRfsmCjDR6l7iAESo+0k6Yda1A==
X-Received: by 2002:a05:6870:6586:b0:30b:7d90:1061 with SMTP id 586e51a60fabf-35ebed296c1mr5766812fac.4.1758917459275;
        Fri, 26 Sep 2025 13:10:59 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:7871:889:3150:8454? ([2600:8803:e7e4:1d00:7871:889:3150:8454])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-363a3f3610bsm1640539fac.14.2025.09.26.13.10.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Sep 2025 13:10:58 -0700 (PDT)
Message-ID: <c8c6390d-825f-48bb-9aba-7d91ecf1e3ee@baylibre.com>
Date: Fri, 26 Sep 2025 15:10:57 -0500
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] spi: offload: Add offset parameter
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-spi@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Axel Haslam <ahaslam@baylibre.com>, broonie@kernel.org, jic23@kernel.org,
 nuno.sa@analog.com, andy@kernel.org, marcelo.schmitt1@gmail.com
References: <cover.1758913065.git.marcelo.schmitt@analog.com>
 <d73804d605d494c6420adb7c0b67f6707628832d.1758913065.git.marcelo.schmitt@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <d73804d605d494c6420adb7c0b67f6707628832d.1758913065.git.marcelo.schmitt@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/26/25 2:01 PM, Marcelo Schmitt wrote:
> From: Axel Haslam <ahaslam@baylibre.com>
> 
> Add an offset parameter that can be passed in the periodic trigger.
> This is useful for example when ADC drivers implement a separate periodic
> signal to trigger conversion and need offload to read the result with
> some delay. While at it, add some documentation to offload periodic trigger
> parameters.
> 
> Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
Reviewed-by: David Lechner <dlechner@baylibre.com>


