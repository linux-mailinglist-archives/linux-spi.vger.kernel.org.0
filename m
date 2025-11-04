Return-Path: <linux-spi+bounces-10989-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C29CC2FB40
	for <lists+linux-spi@lfdr.de>; Tue, 04 Nov 2025 08:43:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 038094271BA
	for <lists+linux-spi@lfdr.de>; Tue,  4 Nov 2025 07:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F054530BB9A;
	Tue,  4 Nov 2025 07:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IS7sfAzr"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16903016E4;
	Tue,  4 Nov 2025 07:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762241953; cv=none; b=jou1E9uE9ASDhaqLMULsTwHvRI3q7FglrUdU3enu84DiRP8o2g3obXqlu3AC+Q/dXvOoWOT/keEZYH5X3VUfqsakP3N81H5c11oMVEgXP/ofzzIdA19vdR7F83851XEIiDPdp4EgwUN3k/YBW2vzXZDJRXmVo4YhOXXDkv8KWgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762241953; c=relaxed/simple;
	bh=JjN+3oyB2ya3h2mPEiJDBcUI41kw139YD+poIXT/mws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AMTLu3RpFBNI0a4pVprsU7AT+vikC5F3ZvKjIJpgblg8pmaKL99xw86N3j+S5FPPZUy5fYC8GxW4aOVQA5ai/sjUaHlxPIAFKqobhz5ZHXKZbBvvgqe94G8Y/vnOgvgiBIA8hPM6zY0bll3ufQBMeHU8MoaUYr1lNu/KnA6j2fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IS7sfAzr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3448C4CEF7;
	Tue,  4 Nov 2025 07:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762241953;
	bh=JjN+3oyB2ya3h2mPEiJDBcUI41kw139YD+poIXT/mws=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IS7sfAzr22iaQDlTQcPkrAbJ7iSA3KOhhlDl4mdL9gClpjcYzG+mxB1NmV7gzynT5
	 0h1i5ACkaTw7cuHvhhixwz786B6nGr5MywI1zMb1QEZ04eipUtDjYGzOWbtUC+2sDg
	 B+CzUnvcFmdbqMRJtw6k9ggLjAsmkQPE2kDTDSqd+sp9iYKJwo37aHaM0R9uzCYKpJ
	 sD7tGA5Drm60q13JA1xwfl/cVhULpjwJ1R0DQb9sOq/h5EHheCaNjSLRBjCjJJe32E
	 jseK3R9REy3Fb2MJQLjS3sSlX+AE7hmhqi0QvYuWx5/j5KiRqhcw9gZowjbeQs/LL5
	 YrOLb4HsvCX7Q==
Date: Tue, 4 Nov 2025 08:39:10 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Haibo Chen <haibo.chen@nxp.com>
Cc: Han Xu <han.xu@nxp.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-spi@vger.kernel.org, imx@lists.linux.dev, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: spi: Document imx94 xspi
Message-ID: <20251104-cerise-muskrat-of-teaching-873ade@kuoka>
References: <20251104-xspi-v1-0-1502847ade40@nxp.com>
 <20251104-xspi-v1-1-1502847ade40@nxp.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251104-xspi-v1-1-1502847ade40@nxp.com>

On Tue, Nov 04, 2025 at 11:07:36AM +0800, Haibo Chen wrote:
> Document imx94 xspi that supports interface to serial flash
> supporting following features:
> 
> - Single-bit SPI, Dual SPI, Quad SPI and Octal SPI.
> - Single Data Rate or Double Data Rate modes.
> - Direct memory mapping of all AHB memory accesses to the
>   chip system memory space.
> - Multi-master AHB accesses with priority.
> 
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> ---
>  .../devicetree/bindings/spi/spi-nxp-xspi.yaml      | 84 ++++++++++++++++++++++
>  MAINTAINERS                                        |  8 +++
>  2 files changed, 92 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-nxp-xspi.yaml b/Documentation/devicetree/bindings/spi/spi-nxp-xspi.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..36970514036fe8e776908a15ed1ea2b21f2c4c9a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/spi-nxp-xspi.yaml

Filename matching exactly compatible (we asked this multiple times
already in other patchsets from NXP).

> @@ -0,0 +1,84 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spi/spi-nxp-xspi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP External Serial Peripheral Interface (xSPI)
> +
> +maintainers:
> +  - Haibo Chen <haibo.chen@nxp.com>
> +  - Han Xu <han.xu@nxp.com>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - enum:
> +          - nxp,imx94-xspi
> +
> +  reg:
> +    items:
> +      - description: registers address space
> +      - description: memory mapped address space
> +
> +  reg-names:
> +    items:
> +      - const: base
> +      - const: mmap
> +
> +  interrupts:
> +    maxItems: 5
> +
> +  clocks:
> +    items:
> +      - description: SPI serial clock
> +
> +  clock-names:
> +    items:
> +      - const: per
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - interrupts
> +  - clocks
> +  - clock-names
> +
> +allOf:
> +  - $ref: spi-controller.yaml#
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        spi@42b90000 {
> +            compatible = "nxp,imx943-xspi";

That's not what your schema said.

> +            reg = <0x42b90000 0x50000>, <0x28000000 0x08000000>;
> +            reg-names = "base", "mmap";
> +            interrupts = <GIC_SPI 390 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 391 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 392 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 393 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 394 IRQ_TYPE_LEVEL_HIGH>;
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +            clocks = <&scmi_1>;
> +            clock-names = "per";
> +
> +            flash@0 {
> +                compatible = "jedec,spi-nor";
> +                reg = <0>;
> +                spi-max-frequency = <200000000>;
> +                spi-rx-bus-width = <8>;
> +                spi-tx-bus-width = <8>;
> +            };
> +

Drop blank line

> +        };

Best regards,
Krzysztof


