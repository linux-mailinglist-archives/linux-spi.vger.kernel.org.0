Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC848104E75
	for <lists+linux-spi@lfdr.de>; Thu, 21 Nov 2019 09:54:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbfKUIyU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 21 Nov 2019 03:54:20 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:34631 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbfKUIyT (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 21 Nov 2019 03:54:19 -0500
Received: by mail-oi1-f196.google.com with SMTP id l202so2528290oig.1;
        Thu, 21 Nov 2019 00:54:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0Bz/aVHhrSp8CJz37MAck0aUQWH98Jp3Ah7Te9LIS/w=;
        b=D8fU+rZ0XM97dU4r/q4YuuSYzGXJiKpuqvAvzFlEjFn8fd5h01zHF/9IRi/elnHPaW
         I/viH1ZrOYJhQkO8VqqUhHMtowvmSfcQnk1Tw4OOO30YIufDWGb3Bf+W5OyjFhC9PIv5
         9dYb+yrM+6QwfhVu99Ygd47pZAPSp3l7DNWCZznRO+QvCqE3EjaZW9OTgRko/2FcC0mi
         z1brto+siocmZV6Ov8uTBlNUInWOgqXs1yxg3JORsvwJvaFHGqVLusa153R8kvtl+74A
         R557RMU4mOFggGKwZOErIrDdZjk13+Dlsy1MUG4E9W7/rLp019a+4HgxTnAbishjIHjH
         Po9Q==
X-Gm-Message-State: APjAAAWL2sYtmTM0MmeeSW8U68dFnAgdDnMYKayvpW7pTJvK0JT6gDNB
        +h09rGxo4pk20Z5xaF7SeCoB6taHDT2WeHS0tHU=
X-Google-Smtp-Source: APXvYqy63gFddvDFxSz98+Mi9qFRnc5TV/efryWReTeB7bid0RErw87Z4cN/QpUnbeDKqKnOiDSKhC/TIBzC7AfkiVw=
X-Received: by 2002:aca:3a86:: with SMTP id h128mr6376241oia.131.1574326457337;
 Thu, 21 Nov 2019 00:54:17 -0800 (PST)
MIME-Version: 1.0
References: <20191121080954.14915-1-peter.ujfalusi@ti.com> <CAMuHMdVWCM_LQ5Fx+3NMhyd21LSpYQWCX2pmtkU2tHvtzDzUzw@mail.gmail.com>
 <c14dd693-74e6-7e48-9697-849f44b8e0d9@ti.com>
In-Reply-To: <c14dd693-74e6-7e48-9697-849f44b8e0d9@ti.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 21 Nov 2019 09:54:06 +0100
Message-ID: <CAMuHMdWXffsC4rYDHggS6CDRnnR_kh1Td=98a0TRPeSUtSKhDw@mail.gmail.com>
Subject: Re: [PATCH] spi: pic32: Retire dma_request_slave_channel_compat()
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     Mark Brown <broonie@kernel.org>, Vinod <vkoul@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Peter,

On Thu, Nov 21, 2019 at 9:40 AM Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
> On 21/11/2019 10.30, Geert Uytterhoeven wrote:
> > On Thu, Nov 21, 2019 at 9:11 AM Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
> >> There is no reason to use the dma_request_slave_channel_compat() as no
> >> filter function and parameter is provided.
> >>
> >> Switch the driver to use dma_request_chan() instead.
> >>
> >> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> >
> >> --- a/drivers/spi/spi-pic32.c
> >> +++ b/drivers/spi/spi-pic32.c
> >> @@ -609,22 +609,18 @@ static void pic32_spi_cleanup(struct spi_device *spi)
> >>  static void pic32_spi_dma_prep(struct pic32_spi *pic32s, struct device *dev)
> >>  {
> >>         struct spi_master *master = pic32s->master;
> >> -       dma_cap_mask_t mask;
> >>
> >> -       dma_cap_zero(mask);
> >> -       dma_cap_set(DMA_SLAVE, mask);
> >> -
> >> -       master->dma_rx = dma_request_slave_channel_compat(mask, NULL, NULL,
> >> -                                                         dev, "spi-rx");
> >> -       if (!master->dma_rx) {
> >> +       master->dma_rx = dma_request_chan(dev, "spi-rx");
> >
> > Why not dma_request_slave_channel()?
>
> The longer term plan is to retire dma_request_slave_channel() as well.
> With dma_request_chan() deferred probing against DMA drivers is possible
> and it also supports legacy boot with dma_slave_map.
>
> At the end we should be left with only dma_request_chan() for slave
> channels in the kernel.

Thank you, deferred probing is a valid argument.
You may want to add that to the patch description.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> > That way you...
> >
> >> +       if (IS_ERR(master->dma_rx)) {
> >
> > ... don't have to change the NULL check here, and...
> >
> >>                 dev_warn(dev, "RX channel not found.\n");
> >> +               master->dma_rx = NULL;
> >
> > ...  don't have to override by NULL here.
>
> It is a small sacrifice, true, but if anyone cares the driver can
> support deferred probing with dma_request_chan().

Deferred probing in case of missing DMA controllers is always a bit
tricky, as there are multiple options:
  1. Defer probing of the slave driver,
  2a. Continue probing of the slave driver, fall back to PIO (which is
      what this driver does)
  2b. and Retry DMA setup later.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
