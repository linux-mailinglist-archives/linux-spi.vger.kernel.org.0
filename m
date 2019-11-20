Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1E51042D0
	for <lists+linux-spi@lfdr.de>; Wed, 20 Nov 2019 19:04:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbfKTSEG (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 20 Nov 2019 13:04:06 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:43368 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727644AbfKTSEG (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 20 Nov 2019 13:04:06 -0500
Received: by mail-oi1-f196.google.com with SMTP id l20so571507oie.10;
        Wed, 20 Nov 2019 10:04:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wn4WhuGPefkkdG2RHoEX8ty8q6GNTGVjdrwviU5xCaA=;
        b=XZOa5HNXdPL1e0SmmnCz/SXjen9dD2ci1KMSX3icc/9nLWukAkW9UtgLIrKKWVvQAh
         TURMqnb9TXwq56E4MvQ2mVqIdeSBZQantviC4qVWtqEwkbQragFcVwENNX1BfbZ3x/1G
         ULQ+wobhTDuOYTwywJSdi7hDuUmghOhYBhQ85HyW4txXX7TEdYzSokNmgkWTCou6s4MN
         AH7B3/ALddfFkZdtplljE3J048r7oKEud6KXC2Bz6RHQEPl+/WStBneJWoxe5k/NKrI4
         DW4sbk7jKOBbEdPe1wGPK7ECYb2ZW+lfeq5wPtqCR+z5nxpa82YWbw0IxtSFo3mrVK9s
         2BmA==
X-Gm-Message-State: APjAAAXVucfLtvSwG1iZF3f2wsbN6PVIkTQ2JP8Isl61EOqI52wph7tr
        PcQOxMw4Ig24Z4caKQRa8g==
X-Google-Smtp-Source: APXvYqw6wtYV4YE9M25DCBt2w6sGKd1fC52lp5UjSjGEUK/AJNWBT/0Aw17mdvBlm+2sqn+sfEMYqQ==
X-Received: by 2002:aca:b602:: with SMTP id g2mr3811454oif.7.1574273044608;
        Wed, 20 Nov 2019 10:04:04 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id z66sm8838593ota.54.2019.11.20.10.04.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 10:04:04 -0800 (PST)
Date:   Wed, 20 Nov 2019 12:04:03 -0600
From:   Rob Herring <robh@kernel.org>
To:     Benjamin Gaignard <benjamin.gaignard@st.com>
Cc:     broonie@kernel.org, mark.rutland@arm.com, alexandre.torgue@st.com,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: crypto: Convert stm32 QSPI bindings to
 json-schema
Message-ID: <20191120180403.GA11687@bogus>
References: <20191115142318.2909-1-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191115142318.2909-1-benjamin.gaignard@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Nov 15, 2019 at 03:23:18PM +0100, Benjamin Gaignard wrote:
> Convert the STM32 QSPI binding to DT schema format using json-schema

Leftover 'crypto' in the subject.

> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
>  .../devicetree/bindings/spi/spi-stm32-qspi.txt     | 47 -----------
>  .../devicetree/bindings/spi/st,stm32-qspi.yaml     | 91 ++++++++++++++++++++++
>  2 files changed, 91 insertions(+), 47 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/spi/spi-stm32-qspi.txt
>  create mode 100644 Documentation/devicetree/bindings/spi/st,stm32-qspi.yaml

[...]

> diff --git a/Documentation/devicetree/bindings/spi/st,stm32-qspi.yaml b/Documentation/devicetree/bindings/spi/st,stm32-qspi.yaml
> new file mode 100644
> index 000000000000..955405d39966
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/st,stm32-qspi.yaml
> @@ -0,0 +1,91 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spi/st,stm32-qspi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: STMicroelectronics STM32 Quad Serial Peripheral Interface (QSPI) bindings
> +
> +maintainers:
> +  - Christophe Kerello <christophe.kerello@st.com>
> +  - Patrice Chotard <patrice.chotard@st.com>
> +
> +allOf:
> +  - $ref: "spi-controller.yaml#"
> +
> +properties:
> +  compatible:
> +    const: st,stm32f469-qspi
> +
> +  reg:
> +    items:
> +      - description: registers
> +      - description: memory mapping
> +    minItems: 2
> +    maxItems: 2

Implied by the 'items' length.

> +
> +  reg-names:
> +    items:
> +     - const: qspi
> +     - const: qspi_mm
> +    minItems: 2
> +    maxItems: 2

Implied by the 'items' length.

> +
> +  clocks:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 1
> +
> +  dmas:
> +    items:
> +      - description: tx DMA channel
> +      - description: rx DMA channel
> +    minItems: 2
> +    maxItems: 2

Implied by the 'items' length.

> +
> +  dma-names:
> +    items:
> +      - const: tx
> +      - const: rx
> +    minItems: 2
> +    maxItems: 2

Implied by the 'items' length.

> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - clocks
> +  - interrupts
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/stm32mp1-clks.h>
> +    #include <dt-bindings/reset/stm32mp1-resets.h>
> +    spi@58003000 {
> +      compatible = "st,stm32f469-qspi";
> +      reg = <0x58003000 0x1000>, <0x70000000 0x10000000>;
> +      reg-names = "qspi", "qspi_mm";
> +      interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>;
> +      dmas = <&mdma1 22 0x10 0x100002 0x0 0x0>,
> +             <&mdma1 22 0x10 0x100008 0x0 0x0>;
> +      dma-names = "tx", "rx";
> +      clocks = <&rcc QSPI_K>;
> +      resets = <&rcc QSPI_R>;
> +
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      flash@0 {
> +        compatible = "jedec,spi-nor";
> +        reg = <0>;
> +        spi-rx-bus-width = <4>;
> +        spi-max-frequency = <108000000>;
> +      };
> +    };
> +
> +...
> -- 
> 2.15.0
> 
