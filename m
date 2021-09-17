Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 512E840EE80
	for <lists+linux-spi@lfdr.de>; Fri, 17 Sep 2021 02:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241997AbhIQAyK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 16 Sep 2021 20:54:10 -0400
Received: from mail-il1-f180.google.com ([209.85.166.180]:37863 "EHLO
        mail-il1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241940AbhIQAyJ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 16 Sep 2021 20:54:09 -0400
Received: by mail-il1-f180.google.com with SMTP id i13so8509061ilm.4;
        Thu, 16 Sep 2021 17:52:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=S3cU5uxz3uzsdIlLr3N5laAmW4fSJBM0Q+aFNdUViTY=;
        b=L2QUeWHXaQk/6NFf2J861TSyoXr/XQTSUSXBQaq9bzqBRR9gwDQMRYyFcZTynvzcji
         nfxb1tVJUfTZzSaFDmwN2z5XCNqBGRS/BYRtt4GyGw6huFpXiHl8KUe1AgO3KasCy0xz
         uT6Gysd3boO/fl5L/1BrXlkeMi6z9Fxgb1RTNS6yyr6Hmd6d9Hr5La9oM+D5FDffgF20
         EznxpDDEuW3HTrDoXCLvixoSvyN8qWwLAu8tqMXpWENeKMsjgIpdsPYpXk+e3P0LnCjx
         Hv7u5kjQEPpdz9fk5v94Nr3k0R7PSDqkHn6s1crS9xG+06KHhqwfayeMaaDmo/+7qWAJ
         QgQQ==
X-Gm-Message-State: AOAM530XDapS3zNWCi9mJYMolFXTHkWE2lSyq71fz+NIS7luCqOc3FHt
        cVych0yk72gwetNcq2RaoA==
X-Google-Smtp-Source: ABdhPJx9BTlt781XK7+3a36jUhdAvLeH2BWzHVgq7vl/hew/ZE/3hpBom4b0wyXkDrhu+cIzJ1g03A==
X-Received: by 2002:a05:6e02:1a6b:: with SMTP id w11mr6033812ilv.21.1631839968282;
        Thu, 16 Sep 2021 17:52:48 -0700 (PDT)
Received: from robh.at.kernel.org (96-84-70-89-static.hfc.comcastbusiness.net. [96.84.70.89])
        by smtp.gmail.com with ESMTPSA id f5sm2764672ils.3.2021.09.16.17.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 17:52:47 -0700 (PDT)
Received: (nullmailer pid 1489692 invoked by uid 1000);
        Fri, 17 Sep 2021 00:52:45 -0000
Date:   Thu, 16 Sep 2021 19:52:45 -0500
From:   Rob Herring <robh@kernel.org>
To:     Parshuram Thombare <pthombar@cadence.com>
Cc:     broonie@kernel.org, lukas@wunner.de, p.yadav@ti.com,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, jpawar@cadence.com,
        mparab@cadence.com, Konrad Kociolek <konrad@cadence.com>
Subject: Re: [PATCH v4 1/2] spi: cadence: add dt-bindings documentation for
 Cadence XSPI controller
Message-ID: <YUPm3RKGRb94Jh4G@robh.at.kernel.org>
References: <1631534558-8102-1-git-send-email-pthombar@cadence.com>
 <1631534684-8273-1-git-send-email-pthombar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1631534684-8273-1-git-send-email-pthombar@cadence.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Sep 13, 2021 at 02:04:44PM +0200, Parshuram Thombare wrote:
> Add DT binding for Cadence's XSPI controller driver.
> 
> Signed-off-by: Konrad Kociolek <konrad@cadence.com>
> Signed-off-by: Jayshri Pawar <jpawar@cadence.com>
> Signed-off-by: Parshuram Thombare <pthombar@cadence.com>
> ---
>  .../devicetree/bindings/spi/cdns,xspi.yaml         | 77 ++++++++++++++++++++++
>  1 file changed, 77 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/cdns,xspi.yaml
> 
> diff --git a/Documentation/devicetree/bindings/spi/cdns,xspi.yaml b/Documentation/devicetree/bindings/spi/cdns,xspi.yaml
> new file mode 100644
> index 0000000..5ebede1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/cdns,xspi.yaml
> @@ -0,0 +1,77 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright 2020-21 Cadence
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/spi/cdns,xspi.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Cadence XSPI Controller
> +
> +maintainers:
> +  - Parshuram Thombare <pthombar@cadence.com>
> +
> +description: |
> +  The XSPI controller allows SPI protocol communication in
> +  single, dual, quad or octal wire transmission modes for
> +  read/write access to slaves such as SPI-NOR flash.
> +
> +allOf:
> +  - $ref: "spi-controller.yaml#"
> +
> +properties:
> +  compatible:
> +    const: cdns,xspi-nor
> +
> +  reg:
> +    items:
> +      - description: address and length of the controller register set
> +      - description: address and length of the Slave DMA data port
> +      - description: address and length of the auxiliary registers
> +
> +  reg-names:
> +    items:
> +      - const: xspi-iobase
> +      - const: xspi-sdmabase
> +      - const: xspi-auxbase

'xspi' and 'base' are redundant. So just io, sdma, and aux.

> +
> +  interrupts:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    bus {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        xspi: spi@a0010000 {
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +            compatible = "cdns,xspi-nor";
> +            reg = <0x0 0xa0010000 0x0 0x10000>,
> +                  <0x0 0xb0000000 0x0 0x10000>,
> +                  <0x0 0xa0020000 0x0 0x10000>;

Unless you are really using 64KB of registers, that wastes a bunch of 
virtual space which is limited on 32-bit platforms.

> +            reg-names = "xspi-iobase", "xspi-sdmabase", "xspi-auxbase";
> +            interrupts = <0 90 IRQ_TYPE_LEVEL_HIGH>;
> +            interrupt-parent = <&gic>;
> +
> +            flash@0 {
> +                compatible = "jedec,spi-nor";
> +                spi-max-frequency = <75000000>;
> +                reg = <0>;
> +            };
> +
> +            flash@1 {
> +                compatible = "jedec,spi-nor";
> +                spi-max-frequency = <75000000>;
> +                reg = <1>;
> +            };
> +        };
> +    };
> -- 
> 2.7.4
> 
> 
