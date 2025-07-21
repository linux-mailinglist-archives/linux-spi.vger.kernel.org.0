Return-Path: <linux-spi+bounces-9144-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69624B0C5BF
	for <lists+linux-spi@lfdr.de>; Mon, 21 Jul 2025 16:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A118B541BEB
	for <lists+linux-spi@lfdr.de>; Mon, 21 Jul 2025 14:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD5A4283FC3;
	Mon, 21 Jul 2025 14:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q85pe+7d"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A2E128395
	for <linux-spi@vger.kernel.org>; Mon, 21 Jul 2025 14:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753106534; cv=none; b=lb6DT4wKxEG67Gq3AZi5qzagZ7UbzFEOREymKL5RKKmXB/mbLSB/u0S3IG1WOXSDXviUVyDVAnqAQmrh56pG3DSfbEGz4NvQiTGN+goY/UAN+lDu5KF1KVE5omR1TECKR6Wnyqi05brEiydzrbILxe2nPJDO2zWjnA1rwK9AZHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753106534; c=relaxed/simple;
	bh=K/tvH/XPupJbti3h3akfsqzcD/XB20IvWkJxZTtRarc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QV4qXVIgiBwu2h3DBPNegnu9ckTWohEDQ48e9AjyUxegO8NTxItKgGSGuqDy5/OYcJNL5O0/4Pc1HqU395fpRObNO2ytDW0igpvkjY0wA6LTO7zWi6xvfOSg4quB80hK8+RQyfVMP/uAvw65Q9Uw/xxxV+lmHQvxdeT/7HlYRIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Q85pe+7d; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-451d6ade159so31920385e9.1
        for <linux-spi@vger.kernel.org>; Mon, 21 Jul 2025 07:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753106531; x=1753711331; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JysbhfPyNzahvE6I7WOWc6CziM6SyuBgK4O6jVYWaZ4=;
        b=Q85pe+7dsIMmzfKxmjZta9ba6luxbkaSQOgGsA7Xmea3kgKF0O7n6yPfK2aBomrxzZ
         9/eHMZWMs+EWliGUcvqGhfaMtHTQtVT3z/HVYORnpfNHWq1/Faw9G8zRsR2um3ZeQY/G
         HWvBEh9XaTD1DARLQSp1uO8N3yN8av+u/y8Crk4+xvsV6VDLUsRBJvhUyyXxbWlUA+E1
         AweV17WRZHSHNuSBKZjdL+bx6IOB9ZvBhbveD3XDHbohKoIs3T8Whdp1XOJZ6e2GpxzJ
         D8ssBJdSVqJpv1UDd2lmimECBWCCmp5ytsQwYcOvJqGEwVcCKdC/cRzlitLjyKvaCjUA
         5usQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753106531; x=1753711331;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JysbhfPyNzahvE6I7WOWc6CziM6SyuBgK4O6jVYWaZ4=;
        b=dc0aen7fpDGkVr4oIJrHYkWwB6gYbmiuQ3liMZsF8r00pb2nXm8M20EvNlkEsmB76U
         jEwy2DVqB2du68VNK0IQN2LN8n9gWFPLXTaCTyPMBwsF/BmQ76k94rTFmiKw+b5Qqe0D
         1VG815/418GvRoBErBHze7zhH0pk90juF5KKWrtYgQsR+GlAKRKtWnpEJiQORs9R4huL
         BDsAj7h5vwcB0JGyXUC58cOJyjxtH5uplfHv50D8FW3SZVuEmLL4CH5vQsHmDByXdS6v
         2o2yJN09CH12emkqP5YkwOp+QvjZ13+38gRjcXfZx+eKf995HKJMWvdv8VSE4lnZ5ubK
         OLSQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8dS+XTCvlp1eM6Wx6bmtnhuZMVEy7Zj3xHskpBMFZliczaXIa7g1LH7P2QPewiY9HoFF9KrpaEDY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXf6iTuuDD0XemaW1SwdgfqcZQScjqEVNp6wMTVyvcGAwmHnq1
	8bxFAb1sad9HzZW0SVXfdew6jsnyQQBU8PAIlgOKZLPDcn33CldFxyuXc1WAn2xtzsc=
X-Gm-Gg: ASbGncubz8M75xKkACfNhHC5WqmlpSgBg34JHbqMxDdAruoeGmjD5jMygZzZGmb5aKs
	2R1YqKS2PTvuJ6KRbBcH8YAOw1fgvovCUe6VVlW8QpvItCnEnfXcpJoy0m8sP9M9eSKhYN7EeHS
	0q47RNxJ7If6+2+8qvQPMeLk1T8gbl2YEq2UKMS/jUYR6yuqK3GMCTb32NyzQuu2Hvy0AFKZ6ej
	nnMaDb9jxQYT1kVHXQcio53fy3hfcw4LcoCJ74oWyojlS6VU1xKdivEQqd/KfQFo2f1oeGTDqLH
	4a1gD64TXPvfyAhmeqBA9VNRcGv6wlHczNaifmRICFWjFYCZAShC37Gie7H9lzPR8riNpSKPkBr
	QH2ffwPi+7gcqvn5VYRSoAHWy5aU=
X-Google-Smtp-Source: AGHT+IGOX5JDkng8uIhW+zosXPHsHWQGM69v40Uruv1QlOIkOEgGq49oUq4QtzyThAB5R5cnQLsYTg==
X-Received: by 2002:a05:600c:3b88:b0:456:25aa:e9c0 with SMTP id 5b1f17b1804b1-4562e355c9bmr205979635e9.14.1753106530850;
        Mon, 21 Jul 2025 07:02:10 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-456490dc57csm44070625e9.4.2025.07.21.07.02.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jul 2025 07:02:10 -0700 (PDT)
Message-ID: <e23bac2c-c39c-4446-9305-e7e51eabcb4b@linaro.org>
Date: Mon, 21 Jul 2025 15:02:09 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/6] spi: spi-fsl-dspi: Store status directly in
 cur_msg->status
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>, Mark Brown
 <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Larisa Grigore <larisa.grigore@nxp.com>, Frank Li <Frank.li@nxp.com>,
 Christoph Hellwig <hch@lst.de>, linux-spi@vger.kernel.org,
 imx@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250627-james-nxp-spi-dma-v4-0-178dba20c120@linaro.org>
 <20250627-james-nxp-spi-dma-v4-2-178dba20c120@linaro.org>
 <20250627213041.vp6yfcgf4xysdklf@skbuf>
 <eb704af4-5800-49b6-9915-c990c5b23fa1@linaro.org>
 <20250721133958.dhityxa7vvtqov3d@skbuf>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250721133958.dhityxa7vvtqov3d@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 21/07/2025 2:39 pm, Vladimir Oltean wrote:
> On Mon, Jul 21, 2025 at 02:25:55PM +0100, James Clark wrote:
>> Hi Vladimir,
>>
>> Just wanted to check if you are ok for me to send a new version with your
>> fixes included now?
> 
> Yes, sorry for not being clear, the tests which I wanted to run were
> these ones:
> https://lore.kernel.org/linux-spi/20250630152612.npdobwbcezl5nlym@skbuf/
> 

Got it, thanks.

>> I assume from the other discussion that we don't want to always enable DMA
>> mode either, and we'll just leave it for s32g target mode only?
> 
> Yeah, for sure don't enable DMA mode unconditionally. I don't have time
> right now to look into Mark's can_dma() suggestion - if you don't have
> either, I suppose it is what it is, and the performance improvements
> brought by your enhanced DMA patches can be brought over to other SoCs
> at some unspecified time in the future.

I think incremental is better yes, there wouldn't be much or any of this 
thrown away anyway.

I'm also not sure if it would fit with can_dma as that starts mapping 
stuff in the core layer. We want to avoid that because we need to write 
that control word for each SPI word. We could still change mode 
conditionally in the DSPI driver though, or make can_dma more flexible. 
But on top of this for sure.

James



