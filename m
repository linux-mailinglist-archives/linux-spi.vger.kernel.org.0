Return-Path: <linux-spi+bounces-5119-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8496F99251B
	for <lists+linux-spi@lfdr.de>; Mon,  7 Oct 2024 08:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACFDD1C20F2B
	for <lists+linux-spi@lfdr.de>; Mon,  7 Oct 2024 06:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60AA158861;
	Mon,  7 Oct 2024 06:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WcFsA7fy"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91AFE800;
	Mon,  7 Oct 2024 06:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728283977; cv=none; b=hI5lv6Y6lgBrOK7aq/RsDe20KI52hWve/lRXLYxek7LzmIHhmWfBHACHQ/qmSWKW74wa4ND6nlmDfpv+X3YHH2cD1VYkw1N58HM0PcXvB1QFolTJSukxtvlDrqFyYJYG1IVVqx/pHnVx+w8oPkZuJMMLRPYLRHJ05dfqgJVD4nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728283977; c=relaxed/simple;
	bh=YE/fwUsofTUlM2zFpCR08q2JU6CrcP0FnVxAVwLIhFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NlT5bG3uA+/CztblIxLB8ck73rzoeEJXELYEJRwzT2y7qUqo4PvN05la0eAqmp8e82Ms0N2kKYhPmxekt/sNvSYCaQvuCDslYJ8c/5tcsgSVs5gF+KMpsVWAQTi7eYVFX6pgv8lV7mPbPIhNSRgGsf8aNIrcl2cj8m6sIUVwnqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WcFsA7fy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93F6DC4CEC6;
	Mon,  7 Oct 2024 06:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728283977;
	bh=YE/fwUsofTUlM2zFpCR08q2JU6CrcP0FnVxAVwLIhFU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WcFsA7fy9qBFJGUBFM/FMs/bdGvoFUnSFk0f9f1S6N+a2juIwwi4wdshTtb/ReBLI
	 0Z+zV53gLCqz+cGgAIZ1LtcH6Y5oBraY9VsySO5+bWS51J+S+4Cf/jE+3Es+qeoGZz
	 PPm6vj2Efqhy15Pe+In4HDXcDb7X3s43mMQwsfsQJZcEtXO6U5l5dGperiZy1qU3Il
	 9ZXx7m5T+QRRrAe+Qnt6EfJqIzGJnYSyUueVkW9Npq3n+4vGlo6ctEU1tXjnI1Apma
	 7nsbG8QYvgj1PAWUOfy4Vijus/OO3samys4VYeW+YYBOHX4OGS6QduUd8q3vbzOo2i
	 aWz3IUlKvarGQ==
Date: Mon, 7 Oct 2024 08:52:53 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, tsbogend@alpha.franken.de, linux-spi@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: spi: Add realtek,rtl9300-snand
Message-ID: <jqiu42r5gegl7vf3tghoudwdliafv3jsvdscmbxxjonqzjxe2f@ogzdgyifnbx7>
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
> +

Also: why no clocks? Binding is supposed to be complete. If it cannot,
you should explain it in the commit msg.

Best regards,
Krzysztof


