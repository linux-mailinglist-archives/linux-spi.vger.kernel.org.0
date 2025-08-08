Return-Path: <linux-spi+bounces-9321-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6199DB1E407
	for <lists+linux-spi@lfdr.de>; Fri,  8 Aug 2025 10:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EA147A2238
	for <lists+linux-spi@lfdr.de>; Fri,  8 Aug 2025 08:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A223A2580CF;
	Fri,  8 Aug 2025 08:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K1+G4C0B"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758D74AEE2;
	Fri,  8 Aug 2025 08:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754640240; cv=none; b=NNsZYpNnUXTo0MqrvPH89FBw1DAP55yWPnCCv24FD2zOSRvA/Ltzri4nfElUEJTjI8Lfy4qSN7QBIr4FDSRg1SzfebzxFUs91O/UgPSydWwG8lqWBnT00oY+qD6aVNUzHDN7qh4GBGShfcKr9/7IVcHwYM/LwX9ceYaVwgNz73s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754640240; c=relaxed/simple;
	bh=ql/cRZYDLhA7jP9iJrRhFEoYs9X2U+gQifZ0qjY7Ur0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PxBOoPZG0pF6dUBoUZuJK89hiq8iBTKvKVt/TXeiL/DT+RDE3CHMYIR2Ivlgt13O8Nyvpm1xxc6xEsbH4/7dfQ8s4ToYNHSnUEJkdfW7B60j7FPmxoxhpf2xg+YhZpoAyNTMz0+x2VzXMEvjoxmbSOs+wm3JAcMYFBQ/BnFWSxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K1+G4C0B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56FC8C4CEED;
	Fri,  8 Aug 2025 08:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754640238;
	bh=ql/cRZYDLhA7jP9iJrRhFEoYs9X2U+gQifZ0qjY7Ur0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K1+G4C0Bb1s5IIBz4hMmY7bLy5UPqfEjDxSNVrmkak5juoah9iMdWFSNY/PszOCbi
	 hRTxS0iDXb+ppUFTDSAhyjD64YmgzizpvzI9s7lh00FMtM7xiNWy7wv8ecTbm1HyJK
	 PLpUxn/ZC/HQQCFxDQ4E/I/da+USOE6O3KZVw4ke+eT72Gzui3kC0hW5Ti1QWOVryv
	 LbynCAYBTqweN6WiMV6tQxV1rWZfuma8ouCzUpmq0/4HYlvNnZeU23sjpdcYM3ZtVv
	 758dy7z+KHq4m+WwQaH0irkFr20Z9SUUGLJdYGx99UDZJZk1sp9mrgkxfodYHd0ikd
	 Dz5s9q4HAM2nA==
Date: Fri, 8 Aug 2025 10:03:56 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Xianwei Zhao <xianwei.zhao@amlogic.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liang Yang <liang.yang@amlogic.com>, Feng Chen <feng.chen@amlogic.com>, linux-spi@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org
Subject: Re: [PATCH 1/3] spi: dt-bindings: add doc for Amlogic A113L2 SFC
Message-ID: <20250808-adamant-fat-raven-38c8b3@kuoka>
References: <20250808-spifc-v1-0-ff4e30e26a6b@amlogic.com>
 <20250808-spifc-v1-1-ff4e30e26a6b@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250808-spifc-v1-1-ff4e30e26a6b@amlogic.com>

On Fri, Aug 08, 2025 at 10:00:34AM +0800, Xianwei Zhao wrote:
> From: Feng Chen <feng.chen@amlogic.com>
> 
> The Flash Controller is derived by adding an SPI path to the original
> raw NAND controller. This controller supports two modes: raw mode and
> SPI mode. The raw mode has already been implemented in the community,
> and the SPI mode is described here.
> 

Subject: drop doc, so just "Add Amlogic foo ..."

> Add bindings for Amlogic A113L2 SPI Flash Controller.
> 
> Signed-off-by: Feng Chen <feng.chen@amlogic.com>
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
> ---
>  .../devicetree/bindings/spi/amlogic,a4-spifc.yaml  | 104 +++++++++++++++++++++
>  1 file changed, 104 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/amlogic,a4-spifc.yaml b/Documentation/devicetree/bindings/spi/amlogic,a4-spifc.yaml
> new file mode 100644
> index 000000000000..712a17a4b117
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/amlogic,a4-spifc.yaml
> @@ -0,0 +1,104 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) 2025 Amlogic, Inc. All rights reserved
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spi/amlogic,a4-spifc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: SPI flash controller for Amlogic ARM SoCs
> +
> +maintainers:
> +  - Liang Yang <liang.yang@amlogic.com>
> +  - Feng Chen <feng.chen@amlogic.com>
> +  - Xianwei Zhao <xianwei.zhao@amlogic.com>
> +
> +description:
> +  The Amlogic SPI flash controller is an extended version
> +  of the Amlogic NAND flash controller. It supports SPI Nor
> +  Flash and SPI NAND Flash(where the Host ECC HW engine could
> +  be enabled).

Wrap at coding style, 80.

> +
> +allOf:
> +  - $ref: /schemas/spi/spi-controller.yaml#
> +
> +properties:
> +  compatible:
> +    const: amlogic,a4-spifc
> +
> +  reg:
> +    items:
> +      - description: core registers
> +      - description: parent clk control registers

Why are you poking to parent node or to clock registers? This looks like
mixing up device address spaces.

> +
> +  reg-names:
> +    items:
> +      - const: core
> +      - const: pclk
> +
> +  clocks:
> +    items:
> +      - description: clock gate

Are you sure this is separate clock input to this device?

> +      - description: clock used for the controller
> +      - description: clock used for the SPI bus
> +
> +  clock-names:
> +    items:
> +      - const: gate
> +      - const: core
> +      - const: device
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  amlogic,sfc-enable-random:
> +    description: Enable data scrambling

Why would this be a property of the board?

> +    type: boolean
> +
> +  amlogic,sfc-no-hwecc:
> +    description: Disable ECC HW engine

Same question, why not having ECC always?

> +    type: boolean
> +
> +  amlogic,rx-adj:
> +    description:
> +      Adjust sample timing for RX, Sampling time
> +      move later by 1 bus clock.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 1, 2, 3]
> +    default: 0
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - clocks
> +  - clock-names
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    sfc0: spi@fe08d000 {
> +      compatible = "amlogic,a4-spifc";
> +      reg = <0xfe08d000 0x800>, <0xfe08c000 0x4>;

One register for the parent clock? This really does not look like part
of this device.

Best regards,
Krzysztof


