Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED3021C6A6
	for <lists+linux-spi@lfdr.de>; Tue, 14 May 2019 12:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbfENKII (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 14 May 2019 06:08:08 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:34906 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbfENKIH (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 14 May 2019 06:08:07 -0400
Received: by mail-vs1-f67.google.com with SMTP id q13so5084946vso.2;
        Tue, 14 May 2019 03:08:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dUhPIQQJZs5Vh3eweO1WtOgzVtv83v6N5NsZQ6JZ7+c=;
        b=YxNiTXXHoDBFpFTaWS7OqKMlXpPl8foshheVv3W3yV5+1Ss2Os8TxkKZHNQuDYaMys
         WqMr06byaneCZaHr5b2/T1VPn6HHKFfFEW+nzSZSkyODGX8NaY/SxIeT7OFU8NKSHLQz
         29GrbXgDKHkJ97lGVCCF29j4lyWKjnCEhYymxNtWbNdHBR1HlSfk8P/3AtmEzm8xzEoR
         s7h4FbAORuytl3hOST6tTBF/nmlOnh2h3iPBVyzGB+KP1F9FIbcpACOlMtv4QNnXov8S
         y4QcbJTBmxkMN2l3YARFcSdyiLCc4nRuicrK39wAyOu8GEsfInzGnyUaZ8oHmRa5UhNj
         gvqw==
X-Gm-Message-State: APjAAAV69evRn/yCRv/Iu+4e1Jgw/tLccKBbsKt9mti0n+v+rAAtRrPi
        JdvJVCvgGCYSLwYtOT8X8EvsgUqpKJaEb+CZ1sE=
X-Google-Smtp-Source: APXvYqyKB1cL40577bS36WrKoIvy12plVmfKdngymvdB6XDyb6Wgl/Dtk2X3JeqP2l9zunBcmzvTb9DUCwWc+RrOsBs=
X-Received: by 2002:a67:fdd4:: with SMTP id l20mr12127723vsq.63.1557828486542;
 Tue, 14 May 2019 03:08:06 -0700 (PDT)
MIME-Version: 1.0
References: <1556092536-17095-1-git-send-email-masonccyang@mxic.com.tw>
 <1556092536-17095-4-git-send-email-masonccyang@mxic.com.tw>
 <20190424212356.GA27103@bogus> <65853dc2-6f3c-1494-7e72-54877797cdd2@gmail.com>
 <20190507125730.GD29524@dell> <OF08A5650B.8AE8977C-ON482583F4.000E5B1E-482583F4.000F7215@mxic.com.tw>
 <d229b19e-351c-c576-b5c4-716d10dad1a0@gmail.com> <20190508061119.GB7627@dell>
 <OFE86674B9.06D723A0-ON482583F5.000AD50C-482583F5.000BA075@mxic.com.tw>
 <a05cff8f-7df2-1938-c0e7-f9366bece607@cogentembedded.com> <OFB19BCE91.6EBBAA77-ON482583F6.000234E2-482583F6.00061290@mxic.com.tw>
 <CAMuHMdUP8KU3Dbv6cwOvrY0hWOcm1xqVcsi20+GvazYMDLGGZg@mail.gmail.com>
 <OFD932ABFC.E3FFCEB8-ON482583F9.003412B1-482583F9.0034D5CA@mxic.com.tw>
 <b51d1cb7-b3b5-208f-ab4c-145ecb57805d@cogentembedded.com> <OFAD9AA573.86373900-ON482583FA.0034781A-482583FA.0035B40C@mxic.com.tw>
In-Reply-To: <OFAD9AA573.86373900-ON482583FA.0034781A-482583FA.0035B40C@mxic.com.tw>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 14 May 2019 12:07:54 +0200
Message-ID: <CAMuHMdVyfnO+wTHNrjjvJoqopC_xC0+sxSY+9a=pv-Wf=w6aCQ@mail.gmail.com>
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
        Rob Herring <robh@kernel.org>, zhengxunli@mxic.com.tw
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Mason,

On Tue, May 14, 2019 at 11:46 AM <masonccyang@mxic.com.tw> wrote:
> > >> There's precedence for such constructs being an MFD: please see
> > >> drivers/mfd/at91-usart.c, which registers a single MFD cell for
> > >           second for the direct mapping read mode and
> > >           third for the write buffer area.
> > >   - reg-names: should contain "regs", "dirmap" and "wbuf"
> > >   - clocks: should contain 1 entries for the module's clock
> > >   - clock-names: should contain "rpc"
> >
> >    I suspect we'd need the RPC/RPCD2 clocks mentioned as well (not sure
> yet)...
>
> Need it ?
> RPCD2 is derived from RPC and it's value is half of RPC,
> i.e., RPC = 160MHz, RPCD2 = 80 MHz

That hierarchy depends on the actual SoC, right?
AFAIU, both are derived from RPCSRC, and can be controlled individually
on some SoCs.

BTW, I still haven't seen a patch for drivers/clk/renesas/r8a77995-cpg-mssr.c
adding RPC-related clocks, so I have no idea what's the Linux view of the
hierarchy on your system.

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
