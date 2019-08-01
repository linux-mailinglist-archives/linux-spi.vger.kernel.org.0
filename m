Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77E767DE21
	for <lists+linux-spi@lfdr.de>; Thu,  1 Aug 2019 16:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbfHAOmj (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 1 Aug 2019 10:42:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:57782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726017AbfHAOmj (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 1 Aug 2019 10:42:39 -0400
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AFB6A20B7C;
        Thu,  1 Aug 2019 14:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564670557;
        bh=GprFswuM78S+VgBUwByzLyrYSPJVf3nxGZ4gKaEnPOI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=z/HdMI/AIy5FG1El2tcpyMP7dY2ibpvP+xRzzk8m0sK5HDQZTnayJoCJObknAGVZ4
         W1uKR5i//rhhMJjOvZkNEJrEiib7P59EoQP6Hfb72LXpKeqytILuerqVXOcJOxD2NK
         grcU3VwO0oom9Fe5WlBevZ+wHeX2T33aW2GXOYBc=
Received: by mail-qt1-f175.google.com with SMTP id r6so66218428qtt.0;
        Thu, 01 Aug 2019 07:42:37 -0700 (PDT)
X-Gm-Message-State: APjAAAXPiaPoWL2cAREbQfvlJ/Ms5WOVgXnkBN/uB87EEAIuXN1TFMCf
        g1ecYGCQ3Sv6ZrPmCDLh6w97SwZcs9ReRYdH/g==
X-Google-Smtp-Source: APXvYqw7U48NblAeJFrFkeTHFyKp5QLlcheCe1VY0HORPOiVyncpm84GhT+LSusKRubHI4v73Qi9L1rIYf5NYy03mFs=
X-Received: by 2002:aed:3f10:: with SMTP id p16mr90788503qtf.110.1564670556872;
 Thu, 01 Aug 2019 07:42:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190801135644.12843-1-narmstrong@baylibre.com> <20190801135644.12843-4-narmstrong@baylibre.com>
In-Reply-To: <20190801135644.12843-4-narmstrong@baylibre.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 1 Aug 2019 08:42:23 -0600
X-Gmail-Original-Message-ID: <CAL_JsqK9ODpXq_VkP4ztW7JAfPNOxpdP1W1duQwaUu0tYNh_Dw@mail.gmail.com>
Message-ID: <CAL_JsqK9ODpXq_VkP4ztW7JAfPNOxpdP1W1duQwaUu0tYNh_Dw@mail.gmail.com>
Subject: Re: [RFC 3/9] dt-bindings: spi: meson: convert to yaml
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

On Thu, Aug 1, 2019 at 7:56 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  .../bindings/spi/amlogic,meson-gx-spicc.yaml  | 74 +++++++++++++++++++
>  .../bindings/spi/amlogic,meson6-spifc.yaml    | 57 ++++++++++++++
>  .../devicetree/bindings/spi/spi-meson.txt     | 55 --------------
>  3 files changed, 131 insertions(+), 55 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml
>  create mode 100644 Documentation/devicetree/bindings/spi/amlogic,meson6-spifc.yaml
>  delete mode 100644 Documentation/devicetree/bindings/spi/spi-meson.txt
>
> diff --git a/Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml b/Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml
> new file mode 100644
> index 000000000000..6e2c41c730b5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml
> @@ -0,0 +1,74 @@
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
> +    oneOf:
> +     - description: SPICC controller on Amlogic GX and compatible SoCs
> +       enum:
> +       - amlogic,meson-gx-spicc
> +     - description: SPICC controller on Amlogic AXG and compatible SoCs
> +       enum:
> +       - amlogic,meson-axg-spicc

'oneOf' results in vague error messages and can be avoided here. Plus
I don't think the descriptions add much as I could pretty much
generate the desc "<block> controller on <vendor> <soc> and compatible
SoCs" from <vendor>,<soc>-<block>.

Though, if you want to keep the description, do it as a comment:

enum:
  - amlogic,meson-gx-spicc # SPICC controller on Amlogic GX and compatible SoCs
  - amlogic,meson-axg-spicc # SPICC controller on Amlogic AXG and
compatible SoCs

> +
> +  interrupts:
> +    maxItems: 1
> +
> +  reg:
> +    maxItems: 1
> +
> +  resets:
> +    description: phandle of the internal reset line

Standard property, don't need a description unless there's something
special about this binding.

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

> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0

These 2 can be dropped as they are covered by spi-controller.yaml.

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +  - "#address-cells"
> +  - "#size-cells"
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

Probably should add a slave node. Once I figure out how to always
build the examples with W=12, the lack of a chlid node will throw a
dtc warning.

> +    };
> +
> diff --git a/Documentation/devicetree/bindings/spi/amlogic,meson6-spifc.yaml b/Documentation/devicetree/bindings/spi/amlogic,meson6-spifc.yaml
> new file mode 100644
> index 000000000000..5f34aed1ad40
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/amlogic,meson6-spifc.yaml

Some of the same comments apply to this one.

> @@ -0,0 +1,57 @@
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
> +    oneOf:
> +     - enum:
> +       - amlogic,meson6-spifc
> +     - enum:
> +       - amlogic,meson-gxbb-spifc

Drop the oneOf. A single enum is sufficient.

> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - "#address-cells"
> +  - "#size-cells"
> +
> +examples:
> +  - |
> +    spi@c1108c80 {
> +          compatible = "amlogic,meson6-spifc";
> +          reg = <0xc1108c80 0x80>;
> +          clocks = <&clk81>;
> +          #address-cells = <1>;
> +          #size-cells = <0>;
> +    };
> +
