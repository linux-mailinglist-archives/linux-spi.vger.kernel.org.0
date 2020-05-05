Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 735801C60F1
	for <lists+linux-spi@lfdr.de>; Tue,  5 May 2020 21:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbgEETTO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 5 May 2020 15:19:14 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42624 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726350AbgEETTO (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 5 May 2020 15:19:14 -0400
Received: by mail-ot1-f65.google.com with SMTP id m18so2657689otq.9;
        Tue, 05 May 2020 12:19:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/U+Utez0g7tzaxYoGDI1nZpfAtzEcCkPAgk4/VbXcdg=;
        b=BqhfgD33wNLxcf72Ftg/2wW59Z9qk5ZFP8dmcTRVB3Yge5g+GnydAqHmYqAmqzkgUk
         zv790zh496mBXeEfZQKiEXhjre96hTVggFbR6D202AxoUDAw2qJcgOWPKg4tmfxZwLG8
         ClLrc7gZtOocr+2Y8lt82H8oD6uIZjsyR36L5qlRm04g1E3jGKaSoVBC6ijiw0SjnzAb
         DUQUKO1uEjo5bnl82yAnQaukGZgoIoV2lcLJVdae01FzH9G75L6btZt9MBgZzAMwsRIQ
         2CDFdJGAxwB/It8pVETZH1YvCU4fQGN9iY45+bY59ZP2f3s38HMyuTGCschHV9+tTaRt
         nfQQ==
X-Gm-Message-State: AGi0PubjyAGxlkdHJO6jcm+YAJtxfzES4IY2F28bqzUZmTvTFbpsbX4h
        S+2RirE1ygoKvkxDjY10ow==
X-Google-Smtp-Source: APiQypKwZP/zlmQLc48VyxIvtAOarvdP8of6TwzErq8vONQjZi4WM1iTtep+tGTUxGO0T32VkPh4rA==
X-Received: by 2002:a9d:708c:: with SMTP id l12mr3430660otj.335.1588706352098;
        Tue, 05 May 2020 12:19:12 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i5sm771139oik.11.2020.05.05.12.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 12:19:11 -0700 (PDT)
Received: (nullmailer pid 7384 invoked by uid 1000);
        Tue, 05 May 2020 19:19:10 -0000
Date:   Tue, 5 May 2020 14:19:10 -0500
From:   Rob Herring <robh@kernel.org>
To:     Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
Cc:     broonie@kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, andriy.shevchenko@linux.intel.com
Subject: Re: [PATCH v5 7/7] dt-bindings: spi: dw-apb-ssi: Convert bindings to
 json-schema
Message-ID: <20200505191910.GA2970@bogus>
References: <20200505130618.554-1-wan.ahmad.zainie.wan.mohamad@intel.com>
 <20200505130618.554-8-wan.ahmad.zainie.wan.mohamad@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200505130618.554-8-wan.ahmad.zainie.wan.mohamad@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, May 05, 2020 at 09:06:18PM +0800, Wan Ahmad Zainie wrote:
> Convert the Synopsis DesignWare dw-apb-ssi binding to DT schema format
> using json-schema.
> 
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
> ---
>  .../bindings/spi/snps,dw-apb-ssi.txt          | 42 -----------
>  .../bindings/spi/snps,dw-apb-ssi.yaml         | 72 +++++++++++++++++++
>  2 files changed, 72 insertions(+), 42 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
>  create mode 100644 Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml


> diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> new file mode 100644
> index 000000000000..edc1e6fb9993
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> @@ -0,0 +1,72 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/spi/snps,dw-apb-ssi.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Synopsys DesignWare AMBA 2.0 Synchronous Serial Interface
> +
> +maintainers:
> +  - Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
> +
> +allOf:
> +  - $ref: "spi-controller.yaml#"
> +
> +properties:
> +  compatible:
> +    enum:
> +      - mscc,ocelot-spi
> +      - mscc,jaguar2-spi
> +      - amazon,alpine-dw-apb-ssi
> +      - snps,dw-apb-ssi
> +      - snps,dwc-ssi-1.01a
> +      - intel,keembay-ssi

This doesn't match what's in dts files. You have to list out every 
combination.

> +
> +  reg:
> +    minItems: 1
> +    maxItems: 2
> +    items:
> +      - description: The register base for the controller.
> +      - description: For "mscc,<soc>-spi", a second register set is required.
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    minItems: 1
> +    maxItems: 2
> +    items:
> +      - description: The core clock used to generate the external SPI clock.
> +      - description: The interface clock required for register access.
> +
> +  clock-names:
> +    items:
> +      - const: ssi_clk
> +      - const: pclk
> +
> +  reg-io-width:
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +      - enum: [ 2, 4 ]
> +      - default: 4
> +    description: The I/O register width (in bytes) implemented by this device.
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
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
