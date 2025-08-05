Return-Path: <linux-spi+bounces-9298-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBAE2B1B9BE
	for <lists+linux-spi@lfdr.de>; Tue,  5 Aug 2025 20:00:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BA9C3BB89F
	for <lists+linux-spi@lfdr.de>; Tue,  5 Aug 2025 18:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 156101F17E8;
	Tue,  5 Aug 2025 18:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OHTMyxGF"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB231B043C;
	Tue,  5 Aug 2025 18:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754416846; cv=none; b=tYn8+rQ3syTXt+3HkBZraJXXyRADx5efhrvCkvp91WHgDMCaKgr9gXkTw//72G5kWCcbM2BLRRIzGeKYVYk3RZTFnqXfKbpswPYzJB9Sm1c1Kp3StwZFDyDscwwzXQjsofW7udM09cEqSz5F/EHnIHglRLUrjSADc9Ygo0Ypv1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754416846; c=relaxed/simple;
	bh=ln/2JVk6NhVsQlWmJ0evfyIiDUEGD4I1liy5tXtZuD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HLxuMFTwuCCckcI1v12Oy6ac5+ZZwHQd3zGWAUbtEsay4cGJzJbiyGoNra04iedqVIlQLcogLsYFz54EM3axJ/7ft7E76aegYvJWqnZzAEAtue21YqkZtbgNmm3mCiQXDd0jDfAQKmknuv7kV4xQ5MCC18In8vRZO5quXVnmxMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OHTMyxGF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49ED5C4CEF0;
	Tue,  5 Aug 2025 18:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754416845;
	bh=ln/2JVk6NhVsQlWmJ0evfyIiDUEGD4I1liy5tXtZuD0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OHTMyxGFQQfgBiaX7nV3hZMsQsP0NpZz6nRiI8HdmNNfiscY6MXw04aK7hY6kH/qj
	 Cy1suNpKCB1VUqy3Brcn+gQOX0I0HH6qET2dp4Cc7Mit1jS0JzLKxSbuFDY6qTyeBE
	 mx1EITer5jd8EgHB0IZaJMuuscpLCK//s3SUpmOXM91CtLO+6C9+BZu2SVhmjtpSY3
	 AD2IP2ObVh7++LSiBvKKMJPOhv2h+k3d4ZIAFyO5wggV3tTGO/KF2swc8jHputQFm/
	 h1Cb3Yh1RJXJiL/S/1OfP4N8Rw/95v46g45YOWbq1prYPpbm6fXUodBa1iOD+E9vR9
	 CcSatEMMhK6iA==
Date: Tue, 5 Aug 2025 13:00:44 -0500
From: Rob Herring <robh@kernel.org>
To: Manikandan Muralidharan <manikandan.m@microchip.com>
Cc: broonie@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev, ryan.wanner@microchip.com,
	tudor.ambarus@linaro.org, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] spi: dt-bindings: atmel,at91rm9200-spi: Add
 support for optional 'spi_gclk' clock
Message-ID: <20250805180044.GA2012043-robh@kernel.org>
References: <20250805102510.36507-1-manikandan.m@microchip.com>
 <20250805102510.36507-3-manikandan.m@microchip.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250805102510.36507-3-manikandan.m@microchip.com>

On Tue, Aug 05, 2025 at 03:55:09PM +0530, Manikandan Muralidharan wrote:
> The Atmel SPI controller supports both the peripheral clock and the
> Generic Clock (GCLK) as sources for SPCK generation. On platforms like
> the SAM9X7 SoC, the peripheral clock can reach frequencies up to
> 266 MHz, which may exceed the maximum value supported by the Serial
> Clock Baud Rate (SCBR) divider, leading to SPI transfer failures. In such
> cases, the GCLK can be used as an alternative source for SPCK generation"
> 
> This patch updates the Atmel SPI DT binding to support an optional
> programmable SPI generic clock, specified as 'spi_gclk', in addition to
> the required 'spi_clk'.
> 
> Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
> ---
>  .../devicetree/bindings/spi/atmel,at91rm9200-spi.yaml | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/spi/atmel,at91rm9200-spi.yaml b/Documentation/devicetree/bindings/spi/atmel,at91rm9200-spi.yaml
> index d29772994cf5..11885d0cc209 100644
> --- a/Documentation/devicetree/bindings/spi/atmel,at91rm9200-spi.yaml
> +++ b/Documentation/devicetree/bindings/spi/atmel,at91rm9200-spi.yaml
> @@ -31,11 +31,16 @@ properties:
>      maxItems: 1
>  
>    clock-names:
> -    contains:
> -      const: spi_clk
> +    items:
> +      - const: spi_clk
> +      - const: spi_gclk

Well, "spi_clk" was a terrible name as it is completely redundant as 
this is the "spi" block and everything in the list is a "clk". So don't 
continue it and just do "gclk".

> +    minItems: 1
>  
>    clocks:
> -    maxItems: 1
> +    items:
> +      - description: Peripheral Bus clock
> +      - description: Programmable Generic clock
> +    minItems: 1
>  
>    dmas:
>      items:
> -- 
> 2.25.1
> 

