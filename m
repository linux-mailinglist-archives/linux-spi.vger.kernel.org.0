Return-Path: <linux-spi+bounces-10121-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C446B853D5
	for <lists+linux-spi@lfdr.de>; Thu, 18 Sep 2025 16:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 396151CC066F
	for <lists+linux-spi@lfdr.de>; Thu, 18 Sep 2025 14:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF1B630C36B;
	Thu, 18 Sep 2025 14:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="V+vDhMpn"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A75930CB34
	for <linux-spi@vger.kernel.org>; Thu, 18 Sep 2025 14:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758205239; cv=none; b=Daq7P8IMuYdgvx4TT1iZvu9TSGwHtygc8+LRIBSYuYc5uiN861Vg/zl+f+z0SFD7bhi5LpVIXIhQ1QqcSCAS9v81VC63Ft0vCt194qwE9g77NnTBSadio9X00kPy7bQr7GtvOUfLb0VUAMCaWPGqtJSaEmkFeCxAjtKxMVGKhJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758205239; c=relaxed/simple;
	bh=aLT8EU4W6ZT2ILFHMoAHb95Gaq0GYb01rVMThh8lhs0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U+dXZBkLcV2pj9wTCqI6QYUnHcCeSvKx1s5Q5INVurc0MOViMmf3SHet6PMBWLgcygfYQ9jeMIWrASiPbVbgrcAaBmqmDyRXbnaTibCVMlAzSGxjUSW2x2t6amHAuzHicskCRPo3jG2hMpZ9VoKyrEV9VyyQFqnpGlhzGJEzVbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=V+vDhMpn; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-88762f20125so100952939f.0
        for <linux-spi@vger.kernel.org>; Thu, 18 Sep 2025 07:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1758205237; x=1758810037; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CGUyDQ28gbrezc/y2GGrwAvmT1nNgBRAv5nk0GUCrzs=;
        b=V+vDhMpnXJNVVf26RHVVrKscFcj47AuuA7K4ZlqmdyyMpTKkLFdvCJ7hzumlVR7waf
         vCwUbIq/Xz3SuA6YGfBZVpe+FNwYkg46S1clYwQ9KoNXwt2TfBqC3jArMRVG6m1mFEv5
         9miGwz1A1xNdITGPSTzTfkQLxcjuJ380HbK1XP1Q9UTmtK/C9h+A0Dbfr6bu0Z+QEzp2
         2rb2sC17TTS2Mct6J79kt/KiwEOzZkM4NBMS6v8iRf7Et4fdaqQPkZ09c5xexzDohjKq
         eoGxe0YgEkcFIKKaYh5PdoblpopoCKkGgLCK+1v6vpK38gArZ3vaNxBnfVXoXTa+qL0R
         uD6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758205237; x=1758810037;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CGUyDQ28gbrezc/y2GGrwAvmT1nNgBRAv5nk0GUCrzs=;
        b=d1mkgwRE8o4NvlLSoPXCoN9gzvmdrrNR4/S9Fz4nj3iMLX25tPGe4ZxAYqTW1VHzMI
         0vDOsG6prAY/6ONCOjUteEOKGW9Ot4wm8Tq0H+uCXNekHTRySHk/79FSqYgWAwwNVRLE
         72PXY7pu+gsEnqtGk513vGlQDqudzoTm83RBMS/GbxvTgmpIgxW+Xeh5lcWSQHTb4fXr
         Aaie+7WwLLAA7WTlTK2+lgEE9VmnIu/4ISGCvn7rLSc3GMxm9q6ASiRUvjdWBHEPPIvp
         IFpvLJ1bYEd4IjY8uHECqEshkEJGAi9Sih4mewFFT0o8qwwzSDfY8LPntslUUHzoi9+k
         eb7g==
X-Forwarded-Encrypted: i=1; AJvYcCXhWIbpotVDSVVE50oWqB0GUQJLnp475cD7HevFwGAKrOLLgOZZeAhdPq2S4dZeq/rpcwRqngst7js=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2enF1MqfxwPlz1MsHSDBxmtv8f0+W48Hn9etXfszQlboR36qY
	ozrwfyGpjrIVxszv5f5HgFWXrxdjQ5HUTbGWS/iY9V2qrUzkcMB2c5i8MG8Kad/bXpQ=
X-Gm-Gg: ASbGncueT8nxLVbfeDTAcQIQMsU5QT0lGM/tBiDI2G7tw9AoDTXAvL2pbAWvFVUsSTy
	tlXBfuKe77isSMzpwkSjkDoLLM+JQRSds0pkyh6fK2/Yc8EHrtMe2kL/oR/K5D0MjmIqXnmMiw8
	GaJ33FPa1j8UPoU3KfqJfYHJ9IjlJ4ij77unfNoso1xdd65Rl70XqLTXThCfkDx8O1m6EjjZtLa
	NPxvMJcpHIzPMsU8qd24EULkhVP+plgjp4qzFADLMfnyfnERZ8Uy/6BHV1LG4JrP7WfpsEd1Rwj
	x/xvhrHnAiAkSkKGQ+vdt6izKCVnasFKHCR+eTu9UtnTc3aVI97bW/HR3BVD3tEyXX2X6uEI6sF
	zhmx9n0DDsaCirY/NUAJyQfTl7TmOfusXNWdLSQNHRZezA0zOJsC1qG22b4uJqGsVMUNRW5HQbG
	ugUynNmQ==
X-Google-Smtp-Source: AGHT+IFYve4EQ3dvEX4MzZuxtP/eJg9hkH/7xZ8/C/iLPdxKPkoWIGurBe2rCvRfKygvBsgv23fk9g==
X-Received: by 2002:a92:cda2:0:b0:424:6c1:a778 with SMTP id e9e14a558f8ab-4241a52851fmr78183445ab.20.1758205237057;
        Thu, 18 Sep 2025 07:20:37 -0700 (PDT)
Received: from [172.22.22.234] (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-4244afaa351sm10679535ab.29.2025.09.18.07.20.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 07:20:35 -0700 (PDT)
Message-ID: <0053c0ca-340f-46fd-adb1-6af6928717ee@riscstar.com>
Date: Thu, 18 Sep 2025 09:20:34 -0500
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] riscv: dts: spacemit: define a SPI controller node
To: Yixun Lan <dlan@gentoo.org>
Cc: broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 alex@ghiti.fr, p.zabel@pengutronix.de, spacemit@lists.linux.dev,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250917220724.288127-1-elder@riscstar.com>
 <20250917220724.288127-4-elder@riscstar.com>
 <20250918133209-GYB1273705@gentoo.org>
 <5956e320-7cbb-4d9a-95a7-720cfa6b9654@riscstar.com>
 <20250918140633-GYA1274501@gentoo.org>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <20250918140633-GYA1274501@gentoo.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/18/25 9:06 AM, Yixun Lan wrote:
> Hi Alex,
> 
> On 08:51 Thu 18 Sep     , Alex Elder wrote:
>> On 9/18/25 8:32 AM, Yixun Lan wrote:
>>>> +			spi3: spi@d401c000 {
>>>> +				compatible = "spacemit,k1-spi";
>>>> +				reg = <0x0 0xd401c000 0x0 0x30>;
>>>> +				#address-cells = <1>;
>>>> +				#size-cells = <0>;
>>>> +				clocks = <&syscon_apbc CLK_SSP3>,
>>>> +					 <&syscon_apbc CLK_SSP3_BUS>;
>>> ..
>>>> +				clock-names = "core",
>>>> +					      "bus";
>>> can you simply put them together in one line? it's kind of tedious to split..
>>
>> Sure I can do that.  I've seen it both ways.
>>
> right, it's merely a coding style I want to enforce, to make it slightly consistent
> 
>>>> +				resets = <&syscon_apbc RESET_SSP3>;
>>>> +				interrupts-extended = <&plic 55>;
>>> why use interrupts-extended?
>>
>> Because it specifies both the controller and interrupt number
>> explicitly.  Why *not* use interrupts-extended?
>>
> It's just unnecessary, the SPI node will fall back to find parent node's interrupt
> which already specific as &plic, brings no benefits

The benefit it brings is that I don't have to search backward to
see what the interrupt controller is.  I realize it's redundant
but I do prefer interrupts-extended over just interrupts.

					-Alex

> 
>>>> +				spacemit,k1-ssp-id = <3>;
>>>> +				dmas = <&pdma 20>,
>>>> +				       <&pdma 19>;
> 


