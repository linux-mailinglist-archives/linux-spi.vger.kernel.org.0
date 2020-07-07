Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC1A216919
	for <lists+linux-spi@lfdr.de>; Tue,  7 Jul 2020 11:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbgGGJdT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 7 Jul 2020 05:33:19 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:33170 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbgGGJdS (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 7 Jul 2020 05:33:18 -0400
Received: by mail-oi1-f195.google.com with SMTP id k22so23033461oib.0;
        Tue, 07 Jul 2020 02:33:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VB02tOgm4x0vvWinn0yzASS1J5cK/IPzRsdpTAQ4rQk=;
        b=YkxXTKpihrkXtHi+nDzxQEfwLFA9LY09pLNm+srfe3FAK9VPTD1xsEiTSn4OT1JZsO
         fceW2TxbWuHi9U9mCZDzQ3xZH3u6aXszIqtpvD869Wyy6+jOfIoyCCWRS/0DGIyAqNIy
         GnY+7gZdMJHidQ9A1HGVZKukbGAWtauVtTDPBXmeSRN/PXauGEHnJ4AmTjtF0+1gbExI
         X3mdl/pv+VNjbkfr8Rwp0vwb/OytkC65EE9X5rZtmLBxXxL3iTyTLv68RfXOPw5g7trN
         hRxE5vM29c+FQFLQPV39KYs58aied1HZdpkT1DTVg+gQtwLQWy+DehkizyiMCl+8OxpX
         nJZQ==
X-Gm-Message-State: AOAM5321dMsNb74ufRE9+elaNSSvUFsk5jAvaxqqaiKpt0wIOPBEVqcU
        IwmM+U0A/FThRt/gWt3yvWFCKnEbT/AXznLqnUE=
X-Google-Smtp-Source: ABdhPJzdnmNZM58lYV9qIqWEOtbYuwfoZLGUAXoQImbx7pakXkbzqGAN57IIyGJ4TXoicdjI0ci72Uq/yPlU117sldc=
X-Received: by 2002:a05:6808:64a:: with SMTP id z10mr2601380oih.54.1594114397872;
 Tue, 07 Jul 2020 02:33:17 -0700 (PDT)
MIME-Version: 1.0
References: <9969c8a1-e6be-38a9-ced5-ce8c5ff07046@cogentembedded.com> <54a84c75-fa17-9976-d9a6-a69ef67c418b@cogentembedded.com>
In-Reply-To: <54a84c75-fa17-9976-d9a6-a69ef67c418b@cogentembedded.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 7 Jul 2020 11:33:07 +0200
Message-ID: <CAMuHMdVnjE=BHe5MBr_NsL6LeXq30vKym8OVLp28=7sZeUBAWw@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] dt-bindings: memory: document Renesas RPC-IF bindings
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Chris Brandt <chris.brandt@renesas.com>,
        Mark Brown <broonie@kernel.org>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mason Yang <masonccyang@mxic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Sergei,

On Tue, Jun 16, 2020 at 10:01 PM Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> Renesas Reduced Pin Count Interface (RPC-IF) allows a SPI flash or
> HyperFlash connected to the SoC to be accessed via the external address
> space read mode or the manual mode.
>
> Document the device tree bindings for the Renesas RPC-IF found in the R-Car
> gen3 SoCs.
>
> Based on the original patch by Mason Yang <masonccyang@mxic.com.tw>.
>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Thanks for your patch!

> --- /dev/null
> +++ linux/Documentation/devicetree/bindings/memory-controllers/renesas,rpc-if.yaml
> @@ -0,0 +1,88 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/memory-controllers/renesas,rpc-if.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Renesas Reduced Pin Count Interface (RPC-IF)
> +
> +maintainers:
> +  - Sergei Shtylyov <sergei.shtylyov@gmail.com>
> +
> +description: |
> +  Renesas RPC-IF allows a SPI flash or HyperFlash connected to the SoC to
> +  be accessed via the external address space read mode or the manual mode.
> +
> +  The flash chip itself should be represented by a subnode of the RPC-IF node.
> +  The flash interface is selected based on the "compatible" property of this
> +  subnode:
> +  - if it contains "jedec,spi-nor", then SPI is used;
> +  - if it contains "cfi-flash", then HyperFlash is used.

> +patternProperties:
> +  "flash@[0-9a-f]+$":
> +    type: object
> +    properties:
> +      compatible:
> +        enum:
> +          - cfi-flash
> +          - jedec,spi-nor

The above does not allow specifying e.g.

    compatible = "spansion,s25fs512s", "jedec,spi-nor";

arch/arm64/boot/dts/renesas/r8a77970-eagle.dt.yaml: spi@ee200000:
flash@0:compatible: Additional items are not allowed ('jedec,spi-nor'
was unexpected)
arch/arm64/boot/dts/renesas/r8a77970-eagle.dt.yaml: spi@ee200000:
flash@0:compatible:0: 'spansion,s25fs512s' is not one of ['cfi-flash',
'jedec,spi-nor']

> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/renesas-cpg-mssr.h>
> +    #include <dt-bindings/power/r8a77995-sysc.h>
> +
> +    spi@ee200000 {
> +      compatible = "renesas,r8a77995-rpc-if", "renesas,rcar-gen3-rpc-if";
> +      reg = <0xee200000 0x200>,
> +            <0x08000000 0x4000000>,
> +            <0xee208000 0x100>;
> +      reg-names = "regs", "dirmap", "wbuf";
> +      clocks = <&cpg CPG_MOD 917>;
> +      power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
> +      resets = <&cpg 917>;
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      flash@0 {
> +        compatible = "jedec,spi-nor";

... which you nicely circumvented in the example ;-)

> +        reg = <0>;
> +        spi-max-frequency = <40000000>;
> +        spi-tx-bus-width = <1>;
> +        spi-rx-bus-width = <1>;
> +      };
> +    };

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
