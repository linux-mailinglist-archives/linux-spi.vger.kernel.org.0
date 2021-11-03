Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61BB6443F10
	for <lists+linux-spi@lfdr.de>; Wed,  3 Nov 2021 10:13:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231913AbhKCJP4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 3 Nov 2021 05:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231925AbhKCJP4 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 3 Nov 2021 05:15:56 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA91C061205;
        Wed,  3 Nov 2021 02:13:20 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id d10so4763095ybe.3;
        Wed, 03 Nov 2021 02:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=B9PO03tEZQxGDCWOiWP9E4WHsaZ/xui8yPJ2nq9Ie+E=;
        b=KNkljUFA7c2Z2y1ulLlQsP7Ck0sCiTe9vVMCyYsujALg8/+6C1sTuzdfujkKce2TSP
         2qc3FJADfMuB/Dkf3wAWX1tNWyKGhsi1X/vIYT2I4dFb63ADvugoIAjwBSoyf1YVnCuP
         UjYlAlHZcTxh0mAA4eF++mz/VcVZH/iXBLc5TBoplRRfdKWSc24lMgXTGcX1Mo//I4lb
         0wBsK+ruU1brPD+R1um24lQM9ztWRNvk7R2gcznkFTeJy5TuZjos7StSNgZ5u4dJUh8y
         EQg/PS+44XnptkjqcWiQ438ZCekYA8zhoxGBkJYeVkUfHs3DqCDZ2J8TuLeP48JKv9Fe
         IpKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=B9PO03tEZQxGDCWOiWP9E4WHsaZ/xui8yPJ2nq9Ie+E=;
        b=qjze0JxdvXZdTesxmngL0FM8MI1Y6BKhRQ5T3zOgOQKU8RZErcKJnqUe7gbv+7b8ov
         Jsl+MLYZZOMZLOGNBEaGR4Ld7Rbsgejn7+FKUSBK5Y1LfNnX3W6KbPaASWMV5u6xo78g
         d+PQuydPbNA8H7CxELm4asxfiTz8e8EzcmSjr7WiuVuve5Z641QmsizP5tsBy8wQ3yBp
         J+IxW+8xlrKV3DSlE2uOqJ4j1tdzErmvggCOTcBZLOeeXQmVLSN0DrVmTEZqfRDluwme
         G3HT5xcfwkXlPsAHuceyXrzoKlmshcF524wLObg76yRO3e2luwe5fQyv0ZuZmzhrxNNb
         UaSA==
X-Gm-Message-State: AOAM530ojlcCuYhGZxsEDTigbRnlTqRCrObNPahpeIAzuI67mIIVdZCs
        hOR284oknolZSM1xTW/SarJecfpHNWS7pLpEC2cofGoWZ79b0g==
X-Google-Smtp-Source: ABdhPJy1YH1/YROO6BKv2SUado0SiJ9R1kr1ijbKaVjaSEbKjRERIu7xzUuf3qc1RKL89AnRU8esbXV+6wS1mZageH0=
X-Received: by 2002:a25:dc4d:: with SMTP id y74mr16947684ybe.422.1635930799289;
 Wed, 03 Nov 2021 02:13:19 -0700 (PDT)
MIME-Version: 1.0
References: <20211025205631.21151-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211025205631.21151-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <YYElefbpP4pwfmUl@shikoro> <CA+V-a8uJxeSr=uoF14gccuSLG7WRqRk8X8uD9UDoxKPGM8hGgQ@mail.gmail.com>
 <YYJLSCE9ak2I/9A/@ninjato>
In-Reply-To: <YYJLSCE9ak2I/9A/@ninjato>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Wed, 3 Nov 2021 09:12:53 +0000
Message-ID: <CA+V-a8sidj+FXF0k4dPCgZz2RUHyKsghc75-=Ka2vCkJEFP+xg@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] memory: renesas-rpc-if: Add support for RZ/G2L
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Mark Brown <broonie@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        linux-mtd@lists.infradead.org,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Wolfram,

On Wed, Nov 3, 2021 at 8:41 AM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> Hi Prabhakar,
>
> > Oops I missed that, does the below look good?
>
> Yes, only a minor nit.
>
> >
> > #define RPCIF_PHYADD_ADD_MD 0x00
> > #define RPCIF_PHYADD_ADD_RDLSEL 0x22
> > #define RPCIF_PHYADD_ADD_FDLSEL 0x24
> > #define RPCIF_PHYADD_ADD_RDLMON 0x26
> > #define RPCIF_PHYADD_ADD_FDLMON 0x28
> >
> > #define RPCIF_PHYADD_ACCEN BIT(31)
> > #define RPCIF_PHYADD_RW BIT(30)
>
> Maybe we could leave this because we don't use it? You decide.
>
Agreed will drop RPCIF_PHYADD_RW macro.

> > > +     regmap_write(rpc->regmap, RPCIF_PHYWR, 0x00000030);
> > > +     regmap_write(rpc->regmap, RPCIF_PHYADD, 0x80000032);
> > >
> > For the above do you have any suggestions? As I couldn't find any
> > details about it or shall I just go with magic numbers for now?
>
> Ack. I couldn't find docs about these as well. I suggest to add a
> comment where this value came from. We can ask the BSP and/or HW team
> for details and update this pair incrementally.
>
Thanks, I'll add a comment stating the values have come from the
RZ/G2L HW manual.

Cheers,
Prabhakar

> > thanks, once we agree upon above I shall re-spin v3.
>
> Cool, looking forward to it!
>
> Happy hacking,
>
>    Wolfram
>
