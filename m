Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B409D1104A8
	for <lists+linux-spi@lfdr.de>; Tue,  3 Dec 2019 19:59:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbfLCS7u (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 3 Dec 2019 13:59:50 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37877 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726932AbfLCS7u (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 3 Dec 2019 13:59:50 -0500
Received: by mail-ot1-f65.google.com with SMTP id k14so3933594otn.4;
        Tue, 03 Dec 2019 10:59:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a3GwPZ/CODVry6CB2B3DmR47MaFScWZKNB7mSrKC2Xg=;
        b=VxnadgwgAmJ/5FVTpU1zSVXJoHpP0Mvzx3tvLcldaimsJlMvp/GBtO2i3Nco/YpSbS
         LkHwTkGrXzm3QOvC0jyAukWtkxzvlqciuIEXeVnLnDS3AoFvpRbzuRzmDJrh9S76LvuB
         a85Pn1cPvf2atu1qTjageEEUm5Se6TGFrOSnU73WDTQc30F4iEa0jTShGISBp+PLmhmc
         gSqDOXboORkCriMgWrHtIJrtGAGacexrwsAJoXqP9ZNmwVRBSVWq64NLdj8W8DBy3T0b
         C+3XFyjxP422WT0nBpLlwFg4Le4FPm+kIJVZEJT21Bb9ldVtQCWD5mL9eS+8YP2+HjZu
         kMyg==
X-Gm-Message-State: APjAAAVkhFBYvoDtaRSAKSsZKeKlAWYWVQz7Di9jVawjNQdmS1kmFC0O
        8e8WaEJq1QYSLjxxxDcHzuv3Pq/UzIjOE0u6ALY=
X-Google-Smtp-Source: APXvYqzwCB4rFT6lcsegDMmdFn1eQYoKloAAvl0cuI+udmTPSot9bxuGUPfp/RgIShmlhaaXmM2acaTMbb8ID69L97Y=
X-Received: by 2002:a9d:2073:: with SMTP id n106mr4358089ota.145.1575399589321;
 Tue, 03 Dec 2019 10:59:49 -0800 (PST)
MIME-Version: 1.0
References: <20191203034519.5640-1-chris.brandt@renesas.com> <20191203034519.5640-6-chris.brandt@renesas.com>
In-Reply-To: <20191203034519.5640-6-chris.brandt@renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 3 Dec 2019 19:59:38 +0100
Message-ID: <CAMuHMdXS_dSEGdMzHFuYraP=dU5WQFM+9DbPW1rFYH2reG2QhA@mail.gmail.com>
Subject: Re: [PATCH 5/6] ARM: dts: r7s9210: Add SPIBSC Device support
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
> Add SPIBSC Device support for RZ/A2.
>
> Signed-off-by: Chris Brandt <chris.brandt@renesas.com>

Thanks for your patch!

> --- a/arch/arm/boot/dts/r7s9210.dtsi
> +++ b/arch/arm/boot/dts/r7s9210.dtsi
> @@ -68,6 +68,16 @@
>                         cache-level = <2>;
>                 };
>
> +               spibsc: spi@1f800000 {
> +                       compatible = "renesas,r7s9210-spibsc", "renesas,spibsc";
> +                       reg = <0x1f800000 0x8c>, <0x20000000 0x10000000 >;

Any specific reason you're using 0x8c, not 0x100?

> +                       clocks = <&cpg CPG_MOD 83>;
> +                       power-domains = <&cpg>;
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;

interrupts?

> +                       status = "disabled";
> +               };
> +
>                 scif0: serial@e8007000 {
>                         compatible = "renesas,scif-r7s9210";
>                         reg = <0xe8007000 0x18>;

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
