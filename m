Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D911B153828
	for <lists+linux-spi@lfdr.de>; Wed,  5 Feb 2020 19:31:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbgBESbV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 5 Feb 2020 13:31:21 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34954 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727081AbgBESbV (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 5 Feb 2020 13:31:21 -0500
Received: by mail-wm1-f67.google.com with SMTP id b17so4062413wmb.0;
        Wed, 05 Feb 2020 10:31:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6Wdi1Nw0TkbyvcKynPsbbC+SOzflRd/srDAI90XenZE=;
        b=GWq+dEQUXJlz0Ac+2OGlrCSA6NW0bLszpGjJr6FLbFDw++7/B6JfgfKK7JXW6xDEpX
         ClPgg42p8WWlk9HzWIhhrV32VNGmYuXrkdQf/XzhwsZfAofY5hOBb+v8qilBqdmKDpzG
         MwOIUreO71vfHNXJpKFEjOyxR+cHOCziD9JZiX8TFoEaulY7ShbR6XbAgdrDyX7FEJH6
         GmrNP3GMXU4XrP+hcA3a0MStjOv4mX+mr2EBYqxMYU++WncDWNgl/mTmxL/6k1iQzmWi
         C2MOqzgwS9+uRQHiPwXRlIk5kLuiXkz4Haf0DHFXLIjC8DvYWGXlB+dMdmxEHxTk512V
         R27g==
X-Gm-Message-State: APjAAAXLW1cn8gPe47zCVGovYuTW8Im5cPf2QmoCtt3YtVDdGf4OtOQq
        ujeghYlm2fD/rmQrGLvJWA==
X-Google-Smtp-Source: APXvYqyn42Q1ovkJ2Lu+d8qWkUbTjADyn1vtAXRSpRxtBayMzNNVpcCMSU3WQqP8Tvcd/ZzJv+vAIw==
X-Received: by 2002:a1c:e388:: with SMTP id a130mr6975762wmh.176.1580927476553;
        Wed, 05 Feb 2020 10:31:16 -0800 (PST)
Received: from rob-hp-laptop ([212.187.182.166])
        by smtp.gmail.com with ESMTPSA id k13sm732442wrx.59.2020.02.05.10.31.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 10:31:15 -0800 (PST)
Received: (nullmailer pid 351 invoked by uid 1000);
        Wed, 05 Feb 2020 18:31:14 -0000
Date:   Wed, 5 Feb 2020 18:31:14 +0000
From:   Rob Herring <robh@kernel.org>
To:     Konrad Kociolek <konrad@cadence.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] Add dt-bindings for Cadence XSPI controller
Message-ID: <20200205183114.GA23752@bogus>
References: <20200128124313.12837-1-konrad@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200128124313.12837-1-konrad@cadence.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Jan 28, 2020 at 01:43:04PM +0100, Konrad Kociolek wrote:
> Add dt-bindings documentation for Cadence XSPI controller to support
> SPI based flash memories.
> 
> Signed-off-by: Konrad Kociolek <konrad@cadence.com>
> ---
> Changes between initial version and v2:
>   - renamed yaml file
>   - added missing include
> 
>  .../devicetree/bindings/spi/cdns,xspi.yaml         | 166 +++++++++++++++++++++
>  1 file changed, 166 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/cdns,xspi.yaml
> 
> diff --git a/Documentation/devicetree/bindings/spi/cdns,xspi.yaml b/Documentation/devicetree/bindings/spi/cdns,xspi.yaml
> new file mode 100644
> index 000000000000..e8c43957fd90
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/cdns,xspi.yaml
> @@ -0,0 +1,166 @@
> +# SPDX-License-Identifier: (GPL-2.0)

Dual license new bindings:

(GPL-2.0-only OR BSD-2-Clause)

> +# Copyright 2020 Cadence
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/spi/cdns,xspi.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Cadence XSPI Controller
> +
> +maintainers:
> +  - Konrad Kociolek <konrad@cadence.com>
> +
> +description: |
> +  The XSPI controller allows SPI protocol communication in
> +  single, dual, quad or octal wire transmission modes for
> +  read/write access to slaves such as SPI-NOR flash.
> +

Needs a ref to spi-controller.yaml

> +properties:
> +  compatible:
> +    const: cdns,xspi-nor-fpga
> +
> +  reg:
> +    maxItems: 3
> +    description: |
> +      Contains three entries, each of which is a tuple consisting of a
> +      physical address and length. The first entry is the address and
> +      length of the controller register set. The second entry is the
> +      address and length of the Slave DMA data port. The third entry is
> +      the address and length of auxiliary registers.

Split into 3 descriptions:

items:
  - description: ...
  - description: ...
  - description: ...

With that, drop 'maxItems' as it is implied.

> +
> +  interrupts:
> +    maxItems: 1
> +
> +  cdns,dqs-last-data-drop:
> +    type: boolean
> +    description: |
> +      This parameter should be set when the Flash Device being used
> +      issues data on negative edge of Flash clock and returns them with
> +      DQS and the PHY is configured to sample data in DQS mode.
> +      If this param is set the controller internally requests this redundant
> +      data at the end of the transfer cleaning up the PHY FIFO.
> +
> +  cdns,phy-data-select-oe-start:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      Adjusts the starting point of the DQ pad output enable window.
> +      Lower numbers pull the rising edge earlier in time and larger
> +      numbers cause the rising edge to be delayed. Each bit changes
> +      the output enable time by a 1/2 cycle resolution.
> +
> +  cdns,phy-data-select-oe-end:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      Adjusts the ending point of the DQ pad output enable window.
> +      Lower numbers pull the falling edge earlier in time and larger
> +      numbers cause the falling edge to be delayed. Each bit changes
> +      the output enable time by a 1/2 cycle resolution.
> +
> +  cdns,phy-dqs-select-oe-start:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      Adjusts the starting point of the DQS pad output enable window.
> +      Lower numbers pull the rising edge earlier in time and larger
> +      numbers cause the rising edge to be delayed. Each bit changes
> +      the output enable time by a 1/2 cycle resolution.
> +
> +  cdns,phy-dqs-select-oe-end:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      Adjusts the ending point of the DQS pad output enable window.
> +      Lower numbers pull the falling edge earlier in time and larger
> +      numbers cause the falling edge to be delayed. Each bit changes
> +      the output enable time by a 1/2 cycle resolution.
> +
> +  cdns,phy-gate-cfg-close:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      Normally the gate is closing then all bits of dfi_cebar are high
> +      or when dfi_rd_pre_post_amble and rebar_dfi are high. This parameter
> +      allows to extend the closing of the DQS gate. Recommended zero.
> +
> +  cdns,phy-gate-cfg:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      Coarse adjust of gate open time. This value is the number of cycles
> +      to delay the dfi_rddata_en signal prior to opening the gate in
> +      full cycle increments. Decreasing this value pulls the gate earlier
> +      in time. This field should be programmed such that the gate signal
> +      lands in the valid DQS gate window.
> +
> +  cdns,phy-rd-del-select:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      Defines the read data delay. Holds the number of cycles to delay
> +      the dfi_rddata_en signal prior to enabling the read FIFO.
> +      After this delay, the read pointers begin incrementing the read FIFO.
> +
> +  cdns,phy-clk-wr-delay:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      Controls the clk_wr delay line which adjusts the write DQ bit
> +      timing in 1/256th steps of the clock period in normal DLL
> +      locked mode. In bypass mode this field directly programs
> +      the number of delay elements.

For all of these, any constraints on the values? default?

> +
> +  cdns,phy-use-lpbk-dqs:
> +    type: boolean
> +    description: |
> +      This parameter chooses lpbk_dqs to capture data for reads.
> +      Instead memory DQS will be used.
> +
> +  cdns,phy-use-ext-lpbk-dqs:
> +    type: boolean
> +    description: |
> +      This parameter chooses external lpbk_dqs for data capture
> +      (lpbk_dqs connected to the lpbk_dqs_IO pad). When not used
> +      mem_rebar_pad is used for data read capture.
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - cdns,phy-data-select-oe-start
> +  - cdns,phy-data-select-oe-end
> +  - cdns,phy-dqs-select-oe-start
> +  - cdns,phy-dqs-select-oe-end
> +  - cdns,phy-gate-cfg-close
> +  - cdns,phy-gate-cfg
> +  - cdns,phy-rd-del-select
> +  - cdns,phy-clk-wr-delay

Is there no sensible default to make these optional?

> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    xspi: spi@a0010000 {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        compatible = "cdns,xspi-nor-fpga";
> +        reg = <0x0 0xa0010000 0x0 0x10000>,
> +              <0x0 0xb0000000 0x0 0x10000>,
> +              <0x0 0xa0020000 0x0 0x10000>;
> +        interrupts = <0 90 IRQ_TYPE_LEVEL_HIGH>;
> +        interrupt-parent = <&gic>;
> +        cdns,dqs-last-data-drop;
> +        cdns,phy-data-select-oe-start = <0>;
> +        cdns,phy-data-select-oe-end = <4>;
> +        cdns,phy-dqs-select-oe-start = <0>;
> +        cdns,phy-dqs-select-oe-end = <1>;
> +        cdns,phy-gate-cfg-close = <3>;
> +        cdns,phy-gate-cfg = <0>;
> +        cdns,phy-rd-del-select = <5>;
> +        cdns,phy-clk-wr-delay = <64>;
> +        cdns,phy-use-lpbk-dqs;
> +        cdns,phy-use-ext-lpbk-dqs;
> +        mt35xu512@0 {

flash@0

> +            compatible = "spi-nor", "micron,mt35xu512";

Wrong order. Most specific first.

> +            spi-max-frequency = <75000000>;
> +            reg = <0>;
> +        };
> +        mt35xu512@1 {

flash@1

> +            compatible = "spi-nor", "micron,mt35xu512";
> +            spi-max-frequency = <75000000>;
> +            reg = <1>;
> +        };
> +    };
> -- 
> 2.15.0
> 
