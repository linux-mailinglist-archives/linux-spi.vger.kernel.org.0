Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73CCE362899
	for <lists+linux-spi@lfdr.de>; Fri, 16 Apr 2021 21:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235362AbhDPT2O (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 16 Apr 2021 15:28:14 -0400
Received: from mail-ot1-f43.google.com ([209.85.210.43]:40762 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232796AbhDPT2N (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 16 Apr 2021 15:28:13 -0400
Received: by mail-ot1-f43.google.com with SMTP id w31-20020a9d36220000b02901f2cbfc9743so26720258otb.7;
        Fri, 16 Apr 2021 12:27:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=gTS/+gQzQAVOTP7Kpo8k+1DieNLZFuf7HOEHcswOVKg=;
        b=KvEJHcovg0YgNaZC9ZlMn1L7hUYt+7w9rZzK0JKwZDP0aNqkSMvLnfkpglz8S9QFZg
         COzruQw9BYfF5ATMYG5A0mg1HZntsd/XTXepo7IMGE50JEvjWhV1erX+P2llzLflx4Pb
         BxzDLW6XSwhW65Qjq/6NotBP6ADbwGHuipcrHbJNrE1cD4Ru96disFBMWlknInCNQd7b
         UaFrlxk1Q4nuBIDqw/48e7BrdpjK/degrtWti25PDz/lGUtdhAAlvLVrUHbJ7ZssZceJ
         ycKs7l6hyRDUy+aF0oCfJjlCC6ab37AC8SKLd5YaIl2GUPggbYBcF4GtEUn+0zWa6t+p
         D8qg==
X-Gm-Message-State: AOAM533E1VGyayS7SvxmGtVD2G+AfahX24PV12esCNZLXXSYNhfB2sPx
        AlWO2FsAIEeuaEv3TjTFUA==
X-Google-Smtp-Source: ABdhPJxNlwZIelUOpnZS2Qvuclwr3kaYBMuhIh9mXEJ9XrKbJLMLHHpqVexS6vOZrud34dNDxsyzNw==
X-Received: by 2002:a9d:648c:: with SMTP id g12mr4998170otl.299.1618601268080;
        Fri, 16 Apr 2021 12:27:48 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 93sm170487otr.31.2021.04.16.12.27.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 12:27:46 -0700 (PDT)
Received: (nullmailer pid 3802806 invoked by uid 1000);
        Fri, 16 Apr 2021 19:27:45 -0000
Date:   Fri, 16 Apr 2021 14:27:45 -0500
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, Kamal Dasu <kdasu.kdev@gmail.com>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH V2] dt-bindings: spi: brcm,spi-bcm-qspi: convert to the
 json-schema
Message-ID: <20210416192745.GA3779932@robh.at.kernel.org>
References: <20210415220201.16429-1-zajec5@gmail.com>
 <20210416062320.21414-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210416062320.21414-1-zajec5@gmail.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Apr 16, 2021 at 08:23:20AM +0200, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> This helps validating DTS files.
> 
> Changes that require mentioning:
> 1. reg-names
>    "mspi_regs" and "bspi_regs" were renamed to "mspi" and "bspi" as that
>    is what's used in DTS files and in Linux driver
> 2. interrupt-names
>    Names were reordered. "mspi_done" has to go first as it's always
>    required.
> 3. spi-rx-bus-width
>    Property description was dropped as it's part of the
>    spi-controller.yaml
> 4. Examples:
>    * flash0@0 was a duplicated node and got dropped
>    * regs and interrupts were formatted and reordered to match yaml
>    * <0x1c> was replaced with <&gic>
> 
> This rewritten binding validates cleanly using the  "dt_binding_check".
> Some Linux stored DTS files will require reordering regs and interrupts
> to make dtbs_check happy.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
> V2: Add Kamal as maintainer
> ---
>  .../bindings/spi/brcm,spi-bcm-qspi.txt        | 245 -----------------
>  .../bindings/spi/brcm,spi-bcm-qspi.yaml       | 247 ++++++++++++++++++
>  MAINTAINERS                                   |   2 +-
>  3 files changed, 248 insertions(+), 246 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.txt
>  create mode 100644 Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.yaml


> diff --git a/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.yaml b/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.yaml
> new file mode 100644
> index 000000000000..598a3984dada
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.yaml
> @@ -0,0 +1,247 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spi/brcm,spi-bcm-qspi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Broadcom SPI controller
> +
> +maintainers:
> +  - Kamal Dasu <kdasu.kdev@gmail.com>
> +  - Rafał Miłecki <rafal@milecki.pl>
> +
> +description: |
> +  The Broadcom SPI controller is a SPI master found on various SOCs, including
> +  BRCMSTB (BCM7XXX), Cygnus, NSP and NS2. The Broadcom Master SPI hw IP consits
> +  of:
> +    MSPI : SPI master controller can read and write to a SPI slave device
> +    BSPI : Broadcom SPI in combination with the MSPI hw IP provides acceleration
> +           for flash reads and be configured to do single, double, quad lane
> +           io with 3-byte and 4-byte addressing support.
> +
> +  Supported Broadcom SoCs have one instance of MSPI+BSPI controller IP.
> +  MSPI master can be used wihout BSPI. BRCMSTB SoCs have an additional instance
> +  of a MSPI master without the BSPI to use with non flash slave devices that
> +  use SPI protocol.
> +
> +allOf:
> +  - $ref: spi-controller.yaml#
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - description: Second Instance of MSPI BRCMSTB SoCs
> +        items:
> +          - enum:
> +              - brcm,spi-bcm7425-qspi
> +              - brcm,spi-bcm7429-qspi
> +              - brcm,spi-bcm7435-qspi
> +              - brcm,spi-bcm7445-qspi
> +              - brcm,spi-bcm7216-qspi
> +              - brcm,spi-bcm7278-qspi
> +          - const: brcm,spi-bcm-qspi
> +          - const: brcm,spi-brcmstb-mspi
> +      - description: Second Instance of MSPI BRCMSTB SoCs
> +        items:
> +          - enum:
> +              - brcm,spi-brcmstb-qspi
> +              - brcm,spi-brcmstb-mspi
> +              - brcm,spi-nsp-qspi
> +              - brcm,spi-ns2-qspi
> +          - const: brcm,spi-bcm-qspi
> +
> +  reg:
> +    minItems: 1
> +    maxItems: 5
> +
> +  reg-names:
> +    minItems: 1
> +    maxItems: 5
> +    items:
> +      - const: mspi
> +      - const: bspi
> +      - enum: [ intr_regs, intr_status_reg, cs_reg ]
> +      - enum: [ intr_regs, intr_status_reg, cs_reg ]
> +      - enum: [ intr_regs, intr_status_reg, cs_reg ]
> +
> +  interrupts:
> +    minItems: 1
> +    maxItems: 7
> +
> +  interrupt-names:
> +    oneOf:
> +      - minItems: 1
> +        maxItems: 7
> +        items:
> +          - const: mspi_done
> +          - const: mspi_halted
> +          - const: spi_lr_fullness_reached
> +          - const: spi_lr_session_aborted
> +          - const: spi_lr_impatient
> +          - const: spi_lr_session_done
> +          - const: spi_lr_overread
> +      - const: spi_l1_intr
> +
> +  clocks:
> +    maxItems: 1
> +    description: reference clock for this block
> +
> +  native-endian:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: Defined when using BE SoC and device uses BE register read/write
> +
> +unevaluatedProperties: false
> +
> +required:
> +  - reg
> +  - reg-names
> +  - interrupts
> +  - interrupt-names
> +
> +examples:
> +  - | # BRCMSTB SoC: SPI Master (MSPI+BSPI) for SPI-NOR access
> +    spi@f03e3400 {
> +            compatible = "brcm,spi-brcmstb-qspi", "brcm,spi-bcm-qspi";
> +            reg = <0xf03e3400 0x188>, <0xf03e3200 0x50>, <0xf03e0920 0x4>;
> +            reg-names = "mspi", "bspi", "cs_reg";
> +            interrupts = <0x5 0x6 0x1 0x2 0x3 0x4 0x0>;

Reformat with <> around each interrupt.

> +            interrupt-parent = <&gic>;
> +            interrupt-names = "mspi_done",
> +                              "mspi_halted",
> +                              "spi_lr_fullness_reached",
> +                              "spi_lr_session_aborted",
> +                              "spi_lr_impatient",
> +                              "spi_lr_session_done",
> +                              "spi_lr_overread";
> +            clocks = <&hif_spi>;
> +            clock-names = "sw_spi";

Looks like you have random clock-names...

> +            #address-cells = <0x1>;
> +            #size-cells = <0x0>;
> +
> +            m25p80@0 {

flash@0

> +                    #size-cells = <0x2>;
> +                    #address-cells = <0x2>;
> +                    compatible = "m25p80";
> +                    reg = <0x0>;
> +                    spi-max-frequency = <0x2625a00>;
> +                    spi-cpol;
> +                    spi-cpha;
> +                    m25p,fast-read;
> +
> +                    flash0.bolt@0 {
> +                        reg = <0x0 0x0 0x0 0x100000>;
> +                    };
> +
> +                    flash0.macadr@100000 {
> +                        reg = <0x0 0x100000 0x0 0x10000>;
> +                    };
> +
> +                    flash0.nvram@110000 {
> +                        reg = <0x0 0x110000 0x0 0x10000>;
> +                    };
> +
> +                    flash0.kernel@120000 {
> +                        reg = <0x0 0x120000 0x0 0x400000>;
> +                    };
> +
> +                    flash0.devtree@520000 {
> +                        reg = <0x0 0x520000 0x0 0x10000>;
> +                    };
> +
> +                    flash0.splash@530000 {
> +                        reg = <0x0 0x530000 0x0 0x80000>;
> +                    };
> +            };
> +    };
> +  - | # BRCMSTB SoC: MSPI master for any SPI device
> +    spi@f0416000 {
> +            clocks = <&upg_fixed>;
> +            compatible = "brcm,spi-brcmstb-mspi", "brcm,spi-bcm-qspi";
> +            reg = <0xf0416000 0x180>;
> +            reg-names = "mspi";
> +            interrupts = <0x14>;
> +            interrupt-parent = <&irq0_aon_intc>;
> +            interrupt-names = "mspi_done";
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +    };
> +  - | # iProc SoC
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    spi@18027200 {
> +            compatible = "brcm,spi-nsp-qspi", "brcm,spi-bcm-qspi";
> +            reg = <0x18027200 0x184>,
> +                  <0x18027000 0x124>,
> +                  <0x1811c408 0x004>,
> +                  <0x180273a0 0x01c>;
> +            reg-names = "mspi", "bspi", "intr_regs", "intr_status_reg";
> +            interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
> +            interrupt-names = "mspi_done",
> +                              "mspi_halted",
> +                              "spi_lr_fullness_reached",
> +                              "spi_lr_session_aborted",
> +                              "spi_lr_impatient",
> +                              "spi_lr_session_done";
> +            clocks = <&iprocmed>;
> +            clock-names = "iprocmed";
> +            num-cs = <2>;
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +    };
> +  - | # NS2 SoC
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    qspi: spi@66470200 {

Drop any unused labels.

> +            compatible = "brcm,spi-ns2-qspi", "brcm,spi-bcm-qspi";
> +            reg = <0x66470200 0x184>,
> +                  <0x66470000 0x124>,
> +                  <0x67017408 0x004>,
> +                  <0x664703a0 0x01c>;
> +            reg-names = "mspi", "bspi", "intr_regs", "intr_status_reg";
> +            interrupts = <GIC_SPI 419 IRQ_TYPE_LEVEL_HIGH>;
> +            interrupt-names = "spi_l1_intr";
> +            clocks = <&iprocmed>;
> +            clock-names = "iprocmed";
> +            num-cs = <2>;
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            flash: m25p80@0 {

flash@0

> +                    #address-cells = <1>;
> +                    #size-cells = <1>;
> +                    compatible = "m25p80";
> +                    reg = <0x0>;
> +                    spi-max-frequency = <12500000>;
> +                    m25p,fast-read;
> +                    spi-cpol;
> +                    spi-cpha;
> +
> +                    partition@0 {

Perhaps show the new, preferred form with a 'partitions' node. Or just 
drop as we have examples elsewhere.

> +                        label = "boot";
> +                        reg = <0x00000000 0x000a0000>;
> +                    };
> +
> +                    partition@a0000 {
> +                        label = "env";
> +                        reg = <0x000a0000 0x00060000>;
> +                    };
> +
> +                    partition@100000 {
> +                        label = "system";
> +                        reg = <0x00100000 0x00600000>;
> +                    };
> +
> +                    partition@700000 {
> +                        label = "rootfs";
> +                        reg = <0x00700000 0x01900000>;
> +                    };
> +            };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a1c2b56f4f90..6fb31a735a0f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3696,7 +3696,7 @@ BROADCOM SPI DRIVER
>  M:	Kamal Dasu <kdasu.kdev@gmail.com>
>  M:	bcm-kernel-feedback-list@broadcom.com
>  S:	Maintained
> -F:	Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.txt
> +F:	Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.yaml
>  F:	drivers/spi/spi-bcm-qspi.*
>  F:	drivers/spi/spi-brcmstb-qspi.c
>  F:	drivers/spi/spi-iproc-qspi.c
> -- 
> 2.26.2
> 
