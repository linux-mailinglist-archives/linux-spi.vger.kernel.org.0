Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13F3E1F679F
	for <lists+linux-spi@lfdr.de>; Thu, 11 Jun 2020 14:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728276AbgFKMKI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 11 Jun 2020 08:10:08 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:41556 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728264AbgFKMKH (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 11 Jun 2020 08:10:07 -0400
Received: by mail-oi1-f195.google.com with SMTP id a21so5159831oic.8;
        Thu, 11 Jun 2020 05:10:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lcgXSywPB08+B3kJ8noSU/N9DMgy+4xXYB/CxnY7Amg=;
        b=YlTfujDe8X3ycDRnEGMpvy3bI3Tq0C2HNBKvyHBn+b3eKbGpjTj1BPopvaFzcm4c6+
         /XkYAFrBbV3DlbIRnPnht+/dvtzUUJuQgNGQj2xMw6Ul4cPlp/m7hkFqmyzWlhJ4Xtjo
         T2WX62k3daDoVOGM6wssDUASmM4Ac+CpycC89ua56x/65V55krS9VlGA3/Dba9NiySJ7
         W5l+wxVK10jf53cb6tr9wdqb5cRSIbnDas91RDLiKfSIDmDMr4krpyflRcu5waBMHdAx
         X227idctfxto4tJgrqUeyKACQ2q+CKgBxPTy4bTMwYRwh2QVmYSdbvWE8n+dOEzR590A
         FooQ==
X-Gm-Message-State: AOAM533KxYHZl4DFqx84sQMs1Mw0mnlVVVL5iVqq3DColwRfvGpgjm6v
        emJr3ARUxdoeOommDDoIs11UR9LsGfc8bhDh37OP/Q==
X-Google-Smtp-Source: ABdhPJxkw8nBqOmM/doJ6JuZq8minHv6eu19aEc1wibYnTv7Nh6qLqRMw7fVRT/pWWz4P5jRTR0aBz/eVhKqpwoAW/s=
X-Received: by 2002:aca:1a19:: with SMTP id a25mr6016101oia.54.1591877405773;
 Thu, 11 Jun 2020 05:10:05 -0700 (PDT)
MIME-Version: 1.0
References: <1591736054-568-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1591736054-568-2-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20200610110810.GD5005@sirena.org.uk> <CAMuHMdWCHeSB9mjpdSX_-qxwo33kMb1_1R93CjBtVBPFPKkEOg@mail.gmail.com>
 <20200610164928.GJ5005@sirena.org.uk> <CAMuHMdUNo0tMxWsnXi4q8NwubPWHqTvzGOA-0hOr7oo2cRvvUg@mail.gmail.com>
 <20200611085004.GC4671@sirena.org.uk>
In-Reply-To: <20200611085004.GC4671@sirena.org.uk>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 11 Jun 2020 14:09:54 +0200
Message-ID: <CAMuHMdUBp79ix5hPjXBARTrOokg-pWY+Rdno9-dd6dBTv+TRcw@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: spi: renesas,sh-msiof: Add r8a7742 support
To:     Mark Brown <broonie@kernel.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Mark,

On Thu, Jun 11, 2020 at 10:50 AM Mark Brown <broonie@kernel.org> wrote:
> On Wed, Jun 10, 2020 at 09:18:19PM +0200, Geert Uytterhoeven wrote:
> > On Wed, Jun 10, 2020 at 6:49 PM Mark Brown <broonie@kernel.org> wrote:
>
> > > I'm much more comfortable explicitly listing the new compatible so that
> > > even if someone makes a DT that doesn't bother listing the fallbacks
> > > things will work.
>
> > Adding all of them would cause even more churn when adding support for
> > a new SoC... There are already more than 700 "renesas," compatible
> > values documented that are not directly matched by drivers.
>
> I'm not sure it's a particular concern, especially since you'll be
> sending this stuff in the same series as a bindings update and an extra
> patch in a series makes very little difference.

Until the DT bindings are split off into their own project...

Listing unneeded compatible values in drivers also increases binary size.
For RSPI and MSIOF that would be +2.5 KiB each.  Times tens of drivers.

Considering the RSPI driver itself is only 9 KiB, and some RZ/A1 systems
are really memory-constrained, I think it's better to avoid that.

> > Nowadays we have "make dtbs_check", so if a DTS doesn't conform to the
> > binding, it will be flagged.
>
> For things that are upstream.

The DT bindings apply to out-of-tree DTS files, too ;-)
If they're not compliant, all odds are off.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
