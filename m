Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB4E1981BB
	for <lists+linux-spi@lfdr.de>; Mon, 30 Mar 2020 18:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728091AbgC3Qyo (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 30 Mar 2020 12:54:44 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:33835 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727742AbgC3Qyn (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 30 Mar 2020 12:54:43 -0400
Received: by mail-io1-f67.google.com with SMTP id h131so18532383iof.1;
        Mon, 30 Mar 2020 09:54:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jOrX9l7RDubap8oYqwDx/Tq7u4SAFSboI9DcFsCizxA=;
        b=k+7p18VosGehS+rG6tJl0+Vwx3XhFuVjmlX9c/J46Tb16c0GVFczCQuGTJ+12Xr/iY
         1HahuQPxImTs26BNiO5jaHNinzVBcZgZ7UzYKDRes4DV6JKmqZCe0bx+oHqKWvkffoOV
         SImGkkL+e4hf4+ZriwLP6dW1qhueVoFXoHuJCth9t7e7YUDS7VFSsRORy3ix7Zy9RyTH
         b6XwHzCQjUMDj/WfV0Mq3CmvyD8wELqZE298udu6Q0bFEOL5wRztCiwEwbR4p9swNxN0
         xzM/wibrgYCGLjlDjZW/nK9hpirSIuZmhbIUkQysA87/N7X0X8MH8mNOpjuXOU9mL+5M
         qfoA==
X-Gm-Message-State: ANhLgQ0/+nE1zA1CLLsb5DQYHM1SgohrEctJDIxKMy33QQbc6kl3pXsr
        9btip9o5A0Y4yksYiG3EmA==
X-Google-Smtp-Source: ADFU+vtF/9BDe2ELhdoObr+6YMCkSHPZ6Kkr7nlLLIKAedijzVrsX8ZjttsiS3hlHJP0GFw7QctNrQ==
X-Received: by 2002:a5e:c803:: with SMTP id y3mr11329390iol.82.1585587281033;
        Mon, 30 Mar 2020 09:54:41 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id c12sm5061284ila.31.2020.03.30.09.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 09:54:40 -0700 (PDT)
Received: (nullmailer pid 388 invoked by uid 1000);
        Mon, 30 Mar 2020 16:54:39 -0000
Date:   Mon, 30 Mar 2020 10:54:39 -0600
From:   Rob Herring <robh@kernel.org>
To:     Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
Cc:     broonie@kernel.org, mark.rutland@arm.com,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 3/7] dt-bindings: spi: dw-apb-ssi: Convert bindings to
 json-schema
Message-ID: <20200330165439.GA15130@bogus>
References: <20200312113129.8198-1-wan.ahmad.zainie.wan.mohamad@intel.com>
 <20200312113129.8198-4-wan.ahmad.zainie.wan.mohamad@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200312113129.8198-4-wan.ahmad.zainie.wan.mohamad@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Mar 12, 2020 at 07:31:25PM +0800, Wan Ahmad Zainie wrote:
> Convert the Synopsis DesignWare dw-apb-ssi binding to DT schema format
> using json-schema.
> 
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
> ---
>  .../bindings/spi/snps,dw-apb-ssi.txt          |  41 -------
>  .../bindings/spi/snps,dw-apb-ssi.yaml         | 102 ++++++++++++++++++
>  2 files changed, 102 insertions(+), 41 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
>  create mode 100644 Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> 
> diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
> deleted file mode 100644
> index 3ed08ee9feba..000000000000
> --- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
> +++ /dev/null
> @@ -1,41 +0,0 @@
> -Synopsys DesignWare AMBA 2.0 Synchronous Serial Interface.
> -
> -Required properties:
> -- compatible : "snps,dw-apb-ssi" or "mscc,<soc>-spi", where soc is "ocelot" or
> -  "jaguar2", or "amazon,alpine-dw-apb-ssi"
> -- reg : The register base for the controller. For "mscc,<soc>-spi", a second
> -  register set is required (named ICPU_CFG:SPI_MST)
> -- interrupts : One interrupt, used by the controller.
> -- #address-cells : <1>, as required by generic SPI binding.
> -- #size-cells : <0>, also as required by generic SPI binding.
> -- clocks : phandles for the clocks, see the description of clock-names below.
> -   The phandle for the "ssi_clk" is required. The phandle for the "pclk" clock
> -   is optional. If a single clock is specified but no clock-name, it is the
> -   "ssi_clk" clock. If both clocks are listed, the "ssi_clk" must be first.
> -
> -Optional properties:
> -- clock-names : Contains the names of the clocks:
> -    "ssi_clk", for the core clock used to generate the external SPI clock.
> -    "pclk", the interface clock, required for register access. If a clock domain
> -     used to enable this clock then it should be named "pclk_clkdomain".
> -- cs-gpios : Specifies the gpio pins to be used for chipselects.
> -- num-cs : The number of chipselects. If omitted, this will default to 4.
> -- reg-io-width : The I/O register width (in bytes) implemented by this
> -  device.  Supported values are 2 or 4 (the default).
> -
> -Child nodes as per the generic SPI binding.
> -
> -Example:
> -
> -	spi@fff00000 {
> -		compatible = "snps,dw-apb-ssi";
> -		reg = <0xfff00000 0x1000>;
> -		interrupts = <0 154 4>;
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -		clocks = <&spi_m_clk>;
> -		num-cs = <2>;
> -		cs-gpios = <&gpio0 13 0>,
> -			   <&gpio0 14 0>;
> -	};
> -
> diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> new file mode 100644
> index 000000000000..57a789f5d9f3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> @@ -0,0 +1,102 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/spi/snps,dw-apb-ssi.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Synopsys DesignWare AMBA 2.0 Synchronous Serial Interface
> +
> +maintainers:
> +  - Mark Brown <broonie@kernel.org>

Should be owner for this h/w, not who takes patches.

> +
> +allOf:
> +  - $ref: spi-controller.yaml#
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - mscc,ocelot-spi
> +              - mscc,jaguar2-spi
> +      - items:
> +          - const: amazon,alpine-dw-apb-ssi
> +      - items:
> +          - const: snps,dw-apb-ssi

This can all be a single 'enum'. You only need 'oneOf' if there are a 
different number of compatible entries.

> +
> +  reg:
> +    minItems: 1
> +    maxItems: 2
> +    oneOf:
> +      - items:
> +          - description: The register base for the controller.
> +      - items:
> +          - description: The register base for the controller.
> +          - description: For "mscc,<soc>-spi", a second register set is
> +                         required (named ICPU_CFG:SPI_MST)

No need for the oneOf. The 2nd case is a superset of the 1st.

> +
> +  interrupts:
> +    maxItems: 1
> +    description: One interrupt, used by the controller.

Can drop description. Not specific to this h/w.

> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0

Drop these 2. Covered by spi-controller.yaml.

> +
> +  clocks:
> +    minItems: 1
> +    maxItems: 2
> +    description: |
> +      phandles for the clocks, see the description of clock-names below.
> +      The phandle for the "ssi_clk" is required. The phandle for the "pclk"
> +      clock is optional. If a single clock is specified but no clock-name,
> +      it is the "ssi_clk" clock. If both clocks are listed, the "ssi_clk"
> +      must be first.

Rework like:

items:
  - description: ...
  - description: ...

> +
> +  clock-names:
> +    items:
> +      - const: ssi_clk
> +      - const: pclk
> +    description: |
> +      Contains the names of the clocks.
> +      "ssi_clk", for the core clock used to generate the external SPI clock.
> +      "pclk", the interface clock, required for register access.

No need to repeat what's in clocks.

> +      If a clock domain used to enable this clock then it should be
> +      named "pclk_clkdomain".

Should be a constraint:

enum: [pclk, pclk_clkdomain]

But really, it probably should be dropped. I don't understand what the 
sentence is supposed to mean.

> +
> +  cs-gpios:
> +    description: Specifies the gpio pins to be used for chipselects.

Can drop, covered by spi-controller.yaml.

> +
> +  num-cs:
> +    default: 4
> +    description: The number of chipselects. If omitted, this will default to 4.

Constraints?

> +
> +  reg-io-width:
> +    default: 4
> +    description: |
> +      The I/O register width (in bytes) implemented by this device.
> +      Supported values are 2 or 4 (the default).

2 or 4?, sounds like constraints.

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - '#address-cells'
> +  - '#size-cells'
> +  - clocks
> +
> +examples:
> +  - |
> +    spi@fff00000 {
> +          compatible = "snps,dw-apb-ssi";
> +          reg = <0xfff00000 0x1000>;
> +          interrupts = <0 154 4>;
> +          #address-cells = <1>;
> +          #size-cells = <0>;
> +          clocks = <&spi_m_clk>;
> +          num-cs = <2>;
> +          cs-gpios = <&gpio0 13 0>,
> +                     <&gpio0 14 0>;
> +    };
> -- 
> 2.17.1
> 
