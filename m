Return-Path: <linux-spi+bounces-4821-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FAEE979DAE
	for <lists+linux-spi@lfdr.de>; Mon, 16 Sep 2024 11:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FCC61C22D5C
	for <lists+linux-spi@lfdr.de>; Mon, 16 Sep 2024 09:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E58149C7B;
	Mon, 16 Sep 2024 09:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VW4hPJzg"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E70313C8FF;
	Mon, 16 Sep 2024 09:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726477209; cv=none; b=JFQauylUROqC6iJfTk6Gb4o4NWxthyDqeQQM0guc9b8hPt6yFKzj+KtO5lGklcuhsBUJvff/lyktunHbI8miqE9l3Vi/nuzBTwGQYm/w2GcZdNtLdWjDzMZcY8TEQfxJ/kvPT4O/bLyBXQcgvr2uUCq5HhErNEFfVXXnl6qNpXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726477209; c=relaxed/simple;
	bh=GNsofsSf7ZYYz1CVXrbDIhqAR/5EB/FNbkOkGvaPK+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SNFThaekOz/wjQPbavSsSimDrdf4vh9sdlpV3DzHaGCRV6bA2imMPieiC39mj+aPculkKzTP77HvGDNJtm/Cm1f3lkdv7gDmssD2lrXxnYs+sXzceqVjTd6zlvCHw6tBQD7QEZW0hm2sK+gmIg8X3WPBLigKiznd5DUBR5uF7fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VW4hPJzg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A492BC4CEC4;
	Mon, 16 Sep 2024 09:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726477208;
	bh=GNsofsSf7ZYYz1CVXrbDIhqAR/5EB/FNbkOkGvaPK+Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VW4hPJzgy5+TkJbMw0CIa8YVX9Yx+DSpjrgKbhMMI+88PAJU9RNp+nYa+p2fgMaKZ
	 yuqZ5nqC5fbOOehaP5v8Vi4NwJrrYn0jdKL+4ypRmGU3tdfjP5u3hwZQgnFROQ7gv/
	 nGCp+Lo1+z8U5gVThwMcrNYEbn3IyavsOIETm9yxJiGn16uDRrAEP6I/miobCZ9a2a
	 kiDuMO1+vnEN67yHtPX5ipiu5hvZPl2XI2MRdVs5YWpCITcD3/Y90YXPGdw/rVx197
	 YgAzsWdbJLiBPYL5evn1NMi834uDtgRRZLozLCvyoI48mNexKMsX7jgYSvlaTaqLcU
	 aCHIM7CB4K3PQ==
Date: Mon, 16 Sep 2024 11:00:05 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Michael Hennerich <michael.hennerich@analog.com>, 
	Mark Brown <broonie@kernel.org>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: touchscreen: add ad7877 support
Message-ID: <mv6ybaysehpwegett4it26f2r63iucjjbzchujv3szryp2mcfu@liiwawl74h7x>
References: <20240913075307.154435-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240913075307.154435-1-antoniu.miclaus@analog.com>

On Fri, Sep 13, 2024 at 10:52:29AM +0300, Antoniu Miclaus wrote:
> Add device tree bindings for ad7877.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> changes in v4:
>  - add bindings patch first
>  - update commit title/body based on review.
>  - add units for pen-down-acc-interval property.
>  - add default value for adi,acquisition-time-us and adi,vref-delay-us property
>  .../input/touchscreen/adi,ad7877.yaml         | 106 ++++++++++++++++++
>  1 file changed, 106 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/adi,ad7877.yaml
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/adi,ad7877.yaml b/Documentation/devicetree/bindings/input/touchscreen/adi,ad7877.yaml
> new file mode 100644
> index 000000000000..c472f50f7a59
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/touchscreen/adi,ad7877.yaml
> @@ -0,0 +1,106 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/input/touchscreen/adi,ad7877.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices AD7877 Touch Screen Controller
> +
> +maintainers:
> +  - Antoniu Miclaus <antoniu.miclaus@analog.com>
> +
> +description: |
> +  Analog Devices Touch Screen Controller
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/AD7877.pdf
> +
> +allOf:
> +  - $ref: touchscreen.yaml#
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ad7877
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  spi-max-frequency:
> +    description: AD7877 SPI bus clock frequency.
> +    minimum: 10000
> +    maximum: 20000000
> +
> +  adi,stopacq-polarity:
> +    description: The polarity of the signal applied to the STOPACQ pin.
> +    $ref: /schemas/types.yaml#/definitions/string
> +    enum: [low, high]

Missing default.

> +
> +  adi,first-conv-delay-ns:
> +    description: Delay in ns before the first conversion.
> +    enum: [500, 128000, 1000000, 8000000]

Missing default.


Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof


