Return-Path: <linux-spi+bounces-8906-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D96FDAEDCFF
	for <lists+linux-spi@lfdr.de>; Mon, 30 Jun 2025 14:36:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8807B1890008
	for <lists+linux-spi@lfdr.de>; Mon, 30 Jun 2025 12:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB6528A1C5;
	Mon, 30 Jun 2025 12:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kNc9RbRH"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDED289836
	for <linux-spi@vger.kernel.org>; Mon, 30 Jun 2025 12:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751286982; cv=none; b=qkcDtGkrzj1sCjvVbjUHsA3hynKS76pJKKSQPgIVX/nNvbY7JAVwaNe6trrCT+z122QKxVBg1LSuQ47rM683K3HsqRAFdhe0V9Sf3n7K7nzjfBv3Pl8kv65/urRQki6Uqmgn1Ip9QXoYbpGgf8t82t3jKPosjr8Catt/UoBGRpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751286982; c=relaxed/simple;
	bh=Iqbi9XJU3Rcsr9hOuzWCaTBhtE4KFyjIWoG/KOJnLcA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ef0Jqs9QYEKHMjxY9YcEkwx2sgXBkdUeXsxl+rrTRhQG4S2drvXyEMgoB+Tw6NHRyCe5m2sF07+SPxlgDUnZ31wcIqD2f8uJWzIBN47Co0Ivr7Ff7d7UXIi+ztM/77vC20AzfOgl0826ZoLGl2i+FXu1qprkpjfm1tv5FV/Rnoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kNc9RbRH; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-453608ed113so21263405e9.0
        for <linux-spi@vger.kernel.org>; Mon, 30 Jun 2025 05:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751286978; x=1751891778; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sTk6vgTqpktXfMs2jw1tzY/3Mhfdc83Si91WoTu70s0=;
        b=kNc9RbRHsyaYh0UkLJdn63hztu61RV+oRswciD6FCo1L/LvU4Sws/2q8rk/0dzkGn+
         6S2Yy79psRELTgsIkWbqFyeVXGgd35Igaub3YLq0loSgfBk5A2m3t4aja0hRz3gfZSz2
         Tr3lXrpBrgPgRMd9PtasyG6ziO8lpmaJPBUP/Ze9Bdg7u7dUf0oWSERItUGCFoHg2+sO
         ry213PyZeeGe1LzTZdgrSKPaIEuq1vD5a9jwvoQtW/7vJJT61k/XVfZDtmAngN4NE9M8
         niO5EjpCxRx6KGWdNhD5VeSG4fAUhosayx2xSXx2Qpb3mN7CvzBNFip/aRBCik89ccXE
         lbXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751286978; x=1751891778;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sTk6vgTqpktXfMs2jw1tzY/3Mhfdc83Si91WoTu70s0=;
        b=IDU1Dipn09LE6iG1e8IqV0dnbOH4lcL4VBRzwZTt2UgLOGlSOLWrA1QJRaZZDlsD0x
         fUmdjyLpViZZOXXXIwwDZYdr/e6r4Cl1YMfVIhNtOcM8z2DBkglJUMwBk7wKJCDjIYY3
         w804SfTnwWuX3/XnEDyPp7XNGf37GyKfKv4Jz3L+spGk0bIN+PCQ4Crzo5EvFc9XPSWA
         mZ7TziF7c9cYeOOnvE4045cP/RPymU+1Ky64qU4txySRieaKfWjJ54/t0aQYMGq7RZ7S
         8kmH5olgLVwV8kqkrBTinS2sMAWTIY46aYya+NiEFEMcosjbHauP7XxSC90XI0efBqFs
         5buQ==
X-Forwarded-Encrypted: i=1; AJvYcCUaQQh7Xr22hRGQOZOjj9DA+1JYgkJ/dLhwqjsizzbXvN3A4pYaaF0nuukwMlBfs1hR75/CwdIpLG0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUQJYrgLq7jtzsoIsq+giEmbXb8FsGHVpqjbh2y9j/Tiils0Pc
	dUWzJxjqd5WyMgvrDp/HjY+kUJ/BMMmLHk5vFnky0in+m5LU6YTP2saTHPH0/Z6lEjE=
X-Gm-Gg: ASbGncsJo+x+3nthl/A/mfq5l5EM2PQ4IBRojsAaO0z9GvsRjekEVcoHxQyUIssoYgI
	HqpJQr148YlXck5qBwDTbmTd3yr+FOBcDs/l2nifP0O+h9zz+W+5287CeaJxmmOKOFydxIm1Ik0
	QMafStn44tVfpaAdrp9c3/c2EHXPQdKnwHRNTAFhyqEPsZTsrZDmssPhgI53EfzsGOinxrgZCef
	P6HBT5TVbwS5LuxWbjLhAHNPN8YvZauZ+tL5X4BwYMxdSV/dAyDP0oVu4Eg07BIEb3und7xbfQX
	sh2miuJTaTD6lJytpZKYLuKsVx4Q+L74rq7M4v9w2QsxzpfJvvvTevKU924bXxFt+Os=
X-Google-Smtp-Source: AGHT+IGodC564GL5rE7SFk0/J9O10Wn4F5hiF1J3YUnZxSumumM4a6Ana+kyQSrduZXBrfrz1Dx6YQ==
X-Received: by 2002:a05:600c:6285:b0:450:d01f:de6f with SMTP id 5b1f17b1804b1-4538ee51961mr149563425e9.15.1751286978275;
        Mon, 30 Jun 2025 05:36:18 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.136.128])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a892e59ab5sm10090309f8f.82.2025.06.30.05.36.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jun 2025 05:36:17 -0700 (PDT)
Message-ID: <d86c48f4-fa10-4205-b0de-43fc8be0c848@linaro.org>
Date: Mon, 30 Jun 2025 13:36:17 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] spi: spi-fsl-dspi: Target mode improvements
To: Mark Brown <broonie@kernel.org>
Cc: Vladimir Oltean <olteanv@gmail.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, linux-spi@vger.kernel.org,
 imx@lists.linux.dev, linux-kernel@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>, Larisa Grigore <larisa.grigore@nxp.com>
References: <20250609-james-nxp-spi-dma-v1-0-2b831e714be2@linaro.org>
 <175128365072.28911.16806664823646528710.b4-ty@kernel.org>
 <9f707fd9-a9f0-45d3-aaec-e20bad4c4f76@linaro.org>
 <e5dabc83-eb1c-46eb-b24e-6dc8b19c4ff7@sirena.org.uk>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <e5dabc83-eb1c-46eb-b24e-6dc8b19c4ff7@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 30/06/2025 1:25 pm, Mark Brown wrote:
> On Mon, Jun 30, 2025 at 01:23:18PM +0100, James Clark wrote:
>> On 30/06/2025 12:40 pm, Mark Brown wrote:
> 
>>> [1/4] spi: spi-fsl-dspi: Clear completion counter before initiating transfer
>>>         commit: fa60c094c19b97e103d653f528f8d9c178b6a5f5
> 
>>> If any updates are required or you are submitting further changes they
>>> should be sent as incremental updates against current git, existing
>>> patches will not be replaced.
> 
>> Not sure if this is a mistake in the notification or not, but this one
>> shouldn't be applied. There is a v4 with some issues. Although the
>> notification on V4 that patch 1 was applied is OK.
> 
> Please follow the above for any fixes that are needed.

Ok I think I may have just been reading the notification incorrectly. I 
see that patches 2-4 are listed as "(no commit info)" so I'm assuming 
they weren't applied.

I was a bit confused to see this notification on both V1 and V4. Maybe 
an artifact of the first commit that was applied being the same?

So nothing needs following up, that particular commit happens to be the 
same on both versions and it looks like the remaining patches weren't 
actually applied.



