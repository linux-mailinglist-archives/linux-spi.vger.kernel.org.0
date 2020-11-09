Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BABDE2AC7D0
	for <lists+linux-spi@lfdr.de>; Mon,  9 Nov 2020 22:58:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729493AbgKIV6W (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Nov 2020 16:58:22 -0500
Received: from mail-oo1-f66.google.com ([209.85.161.66]:45476 "EHLO
        mail-oo1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbgKIV6V (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 9 Nov 2020 16:58:21 -0500
Received: by mail-oo1-f66.google.com with SMTP id j41so2586629oof.12;
        Mon, 09 Nov 2020 13:58:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Rprblfe+luJ0hSeeUEc97b4ulGTxy/C3pizbTWGIRPY=;
        b=b3+JuOWvgnx25TgPUlLwr5Q87bHI+o2AErGnhiMQYbX15k+W4B3Q0Lf+f7zM39/3VB
         xCTDtEwcpxEKAJJFIMEQU9n8sj0pJptZd/X4I1kGtmLugp+eEfQ3P1KxNgui/GVC4fS7
         SwHee+FI6pqvVZ5nragPwI4PJmdpMLBHFf2b9lQbQX+VNcKDhVlsfspTgfogdf+9sO7b
         539+hMSO8XsaK8UDv/YA7zjj3qkYm/rYSvhYZZ4QPOg6k+l9NZWP7gbGoB6f3lN83ZZy
         tkjWIgYQuphjb0pKni9pBJ6l9ar7ljSiYuDode0qZ5xkO6OVUUa0VJKciXY5lcKE0vpe
         mAEw==
X-Gm-Message-State: AOAM533z2ZsDUd1c/xh7rWv5FZa/Th0CKmwYJJh2ZbpW0OoXKahz057A
        jnOCwbhy1uGRdrtoz3JFxg==
X-Google-Smtp-Source: ABdhPJwQH/VtC6qE0HHNpBy9dQppn1TYJUlWL8V73R7BJZQqKIK8+ExMN1LXYwZX04+vooKRFikYrw==
X-Received: by 2002:a4a:8c4f:: with SMTP id v15mr11617101ooj.52.1604959100668;
        Mon, 09 Nov 2020 13:58:20 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id q24sm2813780otm.22.2020.11.09.13.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 13:58:20 -0800 (PST)
Received: (nullmailer pid 1828426 invoked by uid 1000);
        Mon, 09 Nov 2020 21:58:19 -0000
Date:   Mon, 9 Nov 2020 15:58:19 -0600
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
Subject: Re: [PATCH 23/32] dt-binding: Document kendryte,k210-clk bindings
Message-ID: <20201109215819.GA1826748@bogus>
References: <20201107081420.60325-1-damien.lemoal@wdc.com>
 <20201107081420.60325-24-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201107081420.60325-24-damien.lemoal@wdc.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sat, Nov 07, 2020 at 05:14:11PM +0900, Damien Le Moal wrote:
> Document the device tree bindings of the Kendryte K210 SoC clock driver
> in Documentation/devicetree/bindings/clock/kendryte,k210-clk.yaml.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> ---
>  .../bindings/clock/kendryte,k210-clk.yaml     | 70 +++++++++++++++++++
>  1 file changed, 70 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/kendryte,k210-clk.yaml

This and the header go in 1 patch. And before the driver patch.

> 
> diff --git a/Documentation/devicetree/bindings/clock/kendryte,k210-clk.yaml b/Documentation/devicetree/bindings/clock/kendryte,k210-clk.yaml
> new file mode 100644
> index 000000000000..02f5f8a86bc8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/kendryte,k210-clk.yaml
> @@ -0,0 +1,70 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/kendryte,k210-clk.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Kendryte K210 Clock Device Tree Bindings
> +
> +maintainers:
> +  - Damien Le Moal <damien.lemoal@wdc.com>
> +
> +description: |
> +  Kendryte K210 clock controller driver which support the system controller
> +  subsystem supplied clocks for the various controllers and peripherals within
> +  the SoC.
> +
> +  See also:
> +  - dt-bindings/clock/k210-clk.h
> +
> +properties:
> +  compatible:
> +    const: kendryte,k210-clk
> +
> +  clocks:
> +    maxItems: 1
> +    description: System fixed rate oscillator clock
> +
> +  '#clock-cells':
> +    const: 1
> +
> +required:
> +  - compatible
> +  - '#clock-cells'
> +  - clocks
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/k210-clk.h>
> +
> +    clocks {
> +      in0: oscillator {
> +        compatible = "fixed-clock";
> +        #clock-cells = <0>;
> +        clock-frequency = <26000000>;
> +      };
> +    };
> +
> +    soc {
> +      #address-cells = <1>;
> +      #size-cells = <1>;
> +      /* ... */
> +
> +      sysctl: system-controller@50440000 {
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +        compatible = "kendryte,k210-sysctl",
> +                     "syscon", "simple-mfd";
> +        reg = <0x50440000 0x1000>;
> +        /* ... */
> +        sysclk: clock-controller {
> +          #clock-cells = <1>;
> +          compatible = "kendryte,k210-clk";
> +          clocks = <&in0>;
> +        };
> +        /* ... */
> +      };
> +    };
> +
> -- 
> 2.28.0
> 
