Return-Path: <linux-spi+bounces-8590-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C5DFADB17A
	for <lists+linux-spi@lfdr.de>; Mon, 16 Jun 2025 15:17:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D4D77A9BCB
	for <lists+linux-spi@lfdr.de>; Mon, 16 Jun 2025 13:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09732D9EEC;
	Mon, 16 Jun 2025 13:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R9CIu4TD"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF39E2DBF77
	for <linux-spi@vger.kernel.org>; Mon, 16 Jun 2025 13:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750079699; cv=none; b=Z6jOaNoIDIo4U0wPe0WzibS2LMwfDsFj4AdFoX7LiA8rm21/y5r+mhEOsQLSNbbmg0Y+G0vrZ1zIu6SUEQfAccFufLx+elZ1kV1WsY5AFoxhPckPjujLjgRNKmETBZRFa2dmU4uOFRF66LkGiQAP74EkpdzhKy4IEOOWgKVBdfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750079699; c=relaxed/simple;
	bh=h+AoZLWnrd8a6Oc4wKT40DhZiludtEsDa24LLYFfTC8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jgYeQsBEGeFdGB+HMSyfKJxS3ZdcUgtnvhDuRHnpynteMre3tFurj9U9O4Two7fjd8VjK731dHUfl4ZD1C4PmSn7C9XX0oVT3mWjiCh2QmlSB/Nn1jo0Ib/xv6jw5zOi0sHSZczEC5PqZbiOOSMlqzNFKFvXB5DMrXa/G7LThBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=R9CIu4TD; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a5123c1533so2569681f8f.2
        for <linux-spi@vger.kernel.org>; Mon, 16 Jun 2025 06:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750079696; x=1750684496; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TJ++7qElBXjbLPKEg859pJbPfq8le05HNKkEpAhCAPU=;
        b=R9CIu4TD4vWNCQ84I7W/FmjmATMArgJMjM9VAHEgxaUni6rSa5s9bERY3q3iPRWen9
         g/JWFK8fWSzJXZv7HCA7g9BE3BLGmW/isicMVDkFwUBlwN6zFmL5eFaCWvcaHEQ7hPwP
         ENxdQxrv7PMVvHof/49foJ1Puw7HaA4+zVJEJr+Z8Fts4+Ouek2iEjNNGeXGrSiV4LmR
         YqlTcg7gfz4EmIqf8dgxWOhBtJlUcATQaM/qhKnpwD8pvlwfxYvktvLulcpFCDwA+oYu
         ujCTTZefcHaF7w7meJ8tfoZlThFlHBpMTrrc4q/Q9PVjP/WRbI4/aDZPy+ZePY43ErGk
         uUiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750079696; x=1750684496;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TJ++7qElBXjbLPKEg859pJbPfq8le05HNKkEpAhCAPU=;
        b=LwTeL90LBOgrFTDecRcoknL9ISy0345geHHyqofgrk6XB4i6zfsH01iQ134wMD7MMM
         /x1ASUUl6nfNMO2hn9N0obiktbdZP8j8TY14V6ItrJnhe/KR20DoJIV8RJXYQUlgKfCq
         IGdFuEtTzlUIY9sZkyQ2ELZrVkfUoyVQs0H03chphlVWoY18CXx6XijHtpsmAjdxc4MC
         O7y6X5QmnvbPw+8tIJJNvxmkxvvTdfZ9J8vMdT6MOQqkRSaHLZQV9zDQXpvE0SP5bbnY
         v5rloSylEDmcu93K13DPNecdGpNL1+k+zj7cCsgwuzeRJZA9naVNdizfWZvuPnftktRH
         qgPA==
X-Forwarded-Encrypted: i=1; AJvYcCW7W6ulfPBhqGOBoQ2js9CejAEmrhnxJ7dVOFu4f4XjBiAOEBlcnXy8mnvCJWhE8wLZM/PcQPCP2Ww=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5HOsvOGNbaiOibq3sYBxo3++Ev+1lZDzSmblYUqNf18fvQAd5
	zBqY8k8j9UAKmSagg+p5EqsipYNZZqxPX3BWS1LogwZNYBAP//KzzuXzzl/9To8Rmek=
X-Gm-Gg: ASbGnctzxaqTL500vWrs/Nd96qjmTRw8cLCxYfLGzMuNr7tfyhLNp9eCH3yUlgGbNR4
	bt9CxSfSSGU9dfIHXdyx4vKHebDFACa8T2WAyuO8I1zbYqrkfjuosO0oIDUEcZyVqZf5ncF14z4
	TQ4RNy47hO7Yw/RI8TWubMJyJnm80JF+aay4DFH0hZf/EAh3FKp/mON0ActLzJvw26sDfFN2+kj
	BlYov8eaDk2DQRTispJ7l05MkMvhQUdyjPFdM6ZE3sB/OHgOcN71TPW0m+CnoDTqrKlflrYAiAd
	XjMTKbxfaCkczrpAnF0+AuLs0vwzlIovhZ9E3w+VG5iuo0PmvuB6uQWpWzjNIEv8Vks=
X-Google-Smtp-Source: AGHT+IHos6U7nxGDoiXdGjhAs3Whyn47rcft9em19E32YJ5Q6QPRqLvwdbpp0G+JbOnleSw237UOPg==
X-Received: by 2002:a05:6000:2908:b0:3a0:b84d:60cc with SMTP id ffacd0b85a97d-3a572399156mr7832327f8f.2.1750079696270;
        Mon, 16 Jun 2025 06:14:56 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.136.128])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568a6ee12sm11079775f8f.31.2025.06.16.06.14.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jun 2025 06:14:55 -0700 (PDT)
Message-ID: <83855c1a-c128-4762-9d6b-e17f2c4c8820@linaro.org>
Date: Mon, 16 Jun 2025 14:14:54 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dma-mapping: Stub out dma_{alloc,free,map}_pages() API
To: Christoph Hellwig <hch@lst.de>
Cc: Mark Brown <broonie@kernel.org>, olteanv@gmail.com,
 oe-kbuild-all@lists.linux.dev, arnd@arndb.de, larisa.grigore@nxp.com,
 Frank.li@nxp.com, linux-spi@vger.kernel.org, imx@lists.linux.dev,
 linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev
References: <202506160036.t9VDxF6p-lkp@intel.com>
 <20250616111749.316413-1-james.clark@linaro.org>
 <20250616112927.GA21689@lst.de>
 <5f1ca0ac-b66c-4b92-8f69-027c2468b117@sirena.org.uk>
 <20250616120832.GA24959@lst.de>
 <2d62254e-5cbe-4174-95d8-e80cae4f4543@sirena.org.uk>
 <20250616121444.GA25443@lst.de>
 <7cfcf919-3c7d-4f0c-911f-697ea3141080@linaro.org>
 <20250616131346.GB29838@lst.de>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250616131346.GB29838@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 16/06/2025 2:13 pm, Christoph Hellwig wrote:
> On Mon, Jun 16, 2025 at 02:10:40PM +0100, James Clark wrote:
>> The change introduces consistency with the existing declarations in
>> dma-mapping.h. Surely there is value in consistency and it doesn't do any
>> harm to define new ones with stubs the same as the other ones. That way
>> when you change an existing device that has DMA stuff to use a new part of
>> the API you don't have to predict that it will behave differently to
>> another part of the API.
> 
> Well, redoing the rest would definitively be nice, but so far no one
> has signed up to that.
> 
>> I suppose it is possible to #ifdef out the DMA stuff in this driver, but
>> IMO it would be quite messy, and I don't think randomly not stubbing out
>> some functions is the right way to move towards fixing all the dependencies
>> in all drivers. We should continue with the stubs for now and fix whole
>> drivers one by one as a proper effort.
> 
> Does the driver even work at all without DMA support?
> 

Yes it does, it has a few modes that don't require it. Presumably we 
can't just add a depends into the kconfig for all devices because they 
might not be using DMA.

