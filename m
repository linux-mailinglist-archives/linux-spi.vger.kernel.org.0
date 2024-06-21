Return-Path: <linux-spi+bounces-3526-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DEF19125E2
	for <lists+linux-spi@lfdr.de>; Fri, 21 Jun 2024 14:49:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 983C41C2177D
	for <lists+linux-spi@lfdr.de>; Fri, 21 Jun 2024 12:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E82D6156223;
	Fri, 21 Jun 2024 12:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RpVHj/kx"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED9E1553A4;
	Fri, 21 Jun 2024 12:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718973738; cv=none; b=I3xOoKfnuSFPaiA7IfRp3Dq983tCx8uD0omydQu8YI9cPENxL+dx/03ng1Mfka69E3xyzW5XVvhN8CZIFzp2a6/cU2LRvE7rNnjL5p+ssm/ECyxzV2sFwbzcxqYu1VUB2IwakmVA22boyYd76BxKtiyYS/k7KhgfFXBOY9MDTd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718973738; c=relaxed/simple;
	bh=o0Zz1fevuySLS+ArAprXIPomY4FCfyicPzisqwGrjU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rRp5LHyrSUwPZtRfRY3vhqrzkHxJfmqoMQCU6DgvtA2R41bCAsjUNX/iVF+HzKBvPFBxPhO+iBY5vFqulWCbDjlBXg3JdZYSWUHlfTlmDWc4bfOegvjX4BRgSNA6eWVTJulBosjVRi8FOI/OL6ioSOx5Iaj86vvyFxYefPZZzm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RpVHj/kx; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-57cbc66a0a6so132243a12.1;
        Fri, 21 Jun 2024 05:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718973735; x=1719578535; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oi0LcVAmr1WeeM46g7NJXJsrRLdwaPetNc18z6AYroU=;
        b=RpVHj/kxr9RFxB30to1gMh7OG2Du7W5YbaibGzjb5wL3N7Kaao7xEYDHqqvSalLz8J
         MjZMHHxJhvws7BMD8XLD081NZgd9E4MFdSTgK3iNQ7MVlIXkZOzjXtn+zU0aerMX0CfR
         9s/trckupMaNiN61higIn6W4IQ4dU2TRxLZ+dSzHr9FyEt88YTn6yecdWWF3c4BiDpOl
         8NmAMedjsLp2dHey9HHEPD7EZBhgzXfnExEKKcoa3bPp9Jxp910iwtkgZ8tfUMdsur54
         BpqM5MR12KQC2yktCQjUG9qaUqY9R5oW796xKE/zqilR3UFbQU5UeYtxYAdb1Yq2+eZX
         h8pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718973735; x=1719578535;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oi0LcVAmr1WeeM46g7NJXJsrRLdwaPetNc18z6AYroU=;
        b=aUGGwKCmjpZVUnNcDJM8Niqo3NnKngB2MAZUllp4+g3cXOcm/nEbKxcYF+DMVp7YJM
         yxQQUYaQqrUyUGU2JlK5aqiS8zEbs+KjXBQf6zuLfFDqPoaqh2r42Knk/NaxH7yU6X2/
         v9YppLsFy3Nis4pO5N4aPM+Ia27JnJQQIbZpiNWoPHAWyv6MZSb3DzfTCZItbMwtNIWm
         gu4LXogN0icmCEuWKKqOpdbHcPTXf/iznJrRU7qgY+YPYqGjihEqJ2C3pJlMZ6T5zIOD
         K5/6kj0SGcnjmMSS0o9xfZN8StEIKEfwh5iGZNrVxbwp7jL+KPUPIaO3Dm5meBTqx+JJ
         vRmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEOFju4lUWHpAZdi74A/+Z7PpyAjJA67MK2FKTIfUBiViw9TxLepuBmExyhLElrPDcyVhEDJGLcLjAXA3hJMz1Iv5db6fV95vGbDqJUdKIxJwZhOyzlruPRHvensxynovUKGNTE9k2lufHSNZbCtmng30TtAM2L3m67j5PnfuqfxURgw==
X-Gm-Message-State: AOJu0YxxmvmKQSQj5CIoek2Qn5jt42ff9D45WquwS6Au1EuGI5TJcmqA
	LlHoXu8m1f7tTTMp4s9lhif0AWU/6UTaeLxMW8VRZK55QOuQmkmTmzE9R3Nb
X-Google-Smtp-Source: AGHT+IHREP6VjuCYeod3fdem5l5ceB2HMxw0B8mnfswHnwlQuq+6rPxhUfpLpntKlXu1IPn/nuphXA==
X-Received: by 2002:a50:aa9b:0:b0:57c:c171:2fb6 with SMTP id 4fb4d7f45d1cf-57d069c3a10mr6199253a12.1.1718973734850;
        Fri, 21 Jun 2024 05:42:14 -0700 (PDT)
Received: from skbuf ([188.25.55.166])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57d3048ba0dsm920306a12.54.2024.06.21.05.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 05:42:14 -0700 (PDT)
Date: Fri, 21 Jun 2024 15:42:11 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Frank Li <Frank.Li@nxp.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev
Subject: Re: [PATCH v3 2/3] spi: dt-bindings: fsl-dspi: Convert to yaml format
Message-ID: <20240621124211.pueymngpq5luokvj@skbuf>
References: <20240620-ls_qspi-v3-0-1a2afcf417e4@nxp.com>
 <20240620-ls_qspi-v3-2-1a2afcf417e4@nxp.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240620-ls_qspi-v3-2-1a2afcf417e4@nxp.com>

On Thu, Jun 20, 2024 at 12:58:28PM -0400, Frank Li wrote:
> Convert dt-binding spi-fsl-dspi.txt to yaml format.
> 
> Addtional changes during convert:
> - compatible string "fsl,ls1028a-dspi" can be followed by
> fsl,ls1021a-v1.0-dspi.
> - Change "dspi0@4002c000" to "spi@4002c000" in example.
> - Reorder properties in example.
> - Use GIC include in example.
> - Remove fsl,spi-cs-sck-delay and fsl,spi-sck-cs-delay by use common SPI
> property.
> - Use compatible string 'jedec,spi-nor' in example.
> - Split peripheral part to fsl,spi-dspi-peripheral-props.yaml
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> 
> ---
> Use part of Vladimir Oltean's work at
> https://lore.kernel.org/linux-spi/20221111224651.577729-1-vladimir.oltean@nxp.com/

Hm, you took part of that but gave no attribution? The portion below ---
is also discarded when the patch is applied, so even the link is lost,
FYI.

> ---
>  .../devicetree/bindings/spi/fsl,dspi.yaml          | 115 +++++++++++++++++++++
>  .../spi/fsl,spi-dspi-peripheral-props.yaml         |  28 +++++

For consistency, could you name this fsl,dspi-peripheral-props.yaml?

>  .../devicetree/bindings/spi/spi-fsl-dspi.txt       |  65 ------------
>  .../bindings/spi/spi-peripheral-props.yaml         |   1 +

No MAINTAINERS change for the schema path? There was a discussion with
Krzysztof in the old thread.

>  4 files changed, 144 insertions(+), 65 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/spi/fsl,dspi.yaml b/Documentation/devicetree/bindings/spi/fsl,dspi.yaml
> new file mode 100644
> index 0000000000000..924ba19aea017
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/fsl,dspi.yaml
> @@ -0,0 +1,115 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spi/fsl,dspi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ARM Freescale DSPI controller
> +
> +maintainers:
> +  - Frank Li <Frank.Li@nxp.com>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - enum:
> +          - fsl,vf610-dspi
> +          - fsl,ls1021a-v1.0-dspi
> +          - fsl,ls1012a-dspi
> +          - fsl,ls1028a-dspi
> +          - fsl,ls1043a-dspi
> +          - fsl,ls1046a-dspi
> +          - fsl,ls1088a-dspi
> +          - fsl,ls2080a-dspi
> +          - fsl,ls2085a-dspi
> +          - fsl,lx2160a-dspi
> +      - items:
> +          - enum:
> +              - fsl,ls1012a-dspi
> +              - fsl,ls1028a-dspi
> +              - fsl,ls1043a-dspi
> +              - fsl,ls1046a-dspi
> +              - fsl,ls1088a-dspi
> +          - const: fsl,ls1021a-v1.0-dspi
> +      - items:
> +          - const: fsl,ls2080a-dspi
> +          - const: fsl,ls2085a-dspi
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    items:
> +      - const: dspi
> +
> +  pinctrl-0: true
> +
> +  pinctrl-names:
> +    items:
> +      - const: default

I don't think that pinctrl properties need to be specified in the
schema. Somehow, I think dt-schema applies
dtschema/schemas/pinctrl/pinctrl-consumer.yaml by default every time.

> +
> +  spi-num-chipselects:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: the number of the chipselect signals.

Worth mentioning that this is about _native_ chip select signals.
cs-gpios don't count against this number.

> +
> +  big-endian:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      If present the dspi device's registers are implemented
> +      in big endian mode.

I'm not sure that this needs an explanation, it is an absolutely generic
property with a universal meaning.

> +
> +  bus-num:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: the slave chip chipselect signal number.

In fact, no, this is not a chip select number, the old documentation is
wrong. It just gets assigned to the struct spi_controller :: bus_num.
In my last submitted version I wrote "SoC-specific identifier for the
SPI controller", that seems perfectly adequate.

> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - interrupts
> +  - pinctrl-0
> +  - pinctrl-names

interrupts and pinctrl are not required.

> +  - spi-num-chipselects
> +
> +allOf:
> +  - $ref: spi-controller.yaml#
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/vf610-clock.h>
> +
> +    spi@4002c000 {
> +        compatible = "fsl,vf610-dspi";
> +        reg = <0x4002c000 0x1000>;
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
> +        clocks = <&clks VF610_CLK_DSPI0>;
> +        clock-names = "dspi";
> +        spi-num-chipselects = <5>;
> +        bus-num = <0>;
> +        pinctrl-names = "default";
> +        pinctrl-0 = <&pinctrl_dspi0_1>;
> +        big-endian;
> +
> +        flash@0 {
> +                compatible = "jedec,spi-nor";
> +                reg = <0>;
> +                spi-max-frequency = <16000000>;
> +                spi-cpol;
> +                spi-cpha;
> +                spi-cs-setup-delay-ns = <100>;
> +                spi-cs-hold-delay-ns = <50>;
> +        };
> +    };
> +

Please remove newline at end of file.

