Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9F143F1D5
	for <lists+linux-spi@lfdr.de>; Thu, 28 Oct 2021 23:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbhJ1Vg5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 28 Oct 2021 17:36:57 -0400
Received: from mail-ot1-f46.google.com ([209.85.210.46]:43719 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231417AbhJ1Vgz (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 28 Oct 2021 17:36:55 -0400
Received: by mail-ot1-f46.google.com with SMTP id n13-20020a9d710d000000b005558709b70fso4102912otj.10;
        Thu, 28 Oct 2021 14:34:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qpLGuTUyYYTKPA8RL6cRZq63VfK8RoUI0Php/jfvjsw=;
        b=fIhT8PuVhyLPAte6sS/4bq8DE2XQN95X2gp+u4AG34q9qGXJEQ3X8Johcb236/Nwu6
         YBg33uUJdoi8ktpD2kfgue3ZXJ4ZZ1KvvA4lJRWeppatc5KiDRyXCf530JVY44p2iIdx
         BgbYv+r12Z4Ka4/NakZrl3wh94LNMAWMPgN9hHJI6mktV98gJI+7OwpLfaJsAtUoWzua
         aDj7dW6y0dzpIFp+Ns/zKCQLUI0J20n/CIkmMwKeb796CO7KU//Dm0+cRp/0bZxQABbe
         PbXyjczdcT8aj6ZQjCQV4st8X/kf4RswAf8wSlm3GhzZh/70ozJ3D7fIygwkPrWmrHjA
         RALw==
X-Gm-Message-State: AOAM530mFsv1p3bmBszYDAcn5rHcqXHH/2UNbC/ffEXKyPsxN3QbhgcE
        rdoPiiTeWogsgBEvrBL50g==
X-Google-Smtp-Source: ABdhPJxpNPOfRGhPO9EQMfKEEg+FrVFsZABAS89TAmyXKolt/PW5cIbwKvjIEVhyue3qL/S+f0RUNg==
X-Received: by 2002:a9d:6d03:: with SMTP id o3mr5613522otp.87.1635456868157;
        Thu, 28 Oct 2021 14:34:28 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id w16sm1346045oti.3.2021.10.28.14.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 14:34:27 -0700 (PDT)
Received: (nullmailer pid 626453 invoked by uid 1000);
        Thu, 28 Oct 2021 21:34:26 -0000
Date:   Thu, 28 Oct 2021 16:34:26 -0500
From:   Rob Herring <robh@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Mark Brown <broonie@kernel.org>, linux-mtd@lists.infradead.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Julien Su <juliensu@mxic.com.tw>,
        Jaime Liao <jaimeliao@mxic.com.tw>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Xiangsheng Hou <Xiangsheng.Hou@mediatek.com>
Subject: Re: [PATCH 07/18] dt-bindings: spi: mxic: Convert to yaml
Message-ID: <YXsXYssDTKv2L4EL@robh.at.kernel.org>
References: <20211020142809.349347-1-miquel.raynal@bootlin.com>
 <20211020142809.349347-8-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211020142809.349347-8-miquel.raynal@bootlin.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Oct 20, 2021 at 04:27:58PM +0200, Miquel Raynal wrote:
> Straightforward conversion from regular text to yaml schema of the
> Macronix SPI controller DT bindings.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  .../bindings/spi/mxicy,mx25f0a-spi.yaml       | 67 +++++++++++++++++++
>  .../devicetree/bindings/spi/spi-mxic.txt      | 36 ----------
>  2 files changed, 67 insertions(+), 36 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/spi/mxicy,mx25f0a-spi.yaml
>  delete mode 100644 Documentation/devicetree/bindings/spi/spi-mxic.txt
> 
> diff --git a/Documentation/devicetree/bindings/spi/mxicy,mx25f0a-spi.yaml b/Documentation/devicetree/bindings/spi/mxicy,mx25f0a-spi.yaml
> new file mode 100644
> index 000000000000..4036c14fc533
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/mxicy,mx25f0a-spi.yaml
> @@ -0,0 +1,67 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spi/mxicy,mx25f0a-spi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Macronix SPI controller device tree bindings
> +
> +maintainers:
> +  - Miquel Raynal <miquel.raynal@bootlin.com>
> +
> +allOf:
> +  - $ref: "spi-controller.yaml#"
> +
> +properties:
> +  compatible:
> +    const: mxicy,mx25f0a-spi
> +
> +  reg:
> +    minItems: 2
> +    maxItems: 2
> +
> +  reg-names:
> +    items:
> +      - const: regs
> +      - const: dirmap
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    minItems: 3
> +    maxItems: 3
> +
> +  clock-names:
> +    items:
> +      - const: send_clk
> +      - const: send_dly_clk
> +      - const: ps_clk
> +

> +  "#address-cells":
> +    const: 1
> +  "#size-cells":
> +    const: 0

Can drop these as spi-controller.yaml already defines them.

> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - clocks
> +  - clock-names

> +  - "#address-cells"
> +  - "#size-cells"

And makes them required.

With that,

Reviewed-by: Rob Herring <robh@kernel.org>

> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    spi@43c30000 {
> +      compatible = "mxicy,mx25f0a-spi";
> +      reg = <0x43c30000 0x10000>, <0xa0000000 0x20000000>;
> +      reg-names = "regs", "dirmap";
> +      clocks = <&clkwizard 0>, <&clkwizard 1>, <&clkc 18>;
> +      clock-names = "send_clk", "send_dly_clk", "ps_clk";
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +    };
