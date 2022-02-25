Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51D314C4822
	for <lists+linux-spi@lfdr.de>; Fri, 25 Feb 2022 15:58:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbiBYO7H (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 25 Feb 2022 09:59:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiBYO7G (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 25 Feb 2022 09:59:06 -0500
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154B313D75;
        Fri, 25 Feb 2022 06:58:34 -0800 (PST)
Received: by mail-oo1-f44.google.com with SMTP id w10-20020a4ae08a000000b0031bdf7a6d76so6407545oos.10;
        Fri, 25 Feb 2022 06:58:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VWXtqHCu6z1JS1swSPU8LtzzThvs1qTLihUJQa/4DcU=;
        b=wK0jCUpPr2MvNTQxk350Xpe29/HDmnUYWVQ+2iCBUfENQoNRYnOgfH+ybivSC3b4i2
         fR+Kd9T/AYDrX15bG938zVO+IVQMGZ2frsTQnexcNHc5Wi2lPUS9mn+US/+b1zKlr2uD
         i9guZoV47a5Dn8hapu9gFYt7j92uBjAPRMmnnaDddta3eDwWfbUeDDd/DZN4du/ej8UG
         GgXLdp7IS4h2ur9hAfpMz4aB9XY5cLcU9K75gsksddE7sDgw3v4FyIGGPTB3eaticTlR
         fzjldA8BY2BM7Mq4blxACmw85sSm5ZrGnN+afOfV/ElPBVxDHNEkgFCHOJphFg/MFsKB
         vEEQ==
X-Gm-Message-State: AOAM531euaKUn8IglfI2Lck1Tzb35S0NvKXgcTJDRqaVFySjD7mjUGNX
        iiYAM6KYJp7u1Mkir/tX7A==
X-Google-Smtp-Source: ABdhPJz/SSxAYpaGrZ6rSQyF1EYSgUPqN+vWxjCDUYltt2aeXjfiOITgwdo0kUNIM1EzkkCO6lwXxA==
X-Received: by 2002:a05:6870:9a18:b0:d6:bc01:21a0 with SMTP id fo24-20020a0568709a1800b000d6bc0121a0mr1465414oab.216.1645801113046;
        Fri, 25 Feb 2022 06:58:33 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id 125-20020a4a1483000000b003175bffb677sm1153710ood.2.2022.02.25.06.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 06:58:32 -0800 (PST)
Received: (nullmailer pid 916386 invoked by uid 1000);
        Fri, 25 Feb 2022 14:58:31 -0000
Date:   Fri, 25 Feb 2022 08:58:31 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Antipov <daantipov@gmail.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Felipe Balbi <balbi@kernel.org>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        Dmitry Antipov <dmanti@microsoft.com>
Subject: Re: [PATCH v4 3/6] Documentation: DT bindings for Microsoft G6 Touch
 Digitizer
Message-ID: <Yhjul21OnmFWMfqj@robh.at.kernel.org>
References: <20220225005936.3485405-1-dmanti@microsoft.com>
 <20220225005936.3485405-4-dmanti@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220225005936.3485405-4-dmanti@microsoft.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Feb 24, 2022 at 04:59:33PM -0800, Dmitry Antipov wrote:
> From: Dmitry Antipov <dmanti@microsoft.com>

Please follow the conventions of the subsystem for the subject:

dt-bindings: input: ...

> 
> Documentation describes the required and optional properties for
> implementing Device Tree for a Microsoft G6 Touch Digitizer that
> supports HID over SPI Protocol 1.0 specification.
> 
> Signed-off-by: Dmitry Antipov <dmanti@microsoft.com>
> ---
>  .../input/microsoft,g6-touch-digitizer.yaml   | 105 ++++++++++++++++++
>  1 file changed, 105 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/microsoft,g6-touch-digitizer.yaml
> 
> diff --git a/Documentation/devicetree/bindings/input/microsoft,g6-touch-digitizer.yaml b/Documentation/devicetree/bindings/input/microsoft,g6-touch-digitizer.yaml
> new file mode 100644
> index 000000000000..e516717527e9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/microsoft,g6-touch-digitizer.yaml
> @@ -0,0 +1,105 @@
> +# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/input/microsoft,g6-touch-digitizer.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Microsoft G6 Touch Digitizer
> +
> +maintainers:
> +  - Dmitry Antipov <dmanti@microsoft.com>
> +
> +description: |
> +  Microsoft G6 touch digitizer is a HID over SPI device supporting HID Over SPI
> +  Protocol Specification 1.0, available at
> +  https://www.microsoft.com/en-us/download/details.aspx?id=103325.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: microsoft,g6-touch-digitizer
> +      - items:
> +        - const: microsoft,g6-touch-digitizer
> +        - const: hid-over-spi

Why are both cases needed?

Assuming you keep the 2nd case, you will need a custom 'select' to avoid 
applying this schema to another binding using 'hid-over-spi':

select:
  properties:
    compatible:
      contains:
	const: microsoft,g6-touch-digitizer

  required:
    - compatible


> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  reset-gpios:
> +    maxItems: 1
> +    description:
> +      GPIO specifier for the digitizer's reset pin (active low). The line must
> +      be flagged with GPIO_ACTIVE_LOW.
> +
> +  vdd-supply:
> +    description:
> +      Regulator for the VDD supply voltage.
> +
> +  input-report-header-address:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      This property and the rest are described in HID Over SPI Protocol Spec 1.0

Each property needs a description and a more specific spec location.

No constraints on the values? 0 - 2^32 is valid?

> +
> +  input-report-body-address:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  output-report-address:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  read-opcode:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  write-opcode:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  hid-over-spi-flags:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +

> +  post-power-on-delay-ms:
> +    description:
> +      Optional time in ms required by the device after enabling its regulators
> +      or powering it on, before it is ready for communication.
> +
> +  minimal-reset-delay-ms:
> +    description:
> +      Optional minimum amount of time in ms that device needs to be in reset
> +      state for the reset to take effect.

These should be implied by the compatible string.

> +
> +required:
> +  - compatible
> +  - interrupts
> +  - reset-gpios

It's not allowed to have reset under h/w control?

> +  - vdd-supply
> +  - input-report-header-address
> +  - input-report-body-address
> +  - output-report-address
> +  - read-opcode
> +  - write-opcode
> +  - hid-over-spi-flags
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/gpio/gpio.h>
> +    spi-hid-dev0 {

hid@0

And you'll need to define a spi bus.

> +      compatible = "microsoft,g6-touch-digitizer", "hid-over-spi";
> +      reg = <0>;
> +      interrupts-extended = <&gpio 42 IRQ_TYPE_EDGE_FALLING>;
> +      reset-gpios = <&gpio 27 GPIO_ACTIVE_LOW>;
> +      vdd-supply = <&pm8350c_l3>;
> +      pinctrl-names = "default";
> +      pinctrl-0 = <&ts_d6_reset_assert &ts_d6_int_bias>;
> +      input-report-header-address = <0x1000>;
> +      input-report-body-address = <0x1004>;
> +      output-report-address = <0x2000>;
> +      read-opcode = <0x0b>;
> +      write-opcode = <0x02>;
> +      hid-over-spi-flags = <0x00>;
> +      post-power-on-delay-ms = <5>;
> +      minimal-reset-delay-ms = <5>;
> +    };
> -- 
> 2.25.1
> 
> 
