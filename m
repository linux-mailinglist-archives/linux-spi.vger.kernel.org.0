Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EBB32214DB
	for <lists+linux-spi@lfdr.de>; Wed, 15 Jul 2020 21:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726356AbgGOTHO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 15 Jul 2020 15:07:14 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36613 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbgGOTHJ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 15 Jul 2020 15:07:09 -0400
Received: by mail-ot1-f65.google.com with SMTP id 72so2326426otc.3;
        Wed, 15 Jul 2020 12:07:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wY3QJfcVyJVpfiCFE28joz64Cm4Q2M/EKmJjz4Xq+cU=;
        b=Of7pKTd0k4ziHZvSXNok636YknyMHuVx0tzteD1AdH+OUkxZDAyBlY4bN4t0vzdCm4
         mYEcO/h/+OV6zKeEIdUJYH8JspV1UuTW07Ayf2FCdp2uDDwkYKgm8zdTmF+XvAGx/eWp
         suwWr1vyRyyXlcagK6fKNKTh0dZ1dAeYz4DqdULhAS+cWQtR04FUz+G3bTp63RljWyPT
         21UuHGEL+VgBPv1bDhXeQkoOAm3TWUUDYDp9PWKOvfp3YhGVBGHOkgR+/oqN1q8tNgu/
         KmX7uxa85YB1hadTAw3AF9A6FRY6tcAPHEIXLRiypOKJFEo1pBUpjCz/c81gTdH7vqKY
         liMw==
X-Gm-Message-State: AOAM531I8ZyLMq/hVZ7bv1zM2lmdmuS6jSrZ0C79wm/1BYlJcSjoM6so
        HJELicId4ibT655cLgq3jmCjN0AnWTvyX9ViFQj1aT6hlbI=
X-Google-Smtp-Source: ABdhPJxtrf7cwMquZAhltJT4Egsrp/5t1aoR1MZy5Jh+6xdpWTbNqaY8bo8KHyVr/g4KW4MfbR6Q0i0+fj1ED2AGIc0=
X-Received: by 2002:a9d:2646:: with SMTP id a64mr999765otb.107.1594840027946;
 Wed, 15 Jul 2020 12:07:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200702141846.7752-1-frieder.schrempf@kontron.de>
 <20200702142511.GF4483@sirena.org.uk> <24ec4eed-de01-28df-ee1f-f7bcfc80051a@kontron.de>
 <20200702150725.GI4483@sirena.org.uk> <479d566a-213f-4e33-8ac7-7637ae88e31c@kontron.de>
 <a5b88ad9-3884-1d9c-c4ad-057266f84261@kontron.de> <20200713151108.GB4420@sirena.org.uk>
In-Reply-To: <20200713151108.GB4420@sirena.org.uk>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 15 Jul 2020 21:06:56 +0200
Message-ID: <CAMuHMdUYnMkobQBVLWkL-n8HLHGVOTqDs7H7kaYN6gPQmV_A7A@mail.gmail.com>
Subject: Re: [PATCH] spi: spidev: Add compatible for external SPI ports on
 Kontron boards
To:     Mark Brown <broonie@kernel.org>
Cc:     Frieder Schrempf <frieder.schrempf@kontron.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Jul 13, 2020 at 5:11 PM Mark Brown <broonie@kernel.org> wrote:
> On Mon, Jul 13, 2020 at 03:19:52PM +0200, Frieder Schrempf wrote:
> > I would have expected that there is some kind of existing userspace API to
> > load an overlay manually, but it seems like there isn't!?
>
> > So what's the reasoning behind this? How can I solve this in a
> > mainline-compliant way, meaning without either keeping downstream patches to
> > bind spidev to my device or writing and maintaining code that does the
> > overlay loading?
>
> Basically the reasoning is that nobody's done it rather than any grand

Nah, it's been done, but a bit unsafe, if you don't know what you're doing
("with great power come great responsibilities").

Please check out https://elinux.org/R-Car/DT-Overlays
I do my best to keep topic/overlays branch up-to-date, and working.

> design not to do it.  There's some issues for more complex connectors
> present on multiple boards with mapping the same connector onto multiple
> boards where a resource on the connector might be provided by different
> things on the base board so it's not quite as trivial for them as it
> should be.

There's a big list of issues at
https://elinux.org/Frank%27s_Evolving_Overlay_Thoughts
In other words: more work to be done, to polish it, and make it safe(r).

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
