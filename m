Return-Path: <linux-spi+bounces-8587-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48439ADB140
	for <lists+linux-spi@lfdr.de>; Mon, 16 Jun 2025 15:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 505643A1BDB
	for <lists+linux-spi@lfdr.de>; Mon, 16 Jun 2025 13:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F3D292B2C;
	Mon, 16 Jun 2025 13:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T9RQ2btZ"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88035292B4D
	for <linux-spi@vger.kernel.org>; Mon, 16 Jun 2025 13:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750079445; cv=none; b=BcWTgOHvFxiuPbXDPRUrEJ48bRrC/46CfPpH2uQXtHyRQOTA1B9+CSJvYqXxAuAUV05bRDfi5Mn7Hb+Xqo0uZYFdfB5Bdg6GoXCWJAtzL+FjCsCuxNu+fgLra9YxWk5ecby9WATd5bnVYOZ51bg9t74IlW5c+3pf5y+Dhv5YkLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750079445; c=relaxed/simple;
	bh=pFqG/js0pAlqzBZAvPKECVmOa3/ZW9gFrsfeSebvWj0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g1i6msGSo/LEFtYmYgMZXxE4jl6ELr/yUEPaPaI2FKKqojtGqPUNVs6lCkjoInA/6/wlObukuQoohCsg3Pmim5GGzk9WUYO53NMsmWcjut+DvINJTg/rzJbwdmpUrO2rDiwgzKM+kvgZO+5OkbJbPagsjPby/haD2/+FnW74zro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=T9RQ2btZ; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3a57c8e247cso1180521f8f.1
        for <linux-spi@vger.kernel.org>; Mon, 16 Jun 2025 06:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750079442; x=1750684242; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x1cp+4QPv/1PUyqDV9F6cY2KZxx/RBlLdAVmrPE1MfI=;
        b=T9RQ2btZgx+EAZpkOtkYQEPfrBSmU5Fu9FRQLS0vcfsZzDvM29PG0/KCu3UFR0cWO1
         89CEPTRzHf2ulCOc8wfAeNMFXCOC8zHpsmzilFulmp4kYQ0rDtBrBWjFtQN5My6aiyoQ
         B+aGx/rjh7VA7zyjFzvFaSvUD7BQJklEJC8NtGENk27FFKccQrl5xY8aoza7pi+s4Zdy
         1ddjI0cFXOb7ycUjigQzfB8WrlzKR+Aa9oGmiE2WgpXi0O6OE1a5osvPXuhncSCnaJd8
         4ZHM82kGbgeu01O87AUaX2CZOFEl81ACul3KsAmTsuf3dXaVuKHT5TFoJFB6et2+ql1I
         7yTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750079442; x=1750684242;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x1cp+4QPv/1PUyqDV9F6cY2KZxx/RBlLdAVmrPE1MfI=;
        b=YgvLPscxGQ2mqcGWv6DvyP5omibaISyDa3VQsKj4p1fTZCmzrFIh7uqK2c5G7HjE1+
         X106ZmwvMbCY58ea3RBi4F+ZyfSrNUrMtVjvXP74DM7B3845Pe6lC+zk6SFJo0w29ieg
         asrgl9j9kBu8ZJaIm5M/+iOJZy8VB7fuusQUYMuN9HHhCPOKk6ptBIV0b9WcRWXvmSLk
         DEgZcP2yeQ7iqZwevxhHPRGbz65Devtyfvdlkxq9Hr3VBcqVub02qrKv+NrKqPNfnTrO
         DTLm/Who5Muee4bVNdROw/MbIXc7IqGFcPwPKVm+7TJ1FbziX6N9nItuuRiUveuRXJwz
         WVvg==
X-Forwarded-Encrypted: i=1; AJvYcCVyajcJCwyoyB/ZBDPqiy17EeaErxuK98Cjg0xFr9vEhy7jFXpQlr/Tg4EFKN3/vCIzQOL6RsoPHxE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2ID7M/MN3s1RGRQDTXmjm1spjVehxJeEMwsg0B5qrCOG4O5O0
	yKhS7p6d/k/fAri7C31LCXnUce2YUXmdYNyRrd7Ho+kGdGv4MG6bHOjcKhrF6n7A89I=
X-Gm-Gg: ASbGncuxh2s8qPVMph/7YDFIogOGVNIdhO3F3GdKCrBfSIP6k26m/o8DiIrbWP8dQVN
	Y6Eb/FXT0fvnZe8C/XcP024xTX6LYF8M77FuL2TsGZXcBIl7T2Wcsy3MnsCwCfI106/LmlLe3tG
	Co3EINPz8KUFaaw4pgzv1o2n1ywxV6ruJrFAbD3/Q9+f9Jr8HkGiD8XvHNKPZEYEwapo6P8ampA
	nHzrsT1ajKcDwXgD0G7xueS7u5h21+L1Z2r+FHom6KpnEls9nLZk02T1okJOH5YxQ5pBwsLMHNV
	mCpTyCztR66mqLGVrqdZ3UF51cSyE3LiDA8xklnamQ+YK3H8pE3NHDQ5e7LW6OKct5EimPNXdm4
	XQg==
X-Google-Smtp-Source: AGHT+IFNHg0hyF1PNKI8qLbgZNCoz4YroOmMfvQ93hu1uR9eCFCC/xZl5Wbo20JN2FbWxFzP2HZ79A==
X-Received: by 2002:a05:6000:4284:b0:3a4:e6e6:a026 with SMTP id ffacd0b85a97d-3a572e6bb83mr7546401f8f.28.1750079441882;
        Mon, 16 Jun 2025 06:10:41 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.136.128])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568a54aeasm11271121f8f.14.2025.06.16.06.10.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jun 2025 06:10:41 -0700 (PDT)
Message-ID: <7cfcf919-3c7d-4f0c-911f-697ea3141080@linaro.org>
Date: Mon, 16 Jun 2025 14:10:40 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dma-mapping: Stub out dma_{alloc,free,map}_pages() API
To: Christoph Hellwig <hch@lst.de>, Mark Brown <broonie@kernel.org>
Cc: olteanv@gmail.com, oe-kbuild-all@lists.linux.dev, arnd@arndb.de,
 larisa.grigore@nxp.com, Frank.li@nxp.com, linux-spi@vger.kernel.org,
 imx@lists.linux.dev, linux-kernel@vger.kernel.org,
 kernel test robot <lkp@intel.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev
References: <202506160036.t9VDxF6p-lkp@intel.com>
 <20250616111749.316413-1-james.clark@linaro.org>
 <20250616112927.GA21689@lst.de>
 <5f1ca0ac-b66c-4b92-8f69-027c2468b117@sirena.org.uk>
 <20250616120832.GA24959@lst.de>
 <2d62254e-5cbe-4174-95d8-e80cae4f4543@sirena.org.uk>
 <20250616121444.GA25443@lst.de>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250616121444.GA25443@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 16/06/2025 1:14 pm, Christoph Hellwig wrote:
> On Mon, Jun 16, 2025 at 01:11:49PM +0100, Mark Brown wrote:
>> already tied to a platform that needs DMA needing to add the dependency
>> which nobody is going to notice without doing build testing for
>> randconfigs or similar non-useful configs - it's not a productive use of
>> time.
> 
> Stop your unproductive whining and just fix your dependencies.

The change introduces consistency with the existing declarations in 
dma-mapping.h. Surely there is value in consistency and it doesn't do 
any harm to define new ones with stubs the same as the other ones. That 
way when you change an existing device that has DMA stuff to use a new 
part of the API you don't have to predict that it will behave 
differently to another part of the API.

I suppose it is possible to #ifdef out the DMA stuff in this driver, but 
IMO it would be quite messy, and I don't think randomly not stubbing out 
some functions is the right way to move towards fixing all the 
dependencies in all drivers. We should continue with the stubs for now 
and fix whole drivers one by one as a proper effort.

Thanks
James


