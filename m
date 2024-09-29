Return-Path: <linux-spi+bounces-5036-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB4E98972F
	for <lists+linux-spi@lfdr.de>; Sun, 29 Sep 2024 21:54:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 612F71F216C0
	for <lists+linux-spi@lfdr.de>; Sun, 29 Sep 2024 19:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F6976026;
	Sun, 29 Sep 2024 19:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OYJ6SyB3"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FEE8F6D;
	Sun, 29 Sep 2024 19:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727639667; cv=none; b=N8HanQROS1c3YJY68wxLDqjnJc5mfM+WgKFz/v6NZa9euWWHrvEJ1SA1QXi72ufw0IWLFz9ZtuSu0DNOZ9ytM+BfGq7M4WlJr7azhyCfxZVB5MnomT6aS0B75tZtojHxTXnN9TIBTRrLkgsBHxWmsnQOCGwJxulXQxhUUCx0BpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727639667; c=relaxed/simple;
	bh=3ec6TBaIrguuCGne5BwNNYsxTdVA0VDsTr4JFGHXQN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F5IBC8zm4b3qLaYfdq3vWlN/JfIC/PKEC8YysChEf15gBM882dOJA7TAESrUbg9LXI1/31pAOPJrs5R6Q+BUDPvyRUxPf1uYM5ahkIa0Q+RVPeq3K6mNnGmIlSnQxwEU6QsFJ6dO9AYrWUjjJMOFrQYIHeF0VRM5B/Mi421tTtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OYJ6SyB3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0FE7C4CEC5;
	Sun, 29 Sep 2024 19:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727639666;
	bh=3ec6TBaIrguuCGne5BwNNYsxTdVA0VDsTr4JFGHXQN4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OYJ6SyB3FbBA+NMrI/0bnC9un38e3AceF0r4T/8no02WjKjqymImA8cNcH/wSbfRa
	 oaWOyNVWuWWu3lIPuBgk1+iCQHclKmixyz9RDQuyTCvciJHDx67eKnbZRHyJqGBeXx
	 AIfD+XRie4bnEx5lVCLvmGwDJv4wjqwJERArMdLo6V3XKEUsQSKyU4IgyB9ZmpPj2q
	 yIW8Wf3jVNBmsFtWIgoFzDiVk9Hxa3duKPypWs8U2umq8vqI17JRn0qEwnB9uFXsqm
	 WRkyHaiIag4kQvcV7IiA5mWqvQkiPjPgiB+l0/6Fn/VWi3Zci+M0Sisa//5W4eQsDZ
	 6P/aRpxI0yK1Q==
Date: Sun, 29 Sep 2024 21:54:23 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Karan Sanghavi <karansanghvi98@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org, 
	devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, linux-kernel@vger.kernel.org, 
	Shuah Khan <skhan@linuxfoundation.org>, Anup <anupnewsmail@gmail.com>
Subject: Re: [PATCH] dt-bindings: spi: Add bcm2835-aux-spi.yaml file.
Message-ID: <b4sbg7k5gz2uawunvjisphiut7xs3a3ark2t7ekze22eqrs6kr@hffol2q525fj>
References: <ZvkAPUoa96GHPnZE@Emma>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZvkAPUoa96GHPnZE@Emma>

On Sun, Sep 29, 2024 at 07:22:37AM +0000, Karan Sanghavi wrote:
> Converted the brcm,bcm2835-aux-spi.txt file to
> its respective yaml file format.
> 

Subject: You do not add new binding, you convert it. Also, drop final
full stop.

> Signed-off-by: Karan Sanghavi <karansanghvi98@gmail.com>
> ---


> diff --git a/Documentation/devicetree/bindings/spi/brcm,bcm2835-aux-spi.yaml b/Documentation/devicetree/bindings/spi/brcm,bcm2835-aux-spi.yaml
> new file mode 100644
> index 000000000000..4c24cf2fe214
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/brcm,bcm2835-aux-spi.yaml
> @@ -0,0 +1,66 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spi/brcm,bcm2835-aux-spi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Broadcom BCM2835 Auxiliary SPI1/2 Controller
> +
> +maintainers:
> +  - Karan Sanghavi <karansanghvi98@gmail.com>

This is fine, just to be clear: you have the hardware, datasheet or
some sort of interest in this hardware?

> +
> +description: |

Do not need '|' unless you need to preserve formatting.

> +  The BCM2835 contains two forms of SPI master controller. One is known simply as
> +  SPI0, and the other as the "Universal SPI Master," part of the auxiliary block.
> +  This binding applies to the SPI1 and SPI2 auxiliary controllers.
> +
> +allOf:
> +  - $ref: spi-controller.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - brcm,bcm2835-aux-spi
> +    description: Broadcom BCM2835 Auxiliary SPI controller for SPI1 and SPI2.

Drop description

> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: Reference to the auxiliary clock driver for the BCM2835.

Instead: maxItems: 1

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/bcm2835-aux.h>
> +    spi@7e215080 {
> +        compatible = "brcm,bcm2835-aux-spi";
> +        reg = <0x7e215080 0x40>;
> +        interrupts = <1 29>;
> +        clocks = <&aux_clocks BCM2835_AUX_CLOCK_SPI1>;
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +    };
> +
> +  - |

Only one example is enough, drop the rest because they are the same.

Best regards,
Krzysztof


