Return-Path: <linux-spi+bounces-9238-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCCE9B163CC
	for <lists+linux-spi@lfdr.de>; Wed, 30 Jul 2025 17:38:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0064A566C8D
	for <lists+linux-spi@lfdr.de>; Wed, 30 Jul 2025 15:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A367298CD5;
	Wed, 30 Jul 2025 15:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m1j+qiPF"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574BF2D6406;
	Wed, 30 Jul 2025 15:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753889891; cv=none; b=Vh9+RatZdzxfM5wyvCjXuDFTUu36r44EBgEAeu7OeUa/3oqWC2DwehRlacL93e42nrHlu/WqNnKJcbTutrLVEhEV6EF9ye2rEzz3mGliddrF+XE0WjOKSkasUc6czAF5kU7f/Wi/i/nKwoAJuJF53b2N9GLzPMPUvoJbZ9C4kfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753889891; c=relaxed/simple;
	bh=wjsLnA+PCQ4p5GofT9PAJz+jbiKa8aiRv5XiTBLP11I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RuP4IrvOpmEr7/Dw+g6iO9pfWrnwxP325DFP3RionXmM448BC8KnCKretsQ6m+Wju7ErzNjlfBeXAGYJ/9E9EEKU3YqPxepyGm17e8rgNT+al4ezenMjn9TfeOnbD9HOfGWL93/Zt7WrebwlAGYCxzMc/Ak5MQUBaQEOO58KpV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m1j+qiPF; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45555e3317aso32118835e9.3;
        Wed, 30 Jul 2025 08:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753889888; x=1754494688; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h8wcdzaaJocT90oXdQyNsOGdHRF6PjEabIQP8yYPyOU=;
        b=m1j+qiPFuykuOx8FCJPZJ+ETsYS/i+bg07I2oiQ7g8bNnMdGU6DocWBrlIprovOWSn
         WIlyzKUrnp+azoLUVDrr+OD1gvD5zqLQYuXj+hppPSajt9VLd2rvoW6dLU9pmgi2opc4
         epEQAJ/UCQ7/r8Cuoc2mkfG5aEGMt2+6BaZhKtfaOYz7modYZkIM043zUhRRJPfiTWSF
         xUHnzkF3hDK4IANGgiy+LlJcHp+cAIn6yhqdzbURr4BcXfa9WUP05cYt0alLW71AVvgb
         +qUFO8yVxnlxS6wm9345k6w6vbbwwtf1nqUEhiZVbKeB6KkQWYaVbyUFsrqT5UieBroz
         xumw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753889888; x=1754494688;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h8wcdzaaJocT90oXdQyNsOGdHRF6PjEabIQP8yYPyOU=;
        b=bnBhMxgI38LIx+vEHnvrWy7WC+jMMqrehAtSyDw//fg6gp3/CSHu7/ri2H/LMUDThD
         SRugUo6zUATXiwN4KwAKXykqsx2U7GTP0Mks332ny6O+VLnTbs9/HxESxg0GYA01W9Gg
         aJFBcAw/HJttNPwJyHBRXqmvMZ5MBeW5AM8FIMmOuuq51svg89dQKZre38NhGBq/dX+v
         f5gHNZGJ8azkxM97xOoI5vGH4kzcQ/FYkJEw6UCYcG1wujIIK6jWgTQYRcuEjtkrGVS9
         I6uS6kQkOnNiGxD1ikWUoTou+UeRcoVYWdTRUsNNi3BXqbtvKw44Z7Ifd3FlFzM5Um5H
         nqsw==
X-Forwarded-Encrypted: i=1; AJvYcCXIX4lRNtGlu9S7nEuBIYQRMaUm8VCZvOEK/O2XyMqqiorxFRDyZ4quyi630kwdeAuAdMuU401pWXOY2eQ=@vger.kernel.org, AJvYcCXZKaN744OD3FJVNqf6aQjvYffqY84O04TlAbo2KEwMMfoZ3XHdGQH92E60JHCkRAPyzS/BHAJ9jCwY@vger.kernel.org
X-Gm-Message-State: AOJu0YxorqXArcDObFJQea7C2xIhRoapS7aipJwqIl4SyIf+B5TP26iH
	S1ZAj/w0AEnRp5aQmz8uZ5YD4GdC1jamkN/FN4FbZbE2Zm9bSU6/cLi2
X-Gm-Gg: ASbGnctD9EWoqkPvTwpSnGdK9y68LvD/oWUZzlxqNLskSgDSBiCayYej1FlTCikPzFx
	n5M3XEVNhJiWUyedt9dlft20/1EcVar3YnpHI76IC14Cdb9rUzxJw75ZdVu+GNbRRwf/n+wsh9Y
	4u5YsIUCakodQHIk6YQjccMZ2/Wg4F+mkclj9dCozTgSe6Ib8F+Z9Rutrxzrl9vjFmdfODPzdVa
	+oLTlRv9wb8zODFxKGmnibaR7gyQP3521mCBcfyqa0bBYOsghzfLfaqzzIpqOZkKRaai7IrdiLZ
	4ZTsHLGpRsT6zQO5RuUv4jzVdDFMKx6Re/X6VQzM2f1PDmRgqNewcjgZ4lqevqnJzGxhx9ObhAH
	Q4+60TzHmuO/w9QHGS6VkNQPkTMoyDW5wN8yDvel718nOkaNdTmwnrIx7FV7FVTwdvGI=
X-Google-Smtp-Source: AGHT+IFQlDS1adRzkZyioOfFow8Qx/jaTs52VlzWZUs78UZ35ZH/lLgEP/JH9vimbl/nssKJpelqXQ==
X-Received: by 2002:a05:600c:c0d1:20b0:456:161c:3d77 with SMTP id 5b1f17b1804b1-4589301f9famr24925175e9.16.1753889887346;
        Wed, 30 Jul 2025 08:38:07 -0700 (PDT)
Received: from ?IPV6:2001:861:3385:e20:6384:4cf:52c5:3194? ([2001:861:3385:e20:6384:4cf:52c5:3194])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b7819039efsm14462012f8f.11.2025.07.30.08.38.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 08:38:06 -0700 (PDT)
Message-ID: <b3395812-6000-4e23-9b25-dbbc97547acd@gmail.com>
Date: Wed, 30 Jul 2025 17:38:05 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: st: Switch from CONFIG_PM_SLEEP guards to
 pm_sleep_ptr()
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250609-update_pm_macro-v1-1-819a53ef0eed@gmail.com>
 <CAMuHMdX9nkROkAJJ5odv4qOWe0bFTmaFs=Rfxsfuc9+DT-bsEQ@mail.gmail.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?Rapha=C3=ABl_Gallais-Pou?= <rgallaispou@gmail.com>
In-Reply-To: <CAMuHMdX9nkROkAJJ5odv4qOWe0bFTmaFs=Rfxsfuc9+DT-bsEQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 28/07/2025 à 09:35, Geert Uytterhoeven a écrit :
> Hi Raphael,
> 
> On Tue, 10 Jun 2025 at 16:59, Raphael Gallais-Pou <rgallaispou@gmail.com> wrote:
>> Letting the compiler remove these functions when the kernel is built
>> without CONFIG_PM_SLEEP support is simpler and less error prone than the
>> use of #ifdef based kernel configuration guards.
>>
>> Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
> 
> Thanks for your patch, which is now commit 7d61715c58a39edc ("spi:
> rspi: Convert to DEFINE_SIMPLE_DEV_PM_OPS()") in spi/for-next.

Hi Geert,

Did you mean commit 6f8584a4826f ("spi: st: Switch from CONFIG_PM_SLEEP 
guards to pm_sleep_ptr()", 2025-06-09) ?

7d61715c58a39edc ("spi: rspi: Convert to DEFINE_SIMPLE_DEV_PM_OPS()")
points to another reference, authored by you. :)>
>> --- a/drivers/spi/spi-st-ssc4.c
>> +++ b/drivers/spi/spi-st-ssc4.c
>> @@ -378,8 +378,7 @@ static void spi_st_remove(struct platform_device *pdev)
>>          pinctrl_pm_select_sleep_state(&pdev->dev);
>>   }
>>
>> -#ifdef CONFIG_PM
>> -static int spi_st_runtime_suspend(struct device *dev)
>> +static int __maybe_unused spi_st_runtime_suspend(struct device *dev)
> 
> The __maybe_unused can be removed, too...
> 
>> @@ -429,7 +426,6 @@ static int spi_st_resume(struct device *dev)
>>
>>          return pm_runtime_force_resume(dev);
>>   }
>> -#endif
>>
>>   static const struct dev_pm_ops spi_st_pm = {
>>          SET_SYSTEM_SLEEP_PM_OPS(spi_st_suspend, spi_st_resume)
> 
> ... if you would update these, too:
> 
>      -    SET_SYSTEM_SLEEP_PM_OPS(spi_st_suspend, spi_st_resume)
>      -    SET_RUNTIME_PM_OPS(spi_st_runtime_suspend, spi_st_runtime_resume, NULL)
>      +    SYSTEM_SLEEP_PM_OPS(spi_st_suspend, spi_st_resume)
>      +    RUNTIME_PM_OPS(spi_st_runtime_suspend, spi_st_runtime_resume, NULL)
> 
>> @@ -445,7 +441,7 @@ MODULE_DEVICE_TABLE(of, stm_spi_match);
>>   static struct platform_driver spi_st_driver = {
>>          .driver = {
>>                  .name = "spi-st",
>> -               .pm = &spi_st_pm,
>> +               .pm = pm_sleep_ptr(&spi_st_pm),
> 
> This should use pm_ptr() instead, as spi_st_pm defines not only system
> sleep ops, but also Runtime PM ops.


Anyway, that is indeed a good catch.  I actually got lost between 
CONFIG_PM and CONFIG_PM_SLEEP, which is now clarified.

I made a fix, but will send it after my summer break.

Thanks,

Best regards,
Raphaël>
>>                  .of_match_table = of_match_ptr(stm_spi_match),
>>          },
>>          .probe = spi_st_probe,
> 
> Gr{oetje,eeting}s,
> 
>                          Geert
> 


