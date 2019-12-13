Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9B1A11E1B6
	for <lists+linux-spi@lfdr.de>; Fri, 13 Dec 2019 11:11:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbfLMKLT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 13 Dec 2019 05:11:19 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35501 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbfLMKLS (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 13 Dec 2019 05:11:18 -0500
Received: by mail-wm1-f65.google.com with SMTP id p17so5929794wmb.0
        for <linux-spi@vger.kernel.org>; Fri, 13 Dec 2019 02:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=afUYRWsoJ7gXjNd0peDLBkKmnYts93gY39k9kIKHPTI=;
        b=dOPTYyNgmJ7KAAigY6FG0RS5z65RmW4VtcFRy8cfQuVU9G2SAPyJLE4AuegYdu2EAO
         7xCih5yaJzkoEDJH1AZf+QSmBw+F8mxBAuTcTT5HHVRSKCAqWTnRwdy2n2+QIT5GNh2m
         v+IGFR6jD27JH+UhPSegLEPcwKXH9/YQJkMFA+M99YJn2RKoLPPtqFc/OJK1sxrqr/5G
         lKRXWv5cnz+AASRU8tP5nCI3qOXE68Jt4+G9jeYv1cNKPQNffxXhCdnAlyh5sBY2IfYU
         EN+LN8KSrrF7dl4BJWK6IYoR5kDyLcpvZIU/hvesgqotbShz/uMEPFBUoHwE5mcPbKG+
         h3ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=afUYRWsoJ7gXjNd0peDLBkKmnYts93gY39k9kIKHPTI=;
        b=NqXp4OWBMXZqIcVhdbVxp7C057AVzaIbk2oTEcSzHH6wZO1O8AlRJC9C/zM45BC6Rd
         tLm/zvv8udTeznuVXX4zOo1bD90F+KfQIm48x1kzbUPfUDvVoi+crMoX0/vS+GLkPfZn
         ytfnrHWy1J9pu7gEmaomWo8kB0/pZAg6OEu/ujZ3yvzIP2gudZT8qUPVASMM4aR1bzzC
         dYCHmAqPVyUPjudw6BuvlVQ9qK5TR9oXqjwjci5idYUNppdX8RCy78DF+Xq6bX4BQcpr
         gqx5Nn7IL892L4s53VU3HonOOvFOr7LSyL4hTdPryEFuXRyo4jYIqENMUGPAZig2txLA
         nPWg==
X-Gm-Message-State: APjAAAVT+keYdckFm5qWyPD2aCkbPlSpI07lJvz3UiGaV5yQs0NkW5su
        Cf0g+V1yA61qISUr56E0stbB7A==
X-Google-Smtp-Source: APXvYqz6MgSbH71a82LakgkhteZgoIx5NU/6xOT6FieoairRWs/pFDAm7IyEOiqYbykOh07ij2zAcw==
X-Received: by 2002:a7b:c5d8:: with SMTP id n24mr12047758wmk.124.1576231876012;
        Fri, 13 Dec 2019 02:11:16 -0800 (PST)
Received: from [10.2.4.229] (lfbn-nic-1-505-157.w90-116.abo.wanadoo.fr. [90.116.92.157])
        by smtp.gmail.com with ESMTPSA id i16sm10022148wmb.36.2019.12.13.02.11.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Dec 2019 02:11:15 -0800 (PST)
Subject: Re: [PATCH] spi: meson-spicc: Use GPIO descriptors
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Sunny Luo <sunny.luo@amlogic.com>
References: <20191205083915.27650-1-linus.walleij@linaro.org>
 <cbe69b98-39a9-4e87-77d2-cf7a4753a6ce@baylibre.com>
 <CACRpkdYgLoO8jPEWSxteZrdi2-dMjpCX0zKfXR1Zrv6RH=MJ=A@mail.gmail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <d3af71d2-308f-5b5b-f6c5-4f2719a5a3d4@baylibre.com>
Date:   Fri, 13 Dec 2019 11:11:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CACRpkdYgLoO8jPEWSxteZrdi2-dMjpCX0zKfXR1Zrv6RH=MJ=A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 13/12/2019 11:08, Linus Walleij wrote:
> On Thu, Dec 5, 2019 at 10:12 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>> On 05/12/2019 09:39, Linus Walleij wrote:
>>> Instead of grabbing GPIOs using the legacy interface and
>>> handling them in the setup callback, just let the core
>>> grab and use the GPIOs using descriptors.
>>>
>>> Cc: Neil Armstrong <narmstrong@baylibre.com>
>>> Cc: Sunny Luo <sunny.luo@amlogic.com>
>>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>>> ---
>>>  drivers/spi/spi-meson-spicc.c | 25 ++-----------------------
>>>  1 file changed, 2 insertions(+), 23 deletions(-)
>>>
>>> diff --git a/drivers/spi/spi-meson-spicc.c b/drivers/spi/spi-meson-spicc.c
>>> index f3f10443f9e2..7f5680fe2568 100644
>>> --- a/drivers/spi/spi-meson-spicc.c
>>> +++ b/drivers/spi/spi-meson-spicc.c
>>> @@ -19,7 +19,6 @@
>>>  #include <linux/types.h>
>>>  #include <linux/interrupt.h>
>>>  #include <linux/reset.h>
>>> -#include <linux/gpio.h>
>>>
>>>  /*
>>>   * The Meson SPICC controller could support DMA based transfers, but is not
>>> @@ -467,35 +466,14 @@ static int meson_spicc_unprepare_transfer(struct spi_master *master)
>>>
>>>  static int meson_spicc_setup(struct spi_device *spi)
>>>  {
>>> -     int ret = 0;
>>> -
>>>       if (!spi->controller_state)
>>>               spi->controller_state = spi_master_get_devdata(spi->master);
>>> -     else if (gpio_is_valid(spi->cs_gpio))
>>> -             goto out_gpio;
>>> -     else if (spi->cs_gpio == -ENOENT)
>>> -             return 0;
>>> -
>>> -     if (gpio_is_valid(spi->cs_gpio)) {
>>> -             ret = gpio_request(spi->cs_gpio, dev_name(&spi->dev));
>>> -             if (ret) {
>>> -                     dev_err(&spi->dev, "failed to request cs gpio\n");
>>> -                     return ret;
>>> -             }
>>> -     }
>>> -
>>> -out_gpio:
>>> -     ret = gpio_direction_output(spi->cs_gpio,
>>> -                     !(spi->mode & SPI_CS_HIGH));
>>>
>>> -     return ret;
>>> +     return 0;
>>>  }
>>>
>>>  static void meson_spicc_cleanup(struct spi_device *spi)
>>>  {
>>> -     if (gpio_is_valid(spi->cs_gpio))
>>> -             gpio_free(spi->cs_gpio);
>>> -
>>>       spi->controller_state = NULL;
>>>  }
>>>
>>> @@ -564,6 +542,7 @@ static int meson_spicc_probe(struct platform_device *pdev)
>>>       master->prepare_message = meson_spicc_prepare_message;
>>>       master->unprepare_transfer_hardware = meson_spicc_unprepare_transfer;
>>>       master->transfer_one = meson_spicc_transfer_one;
>>> +     master->use_gpio_descriptors = true;
>>>
>>>       /* Setup max rate according to the Meson GX datasheet */
>>>       if ((rate >> 2) > SPICC_MAX_FREQ)
>>>
>>
>> Hmm, I did this because the SPI core was buggy, so I assume it has been fixed ?
>>
>> gpio_request/free was not done by the core, thus needing to be done in the setup/cleanup callback.
> 
> Yes and no. I convert to using descriptors which are devm managed
> resources.
> 
> If you use the legacy API for requesting GPIO (by number) which is
> what happens without ->use_gpio_descriptors then this need for
> the driver to request the GPIOs still exist.
> 
> Here we solve two problems at the same time:
> 
> - Get rid of the need to explicitly request the lines
> - Convert to use descriptors
> 
> Isn't it great.

Bingo !

LGTM !

Acked-by: Neil Armstrong <narmstrong@baylibre.com>

> 
> Yours,
> Linus Walleij
> 

