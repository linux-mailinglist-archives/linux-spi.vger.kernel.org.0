Return-Path: <linux-spi+bounces-501-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED1E831ABE
	for <lists+linux-spi@lfdr.de>; Thu, 18 Jan 2024 14:43:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC10428776E
	for <lists+linux-spi@lfdr.de>; Thu, 18 Jan 2024 13:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205401D55A;
	Thu, 18 Jan 2024 13:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I8GiAqY6"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5909325750
	for <linux-spi@vger.kernel.org>; Thu, 18 Jan 2024 13:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705585396; cv=none; b=HyOtBeVlZbnTAkfB0IWUspGkhjTbfjSXdDvGL/YwWeOeDl6PejleE3xvuszBW2ujI2mAEPUrK9B41I8A+ibdtnTp1pir2Ikfu8t6mpYymGOn7WO0STk2LVA4xCYDpgBEJGX5EOlvWu+sbAUlFcdPw5M6V4V/y2/meqZd/rseMgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705585396; c=relaxed/simple;
	bh=e2vtDuhYgMmP6hm99F8iSKOe28KqoDVgOs3zkAnyJ2k=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:
	 To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=Bcrh4Sv0xOI/dU13CGqIM1WCbjPWnmAMVEQMSpXS9WLaM4olmP6JaP7gchQBTZ6e5yJqH5LRJmXQh3Af5Oj1Qlt7myJfpoPijUvTzZObHSBYRTtIfViylmNrPku5wfYOVhHPADjewEhOYiHvFcSKKTdRP6kCK5Hb1iug79iv2mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=I8GiAqY6; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-50eac018059so15962805e87.0
        for <linux-spi@vger.kernel.org>; Thu, 18 Jan 2024 05:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705585392; x=1706190192; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uKXdOMa6CFTvdvBo1Y+yw7L4PkHx4xSAhjuginqsYaY=;
        b=I8GiAqY6L5XeC6OlUljzx+qVE7wMlHLp6oLUEin7pmcsdbpjWnLtvbUbCm4cin4v1k
         2SmFZB/KUEi/0EZan0dgsMP4Mx5AhAtrW4il4EQEqFK3517JW552zRkoy6RuCuhBLFSv
         JdSDFMwrYw3piFC88+9jv0YlP2IkKSUz1wUceFubtqO7QDQhaw7VawMNiq57tNTfzYiq
         27sLLqdlaytUOBLHsRCPRUM0gozgvLU/V/7jVYSCfN/Xic8TYRV5iUQWbhJE2IleIy0N
         iJOurDyggJWhRXC6qnseoNeCN6Hrdk2zXurGGT/UUP4kFjYUeSkwpOa6TF17adbccg6w
         HsAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705585392; x=1706190192;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uKXdOMa6CFTvdvBo1Y+yw7L4PkHx4xSAhjuginqsYaY=;
        b=mB4C/tR5v2hzdhHxM8AIWua4sgizQ8eRf4YLnGEIPO7Llzk6o7pys+sjS2GuUxmFR6
         B8QQxp5St6U6AwkvQ01D9/rxRObMgg/IRddwczv+RCHSPLOxF8jPWS656XlLO4K/I5Oe
         LH1HW6BO9bVw0XWsKgPtzcRv0EEU2dAT7o+kHSAb1WpBMUthwe0vHurMlzrupYuPRBVF
         7V/dUbP7TjuWo9A7MGtOEDtPSNb3Td9wnuvvlIfcMGsmnDLM01v8f1c5p3HiI6sdtW2a
         LECc17rH3wz1DAXgzptB9S0Fon+h8+DYu4as/aXVizLmuv6kEqrj1GWer8mIMK9Yu5Rb
         rn+g==
X-Gm-Message-State: AOJu0YxMDMJt3Qx74zIHI4B+Fw4PbQiIEV3WKxsOO4LlnDVAOP6RZW2j
	HR4dcCV1koocAEUtWawLIxpj+uKmK6l2iau7w0Z8NNyXoi3wiB9SGNTZeDnv3ccTAy6gTUnHVrR
	kzmg=
X-Google-Smtp-Source: AGHT+IHS25Vf1aNiHNzQkr/0OchFeUGY12fwtt5HObnC5O3KjDqWpeJx7ucltXlN+wnRAD2zBeEFBQ==
X-Received: by 2002:a05:6512:1327:b0:50e:55d0:855c with SMTP id x39-20020a056512132700b0050e55d0855cmr613513lfu.17.1705585392342;
        Thu, 18 Jan 2024 05:43:12 -0800 (PST)
Received: from [192.168.2.107] ([79.115.63.202])
        by smtp.gmail.com with ESMTPSA id u13-20020a170906b10d00b00a2b3bb73b83sm9156463ejy.94.2024.01.18.05.43.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jan 2024 05:43:11 -0800 (PST)
Message-ID: <18dc21ce-7f69-4ef1-a7d7-338fa7fa4990@linaro.org>
Date: Thu, 18 Jan 2024 13:43:10 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] spi: loopback-test: add elapsed time check
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>
Cc: akinobu.mita@gmail.com,
 "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
 kernel@martin.sperl.org
References: <1489774651-30170-1-git-send-email-akinobu.mita@gmail.com>
 <1489774651-30170-6-git-send-email-akinobu.mita@gmail.com>
 <4f097d14-dc7f-453e-94f6-96ef568e7770@linaro.org>
 <e3db65ab-be7e-45dc-9104-fe2a3b046b7d@sirena.org.uk>
 <f0a9f2af-f737-496e-a1bf-7758826089b9@linaro.org>
 <a176ecb0-08ed-4e1a-bd0a-aaf70186f5bd@sirena.org.uk>
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <a176ecb0-08ed-4e1a-bd0a-aaf70186f5bd@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/18/24 12:42, Mark Brown wrote:
> On Thu, Jan 18, 2024 at 08:30:39AM +0000, Tudor Ambarus wrote:
>> On 1/12/24 18:37, Mark Brown wrote:
> 
>>>> [ 6748.913400] spi-loopback-test spi13.0: elapsed time 532837 ns is
>>>> shorter than minimum estimated time 82240000 ns
> 
>>> That's a *very* substantial error, it makes me suspect that the hardware
>>> might be doing loopback at a stage before it actually clocks the bus and
>>> doing something like just connecting the TX and RX FIFOs.
> 
>> Thanks, Mark! It was a problem on how the clocks were handled, I ended
>> up with a higher frequency than I requested.
> 
> Ouch, hopefully that's only affecting loopback mode and not normal
> operation for everyone.

It was a problem on the clock driver which is not yet upstream. SPI is
fine, in loopback mode at least, that's all I could test for now.

