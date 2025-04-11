Return-Path: <linux-spi+bounces-7558-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E32DA8668D
	for <lists+linux-spi@lfdr.de>; Fri, 11 Apr 2025 21:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5441F189E527
	for <lists+linux-spi@lfdr.de>; Fri, 11 Apr 2025 19:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16DC0280A32;
	Fri, 11 Apr 2025 19:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uBqvOm9M"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DBB2586FE;
	Fri, 11 Apr 2025 19:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744400505; cv=none; b=eKyZTTNY6uYkAn814nIC/dWGELNCyneVZ4U0jU3Um9zT3aZN3qOobwsQGAKZc3d0bTbPLTJoCMLV6Da7D1mVD0M6YG1chclKZM4J5KaEPAWDLjG8IVtvaQ2w3pyTcTZmGElzybD/xWk/IejGZ7MFxezziBIntxFVGbg0xzKHzA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744400505; c=relaxed/simple;
	bh=/wFLNpPmWUKjvlLcHH3mgD6Psd/L7xQwFmxNcgBEH1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GG9AS1WFUW7Ms2E9y3J6OXuHLZ2tW0YM+d47wfDgRZ/iosOKYTmQ+l6YxvzZCtjMF4+Jc99/fts5uoWxzzlJTTaL/RJHgb7QwbwD6KwY927rjmwewU7duv7C4IbeHQm5MCXNtcFByrW7uJ2s8AD0FMKpVmseli6USyH/YV2hd0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uBqvOm9M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6808C4CEE2;
	Fri, 11 Apr 2025 19:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744400502;
	bh=/wFLNpPmWUKjvlLcHH3mgD6Psd/L7xQwFmxNcgBEH1I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uBqvOm9Ms6X6s6eKJZcgknAjmqo1NfiDC41m1l2Bw62d0RzLP5dBKlw2Gmf61/GHM
	 FQIYySGY4t8Obirw8UlQAIDkFAMOsFYrGa4vDaerOYukhlh3ckbmjib0GrY65yJ/X7
	 wdk3BUoE1pfEoKdNoCDvr5xcVjsZ/0ttu6pRnmaZ8GU5CSWeRq30n6JLXXz5ezNsxd
	 vyiKJCp9uuGqyLeaUubvSHj2BKcVhdPSEs4MIuUQWkJXKYePxc58BBVxQEaEjQW+c8
	 tTH+etxD8MCj980d7zPPI2LczGlXkkmz15F7BmiWYuvV7WmKjk0bnRyaBahpK5B/gR
	 tBtK7tsPRv3Fg==
Date: Fri, 11 Apr 2025 14:41:40 -0500
From: Rob Herring <robh@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Jaroslav Kysela <perex@perex.cz>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-sound@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH v2 1/9] dt-bindings: renesas,sh-msiof: Add MSIOF I2S
 Sound support
Message-ID: <20250411194140.GA3767706-robh@kernel.org>
References: <87h62vh5mj.wl-kuninori.morimoto.gx@renesas.com>
 <87frifh5ls.wl-kuninori.morimoto.gx@renesas.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87frifh5ls.wl-kuninori.morimoto.gx@renesas.com>

On Fri, Apr 11, 2025 at 01:03:27AM +0000, Kuninori Morimoto wrote:
> Renesas MSIOF (Clock-Synchronized Serial Interface with FIFO) can work as
> both SPI and I2S. MSIOF-I2S will use Audio Graph Card/Card2 driver which
> uses Of-Graph in DT.
> 
> MSIOF-SPI/I2S are using same DT compatible properties.
> MSIOF-I2S         uses Of-Graph for Audio-Graph-Card/Card2,
> MSIOF-SPI doesn't use  Of-Graph.
> 
> Adds schema for MSIOF-I2S (= Sound).
> Because MSIOF is no longer SPI specific device, remove spi specific schema
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  .../bindings/spi/renesas,sh-msiof.yaml        | 23 +++++++++++++------
>  1 file changed, 16 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml b/Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml
> index 49649fc3f95a..9f73120e97c1 100644
> --- a/Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml
> +++ b/Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml
> @@ -4,14 +4,11 @@
>  $id: http://devicetree.org/schemas/spi/renesas,sh-msiof.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>  
> -title: Renesas MSIOF SPI controller
> +title: Renesas MSIOF SPI / I2S controller
>  
>  maintainers:
>    - Geert Uytterhoeven <geert+renesas@glider.be>
>  
> -allOf:
> -  - $ref: spi-controller.yaml#

if:
  properties:
    $nodename:
      pattern: '^spi@'
then:
  $ref: spi-controller.yaml#

Or just always use 'spi' node name even if used for i2s.

> -
>  properties:
>    compatible:
>      oneOf:
> @@ -70,6 +67,12 @@ properties:
>            - description: CPU registers
>            - description: DMA engine registers
>  
> +  "#address-cells":
> +    enum: [0, 1]
> +
> +  "#size-cells":
> +    const: 0
> +

Then drop these.

>    interrupts:
>      maxItems: 1
>  
> @@ -146,14 +149,20 @@ properties:
>      $ref: /schemas/types.yaml#/definitions/uint32
>      default: 64
>  
> +  # for MSIOF-I2S
> +  port:
> +    $ref: ../sound/audio-graph-port.yaml#/definitions/port-base
> +    unevaluatedProperties: false
> +    patternProperties:
> +      "^endpoint(@[0-9a-f]+)?":
> +        $ref: audio-graph-port.yaml#/definitions/endpoint-base

The correct way is:

port:
  $ref: audio-graph-port.yaml#
  unevaluatedProperties: false

> +
>  required:
>    - compatible
>    - reg
>    - interrupts
>    - clocks
>    - power-domains
> -  - '#address-cells'
> -  - '#size-cells'
>  
>  if:
>    not:
> @@ -173,7 +182,7 @@ examples:
>      #include <dt-bindings/interrupt-controller/arm-gic.h>
>      #include <dt-bindings/power/r8a7791-sysc.h>
>  
> -    msiof0: spi@e6e20000 {
> +    msiof0: serial-engine@e6e20000 {
>          compatible = "renesas,msiof-r8a7791", "renesas,rcar-gen2-msiof";
>          reg = <0xe6e20000 0x0064>;
>          interrupts = <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>;
> -- 
> 2.43.0
> 

