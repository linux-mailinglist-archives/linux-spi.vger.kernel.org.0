Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4C7C212728
	for <lists+linux-spi@lfdr.de>; Thu,  2 Jul 2020 16:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729883AbgGBO53 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 2 Jul 2020 10:57:29 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:38659 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbgGBO52 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 2 Jul 2020 10:57:28 -0400
Received: by mail-oi1-f193.google.com with SMTP id r8so23882369oij.5;
        Thu, 02 Jul 2020 07:57:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4Uyr88816PZugcDabz3B+8YDv9OegHQr/fvn7LXL7Q8=;
        b=KpfN1XMmjZXaeuccgakxXYkgbrczna12RJrU4uGKE3uWzAXPBdl97OU5RZYs6Msvec
         VgvYq0//1wMhdyWeFvrDHes88SeJIzqtjp55SWUQR5NOkrMGL8YC/OIFxsW+IeXm6fLX
         7Rwu+kh+H8XFfeRweH/wnlkl/RzQGjzbQl5JtGQdPfdzME03a5dR935WwN2VIJr11Y0R
         5//gO8n1hzuYvvicVsQpLFOokezAd2lxTbAX1nkXwXG/RYY4cgMxHEdLNGYPJfpB5pZ8
         yirO9Vmiibz19T/J9Eh5CxdSfAUXNhU8GL2S13Um4jl6a31wP7Tog3tkd1qnfOMwCe6o
         gl0Q==
X-Gm-Message-State: AOAM533IAG924FGstZ34+jwQaTEwc2eMe+fffuSFBygI4tSkn0snYYr8
        X+8Q1MoJBY/Uo0jNN/ubUX9OPai/xhffc1/B/IA=
X-Google-Smtp-Source: ABdhPJx/jvawRsi+Z9Sgj6edBFdRwzz34sAQe2zWDP2cqfDS3WNm1w/Tyw6Lk0ofZGhde6JwQgAimZPRvBA30LYdYZE=
X-Received: by 2002:aca:ac10:: with SMTP id v16mr4965871oie.153.1593701847154;
 Thu, 02 Jul 2020 07:57:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200702141846.7752-1-frieder.schrempf@kontron.de>
 <20200702142511.GF4483@sirena.org.uk> <24ec4eed-de01-28df-ee1f-f7bcfc80051a@kontron.de>
In-Reply-To: <24ec4eed-de01-28df-ee1f-f7bcfc80051a@kontron.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 2 Jul 2020 16:57:15 +0200
Message-ID: <CAMuHMdUkHxOqqX95R5BEET-aSF5SYw2zufnxWuqmKnSY0NENcQ@mail.gmail.com>
Subject: Re: [PATCH] spi: spidev: Add compatible for external SPI ports on
 Kontron boards
To:     Frieder Schrempf <frieder.schrempf@kontron.de>
Cc:     Mark Brown <broonie@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Frieder,

On Thu, Jul 2, 2020 at 4:46 PM Frieder Schrempf
<frieder.schrempf@kontron.de> wrote:
> On 02.07.20 16:25, Mark Brown wrote:
> > On Thu, Jul 02, 2020 at 04:18:46PM +0200, Schrempf Frieder wrote:
> >> From: Frieder Schrempf <frieder.schrempf@kontron.de>
> >>
> >> Allow external SPI ports on Kontron boards to use the spidev driver.
> >
> > I'd have expected this to require loading a DT overlay for whatever's
> > attached?
>
> My intention is to use the spidev driver in the default board DT for an
> interface that is routed to an extension connector and has no dedicated
> slave device attached onboard. So users can attach sensors, etc. with
> userspace drivers without touching the kernel or DT.
>
> See https://patchwork.kernel.org/patch/11639075/ for the boards DT.

You can bind "kontron,user-spi" devices to spidev from userspace:
[PATCH v2 0/3] device tree spidev solution - driver_override for SPI
https://spinics.net/lists/linux-spi/msg13951.html

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
