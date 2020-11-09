Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A37C2ABEEA
	for <lists+linux-spi@lfdr.de>; Mon,  9 Nov 2020 15:41:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729850AbgKIOla (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Nov 2020 09:41:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726952AbgKIOla (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 9 Nov 2020 09:41:30 -0500
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E10D7C0613CF;
        Mon,  9 Nov 2020 06:41:29 -0800 (PST)
Received: by mail-vs1-xe43.google.com with SMTP id h5so5072577vsp.3;
        Mon, 09 Nov 2020 06:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=psnNy3QTtX/D1uoSbPA7cfyikpVZsBuIEGMQour2XRE=;
        b=LIzpzS0g4PiuKnCEWPFVRmEERGdUrGPL0WK+VMtHllrC4v151WNFAQsZRvk3RmZdbf
         q4uVYskOcYNX8qTuRnciCPDBW0fJp922FI1tCt62FOlH2Qd5aKs3Cq+t4wbKJUvru7UK
         r0NfCmD6f2KUgeIhzFsei3pEoXPXJefDGG4Vw0Db6Apjml5k8fu/vm0DtNRRnDOO8Mt/
         mE1jD/49tAF3NgqOkoYU8n+wKQ7DizRA8DBfLd2cOcM3nI2whJIETfvny2LQPzzHG3KR
         UsVF2YSnrOL/wiTQfbRjxL6kU4TUGYyXFHa8y5MUJrVQGVU8W3eNURr2017hSlQmW3YQ
         wpgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=psnNy3QTtX/D1uoSbPA7cfyikpVZsBuIEGMQour2XRE=;
        b=chh2GIB7dkObDy1uAXtQGP0Lolhph1BtnK2GhsDxHdz5qiVCKt7tYwsYf+4A0G9ZUy
         DJcQgO4e001KV6thu5e7hl7WWWyOgj1BV8Vp8fOWQ4osuimVSH73Ca0SrJ9AdCDV/77U
         NKI/1BMwu/EEmZ2V1E/JWHgZc4X41s7KVq6vw0vm8Aq/GEQz0+swzGW+W7EVZBoOoEVu
         6d5hcsHSPKh7dbkVgXZ2KlpFe0VroXqMhXYY3LgrAEXZ/foj+MGdjQ0lrieeFb8Fqjjs
         Ppqa4hcj9yVgRDQMa6pa2JVAnWFpsL+y4R5D1xLgwKMTLxTPHoJWxKpkYxWotLH6cOAp
         dWKw==
X-Gm-Message-State: AOAM5309pAjYcTOUiY/DyBTJyD8Gs8SBS2QYixTQmhxpzQAVl2zF03xS
        N2IUxZ6D29/N1N1IhvutRPpPw+CGjapBcZka4L0=
X-Google-Smtp-Source: ABdhPJyBu3fkqNB1vZfypbjgqBD/gBgpoPDRvZL8h4tVJrCeFgQTl7tGomyBv2HvTQn41T46w4xyqDY4+/8tJf29ao0=
X-Received: by 2002:a67:2ac1:: with SMTP id q184mr7758992vsq.57.1604932889025;
 Mon, 09 Nov 2020 06:41:29 -0800 (PST)
MIME-Version: 1.0
References: <20201106150706.29089-1-TheSven73@gmail.com> <CAHp75VfP1R7bXV6nWWnovWB5BMFcNNEmwBQXheBCUVDbr=xXGA@mail.gmail.com>
In-Reply-To: <CAHp75VfP1R7bXV6nWWnovWB5BMFcNNEmwBQXheBCUVDbr=xXGA@mail.gmail.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Mon, 9 Nov 2020 09:41:18 -0500
Message-ID: <CAGngYiVu3cXtzb5PaoDOoyqjuuohLQ+em6Keg-qgDFFn2tdp=Q@mail.gmail.com>
Subject: Re: [PATCH v1] spi: fix client driver breakages when using GPIO descriptors
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
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

Hi Andy, thank you for looking at this patch !

On Mon, Nov 9, 2020 at 9:24 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> Sounds like "many SPI drivers have to be fixed".
>

I don't disagree. Fact is that after the imx cspi bus driver was converted
to gpio descriptors, most spi client drivers broke. It would be great if this
could be fixed. Any method that the community can find a consensus on,
would be great :)

One the one hand: the fact that many spi client drivers just overwrite
flags and values in their parent bus structure, doesn't sound idiomatic.
I guess those spi->... values should really be opaque, and we should
be using accessor functions, eg.:

    static int acme_probe(struct spi_device *spi)
    {
        ...
        // won't touch SPI_CS_HIGH flag
        spi_set_mode_clock(spi, SPI_MODE_0);
        ...
    }

On the other hand, it sounds very confusing to set SPI_CS_HIGH on
all spi buses that use gpio descriptors: especially because gpiolib
already handles absolutely everything related to polarity. And the
SPI_CS_HIGH flag gets set even for chip-selects that are active-low.
