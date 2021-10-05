Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01199422C05
	for <lists+linux-spi@lfdr.de>; Tue,  5 Oct 2021 17:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235335AbhJEPN6 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 5 Oct 2021 11:13:58 -0400
Received: from mail-vs1-f53.google.com ([209.85.217.53]:34602 "EHLO
        mail-vs1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235810AbhJEPNz (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 5 Oct 2021 11:13:55 -0400
Received: by mail-vs1-f53.google.com with SMTP id d18so1453207vsh.1;
        Tue, 05 Oct 2021 08:12:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gf17DwZloYrFgqlw64n/3dkqUKbD656uIR22G5R4yNA=;
        b=WYWH8uTxSMJq76TgA2ObpZPhrPwf5t4TEhKPIinSCwhxIUYEW17aRT2z7Ec5V2w1OF
         fXJqV2fGKZPpZsJBLjsm257C0WpKeLnWGDnnUdaV2GgUhQOFFuYksbEinRMK0YLArKTu
         bNrJ3gw1Mcar1W2RfltrYcKIhuoEPPqPDqo53y02iALamMZC/XrLOMEhkVPTVpmy1WMG
         kM1TyEs4QVPdBcPBWLzRbeilnYXx6NLB1yH1g5j5qquX+SvgmCg01zCxrHf8Jyzs0fbj
         jZLNFTyLbrv9c3/BOjdgTTtNU1Bp/3vJsStxL7BhN/ZZP0pgsIN8Tlldc6eoNQS37833
         N/9Q==
X-Gm-Message-State: AOAM531G7wM3MG0hgkBNVs2MKk1aim1WUNOmDg4yUvy5GDnohnB/vwbp
        Gag/x74BaU+b4rij5+ibXPIz7p+e0ir+okDwxkM=
X-Google-Smtp-Source: ABdhPJyixGIKxdVKLR+jX0yGSnIsxa6UT2MwKmvFfDtbnIxso2yONZOkM11x61wzCO95nrP8oCxmehr97uuO6qk3ado=
X-Received: by 2002:a67:f147:: with SMTP id t7mr18978451vsm.41.1633446724666;
 Tue, 05 Oct 2021 08:12:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210928140721.8805-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20210928140721.8805-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20210928140721.8805-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 5 Oct 2021 17:11:53 +0200
Message-ID: <CAMuHMdWSsrV-9Kxz=zS3CVKSbo2OkwyaVK2Jx-+X68W-cqAdvQ@mail.gmail.com>
Subject: Re: [PATCH 2/6] dt-bindings: memory: renesas,rpc-if: Add optional
 interrupts property
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Mark Brown <broonie@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Sep 28, 2021 at 4:07 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> For completeness add optional interrupts property.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
