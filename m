Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1A11F5409
	for <lists+linux-spi@lfdr.de>; Wed, 10 Jun 2020 13:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728673AbgFJL7h (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 10 Jun 2020 07:59:37 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:33607 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728480AbgFJL7g (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 10 Jun 2020 07:59:36 -0400
Received: by mail-ot1-f67.google.com with SMTP id n6so1498371otl.0;
        Wed, 10 Jun 2020 04:59:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8ZG/HJT7rPSiNIE05gFVcJqpFa/5aewZ1WUsbuSs15s=;
        b=Knl+eXYUL2rNk1pwnsIyVkxwPUID5ylX6uN0Cq4uGovGfoMB3X817iMRC/Fl7GeGMD
         ZGR872roQZKuyuXcXKB85qsNl66ri4iFO+SOKJz8+TwC4ZdF/NxJGEZkLnmF8e3Un7aE
         YSpGTsmQ8Pt0MSx3UKVIDivwVicpiYvDsd1moDm9ajyv1AnjnnD0a/8qvvEI6iC79gaa
         e7OJKhcRZcZKXihHqgVzBLlnahWeJCRew1CCVJhQ1vyYrKFpb4b3tdyhe7ifSQs41QD6
         DjlBW/PN4MBDGYNPQ/lmkOJRMaU5Em3b6uZ7fBPkmRQc7/bQuT5MNXQigGpt+DsJ1j55
         YqKw==
X-Gm-Message-State: AOAM532HmBnodkKH3ydymaA9kO9v6t6ijiGkWSt7KhFueXxlUkVeP8WE
        G8hampJ3GXspEw5FFHOQFgWbu0lAf7S4GvKMMJ0XgvXK
X-Google-Smtp-Source: ABdhPJz4zTu2IPb7LBk7svTC/4Ryb7wQelQ/gCq4Psv1ev4MAuApJsbFdmNc5XwduPkB767t96+jNabtE2GhD0tH3NY=
X-Received: by 2002:a9d:c29:: with SMTP id 38mr2147470otr.107.1591790375776;
 Wed, 10 Jun 2020 04:59:35 -0700 (PDT)
MIME-Version: 1.0
References: <1591736054-568-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1591736054-568-2-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com> <20200610110810.GD5005@sirena.org.uk>
In-Reply-To: <20200610110810.GD5005@sirena.org.uk>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 10 Jun 2020 13:59:24 +0200
Message-ID: <CAMuHMdWCHeSB9mjpdSX_-qxwo33kMb1_1R93CjBtVBPFPKkEOg@mail.gmail.com>
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

On Wed, Jun 10, 2020 at 1:08 PM Mark Brown <broonie@kernel.org> wrote:
> On Tue, Jun 09, 2020 at 09:54:13PM +0100, Lad Prabhakar wrote:
> > Document RZ/G1H (R8A7742) SoC bindings.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
> > ---
> >  Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml | 1 +
> >  1 file changed, 1 insertion(+)
>
> To repeat my previous feedback I'd expect a driver update as well.

No driver update is needed.

Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml says:

  compatible:
    oneOf:
      - items:
          - enum:
             - renesas,msiof-r8a7742       # RZ/G1H
               ...
          - const: renesas,rcar-gen2-msiof  # generic R-Car Gen2 and RZ/G1
                                            # compatible device

drivers/spi/spi-sh-msiof.c matches against "renesas,rcar-gen2-msiof".

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
