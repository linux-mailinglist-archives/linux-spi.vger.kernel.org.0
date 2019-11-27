Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04C5510ADFE
	for <lists+linux-spi@lfdr.de>; Wed, 27 Nov 2019 11:43:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbfK0KnB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 27 Nov 2019 05:43:01 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:35064 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbfK0KnB (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 27 Nov 2019 05:43:01 -0500
Received: by mail-lf1-f65.google.com with SMTP id r15so13808333lff.2
        for <linux-spi@vger.kernel.org>; Wed, 27 Nov 2019 02:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4bSZtYSKRzzSpgbvHLlRlvm4/VSvnoysG6GlVXihnl0=;
        b=ggKnvTb3rsJToKxbuhyxwAbfRBemmGkw8JZt/E9J/1dva2aqZ56jv3tvhwXZI/lTDT
         5f6wo5LpHRqnMAejwyytGjAdGro3Cq2DWfIJWELdiBbag2RHMjmZqhl3kDypKRaBPnqM
         Y/f6UBfRriLjYDBLpmql0qGv/rDbQfWjp7BJg9bgwQeF/jMHPwXEa4GWTnYiPAwhPb5e
         XD7b98K1+F/mjCoL4AWYXhzzo03som5qUjjmDPIcZMy4w8Vou9qns3GllacfRtdsQKPt
         nDWvssfwI5q+Ay/+b6l+10d/cA3oC9alMPeAj31Wd8lTnp1uiRm7OmJOUySUV3n1Z8BF
         n7yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4bSZtYSKRzzSpgbvHLlRlvm4/VSvnoysG6GlVXihnl0=;
        b=IT64Ny667FAuFCiXxHClU31Vo2Bw2Y1jDPboKkcNS+C2gfqCbGGqj7swARIYq9wpNd
         K8jytfINyP6Ku8VVILliI9w3wPmS2Abu4kW+ligTuXtmDdEBqEadIzYUCFrCckfPd629
         Qr9xQDLl6tBSnb5/DnXHn0hb75KGJxBuLegKAJJ06gAyCpQNz+vgaqu8fWJYXLg5PCac
         6H0M6UiWbI/EGnrL/jBjd473Ev6wO/HybltQJs5ldYILbXVdtbTdHgR4jP5OYTtPy2fA
         Uzj4KW7TrJhKTrIYKeMAfhOpJrhgPJguuuo1gZs63PG7FJrIUKfXySJtEqs2LvSjTH9a
         YZ2Q==
X-Gm-Message-State: APjAAAV8AYI8sqaNFM5Tx54YuRGJVO9ygmcEjnNactTKCQR5PxJq1IAT
        OQ6nItK+9wEsHJS0ym1xDSaJsqkkVbEpPcT2PKnOU/+5ky9fAw==
X-Google-Smtp-Source: APXvYqw0axWlyE9Xf7qKCdQKDA51b0gvm1OnGchTmMmRVTBeWX1iAOF60Ns4IfePT38SeObuWmaWludZTP46LMj/Nog=
X-Received: by 2002:a19:7d02:: with SMTP id y2mr26825678lfc.86.1574851379646;
 Wed, 27 Nov 2019 02:42:59 -0800 (PST)
MIME-Version: 1.0
References: <20191126164140.6240-1-ckeepax@opensource.cirrus.com>
In-Reply-To: <20191126164140.6240-1-ckeepax@opensource.cirrus.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 27 Nov 2019 11:42:47 +0100
Message-ID: <CACRpkdYc=2vWte+gFp0m6RvWSu=+qT=WWUzag0N1FUBmbSCOOw@mail.gmail.com>
Subject: Re: [PATCH] spi: cadence: Correct handling of native chipselect
To:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        Gregory Clement <gregory.clement@bootlin.com>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Charles!

Thanks for finding this!

On Tue, Nov 26, 2019 at 5:41 PM Charles Keepax
<ckeepax@opensource.cirrus.com> wrote:

> To fix a regression on the Cadence SPI driver, this patch reverts
> commit 6046f5407ff0 ("spi: cadence: Fix default polarity of native
> chipselect").
>
> This patch was not the correct fix for the issue. The SPI framework
> calls the set_cs line with the logic level it desires on the chip select
> line, as such the old is_high handling was correct. However, this was
> broken by the fact that before commit 3e5ec1db8bfe ("spi: Fix SPI_CS_HIGH
> setting when using native and GPIO CS") all controllers that offered
> the use of a GPIO chip select had SPI_CS_HIGH applied, even for hardware
> chip selects. This caused the value passed into the driver to be inverted.
> Which unfortunately makes it look like a logical enable the chip select
> value.
>
> Since the core was corrected to not unconditionally apply SPI_CS_HIGH,
> the Cadence driver, whilst using the hardware chip select, will deselect
> the chip select every time we attempt to communicate with the device,
> which results in failed communications.
>
> Fixes: 3e5ec1db8bfe ("spi: Fix SPI_CS_HIGH setting when using native and GPIO CS")
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>

I kind of get it... I think.

I see it fixes a patch that I was not CC:ed on, which is a bit unfortunate
as it tries to fix something I wrote, but such things happen.

The original patch
f3186dd87669 ("spi: Optionally use GPIO descriptors for CS GPIOs")
came with the assumption that native chip select handler needed
was to be converted to always expect a true (1) value to their
->set_cs() callbacks for asserting chip select, and this was one of
the drivers augmented to expect that.

As
3e5ec1db8bfe ("spi: Fix SPI_CS_HIGH setting when using native and GPIO CS")
essentially undo that semantic change and switches back to
the old semantic, all the drivers that were converted to expect
a high input to their ->set_cs() callbacks for asserting CS need
to be reverted back as well, but that didn't happen.

So we need to fix not just cadence but also any other driver setting
->use_gpio_descriptors() and also supplying their own
->set_cs() callback and expecting this behaviour, or the fix
will have fixed broken a bunch of drivers.

But we are lucky: there aren't many of them.
In addition to spi-cadence.c this seems to affect only spi-dw.c
and I suppose that is what Gregory was using? Or
something else?

Yours,
Linus Walleij
