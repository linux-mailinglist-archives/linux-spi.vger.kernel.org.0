Return-Path: <linux-spi+bounces-8766-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7C7AE7EF2
	for <lists+linux-spi@lfdr.de>; Wed, 25 Jun 2025 12:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D5EA1716AC
	for <lists+linux-spi@lfdr.de>; Wed, 25 Jun 2025 10:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4BF27F170;
	Wed, 25 Jun 2025 10:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NfvJVGp3"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB6927FD74
	for <linux-spi@vger.kernel.org>; Wed, 25 Jun 2025 10:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750846763; cv=none; b=bILaw5BfCPOG19o0cmHrABZBF9O8gXYobSTOxWcgbkUv9ED4a6sr3gfnCuIpTONDEhvdPU5nZ9AxBACNOm0VAdJNmiZWWW8O0pIxW5/D0s/cb/SJRazKH/7khZ/mnaHGzTiAmri2YHxtrNb7EM/vpHmwhgoR7mlzefaBDhNCo8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750846763; c=relaxed/simple;
	bh=rETTiKlx9Yq3+PDQAIMBB+ZMyTfACLEpmK3go+sZBpU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Weexz+UaP6m3JNvpnrD0bkgTn3uAg5fhp+ISHJ/yOTB3HHhJbqu7RavAqAa4Ef3mlEwFTxFiYJVLvjUN5nA6lzXb1I6XyHe0d5gNP2DhZVGj3ChCGsdWBYuAUwW9HFN0oRWi53x5VWjKXI6gNnTI96V2UnWrVMWdHTst6pt37rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NfvJVGp3; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3a575a988f9so848351f8f.0
        for <linux-spi@vger.kernel.org>; Wed, 25 Jun 2025 03:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750846760; x=1751451560; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7Ll2qquLfGh6XGelYBblYLwfpUh2cahEoEgX9BFfgbw=;
        b=NfvJVGp3TubCBf0g17UIMvrTcf99TG1Iy/OWDOJVBHJWMEvOATSV4m7+tsuqSZMCGs
         +zTix8YwH0DcLlV8ZmJiVtg5tkSsuiRGQd0SJSvnsXkEzRHNVvUOMMZweKlXsrE3jgOI
         IRxggfxwBCpYwnelbVzcaw7AEuB2OUGaBFXFxB09e2C2LFT5OnzKAKWqfuva2PAjRezD
         HHZPKHOyesb0lghoUsH4AYnw+1c745eVBaeh1E59CFdvcP2wpehRKbqRRglEnZ9CuqIu
         SQEeW+m6lke+WceSEqCuCf8q3nzFQEoDNaZKfvbq5Fg6yHkC2XIC5UZpCkyUTv50NWV/
         etmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750846760; x=1751451560;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Ll2qquLfGh6XGelYBblYLwfpUh2cahEoEgX9BFfgbw=;
        b=m1NXM7wqleKc0JZNRyhZ7Edy+j/QCcpWBlPVmnx9w4h/EvYcuzQvgxqjOn921szxhU
         +9r1h9ibJwcdbZ4BA2DPrfJLgqQDuFjbAyGiv/o7mHEv9i/uzqgtKdUsNT1KquOFZg05
         G7KAOqOO6Zf6hs/6qk/cZZN90ENs568ElZNmFdJUuwhSt+akxL00Retp/RPJEgHrular
         VA3RjblZFRSzsiOrsK3xIxNtjSMq7JELT5JaLfTbI0csc0Itu2qg0QI3TGRqSKhIazGb
         /nGnVMDNMYERE/Ew0zqCIP0Ix7IH4VedqOLWRO05rWskLr3ZTrLQEQvy+tWDf/T8UC+/
         818Q==
X-Forwarded-Encrypted: i=1; AJvYcCVK8IoLe3JypgS5Pi7oX/qA/cLiPgnrAwAQR9DczbLcvLKKaaXCAydqio3cTb0j1/k9pU9tJCdCUBs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ0aVlb9WPSHznpHjrsISB44Jq1XffOMcM11BDlz0lEub5tzSJ
	Tx43yGlsua91VtIDcj/Q3ohefofdWL6VlylofDF0FB9tlL8dIstUnvIpdtGWB4QnEXY=
X-Gm-Gg: ASbGnctnp+kUkDmo0TdzfUj6tasaw02v7CeUQmMJtS4XGXtRV2ysO6mmdXyJ68fFx9U
	YlfeaBNkxzMJYqp6l/AIt3lCwFa4RgcL54T5LRuln20H8MlBoi+ND9057p6frupMEkJr2ex0Syg
	KG1FCX1QNqWbLyzziF6wALVCG+wx2b5O3iW0Gl5d/1tfep/Bz2T/lCbjNRftIYyfqMPaOr9dGbG
	5XzVk51plhV9kNFpBmAl3FB2N95kK3c8ZFP4mwx50M8UVdK/8qbt/KLm9a9+SGewYf3B8CBhdDK
	/cTJXwz3WwlbYXEsairuayUGHSn4G4nsBdX8jEL24dKLNt5SJSQbACO5aAoDcTYRyJc=
X-Google-Smtp-Source: AGHT+IG4AQnRsnaojqWPjOdW6AAh68yC766lGy7h0in8xaHoSs5FdnvmUELehZ0zifBrriq6WAa6Wg==
X-Received: by 2002:a05:6000:2c0f:b0:391:3aaf:1d5f with SMTP id ffacd0b85a97d-3a6ed6746a1mr1929543f8f.52.1750846760466;
        Wed, 25 Jun 2025 03:19:20 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.136.128])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538234b1b9sm15217565e9.11.2025.06.25.03.19.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jun 2025 03:19:19 -0700 (PDT)
Message-ID: <884e86be-112b-44dd-a827-30355a5fdba6@linaro.org>
Date: Wed, 25 Jun 2025 11:19:18 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/6] spi: spi-fsl-dspi: Stub out DMA functions
To: Arnd Bergmann <arnd@arndb.de>, Frank Li <Frank.li@nxp.com>
Cc: Vladimir Oltean <olteanv@gmail.com>, Mark Brown <broonie@kernel.org>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 Larisa Grigore <larisa.grigore@nxp.com>, Christoph Hellwig <hch@lst.de>,
 linux-spi@vger.kernel.org, imx@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250624-james-nxp-spi-dma-v3-0-e7d574f5f62c@linaro.org>
 <20250624-james-nxp-spi-dma-v3-3-e7d574f5f62c@linaro.org>
 <aFrSgJ5xZfccEX9x@lizhi-Precision-Tower-5810>
 <290fc244-e88f-47a3-8dd3-0ec27eb5c60b@app.fastmail.com>
 <0c6c78da-575a-4d29-a79a-3903aa801b42@linaro.org>
 <0f904f12-295c-48fe-96c7-c64c461cdbbd@app.fastmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <0f904f12-295c-48fe-96c7-c64c461cdbbd@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 25/06/2025 11:00 am, Arnd Bergmann wrote:
> On Wed, Jun 25, 2025, at 11:19, James Clark wrote:
>> On 24/06/2025 6:16 pm, Arnd Bergmann wrote:
>>> On Tue, Jun 24, 2025, at 18:29, Frank Li wrote:
>>
>>> It would also be simpler to enforce this in Kconfig if we only
>>> care about users that use the DMA support.
>>
>> But most of the devices supported by the driver don't do any DMA. That
>> was the reason to stub them out rather than add the Kconfig depends.
> 
> Ah right. So even when running on SoCs that have a DMA engine,
> you can end up not using it?
> 

Yes

> In this case you could have an extra Kconfig symbol to configure
> DMA support for this driver and use that in the source code:
> 
> config SPI_FSL_DSPI_DMA
>        bool "Use DMA engine for offloading Freescale DSPI transfers"
>        depends on SPI_FSL_DSPI && DMA_ENGINE
>        help
>           ....
> 
> 
>       Arnd

Wouldn't that allow someone to break it by disabling (or not enabling) 
that option? The driver won't fall back to the other modes if DMA isn't 
configured, it just won't work. In this case it seems like it's better 
to depend directly on DMA_ENGINE because that fixes the randconfig 
issues, which is the whole reason for the discussion.

Would someone really want an option to disable compilation of two 
functions if their DSPI device is one that doesn't use DMA? Seems like 
this option would always be on anyway.


