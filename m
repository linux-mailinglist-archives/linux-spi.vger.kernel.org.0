Return-Path: <linux-spi+bounces-7898-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC982AA9A51
	for <lists+linux-spi@lfdr.de>; Mon,  5 May 2025 19:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74E867A1C02
	for <lists+linux-spi@lfdr.de>; Mon,  5 May 2025 17:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E589826B0A0;
	Mon,  5 May 2025 17:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Xt3gdcLq"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FAA226A0CA
	for <linux-spi@vger.kernel.org>; Mon,  5 May 2025 17:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746465677; cv=none; b=ZU8QNM3S7hWS5cmW9+ZEJjSCzcz4T636lkhSPwkVTI1KLuQ7wvyH7wovUrbigeUT6gh8VGxnOxs6huw1h6Lj0K8EGxOELCQezN6bbWgN3DT2LjTCyoQ8Z5Csj073tit63m0gWG3kK0u0Ytd+mzNkivkGLTtz/lNCkADcbYwt8Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746465677; c=relaxed/simple;
	bh=ED0YEr0axl5zx/4gKF6UrVnXHUt5MRwQZrtasEJIvN4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fs9SRyGotop5jzj8B5hXMGLeB5N7V4XChczq8zNsx+PfT8CC3HNFyc8FAd6vFk8uQHy17qKtJZLWTdfcvXOnFsKylUMVyf9Aoj+qrCWocPrVR5raWVANCAD1qvqeJ7NEiX9RWezN5V5iFbGbbnftAj878hXXWvuYuMi2qAbWrn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Xt3gdcLq; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-2c7f876b321so1416890fac.1
        for <linux-spi@vger.kernel.org>; Mon, 05 May 2025 10:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1746465674; x=1747070474; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2/G+nBnNesW1TDGe9R775N3Td+u+vfQ6F72XRRWzOa0=;
        b=Xt3gdcLqIK0AP5dFYU2TLbBxeDa/TAnxULksakBJHQNQFLs3qzLgDwi8F+1XGo3NxX
         R0PV/p6yYWyZLddHxP5m/SA0kHOK4njge0WD981pdkho2Lx1jKGOpoL73cm+lbtj82Gm
         3Rusl09vLPBvdnkb6WzchcQoBtbMspHPINYFjoKxuP8WXqC7bPrJnT510vTYUXtrqXNv
         upgoncQerKPOWiMuZoGcpBEoEOImYdL5SVR3kLLl8hOv2VBQPhzazRnzSA6YvNo6EK88
         1ouyu0UxgmMH3ghd27VsZ+qMZJVqHgM/FnL4zhBEIpQRQmkm4tg39aouYyGNNpAdNE9q
         2KFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746465674; x=1747070474;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2/G+nBnNesW1TDGe9R775N3Td+u+vfQ6F72XRRWzOa0=;
        b=q8kZ+YJjmpX7WyFRC29Hfgvn9DN/UxgAU3OCo0dw+/13tcMPebvjxVdTYFlRKj27N0
         ZBODjBwwIFQk4ASInKUSIkVJ871fh8tuGFmfp/vpaXxby82dOecYwR6QEw4GaXQR0qCq
         kRx/F1pKFQ9yMBSjfvf3eS5zV0b/Duf62HXS28Rrc11KxTNGmZhA+Ewlsu+UCZ7+iuve
         cQd6dZpQKFQhG6OOMmyH7/TjFKwyFsy1RTktwlp4cizJLd2m/l6DlpQSVXD7zOA6fGSr
         DoPZCWv1RgEVJydMW93mwK3FF/rCsdJeICNFKv3UATFIojWCgJ51+zPGZYIyPqt1ik8o
         UExw==
X-Forwarded-Encrypted: i=1; AJvYcCVBywGeWbu1zqBv3tgMxDf3B213LEXPf5i7kKkVrGowioakqRECNrR8OhuxewgftL2+ZcYuPjfi5A8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3GWo+8uqvySLh/WOEzzcPg1pF/ckwQstBUfjss62UWa36co0/
	MLVbgDts58thHV8I0zngJiqFQPAkMKmaZz+kXVL89/NUaNkQyT7GN/y7rks3R/A=
X-Gm-Gg: ASbGncupiaH642ZHzuHT+mwHzvloPUGu+5bLksPaF28BBn4XtgW2TI3pGaLYU133sCA
	fqe9SGXEX9FtzoRY22FEyqqUorAAuadBBrrrPJEGwnDAoVIjZF9DzACCzZxA9HrtEl1PBbRgdYn
	yIxfv/b/gkfNykzY5bllY8MtnPFyaMILlRtTnT/7aAG2oR2BTGGBL1RD/cc0ScqRYjreUs1P7WC
	TYkCLD4/fNcnywNl9XwDexkwh30TsdI281AamPXhP1IuiaOkmKyrhhZM2Jsp5M62IMfJVAukHFI
	omH+wGcjK7DEFD3wtR6H7a1jCIcvNOkvpK7FGteXqWUlTWCy2/1hLTX4+IKGgM1hvSX1c9D0W64
	8ZhR/dDnR8FyZm7E=
X-Google-Smtp-Source: AGHT+IE/IoVpJPAJ8LqGJDHQZ7X4gmy2K04E7oj2S0s4rKeDTv7fvaB2eoCocspZ2xh2Gh0s5XTIOQ==
X-Received: by 2002:a05:6870:91d3:b0:2d5:cb5:2193 with SMTP id 586e51a60fabf-2db391b23b2mr162206fac.35.1746465674086;
        Mon, 05 May 2025 10:21:14 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:2151:6806:9b7:545d? ([2600:8803:e7e4:1d00:2151:6806:9b7:545d])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-731d31a23c5sm1590259a34.8.2025.05.05.10.21.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 May 2025 10:21:13 -0700 (PDT)
Message-ID: <79c256ab-3d21-481c-ab9d-eca643d3d998@baylibre.com>
Date: Mon, 5 May 2025 12:21:12 -0500
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/7] include: fpga: adi-axi-common: add new helper
 macros
To: nuno.sa@analog.com, linux-clk@vger.kernel.org,
 linux-fpga@vger.kernel.org, dmaengine@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-pwm@vger.kernel.org, linux-spi@vger.kernel.org
Cc: Stephen Boyd <sboyd@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Moritz Fischer
 <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>, Xu Yilun <yilun.xu@intel.com>,
 Tom Rix <trix@redhat.com>, Vinod Koul <vkoul@kernel.org>,
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Trevor Gamblin <tgamblin@baylibre.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Mark Brown <broonie@kernel.org>, Mike Turquette <mturquette@linaro.org>
References: <20250505-dev-axi-clkgen-limits-v4-0-3ad5124e19e1@analog.com>
 <20250505-dev-axi-clkgen-limits-v4-4-3ad5124e19e1@analog.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250505-dev-axi-clkgen-limits-v4-4-3ad5124e19e1@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/5/25 11:41 AM, Nuno Sá via B4 Relay wrote:
> From: Nuno Sá <nuno.sa@analog.com>
> 
> Add new helper macros and enums to help identifying the platform and some
> characteristics of it at runtime.
> 
> Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> ---
>  include/linux/adi-axi-common.h | 35 +++++++++++++++++++++++++++++++++++

Since this file was moved in the previous patch, should we drop "fpga:" from the
subject of this patch?

>  1 file changed, 35 insertions(+)
> 
> diff --git a/include/linux/adi-axi-common.h b/include/linux/adi-axi-common.h
> index 141ac3f251e6f256526812b9d55cd440a2a46e76..a832ef9b37473ca339a2a2ff8a4a5716d428fd29 100644
> --- a/include/linux/adi-axi-common.h
> +++ b/include/linux/adi-axi-common.h
> @@ -12,6 +12,8 @@
>  #define ADI_AXI_COMMON_H_
>  
>  #define ADI_AXI_REG_VERSION			0x0000
> +#define ADI_AXI_REG_FPGA_INFO			0x001C
> +#define ADI_AXI_REG_FPGA_VOLTAGE		0x0140

Doesn't the voltage register only apply to AXI CLKGEN and therefore would
belong in the clock driver rather than here? 0x1C seems to be the last of the
defined "common to all IP cores" address before we possibly get into
core-specific register definitions starting at 0x40.

I guess there are 1 or 2 other cores that define it at the same place, but it
still seems not-global.

>  
>  #define ADI_AXI_PCORE_VER(major, minor, patch)	\
>  	(((major) << 16) | ((minor) << 8) | (patch))
> @@ -20,4 +22,37 @@
>  #define ADI_AXI_PCORE_VER_MINOR(version)	(((version) >> 8) & 0xff)
>  #define ADI_AXI_PCORE_VER_PATCH(version)	((version) & 0xff)
>  
> +#define ADI_AXI_INFO_FPGA_TECH(info)            (((info) >> 24) & 0xff)
> +#define ADI_AXI_INFO_FPGA_FAMILY(info)          (((info) >> 16) & 0xff)
> +#define ADI_AXI_INFO_FPGA_SPEED_GRADE(info)     (((info) >> 8) & 0xff)

I guess we don't care about the DEV_PACKAGE field?

> +#define ADI_AXI_INFO_FPGA_VOLTAGE(val)          ((val) & 0xffff)

This VOLTAGE also goes applies to the first comment.


