Return-Path: <linux-spi+bounces-835-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E698583D4A8
	for <lists+linux-spi@lfdr.de>; Fri, 26 Jan 2024 09:23:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A917B23D57
	for <lists+linux-spi@lfdr.de>; Fri, 26 Jan 2024 08:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC3FC139;
	Fri, 26 Jan 2024 07:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K/LOaOpm"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A86A44C8A
	for <linux-spi@vger.kernel.org>; Fri, 26 Jan 2024 07:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706254026; cv=none; b=o7DtzM0J9OA7bHV/4DD7qTk6KYK5KhheLLzE2mL0i1f2y8Cxgq/o7Ani5yLRwO7Xo8x3wxag1CqbIEjQGdfycfcHLveqLVqd1ufsYAdDxzVlQ/I3k2YtqvYYZxU/O2jvJfbEpjs6+CPEsOrgb9Toj4enOKuL52bEuY3a26NeCbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706254026; c=relaxed/simple;
	bh=PeMyJfDpnk2i+5sA83xjMKB+MOlBBxSjJp10y9Cb9lM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Toyy/aNRvvysNpKLGoqGo3b+c836UfFdwu1GiJcMxanUwd3Uj08x8ZPe9Mm4fWQkEBA64wmquZgq3Ofo0ASrkp8GhAbGcUrAjegOli7qGm7Y0gW61uqFVzK/4MfJ/SAon8l1oGB79Z7IOTdxAlq0rRAR3pIC4TK+4v1N8vX0PR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=K/LOaOpm; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40ed2333c8fso1038045e9.0
        for <linux-spi@vger.kernel.org>; Thu, 25 Jan 2024 23:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706254022; x=1706858822; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=731Y0O4P28eUOEwYYfDx4qMG9ZVWKGkvhdRiYGuXrbY=;
        b=K/LOaOpmWCcWG9F98BD9+usBXU+a2inQh96ZbpA4ulQrIPs785dT78dyfD6tzFn1zt
         kdU4GsJPKTy9gHNAK8eQ9hdniJOq9xlfiUwxiRrZWBIE9hP/3Dq+9JV5hhhTXE7hoO1G
         IMvAo0b8NSDuo2ffJnCwB0UzY6AOjlgm7pdtB+6Im8KzaZbb7eqlu1E6t+o/ppPflMk7
         ZfCEuJVgnrEdoM4WKnXYS5DF4PB222BTM5w7yQu/JO+k+45q1hsMlXWmZdqIDih+nbdv
         9QQ/uSB2o2Zio6FuY3LlnxpBf0+rO8Bz0qVh0B1VP9W/GJTbMAjZOyxUHUPa2f4DPgBN
         eJIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706254022; x=1706858822;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=731Y0O4P28eUOEwYYfDx4qMG9ZVWKGkvhdRiYGuXrbY=;
        b=sm2Z8vpftz1jvx4sui/NRf4qjJyUwUOQaIL/820Zq/2peEiYCFzF6nQRPQmRip9l90
         8PmTTDOeEi5jDNyWUOF4zjCxqUQwNyTd2CtDv+31144SBXgzkhpOEz2u85ScuMbWLYcw
         AfxaSP8f2TokmZHZMoQ9u/dYj/M7MK4cYzf8Pb2x7tusxZb6NMSl2hWbtCDHXGyRhwau
         6tx7zohk+pjK9sQKP08V7O7L7K7Vmy+MPWPMU9YITFzyQNpQoBxX6ClJ/OckcFY9798l
         JRmAQyHI27O0yPHjdrsjF8CeC2WDYfCgqXov8+EnhTD/u13pNOQlgGLebFt+eRXAjPse
         6e2Q==
X-Gm-Message-State: AOJu0Yxb2kIuijqC6PaN+84ouJdYm46ipLZ29JJufhFIOQ4KGOUvMAWi
	shAdNIvKM7KpCcsbRnJ8iXyBnCVi7XFpSDX21HZ9CBAKMdR0yjLbQWY6hykGlRU=
X-Google-Smtp-Source: AGHT+IE+eU0ILS2SbeLlm9XVK5F1FcB1sUPlbR4/ZahYQIzIZIq5ZdqloRBzfOFei+0HE4QMbwS1MQ==
X-Received: by 2002:a05:600c:1f91:b0:40e:5ad1:5820 with SMTP id je17-20020a05600c1f9100b0040e5ad15820mr494864wmb.161.1706254022568;
        Thu, 25 Jan 2024 23:27:02 -0800 (PST)
Received: from [192.168.2.107] ([79.115.63.202])
        by smtp.gmail.com with ESMTPSA id p33-20020a05600c1da100b0040ed4deaf2bsm1861243wms.43.2024.01.25.23.27.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jan 2024 23:27:02 -0800 (PST)
Message-ID: <6a157604-16dd-43b2-90aa-466e8185ff53@linaro.org>
Date: Fri, 26 Jan 2024 07:27:00 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 21/28] spi: s3c64xx: infer fifosize from the compatible
Content-Language: en-US
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: broonie@kernel.org, andi.shyti@kernel.org, arnd@arndb.de,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 alim.akhtar@samsung.com, linux-spi@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-arch@vger.kernel.org, andre.draszik@linaro.org,
 peter.griffin@linaro.org, kernel-team@android.com, willmcvicker@google.com
References: <20240125145007.748295-1-tudor.ambarus@linaro.org>
 <20240125145007.748295-22-tudor.ambarus@linaro.org>
 <CAPLW+4mG_xVvZRrE_jfMxK2zO9GnLAPrHPdzW5bCOPpoiuCjsA@mail.gmail.com>
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <CAPLW+4mG_xVvZRrE_jfMxK2zO9GnLAPrHPdzW5bCOPpoiuCjsA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 1/25/24 22:28, Sam Protsenko wrote:
> On Thu, Jan 25, 2024 at 8:50 AM Tudor Ambarus <tudor.ambarus@linaro.org> wrote:
>> Infer the FIFO size from the compatible, where all the instances of the
>> SPI IP have the same FIFO size. This way we no longer depend on the SPI
>> alias from the device tree to select the FIFO size, thus we remove the
>> dependency of the driver on the SPI alias.
>>
>> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
>> ---
>>  drivers/spi/spi-s3c64xx.c | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
>> index 5a93ed4125b0..b86eb0a77b60 100644
>> --- a/drivers/spi/spi-s3c64xx.c
>> +++ b/drivers/spi/spi-s3c64xx.c
>> @@ -1381,7 +1381,7 @@ static const struct dev_pm_ops s3c64xx_spi_pm = {
>>  };
>>
>>  static const struct s3c64xx_spi_port_config s3c2443_spi_port_config = {
>> -       .fifo_lvl_mask  = { 0x7f },
> How will it work with already existing out-of-tree dts's, if only
> kernel image gets updated? I wonder if it's considered ok to break
> that compatibility like this.
> 

ah, good catch, Sam! I prepared everything to not break older device
trees and then I removed this :).

>> +       .fifosize       = 64,

Adding .fifosize and keeping fifo_lvl_mask will not break backward
compatibility. In s3c64xx_spi_get_fifosize() I first check if .fifosize
is set and use that, and if not set, use the .fifo_lvl_mask.


