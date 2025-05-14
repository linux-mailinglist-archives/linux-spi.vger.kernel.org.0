Return-Path: <linux-spi+bounces-8119-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D85ABAB74EA
	for <lists+linux-spi@lfdr.de>; Wed, 14 May 2025 21:01:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 483561790C0
	for <lists+linux-spi@lfdr.de>; Wed, 14 May 2025 19:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6C4128C016;
	Wed, 14 May 2025 19:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iKifJUl5"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74692170A0B;
	Wed, 14 May 2025 19:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747249268; cv=none; b=p9R3RL/5StLxB5OzQkPuQzKZ41C7OWDZnv7Ejrv4zFYdgDVMaFS/AjiZXkavVeoMb3wQp/0AYRFqnoBmDRyB6NWJXLUrpSoRpQzkdpPPk5AzpksVZPRzNVOHCPbT6mxuSPaYlV0BbC+oUHeGODx926YtxPwuGw6auV/qcrs69hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747249268; c=relaxed/simple;
	bh=RStBa4gVqf1gj1isnHbG1ZXIKHIna+AFHATrVG/m41Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CCK00M3BiK97cvOdltCniHNN5ekOB7bUoGoH+TQBFQ+SyaeJCXeagV8gz9Ne6ImVESinrvC8+rKMz6A2LoYycDlgEFjWiMfLfmc+9BM057p4mtrGXzgRXXA+47Ltp5ZUWk1YjifIY8BKBF07SnN1gMG1GyLa5XhDCXbgwnXcCIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iKifJUl5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9868C4CEE3;
	Wed, 14 May 2025 19:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747249268;
	bh=RStBa4gVqf1gj1isnHbG1ZXIKHIna+AFHATrVG/m41Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iKifJUl5ceYqMaKdMrKuea+rRuVDmtm9NX2RGlxGNMMh3LGKLRdvEt9jwrR/LhUf4
	 34jZPh+xsRu+faMlnuEiqXHfRHDZrNe5JGRigsLQWr/lMlkrg6n/eS6oif70xdR2Ah
	 FR+VRj6Zqr0jU5JMQ93wi5y6lAgWog4PfioFdpWGqig+7VCMwNbtyfGeWWx1lDvlvb
	 5D4gV6QYh3mbY4BwyhMx99qikJGPa+6jCOYqun2g+EeJs7awr0Yr8RvrdRKOWY7458
	 r27o3GdCj/9YObWkCbjb4G+OC/oP2Gve0Sn+vF0ui+h3RI9FyoM005CYi+zGGRsH9C
	 FnwGp4wytS9IQ==
Date: Wed, 14 May 2025 14:01:06 -0500
From: Rob Herring <robh@kernel.org>
To: Vishwaroop A <va@nvidia.com>
Cc: krzk@kernel.org, broonie@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, thierry.reding@gmail.com, jonathanh@nvidia.com,
	skomatineni@nvidia.com, ldewangan@nvidia.com,
	kyarlagadda@nvidia.com, smangipudi@nvidia.com,
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: spi: nvidia,tegra210-quad: Add IOMMU
 property for Tegra234
Message-ID: <20250514190106.GA2808529-robh@kernel.org>
References: <20250506180848.3430191-1-va@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250506180848.3430191-1-va@nvidia.com>

On Tue, May 06, 2025 at 06:08:48PM +0000, Vishwaroop A wrote:
> The Tegra210 Quad SPI controller uses internal DMA engines to efficiently
> transfer data between system memory and the SPI bus. On Tegra234 platform,
> DMA transactions must be properly mapped and protected through IOMMU to
> ensure system security and functional correctness. Tegra241 uses external
> DMA and doesn't require IOMMU.
> 
> Add the iommus property to the device tree binding, making it required
> only for Tegra234 platform while explicitly disallowing it for other
> platforms including Tegra241.
> 
> Signed-off-by: Vishwaroop A <va@nvidia.com>
> ---
>  .../bindings/spi/nvidia,tegra210-quad.yaml    | 22 +++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml b/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml
> index 48e97e240265..ac79cb19c81a 100644
> --- a/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml
> +++ b/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml
> @@ -12,6 +12,25 @@ maintainers:
>  
>  allOf:
>    - $ref: spi-controller.yaml#
> +  - if:
> +      properties:
> +        compatible:

Use 'contains' here so if this is ever a fallback, it works for that 
case.

> +          enum:
> +            - nvidia,tegra234-qspi
> +    then:
> +      required:
> +        - iommus
> +  - if:
> +      properties:
> +        compatible:
> +          enum:
> +            - nvidia,tegra210-qspi
> +            - nvidia,tegra186-qspi
> +            - nvidia,tegra194-qspi
> +            - nvidia,tegra241-qspi

Shouldn't this just be an 'else'? I suppose sometimes an IOMMU might not 
be enabled, but that's policy. Either the h/w has an IOMMU or it 
doesn't.

> +    then:
> +      properties:
> +        iommus: false
>  
>  properties:
>    compatible:
> @@ -47,6 +66,9 @@ properties:
>        - const: rx
>        - const: tx
>  
> +  iommus:
> +    maxItems: 1
> +
>  patternProperties:
>    "@[0-9a-f]+$":
>      type: object
> -- 
> 2.17.1
> 

