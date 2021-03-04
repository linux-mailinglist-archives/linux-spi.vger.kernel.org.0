Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9E9532CE7A
	for <lists+linux-spi@lfdr.de>; Thu,  4 Mar 2021 09:31:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236792AbhCDIax (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 4 Mar 2021 03:30:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236843AbhCDIa0 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 4 Mar 2021 03:30:26 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C409CC061761
        for <linux-spi@vger.kernel.org>; Thu,  4 Mar 2021 00:29:45 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id v9so23988057lfa.1
        for <linux-spi@vger.kernel.org>; Thu, 04 Mar 2021 00:29:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z/YunITDzSj54Y4k2da7IIbwcZOzFgpMcTcXrvSJIsY=;
        b=JaUPYLR7xkZXBatHr7s2xfITNdM0H4Jctt/Fw2uA9rVTPRXS2ypGfQgeG9h77/gY5y
         7R8yulF7mLSY0OgIKuT6J/Ojr06v7NT7A6N5Nkq6CnoaP8Yr0tttUmgXRo9RzzIK0UnP
         UVtLZe4POq614g7G8HEaMlTlNd/edz0pZ/qrLnEd/fMjim5WibSx3ajwVPMfR0eZ2ABR
         f02UlJEuLJBHeRh0WEyp58aIIIxQeyyyLJX8vDD1h13rv3fk1tJqBy+UArpvwCFZt+GW
         WZgE6/MLDaJg5nIEm/9E9KW4ILP0L+viXBuImxX4kz7o8HLReWKq8Y/Pv7jUdUKfuVSr
         3rIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z/YunITDzSj54Y4k2da7IIbwcZOzFgpMcTcXrvSJIsY=;
        b=InyL0xoFejJNXXDR6QEN1y1OhJfnrIxJIKv0T7WbtusOTmxA6FLRZEXDKRaGlpomT5
         wzvaUjR/7WtPywEqOc1Uq3Y44xNEfhpl9W4wQiAb0h4pvsuOFjL5RX3/d1965Dd3EFK+
         5qnZuFCEfXqTCMJSgrKazlFT2UhjJy0+jVrKF4wS0mDDczuamP6bXfAUoypXF7hJq9cl
         jzF+eoQ+emXc6DHDwV+DkDcg5LOsIvrB8iBGy2q3Y2f/wCjBIybOmZrKqAplovJ0IB+0
         1wm+j9s084gTlMXfcPD3MJRCpL74sE6iE4COYwiVzXpCrbjeK8Cbxj8pzuIi9kiRPUEB
         huog==
X-Gm-Message-State: AOAM5316yaIgmVTZI78esDemBDY7yfmpcKOXtzCyVVn2rMj9R/CunvoN
        isApoDZiVKPtOFo927tNDqSyTdn+4NsS3CabXE1/Cw==
X-Google-Smtp-Source: ABdhPJy5zH9v2taHTbOivNt/jHFRx+P8htUtEtdRjWfaZYj8ZCyXiyfzifW75rVWQfROIBOwLzH5JMbjd+5Vk4a/t7c=
X-Received: by 2002:a05:6512:10d1:: with SMTP id k17mr1556851lfg.649.1614846584130;
 Thu, 04 Mar 2021 00:29:44 -0800 (PST)
MIME-Version: 1.0
References: <20210304034141.7062-1-brad@pensando.io> <20210304034141.7062-2-brad@pensando.io>
In-Reply-To: <20210304034141.7062-2-brad@pensando.io>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 4 Mar 2021 09:29:33 +0100
Message-ID: <CACRpkdbQD6p7fbGtuu1c92uXfSFDCTwqjqsXHpgnD5Lg4v0Okw@mail.gmail.com>
Subject: Re: [PATCH 1/8] gpio: Add Elba SoC gpio driver for spi cs control
To:     Brad Larson <brad@pensando.io>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Brad,

thanks for your patch!

On Thu, Mar 4, 2021 at 4:42 AM Brad Larson <brad@pensando.io> wrote:

> This GPIO driver is for the Pensando Elba SoC which
> provides control of four chip selects on two SPI busses.
>
> Signed-off-by: Brad Larson <brad@pensando.io>
(...)

> +#include <linux/gpio.h>

Use this in new drivers:
#include <linux/gpio/driver.h>

> + * pin:             3            2        |       1            0
> + * bit:         7------6------5------4----|---3------2------1------0
> + *     cs1  cs1_ovr  cs0  cs0_ovr |  cs1  cs1_ovr  cs0  cs0_ovr
> + *                ssi1            |             ssi0
> + */
> +#define SPICS_PIN_SHIFT(pin)   (2 * (pin))
> +#define SPICS_MASK(pin)                (0x3 << SPICS_PIN_SHIFT(pin))
> +#define SPICS_SET(pin, val)    ((((val) << 1) | 0x1) << SPICS_PIN_SHIFT(pin))

So 2 bits per GPIO line in one register? (Nice doc!)

> +struct elba_spics_priv {
> +       void __iomem *base;
> +       spinlock_t lock;
> +       struct gpio_chip chip;
> +};
> +
> +static int elba_spics_get_value(struct gpio_chip *chip, unsigned int pin)
> +{
> +       return -ENXIO;
> +}

Write a comment that the chip only supports output mode,
because it repurposes SPI CS pins as generic GPIO out,
maybe at the top of the file?

I suppose these systems also actually (ab)use the SPI cs
for things that are not really SPI CS? Because otherwise
this could just be part of the SPI driver (native chip select).

> +static const struct of_device_id ebla_spics_of_match[] = {
> +       { .compatible = "pensando,elba-spics" },

Have you documented this?

Other than that this is a nice and complete driver.

Yours,
Linus Walleij
