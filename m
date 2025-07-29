Return-Path: <linux-spi+bounces-9207-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04906B14DE6
	for <lists+linux-spi@lfdr.de>; Tue, 29 Jul 2025 14:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2915018A2133
	for <lists+linux-spi@lfdr.de>; Tue, 29 Jul 2025 12:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C658228DD0;
	Tue, 29 Jul 2025 12:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gtFFDWxJ"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F42E2576F;
	Tue, 29 Jul 2025 12:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753793526; cv=none; b=I+KiBX5Ta+Two3o2GiWvi0h1hfkTNGBYjFbiC7ZMJ72y/hCGJTQ/JyiDndjM1TAWYRXvo+OGrOMfuN2nHpvCTgB4EFtXuv+nL4AkwZUPqnb2Cj5BFt7zsZvs/dUkLi6/Sk2UURLNGjc+LwP5J/Tc4uv1GO6MlBfm/6gO4EzvO0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753793526; c=relaxed/simple;
	bh=RWIZovRIjbZNgbY2C4hT+YfeIvszzA1QaDk7v7JoZZI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dCv30rgKz5970FBPSg/oC21P6CuwLjzaj+B7PYJHAiaMAjS0ZMKtS5+dAzk9tIgy9bhBBuFNNifCrwCr/feHUmUc2PeuRT2Bz/3veII+x9jzAR/GI2rdcFCu6c6vnqs8h4PHxW1DGTSdV89SA7sBYbumIZJLrirBaxgCN7D7bSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gtFFDWxJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9406DC4CEF4;
	Tue, 29 Jul 2025 12:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753793526;
	bh=RWIZovRIjbZNgbY2C4hT+YfeIvszzA1QaDk7v7JoZZI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gtFFDWxJQIyiuM3mhrIYM85HOZCJ4E18I7huWpl0NAhWdBPtOm6by5LVlApHGh8+V
	 nRI9BeFlS+3qTOk+mQYdBqc+oUqw/Pjx8pa1N+bXZ6dpFDyldmgA45LlIYKZ7VZVol
	 Z1MCpSDQBm6ss8H84jXNjHUrSuiO0XLVZh8K/IfOJGGwuAPU2XxrVsiMEsiAAsAAq6
	 IN4l2wI5nNw8LL1wYrVXc/2xl+OIKoZd5cRrK4fQ8bcD3iqcVb6YzEtUATRb7zbbkl
	 zW2LIa0PqKixyrVPzQjvgkazt+3o2jiEvcpx7SBugLNve6OeF1Hxke0Tz/1839vv/t
	 +NpZQTYNp1vdA==
Message-ID: <c65d26d0-51b8-4131-a755-6c72b7dea549@kernel.org>
Date: Tue, 29 Jul 2025 14:52:00 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] devicetree: bindings: spi: Introduce SPI bus
 extensions
To: Ayush Singh <ayush@beagleboard.org>, Mark Brown <broonie@kernel.org>,
 herve.codina@bootlin.com, luca.ceresoli@bootlin.com, conor+dt@kernel.org,
 Jason Kridner <jkridner@beagleboard.org>,
 Deepak Khatri <lorforlinux@beagleboard.org>, Dhruva Gole <d-gole@ti.com>,
 Robert Nelson <robertcnelson@beagleboard.org>, Andrew Davis <afd@ti.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20250729-spi-bus-extension-v1-0-b20c73f2161a@beagleboard.org>
 <20250729-spi-bus-extension-v1-4-b20c73f2161a@beagleboard.org>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20250729-spi-bus-extension-v1-4-b20c73f2161a@beagleboard.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/07/2025 11:51, Ayush Singh wrote:
> An SPI bus can be wired to the connector and allows an add-on board to
> connect additional SPI devices to this bus.
> 

... so I found the binding. Not marked by my filters due to non-standard
subject.

Please use subject prefixes matching the subsystem. You can get them for
example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
your patch is touching. For bindings, the preferred subjects are
explained here:
https://www.kernel.org/doc/html/latest/devicetree/bindings/submitting-patches.html#i-for-patch-submitters

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

It looks like you are re-doing I2C work. Please wait till I2C discussion
finishes, so we won't have to comment on the same in multiple places.

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
> diff --git a/Documentation/devicetree/bindings/spi/spi-controller.yaml b/Documentation/devicetree/bindings/spi/spi-controller.yaml
> index 82d051f7bd6e09dab9809c85ff13475d2b118efd..9b44ce4542f9552c94cb0658ffe3f6d3f29bc434 100644
> --- a/Documentation/devicetree/bindings/spi/spi-controller.yaml
> +++ b/Documentation/devicetree/bindings/spi/spi-controller.yaml
> @@ -25,6 +25,13 @@ properties:
>    "#size-cells":
>      const: 0
>  
> +  spi-parent:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      In case of an SPI bus extension, reference to the SPI bus controller
> +      this extension is connected to. In other word, reference the SPI bus
> +      controller on the fixed side that drives the bus extension.
> +
>    cs-gpios:
>      description: |
>        GPIOs used as chip selects.
> @@ -111,7 +118,26 @@ properties:
>        - compatible
>  
>  patternProperties:
> -  "^.*@[0-9a-f]+$":
> +  'spi-bus-extension@[0-9a-f]+$':
> +    type: object
> +    description:
> +      An SPI bus extension connected to an SPI bus. Those extensions allow to
> +      decouple SPI busses when they are wired to connectors.

I really do not get why you need separate two-way phandles for marking
parent child relationship. IOW, if you need two way, then why not graphs?

Or why not just making the device@2 a child of SPI, since it is coming
from overlay.


Best regards,
Krzysztof

