Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20D512D49C6
	for <lists+linux-spi@lfdr.de>; Wed,  9 Dec 2020 20:06:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387509AbgLITFY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 9 Dec 2020 14:05:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733155AbgLITFS (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 9 Dec 2020 14:05:18 -0500
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4162C0613D6;
        Wed,  9 Dec 2020 11:04:38 -0800 (PST)
Received: by mail-vs1-xe43.google.com with SMTP id j140so1492911vsd.4;
        Wed, 09 Dec 2020 11:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8R1emGlkFCZsxKOchekRowPlTq2Uar4xze39TGRHNXE=;
        b=BeDN6FOKor+IDI8aaoX66IwhGklASEbu3c1etaacMoxS1tFLyzuE5mA8bBD/UmQwsY
         LiMxBrAbgYjvsLLG9QZvqT9tkiTbVmLifA911pMjDvu3IVw4Sn3En84zmIpxT4dz05RV
         a+bS7zHOUfTk/lJD8YZHk0spkAPrv7xqPgKv1Ogfa8TbaMXhAZODHDoikO50AR3KFdZ0
         xERQ0TOcQls0eVck1XCHv/FgYDGTwgex6cEDjwC2YUhQPKh4j1uOm7ukEAAMCkc1yXDG
         /j2KAnuCLo3evAcyphQOH4w2beEHg3ZMlYnRE3RLiYojxbpXLii6ERHd705NbaUv3EAE
         GReg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8R1emGlkFCZsxKOchekRowPlTq2Uar4xze39TGRHNXE=;
        b=OwNZE8nCiY8S2e/I+Y8EV/YcWWrtnXBL6Y/FLxBnEaBvwxXkv/XqvWZFJ9jp8DPivn
         URp7iAURzgo2qng2UVgMjLDKYrN5278h+2R+IOSoiidlDQBulh9fxFF4zFN5H4FUNrq/
         HXf2iFMV7lsk9HnXXAeWnXFwz3zUnQmq0erW8IaJb+YOiwfgOIszc4jtm43hLxcn1iJR
         jMAfYOZxMLDPePzNN6rZmplIwcMbVs5mYVoxnil3VWo2kOqzRONpjZNXMMKit4beVbo2
         Huvp4XQMKgnucx3UvaZVosjZBiqLx/BT3HtH83mOHI1d5MHzFZcXTnaNN1qajM4MapFF
         o2Fw==
X-Gm-Message-State: AOAM530IpUC8CYwg8c0JMJZVkx1lHNUrLSOClX85VTOZYA6unO0jJqU6
        gkV9e2hRmfLkNKUNmcHHOButsVK7Sso3JNfyRyQ=
X-Google-Smtp-Source: ABdhPJyQ7CCmXTywKxDhDrU3RrhrzlYn16FTT/OFwg6lGeLoJd3r+t01cn9kYQUtfmGK0lw5z1Gai58BfxETvteuaX0=
X-Received: by 2002:a67:d319:: with SMTP id a25mr3553529vsj.57.1607540677782;
 Wed, 09 Dec 2020 11:04:37 -0800 (PST)
MIME-Version: 1.0
References: <3bed61807fff6268789e7d411412fbc5cd6ffe2a.1607507863.git.hns@goldelico.com>
 <CAGngYiVKHoXPGxmScCnb-R6xoo9GNw5pG8V8Cpyk3meoJbskiw@mail.gmail.com> <3FA1D050-3BD5-4A97-9D83-520CCF75D147@goldelico.com>
In-Reply-To: <3FA1D050-3BD5-4A97-9D83-520CCF75D147@goldelico.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Wed, 9 Dec 2020 14:04:26 -0500
Message-ID: <CAGngYiVL9M72hFRWnmT_8RRX9pUTSLsNuYz6mUo0Be4Vivk7Xw@mail.gmail.com>
Subject: Re: [PATCH] spi: dt-bindings: clarify CS behavior for spi-cs-high and
 gpio descriptors
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-gpio@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>, kernel@pyra-handheld.com,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Lukas Wunner <lukas@wunner.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        Maxime Ripard <maxime@cerno.tech>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Dec 9, 2020 at 1:16 PM H. Nikolaus Schaller <hns@goldelico.com> wrote:
>
> This is also what made me wonder if that is really intended because then
> the whole discussion about the cs-gpio-flags and inversion and the fixes
> would not have been needed. The current code and fixes are all about
> not ignoring the flags...

The inversion you witnessed was a bug caused by spi client drivers that
simply "plow over" the SPI_CS_HIGH mode flag. This includes the panel driver
you're using, see:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/gpu/drm/panel/panel-tpo-td028ttec1.c?h=v5.10-rc6#n337

You responded to this inversion bug by inverting your chip select, which made
things work again. Now that the bug is gone, you can indicate the correct
polarity in your devicetree, i.e. add 'spi-cs-high' for an active-high
CS, and leave it out for an active-low CS.

Your panel's CS is active-low, so it should not contain spi-cs-high.

> Secondly, please imagine some reader of a device tree who finds
>
>         cs-gpios = <&gpio 7 ACTIVE_LOW>;
>         spi-cs-high;

That reader looks at the rules, sees that:
- the ACTIVE_LOW is ignored,
- presence of spi-cs-high means active-high
and concludes this chip-select is active-high.
