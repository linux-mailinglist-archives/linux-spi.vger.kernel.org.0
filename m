Return-Path: <linux-spi+bounces-9210-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA487B14E28
	for <lists+linux-spi@lfdr.de>; Tue, 29 Jul 2025 15:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68F8B7A4E7E
	for <lists+linux-spi@lfdr.de>; Tue, 29 Jul 2025 13:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C38AC259498;
	Tue, 29 Jul 2025 13:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cTFwhVQy"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988851BDCF;
	Tue, 29 Jul 2025 13:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753794778; cv=none; b=lKA1brNnE4QmfCedpHI39gO4xcRqJ0V2vldGXLbNtYVD67H9RhNzYNh4V4c/+zro53S2lo0vCLVtEtT7IOtjZhr1Mz0ZCp3xh7o5hHfJOmey0l02bImkNTwiNU4pnh90xvaQt2YHx79/1o4+jSTxHckYPfDfv/3dtNhvVfzLF2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753794778; c=relaxed/simple;
	bh=/cLNQ0aruB2Rxp4O04VU2hwDm4xTPNqgYIIU3JaaaIA=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=aLs4+SwLZtumL4wf7jjA54lC/rKw3cZBoT7ewphXYly2XFbg+o3vzZijCEbeuNjShb07rG3HtGbKw6D4ckwSfXDljuz816GF9s0CKdGKgzRLcnUz2xBGfWwQnDTn7oyfHXHoG7Pk3aswOMK4ur21lmtOW/jfpWX7KZ89avqX5/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cTFwhVQy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE81EC4CEF7;
	Tue, 29 Jul 2025 13:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753794778;
	bh=/cLNQ0aruB2Rxp4O04VU2hwDm4xTPNqgYIIU3JaaaIA=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=cTFwhVQycc0dYmbyDF/wdmnagj3VL6y0jhemgGz3uKAH68LQHal1ac64muYtz9LoJ
	 OvWLl+YOHmGkKQ4LmagQAvvAZBOdlFeaN7qfXMTM6Kg2WMhhYeVSVdIpR+Iu/0oWE5
	 /xSpdDV/f+/+ut8caPKRNQEqz5VmPajHDj5J47R4POHckdWGoriDymu/3A4r9JGXal
	 58N5myqutBHvpifnR7yyS6RR1Pn/YXgfXbheumsIbMInK5WJt1Z67vVWN6l0D8pT/f
	 r7wf8Od9lCdn+TJzeekARfCAWhmz0CG69F3VHkrH1S2BXssGx9hSkMk53kxMbbo1Ne
	 RKy8JLQFN5KZw==
Date: Tue, 29 Jul 2025 08:12:57 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Jason Kridner <jkridner@beagleboard.org>, luca.ceresoli@bootlin.com, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-kernel@vger.kernel.org, 
 conor+dt@kernel.org, Mark Brown <broonie@kernel.org>, 
 Deepak Khatri <lorforlinux@beagleboard.org>, Andrew Davis <afd@ti.com>, 
 Dhruva Gole <d-gole@ti.com>, linux-spi@vger.kernel.org, 
 herve.codina@bootlin.com, devicetree@vger.kernel.org, 
 Robert Nelson <robertcnelson@beagleboard.org>
To: Ayush Singh <ayush@beagleboard.org>
In-Reply-To: <20250729-spi-bus-extension-v1-4-b20c73f2161a@beagleboard.org>
References: <20250729-spi-bus-extension-v1-0-b20c73f2161a@beagleboard.org>
 <20250729-spi-bus-extension-v1-4-b20c73f2161a@beagleboard.org>
Message-Id: <175379477596.388256.1787674509168915234.robh@kernel.org>
Subject: Re: [PATCH 4/4] devicetree: bindings: spi: Introduce SPI bus
 extensions


On Tue, 29 Jul 2025 15:21:03 +0530, Ayush Singh wrote:
> An SPI bus can be wired to the connector and allows an add-on board to
> connect additional SPI devices to this bus.
> 
> Those additional SPI devices could be described as sub-nodes of the SPI
> bus controller node however for hotplug connectors described via device
> tree overlays there is additional level of indirection, which is needed
> to decouple the overlay and the base tree:
> 
>   --- base device tree ---
> 
>   spi1: spi@abcd0000 {
>       compatible = "xyz,foo";
>       spi-bus-extension@0 {
>           spi-bus = <&spi_ctrl>;
>       };
>       ...
>   };
> 
>   spi5: spi@cafe0000 {
>       compatible = "xyz,bar";
>       spi-bus-extension@0 {
>           spi-bus = <&spi_sensors>;
>       };
>       ...
>   };
> 
>   connector {
>       spi_ctrl: spi-ctrl {
>           spi-parent = <&spi1>;
>           #address-cells = <1>;
>           #size-cells = <0>;
>       };
> 
>       spi_sensors: spi-sensors {
>           spi-parent = <&spi5>;
>           #address-cells = <1>;
>           #size-cells = <0>;
>       };
>   };
> 
>   --- device tree overlay ---
> 
>   ...
>   // This node will overlay on the spi-ctrl node of the base tree
>   spi-ctrl {
>       eeprom@50 { compatible = "atmel,24c64"; ... };
>   };
>   ...
> 
>   --- resulting device tree ---
> 
>   spi1: spi@abcd0000 {
>       compatible = "xyz,foo";
>       spi-bus-extension@0 {
>           spi-bus = <&spi_ctrl>;
>       };
>       ...
>   };
> 
>   spi5: spi@cafe0000 {
>       compatible = "xyz,bar";
>       spi-bus-extension@0 {
>           spi-bus = <&spi_sensors>;
>       };
>       ...
>   };
> 
>   connector {
>       spi_ctrl: spi-ctrl {
>           spi-parent = <&spi1>;
>           #address-cells = <1>;
>           #size-cells = <0>;
> 
>           device@1 { compatible = "xyz,foo"; ... };
>       };
> 
>       spi_sensors: spi-sensors {
>           spi-parent = <&spi5>;
>           #address-cells = <1>;
>           #size-cells = <0>;
>       };
>   };
> 
> Here spi-ctrl (same goes for spi-sensors) represent the part of SPI bus
> that is on the hot-pluggable add-on. On hot-plugging it will physically
> connect to the SPI adapter on the base board. Let's call the 'spi-ctrl'
> node an "extension node".
> 
> In order to decouple the overlay from the base tree, the SPI adapter
> (spi@abcd0000) and the extension node (spi-ctrl) are separate nodes.
> 
> The extension node is linked to the SPI bus controller in two ways. The
> first one with the spi-bus-extension available in SPI controller
> sub-node and the second one with the spi-parent property available in
> the extension node itself.
> 
> The purpose of those two links is to provide the link in both direction
> from the SPI controller to the SPI extension and from the SPI extension
> to the SPI controller.
> 
> Signed-off-by: Ayush Singh <ayush@beagleboard.org>
> ---
>  .../devicetree/bindings/spi/spi-controller.yaml    | 66 +++++++++++++++++++++-
>  1 file changed, 65 insertions(+), 1 deletion(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/spi/spi-controller.example.dtb: spi@abcd0000 (brcm,bcm2835-spi): 'oneOf' conditional failed, one must be fixed:
	'interrupts' is a required property
	'interrupts-extended' is a required property
	from schema $id: http://devicetree.org/schemas/spi/brcm,bcm2835-spi.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/spi/spi-controller.example.dtb: spi@abcd0000 (brcm,bcm2835-spi): 'clocks' is a required property
	from schema $id: http://devicetree.org/schemas/spi/brcm,bcm2835-spi.yaml#
Documentation/devicetree/bindings/spi/spi-controller.example.dtb: /example-2/connector/spi-addon/device@2: failed to match any schema with compatible: ['xyz,foo']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250729-spi-bus-extension-v1-4-b20c73f2161a@beagleboard.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


