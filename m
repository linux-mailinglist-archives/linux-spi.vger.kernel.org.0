Return-Path: <linux-spi+bounces-5142-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE6A993F84
	for <lists+linux-spi@lfdr.de>; Tue,  8 Oct 2024 09:35:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD8FD1C217EC
	for <lists+linux-spi@lfdr.de>; Tue,  8 Oct 2024 07:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4961D54D1;
	Tue,  8 Oct 2024 07:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q1iTtKOB"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B631CACED;
	Tue,  8 Oct 2024 07:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728370916; cv=none; b=ie21jAgLmQIK61mhDC29+goaCR1wCc9gXib2xUVtRaSZ6e9s+IjzbMjxYPBvocwzAdZcV7ZsntNEY/DyyvCK+X7bJf+wa/qJZefq3bqFXCtFg0ORNA0HXR8+wtNYcwKwaCNgT4QibEckS8TZjmBPww8vcZsMMG44N3A6YU4vHtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728370916; c=relaxed/simple;
	bh=wQFQaZ17DLkCHf3agUP3iunbBiIMqKxBWdekK18z/DY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mz7oNxwTR1WEQem14jcdxQfVDRL9qsycJ7OuJxBDpm5P4+0gedgq2c2FksM7+4VGI+Qb4l83js5VtDyc0MliQFxLJFvFrA2HSQLb34ULHQQ4b9lbyhlanz8R1oYZENqIIZyem0k9Q9Mfv9ZmT5c1k3p2h37VQGWpCTgI2z1VP1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q1iTtKOB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0FB0C4CEC7;
	Tue,  8 Oct 2024 07:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728370915;
	bh=wQFQaZ17DLkCHf3agUP3iunbBiIMqKxBWdekK18z/DY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q1iTtKOB67Mwh0M8LrfGpHxLvv2Jax+7oefSNHa3emVnkArF3IzuXhdQQs1TfJ/SI
	 70FitPzlgJcrdQWIpU+zaasP/l0mxd4N7Sgj9cXVf+LGWEuUkjV4XKdcspPzWa96Yy
	 LWGp39ocuNnxpBRR/w1SUea614RvSZHtyIZZoWnQtqvB+4pcK5KCS6sOcj7wpuK4Xu
	 9qVLzrFgQh7H3AlhOTBKRO5vp0eg6hVvNzklBW/t4hb1dNxHBCft7icmWFHTXLtvaK
	 +6s+yA0sDlM/wrWc9VoDdZMWgM/UyImxiNjvc0JHW/x3UYi73QKBcqeJp45bXhKKBi
	 N9SDXdTsvpabg==
Date: Tue, 8 Oct 2024 09:01:52 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, tsbogend@alpha.franken.de, linux-spi@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: spi: Add realtek,rtl9300-snand
Message-ID: <mkrglsjnaxz6m34bb35no7xmv2hcwdbi2il6ijq6khhr7afrv4@vzleatkn7f3h>
References: <20241008002308.1149983-1-chris.packham@alliedtelesis.co.nz>
 <20241008002308.1149983-2-chris.packham@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241008002308.1149983-2-chris.packham@alliedtelesis.co.nz>

On Tue, Oct 08, 2024 at 01:23:05PM +1300, Chris Packham wrote:
> Add a dtschema for the SPI-NAND controller on the RTL9300 SoCs. The
> controller supports
>  * Serial/Dual/Quad data with
>  * PIO and DMA data read/write operation
>  * Configurable flash access timing
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
> 
> Notes:
>     Changes in v2:
>     - Add clocks
>     - For now I've kept realtek,rtl9300-snand to identify the IP block used
>       in the various rtl930x chips. If the consensus is to drop this I can
>       send a v3 with an updated driver to add the chip specific complatibles.
> 
>  .../bindings/spi/realtek,rtl9300-snand.yaml   | 69 +++++++++++++++++++
>  1 file changed, 69 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/realtek,rtl9300-snand.yaml
> 
> diff --git a/Documentation/devicetree/bindings/spi/realtek,rtl9300-snand.yaml b/Documentation/devicetree/bindings/spi/realtek,rtl9300-snand.yaml
> new file mode 100644
> index 000000000000..2d01464e85e5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/realtek,rtl9300-snand.yaml
> @@ -0,0 +1,69 @@
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

Drop 9300, unless it is a final product but then it should be allowed
standalone.

And yeah, it's total mess for other "Realtek Otto" bindings because no
one develops it in cohesive way and no one provides full picture to us
for review.

> +
> +  reg:
> +    items:
> +      - description: SPI NAND controller registers address and size
> +
> +  interrupts:
> +    items:
> +      - description: SPI NAND controller interrupt
> +
> +  clocks:
> +    items:
> +      - description: SPI NAND controller reference clock
> +
> +  clock-names:
> +    items:
> +      - const: spi

Drop clock-names.

Best regards,
Krzysztof


