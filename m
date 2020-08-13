Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66FBC243789
	for <lists+linux-spi@lfdr.de>; Thu, 13 Aug 2020 11:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbgHMJVm (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 13 Aug 2020 05:21:42 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:37514 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbgHMJVm (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 13 Aug 2020 05:21:42 -0400
Received: by mail-oi1-f193.google.com with SMTP id e6so4461486oii.4;
        Thu, 13 Aug 2020 02:21:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YaEuhbpUCPObB924sZp+7C+i8IO12IoyFmwZW/nuIP0=;
        b=Z3uV+MSkTYoIr2t/10xxm8wHIdy3HsCrL/qjGLP9A8RKgYuAxiUv2omfYU3aGFOh4c
         AiTVMRhBXcoWkE598W0Ag+r/DV15/+uNju8TefJyH3COtSM0PPsgu3UpS8UtcJteDizi
         wusLInbfrxQWixBduNq/3w3u5THd2fX6LNnSWB0an6UcvAvPbLDtyLLXyAUneSNCFcHq
         UXhdvttwDhTlmeqA5XrteH0vZ4mC3/ny4N/TfmukqxBxY+1Yo0yrCGNgmek2h6jxdsqB
         EqkKRJTlGJWR7CTO/HULy9JvotvZSLv7okvi5tfY56hrWz+uNPabR7ND6sSNFRd5iQd0
         /9jA==
X-Gm-Message-State: AOAM533nmO0LFR5PZfFYiphC/u7hL4tLPR2XWAtzlBI1jdn7E5zgL9h9
        L/h4vbMy+OUq3y3SfADa6D0cVohRNuZAWfLgfoA=
X-Google-Smtp-Source: ABdhPJyzMM+nvEYYsX5I1IoGccw1T0gnz7Y9PysJQJ25d1i/ZkeqiyFMukSH8lBrYXaRqIbus3bie/U6wX4BYNA+Qb4=
X-Received: by 2002:aca:4b54:: with SMTP id y81mr2595280oia.54.1597310501200;
 Thu, 13 Aug 2020 02:21:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200812150048.27721-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20200812150048.27721-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20200812150048.27721-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 13 Aug 2020 11:21:30 +0200
Message-ID: <CAMuHMdUtKLV9KOJ4AQouDUFN6oCR0p27cMVLnK8AG2CTGFNMgg@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: spi: renesas,rspi: Add r8a7742 to the
 compatible list
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

On Wed, Aug 12, 2020 at 5:01 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Document RZ/G1H (R8A7742) SoC specific bindings. The R8A7742 qspi module
> is identical to R-Car Gen2 family.
>
> No driver change is needed due to the fallback compatible value
> "renesas,qspi".
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
