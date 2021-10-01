Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C511341E960
	for <lists+linux-spi@lfdr.de>; Fri,  1 Oct 2021 11:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352736AbhJAJIS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 1 Oct 2021 05:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbhJAJIR (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 1 Oct 2021 05:08:17 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA219C061775;
        Fri,  1 Oct 2021 02:06:33 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id g6so1949404ybb.3;
        Fri, 01 Oct 2021 02:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=sxJ7l8B7Ljw39q9CkARpipwcpIu37e5gtQDM+cATqHE=;
        b=ElWaZIBpBrKhdeB7VeSlSnwX3ldr2KIWRlbDEFLg/2pZL1nQW3eUOG8slMcyFt4C5s
         jY09wxwXwzndohjHjnAsTnDwEhwPbhwj5V8QvrcYJwHtsGuNsE2EGRiyjaKQTwivnw83
         8Z4B1U5GQc1gcCTmNAlugx5BPmWUMe7fPjtqyon4hm+tfeqf651n8SkcEJxp12bhbqC0
         tztieSewqmlB1f+ejEfgFS5vjKax9sp9cbDuahW2dTAX9TzoVedzdl3xFI/X4RFN63DB
         d1ZBbx800WT18OTmZuI+2ZF8Zs+9gJjWvAXcvMtaulbtuKkrsnMMe66sbYvr+eJFjWU8
         8zPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=sxJ7l8B7Ljw39q9CkARpipwcpIu37e5gtQDM+cATqHE=;
        b=kinfkd0p08KoYWJeZJMZiWrWbsczZaXj8zhC1Lhd7SctSoY45NCt/pgTB57qXwm5Zr
         U5mHEhk3fOLhugTvoTAx/wc9exFMmk1DLPT5WZf+Ozuh28YWBtnc00Ndfi47U87o4A6e
         nBR3iLz5Kahw4XFsB83cf809zwMPQPEieER3TJRrBJzMW9oLdf7dgyCCFWwh4UDNd/zj
         jYskXoKBKiCRUCY+svlc/zGPJijCWX2Tn92lnTWMQl1fTgBmdYOeY9iEVRVhcu6IrWXl
         UEVbZF5cEf+8wY9E3C3ybvGMatvRuOAYwuzcKC7CaoqwemSB7x8ZkZEstSoc5jCchgqE
         bKEQ==
X-Gm-Message-State: AOAM530GTtumNrZ2rVo1KdhmPyxmxzCd/Oc5UZDWqsKdq/zjJwcjkjYe
        htRvleq5ngsz8ygzzcVT1GbS1z6kGFLWZFll1wAJI2Cb6VY=
X-Google-Smtp-Source: ABdhPJwa0O6LDb69yBOtSHQNzBKwyjv3RDtcol0EkDQPnWG9G5+YLs2EdsLK8pb4psp9jvGVSpDiTV07qnieumlyfoQ=
X-Received: by 2002:a25:1c02:: with SMTP id c2mr4943436ybc.218.1633079192918;
 Fri, 01 Oct 2021 02:06:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210928140721.8805-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20210928140721.8805-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <YVXMc1A4D/y4kjim@shikoro> <CA+V-a8sDSsyTGfTeQfG_ZhfrJHCm+2kBTEDWaoFMTgsMOmxEgQ@mail.gmail.com>
 <YVbM3z7x+D0MCkTF@ninjato>
In-Reply-To: <YVbM3z7x+D0MCkTF@ninjato>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Fri, 1 Oct 2021 10:06:06 +0100
Message-ID: <CA+V-a8uyQmW3+4hAt4534spKeQHDoeZzuJJE4RY70KLZfYOXoA@mail.gmail.com>
Subject: Re: [PATCH 6/6] memory: renesas-rpc-if: Add support for RZ/G2L
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Mark Brown <broonie@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-mtd@lists.infradead.org,
        linux-spi <linux-spi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Wolfram,

On Fri, Oct 1, 2021 at 9:55 AM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> Hi Prabhakar,
>
> > > Is RPCIF_CMNCR_IO3FV and RPCIF_CMNCR_IO2FV actually documented in your
> > > datasheets? I am asking because I have a patch pending to remove writing
> > > to undocumented locations. So, I was aboout to remove the IO3FV and
> > > IO2FV macros.
> > >
> > Yes they are documented, you should be able to download the HW manual from [1]
>
> Great, then I will keep them!
>
> > > > +     regmap_write(rpc->regmap, RPCIF_PHYADJ2, 0x00008080);
> > > > +     regmap_write(rpc->regmap, RPCIF_PHYADJ1, 0x80000024);
> > >
> > > Can't we have defines for these magic values? At least in my latest Gen3
> > > documentation, these values are explained.
> > >
> > RZ/G2L manual doesn't explain these bits. Let me refer to R-Car Gen3
> > and define them as macros.
>
> Seems like we have the best of both worlds then with the documentation
> ;)
>
Indeed :)

> > > > +     if (rpc->type == RPCIF_RCAR_GEN3) {
> > > > +             regmap_write(rpc->regmap, RPCIF_PHYCNT, RPCIF_PHYCNT_STRTIM(7) |
> > > > +                          RPCIF_PHYCNT_PHYMEM(hyperflash ? 3 : 0) | 0x260);
> > > > +     } else {
> > > > +             regmap_read(rpc->regmap, RPCIF_PHYCNT, &dummy);
> > > > +             dummy &= ~RPCIF_PHYCNT_PHYMEM_MASK;
> > > > +             dummy |= RPCIF_PHYCNT_PHYMEM(hyperflash ? 3 : 0) | 0x260;
> > > > +             regmap_write(rpc->regmap, RPCIF_PHYCNT, dummy);
> > >
> > > regmap_update_bits?
> > >
> > Im a bit hesitant to use regmap_update_bits() here as some of the bits
> > are not documented.
>
> Hmm, maybe I should then update the patch avoiding undocumented register
> access beforehand? I will download your docs and see what remains and
> send that out for you to check. Somewhen later today.
>
> Sounds good?
>
Fine with me.

Cheers,
Prabhakar

> Happy hacking,
>
>    Wolfram
>
