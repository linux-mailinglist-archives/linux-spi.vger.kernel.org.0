Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAC242EA99A
	for <lists+linux-spi@lfdr.de>; Tue,  5 Jan 2021 12:12:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729069AbhAELMX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 5 Jan 2021 06:12:23 -0500
Received: from mail-ot1-f41.google.com ([209.85.210.41]:40108 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728507AbhAELMX (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 5 Jan 2021 06:12:23 -0500
Received: by mail-ot1-f41.google.com with SMTP id j12so28886796ota.7;
        Tue, 05 Jan 2021 03:12:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PKWuouXVT2LKCbTQ8qdZ/IxRDTAiC46jRA6EblweW7E=;
        b=q0DXnjkKqc/ALGgGgLFgD/TFl9zSNWTaxeHXjXD8ksmj9Yd+bPJnjQ06xWkGyGa49R
         Esv/1d7zRcojU1ko44iFi0EXjdtJRFOt0U2aHPrphhCKxCTbD56whgYJJjTZr6NUigi8
         CyRu6GyZd47R2iZrkC0WHr+qjixmBIHS9KB/0vqsoT+QRkDiQwPTc8z7y2xWtudUpKUM
         +ByoizcLZMVye4TNh7HL0elx+WM4R3Gm3T/DZqlYr7spzJD8DV779RQH0pg4ldlbCNP7
         poZqOzPTZiM3xkpBr96DIR3V4mFAIGaWqa2PXsfv2l+Y3aEF9mAW29xCvOYRbYZuezym
         ttLQ==
X-Gm-Message-State: AOAM530qwMk9AB3Y74i4ameIP47EN/FOmRTVCKXlh7bbXlUSEpxLoix/
        TKHuLq7OtipCRoeUeMyxUbWQJBkJCJ1qTvZLyWw=
X-Google-Smtp-Source: ABdhPJwqiF4TOjyNjS4UTgBi+PQO+Lj6UEIAVNM8s91rL9edm4U7cXsMKxI3ldJ446P32/sYpurXE8MLAH+F2BbBcuY=
X-Received: by 2002:a05:6830:1f5a:: with SMTP id u26mr55990412oth.250.1609845102054;
 Tue, 05 Jan 2021 03:11:42 -0800 (PST)
MIME-Version: 1.0
References: <20201230145708.28544-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20201230145708.28544-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdVCD52-eTnEwftGz8ExMkZkJRyM=3M8zU11yhn1UNPxxA@mail.gmail.com>
 <CA+V-a8tHVkGxCECspfcV9c1UW81bod4N4YzRLJwU8zJ0+awJUw@mail.gmail.com>
 <20210104213005.GK5645@sirena.org.uk> <20210104234018.GA19909@amd>
 <CAMuHMdUjevJ+DgJGnPUN0+ctxm2ML1NYSTgYsjC4c8tDqjUkxQ@mail.gmail.com> <20210105104234.GA29908@amd>
In-Reply-To: <20210105104234.GA29908@amd>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 5 Jan 2021 12:11:31 +0100
Message-ID: <CAMuHMdXOD_vGOYKHS+gVP+RBf_R3tmN2y0SvnphO56kvAiyM-Q@mail.gmail.com>
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

On Tue, Jan 5, 2021 at 11:42 AM Pavel Machek <pavel@denx.de> wrote:
> > On Tue, Jan 5, 2021 at 12:40 AM Pavel Machek <pavel@denx.de> wrote:
> > > > > > >                 .name   = "rpc-if-spi",
> > > > > > > -               .pm     = DEV_PM_OPS,
> > > > > > > +               .pm     = &rpcif_spi_pm_ops,
> > > >
> > > > > > You're aware rpcif_spi_pm_ops is now always referenced and thus emitted,
> > > > > > increasing kernel size by 92 bytes if CONFIG_PM_SLEEP=n?
> > > > > > This may matter for RZ/A SoCs running from internal SRAM.
> > > >
> > > > > Hmm didn't realise this would be an issue on RZ/A.
> > > >
> > > > > Mark, could you please drop this patch from your branch.
> > > >
> > > > Please send an incremental patch with an appropriate changelog.
> > >
> > > Let's fix this properly. I'm pretty sure we have some macros that can
> > > solve this without re-introducing the ifdefs...
> >
> > There's pm_ptr(), but it uses CONFIG_PM as a selector, not CONFIG_PM_SLEEP.
>
> Okay; so we could introduce pm_sleep_ptr().
>
> Or we could just put single #ifdef CONFIG_PM_SLEEP around the .pm
> assignment? That would be improvement on the original, and still
> result in the same binary, right?

Indeed.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
