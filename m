Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A90072EA614
	for <lists+linux-spi@lfdr.de>; Tue,  5 Jan 2021 08:38:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725776AbhAEHiu (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 5 Jan 2021 02:38:50 -0500
Received: from mail-ot1-f43.google.com ([209.85.210.43]:43218 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbhAEHiu (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 5 Jan 2021 02:38:50 -0500
Received: by mail-ot1-f43.google.com with SMTP id q25so28462174otn.10;
        Mon, 04 Jan 2021 23:38:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GsNvvjXAbzsv+FuZnPwVumTRC/6Ac/joNVlKb3haP0E=;
        b=LdcHuWYc10jHSdiL2MPZmUXrqLBpNkZuoTEsENhRUO5xVeFunO2uD2u9gd43vaF6EQ
         A2xCtzzaZTddw5za8nvy0dk3z6VzkHX08BXIAaPs+UIAh+w30+aF/39iONssZHQ4KeHR
         WM8/2r2DNEgZwsK5kPkp6bYn/7i/XW/ZJYFl6uay9pUll3ruRfQ3sUTrjnsqxOdk20L2
         6VAkGtSMJN1NLFSSHCWGOAIb8X3Q49vJ0puVk5UG69B6pU5glBWqi5LDF2Zm8JWpGEfT
         7SvNyGOmuYoi91QRoQ3RMFD2EEWRuIrdZZ/BvX3YsUPyXdsD7MRoAyMZleLwbCn46cwb
         wTgQ==
X-Gm-Message-State: AOAM5335JzJ3ur4OpCawZQ8RU+rUNjlOCTEHBa1KKAZhV2rLgb3L18ZG
        sZZOSXbqVQHFCX9kAlwYoXrjKo1KmDbJbCxjqkUUJJ52
X-Google-Smtp-Source: ABdhPJwB+S8gEdiHn6ODfi9YxxQh9Cv4/z6wLqvckXr6+hvgNE+BXWFVrjwOj1L9L0d/aO9eztlGefYOck6oZBpJRno=
X-Received: by 2002:a9d:c01:: with SMTP id 1mr40244802otr.107.1609832289668;
 Mon, 04 Jan 2021 23:38:09 -0800 (PST)
MIME-Version: 1.0
References: <20201230145708.28544-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20201230145708.28544-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdVCD52-eTnEwftGz8ExMkZkJRyM=3M8zU11yhn1UNPxxA@mail.gmail.com>
 <CA+V-a8tHVkGxCECspfcV9c1UW81bod4N4YzRLJwU8zJ0+awJUw@mail.gmail.com>
 <20210104213005.GK5645@sirena.org.uk> <20210104234018.GA19909@amd>
In-Reply-To: <20210104234018.GA19909@amd>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 5 Jan 2021 08:37:58 +0100
Message-ID: <CAMuHMdUjevJ+DgJGnPUN0+ctxm2ML1NYSTgYsjC4c8tDqjUkxQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] spi: rpc-if: Remove CONFIG_PM_SLEEP ifdefery
To:     Pavel Machek <pavel@denx.de>
Cc:     Mark Brown <broonie@kernel.org>,
        "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Jiri Kosina <trivial@kernel.org>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Chris Brandt <Chris.Brandt@renesas.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Pavel,

On Tue, Jan 5, 2021 at 12:40 AM Pavel Machek <pavel@denx.de> wrote:
> > > > >                 .name   = "rpc-if-spi",
> > > > > -               .pm     = DEV_PM_OPS,
> > > > > +               .pm     = &rpcif_spi_pm_ops,
> >
> > > > You're aware rpcif_spi_pm_ops is now always referenced and thus emitted,
> > > > increasing kernel size by 92 bytes if CONFIG_PM_SLEEP=n?
> > > > This may matter for RZ/A SoCs running from internal SRAM.
> >
> > > Hmm didn't realise this would be an issue on RZ/A.
> >
> > > Mark, could you please drop this patch from your branch.
> >
> > Please send an incremental patch with an appropriate changelog.
>
> Let's fix this properly. I'm pretty sure we have some macros that can
> solve this without re-introducing the ifdefs...

There's pm_ptr(), but it uses CONFIG_PM as a selector, not CONFIG_PM_SLEEP.

> (Besides... 92 bytes. How big is kernel these days? 4MB? More? How
> much SRAM do you have?)

92 bytes is indeed not much (on 64-bit it would be doubled).
Still, it's good to make people think about innocent looking changes,
once in a while.

RZ/A1H and RZ/A1M have 10 resp. 5 MiB of SRAM.
RZ/A2 has 4 MiB SRAM, which is sufficient to run Linux when used with
XIP (requires a one-line Kconfig change rmk has been vetoing for years).

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
