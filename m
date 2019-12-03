Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02CCF110498
	for <lists+linux-spi@lfdr.de>; Tue,  3 Dec 2019 19:57:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbfLCS5e (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 3 Dec 2019 13:57:34 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:46028 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbfLCS5d (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 3 Dec 2019 13:57:33 -0500
Received: by mail-oi1-f196.google.com with SMTP id v10so2264651oiv.12;
        Tue, 03 Dec 2019 10:57:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QbBA1xUeDWozSALaq+ZgoDJg/avbhvBYLtHk3XaCifw=;
        b=lsEzUPIx61+IoHiy8JrfhUXUZVGP/ZWFjLn6AqNtKxl6iD4RbfSQEkk7Fkwt3bg4Wk
         UAJX/OxaeKOS/HX7z/IjgB5YfdUCC9HN0r/nYkznbSrQqG9og6S248ij0i2wFKTiaEhg
         QrhAKfNPtUXulJfTHXFe+cM4PdFFPnebMNOGSoyA0KuyUN3OvKRVEcFTTTif6Xneu9MP
         uvKpfT1dSejPwT3J85mFuJuXqCbLHsUAgJRWRVtpwD44fDMUB9piyrjVpPWuBkbRv5WV
         T/dfcEWa6fs7OvS6kFslantWWcK/0id8xuViWrlJo6pKcbOuyGiW8/KEj0qf51EoYExN
         hO2Q==
X-Gm-Message-State: APjAAAU9/SmzCLbb9/VwSnfi6RdbkaG0N/QrSCuNnhSt4lKqyBBSrH76
        bP5/HglNvrKbvbLUfuF7xao5bnfdhTrCiaRZJ8w=
X-Google-Smtp-Source: APXvYqyKgyiMygfjiXO8XcBZrxs1x7n6N0Y2SMTF6gDNv+MIgPG02RwFvT17WjD20296e3XHU/UN+EWiy7fHSp6VNgs=
X-Received: by 2002:aca:48cd:: with SMTP id v196mr5098702oia.102.1575399452736;
 Tue, 03 Dec 2019 10:57:32 -0800 (PST)
MIME-Version: 1.0
References: <20191203034519.5640-1-chris.brandt@renesas.com> <20191203034519.5640-7-chris.brandt@renesas.com>
In-Reply-To: <20191203034519.5640-7-chris.brandt@renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 3 Dec 2019 19:57:21 +0100
Message-ID: <CAMuHMdVBYpuoK7hcyNLK-mAdpTQz3ohTGXuYdFPHdpU5RoPr6Q@mail.gmail.com>
Subject: Re: [PATCH 6/6] dt-bindings: spi: Document Renesas SPIBSC bindings
To:     Chris Brandt <chris.brandt@renesas.com>
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

On Tue, Dec 3, 2019 at 4:47 AM Chris Brandt <chris.brandt@renesas.com> wrote:
> Document the bindings used by the Renesas SPI bus space controller.
>
> Signed-off-by: Chris Brandt <chris.brandt@renesas.com>

Thanks for your patch!

> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/spi-renesas-spibsc.txt

Checkpatch.pl says:
WARNING: DT bindings should be in DT schema format. See:
Documentation/devicetree/writing-schema.rst

> @@ -0,0 +1,48 @@
> +Renesas SPI Bus Space Controller (SPIBSC) Device Tree Bindings
> +
> +Otherwise referred to as the "SPI Multi I/O Bus Controller" in SoC hardware
> +manuals. This controller was designed specifically for accessing SPI flash
> +devices.
> +
> +Required properties:
> +- compatible: should be an SoC-specific compatible value, followed by
> +               "renesas,spibsc" as a fallback.
> +               supported SoC-specific values are:
> +               "renesas,r7s72100-spibsc"       (RZ/A1)
> +               "renesas,r7s9210-spibsc"        (RZ/A2)

Is the fallback valid for RZ/A1, which has its own special match entry
in the driver?
Will it be valid for R-Car Gen3?
If not, you may want to drop it completely.

> +- reg: should contain three register areas:
> +       first for the base address of SPIBSC registers,
> +       second for the direct mapping read mode
> +- clocks: should contain the clock phandle/specifier pair for the module clock.
> +- power-domains: should contain the power domain phandle/specifier pair.
> +- #address-cells: should be 1
> +- #size-cells: should be 0
> +- flash: should be represented by a subnode of the SPIBSC node,
> +        its "compatible" property contains "jedec,spi-nor" if SPI is used.

What about the "mtd-rom" use for e.g. XIP?

interrupts? RZ/A2M seems to have an SPIBSC interrupt, RZ/A1 hasn't.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
