Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2A872ABE90
	for <lists+linux-spi@lfdr.de>; Mon,  9 Nov 2020 15:24:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730197AbgKIOYW (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Nov 2020 09:24:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730035AbgKIOYW (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 9 Nov 2020 09:24:22 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5647BC0613CF;
        Mon,  9 Nov 2020 06:24:22 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id r186so7296852pgr.0;
        Mon, 09 Nov 2020 06:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I0JWH1SE4fNuIvP9pni+ltgPPpUk5UXe6Ja6Dl7UHNM=;
        b=jevuavzxcW3HQorjQwheDNNI2A/fFPMvKDn0mcJGqAZBwBmCKwMTdKJpXVkQPCC+xc
         0wzcYAZ5Q9lDDiVmS1vQywVJM7xxtr6bERgHvaw2TEYngDMWsfm/UvAbGMQVmFwZV6AE
         lsMhtSpPyA8oDLU44HCn1M8NMYKKMjwqaHtlsW2DLk/QnsFFxCiUlGtC6gh6DgouC3yv
         ZuWZI00QluQK5J/HrBKfORylQVbU6tR9TYZ61UkFhd1dTptjTzMHdN3pV6bzUplif+Sy
         B0mjgvK9zvjtFqHsvXmc3piUc2zpJLAweR5Z9rqfcxL7qRHQeczNP/gpziee4ovyEAeC
         SdMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I0JWH1SE4fNuIvP9pni+ltgPPpUk5UXe6Ja6Dl7UHNM=;
        b=HmhhnF8mLX8j7KnSWena5LS4wePUGslk2xCmf8mrR4XxvwYe3hCd4UeDIuPlOR0E7w
         yuBdI01C1WRWTlTsvjoHngUU+G4XZHY2lZ8W0ivja1L/xLpC00sXYTe/drf1GJ99yf7Q
         Is0FWJwtrUg2HOALoHX/82FF30aPPEomlm+zZVv5M6iCLk25iq/PFdpoM/AwJa34LNWc
         j4MeWH/SERu4BdsoAsFfbm5rBuUkYSJSE+ypH4tgo7oDgR4xRURaDUz3KOSUNUJaXA/r
         UsKWQ/i+zzf03Z1dSzI33t5sVG90OTdsR71L3hiCKUgPmdyeCUEmVfr5ixttSycMvPIa
         ObZg==
X-Gm-Message-State: AOAM530vNtA7ozUJYR6RKN91xGbSbD6ntA9HYPDVG3yXD+kNAqg6MjdH
        1UTxGHPXkH4rMh4BGTtp7Of1IJrrQK8470JmPoM=
X-Google-Smtp-Source: ABdhPJwidLp7E0/LPaDZe10ybjQfbINm9x2SALC+02oxtUeVB16O5+WJcb4yxzJw4LIARuGK1yf21/HmLLMPqjNbLWw=
X-Received: by 2002:a63:4511:: with SMTP id s17mr13018417pga.4.1604931861810;
 Mon, 09 Nov 2020 06:24:21 -0800 (PST)
MIME-Version: 1.0
References: <20201106150706.29089-1-TheSven73@gmail.com>
In-Reply-To: <20201106150706.29089-1-TheSven73@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 9 Nov 2020 16:25:10 +0200
Message-ID: <CAHp75VfP1R7bXV6nWWnovWB5BMFcNNEmwBQXheBCUVDbr=xXGA@mail.gmail.com>
Subject: Re: [PATCH v1] spi: fix client driver breakages when using GPIO descriptors
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Simon Han <z.han@kunbus.com>, Lukas Wunner <lukas@wunner.de>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Nov 6, 2020 at 5:08 PM Sven Van Asbroeck <thesven73@gmail.com> wrote:
>
> From: Sven Van Asbroeck <thesven73@gmail.com>
>
> Commit f3186dd87669 ("spi: Optionally use GPIO descriptors for CS GPIOs")
> introduced the optional use of GPIO descriptors for chip selects.
>
> A side-effect of this change: when a SPI bus uses GPIO descriptors,
> all its client devices have SPI_CS_HIGH set in spi->mode. This flag is
> required for the SPI bus to operate correctly.
>
> This unfortunately breaks many client drivers, which use the following
> pattern to configure their underlying SPI bus:
>
> static int client_device_probe(struct spi_device *spi)
> {
>         ...
>         spi->mode = SPI_MODE_0;
>         spi->bits_per_word = 8;
>         err = spi_setup(spi);
>         ..
> }
>
> In short, many client drivers overwrite the SPI_CS_HIGH bit in
> spi->mode, and break the underlying SPI bus driver.

Sounds like "many SPI drivers have to be fixed".



-- 
With Best Regards,
Andy Shevchenko
