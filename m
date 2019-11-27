Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2C510ABAD
	for <lists+linux-spi@lfdr.de>; Wed, 27 Nov 2019 09:26:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbfK0I0Z (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 27 Nov 2019 03:26:25 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46066 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbfK0I0Z (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 27 Nov 2019 03:26:25 -0500
Received: by mail-lj1-f195.google.com with SMTP id n21so23384272ljg.12
        for <linux-spi@vger.kernel.org>; Wed, 27 Nov 2019 00:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EtlRW7Zv5WKr6zMoDEd4iR5nTnfjs8gcond8279/uso=;
        b=QZKjuOH8L91oMw8/x7vKUMLPdQtpLsV5zsZPR0IYNcqCjAHp48gDX95W9i/wNdgZ8V
         FQSxbSdJUOSgrVE8/mt1FVzAK/Vkk/HO57i56yr7yNCR8S1th47E6/RZ6KM8KrXTHR5E
         aV3AtZz7PuHu9vTfS2UMTuZI0T4JZC/JRgXH/nfek/IWZ3RyV8tczC0Yczl3As+1LHLP
         BfyFsFDqd7kj/IiGINFzPcDnP2vhCHO5j65kVITVY0HAPI6Ca2vgv2MjLrLIE9zZK3Ch
         IWaxu07RWI0rpa36SIK79asxwvtGc9ota2cboAbDzrQgVbA7fQWVDgXMr4v+kAKQOtDV
         jUxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EtlRW7Zv5WKr6zMoDEd4iR5nTnfjs8gcond8279/uso=;
        b=khcjOBp6o/k2cJufJXQoiTS2IN/jt2TIiT+DO6IUa5d2Nrv53b8ZXB/fz/o+oSKSWa
         f5kvc8ZiYvRdMLdF33b5D1r181dg1+FJte/uljbH7z5BbMExkja6B0nnXJKGAA7nB+eC
         rDZGfm6VwgN8B7kfvnRRN8pOdmIcoedpVRRkGCfSca1R1z9TV48YQfxx3r+gVG619aND
         rC88GJ2BbIg+X/s9hrj+3tzydSN8HsnWt5roY+V6zu/c9wG8gZUP5adg5YiecxuaJFu1
         Mpu9V1FoQjlqi+xWY72n/YCT12XGod6mnKy7OsBC0utBKc+kjSBynH7WFc+CewrO+95e
         /XEg==
X-Gm-Message-State: APjAAAWvz6zLdc72UjodPlubnfNIdhYLBZkKc9NRf1mVf8DtYG8JcB7o
        hkUdTKUfPbg/v20VqEK+JqPnBDkXt/TmJbbrPOYxnA==
X-Google-Smtp-Source: APXvYqxXGQ2RA0UrDyenqWCR2MPe2w1V9LQ+O26pNg03ZAW5VOPpyvVm+WNSb2zDi8QrExFP6UmyToP9pnQGAyfCZo8=
X-Received: by 2002:a2e:9699:: with SMTP id q25mr29840309lji.251.1574843183092;
 Wed, 27 Nov 2019 00:26:23 -0800 (PST)
MIME-Version: 1.0
References: <e9981d69-2a33-fec9-7d12-15fcb948364d@c-s.fr> <CACRpkdYLEibwyK_BGO3gsJ_aQFWZNJCky-GezHVmHfRSzD2zBg@mail.gmail.com>
 <1efb797c-e3c1-25a4-0e81-78b5bbadb355@c-s.fr> <CACRpkdYUBj+45Jr94kdERKJogVoL96JH6i85o_bVUtjmkTt19g@mail.gmail.com>
 <3c79a8b9-65e4-bfc9-d718-b8530fe1e672@c-s.fr> <b06679da-0332-2322-13f8-07307f611542@c-s.fr>
In-Reply-To: <b06679da-0332-2322-13f8-07307f611542@c-s.fr>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 27 Nov 2019 09:26:11 +0100
Message-ID: <CACRpkdbOzM3X2_BMnf5eSqCt_UsnXo4eXD2fUbTLk6=Uo3gB2g@mail.gmail.com>
Subject: Re: Boot failure with 5.4-rc5, bisected to 0f0581b24bd0 ("spi: fsl:
 Convert to use CS GPIO descriptors")
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linux-spi <linux-spi@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Nov 26, 2019 at 8:14 PM Christophe Leroy
<christophe.leroy@c-s.fr> wrote:

> > Digging a bit further, I see that devm_spi_register_master() fails in
> > spi_register_controler() because ctlr->num_chipselect is 0

Aha, I see what the problem is I think. The old code for mpc8xxx had this:

       ngpios = of_gpio_count(np);
       ngpios = max(ngpios, 0);
       if (ngpios == 0 && !spisel_boot) {
               /*
                * SPI w/o chip-select line. One SPI device is still permitted
                * though.
                */
               pdata->max_chipselect = 1;
               return 0;
       }
(...)
      master->num_chipselect = pdata->max_chipselect;

But the new code in the core has this:

    nb = gpiod_count(dev, "cs");
    ctlr->num_chipselect = max_t(int, nb, ctlr->num_chipselect);

So it relied on inspecting the device tree and set  this to 1
if it didn't find anything.

I will send a patch to test!

Yours,
Linus Walleij
