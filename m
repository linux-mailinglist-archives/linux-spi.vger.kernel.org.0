Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFA63110463
	for <lists+linux-spi@lfdr.de>; Tue,  3 Dec 2019 19:43:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbfLCSnB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 3 Dec 2019 13:43:01 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37138 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbfLCSnB (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 3 Dec 2019 13:43:01 -0500
Received: by mail-ot1-f65.google.com with SMTP id k14so3885880otn.4;
        Tue, 03 Dec 2019 10:43:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1rFWjtJS7H2a5vpbCHKE3BleeIGEdr3n3O8a9Afs+D4=;
        b=HtBiZ+KqhnPZyVBFnhP+V1ZUrkYQ5gyZ16ZxXfTqRNXqn2oArQdRE/Gh4wkW0ZfPu6
         YlCvF9RJrhbcyGQF2uKDxaYl7aZx5wDBvnhq3we3TUS74l/tikfczIfmbfig6mD+f9sM
         OOGJ0TDbNWjv49aR4V8nBnzo6HbTh2HRVOXVRBsnbId6/KC+iNkfjB9lz6qfd4yjWO4O
         AzR06nhtvQ8eTk3zV/j+wfFwLa8XCjsfC98tFvURWJu6FNyVBRtZFgKczyXVYwKl0BPs
         +7Z7v4g9M2moK2ozH9nOSTSDBz+vE4lvdPbtQV63E3WkNOsS4v0aOuURAwsFiNGXaK5X
         2VSA==
X-Gm-Message-State: APjAAAUbxdZrrm4Yx1scEjMmiKW3RBsLmIev9DdzSEW6Yi0ad95hsWT7
        X1mwj6262BHvmzSv3tcDob4qc0PpBH7hw5lCJbU=
X-Google-Smtp-Source: APXvYqwx/s2fr1p/E7Z29itFBziFWlfJAYCJn+AR4bMER2poopo74VmOItRnhjyFZsuNUSe7e793eUDF07ATsshicGg=
X-Received: by 2002:a05:6830:1047:: with SMTP id b7mr4077972otp.107.1575398580155;
 Tue, 03 Dec 2019 10:43:00 -0800 (PST)
MIME-Version: 1.0
References: <20191203034519.5640-1-chris.brandt@renesas.com> <20191203034519.5640-3-chris.brandt@renesas.com>
In-Reply-To: <20191203034519.5640-3-chris.brandt@renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 3 Dec 2019 19:42:49 +0100
Message-ID: <CAMuHMdXUVdG_PMQEpz=QWLCaabfK8Mc41zFiymXJ4Rx_C2gzdg@mail.gmail.com>
Subject: Re: [PATCH 2/6] ARM: dts: r7s72100: Add SPIBSC clocks
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

On Tue, Dec 3, 2019 at 4:46 AM Chris Brandt <chris.brandt@renesas.com> wrote:
> The SPIBSC-0 clock is marked as critical because for XIP systems, this
> is the SPI flash controller it will boot from and the kernel will also
> be running from so it cannot be turned off.
>
> Signed-off-by: Chris Brandt <chris.brandt@renesas.com>

Thanks for your patch!

> --- a/arch/arm/boot/dts/r7s72100.dtsi
> +++ b/arch/arm/boot/dts/r7s72100.dtsi
> @@ -101,6 +101,26 @@
>                 #size-cells = <1>;
>                 ranges;
>
> +               spibsc0: spi@3fefa000 {
> +                       compatible = "renesas,r7s72100-spibsc", "renesas,spibsc";
> +                       reg = <0x3fefa000 0x100>, <0x18000000 0x4000000>;

The second region conflicts with the XIP flash@18000000 in
arch/arm/boot/dts/r7s72100-gr-peach.dts.
Yes, I know it is the same device ;-)

> +                       clocks = <&mstp9_clks R7S72100_CLK_SPIBSC0>;
> +                       power-domains = <&cpg_clocks>;
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       status = "disabled";
> +               };
> +
> +               spibsc1: spi@3fefb000 {
> +                       compatible = "renesas,r7s72100-spibsc", "renesas,spibsc";
> +                       reg = <0x3fefb000 0x100>, <0x1c000000 0x4000000>;
> +                       clocks = <&mstp9_clks R7S72100_CLK_SPIBSC1>;
> +                       power-domains = <&cpg_clocks>;
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       status = "disabled";
> +               };
> +
>                 L2: cache-controller@3ffff000 {
>                         compatible = "arm,pl310-cache";
>                         reg = <0x3ffff000 0x1000>;
> @@ -467,11 +487,13 @@
>                         #clock-cells = <1>;
>                         compatible = "renesas,r7s72100-mstp-clocks", "renesas,cpg-mstp-clocks";
>                         reg = <0xfcfe0438 4>;
> -                       clocks = <&p0_clk>, <&p0_clk>, <&p0_clk>, <&p0_clk>;
> +                       clocks = <&p0_clk>, <&p0_clk>, <&p0_clk>, <&p0_clk>, <&b_clk>, <&b_clk>;
>                         clock-indices = <
>                                 R7S72100_CLK_I2C0 R7S72100_CLK_I2C1 R7S72100_CLK_I2C2 R7S72100_CLK_I2C3
> +                               R7S72100_CLK_SPIBSC0 R7S72100_CLK_SPIBSC1
>                         >;
> -                       clock-output-names = "i2c0", "i2c1", "i2c2", "i2c3";
> +                       clock-output-names = "i2c0", "i2c1", "i2c2", "i2c3", "spibsc0", "spibsc1";
> +                       clock-critical = <4>; /* spibsc0 */

Iff we go this clock-critical route, I think this should be specified in the
board-specific .dts instead of in the SoC-specific .dtsi.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
