Return-Path: <linux-spi+bounces-5625-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D79919BC832
	for <lists+linux-spi@lfdr.de>; Tue,  5 Nov 2024 09:42:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 148041C220DC
	for <lists+linux-spi@lfdr.de>; Tue,  5 Nov 2024 08:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE1CC1C7608;
	Tue,  5 Nov 2024 08:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="lYgRInHZ"
X-Original-To: linux-spi@vger.kernel.org
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1961CFED4
	for <linux-spi@vger.kernel.org>; Tue,  5 Nov 2024 08:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730796119; cv=none; b=e760+kOF1hWwY9O7MJzhcQw1a4H7duFzvICE0vy4HeP4k9aIqBMptKWokkClBUdnGHK63iHBBr7YBzB/8AABRM1HtMArrTABBfs8VyEnpz5RnVTfvOO/oofAIkZTWxIcAHWy60vCW1wYtN/6Nr00bpskxwrs422m+qwUI4t72Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730796119; c=relaxed/simple;
	bh=PghXW7gaZF1lHy96HgwX9n9i2uXrKk+8Si62faTbS18=;
	h=Date:Message-Id:From:To:Cc:In-Reply-To:Subject:References; b=bOGvSJh9vlgls2zB2bk0KsGVjWr9C+3XVOP7pc60SKBBSr+z5SqSV53rFdYFUvqSfSllBtMej0fe2cBZyuXZ/+M0Ub80IutpNK1W690EmL56G60GO3YhtK3LuIavpvplAjiFnbTZ9B+DCgebUVBltvCCuAZx/cDOSkJ+v2S00MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=lYgRInHZ; arc=none smtp.client-ip=195.121.94.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
X-KPN-MessageId: cbd3c289-9b51-11ef-8d51-005056999439
Received: from smtp.kpnmail.nl (unknown [10.31.155.5])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id cbd3c289-9b51-11ef-8d51-005056999439;
	Tue, 05 Nov 2024 09:41:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=subject:to:from:message-id:date;
	bh=jefnxVo5g2H0Su9GziWcx7xJMa463Zc+Yp3+Yh3BVHg=;
	b=lYgRInHZEGEGH/dOZfkoaC8/iZWU5AkH6VZn0Alk60Z7+RyVneblrEOPFdUR7WL4sVA518nO5q+Q/
	 j8FO6vztuP1v3Q8BHY8VIY1JRqlyLJOqI/+EUFfvMXLOA7AzUfvvKPD0piD+1lHtE/nUArRLOa5bDW
	 2/fGR02W9ejHFdMvvXUHE6PBsmW/BtMUB1mWeBVOegRgIBtxqXHg920URl5oUzrIg3AnliULfxbsiB
	 6yRxu6JC8aVflWKzkebX+egmQeogHSS6ol45qgsRZ1lSxd9UgtG8oFiglt+54POChTFGLZD/3Sgwhr
	 9F7J0MYHzEYaCS9lV1tWPVKR9z0fe+w==
X-KPN-MID: 33|DvtP+JdYvzSblrsg267cZse9/LQIrxsjK7xbTQSHViMueZiHcwJ9JP7t5Z0peDU
 eiukTx7x+7l/cI5g28XYgCXH+5MSPTXWzfQRdkH7uEL4=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|JvOqZX1LaV8o6V89k1e3f0Nll+2+Ct0klrl86zRy/XeEYFMeTkVlUzc6ubdJbXB
 HBTFMVcQRcXCMRT/CynX8wA==
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net [80.61.163.207])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id cbfa2edc-9b51-11ef-b66d-00505699b758;
	Tue, 05 Nov 2024 09:41:49 +0100 (CET)
Date: Tue, 05 Nov 2024 09:41:48 +0100
Message-Id: <87a5ee3wdv.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: j@jannau.net
Cc: marcan@marcan.st, sven@svenpeter.dev, alyssa@rosenzweig.io,
	broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, j@jannau.net,
	towinchenmi@gmail.com, conor.dooley@microchip.com
In-Reply-To: <20241105-asahi-spi-v4-1-d9734f089fc9@jannau.net> (message from
	Janne Grunau via B4 Relay on Tue, 05 Nov 2024 09:08:29 +0100)
Subject: Re: [PATCH v4 1/3] dt-bindings: spi: apple,spi: Add binding for Apple
 SPI controllers
References: <20241105-asahi-spi-v4-0-d9734f089fc9@jannau.net> <20241105-asahi-spi-v4-1-d9734f089fc9@jannau.net>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

> From: Janne Grunau via B4 Relay <devnull+j.jannau.net@kernel.org>
> Date: Tue, 05 Nov 2024 09:08:29 +0100
> 
> From: Hector Martin <marcan@marcan.st>
> 
> The Apple SPI controller is present in SoCs such as the M1 (t8103) and
> M1 Pro/Max (t600x). This controller uses one IRQ and one clock, and
> doesn't need any special properties, so the binding is trivial.

Matches what is currently in use for U-Boot and OpenBSD.

> Signed-off-by: Hector Martin <marcan@marcan.st>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Acked-by: Nick Chan <towinchenmi@gmail.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Janne Grunau <j@jannau.net>

Reviewed-by: Mark Kettenis <kettenis@openbsd.org>

> ---
>  .../devicetree/bindings/spi/apple,spi.yaml         | 62 ++++++++++++++++++++++
>  1 file changed, 62 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/apple,spi.yaml b/Documentation/devicetree/bindings/spi/apple,spi.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..7bef605a296353a62252282af4ba45a71b20b7b6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/apple,spi.yaml
> @@ -0,0 +1,62 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spi/apple,spi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Apple ARM SoC SPI controller
> +
> +allOf:
> +  - $ref: spi-controller.yaml#
> +
> +maintainers:
> +  - Hector Martin <marcan@marcan.st>
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - apple,t8103-spi
> +          - apple,t8112-spi
> +          - apple,t6000-spi
> +      - const: apple,spi
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  power-domains:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - interrupts
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/apple-aic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    soc {
> +      #address-cells = <2>;
> +      #size-cells = <2>;
> +
> +      spi@39b104000 {
> +        compatible = "apple,t6000-spi", "apple,spi";
> +        reg = <0x3 0x9b104000 0x0 0x4000>;
> +        interrupt-parent = <&aic>;
> +        interrupts = <AIC_IRQ 0 1107 IRQ_TYPE_LEVEL_HIGH>;
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        clocks = <&clk>;
> +      };
> +    };
> 
> -- 
> 2.47.0
> 
> 
> 
> 

