Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 154D164287
	for <lists+linux-spi@lfdr.de>; Wed, 10 Jul 2019 09:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbfGJHW7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 10 Jul 2019 03:22:59 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:32939 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbfGJHW7 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 10 Jul 2019 03:22:59 -0400
Received: by mail-oi1-f195.google.com with SMTP id u15so871141oiv.0;
        Wed, 10 Jul 2019 00:22:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TNhWmN6/QiO2aT/qVjLLK+VPEsMniX5sP/eihsxi4qo=;
        b=KDRfwLbXw2c4i0y0YBU7VNcQ+M02+hHom8sjU0T42fcuF9wWBAUAyV/AaH+19rTWAA
         dCMWbLLbOm4QAnxptbIzu6sf6ClYNF6ofVrytQ3/07PcOX0yQ6+BKYVXaiHs27aQzweq
         kxo1kfntlxPDzLxflSJuwPwO36i2CNi9EjFiDq+kiIfrR5XnaZ2hoQQZ4pUIj+9OEmqr
         wlvSMuMq4o7GLnybkdLRr4B96yzEwpaSeKuAZLoU9DA/CW70t2SOQz3mpHh7ao5TFUcW
         apD5f/ZSU89lij5TYhoIbk6nSDxvapQ3SqbcPUEbaQWxr+i2Cr5wdNFPhw7IEcVvRVgA
         KXjg==
X-Gm-Message-State: APjAAAUKI1zg5mlp6rob5Ym374YS1jcwxRsJu+mr8BEPoMO+sl2ZGsN4
        eSgJLVCUZOm5v/YOiqDdwbGIHkiLCOFROq8p0HU=
X-Google-Smtp-Source: APXvYqyn0dkttUnC8/6vf+zF9/ToNEXzP4zlEcN8COzv2vWS0ZD6UDY6SVdd5baBujmwlMgykLnOVZJyF9vs5pmKiG8=
X-Received: by 2002:a05:6808:3c5:: with SMTP id o5mr2496751oie.102.1562743378632;
 Wed, 10 Jul 2019 00:22:58 -0700 (PDT)
MIME-Version: 1.0
References: <1561023046-20886-1-git-send-email-masonccyang@mxic.com.tw> <1561023046-20886-3-git-send-email-masonccyang@mxic.com.tw>
In-Reply-To: <1561023046-20886-3-git-send-email-masonccyang@mxic.com.tw>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 10 Jul 2019 09:22:47 +0200
Message-ID: <CAMuHMdUPmj0tAhJ18DhQEbYxP7g4MMBMe0U_2eQFQ7mOq4ZFLQ@mail.gmail.com>
Subject: Re: [PATCH v14 2/2] dt-bindings: spi: Document Renesas R-Car Gen3
 RPC-IF controller bindings
To:     Mason Yang <masonccyang@mxic.com.tw>
Cc:     Mark Brown <broonie@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lee Jones <lee.jones@linaro.org>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, juliensu@mxic.com.tw,
        Simon Horman <horms@verge.net.au>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Mason,

On Thu, Jun 20, 2019 at 11:08 AM Mason Yang <masonccyang@mxic.com.tw> wrote:
> Dcument the bindings used by the Renesas R-Car Gen3 RPC-IF controller.
>
> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>

Thanks for your patch!

> index 0000000..e8edf99
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt
> @@ -0,0 +1,43 @@
> +Renesas R-Car Gen3 RPC-IF controller Device Tree Bindings
> +---------------------------------------------------------
> +
> +Required properties:
> +- compatible: should be an SoC-specific compatible value, followed by
> +               "renesas,rcar-gen3-rpc" as a fallback.
> +               supported SoC-specific values are:
> +               "renesas,r8a77980-rpc"  (R-Car V3H)
> +               "renesas,r8a77995-rpc"  (R-Car D3)
> +- reg: should contain three register areas:
> +       first for the base address of RPC-IF registers,
> +       second for the direct mapping read mode and
> +       third for the write buffer area.
> +- reg-names: should contain "regs", "dirmap" and "wbuf"
> +- clocks: should contain the clock phandle/specifier pair for the module clock.
> +- clock-names: should contain "rpc"
> +- power-domain: should contain the power domain phandle/secifier pair.

power-domains

> +- resets: should contain the reset controller phandle/specifier pair.
> +- #address-cells: should be 1
> +- #size-cells: should be 0
> +
> +Example:
> +
> +       rpc: spi@ee200000 {
> +               compatible = "renesas,r8a77995-rpc", "renesas,rcar-gen3-rpc";
> +               reg = <0 0xee200000 0 0x200>, <0 0x08000000 0 0x4000000>,
> +                     <0 0xee208000 0 0x100>;
> +               reg-names = "regs", "dirmap", "wbuf";
> +               clocks = <&cpg CPG_MOD 917>;
> +               clock-names = "rpc";
> +               power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
> +               resets = <&cpg 917>;
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               flash@0 {

The subnode is not documented above.

> +                       compatible = "jedec,spi-nor";
> +                       reg = <0>;
> +                       spi-max-frequency = <40000000>;
> +                       spi-tx-bus-width = <1>;
> +                       spi-rx-bus-width = <1>;
> +               };
> +       };

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
