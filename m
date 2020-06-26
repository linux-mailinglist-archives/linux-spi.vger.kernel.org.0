Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC30D20AE90
	for <lists+linux-spi@lfdr.de>; Fri, 26 Jun 2020 10:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726015AbgFZIx7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 26 Jun 2020 04:53:59 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:39133 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725850AbgFZIx7 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 26 Jun 2020 04:53:59 -0400
Received: by mail-oi1-f195.google.com with SMTP id w17so6744487oie.6;
        Fri, 26 Jun 2020 01:53:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SOfvc0ce26XYDR0QIn4GDa0avuT+rkiFokmRicRdgc0=;
        b=Q2TPFOt0Pfl4rZP/RpPWaNJ88IR82WeyWk/93rPHRUV3wMYUaTHHxTImBLUV6u3g96
         SIYGaqE0T8jW9cxYsb6whvXKRUqyHC/HohXkO47TUuYpAaKfvxlpQV6aMiV9EgoXsyZ2
         /VJXDq3M7dGQLnXl2BFebBQGzqdH5cKu1VW2PrYIvfPnhaK14gGefOu3EZWwSqcD6tFt
         dfDqq0sgetVgkiVyacEfWh4oPgm7cSJc6T0BFD3gJh5oNSJKGWkpUsxXOOSPnNS3T6Fs
         Sdgky/0+K5YQ7k6ESWF2C9h3BxAABXpNnmQvbo9v+YPkiVxwHDEyw8Xj+ujV5bYGRyfn
         iqEw==
X-Gm-Message-State: AOAM533LQVfMqcY5tLnTjgmIjvSB0OXkxPRn5hUPWjIVU1wcwk1+KriO
        3dxsXm00Y5wj7k/GDBR3WmeUBmemKX+M1pSlVzAaE1SI
X-Google-Smtp-Source: ABdhPJxn+nXXK4OIQNsJIb4wQRkHI48WQrf/ZBX/bDqf+/lD9sgtVwduXlwAvitV3W+6Y0DhxsujVrC2gFo5A//dBVI=
X-Received: by 2002:aca:849:: with SMTP id 70mr1499973oii.153.1593161638097;
 Fri, 26 Jun 2020 01:53:58 -0700 (PDT)
MIME-Version: 1.0
References: <1591736054-568-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1591736054-568-3-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <1591736054-568-3-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 26 Jun 2020 10:53:46 +0200
Message-ID: <CAMuHMdVkhztRO5HEUGhHsS4x4UmOMHjw3ZdpBKe0jwtsZXn9iw@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: dts: r8a7742: Add MSIOF[0123] support
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
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

On Tue, Jun 9, 2020 at 10:54 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Add the DT nodes needed by MSIOF[0123] interfaces to the SoC dtsi.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v5.9.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
