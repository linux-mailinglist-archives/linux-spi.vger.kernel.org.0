Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF4F319F54
	for <lists+linux-spi@lfdr.de>; Fri, 12 Feb 2021 14:05:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbhBLM61 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 12 Feb 2021 07:58:27 -0500
Received: from mail-ot1-f52.google.com ([209.85.210.52]:34060 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231992AbhBLM6R (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 12 Feb 2021 07:58:17 -0500
Received: by mail-ot1-f52.google.com with SMTP id y11so8285942otq.1;
        Fri, 12 Feb 2021 04:58:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mB82SPJ4sUvAP/MTxvyjnaDxWnUMLJPL3SryNf3taAk=;
        b=YZ/i4MmMCTmxQ04u7TvYVt4ToDrKDc9ERUy1pht4dj5x89rN9z4N6VIArZlwlP2mL0
         wrV3Ds5RtB19n7Xu6nkqX+l9R+jP144fr+Ras0gh6Z5VOET7cqyWyKjtat8w+NYrskLC
         R2J0FXVRoqGCJpcBMiTN8RItHkgl4kPZxQFrrtTZ012TOO/aJGBtKRpp8JbsyaQVqLHF
         a4cHiSv1/fl766HYtKs4lXt9kJuioggq7+nyect5uCEYpGRCR4HLh/MMdUyZfTBDgio1
         Bmx2Klfrg31vAmiuxLbOduUxZPBBsoI0bxsPVhW64tQtgyy2RyicAjcZ807IfN8I3fPi
         Iopw==
X-Gm-Message-State: AOAM5321UlgBSZH5SjgfzrE6wnWje6/uYuAHMk3GPUfTcf3bCjcuNKG5
        mnN0EP56n6uv58eMjlv3ABnI5RVeYZMDqstDI00=
X-Google-Smtp-Source: ABdhPJwnyP+eMYhUW4fMTvm0ei6SwIsXJsXKH3glrcwdP0FZaSBkvxqf6xGDd+dlDKDq88AJQrmxppgM39vwB7AYHQc=
X-Received: by 2002:a9d:77d6:: with SMTP id w22mr1866225otl.145.1613134656073;
 Fri, 12 Feb 2021 04:57:36 -0800 (PST)
MIME-Version: 1.0
References: <20210211180820.25757-1-nsaenzjulienne@suse.de>
 <20210212123118.GB6057@sirena.org.uk> <cd41a204107900c890b0234847fa0b62701f74cc.camel@suse.de>
 <20210212125221.GD6057@sirena.org.uk>
In-Reply-To: <20210212125221.GD6057@sirena.org.uk>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 12 Feb 2021 13:57:24 +0100
Message-ID: <CAMuHMdXFt-0vyBQnvwWim8MrijZ-PNN0HsO+dDp9iMzb2153Hg@mail.gmail.com>
Subject: Re: [PATCH] spi: Skip zero-length transfers in spi_transfer_one_message()
To:     Mark Brown <broonie@kernel.org>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Phil Elwell <phil@raspberrypi.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Mark,

On Fri, Feb 12, 2021 at 1:55 PM Mark Brown <broonie@kernel.org> wrote:
> On Fri, Feb 12, 2021 at 01:48:21PM +0100, Nicolas Saenz Julienne wrote:
> > On Fri, 2021-02-12 at 12:31 +0000, Mark Brown wrote:
> > > On Thu, Feb 11, 2021 at 07:08:20PM +0100, Nicolas Saenz Julienne wrote:
>
> > > > -         if (xfer->tx_buf || xfer->rx_buf) {
> > > > +         if ((xfer->tx_buf || xfer->rx_buf) && xfer->len) {
>
> > > I think the issue here is more that some users were passing in buffers
> > > with zero length transfers, the above check was already intended to
> > > catch this case but was working on the assumption that if there was
> > > nothing to transfer then no buffer would be provided.
>
> > Fair enough, maybe it makes sense to move the check into __spi_validate() and
> > propagate an error upwards?
>
> No, I think it's fine - there's probably some sensible use case with
> drivers reusing a statically allocated transfer/buffer set for multiple
> operations and just tweaking the length as needed which seems a bit
> weird but I can't think of a reason not to allow it.  Your patch is
> currently queued, all being well it'll get tested & pushed out later
> today.

Aren't the zero-length transfers also used to do tricks with the CS signal,
e.g. combined with cs_change?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
