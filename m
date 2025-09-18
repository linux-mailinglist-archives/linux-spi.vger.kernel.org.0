Return-Path: <linux-spi+bounces-10129-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0BC3B86035
	for <lists+linux-spi@lfdr.de>; Thu, 18 Sep 2025 18:26:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED92F7E0E86
	for <lists+linux-spi@lfdr.de>; Thu, 18 Sep 2025 16:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02BEC31CA77;
	Thu, 18 Sep 2025 16:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="FsPVYYxJ"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E78831CA52
	for <linux-spi@vger.kernel.org>; Thu, 18 Sep 2025 16:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758212543; cv=none; b=W2fnCotSh0Os8EgBbQrUPNzj+r/kbyGjDhDvCARUYvGDjFllfGBNJdT1n8XwhHMjEuS7Cf34mxqwEp+adY8L2nV7nxQYPE4ltoxVPi5xfWdNUMkuwQ48JioVCIxpHp9QIUBH/Fc9TNVHzOUs4MlKlqtYWxbP/tEXzLZb4Vw7GIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758212543; c=relaxed/simple;
	bh=+crtDq0mXabYH2Lz3fi9Mlu1oIxDcHVi/vLFzRBDDfU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PPeKIRimAPXiqZ2KzLfAdW8+osu1IB92xJbc0qbCH3SLevSWiN1ZZY/jGOiJM2d7Ab8Vw0CQcctAYlvpci6FaD99BNuoezhjA16zL8D5MYC+aJLjZPWt2bgk2EA26AG+V/A/0X+T6bjtl2cT784qWVgbl7QWHsa+mpeL8jGtpmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=FsPVYYxJ; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-4240d243340so11262185ab.2
        for <linux-spi@vger.kernel.org>; Thu, 18 Sep 2025 09:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1758212541; x=1758817341; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AU2OV7gY++1HQBPAJUTGEHGKnym698Yje6WiyRPMWQ8=;
        b=FsPVYYxJJc7IbN+TMrre+0X+FtK8k6fOXwv/Sy3L7/F0SjY9S4UBu/LSqMlNDZ0i57
         SQPoBDnTjPjGMX5hsG62DIZ02wZNBdo0PtvA+/datmg0K7aQfaYT8at4UyPfNbtXYBIA
         OPO3ZvpQ3KFnCTi6ssuok1FutnhgsbFUwU4rPSjyB6yD+oWIVqkXZHl0WI8YjWD/GPP5
         H7WZEjlFIk7hgbyDGSFeYRHBn1oUmCdZiB/zCaSXNkXFxvYEC1s0A4TtgsPQuommz4u6
         LxgqL0rqQ++KHQ+98T9ImS5YmfbGyVaSHM+4hzTaXpxA8AvFN2i2SfGzSGVgI0MwebKS
         FgqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758212541; x=1758817341;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AU2OV7gY++1HQBPAJUTGEHGKnym698Yje6WiyRPMWQ8=;
        b=kuUgRlPNjjx8p1V8lzul5SeiyGSg8EEjv2GSZH5sBxgQt/E/HZqUNpxuBvmQBlAzRn
         ZDw0tMaji882bGArv5VPnj8TsXoSHOYSgKuDQwD9Oh8VgtfCxU+qFLFjG9UBro+BUMMa
         oNlCt+vRmb0L72/1ipL+hY3bxcFmef9sHCNQINsQl2bFcf/8BQOpwW1jK8NOoJiPxHbN
         Gvndpst1WvKCWuFlA5KJVHfg7wOi+e/Nmm6MZbeLfoqwv4NbHaLJbiwicCMgWqYA8jSZ
         zydwcLI4C/TcGB08NdXjFAzDYrkVVOL4hY3LCPOPcd7gsuv3uu5QiX02tmYKN1uSCQ8x
         NS/w==
X-Forwarded-Encrypted: i=1; AJvYcCVk/ctHBTz1g+wJ6uzAtAPGZvOI5GGR3jYKSj4VkYv/bSta6zRp6i0ZM3y3ceCZPzbPCZMx4qlYK9c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKiht3MEHaSVKhQYPovXDThvVMl1CLCIjbvzVd4xfHCqHna3t3
	AwxuJzKSU861k9/9AyDVH0pW5+XD7EhbKd6huj8KYEXf3T/WY9j/UYgZmtF3w1yhWTs=
X-Gm-Gg: ASbGncubYz0+N8tuaiXR9JXWF/9c1JsTE7Lx0vDncRNcyZvE5uqAe9MoaThP2a82aOL
	nMgHrOHNMEVfr0pN5NS1qRG5SPOtnNTr9+6Kfiy0FXesqxCnWPjVGqzjMCPjFy4R+vqUaA8nWwF
	oFe49WbKNHRtGvZ4cj7dW3ZO8viquTNyqfF7nZNyx2SZOjLVysoZ46pbtzxNCgHUHrC/IbxvwFA
	DDClC+7Pki3u3r515aFF8jWPvUawZC+Ld5Tk486m/rOL0Fu9xkE2aLzmdlOXtc9x/G5zMBGtr7b
	s4zXJw+0FaWKdpyTh/CMfh/8KtxLUnnCg3ZZvhdP4zQ/3UEjYfNdU+MtZXjQBWiIoa/yCICh5re
	H7Rs9clK4GKb8eoRk5J+0wENdYr24Cd5cpSZsjBlqSaxPB7WcK3rnSzdx6pur7rFdEx/3pD1uqr
	Us0+Sb7Q==
X-Google-Smtp-Source: AGHT+IEJA379jBFlrQdMuZZ7GAQYUyd69Hmjw5o+yqSb0aHO7CoUDX+AkO4upDsCoz0J8wxrQujxtw==
X-Received: by 2002:a05:6e02:1b05:b0:418:aefa:bb83 with SMTP id e9e14a558f8ab-4248190b442mr2732905ab.5.1758212541014;
        Thu, 18 Sep 2025 09:22:21 -0700 (PDT)
Received: from [172.22.22.234] (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-53d3e3373f6sm1110059173.29.2025.09.18.09.22.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 09:22:20 -0700 (PDT)
Message-ID: <5a8364e4-3160-4459-9db4-c9d877ba8c6e@riscstar.com>
Date: Thu, 18 Sep 2025 11:22:19 -0500
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] spi: spacemit: introduce SpacemiT K1 SPI controller
 driver
To: Yixun Lan <dlan@gentoo.org>
Cc: broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 alex@ghiti.fr, p.zabel@pengutronix.de, spacemit@lists.linux.dev,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250917220724.288127-1-elder@riscstar.com>
 <20250917220724.288127-3-elder@riscstar.com>
 <20250918124120-GYA1273705@gentoo.org>
 <034cecd3-c168-4c8d-9ad5-10cc1853894b@riscstar.com>
 <20250918143928-GYB1274501@gentoo.org>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <20250918143928-GYB1274501@gentoo.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/18/25 9:39 AM, Yixun Lan wrote:
>>>> +	ret = of_property_read_u32(np, "spi-max-frequency", &host->max_speed_hz);
>>>> +	if (ret < 0) {
>>>> +		if (ret != -EINVAL)
>>>> +			dev_warn(dev, "bad spi-max-frequency, using %u\n",
>>>> +				 K1_SPI_MAX_SPEED_HZ);
>>> the err msg does't really usefull..
>> You mean there should be no error message, or that it
>> should say something else?
>>
>>>> +		host->max_speed_hz = K1_SPI_MAX_SPEED_HZ;
>>>> +	}
>>> so in any case, there will be an assignment, I'd rather simplify it as
>>>
>>> 	if (of_property_read_u32(np, "spi-max-frequency", &host->max_speed_hz);
>>> 		host->max_speed_hz = K1_SPI_MAX_SPEED_HZ;
>> I add the warning so it's clear we're using something different
>> than is specified in the DT.
>>
> I personally do not really care about the msg as long as there is a known good value,
> but you could weigh this..
> 
> further I feel the warning message isn't accurate, if spi-max-frequency is
> "bad", why not let user fix it? does "bad" means invalid or overflow?

The reality is that this is a property in the DTB, so it can't
be "fixed" by the user.  It defines the *maximum* frequency
that this particular controller (on this board, or possibly
limited by what the SoC is capable of) will implement.

Stating that it's "bad" seems enough, given it normally can't
be changed--and we will use a sane default instead.

It might helpful to indicate what the bad value is, but that
complicates the code ("bad" could mean the property was
specified without a value too).

> I don't want to have bikeshedding on this, feel free to pick my suggestion
> or keep yours, there is no much real difference

I plan to keep the code as-is.

I don't actually know whether the limitation is on the SoC
or the board (or even whether it truly is the upper bound).
I'll ask SpacemiT about that.

The default value is expected to work on all platforms.  If
If it's specified at all, it should be done in the board
file (so it won't be in "k1.dtsi").

If I don't learn of specific constraints, I'll omit it in
the DTS file (it's currently unused).

However I *will* add some new code that verifies that the
value (if specified) is within the SoC-supported range,
which is 6.25 Kbps-51.2Mbps.

> thanks for your efforts to work on this

And thank you for your review feedback.

					-Alex>
> -- Yixun Lan (dlan)


