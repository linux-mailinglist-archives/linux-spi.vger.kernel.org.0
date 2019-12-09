Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0659116EA6
	for <lists+linux-spi@lfdr.de>; Mon,  9 Dec 2019 15:09:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727300AbfLIOJk (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Dec 2019 09:09:40 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:35522 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726687AbfLIOJj (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 9 Dec 2019 09:09:39 -0500
Received: by mail-oi1-f196.google.com with SMTP id k196so6415610oib.2;
        Mon, 09 Dec 2019 06:09:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AYKsf4+zyiXbX+LMwBugJf17+cTXdoGFUuI3+FrWo80=;
        b=JEasZ2/+6zkgZ3m/Arf0txmxxiZ4SumZ19u1sMeGGLeckTLG/AWiY4gTfdwXY035bN
         Ut4zgiKFfMJqGrJSPqvBMWL0ZYHktHxITzj+ovwdSi4xssgBW7FxSlqEQph+LJocEAME
         5khvIBJqFsczh1y71uGN57n9q3QbkNE7nBRO9xFfgzxv1PgDStm9fEFzTPlsHEdLccLB
         TWQQ2TsCeXjgI994u6Uy5yRnphOG28ZzzJOJvm39XYwCDIGIoNgPv1fJF0wUXfbmUG70
         E92x5Aki6/RvzSkGSQeE9Jr+XP3KmkHtNR5uw9egDkZqwWmbxAh4v/07PqLGBdcxJFqG
         7aAw==
X-Gm-Message-State: APjAAAVf2F7iPZOpS+HMpqUm/qzFzxJM7VNjxDGqrgFxlExdD9D5B7uh
        AoifRN+OiE2Tr0bu6grXeRmgH9ZsDrSIeTOeWCs=
X-Google-Smtp-Source: APXvYqwpmEvUqY5ENm33wFm2S/SfZlMsJ8IWglG14ZVPhVnUKhd1QoH8ywOkoILfWcJzeyuCZVC+1xbiMPXa9hXELhc=
X-Received: by 2002:aca:4a41:: with SMTP id x62mr23172438oia.148.1575900578654;
 Mon, 09 Dec 2019 06:09:38 -0800 (PST)
MIME-Version: 1.0
References: <20191206134202.18784-1-chris.brandt@renesas.com> <20191206134202.18784-3-chris.brandt@renesas.com>
In-Reply-To: <20191206134202.18784-3-chris.brandt@renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 9 Dec 2019 15:09:27 +0100
Message-ID: <CAMuHMdXW6_tCcx_DE66qBSTK8XmWyWm82ZD6h-N5YX_+xcvBtw@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] dt-bindings: spi: Document Renesas SPIBSC bindings
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

On Fri, Dec 6, 2019 at 2:43 PM Chris Brandt <chris.brandt@renesas.com> wrote:
> Document the bindings used by the Renesas SPI bus space controller.
>
> Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
> ---
> v2:
>  * change to YAML format
>  * add interrupts property
>  * Used more terms directly from the hardware manual

Thanks for the update!

> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/renesas,spibsc.yaml
> @@ -0,0 +1,115 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spi/renesas,spibsc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Renesas SPI Bus Space Controller (SPIBSC) Device Tree Bindings
> +
> +description: |
> +  Otherwise referred to as the "SPI Multi I/O Bus Controller" in SoC hardware
> +  manuals. This controller was designed specifically for accessing Serial flash
> +  devices such as SPI Flash, HyperFlash and OctaFlash. The HW can operate in two
> +  modes. One mode allows for normal byte by byte access (refereed to as
> +  "Manual Mode"). The other mode allows for direct memory mapped access (read
> +  only) to the flash area by the CPU (refereed to as "External Address Space
> +  Read Mode").
> +
> +allOf:
> +  - $ref: spi-controller.yaml#
> +
> +maintainers:
> +  - Chris Brandt <chris.brandt@renesas.com>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - renesas,r7s72100-spibsc     # RZ/A1
> +              - renesas,r7s9210-spibsc      # RZ/A2
> +
> +  reg:
> +    minItems: 2
> +    maxItems: 2
> +    items:
> +      - description: Registers
> +      - description: Memory Mapped Address Space

The second one is not needed, if you would add "ranges" for the
memory-mapped mode.

> +
> +  interrupts:
> +    description: Some HW versions do not contain interrupts
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  flash:
> +    description: |
> +      (Optional) In order to use the HW for R/W access ("Manual Mode"), a "flash"
> +      subnode must be present with a "compatible" property that contains
> +      "jedec,spi-nor". If a spi-nor property is not found, the HW is assumed to be
> +      already operating in "External Address Space Read Mode".
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - '#address-cells'
> +  - '#size-cells'

I would make the flash subnode mandatory.

> +
> +examples:
> +  - |
> +    # This example is for "Manual Mode"
> +    spibsc: spi@1f800000 {
> +        compatible = "renesas,r7s9210-spibsc";
> +        reg = <0x1f800000 0x100>, <0x20000000 0x10000000>;
> +        clocks = <&cpg CPG_MOD 83>;
> +        power-domains = <&cpg>;
> +        interrupts = <GIC_SPI 445 IRQ_TYPE_LEVEL_HIGH>;
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        flash@0 {
> +            compatible = "jedec,spi-nor";
> +            reg = <0>;
> +            spi-max-frequency = <40000000>;
> +
> +            partitions {
> +                compatible = "fixed-partitions";
> +                #address-cells = <1>;
> +                #size-cells = <1>;
> +
> +                partition@0000000 {
> +                    label = "u-boot";
> +                    reg = <0x00000000 0x80000>;
> +                };
> +            };
> +        };
> +
> +    # This example is for "External Address Space Read Mode"
> +    spibsc: spi@1f800000 {
> +        compatible = "renesas,r7s9210-spibsc";
> +        reg = <0x1f800000 0x100>, <0x20000000 0x10000000>;
> +        clocks = <&cpg CPG_MOD 83>;
> +        power-domains = <&cpg>;
> +        interrupts = <GIC_SPI 445 IRQ_TYPE_LEVEL_HIGH>;
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +    };
> +    flash@20000000 {

This does not describe the hardware topology: the flash node should be
a subnode of the spibsc node, as it relies on the spibsc being clocked.

I think when using:

    spibsc: spi@1f800000 {
                compatible = "renesas,r7s9210-spibsc", "simple-pm-bus";
                reg = <0x1f800000 0x100>;
                clocks = <&cpg CPG_MOD 83>;
                power-domains = <&cpg>;
                interrupts = <GIC_SPI 445 IRQ_TYPE_LEVEL_HIGH>;
                #address-cells = <1>;
                #size-cells = <1>;
                ranges = <0 0x20000000 0x10000000>;

                flash@0 {
                        ...
                };
    };

and applying "[PATCH] mtd: maps: physmap: Add minimal Runtime PM
support"[1], the memory-mapped case should work, without your spibsc
driver.

Of course, you still need your driver for using the FLASH in SPI mode.

> +        compatible = "mtd-rom";
> +        probe-type = "direct-mapped";
> +        reg = <0x20000000 0x4000000>;
> +        bank-width = <4>;
> +        device-width = <1>;
> +        #address-cells = <1>;
> +        #size-cells = <1>;
1> +
> +        partition@80000 {
> +            label ="uboot_env";
> +            reg = <0x00080000 0x010000>;
> +            read-only;
> +        };
> +    };

[1] https://lore.kernel.org/linux-mtd/20191209134823.13330-1-geert+renesas@glider.be/

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
