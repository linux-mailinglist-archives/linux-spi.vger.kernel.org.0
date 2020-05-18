Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE1341D89FE
	for <lists+linux-spi@lfdr.de>; Mon, 18 May 2020 23:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbgERVX2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 18 May 2020 17:23:28 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:43891 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbgERVX2 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 18 May 2020 17:23:28 -0400
Received: by mail-ot1-f65.google.com with SMTP id a68so9420353otb.10;
        Mon, 18 May 2020 14:23:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U92BB+6C4uVhJQrf36MoRzDWDXvidueX3Mpx+wYGjHE=;
        b=ZRdjIlqU7AfCkFE26U6/1P+bM937s3zBzHArBm+IKNXnvQiV9aQpYE+A1ei5zCvzmG
         QXrUWcOZXWtmn1xvQjexMWYkY1z03nA5Z/BV1Owr/oAYmNIW+UVIDU3rQbF5wxSYOKum
         0t7P658XQET7MXxsoaoO61BDJEYAGwzivBLii8w5B6eP4+eBKRvSqH3SsnW6eCK4Y/5v
         h2Q+KKeOpGe+1b8jGFX4cPRYviy7sXMlhvoNxKb7hgNSzdk0LJhWUkvAtkcqasso1AI+
         cyVeDojtOQzZtFHAgYL02EJVFK8t4l3bKwhYPq5TEmxhAaTsVGmNZ3q5DMedOH0bKH6g
         6lrQ==
X-Gm-Message-State: AOAM530Up1+RieRSCYMveQqLWJmZS10qsj1QtFWCxnNVW7xEdutcrG3u
        qd7dPsG93bqVhNWBTt+8mbk4eaQ8WB4EQK6pkvqU0bLf
X-Google-Smtp-Source: ABdhPJxXwxJ5xuvSfmX1AYEFPzUHohPAxLY19VYdsib15uohT6ml7h8lWA+I3c4PBsWvNIX259XyYBX58w4WJiRsU14=
X-Received: by 2002:a9d:7e92:: with SMTP id m18mr13486340otp.145.1589837007047;
 Mon, 18 May 2020 14:23:27 -0700 (PDT)
MIME-Version: 1.0
References: <26faf5e8-26eb-cceb-a500-f0fd64609737@cogentembedded.com> <f998fe6c-c586-17cb-9343-30460ce0bf9d@cogentembedded.com>
In-Reply-To: <f998fe6c-c586-17cb-9343-30460ce0bf9d@cogentembedded.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 18 May 2020 23:23:15 +0200
Message-ID: <CAMuHMdVg4=1JA2x4PN6Y4cE_WJ9LSZUTi0hyxUqiUWujv8Z3pg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: memory: document Renesas RPC-IF bindings
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Chris Brandt <chris.brandt@renesas.com>,
        Mason Yang <masonccyang@mxic.com.tw>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-spi <linux-spi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Sergei,

On Mon, May 18, 2020 at 10:33 PM Sergei Shtylyov
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
> +  - Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
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
> +
> +allOf:
> +  - $ref: "/schemas/spi/spi-controller.yaml#"
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +        - renesas,r8a77980-rpc-if

Usually we add a comment with the SoC name, e.g. "# R-Car V3H"

> +        - renesas,r8a77995-rpc-if
> +      - enum:
> +        - renesas,rcar-gen3-rpc-if # a generic R-Car gen3 device

No need for an enum, just use "- const: renesas,rcar-gen3-rpc-if".

> +examples:
> +  - |
> +    #include <dt-bindings/clock/renesas-cpg-mssr.h>
> +    #include <dt-bindings/power/r8a77995-sysc.h>
> +
> +    spi@ee200000 {
> +      compatible = "renesas,r8a77995-rpc-if", "renesas,rcar-gen3-rpc-if";
> +      reg = <0 0xee200000 0 0x200>,
> +            <0 0x08000000 0 0x4000000>,
> +            <0 0xee208000 0 0x100>;

Examples are built with #{address,size}-cells = <1>, so please drop
the zeroes.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
