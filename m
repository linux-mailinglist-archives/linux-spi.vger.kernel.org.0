Return-Path: <linux-spi+bounces-10197-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56366B8E393
	for <lists+linux-spi@lfdr.de>; Sun, 21 Sep 2025 20:59:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25B851895027
	for <lists+linux-spi@lfdr.de>; Sun, 21 Sep 2025 18:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 494E72727FE;
	Sun, 21 Sep 2025 18:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="oG8dLISu"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833B92367D1
	for <linux-spi@vger.kernel.org>; Sun, 21 Sep 2025 18:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758481135; cv=none; b=YT1EMBpAUy4P8XB+LVxHfdfiaGfdY4e3MdBuK2RKNh59G77tNSQwoZ9k47CJd1hevRFUz60pk6+/DRWgqi1LRmA8BVNT9m2YEuKYCOAF/M4RB/Z7KEL9HmkRAx97TD0J00ddbEda5ysMFFmfaAu/aynaHGc+bNSYqqkuQ0slMGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758481135; c=relaxed/simple;
	bh=w8WpeZPhF8DveCAu9nZH5IdpjTp7dXBeqPT5tY/beCM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rf/pLVyeWOBfSMlXfrzvqfgJF87484uMIUMKgK6/qxLaF4XpkH+o0B+ijejtiZxzRSOWGQMDfaezuGDTS/gqPQi5b2hP6hW4uj2jwkcPbsJD4+BukkLdGytH4Mcy+xQC6j1c8CcuybCiQ/uh75VP/3n9QxKGfSSxqzIUdW7YNtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=oG8dLISu; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-42576a07eeeso4626575ab.0
        for <linux-spi@vger.kernel.org>; Sun, 21 Sep 2025 11:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1758481132; x=1759085932; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t3yODI1opb0jOanIEDnISA0XED16oP9HRbOj2aYoSYs=;
        b=oG8dLISupdvSAsUh2Q6qT9JrEzRd4z2cy1p3YURvLlM5oZ2343UEh9lXw56LfCATke
         4g/DkrrcqWH3siH578qnZwIEZty6IXiDJvAAaVNEDNfh3cgD5UahFuvspUbXMnUmcQLw
         bsyJUlvIW6oGRXTsxfjdd6GikjNmFPyMt/u89L+4f4kgydhhGdiNEVIGgRwLpXAZNBFx
         TYKaiJY/czVmNdxjrWXNlh8YhJcwZaGO72Q+3AtZjbnE/X92tC/xZZsdlM9eMqlX9F5W
         2oVh2aclkyk5o93puTK3A5PasaXxFc8ekEBQ0wn4zovTDmJAMb/OiHreaeF1YXBFi3Cw
         WhJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758481132; x=1759085932;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t3yODI1opb0jOanIEDnISA0XED16oP9HRbOj2aYoSYs=;
        b=oQw47GuOnO/uKIgNTPq33I+78k+8XTH+OrUL+algRP7/bkRgIy9PiZJYXoZAWhXNc1
         exiKRfgB9tFb1H+1dyzn463KcCWmFUBVa+O1r3jA8As3cyK8qmSthaMPnHjpQGOqtlE4
         ZSEGU7URXVtW7n83AC81PPQqwJTZW7anzD7pmux2447fe4ReVMfjGaCfvzkK/jKylKUV
         RySL8etA+xe6mbi8S9fK+AIEtlHw3JrgL1atULiEBpC+1DWa5sqVgY4OaPMy3sQHGxg1
         DwpOuz6cJNdce7Difk0NvYt83jZbR927yvRQsuA/esktS7MQgdqJCpnq4wAqluq5jX6y
         2U+Q==
X-Forwarded-Encrypted: i=1; AJvYcCU8Ez8UNimzd93fbUujJy5OWqPwfmlhxeRk6UZ3BiRvs4n38ffPgH+dRbOf5jmpcDWFMiL5JXmwrO4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiJwVaYnCVdO4AyWFA6msJ/d+m/8+LLBZluBHvcBBc4+6oPvyX
	4LAmLCszL9oenwRHe8I41sCDEFmoY/4XXsLjUl5zwCURhmqZ4ixF2JQd/hqIEe7lEq8=
X-Gm-Gg: ASbGnctUvhFHPaZpfQ4dOlqlb6yrGWxe0Ns2KB3e7SS9DfB3DIOMvZBzj8oU64Dr5UX
	gF1Uz7w++Lm5Fm7QGjkKSZaqx8YdNff+aOly80ZxqbotdpoOvXP0VmqFyG0KxZfGOlXVJoyUOvd
	zcEM/czGkVa2qk7yISTfXinuupx8XJ7joKhcRXBmcplq7Yql7PjaWJhy6maHif28V8L3t129wjL
	nO+5Lk9nSd28WwyNO2SjcxsgjVntza3N95CMpVBmz1BZbOCVR2x8Z2NoC0tREggaUxANYVyIlKM
	qs1TOOIP3bcex+YoU6QecNWJA9DNuiyJ/2PrM6GLwSG4AdsmqXMOr2n9cLJJUCLGOM9LTiKDGYi
	l0fVrpcOWrruuKa/2G5IN8OE1qAkQxRdMYBCU0kcfduV5dPVB3Q0F5UO8VJ5qIF8Yua1TbHE=
X-Google-Smtp-Source: AGHT+IEFYJsSo8XIdBpCssdirvu4z8vm7oDZUP42OyCCbdIOLRYBgINTidn4zPRPHizJvfN5lbHIOQ==
X-Received: by 2002:a92:ca09:0:b0:424:ed48:9acd with SMTP id e9e14a558f8ab-424ed489bb8mr86349525ab.27.1758481132441;
        Sun, 21 Sep 2025 11:58:52 -0700 (PDT)
Received: from [10.211.55.5] (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-4244a36aa66sm49663255ab.8.2025.09.21.11.58.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Sep 2025 11:58:52 -0700 (PDT)
Message-ID: <84c77e62-93f7-4a3e-8a86-7f653076bdcd@riscstar.com>
Date: Sun, 21 Sep 2025 13:58:50 -0500
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] spi: spacemit: introduce SpacemiT K1 SPI
 controller driver
To: Vivian Wang <wangruikang@iscas.ac.cn>, broonie@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: dlan@gentoo.org, ziyao@disroot.org, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, alex@ghiti.fr, p.zabel@pengutronix.de,
 spacemit@lists.linux.dev, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250919155914.935608-1-elder@riscstar.com>
 <20250919155914.935608-3-elder@riscstar.com>
 <a7070f3f-8857-4834-9e9e-02068637075c@iscas.ac.cn>
 <3c9aaa62-f685-47f7-a21c-00f51550f185@riscstar.com>
 <411ade91-3fb5-40a3-baca-e6b03c5783ae@iscas.ac.cn>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <411ade91-3fb5-40a3-baca-e6b03c5783ae@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/21/25 1:51 PM, Vivian Wang wrote:
> 
> On 9/20/25 23:59, Alex Elder wrote:
>> On 9/19/25 10:52 PM, Vivian Wang wrote:
>>>
>>> [...]
>>>
>>> +static void k1_spi_read_word(struct k1_spi_driver_data *drv_data)
>>> +{
>>> +    struct k1_spi_io *rx = &drv_data->rx;
>>> +    u32 bytes = drv_data->bytes;
>>> +    u32 val;
>>> +
>>> +    val = readl(drv_data->base + SSP_DATAR);
>>> +    rx->resid -= bytes;
>>> +
>>> +    if (!rx->buf)
>>> +        return;    /* Null reader: discard the data */
>>> +
>>> +    if (bytes == 1)
>>> +        *(u8 *)rx->buf = val;
>>> +    else if (bytes == 1)
>>>
>>> Typo? else if (bytes == 2)
>>
>> Wow.  Yes that is an error that I'll correct.
>>
>>>> +        *(u16 *)rx->buf = val;
>>>> +    else
>>>> +        *(u32 *)rx->buf = val;
>>>
>>> Maybe
>>>
>>>      else if (bytes == 4)
>>>          *(u32 *)rx->buf = val;
>>>      else
>>>          WARN_ON_ONCE(1);
>>
>> The value of bytes will be 1, 2, or 4, which we can tell
>> by inspection.  At one time I had a switch statement with
>> a default, but I decided to leave out the default, which
>> won't happen.
>>
>>> Just to make the pattern consistent? Same for k1_spi_write_word.
>>
>> Consistent with what?
>>
> I was just thinking it would be clearer if the code states clearly:
> 
>      1 -> u8
>      2 -> u16
>      4 -> u32
>      anything else -> shouldn't happen
> 
> As is, it wasn't obvious to me that we're just handling 4 as u32. Maybe
> we're just capping it at u32, and 8 is also handled.
> 
> Well, maybe I'm just not familiar with SPI stuff, and word size above 4
> doesn't make sense anyway.

Understood.  I only know it because I checked.  And I do want my
code to me understandable, so I'll add a comment as you suggest
below.

Thank you.

					-Alex

> 
> It could also be a comment
> 
>      else /* 4 */
> 
> Just a suggestion, no strong preference from me.
> 
> Vivian "dramforever" Wang
> 


