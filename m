Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06DC71143FE
	for <lists+linux-spi@lfdr.de>; Thu,  5 Dec 2019 16:48:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729187AbfLEPsV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 5 Dec 2019 10:48:21 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:44114 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbfLEPsV (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 5 Dec 2019 10:48:21 -0500
Received: by mail-oi1-f193.google.com with SMTP id d62so3116108oia.11;
        Thu, 05 Dec 2019 07:48:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XZiF8L55aoKSCKIPsroK6TKVziAXxA4eopxQuCxnWPg=;
        b=j7xCbNPAfUIVLs3H6M0n+STqooL2KHW3AZu0fnhSi6JXSUVXpOWAfEJfOq77tZmXsC
         PvbQTcCprSRxnlQBefSzfksWVMkz3Xi/krtKb6OuuKqrhef+3BySnxiD8JELF9VdnIoT
         Kk68rwSbeTWJ4yF5b6gdwGHYEmS+Tcb5IgOspEXuu2nkyElGTzugOv3CTsGcs9bfsGGC
         PkzD2JgJtRqBQcyMJPgcPbDxnMJtwlnupUtEKYzaiNb73MHUNR+6SzEvfPj7i4NlYPBM
         lK7ryuw5nhy0Fh/sBjAOm5NPp3MDRwhzO8SeRKCz0iBHa0Q1zyqE67cfngChMjsXbNMq
         3sLQ==
X-Gm-Message-State: APjAAAV4Zh13ePUuWklTaK6sOlnhWeYbXNfzjkEmGjXjEmKkc44+nGNB
        ltSeZjY91Lz5u/+Lhdv68F0xNDmTtkurAwyOGpU=
X-Google-Smtp-Source: APXvYqw/+zkbokRYmfSgQpeCPIqliBYTc3RYgcji0fDJoOYlF/6LAGPuT8XtB0B9Q+xDPgtWc3MSZasdOt39nB2UEYI=
X-Received: by 2002:aca:4a41:: with SMTP id x62mr7347186oia.148.1575560900523;
 Thu, 05 Dec 2019 07:48:20 -0800 (PST)
MIME-Version: 1.0
References: <20191203034519.5640-1-chris.brandt@renesas.com>
 <20191203034519.5640-7-chris.brandt@renesas.com> <CAMuHMdVBYpuoK7hcyNLK-mAdpTQz3ohTGXuYdFPHdpU5RoPr6Q@mail.gmail.com>
 <CAMuHMdV7XY7FB9pBsxuWxGsqYaD9n1Y+XZXEJO5OsuigjjUgpw@mail.gmail.com>
 <TY1PR01MB1562A6AFD8D0807B345B7A208A5D0@TY1PR01MB1562.jpnprd01.prod.outlook.com>
 <CAMuHMdUn3h1VjYkARTFBqMij5aYg2mJSVErwceHc0NATBo+_hw@mail.gmail.com> <TY1PR01MB1562322613FC52617312F14E8A5D0@TY1PR01MB1562.jpnprd01.prod.outlook.com>
In-Reply-To: <TY1PR01MB1562322613FC52617312F14E8A5D0@TY1PR01MB1562.jpnprd01.prod.outlook.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 5 Dec 2019 16:48:09 +0100
Message-ID: <CAMuHMdVy_0e5_94a-G83Tt14XsxmLFOpstvSP6Yw8m9oRW_eZg@mail.gmail.com>
Subject: Re: [PATCH 6/6] dt-bindings: spi: Document Renesas SPIBSC bindings
To:     Chris Brandt <Chris.Brandt@renesas.com>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Mason Yang <masonccyang@mxic.com.tw>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Chris,

On Wed, Dec 4, 2019 at 2:31 PM Chris Brandt <Chris.Brandt@renesas.com> wrote:
> > To avoid future problems, you probably do want to specify spi-tx-bus-width =
> > <4> and spi-rx-bus-width = <4> in DTS now.
>
> I didn't do that because if the MTD layer then thinks I 'want' to do 4-bit access, then that introduces a new problem the solve.
> The MTD layer might start sending down QUAD READ commands to the external SPI and then the SPI Flash will start sending back data on all 4 lines, but the controller is only configured for 1-bit transfers.
>
> I honestly don't know when/why the MTD layer decides on switch from 1-bit to 4-bit mode, so while the board hardware is wired for 4-bit (as the DT would document), we are not ready to be doing 4-bit just yet.
> I just want to try and get the driver in at first....then we can make it do fancy stuff later.
>
> If someone can tell me that even if "spi-rx-bus-width = <4>" is put I the board DTS, the spi will still only do 1-bit transfers until the application specially enables 4-bit mode, then I'm fine with add bus-width=<4> in the DTS.

Your spibsc driver does:

    master->mode_bits = SPI_CPOL | SPI_CPHA;

i.e. SPI_[TR]X_{QUAD,DUAL} are not set, so it should not try those modes.

At least on RSK+RZA1, the FLASHes are wired in quad mode, so you
should describe the hardware in DT.

>
> Unless....I did not understand you meaning....
>
> Did you mean put 'spi-rx-bus-width = <4>' in the .dtsi????  (then I can override it back to <1>  that in the board .dts)???

No, in the board .dtb.

> > BTW, when using spibsc in direct-mapped mode: if you turn of and on again the
> > module clock, does the spibsc need reprogramming?
>
> Nope. Everything will stay the same (just like all the other peripherals). The only thing you 'might' want to do is flush the read cache (especially if you disconnected it because you were going to go out and re-write some of the flash in SPI mode).

Good. So that means the MTD driver can be modular.  Unused clocks are
turned off at boot, and can be turned on when the mtd-rom driver is loaded
and activated.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
