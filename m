Return-Path: <linux-spi+bounces-3164-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E01948D5853
	for <lists+linux-spi@lfdr.de>; Fri, 31 May 2024 03:47:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FE501F249A9
	for <lists+linux-spi@lfdr.de>; Fri, 31 May 2024 01:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 119A9EAF9;
	Fri, 31 May 2024 01:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VUgrZurj"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8517FF;
	Fri, 31 May 2024 01:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717120025; cv=none; b=vGBidPA+0mnfiUlZNCDJsFshDKK6KqV2XN3sZUViqrXHS7VCempdCrGT6K5QGsR2W5jD2ZXocea6gvOLTiFwq5zUi3uct7dbV8y0MZI1pZhetUxDQb+u58LqFajjs4ezoMt9JHAjohiKY9ha//khxWSYFrVKlD9YMkUtwlq4boQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717120025; c=relaxed/simple;
	bh=sm4tOvPgFiYREVqJv7hB+doGfUq4iZtbeO6LKvut3/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NGVLFB0jbTSEpo37+ZWomLg/2k9fbZlaPiyDIFK615BkKq9rUvL8lqZfl7DbqEeoyOtyDmOkWwSOfk+pGROaQBvXojRpmmnVgSM/wBYv94bOQuf2p73OdVRLPVL+c3fR3qUgmRFO0QpLybAqjM2kw3g/SubLhkxXyE1LwnHJ2Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VUgrZurj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3730AC32789;
	Fri, 31 May 2024 01:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717120024;
	bh=sm4tOvPgFiYREVqJv7hB+doGfUq4iZtbeO6LKvut3/k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VUgrZurjV332keL/lETXjBTJdXtAkFcwGZtnyMQiCLkqDoD8PmGXGJ498cY+/JeTt
	 tpdnQYsV1xXfKqk2XGmoj6b4Bi43LPEmh2mXB8L2xGCozzmDxvuOT2HvoXPrQq6mdf
	 VD9u8OjpHerNmUcIE9VZro13YCwv2DHyWnXZXWkBSl1iQ/f4fgtOV6mJjSIsxSJdE9
	 VqsnDKHMBs6h4qq/HYHkiO5l515Dxcwp1PNkUuTq3K9JNuwHMWyRj+uBoB1uXUHm42
	 pexH+rvlB+3u88dpLfcHKEex0PVt8MGovihIfEcY6elOxFj8R7tt35zQhnYjH3giPS
	 OnhXqIoAeaydg==
Date: Thu, 30 May 2024 20:47:03 -0500
From: Rob Herring <robh@kernel.org>
To: Witold Sadowski <wsadowski@marvell.com>
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, broonie@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	pthombar@cadence.com
Subject: Re: [PATCH v7 1/4] spi: dt-bindings: cadence: Add Marvell overlay
 bindings documentation for Cadence XSPI
Message-ID: <20240531014703.GA3691352-robh@kernel.org>
References: <20240529220026.1644986-1-wsadowski@marvell.com>
 <20240529220026.1644986-2-wsadowski@marvell.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529220026.1644986-2-wsadowski@marvell.com>

On Wed, May 29, 2024 at 03:00:23PM -0700, Witold Sadowski wrote:
> Add new bindings for the v2 Marvell xSPI overlay: marvell,cn10-xspi-nor
> compatible string. This new compatible string distinguishes between the
> original and modified xSPI block.
> 
> Also add an optional base for the xfer register set with an additional
> reg field to allocate the xSPI Marvell overlay XFER block.
> 
> Signed-off-by: Witold Sadowski <wsadowski@marvell.com>

Missing a tag.

But since you want it reviewed again...

> ---
>  .../devicetree/bindings/spi/cdns,xspi.yaml    | 32 ++++++++++++++++---
>  1 file changed, 28 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/spi/cdns,xspi.yaml b/Documentation/devicetree/bindings/spi/cdns,xspi.yaml
> index eb0f92468185..49c6a2c82fc4 100644
> --- a/Documentation/devicetree/bindings/spi/cdns,xspi.yaml
> +++ b/Documentation/devicetree/bindings/spi/cdns,xspi.yaml
> @@ -15,24 +15,27 @@ description: |
>    single, dual, quad or octal wire transmission modes for
>    read/write access to slaves such as SPI-NOR flash.
>  
> -allOf:
> -  - $ref: spi-controller.yaml#
> -
>  properties:
>    compatible:
> -    const: cdns,xspi-nor
> +    enum:
> +      - cdns,xspi-nor
> +      - marvell,cn10-xspi-nor
>  
>    reg:
>      items:
>        - description: address and length of the controller register set
>        - description: address and length of the Slave DMA data port
>        - description: address and length of the auxiliary registers
> +      - description: address and length of the xfer registers
> +    minItems: 3
>  
>    reg-names:
>      items:
>        - const: io
>        - const: sdma
>        - const: aux
> +      - const: xferbase

'base' is redundant.

> +    minItems: 3
>  
>    interrupts:
>      maxItems: 1
> @@ -42,6 +45,27 @@ required:
>    - reg
>    - interrupts
>  
> +allOf:
> +  - $ref: spi-controller.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - marvell,cn10-xspi-nor
> +    then:
> +      properties:
> +        reg:
> +          minItems: 4
> +        reg-names:
> +          minItems: 4
> +    else:
> +      properties:
> +        reg:
> +          maxItems: 3
> +        reg-names:
> +          maxItems: 3
> +
>  unevaluatedProperties: false
>  
>  examples:
> -- 
> 2.43.0
> 

