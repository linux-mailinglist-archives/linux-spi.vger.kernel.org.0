Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A64E8271D
	for <lists+linux-spi@lfdr.de>; Mon,  5 Aug 2019 23:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728851AbfHEVqC (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 5 Aug 2019 17:46:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:51364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728483AbfHEVqC (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 5 Aug 2019 17:46:02 -0400
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 106CA214C6;
        Mon,  5 Aug 2019 21:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565041561;
        bh=subSU4ANuK0qDVBd0vAG1AnkJerzP5pOi4fyuHG8xv8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=13tUIInKnE4eHNYqfY1p4vcbK2rEnqAFvan1kVXBDW5FZeUc/8i5HWU+RjTF0itMs
         +boDbn8fAivIGCUSTItUaBOwiciY4eztk4XvucyK4bMgGINLKBaIPaggQPc9KbX1nR
         7PC+lVjFWRm3eoAteReg3RaM3tm6BqPXNMJG6WrY=
Received: by mail-qt1-f182.google.com with SMTP id d23so82561756qto.2;
        Mon, 05 Aug 2019 14:46:01 -0700 (PDT)
X-Gm-Message-State: APjAAAVhjJ3h/OjZHpmfTcamienHkKVWWlHPv5ReNxOvtPgPZhgs/uRi
        FtuXF8Kuc3MO9gBtSgpBl7Xj6tccWtrxl0+RAw==
X-Google-Smtp-Source: APXvYqzBwGXmcn81biCg4KLoojhRENYm4XDLvNlQS3MkA879bNBj02ITgrBwmCGub/Tr10uEARqqTe/pjnCfytTfQ3E=
X-Received: by 2002:aed:3f10:: with SMTP id p16mr249407qtf.110.1565041560261;
 Mon, 05 Aug 2019 14:46:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190805120320.32282-1-narmstrong@baylibre.com> <20190805120320.32282-4-narmstrong@baylibre.com>
In-Reply-To: <20190805120320.32282-4-narmstrong@baylibre.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 5 Aug 2019 15:45:48 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+WQ6KAE+d2_Pu03s6cSbu4PUErUWrGj81cAivTBNWBxQ@mail.gmail.com>
Message-ID: <CAL_Jsq+WQ6KAE+d2_Pu03s6cSbu4PUErUWrGj81cAivTBNWBxQ@mail.gmail.com>
Subject: Re: [RFCv2 3/9] dt-bindings: spi: meson: convert to yaml
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org,
        linux-spi <linux-spi@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Aug 5, 2019 at 6:03 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Now that we have the DT validation in place, let's convert the device tree
> bindings for the Amlogic SPI controllers over to two separate YAML schemas.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  .../bindings/spi/amlogic,meson-gx-spicc.yaml  | 67 +++++++++++++++++++
>  .../bindings/spi/amlogic,meson6-spifc.yaml    | 53 +++++++++++++++
>  .../devicetree/bindings/spi/spi-meson.txt     | 55 ---------------
>  3 files changed, 120 insertions(+), 55 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml
>  create mode 100644 Documentation/devicetree/bindings/spi/amlogic,meson6-spifc.yaml
>  delete mode 100644 Documentation/devicetree/bindings/spi/spi-meson.txt
>
> diff --git a/Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml b/Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml
> new file mode 100644
> index 000000000000..49b617c98ae7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml
> @@ -0,0 +1,67 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright 2019 BayLibre, SAS
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/spi/amlogic,meson-gx-spicc.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Amlogic Meson SPI Communication Controller
> +
> +maintainers:
> +  - Neil Armstrong <narmstrong@baylibre.com>
> +
> +allOf:
> +  - $ref: "spi-controller.yaml#"
> +
> +description: |
> +  The Meson SPICC is a generic SPI controller for general purpose Full-Duplex
> +  communications with dedicated 16 words RX/TX PIO FIFOs.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - amlogic,meson-gx-spicc # SPICC controller on Amlogic GX and compatible SoCs
> +      - amlogic,meson-axg-spicc # SPICC controller on Amlogic AXG and compatible SoCs
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  reg:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    description: input clock for the baud rate generator
> +    items:
> +      - const: core
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +
> +examples:
> +  - |
> +    spi@c1108d80 {
> +          compatible = "amlogic,meson-gx-spicc";
> +          reg = <0xc1108d80 0x80>;
> +          interrupts = <112>;
> +          clocks = <&clk81>;
> +          clock-names = "core";
> +          #address-cells = <1>;
> +          #size-cells = <0>;
> +
> +          ethernet-switch@0 {
> +              compatible = "micrel,ks8995m";
> +              spi-max-frequency = <1000000>;
> +              reg = <0>;
> +          };
> +    };
> +
> diff --git a/Documentation/devicetree/bindings/spi/amlogic,meson6-spifc.yaml b/Documentation/devicetree/bindings/spi/amlogic,meson6-spifc.yaml
> new file mode 100644
> index 000000000000..67dcedc81a5e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/amlogic,meson6-spifc.yaml
> @@ -0,0 +1,53 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright 2019 BayLibre, SAS
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/spi/amlogic,meson6-spifc.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Amlogic Meson SPI Flash Controller
> +
> +maintainers:
> +  - Neil Armstrong <narmstrong@baylibre.com>
> +
> +allOf:
> +  - $ref: "spi-controller.yaml#"
> +
> +description: |
> +  The Meson SPIFC is a controller optimized for communication with SPI
> +  NOR memories, without DMA support and a 64-byte unified transmit /
> +  receive buffer.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - amlogic,meson6-spifc # SPI Flash Controller on Meson6 and compatible SoCs
> +      - amlogic,meson-gxbb-spifc # SPI Flash Controller on GXBB and compatible SoCs
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +
> +examples:
> +  - |
> +    spi@c1108c80 {
> +          compatible = "amlogic,meson6-spifc";
> +          reg = <0xc1108c80 0x80>;
> +          clocks = <&clk81>;
> +          #address-cells = <1>;
> +          #size-cells = <0>;
> +
> +          flash: m25p80@0 {

flash@0

I need to write a schema for this or I'll never stop giving this comment...

Otherwise,

Reviewed-by: Rob Herring <robh@kernel.org>

> +              compatible = "spansion,m25p80", "jedec,spi-nor";
> +              reg = <0>;
> +              spi-max-frequency = <40000000>;
> +          };
> +    };
> +
