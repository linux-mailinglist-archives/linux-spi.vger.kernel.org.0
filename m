Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EACA2460BB6
	for <lists+linux-spi@lfdr.de>; Mon, 29 Nov 2021 01:37:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231971AbhK2Akz (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 28 Nov 2021 19:40:55 -0500
Received: from mail-ot1-f41.google.com ([209.85.210.41]:44562 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231314AbhK2Aiz (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 28 Nov 2021 19:38:55 -0500
Received: by mail-ot1-f41.google.com with SMTP id u18-20020a9d7212000000b00560cb1dc10bso23117201otj.11;
        Sun, 28 Nov 2021 16:35:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vTUt8JL8c0EbX4Ws9Y0MvfhBbZdQKPR3Lahk2uzREzY=;
        b=q+GmNkORhoKvCJXShUK1j9nl14leO2sRrIplnNgGLdmKZ5iH02HgCKFtIaQlSZnzTV
         Y5VP1qAEHspFPn22TrBrcZPm+hsnmLEr1qa9rh6TGwRoKs2t8WzMo84vY7lPmuOw5sOY
         AKnmigAKKPpLWMUKydWnBNDrF0iBYq33E/dv3cvUyh/nqiZOOJZnuU2JnlR/zWT1xJxu
         97vCvNtHSEFJJ0L0ihziAT1se1Mi6zFElYv11aUDgCowX9zmNxiQWqmFhQtEPdj+ZJEL
         9PQRWM1+EgEqiXk1/sBmMbdfDbRoIc2HWYwO4zZB9UjGUQDabYpBY8DFUA+3tDAHLBt8
         0iDw==
X-Gm-Message-State: AOAM533tHhppzNoFh4ssdQlKe1a7hwypy/s7HhKsls9Ojwp3+w/xnZyX
        iJeLma5xePSPS26jzOSK+g==
X-Google-Smtp-Source: ABdhPJyIsxVbrAl6w5jRXWrXljVtVdOCK0m1rowcOQgI10uw0tBz00FfMlqNEu2vkoTJrlyJOe0CKQ==
X-Received: by 2002:a05:6830:1bcf:: with SMTP id v15mr42639618ota.200.1638146138466;
        Sun, 28 Nov 2021 16:35:38 -0800 (PST)
Received: from robh.at.kernel.org ([172.58.99.229])
        by smtp.gmail.com with ESMTPSA id a5sm1428275otd.74.2021.11.28.16.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Nov 2021 16:35:37 -0800 (PST)
Received: (nullmailer pid 2897649 invoked by uid 1000);
        Mon, 29 Nov 2021 00:35:34 -0000
Date:   Sun, 28 Nov 2021 18:35:34 -0600
From:   Rob Herring <robh@kernel.org>
To:     "LH.Kuo" <lhjeff911@gmail.com>
Cc:     p.zabel@pengutronix.de, broonie@kernel.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dvorkin@tibbo.com,
        qinjian@cqplus1.com, wells.lu@sunplus.com,
        "LH.Kuo" <lh.kuo@sunplus.com>
Subject: Re: [PATCH v3 2/2] devicetree: bindings SPI Add bindings doc for
 Sunplus SP7021
Message-ID: <YaQgVn5sx3AHtmaF@robh.at.kernel.org>
References: <cover.1637547799.git.lh.kuo@sunplus.com>
 <7b8353666052fc42647fce833485b271df8dbc9f.1637547799.git.lh.kuo@sunplus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b8353666052fc42647fce833485b271df8dbc9f.1637547799.git.lh.kuo@sunplus.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Nov 22, 2021 at 10:33:33AM +0800, LH.Kuo wrote:
> Add devicetree bindings SPI Add bindings doc for Sunplus SP7021
> 
> Signed-off-by: LH.Kuo <lh.kuo@sunplus.com>

Again, From and S-o-b must match.

> ---
> Changes in v3:
>  - Addressed all comments from Mr. Mark Brown
>  - Addressed all comments from Mr. Philipp Zabel
>  - Addressed all comments from Mr. Rob Herring
>  - remove spi transfer_one_message
> 
>  .../bindings/spi/spi-sunplus-sp7021.yaml           | 95 ++++++++++++++++++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 96 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/spi-sunplus-sp7021.yaml
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-sunplus-sp7021.yaml b/Documentation/devicetree/bindings/spi/spi-sunplus-sp7021.yaml
> new file mode 100644
> index 0000000..5502f15
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/spi-sunplus-sp7021.yaml
> @@ -0,0 +1,95 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright (C) Sunplus Co., Ltd. 2021
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spi/spi-sunplus-sp7021.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Sunplus sp7021 SPI controller
> +
> +allOf:
> +  - $ref: "spi-controller.yaml"
> +
> +maintainers:
> +  - lh.kuo <lh.kuo@sunplus.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - sunplus,sp7021-spi-controller

I think you can drop '-controller'.

> +
> +  reg:
> +    items:
> +      - description: Base address and length of the SPI master registers
> +      - description: Base address and length of the SPI slave registers

Drop 'Base address and length of '. The rest is sufficient.

> +
> +  reg-names:
> +    items:
> +      - const: spi_master
> +      - const: spi_slave

Drop 'spi_'.

> +
> +  interrupt-names:
> +    items:
> +      - const: dma_w_intr
> +      - const: mas_risc_intr
> +      - const: slave_risc_intr

Drop '_intr', it's redundant.

> +
> +  interrupts:
> +    minItems: 3
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clocks-names:
> +    items:
> +      - const: sys_pll
> +
> +  resets:
> +    maxItems: 1
> +
> +  pinctrl-names:
> +    description:
> +      A pinctrl state named "default" must be defined.
> +    const: default
> +
> +  pinctrl-0:
> +    description:
> +      A phandle to the default pinctrl state.
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - interrupts
> +  - interrupt-names
> +  - clocks
> +  - clocks-names
> +  - resets
> +  - pinctrl-names
> +  - pinctrl-0
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/sp-sp7021.h>
> +    #include <dt-bindings/reset/sp-sp7021.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    spi@9C002D80 {
> +        compatible = "sunplus,sp7021-spi-controller";
> +        reg = <0x9C002D80 0x80>, <0x9C002E00 0x80>;
> +        reg-names = "spi_master", "spi_slave";
> +        interrupt-parent = <&intc>;
> +        interrupt-names = "dma_w_intr",
> +                          "mas_risc_intr",
> +                          "slave_risc_intr";
> +        interrupts = <144 IRQ_TYPE_LEVEL_HIGH>,
> +                     <146 IRQ_TYPE_LEVEL_HIGH>,
> +                     <145 IRQ_TYPE_LEVEL_HIGH>;
> +        clocks = <&clkc SPI_COMBO_0>;
> +        clocks-names = "sys_pll";
> +        resets = <&rstc RST_SPI_COMBO_0>;
> +        pinctrl-names = "default";
> +        pinctrl-0 = <&pins_spi0>;
> +    };
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 75fa7d5..88f3747 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18220,6 +18220,7 @@ SUNPLUS SPI CONTROLLER INTERFACE DRIVER
>  M:	LH Kuo <lh.kuo@sunplus.com>
>  L:	linux-spi@vger.kernel.org
>  S:	Maintained
> +F:	Documentation/devicetree/bindings/spi/spi-sunplus-sp7021.yaml
>  F:	drivers/spi/spi-sunplus-sp7021.c
>  
>  SUPERH
> -- 
> 2.7.4
> 
> 
