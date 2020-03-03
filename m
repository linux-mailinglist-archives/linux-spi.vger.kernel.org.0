Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB41D1785DE
	for <lists+linux-spi@lfdr.de>; Tue,  3 Mar 2020 23:47:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbgCCWrJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 3 Mar 2020 17:47:09 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:32836 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbgCCWrJ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 3 Mar 2020 17:47:09 -0500
Received: by mail-ot1-f65.google.com with SMTP id a20so121783otl.0;
        Tue, 03 Mar 2020 14:47:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Z0du2wcxyjg7iRH0s/qpIMsj7X0YCwaBDvE2vsxIrbk=;
        b=ptKay2zTXDuwv4sLGKm+yU3NkVByKaqrWKWW8+yMBqmbO7bGEAsTuOxCR9dOc1Mopm
         qpnJxckMJyfIvQgVZw6JW85HJpsVJMWhhUe0bqiNX2JUp2dU8N3+fx34f7MbEHkSZwyA
         5GUOMeaVzIiq1084X6YvAC6NH+tuklJF1c5nPBGj81i9cZWGx7CFzFRcsT+6XGGTODsN
         KRxwYnvQKbs7gNQsr+mRquu4PkSmkCuVhoM7vTTpZAkSBfdUEgk9PiV2HzRQJ9IAmhtx
         kvJhfmAch4hWexgOHY5W3VI/ddbI8+2c7/kQyRq6Gylyqvsv0fwgRz231c8UcLqPKO9k
         Ehew==
X-Gm-Message-State: ANhLgQ21VIBHaKa3T+u+yr7vPTojh5vTOw9jtx4qb5MQnU9Vwh3PiZri
        ARfE9upaUW6Un71mAgWMHA==
X-Google-Smtp-Source: ADFU+vuU+JCOVQpYg1AlYEQdEKGSsg5SLhgtKZoaS1dScWhKEQWMAhE4l5CbjQlxM9gWy34zkZG6zg==
X-Received: by 2002:a9d:4c92:: with SMTP id m18mr129586otf.168.1583275628368;
        Tue, 03 Mar 2020 14:47:08 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id b2sm5879600oii.20.2020.03.03.14.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 14:47:07 -0800 (PST)
Received: (nullmailer pid 32174 invoked by uid 1000);
        Tue, 03 Mar 2020 22:47:06 -0000
Date:   Tue, 3 Mar 2020 16:47:06 -0600
From:   Rob Herring <robh@kernel.org>
To:     Chuanhong Guo <gch981213@gmail.com>
Cc:     linux-mediatek@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/4] dt-bindings: convert mtk-quadspi binding doc for
 spi-mtk-nor
Message-ID: <20200303224706.GA22867@bogus>
References: <20200228043636.559915-1-gch981213@gmail.com>
 <20200228043636.559915-4-gch981213@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200228043636.559915-4-gch981213@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Feb 28, 2020 at 12:36:35PM +0800, Chuanhong Guo wrote:
> spi-mtk-nor is a driver to replace mtk-quadspi and they have almost
> the same device-tree bindings. Reuse this binding documentation and
> convert it for new driver:
> 
> 1. "Mediatek SoCs" -> "Mediatek ARM SoCs" because MTK MIPS SoCs
>    use different controllers.
> 2. document "interrupts" as a required property because it's
>    available on all SoCs with this controller and new driver takes
>    advantages of it. It's implemented as optional only to maintain
>    backward compatibility.
> 3. replace binding example with a mt7629 one because this is the
>    only one I know the interrupt assignment.

That doesn't really matter. It would be less churn without that change 
and examples are just examples.

> 
> Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
> ---
> Change since v1:
>  none
> 
>  .../mtk-quadspi.txt => spi/spi-mtk-nor.txt}   | 34 ++++++++-----------
>  1 file changed, 15 insertions(+), 19 deletions(-)
>  rename Documentation/devicetree/bindings/{mtd/mtk-quadspi.txt => spi/spi-mtk-nor.txt} (62%)
> 
> diff --git a/Documentation/devicetree/bindings/mtd/mtk-quadspi.txt b/Documentation/devicetree/bindings/spi/spi-mtk-nor.txt
> similarity index 62%
> rename from Documentation/devicetree/bindings/mtd/mtk-quadspi.txt
> rename to Documentation/devicetree/bindings/spi/spi-mtk-nor.txt
> index a12e3b5c495d..829da480b9a9 100644
> --- a/Documentation/devicetree/bindings/mtd/mtk-quadspi.txt
> +++ b/Documentation/devicetree/bindings/spi/spi-mtk-nor.txt
> @@ -1,4 +1,4 @@
> -* Serial NOR flash controller for MediaTek SoCs
> +* SPI NOR flash controller for MediaTek ARM SoCs
>  
>  Required properties:
>  - compatible: 	  For mt8173, compatible should be "mediatek,mt8173-nor",
> @@ -13,6 +13,7 @@ Required properties:
>  		  "mediatek,mt7629-nor", "mediatek,mt8173-nor"
>  		  "mediatek,mt8173-nor"
>  - reg: 		  physical base address and length of the controller's register
> +- interrupts:	  Interrupt number used by the controller.
>  - clocks: 	  the phandle of the clocks needed by the nor controller
>  - clock-names: 	  the names of the clocks
>  		  the clocks should be named "spi" and "sf". "spi" is used for spi bus,
> @@ -22,29 +23,24 @@ Required properties:
>  - #address-cells: should be <1>
>  - #size-cells:	  should be <0>
>  
> -The SPI flash must be a child of the nor_flash node and must have a
> -compatible property. Also see jedec,spi-nor.txt.
> -
> -Required properties:
> -- compatible:	  May include a device-specific string consisting of the manufacturer
> -		  and name of the chip. Must also include "jedec,spi-nor" for any
> -		  SPI NOR flash that can be identified by the JEDEC READ ID opcode (0x9F).
> -- reg :		  Chip-Select number
> +There should be only one spi slave device following generic spi bindings.
> +It's not recommended to use this controller for devices other than SPI NOR
> +flash due to limited transfer capability of this controller.
>  
>  Example:
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/clock/mt7629-clk.h>
>  
> -nor_flash: spi@1100d000 {
> -	compatible = "mediatek,mt8173-nor";
> -	reg = <0 0x1100d000 0 0xe0>;
> -	clocks = <&pericfg CLK_PERI_SPI>,
> -		 <&topckgen CLK_TOP_SPINFI_IFR_SEL>;
> +spi_nor: spi@11014000 {
> +	compatible = "mediatek,mt7629-nor",
> +		     "mediatek,mt8173-nor";
> +	reg = <0x11014000 0xe0>;
> +	interrupts = <GIC_SPI 88 IRQ_TYPE_LEVEL_LOW>;
> +	clocks = <&pericfg CLK_PERI_FLASH_PD>,
> +		 <&topckgen CLK_TOP_FLASH_SEL>;
>  	clock-names = "spi", "sf";
>  	#address-cells = <1>;
>  	#size-cells = <0>;
> -
> -	flash@0 {
> -		compatible = "jedec,spi-nor";
> -		reg = <0>;
> -	};

Better to leave this in the example IMO.

Rob
