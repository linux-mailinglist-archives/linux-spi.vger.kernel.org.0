Return-Path: <linux-spi+bounces-10573-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6716BCF587
	for <lists+linux-spi@lfdr.de>; Sat, 11 Oct 2025 15:09:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76862406B4F
	for <lists+linux-spi@lfdr.de>; Sat, 11 Oct 2025 13:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 757F926AA93;
	Sat, 11 Oct 2025 13:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U85xZFnL"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F75253944
	for <linux-spi@vger.kernel.org>; Sat, 11 Oct 2025 13:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760188156; cv=none; b=iya9PRDCsK3TQFL2PvDDVwGDPQJZr46axMmJv6Q35pfWsRtVIhoXF5Qu3gTSZgsgM986UnF28hCIcFK6cn6e1uyAUx5hb4IoeqTBba8VHZw5dgSpR7iNolr93ozy3HxoPL98qZLCo07f7VSUiOh6UevaSKTsBh04axpanUtG1Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760188156; c=relaxed/simple;
	bh=tlkJwfNU1cVCPDhRsrqFR+Vps9eI4PoV/Fx5dERZ4Hc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q6iGqubK00nbeHdocs2ba1uFPIdTad1PB1G8N7pGVa4jnjg+z1TEunBWiEJ5JPQxqTuE3ZKctR2pV0dQgWWbh8OgMxcnaRZJUkIiZtAtGpv3JAB1ZDY3SMOyBEsKYwMuue1FICEJDpQ/9w+nMoFWJ6LhwEqHdrmXV1xHEc9WAMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U85xZFnL; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-57a604fecb4so3749701e87.1
        for <linux-spi@vger.kernel.org>; Sat, 11 Oct 2025 06:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760188149; x=1760792949; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yFqG+W0h7HPgIYyh4oB9VLKX2QzoB0wmqumVtSZ2KnI=;
        b=U85xZFnL/s6LyNi08VC2ZWFtDhecXGC1aL+t9r7B2Q80j5EslV56CuZ0OpnAFYOfR0
         3hZqWXVh6NaixA++Q+mnu039jKqlgvlphyl6eH0eNxNct3kGGfr8hQJf9jATsoFMn+PJ
         USSJ3+juxDZNAO/4qvA8qIcIogcEFIwWpNtVTOSHgYsD+s3W5oqzqXHc738H6e5wKTB6
         SMMBa9KycRuaZUedtMI+mDZ/oRRIOBmAC76wwVwn1Nj1uSTjOaeevHLf/Fh7Bm51CMp5
         kQ7GSaXZycPp/CrTTkXcgrf5pMbynuFEv2R9dLSzh7NhuucdWXQzRD6+OHsREK/O+HdI
         dOxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760188149; x=1760792949;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yFqG+W0h7HPgIYyh4oB9VLKX2QzoB0wmqumVtSZ2KnI=;
        b=MI5SUvgNy7r5qMfjdB4iwuYqouRqZ/bAV8aJxfVTM6Xatybc1r4909ia8FzW2gTw1W
         wlMgzVo9J8mfsfLCU1a+/WQDH8WtBuV77PCOquujT6MjlTyWckU7se5IQl9eF5FQQ+1G
         5IDdID5CjuWUQaS0D/62Vm1tua9Fy2UAtZ1xiuAolv7UgRh8SPdt7iV+X9a7u9Jvs5ev
         EBuXdBnt4tS+06CxuteAvHgn+BYb1molcEjc5jSJfepWwD/EilUVpJ6wImM0B93Zt8oK
         k+JcBNw7kzvDJvUZFR3FAvvSRgJBBzfko7mvwQpYDaInKqoJqXrmUDi3jkv35A15TUOh
         M8AQ==
X-Forwarded-Encrypted: i=1; AJvYcCXp/4RvAh6e71fDjaOHRylaqJojv6oVEMMblXPVSK7/DVRWCsdTFgh9thaUArrwA6dHrBxv2A6xogs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTZsVnLDVERKa4f5xOlqk/y8OmokPMXcEvwCDgbQIG1Bv6rSiZ
	SzKAnhIbCE417BtQmS1p1aVxx1rzAXW9l3Lb0r860kC2sHVfE3IMw9mO
X-Gm-Gg: ASbGncvMzFDShlLucg2ENCSTZtVwbfbGPRXS0bM58jX+R4bqHOlVloPS5oFSFG3R13T
	Xisp3Zk4GBNsAQr/3+vRR3EFjzH7qqpdd4xMKmk/KNocC0fpm99bZkzKzoA7FuLZ5DLDeNgGglS
	O/xNcEphZe1LP+MMhTd3Vb2TW45Aox8kCu+kY2USzTCHfjSU6ZCrDHCYzlPF9XLk8PoViO2BbBB
	6WxmMAAqOogw/AXRNIfhjZT1FlY8kNUgTEQKO5hlp25PyYLuYwlX7opO5ZPQ0inqHliX+YlfxRJ
	Ni6ZLPGw8MAIF8b0BYRhmLWsMSCyxRCxHVvxYcdAb4oWquemBQ+dm26GBOdf2WVnSu8sAMVu6k+
	NYL+RqG9wOAplXaRbCZ+C8Fc38ObYu8o00YZkJPljyyja48MJl+2zvvpNq4gz0BJn
X-Google-Smtp-Source: AGHT+IEsd2dh3b7ZCBcS7C11Y+DmJop0Y5QgiZQ50QcK97YSeU7ZYKZ8b42eMZzoz9RF9b0Cs+MNcw==
X-Received: by 2002:a05:6512:1246:b0:55f:4ac2:a597 with SMTP id 2adb3069b0e04-5906d87babamr4379026e87.7.1760188148525;
        Sat, 11 Oct 2025 06:09:08 -0700 (PDT)
Received: from [192.168.0.131] ([194.183.54.57])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-590881e5790sm1919616e87.19.2025.10.11.06.09.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Oct 2025 06:09:07 -0700 (PDT)
Message-ID: <5d8ec4c3-1b36-470b-a1c7-629060a154ce@gmail.com>
Date: Sat, 11 Oct 2025 15:09:05 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] leds: add support for TI LP5860 LED driver chip
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>, Lee Jones <lee@kernel.org>
Cc: Pavel Machek <pavel@ucw.cz>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Steffen Trumtrar <kernel@pengutronix.de>,
 Pavel Machek <pavel@kernel.org>, Mark Brown <broonie@kernel.org>,
 linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250911-v6-14-topic-ti-lp5860-v3-0-390738ef9d71@pengutronix.de>
 <20250911-v6-14-topic-ti-lp5860-v3-2-390738ef9d71@pengutronix.de>
 <20250916153412.GA3837873@google.com> <875xd0jslv.fsf@pengutronix.de>
Content-Language: en-US
From: Jacek Anaszewski <jacek.anaszewski@gmail.com>
In-Reply-To: <875xd0jslv.fsf@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Steffen

On 9/30/25 09:40, Steffen Trumtrar wrote:
> 
> Hi,
> 
> On 2025-09-16 at 16:34 +01, Lee Jones <lee@kernel.org> wrote:
> 
>> > +#include <linux/gpio.h>
>> > +#include <linux/led-class-multicolor.h>
>> > +#include <linux/module.h>
>> > +#include <linux/of_gpio.h>
>> > +#include <linux/of_platform.h>
>> > +#include <linux/regmap.h>
>> > +
>> > +#include <linux/platform_data/leds-lp5860.h>
>> > +
>> > +static struct lp5860_led *mcled_cdev_to_led(struct led_classdev_mc 
>> *mc_cdev)
>> > +{
>> > +    return container_of(mc_cdev, struct lp5860_led, mc_cdev);
>> > +}
>> > +
>> > +LP5860_SHOW_MODE(r_global_brightness_set, LP5860_REG_R_CURRENT_SET, 
>> LP5860_CC_GROUP_MASK, 0)
>> > +LP5860_STORE_MODE(r_global_brightness_set, 
>> LP5860_REG_R_CURRENT_SET, LP5860_CC_GROUP_MASK, 0)
>> > +DEVICE_ATTR_RW(r_global_brightness_set);
>>
>> How is this different to /sys/class/leds/<led>/multi_intensity?
>>
>> # echo 43 226 138 > /sys/class/leds/multicolor:status/multi_intensity
>> red -
>>     intensity = 138
>>     max_brightness = 255
>> green -
>>     intensity = 43
>>     max_brightness = 255
>> blue -
>>     intensity = 226
>>     max_brightness = 255
>>
> 
> the LP5860 has a register for setting the maximal brightness that holds 
> for all LEDs in the matrix. multi_intensity and max_brightness is only 
> for that one multicolor LED, right? And I can only manipulate the 
> max_brightness of that one multicolor LED instance.
> If I'm wrong, I'd be happy to not have to add the sysfs files.

It seems that this device is similar in the aspect of LED grouping
to LP50xx family. There is already a driver for that one [0] with
related bindings. Grouping solution could be addressed similarly to the
banking mechanism in that driver.

That of course means that this patch needs a significant rework.

First thing that strikes me after analyzing datasheet is that
LEDs are not assigned to any group since LP5860_REG_GRP_SEL_START
address is not referenced anywhere, and this is base address for
Dot_grp_selN registers that enable affiliation of the LED to given
group. No need for global brightness setting then.

Anyway, I'd add proper support for this device with DT knobs
to enable both grouping and individual approach to controlling the LEDs.

Driver [0] should serve as good guidance for that.

[0] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/leds/leds-lp50xx.c

-- 
Best regards,
Jacek Anaszewski

