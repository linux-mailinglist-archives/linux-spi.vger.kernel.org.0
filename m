Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0F92AC013
	for <lists+linux-spi@lfdr.de>; Mon,  9 Nov 2020 16:41:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729336AbgKIPlJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Nov 2020 10:41:09 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:37375 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbgKIPlJ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 9 Nov 2020 10:41:09 -0500
Received: by mail-oi1-f193.google.com with SMTP id m17so10643957oie.4;
        Mon, 09 Nov 2020 07:41:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Skf7O7xduNCjsUIYHWZYfDlsruuW2g/Oe8onPZnrLHY=;
        b=reMxmNSkxFD3FgtW9V6MMVXxBS18y9KfY45Bpk8UUf9cDeh5feucG95hicT0NUCUs+
         bl9jahRxkphw5I2H2hN0KVFyuvvifxiwVY3SaO+tFfbgpfqRO6LxuAxi37R/q+kyBMj8
         ApQfzpOOf67shFL3Ai0YiLTeFupbIfQuE8g1uQojma3BTxKxBH7z9FIq5yx0ahiEAUxZ
         DseDpgzkPkmyAhvW9rgPCUZSWEd7LH99RxwaWzziNUCXLiYR7Eks+vlRAHuBlfm6pQLg
         jduD6YPn6s+4xHi8sDfHxrP2SyKUDpTrixkHpfKFAlwnGsLoNY0fpKCIE8tZNIgDlrz/
         XrsA==
X-Gm-Message-State: AOAM530ivqwNTB8o0t64tdvggDPlk1kI9KApaOYX3rKJ9DUAvyMv8I+N
        oVnaTq0bht5sMYr9LrKjLQ==
X-Google-Smtp-Source: ABdhPJzUWVuxgTdkGVZ598u0iag5nus/DpRG0Lu5FTE3BKlLataQl9y9JQaFx16MvZWSDzV46y7A4g==
X-Received: by 2002:aca:30d7:: with SMTP id w206mr9533783oiw.69.1604936467974;
        Mon, 09 Nov 2020 07:41:07 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id g8sm2429762oia.16.2020.11.09.07.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 07:41:07 -0800 (PST)
Received: (nullmailer pid 1340389 invoked by uid 1000);
        Mon, 09 Nov 2020 15:41:05 -0000
Date:   Mon, 9 Nov 2020 09:41:05 -0600
From:   Rob Herring <robh@kernel.org>
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>,
        Sean Anderson <seanga2@gmail.com>
Subject: Re: [PATCH 25/32] dt-bindings: Document kendryte,k210-rst bindings
Message-ID: <20201109154105.GB1335181@bogus>
References: <20201107081420.60325-1-damien.lemoal@wdc.com>
 <20201107081420.60325-26-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201107081420.60325-26-damien.lemoal@wdc.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sat, Nov 07, 2020 at 05:14:13PM +0900, Damien Le Moal wrote:
> Document the device tree bindings for the Kendryte K210 SoC reset
> controller driver in
> Documentation/devicetree/bindings/reset/kendryte,k210-rst.yaml.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> ---
>  .../bindings/reset/kendryte,k210-rst.yaml     | 78 +++++++++++++++++++
>  1 file changed, 78 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reset/kendryte,k210-rst.yaml
> 
> diff --git a/Documentation/devicetree/bindings/reset/kendryte,k210-rst.yaml b/Documentation/devicetree/bindings/reset/kendryte,k210-rst.yaml
> new file mode 100644
> index 000000000000..bdd0bf37bdfb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/reset/kendryte,k210-rst.yaml
> @@ -0,0 +1,78 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/reset/kendryte,k210-rst.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Kendryte K210 Reset Controller Device Tree Bindings
> +
> +maintainers:
> +  - Damien Le Moal <damien.lemoal@wdc.com>
> +
> +description: |
> +  Kendryte K210 reset controller driver which support the system controller
> +  subsystem supplied reset registers for the various peripherals within
> +  the SoC.
> +
> +  See also:
> +  - dt-bindings/reset/k210-rst.h
> +
> +properties:
> +  compatible:
> +    allOf:
> +      - items:
> +        - const: kendryte,k210-rst

> +        - const: syscon-reset

This is not a generic thing.

> +
> +  regmap:
> +    maxItems: 1
> +    description: phandle of the system controller (sysctl) node
> +
> +  offset:
> +    maxItems: 1
> +    description: peripheral reset register offset in the system controller
> +      controller register map
> +
> +  mask:
> +    maxItems: 1
> +    description: bit-mask indicating valid reset bits in the reset register

You don't need this. Just don't use invalid cell values.

> +
> +  assert-high:
> +    maxItems: 1
> +    description: bit value to write when asserting a reset

Should be implied by the compatible string.

> +
> +  '#reset-cells':
> +    const: 1
> +
> +required:
> +  - '#reset-cells'
> +  - compatible
> +  - regmap
> +  - offset
> +  - mask
> +  - assert-high
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/mfd/k210-sysctl.h>
> +    #include <dt-bindings/reset/k210-rst.h>
> +
> +    sysctl: system-controller@50440000 {
> +      #address-cells = <1>;
> +      #size-cells = <1>;
> +      compatible = "kendryte,k210-sysctl",
> +                   "syscon", "simple-mfd";
> +      reg = <0x50440000 0x1000>;
> +      /* ... */
> +      sysrst: reset-controller {
> +        compatible = "kendryte,k210-rst",
> +                      "syscon-reset";
> +        #reset-cells = <1>;
> +        regmap = <&sysctl>;

That's just the parent node, you don't need this.

> +        offset = <K210_SYSCTL_PERI_RESET>;

Use 'reg'.

> +        mask = <0x27FFFFFF>;
> +        assert-high = <1>;
> +      };
> +    };
> -- 
> 2.28.0
> 
