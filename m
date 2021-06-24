Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E159E3B3695
	for <lists+linux-spi@lfdr.de>; Thu, 24 Jun 2021 21:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232647AbhFXTGh (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 24 Jun 2021 15:06:37 -0400
Received: from mail-io1-f47.google.com ([209.85.166.47]:33696 "EHLO
        mail-io1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232417AbhFXTGh (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 24 Jun 2021 15:06:37 -0400
Received: by mail-io1-f47.google.com with SMTP id a6so9642696ioe.0;
        Thu, 24 Jun 2021 12:04:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RNyR7WJkBi+j5cZSpglBt7CMB4kjHG9lY9GO1xbTvDI=;
        b=ZXo45QX8U+A3TzQIo/cFley6OfM/RGH+0OaTOvkH5lk8DWrb9vjPp/hRVJ9GvXcGT8
         3rlmtYMEDedPdvaA3h37SkbOZCkTVA9tj7e/Xqhv1vzNqrYnyRQS2hGxLmNVxU/p+BdO
         vXsmldTMyIaJaMfjHippUWsDE/edgxCPQJH7XENNwH+aifidA1MwWq9M8CL2baPjLjpu
         ZLqf/8WGGDQyKiXrZn4M7eoZ6KTBmJ4ktu99GXjCm5OAUZye5XboXiT5NNKQzdyY+2K8
         i7UPzjwSZlhl/oSYg08IxnZDcF7MqzwXfH41zuRMfLe6T/1k3x/IPSRCNrVgSkaa/N4X
         M93A==
X-Gm-Message-State: AOAM532Nu6VnO5d1KyIONjody+jE/1IZzeMZAOTGMSdMf3KrmQsVMyM4
        EIaziIyAmFU7ru6JvMlxiA==
X-Google-Smtp-Source: ABdhPJwXCSzJsbLCsA/ceit/PNBn7MfOoeDC+bW/W0gnmgK2bxUazXXMLP+69M/mtI5Mukc063Xldg==
X-Received: by 2002:a5d:9549:: with SMTP id a9mr5209403ios.152.1624561456623;
        Thu, 24 Jun 2021 12:04:16 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id t21sm1773281ioj.10.2021.06.24.12.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 12:04:15 -0700 (PDT)
Received: (nullmailer pid 1817466 invoked by uid 1000);
        Thu, 24 Jun 2021 19:04:09 -0000
Date:   Thu, 24 Jun 2021 13:04:09 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jon Lin <jon.lin@rock-chips.com>
Cc:     linux-spi@vger.kernel.org, broonie@kernel.org, heiko@sntech.de,
        jbx6244@gmail.com, hjc@rock-chips.com, yifeng.zhao@rock-chips.com,
        sugar.zhang@rock-chips.com, linux-rockchip@lists.infradead.org,
        linux-mtd@lists.infradead.org, p.yadav@ti.com,
        macroalpha82@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH v8 1/9] dt-bindings: rockchip-sfc: Bindings for Rockchip
 serial flash controller
Message-ID: <20210624190409.GA1815079@robh.at.kernel.org>
References: <20210611061134.31369-1-jon.lin@rock-chips.com>
 <20210611061134.31369-2-jon.lin@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210611061134.31369-2-jon.lin@rock-chips.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Jun 11, 2021 at 02:11:26PM +0800, Jon Lin wrote:
> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Add bindings for the Rockchip serial flash controller. New device
> specific parameter of rockchip,sfc-no-dma included in documentation.
> 
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> Signed-off-by: Jon Lin <jon.lin@rock-chips.com>
> ---
> 
> Changes in v8:
> - Fix indent 4 to 2 in yaml

My comments from v7 remain.

> 
> Changes in v7:
> - Fix up the sclk_sfc parent error in rk3036
> - Unify to "rockchip,sfc" compatible id because all the feature update
>   will have a new IP version, so the driver is used for the SFC IP in
>   all SoCs
> - Change to use node "sfc" to name the SFC pinctrl group
> - Add subnode reg property check
> - Add rockchip_sfc_adjust_op_size to workaround in CMD + DUMMY case
> - Limit max_iosize to 32KB
> 
> Changes in v6:
> - Add support in device trees for rv1126(Declared in series 5 but not
>   submitted)
> - Change to use "clk_sfc" "hclk_sfc" as clock lable, since it does not
>   affect interpretation and has been widely used
> - Support sfc tx_dual, tx_quad(Declared in series 5 but not submitted)
> - Simplify the code, such as remove "rockchip_sfc_register_all"(Declared
>   in series 5 but not submitted)
> - Support SFC ver4 ver5(Declared in series 5 but not submitted)
> - Add author Chris Morgan and Jon Lin to spi-rockchip-sfc.c
> - Change to use devm_spi_alloc_master and spi_unregister_master
> 
> Changes in v5:
> - Add support in device trees for rv1126
> - Support sfc tx_dual, tx_quad
> - Simplify the code, such as remove "rockchip_sfc_register_all"
> - Support SFC ver4 ver5
> 
> Changes in v4:
> - Changing patch back to an "RFC". An engineer from Rockchip
>   reached out to me to let me know they are working on this patch for
>   upstream, I am submitting this v4 for the community to see however
>   I expect Jon Lin (jon.lin@rock-chips.com) will submit new patches
>   soon and these are the ones we should pursue for mainlining. Jon's
>   patch series should include support for more hardware than this
>   series.
> - Clean up documentation more and ensure it is correct per
>   make dt_binding_check.
> - Add support in device trees for rk3036, rk3308, and rv1108.
> - Add ahb clock (hclk_sfc) support for rk3036.
> - Change rockchip_sfc_wait_fifo_ready() to use a switch statement.
> - Change IRQ code to only mark IRQ as handled if it handles the
>   specific IRQ (DMA transfer finish) it is supposed to handle.
> 
> Changes in v3:
> - Changed the name of the clocks to sfc/ahb (from clk-sfc/clk-hsfc).
> - Changed the compatible string from rockchip,sfc to
>   rockchip,rk3036-sfc. A quick glance at the datasheets suggests this
>   driver should work for the PX30, RK180x, RK3036, RK312x, RK3308 and
>   RV1108 SoCs, and possibly more. However, I am currently only able
>   to test this on a PX30 (an RK3326). The technical reference manuals
>   appear to list the same registers for each device.
> - Corrected devicetree documentation for formatting and to note these
>   changes.
> - Replaced the maintainer with Heiko Stuebner and myself, as we will
>   take ownership of this going forward.
> - Noted that the device (per the reference manual) supports 4 CS, but
>   I am only able to test a single CS (CS 0).
> - Reordered patches to comply with upstream rules.
> 
> Changes in v2:
> - Reimplemented driver using spi-mem subsystem.
> - Removed power management code as I couldn't get it working properly.
> - Added device tree bindings for Odroid Go Advance.
> 
> Changes in v1:
> hanges made in this new series versus the v8 of the old series:
> - Added function to read spi-rx-bus-width from device tree, in the
>   event that the SPI chip supports 4x mode but only has 2 pins
>   wired (such as the Odroid Go Advance).
> - Changed device tree documentation from txt to yaml format.
> - Made "reset" message a dev_dbg from a dev_info.
> - Changed read and write fifo functions to remove redundant checks.
> - Changed the write and read from relaxed to non-relaxed when
>   starting the DMA transfer or reading the DMA IRQ.
> - Changed from dma_coerce_mask_and_coherent to just
>   dma_set_mask_and_coherent.
> - Changed name of get_if_type to rockchip_sfc_get_if_type.
> 
>  .../devicetree/bindings/spi/rockchip-sfc.yaml | 88 +++++++++++++++++++
>  1 file changed, 88 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/rockchip-sfc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/spi/rockchip-sfc.yaml b/Documentation/devicetree/bindings/spi/rockchip-sfc.yaml
> new file mode 100644
> index 000000000000..162993a97290
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/rockchip-sfc.yaml
> @@ -0,0 +1,88 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spi/rockchip-sfc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Rockchip Serial Flash Controller (SFC)
> +
> +maintainers:
> +  - Heiko Stuebner <heiko@sntech.de>
> +  - Chris Morgan <macromorgan@hotmail.com>
> +
> +allOf:
> +  - $ref: spi-controller.yaml#
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: rockchip,sfc
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: Bus Clock
> +      - description: Module Clock
> +
> +  clock-names:
> +    items:
> +      - const: clk_sfc
> +      - const: hclk_sfc
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  rockchip,sfc-no-dma:
> +    description: Disable DMA and utilize FIFO mode only
> +    type: boolean
> +
> +patternProperties:
> +  "^flash@[0-3]$":
> +    type: object
> +    properties:
> +      reg:
> +        minimum: 0
> +        maximum: 3
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/px30-cru.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/power/px30-power.h>
> +
> +    sfc: spi@ff3a0000 {
> +        compatible = "rockchip,sfc";
> +        reg = <0xff3a0000 0x4000>;
> +        interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
> +        clocks = <&cru SCLK_SFC>, <&cru HCLK_SFC>;
> +        clock-names = "clk_sfc", "hclk_sfc";
> +        pinctrl-0 = <&sfc_clk &sfc_cs &sfc_bus2>;
> +        pinctrl-names = "default";
> +        power-domains = <&power PX30_PD_MMC_NAND>;
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        flash@0 {
> +            compatible = "jedec,spi-nor";
> +            reg = <0>;
> +            spi-max-frequency = <108000000>;
> +            spi-rx-bus-width = <2>;
> +            spi-tx-bus-width = <2>;
> +        };
> +    };
> +
> +...
> -- 
> 2.17.1
> 
> 
> 
> 
