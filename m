Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 881321E8626
	for <lists+linux-spi@lfdr.de>; Fri, 29 May 2020 20:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbgE2SD4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 29 May 2020 14:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbgE2SD4 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 29 May 2020 14:03:56 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D80CBC03E969;
        Fri, 29 May 2020 11:03:55 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id be9so2417331edb.2;
        Fri, 29 May 2020 11:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SiB7HET2dLvdlmmU4DX5gmb+mL1M6obOE7qdN1rHGNg=;
        b=g+JcM8esIk55PDKHgHqGEM5/WOea6axPRjT/TyFWtQH74h7F/44gAtRFeRLdQv6t60
         vIkf0wIjSsTGP/rlmlMelaPjtWGN5PLa14LT54AI3xBLGXmmixkmqXdefLForDXQH6Ia
         Lbc6l0VVpnjfj7Gm/OdnjnrtQ67JYXo62mtUW2XVxM+Dio4+NhuQsaGK05S1NmD2hmPZ
         AD5IZsqvgfYZ6eij0ie/rR4l52Y8lTGzV2eP0HoGebb9AUDG0IeNAq5HwhiGleVf8B9i
         IBxbveYCUrbKTOCuOmgsAQkwTFu5qqx8dPa6Hh8m11Cfu+1K6Y0JUCGmHXiwvAT8YjzU
         lrGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=SiB7HET2dLvdlmmU4DX5gmb+mL1M6obOE7qdN1rHGNg=;
        b=A1CEfsUGgihFKwYaCNiKnKrxf2a+CPSqyELHRxX50Lj0s9sraTUhDdNgIQhK1gwaH5
         XIC+NNCNj46xDM1hKbunlYO8+oNEdbrE9gS7LNWKHit35C/VBrGysx4duMJnFId2d1Z9
         ImFz8vUnTr0uW8y+7/CDKTRZmnamn+I7XPeCr+qG24fRgBqwZW8RpKvVWvH6ei8gWUJk
         rrEKHwMxE7r/sUvuneWR8gZswy6a6k5F+4/bOL05st/u8DzH/FnJCPi8gwdeIXCtYc5+
         ujl4Yvy5mjSGr6azd/2V+/nDYxxV7fmnjFoH+CaHUvieVwRMfQw50JY4FB4hkSRO18yj
         ejdg==
X-Gm-Message-State: AOAM531ctOEXOOJfJoIwObIHz2CdGbPyeaq8SAQ2TaIZDt7/lgSrmxJD
        LRFwLjbcLNwtUmT1PLKYIfc3TF49
X-Google-Smtp-Source: ABdhPJyG9pcq/VJyek9MK7/FBu1uPl148Z7dAaldQ9lOzZIAObImvzjo5Nlt2tKiVYIKXxkyvD09iw==
X-Received: by 2002:a05:6402:1cad:: with SMTP id cz13mr9717939edb.56.1590775433876;
        Fri, 29 May 2020 11:03:53 -0700 (PDT)
Received: from [10.67.49.116] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id m3sm7514272ede.58.2020.05.29.11.03.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2020 11:03:52 -0700 (PDT)
Subject: Re: [PATCH] spi: bcm2835: Enable shared interrupt support
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Mark Brown <broonie@kernel.org>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Martin Sperl <kernel@martin.sperl.org>,
        linux-spi@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20200528185805.28991-1-nsaenzjulienne@suse.de>
 <20200529174358.som3snunfxch6phi@wunner.de>
 <36dd65bb-18a9-9697-b9b6-76eaf8cbe45c@gmail.com>
 <20200529175350.2wtoqttipa354m2m@wunner.de>
From:   Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 G10n8gCguORqNGMsVRxrlLs7/himep7MrCc=
Message-ID: <b832eaed-b480-b3b6-4df0-75abcc11f08a@gmail.com>
Date:   Fri, 29 May 2020 11:03:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200529175350.2wtoqttipa354m2m@wunner.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 5/29/20 10:53 AM, Lukas Wunner wrote:
> On Fri, May 29, 2020 at 10:46:01AM -0700, Florian Fainelli wrote:
>> On 5/29/20 10:43 AM, Lukas Wunner wrote:
>>> On Thu, May 28, 2020 at 08:58:04PM +0200, Nicolas Saenz Julienne wrote:
>>>> --- a/drivers/spi/spi-bcm2835.c
>>>> +++ b/drivers/spi/spi-bcm2835.c
>>>> @@ -379,6 +379,10 @@ static irqreturn_t bcm2835_spi_interrupt(int irq, void *dev_id)
>>>>  	if (bs->tx_len && cs & BCM2835_SPI_CS_DONE)
>>>>  		bcm2835_wr_fifo_blind(bs, BCM2835_SPI_FIFO_SIZE);
>>>>  
>>>> +	/* check if we got interrupt enabled */
>>>> +	if (!(bcm2835_rd(bs, BCM2835_SPI_CS) & BCM2835_SPI_CS_INTR))
>>>> +		return IRQ_NONE;
>>>> +
>>>>  	/* Read as many bytes as possible from FIFO */
>>>>  	bcm2835_rd_fifo(bs);
>>>>  	/* Write as many bytes as possible to FIFO */
> [...]
>>> Finally, it would be nice if the check would be optimized away when
>>> compiling for pre-RasPi4 products, maybe something like:
>>>
>>> +	if (IS_ENABLED(CONFIG_ARM_LPAE) && !(cs & BCM2835_SPI_CS_INTR))
>>> +		return IRQ_NONE;
>>
>> Rather than keying this off ARM_LPAE or any other option, this should be
>> keyed off a compatible string, that way we can even conditionally pass
>> IRQF_SHARED to the interrupt handler if we care so much about performance.
> 
> But a compatible string can't be checked at compile time, can it?

No, but you can have a different interrupt handler that it set at
runtime if you want to completely eliminate this comparison.

My point is that CONFIG_ARM_LPAE is just too brittle, there is nothing
that prevents you from using a non-LPAE kernel on the Pi 4, even PCIe
could be made to work if using super section mappings to map the PCIe
outbound space. Even on models with over 4GB of DRAM, if you are willing
to lose some of it, it can work.

> 
> The point is that at the least the Foundation compiles and ships a separate
> kernel for each of the three platforms BCM2835, BCM2837, BCM2711.  It's
> unnecessary to check whether an interrupt was actually raised if we *know*
> in advance that it's not shared (as is the case with kernels compiled for
> BCM2835 and BCM2837).

I am fine with any solution that does not involve keying off
CONFIG_ARM_LPAE to discriminate 2711 from any other chip.
-- 
Florian
