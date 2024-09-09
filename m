Return-Path: <linux-spi+bounces-4738-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB0009714ED
	for <lists+linux-spi@lfdr.de>; Mon,  9 Sep 2024 12:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1F061C22D30
	for <lists+linux-spi@lfdr.de>; Mon,  9 Sep 2024 10:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903A51B5812;
	Mon,  9 Sep 2024 10:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="edIXb8fK"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602081B5806;
	Mon,  9 Sep 2024 10:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725876560; cv=none; b=BWYavX7OT9nxQ5cP0nUYQSd29KNO0S88+2Oh/2pkr+K+1IP2mnbUQwtAAeGDzMMygs2iCvdVjhKpt3MPk5ThahLdvBVgsowb7gB0FUATcyjdyIE9S2pZe/wNuEQ9kv6L6ksjod5tQvgq20zxOervlPFDW0g0lQ6GPzRA1OrJV+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725876560; c=relaxed/simple;
	bh=gFeTiDQ9+Il5wiQQ5+M78yiF1Ma+uzxGI3sPKytmhnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M/BvNcloSk+6RZFdfKJ4aHz42L+cKcipVaKEi1OKihaRD4EDgy56ZUq3UHav2qb7MiTybNF5qXbp8IcqQmjtGVte0utHOKq7WlNC3oVwxV/xedg9T82XE0nykP0DEnig42n0zMBbcjlO7cwLDOMG4K4MuXrENImwBb3kqtDhjKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=edIXb8fK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC769C4CECD;
	Mon,  9 Sep 2024 10:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725876559;
	bh=gFeTiDQ9+Il5wiQQ5+M78yiF1Ma+uzxGI3sPKytmhnw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=edIXb8fKt6WGE8QLkL2kSq/0HSCdJjK1cd2bB/d9UDO/pv3xyCeiFkRQPmAQTmmYG
	 pz9XQTO7Ubb3G+pwE6LYOE4Tkp0H0U0uVRICNtxT+PuTHUjNM5Ah/ez9mDfP+u9z9f
	 qGu0JlkHBzGyA828f1hMzehrKFJWuFDxhyCw5JhbEFfYfQZk3dqlGxG62vBBrxx9Ic
	 hDdJlK6dZ08MH1Mqfgt7AGQLuT+fuU2rAebDSrHXTsifrbmvxTNzmgUZkOW3mTK8ZW
	 TypziDrjD+qfDyR4xH+mf7FKYsbUMc1iKOJcmk1IGeVUJq6i3DPnkF5UzotC1ivny/
	 Y2+8eUQFsVX8Q==
Date: Mon, 9 Sep 2024 12:09:15 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Michael Hennerich <michael.hennerich@analog.com>, 
	Mark Brown <broonie@kernel.org>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH v3 3/3] dt-bindings: touchscreen: ad7877: add bindings
Message-ID: <psqb6aw23xdslobrzy5rbjyr67spccc2txbk3pajdlucys6kss@tvh234zhwlz3>
References: <20240909093101.14113-1-antoniu.miclaus@analog.com>
 <20240909093101.14113-3-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240909093101.14113-3-antoniu.miclaus@analog.com>

On Mon, Sep 09, 2024 at 12:30:13PM +0300, Antoniu Miclaus wrote:
> Add device tree bindings for the ad7877 driver.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> changes in v3:
>  - use strings for polarity.
>  - use unit siffix where applies.
>  - add defaults where applies.
>  - add complete example.
>  .../input/touchscreen/adi,ad7877.yaml         | 109 ++++++++++++++++++
>  1 file changed, 109 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/adi,ad7877.yaml
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/adi,ad7877.yaml b/Documentation/devicetree/bindings/input/touchscreen/adi,ad7877.yaml
> new file mode 100644
> index 000000000000..7603ce63af7e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/touchscreen/adi,ad7877.yaml
> @@ -0,0 +1,109 @@
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
> +
> +  adi,first-conv-delay-ns:
> +    description: Delay in ns before the first conversion.
> +    enum: [500, 128000, 1000000, 8000000]
> +
> +  adi,pen-down-acc-interval:
> +    description: Enable the ADC to repeatedly perform conversions.
> +                  0 = convert once
> +                  1 = every 0.5 ms
> +                  2 = every 1 ms
> +                  3 = every 8 ms
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 1, 2, 3]
> +    default: 0

You got the comment about using units, right? It applied *everywhere*.
This is clearly a property in ms.

> +
> +  adi,acquisition-time-us:
> +    description: Select acquisition times in us for the ADC.
> +    enum: [2, 4, 8, 16]

What is the default? The property is not reuired, so how does it work
without it?

> +
> +  adi,vref-delay-us:
> +    description: Delay required for the SPI transfers depending on the VREF used.

Same question.

Best regards,
Krzysztof


