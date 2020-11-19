Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F59D2B9B82
	for <lists+linux-spi@lfdr.de>; Thu, 19 Nov 2020 20:31:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727617AbgKSTa0 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 19 Nov 2020 14:30:26 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:35706 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727231AbgKSTaZ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 19 Nov 2020 14:30:25 -0500
Received: by mail-ot1-f68.google.com with SMTP id n11so6454281ota.2;
        Thu, 19 Nov 2020 11:30:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5Ecn4UiWlcgp/o5Zc8vmAt9tSib8lHYaxaJsU9eKOvE=;
        b=ePaD4yxdYYiDGQ4nBl8phlWRWG4unRLBy3878XTgzIqlY8uIhcOxM8SgOFJK9gNVA5
         pG6yqycV+ku8GNMim8Z2Armn3NJjDS91u5RuBKJ0U7v4kRGE0trwJE7+dBPBy/yVDmV3
         1uWt5f4T18GTSqwL2AKN8SkjvXhLbBPugpakBMloDLAi6OnHhxpQrW46lAS1LFkaAM8W
         HWoB/Fse14bG5rkiFYmgWe/PhTUKUpMd8dP3g0PQEnxx4m25f/GvcCuTgzygSAwxZzHs
         vBZ9REC6YaeNJNIoxtqf/pF+S2vRKSZERHBAPPQyc3SM+0yQI32FYK5vyLcZjGrpdaHd
         h50g==
X-Gm-Message-State: AOAM5334UjSBeVnF8Px+wOojVIKubbtyFxc09kGuQh5o6QqOslw0hK3H
        xZyMGqQCACv7ai9Nyf/r8EMXXGcyArA4uMJDBW6YmAwBIK4=
X-Google-Smtp-Source: ABdhPJyj2PK7ieqi+RRoQYd0DEormOY9vUbamt4wvlggoX93TyjgNwZhsHlT0MdQhioQNovo7qVLMOyuqDA8KfGo0dU=
X-Received: by 2002:a9d:5e14:: with SMTP id d20mr10559942oti.107.1605814224133;
 Thu, 19 Nov 2020 11:30:24 -0800 (PST)
MIME-Version: 1.0
References: <20201117094517.5654-1-Sergey.Semin@baikalelectronics.ru>
 <20201118131604.GC4827@sirena.org.uk> <20201118162931.sdpofyw74yyr5n5z@mobilestation>
 <20201119184340.GJ5554@sirena.org.uk>
In-Reply-To: <20201119184340.GJ5554@sirena.org.uk>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 19 Nov 2020 20:30:12 +0100
Message-ID: <CAMuHMdWv4MAdqf1EBGSybw=2-hNeeEf3TWiH7ZhQBa-Ad9++Ag@mail.gmail.com>
Subject: Re: [RFC PATCH] spi: Take the SPI IO-mutex in the spi_setup() method
To:     Mark Brown <broonie@kernel.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Mark,

On Thu, Nov 19, 2020 at 7:45 PM Mark Brown <broonie@kernel.org> wrote:
> On Wed, Nov 18, 2020 at 07:29:31PM +0300, Serge Semin wrote:
> > On Wed, Nov 18, 2020 at 01:16:04PM +0000, Mark Brown wrote:
> > > Yeah, problems with it are very common as the documentation has noted
> > > since forever.  IIRC there was some problem triggered by trying to force
> > > it to be serialised but I can't remember what it was.
>
> > Does it mean nack for this patch from you? So you suggest to fix the controller
> > driver instead, right? If so the best solution would be to just lock the
> > IO mutex in the set_cs callback of the DW APB SSI driver...
>
> I'm not 100% clear what the original issue was, given that this is a
> constant source of errors in drivers it seems like it should be better
> to change the core but since I don't know why we have this the way it is
> it's hard to tell what special cases we might have that could explode if
> we try to do so.  I *think* the main issue is things that don't actually
> have separate per device registers trying to configure the single set of
> controler registers shared by all devices in which case the locking is
> fine and helps with this specific case where it's a read/modify/write
> operation on per device stuff and this makes sense.

It's also an issue on SPI controllers with a single native chipselect,
tricking the driver author into believing that writing to registers
during .setup() is not an issue.  Until an integrator starts using
cs-gpios...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
