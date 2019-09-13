Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C18E6B2699
	for <lists+linux-spi@lfdr.de>; Fri, 13 Sep 2019 22:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730749AbfIMUWY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 13 Sep 2019 16:22:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:50330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726558AbfIMUWX (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 13 Sep 2019 16:22:23 -0400
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8194E20830;
        Fri, 13 Sep 2019 20:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568406142;
        bh=vG37y5t0pRhDhnEVmbp4aTMVf299qtNOZ0ybiETShm0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uK4fmBeujfaCJZ/pxsdoELSElBZAdQ/FGtvLdn898bNBHcdUm4sU4KL8vY5yNSlsy
         4PE4WXB82sagGyZtqkl6PUaHMbXZBXEJPjmAjTki/MQ+lC30vj0tRsz0kENcZ0Grjt
         43h5LgaxvAG6S1LWp1Iazs9zyGwIsy+IYFX0p70A=
Received: by mail-qt1-f174.google.com with SMTP id g16so1864048qto.9;
        Fri, 13 Sep 2019 13:22:22 -0700 (PDT)
X-Gm-Message-State: APjAAAX08Ra25YMVhSmJ202dNCmBN9sau43vI+6Xs/b95DRuiReZr9lf
        mDs88IijP6N+Ch/fRX69Po74z+mQdv2Vu0F10A==
X-Google-Smtp-Source: APXvYqypKBIONVth3RhCgDbUSsYMBwnT1E0liGyv5ml3WrSBUn9HwNCvUTY0EwpTbwvYuNmQpEaSbvAM/qk/XYoCD2w=
X-Received: by 2002:a0c:9e20:: with SMTP id p32mr19851394qve.39.1568406141652;
 Fri, 13 Sep 2019 13:22:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190913122151.20264-1-horms+renesas@verge.net.au>
In-Reply-To: <20190913122151.20264-1-horms+renesas@verge.net.au>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 13 Sep 2019 15:22:10 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKEym4i74AuTFvawBaB0_zBeh5KcBOY_OFheUV1oF4yEg@mail.gmail.com>
Message-ID: <CAL_JsqKEym4i74AuTFvawBaB0_zBeh5KcBOY_OFheUV1oF4yEg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: hspi: Convert bindings to json-schema
To:     Simon Horman <horms+renesas@verge.net.au>
Cc:     Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Mark Rutland <mark.rutland@arm.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Yoshihiro Kaneko <ykaneko0929@gmail.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "open list:MEDIA DRIVERS FOR RENESAS - FCP" 
        <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Sep 13, 2019 at 7:22 AM Simon Horman <horms+renesas@verge.net.au> wrote:
>
> Convert Renesas HSPI bindings documentation to json-schema.
> Also name bindings documentation file according to the compat string
> being documented.
>
> As a side effect of this change all currently supported/used compat
> strings are listed while no while card compat string is documented.
> This, in my opinion, is desirable as only supported hardware should
> be documented.
>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
> Based on v5.3-rc1
> Tested using:
>   make dtbs_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/spi/renesas,hspi.yaml
> ---
>  .../devicetree/bindings/spi/renesas,hspi.yaml      | 54 ++++++++++++++++++++++
>  Documentation/devicetree/bindings/spi/sh-hspi.txt  | 26 -----------
>  2 files changed, 54 insertions(+), 26 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/spi/renesas,hspi.yaml
>  delete mode 100644 Documentation/devicetree/bindings/spi/sh-hspi.txt
>
> diff --git a/Documentation/devicetree/bindings/spi/renesas,hspi.yaml b/Documentation/devicetree/bindings/spi/renesas,hspi.yaml
> new file mode 100644
> index 000000000000..94a64a33daf4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/renesas,hspi.yaml
> @@ -0,0 +1,54 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spi/renesas,hspi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Renesas HSPI
> +
> +maintainers:
> +  - Geert Uytterhoeven <geert+renesas@glider.be>

Add:

allOf:
  - $ref: spi-controller.yaml#

> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +        - renesas,hspi-r8a7778 # R-Car M1A
> +        - renesas,hspi-r8a7779 # R-Car H1
> +      - const: renesas,hspi
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +

> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0

And then these 2 can be dropped.

> +
> +  # Pinctrl properties might be needed, too.
> +  # See Documentation/devicetree/bindings/pinctrl/renesas,*.

If only a single state, you don't. For multiple states, we need to
document the names.

If not present, then they get added automagically so that
'additionalProperties: false' works. But you can't use that here as
you'll have child nodes.

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - '#address-cells'
> +  - '#size-cells'
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    hspi0: spi@fffc7000 {
> +        compatible = "renesas,hspi-r8a7778", "renesas,hspi";
> +        reg = <0xfffc7000 0x18>;
> +        interrupt-parent = <&gic>;
> +        interrupts = <0 63 IRQ_TYPE_LEVEL_HIGH>;
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +    };
> +
