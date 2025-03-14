Return-Path: <linux-spi+bounces-7152-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E05B9A61D97
	for <lists+linux-spi@lfdr.de>; Fri, 14 Mar 2025 22:07:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3997F42088F
	for <lists+linux-spi@lfdr.de>; Fri, 14 Mar 2025 21:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8267B2040A1;
	Fri, 14 Mar 2025 21:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mllpNJ2v"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F89B190676;
	Fri, 14 Mar 2025 21:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741986413; cv=none; b=satuQsh3Xw9tOP9nVg/WicQTWCq/cBuuaQ7imJJOviNjQ0UU/kA3y6YEfvVMToehi27VZZpwGNkh9QHZDUpAbMB2lSLU7cy0Fg7TAadESyjsl+FYAY/tdwEr0LQcdxDT7oH/frRimpQKYob31qMgXkBMFtAXKTInF2WSB3ZyLOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741986413; c=relaxed/simple;
	bh=updmW668AXuEczJRzXxFtdkEvCU4OrjNSAp3qpvjLw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QAoEprK5pRTt3IXscKDk+jDJQWCw6NEK6G6Mpwn0G6VOVCE4BLCho7HmN36NviYT13u+iSKJ8znilNOqP1c7EUmQM0WI5BDeVZtVljy/rLyZdZrY5HP//0DgQ4SeIW0Y2I4QQypaN4lAnjHjFz+ZzeUdZefR2iYjfHdY7+P6ZAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mllpNJ2v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01900C4CEE3;
	Fri, 14 Mar 2025 21:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741986413;
	bh=updmW668AXuEczJRzXxFtdkEvCU4OrjNSAp3qpvjLw4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mllpNJ2vShm53XePYhANE9KP2D4263ZkCTgGDLtAm7AFn21OBMlK1F/dNkxUhUoAM
	 mf80c3yVKPa9GP29CvxlKBUKkSHRggb1ciT/HolwQ/a4TktfQQ2aBweYsUCF8mU7ad
	 jIgbER5NtY8oSUMWQmNbDQlhKZfhjyeYxtz0VbLDHegKY7dlrWDLuAsz9CQ/kmqxPK
	 lyDdyxynK7HtA/JZPnlUrCAtFmEZ/iojSonoH+9hM+IquUbweStcvNr5oR/POr7te1
	 0oj5dQidA4o4fwcw0lD6fQ/a9CtRtcH47crB4M+bXH6C6VGlUw9SpRo22zeT78Hwad
	 Vpbw40GJ/8tVA==
Date: Fri, 14 Mar 2025 16:06:52 -0500
From: Rob Herring <robh@kernel.org>
To: Maud Spierings <maudspierings@gocontroll.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Sam Ravnborg <sam@ravnborg.org>, Liu Ying <victor.liu@nxp.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Mark Brown <broonie@kernel.org>,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH v2 03/12] dt-bindings: connector: Add the GOcontroll
 Moduline module slot bindings
Message-ID: <20250314210652.GA2300828-robh@kernel.org>
References: <20250226-initial_display-v2-0-23fafa130817@gocontroll.com>
 <20250226-initial_display-v2-3-23fafa130817@gocontroll.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226-initial_display-v2-3-23fafa130817@gocontroll.com>

On Wed, Feb 26, 2025 at 03:19:14PM +0100, Maud Spierings wrote:
> Add the bindings that describe a GOcontroll Moduline module slot. This
> slot provides all the interfaces to interface with a Moduline compatible
> IO module. The actual module is not reasonable to describe as it can be
> swapped at will, with this connector the driver will be able to probe
> for a module on boot.
> 
> The connector consists of 2 parts, one part for interfacing with the SoC
> and main board, the other part has 13 IO channels for the module to
> interact with the outside world. The functions of these IO channels are
> determined by the type of module in the slot. The IO on the SoC side is
> as follows:
> 
>  - a 3v3 supply, this tends to be the logic level of the module and its
>    microcontroller
>  - a 5v0 supply, this can be used to power low power peripherals on the
>    module
>  - a 6v-8v supply, this can be used for high power peripherals on the
>    module
>  - a 6v-30v supply, this tends to be a dirty supply that comes from the
>    controller supply after some circuit protection, or is the same as
>    the 6v-8v supply.
>  - an SPI bus which carries the communication between the SoC and the
>    microcontroller on the module.
>  - an I2C bus shared between the SoC and all module slots which can
>    carry direct module-to-module communication.
>  - a reset line
>  - an interrupt line that indicates a clear to transmit signal
>  - a sync line shared between the SoC and all module slots which could
>    be used to synchronize modules for time sensitive IO spread across
>    modules.
>  - a SMBus alert line that is shared between the modules but is not
>    connected to the SoC so that is ignored.
> 
> A slot-number property is used to identify the physical location of a
> module slot. Without it, it would be impossible to identify which module
> to control if there are multiple of one type, to address the desired IO.

Is that for a person to identify slots or s/w? If just a person, we 
generally use 'label' as in a sticker on the connector. If s/w, we 
generally try to avoid made up indexing in DT though there are some 
exceptions.

> 
> Signed-off-by: Maud Spierings <maudspierings@gocontroll.com>
> ---
>  .../connector/gocontroll,moduline-module-slot.yaml | 88 ++++++++++++++++++++++
>  1 file changed, 88 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/connector/gocontroll,moduline-module-slot.yaml b/Documentation/devicetree/bindings/connector/gocontroll,moduline-module-slot.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..a16ae2762d160180d5b163e20f5294235e65053b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/connector/gocontroll,moduline-module-slot.yaml
> @@ -0,0 +1,88 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/connector/gocontroll,moduline-module-slot.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: GOcontroll Moduline Module slot
> +
> +maintainers:
> +  - Maud Spierings <maudspierings@gocontroll.com>
> +
> +description:
> +  The GOcontroll Moduline module slot represents a connector that fullfills the
> +  Moduline slot specification, and can thus house any IO module that is also
> +  built to this spec.
> +
> +properties:
> +  compatible:
> +    const: gocontroll,moduline-module-slot
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    description: indicates readiness, high means busy.
> +    maxItems: 1
> +  reset-gpios:
> +    description: resets the module, active low.
> +    maxItems: 1
> +  sync-gpios:
> +    description: sync line between all module slots.
> +    maxItems: 1
> +
> +  vdd-supply:
> +    description: low power 3v3 supply generally for the microcontroller.
> +  vddp-supply:
> +    description: medium power 5v0 supply for on module low power peripherals.
> +  vddhpp-supply:
> +    description: high power 6v-8v supply for on module high power peripherals.
> +  power-supply:
> +    description: high power 6v-30v supply for high power module circuits.
> +
> +  i2c-bus:
> +    description: i2c bus shared between module slots and the SoC
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +
> +  slot-number:
> +    description:
> +      The number of the module slot representing the location of on the pcb.
> +      This enables access to the modules based on slot location.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  spi-max-frequency: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - reset-gpios
> +  - interrupts
> +  - sync-gpios
> +  - i2c-bus
> +  - slot-number
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        connector@0 {

I find this being a SPI device a bit strange. Is there a defined SPI 
device that every slot is going to have? Or the connector has SPI 
interface and *anything* could be attached on it?

> +            reg = <0>;
> +            compatible = "gocontroll,moduline-module-slot";
> +            reset-gpios = <&gpio5 10 GPIO_ACTIVE_LOW>;
> +            sync-gpios = <&gpio4 16 GPIO_ACTIVE_HIGH>;
> +            interrupt-parent = <&gpio4>;
> +            interrupts = <5 IRQ_TYPE_EDGE_FALLING>;
> +            vdd-supply = <&reg_3v3_per>;
> +            vddp-supply = <&reg_5v0>;
> +            vddhpp-supply = <&reg_6v4>;
> +            i2c-bus = <&i2c2>;
> +            slot-number = <1>;
> +        };
> +    };
> 
> -- 
> 2.48.1
> 

