Return-Path: <linux-spi+bounces-8092-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2ADAB3BC5
	for <lists+linux-spi@lfdr.de>; Mon, 12 May 2025 17:15:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 775DD7A9D03
	for <lists+linux-spi@lfdr.de>; Mon, 12 May 2025 15:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89F8C1E1E13;
	Mon, 12 May 2025 15:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="NPkMYGdq"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C6019ABD4
	for <linux-spi@vger.kernel.org>; Mon, 12 May 2025 15:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747062946; cv=none; b=uzrXSHpIqyWBbv1UDyuUI9Dds7pTcYDoE5lsETSUPu+eb9OcZfEhua0oBVWo+cmsyR5S8qbpCJS+54ktXeLVSLL6yWJCXswiH8QqTuvw8eUhowhGf5oGWVkNBVZzQVCyKpdfRaJrO9DsUJhO0Hwp28lLPltmf1A/nKx69GhAhi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747062946; c=relaxed/simple;
	bh=zF4PQS8RQFM30N3ao4kEuN2RsoQHNBfVK/8QGFaitO8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TjaHdJKkQvAYUnAW4l61ga9sL4lRDy8l8lnjyScPcqu/JLv6R5Xn2yZGW9znc4XvpaC5oycc6p+OgFXzEmnfkE8xADOxCI3NKL28wpmhsXyk1HKnkPh05tSma1H4fFPKFtKp8FHK0DR6OZdy/FQeDmXZ+bRRPU5vr5/RoFoYZW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=NPkMYGdq; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-30a8c9906e5so5811772a91.1
        for <linux-spi@vger.kernel.org>; Mon, 12 May 2025 08:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1747062943; x=1747667743; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d0n+Mfncf1dF7UbdvMh/Y3Vkt6ppEmOAhKQI7/Xctfs=;
        b=NPkMYGdqygEadNa9LBxCCsLaDWqp4GRfS8Ph/xx/qGxOGPd6hDtfGyacyAIcTs026J
         XJSoBBNAt5MhW+Ef40nJeLNLyYIq0IPafG8V/XqKhS7RAQUdxaQ7ZDj29uzdzT8esr4Y
         QfdsgqR63ugM64JgjPrM/r0nO3DgiRIhFkE6OcwINl9E10F2f+9iN9bN9dz2axCXfs7t
         Rgd9WAV1o/WeEORfTBRaCAMoC1DOhD+cZUcSGhwXhg5izye20HxjlROwGjLgGYOkAlCy
         C5S2GJWp/HDi0W5vvyT+FAAjmnOPikPwo+VfsbGnWY73IoV43GXQVQqNaNDRWSumS2Ff
         Bxcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747062943; x=1747667743;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d0n+Mfncf1dF7UbdvMh/Y3Vkt6ppEmOAhKQI7/Xctfs=;
        b=axqq/U9OK2WpQOYz8fg/LSRtOPQNBnPgx+0W/QRXsrfcxnvJ4tOLrKk7DOFxVsAm/z
         MtNdCOv/Z7ieikwLQuxAUPzUskAWELcfzR8Yf1nLg2/4YLTkX/gHQdsV56K8qQpRMpkr
         okciX8BGUXumT1Jv2oOgtyaGn0hU0X3cQYVjynWs+X+av9+pMDsXStL7hSmmj4q/FXpG
         yPI/HxkAGOeL64o9MbRZ8EE9yqgxtY59GCyHzOw6DpaclbAHWMH/XaBL77WaOFBMGrUZ
         EZAqgwqGbLf026113HWiuxxQeJb1crraoNyG9Km1IhS8PCDr518xviiw80x7pn30LwI0
         gmIQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1ovo1iHeXOBcQyhULJby4U5jP80iGE72FAiDOpzIj6zX1NNN0JHBVk3yQNR6TSZ2GDnZ2Q1IUxos=@vger.kernel.org
X-Gm-Message-State: AOJu0YzA/ono2BExJEDsOOOVQvaTQWxXvH7ZKqXN7ZkUDsWpk/yTdAi/
	YoafFq1FFtbUrC7LiafUA3UKEMj8fbolQeqIxPgfoVJsRVghs4KsKjqjLE5O0617QiNQLZr54eb
	S
X-Gm-Gg: ASbGncsh0nc++zSmCIYZesJxecG2OLjia4rb5hTjUE3etPvR6PFNSoS5DYfHoyqRqNX
	5oZFYR1fawZYied7x8wRIeTCnXNB1HNNO8Gvx/oumZ6m0w4JHqLCmnWGFB2JcMApRMQX+t9acz4
	SCIXz4fqHN91lsAqGMKtGCfpBGhS2npVqnDUvv8ku10lB8MPK7Z1U6FEmxt+bfENB72wNm43Q+b
	nCMJylrSKHQ6TDhDz0wOzP/JGnprLv+/B6L88U/6IEBMgXIr5245knbf+RdJlIqWekITCMI8yVd
	GiFYPTKwFSwJn9j62wRIQ0RJ9kbzMCSl37rMNJJl2qB/py94wZJKN4SJcNnOlNcdsU7juSG4Mv8
	RYwkGW/nRYmySlUnhcE4PInHL4qzc
X-Google-Smtp-Source: AGHT+IHZGDRNs+8vOMkC0p04fQzG/ssmfSh7XZKqv3ixjm0TN3TuT3LuzzKvBaCQb7HZ2b2RSV9r0w==
X-Received: by 2002:a05:6808:1582:b0:400:fa6b:dc93 with SMTP id 5614622812f47-4037fec216emr8370575b6e.39.1747062932740;
        Mon, 12 May 2025 08:15:32 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:fd2e:ffda:4c42:b314? ([2600:8803:e7e4:1d00:fd2e:ffda:4c42:b314])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-403802d369fsm1565218b6e.17.2025.05.12.08.15.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 May 2025 08:15:31 -0700 (PDT)
Message-ID: <44929bd2-4abf-4c7b-b3c0-382bd030800f@baylibre.com>
Date: Mon, 12 May 2025 10:15:29 -0500
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/7] include: linux: move adi-axi-common.h out of fpga
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
 Mark Brown <broonie@kernel.org>, Mike Turquette <mturquette@linaro.org>,
 Xu Yilun <yilun.xu@linux.intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250512-dev-axi-clkgen-limits-v5-0-a86b9a368e05@analog.com>
 <20250512-dev-axi-clkgen-limits-v5-3-a86b9a368e05@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250512-dev-axi-clkgen-limits-v5-3-a86b9a368e05@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/12/25 9:46 AM, Nuno Sá via B4 Relay wrote:
> From: Nuno Sá <nuno.sa@analog.com>
> 
> The adi-axi-common.h header has some common defines used in various ADI
> IPs. However they are not specific for any fpga manager so it's
> questionable for the header to live under include/linux/fpga. Hence
> let's just move one directory up and update all users.
> 
> Suggested-by: Xu Yilun <yilun.xu@linux.intel.com>
> Acked-by: Xu Yilun <yilun.xu@intel.com>
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com> # for IIO
> Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> ---
>  drivers/clk/clk-axi-clkgen.c              | 2 ++
>  drivers/dma/dma-axi-dmac.c                | 2 +-
>  drivers/hwmon/axi-fan-control.c           | 2 +-
>  drivers/iio/adc/adi-axi-adc.c             | 3 +--
>  drivers/iio/dac/adi-axi-dac.c             | 2 +-
>  drivers/pwm/pwm-axi-pwmgen.c              | 2 +-
>  drivers/spi/spi-axi-spi-engine.c          | 2 +-
>  include/linux/{fpga => }/adi-axi-common.h | 0
>  8 files changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/clk/clk-axi-clkgen.c b/drivers/clk/clk-axi-clkgen.c
> index 2a95f9b220234a1245024a821c50e1eb9c104ac9..31915f8f5565f2ef5d17c0b4a0c91a648005b3e6 100644
> --- a/drivers/clk/clk-axi-clkgen.c
> +++ b/drivers/clk/clk-axi-clkgen.c
> @@ -16,6 +16,8 @@
>  #include <linux/mod_devicetable.h>
>  #include <linux/err.h>
>  
> +#include <linux/adi-axi-common.h>
> +

This one is adding, not changing. Was it supposed to be in a later patch?

>  #define AXI_CLKGEN_V2_REG_RESET		0x40
>  #define AXI_CLKGEN_V2_REG_CLKSEL	0x44
>  #define AXI_CLKGEN_V2_REG_DRP_CNTRL	0x70

