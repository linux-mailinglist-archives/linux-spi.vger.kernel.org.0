Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAFB0243795
	for <lists+linux-spi@lfdr.de>; Thu, 13 Aug 2020 11:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726499AbgHMJY4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 13 Aug 2020 05:24:56 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:45145 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbgHMJY4 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 13 Aug 2020 05:24:56 -0400
Received: by mail-oi1-f195.google.com with SMTP id o21so4428901oie.12;
        Thu, 13 Aug 2020 02:24:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K2+R75esT4rg+9Q69N4PN4XprjvYqnCLaYjRU7gitVI=;
        b=Lt1FbXitR6VvRlcLn9T3ddDNZY8h5z8tWbgPfxbPqC92UzBtw7P+rwu2o/FKY07+k0
         SMCqIxM1GvIV32AIl16wX2Ai1wzYcJLyrD24NBHxA0yoKhjY1tAucZVck+dLrjIZ4QHh
         U/SzkGZ8rjVkLCDCVANuHscU/gpbV8RHyyBA4BNplPGq6B2fwsxS+92iDqQu/1nxU1UQ
         IcCKv1+Z84UZApNjMM/zZDcR1AbVticCI9uerVpFcIMn8TTxKpKhvud5uQAh4earIJm8
         GaKplqDArmS3cNKZ7GrvlbMpoalT1UrItBNnddEBiSTNp8V2eheWCN3AUp7V5Bhti8YG
         7KDw==
X-Gm-Message-State: AOAM533x57f30JHcHZ7qljUBzPjNb6ETLGzlrSJkIJF825sYWgH343gt
        /99OMPTYpbpNsJ0phCG7uh5jDQ17LGBHaDdpvt4=
X-Google-Smtp-Source: ABdhPJyQAPXa1JCJaKReMCGblv6NvclKyotZYAsP+48uXjpDLQsArnOJHXUliVf83LKCg86s5omnpltMY723KSYHpww=
X-Received: by 2002:aca:adc4:: with SMTP id w187mr2473696oie.153.1597310695064;
 Thu, 13 Aug 2020 02:24:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200812150048.27721-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20200812150048.27721-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20200812150048.27721-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 13 Aug 2020 11:24:43 +0200
Message-ID: <CAMuHMdU_B63Ukx7bU-HBqEKg5qFMOvy5BVp3u3ztbcL8EUFWLw@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: dts: r8a7742: Add QSPI support
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Chris Paterson <Chris.Paterson2@renesas.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Aug 12, 2020 at 5:02 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Add QSPI DT node to R8A7742 SoC dtsi.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v5.10.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
