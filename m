Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2AF31D7CCD
	for <lists+linux-spi@lfdr.de>; Mon, 18 May 2020 17:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbgERP1E (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 18 May 2020 11:27:04 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:38012 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727005AbgERP1D (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 18 May 2020 11:27:03 -0400
Received: by mail-il1-f194.google.com with SMTP id j2so10230343ilr.5;
        Mon, 18 May 2020 08:27:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HZk04ZduzeUDiGnoNDxh+Yt+cMSaZzh4xYDIz3+9lbs=;
        b=WOTz9iDO0UnowOayR/0uOT445UWiGougKnjJSLl/36a91QzYT3COrpnMuoykdAxaRG
         cpO5qFkRIVeOvGPXNxiE/d9s0HdLpZGjfNn2X2lhoBepEjyqi4ocFOclaVBnrUAGhQpd
         bhuuSlhBgoCraqsVD1J/l6Snlv3Mo3bVXpv3SxIVun9JKpA7npFakklBUSW89U/kIPQl
         IaxhGzOVTwSk97lNjwUiQKUeLWo97US27c5nGCa8XBDOaKnKnw8uc97e95r3vlcJfUS9
         M0KhbK+phrx2CJUkowc8kNwwZIddEcAkV+qbMnH5WbrCv4yUCqzlLOOgl1h7TCqGuzuz
         4Bkg==
X-Gm-Message-State: AOAM5329q8GaAPdOWs3dMt6FoRio/D9qHUWSaUI/CJuJM4xIXl1UGqgd
        oKbQUNOp0Nq4aoDH2i+XVQ==
X-Google-Smtp-Source: ABdhPJwJ0r+woAN0IPhZDIonASVfIXBFtEtRiQdjcrjSFdjLdu5+X/NuiQSAKb+Zr2O1u6nM8LIznQ==
X-Received: by 2002:a05:6e02:801:: with SMTP id u1mr17007953ilm.295.1589815621629;
        Mon, 18 May 2020 08:27:01 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id b18sm476861ilh.77.2020.05.18.08.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 08:27:01 -0700 (PDT)
Received: (nullmailer pid 12949 invoked by uid 1000);
        Mon, 18 May 2020 15:26:59 -0000
Date:   Mon, 18 May 2020 09:26:59 -0600
From:   Rob Herring <robh@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Mark Brown <broonie@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        John Garry <john.garry@huawei.com>,
        Chuanhong Guo <gch981213@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-mips@vger.kernel.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: spi: Add Baikal-T1 System Boot SPI
 Controller binding
Message-ID: <20200518152659.GA2525@bogus>
References: <20200508093621.31619-1-Sergey.Semin@baikalelectronics.ru>
 <20200508093621.31619-2-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508093621.31619-2-Sergey.Semin@baikalelectronics.ru>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, May 08, 2020 at 12:36:20PM +0300, Serge Semin wrote:
> Baikal-T1 Boot SPI is a part of the SoC System Controller and is
> responsible for the system bootup from an external SPI flash. It's a DW
> APB SSI-based SPI-controller with no interrupts, no DMA, with just one
> native chip-select available and a single reference clock. Since Baikal-T1
> SoC is normally booted up from an external SPI flash this SPI controller
> in most of the cases is supposed to be connected to a single SPI-nor
> flash. Additionally in order to provide a transparent from CPU point of
> view initial code execution procedure the system designers created an IP
> block which physically maps the SPI flash found at CS0 to a memory region.
> 
> Co-developed-by: Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>
> Signed-off-by: Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: Paul Burton <paulburton@kernel.org>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: John Garry <john.garry@huawei.com>
> Cc: Chuanhong Guo <gch981213@gmail.com>
> Cc: Tomer Maimon <tmaimon77@gmail.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: linux-mips@vger.kernel.org
> Cc: linux-spi@vger.kernel.org
> ---
>  .../bindings/spi/baikal,bt1-sys-ssi.yaml      | 100 ++++++++++++++++++
>  1 file changed, 100 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/baikal,bt1-sys-ssi.yaml
> 
> diff --git a/Documentation/devicetree/bindings/spi/baikal,bt1-sys-ssi.yaml b/Documentation/devicetree/bindings/spi/baikal,bt1-sys-ssi.yaml
> new file mode 100644
> index 000000000000..d9d3257d78f4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/baikal,bt1-sys-ssi.yaml
> @@ -0,0 +1,100 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) 2020 BAIKAL ELECTRONICS, JSC
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spi/baikal,bt1-sys-ssi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Baikal-T1 System Boot SSI Controller
> +
> +description: |
> +  Baikal-T1 System Controller includes a Boot SPI Controller, which is
> +  responsible for loading chip bootup code from an external SPI flash. In order
> +  to do this transparently from CPU point of view there is a dedicated IP block
> +  mapping the 16MB flash to a dedicated MMIO range. The controller is based on
> +  the DW APB SSI IP-core but equipped with very limited resources: no IRQ,
> +  no DMA, a single native CS being necessarily connected to a 16MB SPI flash
> +  (otherwise the system won't bootup from the flash), internal Tx/Rx FIFO of
> +  just 8 bytes depth. Access to DW APB SSI controller registers is mutually
> +  exclusive from normal MMIO interface and from physically mapped SPI Flash
> +  memory. So either one or another way of using the controller functionality
> +  can be enabled at a time.
> +
> +maintainers:
> +  - Serge Semin <fancer.lancer@gmail.com>
> +
> +allOf:
> +  - $ref: spi-controller.yaml#
> +
> +properties:
> +  compatible:
> +    const: baikal,bt1-sys-ssi
> +
> +  reg:
> +    items:
> +      - description: Baikal-T1 Boot Controller configuration registers
> +      - description: Physically mapped SPI flash ROM found at CS0
> +
> +  reg-names:
> +    items:
> +      - const: config
> +      - const: map
> +
> +  clocks:
> +    description: SPI Controller reference clock source

Can drop this. 

> +    maxItems: 1
> +
> +  clock-names:
> +    items:
> +      - const: ssi_clk
> +
> +  num-cs:
> +    const: 1
> +
> +patternProperties:
> +  "^.*@[0-9a-f]+":
> +    type: object
> +    properties:
> +      reg:
> +        minimum: 0
> +        maximum: 0
> +
> +      spi-rx-bus-width:
> +        const: 1
> +
> +      spi-tx-bus-width:
> +        const: 1

What's the point of these 2 properties if they aren't required?

> +
> +unevaluatedProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names

> +  - "#address-cells"
> +  - "#size-cells"

These 2 are required by spi-controller.yaml, so you can drop here.

> +  - clocks
> +
> +examples:
> +  - |
> +    spi@1f040000 {
> +      compatible = "baikal,bt1-sys-ssi";
> +      reg = <0x1f040000 0x1000>,
> +            <0x1c000000 0x1000000>;
> +      reg-names = "config", "map";
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      clocks = <&ccu_sys>;
> +      clock-names = "ssi_clk";
> +
> +      boot_flash: flash@0 {
> +        compatible = "jedec,spi-nor";
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +        reg = <0>;
> +
> +        spi-max-frequency = <25000000>;
> +      };
> +    };
> +...
> -- 
> 2.25.1
> 
