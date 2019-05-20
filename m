Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6D4522D58
	for <lists+linux-spi@lfdr.de>; Mon, 20 May 2019 09:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730143AbfETHpC (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 20 May 2019 03:45:02 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:34920 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730013AbfETHpC (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 20 May 2019 03:45:02 -0400
Received: by mail-vs1-f65.google.com with SMTP id q13so8332382vso.2;
        Mon, 20 May 2019 00:45:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WNe5zD8EbypMGMCv2cvp7cUoDcbNDit9Pa0KbW5AHpM=;
        b=MQvx3HSmYRVgVSYgRhtnO9vLuxqgE0tZPweb/BOPq6VB/Mf+KekgVpCbUyOzGWupXo
         XyrcfO9cIKgZdOuZd2dS5jGC2/bGTKvSAzGQVyBy04NBU+ouuf30L7WjFEJdmxyettXW
         j5UU/sFupHZnmnkTBQAc0Ikfrcb6lbV9yu1g1dbdO/MAKmzLefqlSGrqEJR5+uG+II+W
         5B+EhUXNjHyoMajVQZZdlYxGZNTKv7vTmk+SfU6l2tIw32Bnr/uGtHnhUSBc4dAHqQF0
         wgC4nQwPBGDunW+sDvxeKh1kJdL2oFFB6eXq2zaEcghali++Mc354S0KW3R3X/6ymmCw
         m3/g==
X-Gm-Message-State: APjAAAUijwEIic+i60MBKR57drBQWPKGdbQ/Ax9VVnQQ9o++7fbpJEhM
        5fIqjSzlFO0tYzzKLBj3GXaRumH6L6+7fKGSEf8=
X-Google-Smtp-Source: APXvYqx5S9gDhfCB9drN7+R0/W78Xu4IJRwCrFKipEDc/5MIaLVZ7/rRdRPe4nJ94/2ntK6T+lcUClyt+FEDm0HnqtA=
X-Received: by 2002:a67:7c93:: with SMTP id x141mr25439751vsc.96.1558338301113;
 Mon, 20 May 2019 00:45:01 -0700 (PDT)
MIME-Version: 1.0
References: <1556092536-17095-1-git-send-email-masonccyang@mxic.com.tw>
 <20190424212356.GA27103@bogus> <65853dc2-6f3c-1494-7e72-54877797cdd2@gmail.com>
 <20190507125730.GD29524@dell> <OF08A5650B.8AE8977C-ON482583F4.000E5B1E-482583F4.000F7215@mxic.com.tw>
 <d229b19e-351c-c576-b5c4-716d10dad1a0@gmail.com> <20190508061119.GB7627@dell>
 <OFE86674B9.06D723A0-ON482583F5.000AD50C-482583F5.000BA075@mxic.com.tw>
 <a05cff8f-7df2-1938-c0e7-f9366bece607@cogentembedded.com> <OFB19BCE91.6EBBAA77-ON482583F6.000234E2-482583F6.00061290@mxic.com.tw>
 <CAMuHMdUP8KU3Dbv6cwOvrY0hWOcm1xqVcsi20+GvazYMDLGGZg@mail.gmail.com>
 <OFD932ABFC.E3FFCEB8-ON482583F9.003412B1-482583F9.0034D5CA@mxic.com.tw>
 <b51d1cb7-b3b5-208f-ab4c-145ecb57805d@cogentembedded.com> <44bc8f0a-cbdc-db4a-9a46-b8bae5cc37a2@cogentembedded.com>
 <OF5AF00898.3CE87C98-ON48258400.00259B16-48258400.0028A4F5@mxic.com.tw>
In-Reply-To: <OF5AF00898.3CE87C98-ON48258400.00259B16-48258400.0028A4F5@mxic.com.tw>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 20 May 2019 09:44:48 +0200
Message-ID: <CAMuHMdU5a2qXVG52Creftp4wR_nnwB9xk=jFeiOWUO0vJSyV0w@mail.gmail.com>
Subject: Re: [PATCH v12 3/3] dt-bindings: mfd: Document Renesas R-Car Gen3
 RPC-IF MFD bindings
To:     Mason Yang <masonccyang@mxic.com.tw>
Cc:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Lee Jones <lee.jones@linaro.org>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>, juliensu@mxic.com.tw,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh@kernel.org>, zhengxunli@mxic.com.tw,
        Miquel Raynal <miquel.raynal@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Mason,

On Mon, May 20, 2019 at 9:24 AM <masonccyang@mxic.com.tw> wrote:
> > >>>   - clocks: should contain 1 entries for the module's clock
> > >>>   - clock-names: should contain "rpc"
> > >>
> > >>    I suspect we'd need the RPC/RPCD2 clocks mentioned as well (not
> sure
> > > yet)...
> > >
> > > Need it ?
> >
> >    You seem to call clk_get_rate() on the module clock, I doubt that's
> > correct topologically...
>
> I think it's correct but just like Geert mentioned that there is no any
> patch
> in drivers/clk/renesas/r8a77995-cpg-mssr.c adding RPC-related clocks.
>
>
> I patched dt-bindings/clock/r8a77995-cpg-mssr.h for some simple testing
>
> -#define R8A77995_CLK_RPC               29
> -#define R8A77995_CLK_RPCD2             30
> +#define R8A77995_CLK_RPC               31
> +#define R8A77995_CLK_RPCD2             32

That change doesn't make sense to me...

> by clk_prepare_enable() & clk_disable_unprepare() with CPG_MOD 917
> on D3 draak board, it is working fine.

... and is not sufficient to allow the above two calls.

Besides, making explicit clk_prepare_enable() calls bypasses Runtime PM
and the automatic disabling of unused clocks, thus hiding bugs related to
Runtime PM.  Which is probably why your driver doesn't work for Sergei...


Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
