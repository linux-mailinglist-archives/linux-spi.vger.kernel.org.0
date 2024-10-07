Return-Path: <linux-spi+bounces-5118-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ECEE992506
	for <lists+linux-spi@lfdr.de>; Mon,  7 Oct 2024 08:40:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 133CC1F215BF
	for <lists+linux-spi@lfdr.de>; Mon,  7 Oct 2024 06:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1A314C5BA;
	Mon,  7 Oct 2024 06:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IquAIWYt"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57DF65733A;
	Mon,  7 Oct 2024 06:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728283220; cv=none; b=CiJhbkexHucFLuvKRyZsXPVkAp+EhHOd7I6fv5jMPQM1fbfcxYGVfxvVbvzQhyaB37jF5lrT2X7r980GYoE1F/PDKg77481taBEVYc8Oi9Gk9UUvqRXQYQYroHsOQcdNrvGUr+l3BeuWeK/Hbu1fU0kjidm6OtPdrMFIXnzrJ1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728283220; c=relaxed/simple;
	bh=DGQEeKF1AWzf06lGshAo7qMOkapLxdW+HCV2OBKPwgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aFQizjUmN/26ZyXOhuPJLyPXyTuKDgeqEYeHP6wgcDfjTTyoBTYw73SxV7yUGrFWyUiQjj2CZDcc7a/oVcBfrHIfUkzCA76Q99IP6/YCI/GDW3juZZOmbJ2ybatkNHLmT96p9mjfm0QzRqbxYFzB1Z/2S3FX10o79b8wVMCSGl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IquAIWYt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37BD3C4CEC6;
	Mon,  7 Oct 2024 06:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728283219;
	bh=DGQEeKF1AWzf06lGshAo7qMOkapLxdW+HCV2OBKPwgA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IquAIWYtKpLBipqP0kdMlwKbKYgXkHEkyP+LFmNnWvPXFq3xmkq31U7daWwPcoUa/
	 iivpHGE0rMKjvu3/Fsux2nXvGU7FVJhkPIpmjxQgBEjb31J03JESWxVFM/Dr5Yc//W
	 wwMWGPVg0adK1VcAKu+ETNTow3GKLpVdyVQK5DfNiE1uSOKXeNS9XoIdi9e2gEGNpT
	 OoQsy89Edhz/0q2Ha7aHKyoMjLoZiQai6RIAgxYFovhVTg+9UWHImXKBt3tzAIRXld
	 hPvncpdf/7yrUWog1KcEZ147C90gWYUZLgD8EjTiX3gcieC8b9baF0qwn3ypIIwgu+
	 6lkHFIYSfaK0g==
Date: Mon, 7 Oct 2024 08:40:16 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, tsbogend@alpha.franken.de, linux-spi@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: spi: Add realtek,rtl9300-snand
Message-ID: <3tu6x2644lxvvbk74nv5qva7qupsvgxyxkwc5g5n7n4bh3mbwi@457wbps4kpns>
References: <20241006233347.333586-1-chris.packham@alliedtelesis.co.nz>
 <20241006233347.333586-2-chris.packham@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241006233347.333586-2-chris.packham@alliedtelesis.co.nz>

On Mon, Oct 07, 2024 at 12:33:45PM +1300, Chris Packham wrote:
> Add a dtschema for the SPI-NAND controller on the RTL9300 SoCs. The
> controller supports
>  * Serial/Dual/Quad data with
>  * PIO and DMA data read/write operation
>  * Configurable flash access timing
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
>  .../bindings/spi/realtek,rtl9300-snand.yaml   | 58 +++++++++++++++++++
>  1 file changed, 58 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/realtek,rtl9300-snand.yaml
> 
> diff --git a/Documentation/devicetree/bindings/spi/realtek,rtl9300-snand.yaml b/Documentation/devicetree/bindings/spi/realtek,rtl9300-snand.yaml
> new file mode 100644
> index 000000000000..c66aea24cb35
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/realtek,rtl9300-snand.yaml
> @@ -0,0 +1,58 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spi/realtek,rtl9300-snand.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: SPI-NAND Flash Controller for Realtek RTL9300 SoCs
> +
> +maintainers:
> +  - Chris Packham <chris.packham@alliedtelesis.co.nz>
> +
> +description:
> +  The Realtek RTL9300 SoCs have a built in SPI-NAND controller. It supports
> +  typical SPI-NAND page cache operations in single, dual or quad IO mode.
> +
> +properties:
> +  compatible:
> +    items:

Why 9300 cannot be alone? What does 9300 mean even? Wildcards and family
models are not allowed in general.

> +      - enum:
> +          - realtek,rtl9301-snand
> +          - realtek,rtl9302b-snand
> +          - realtek,rtl9302c-snand
> +          - realtek,rtl9303-snand
> +      - const: realtek,rtl9300-snand
> +
> +  reg:
> +    items:
> +      - description: SPI NAND controller registers address and size

Best regards,
Krzysztof


