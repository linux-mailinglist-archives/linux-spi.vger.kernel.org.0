Return-Path: <linux-spi+bounces-5226-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C007499C0D1
	for <lists+linux-spi@lfdr.de>; Mon, 14 Oct 2024 09:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF7261C234C4
	for <lists+linux-spi@lfdr.de>; Mon, 14 Oct 2024 07:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7255145B3F;
	Mon, 14 Oct 2024 07:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SyGEZNG5"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971D24C7C;
	Mon, 14 Oct 2024 07:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728889945; cv=none; b=A7Jsi8/mGKyiQZnLXvFlPgP2qKBpo+jKtnlNOiqj7vd4cZeE6C2DViZXagO+c6Sqy98NRVUOPrp6pv2czTngRI1K2qotrXuCeNFlGgjBRIwVPOvbhpKhp/O3j02OL4cS8KZWMdkY2DvzDSVngUzqtRokJ8uX9kLRW2eUpcih5ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728889945; c=relaxed/simple;
	bh=UcQUHK/Sgz6lopkosdItwhkbc5msm2SD0odvFPImROs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Robv33H5lmjhPmxPJZSK8YK52XAHeWMk4QzNM4k7M7TWFPftNDmv041qUifINhYJv1MCU47bMZih8ghByvf5ROkO6wESmRyrXAlNx22ljZ0/4pDCXNFNc5eGB1nQVglPpQQTitJoIOWB6F9w4rT1NzTj1cjMNk1Kj+Svqu3bQ4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SyGEZNG5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57071C4CEC3;
	Mon, 14 Oct 2024 07:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728889945;
	bh=UcQUHK/Sgz6lopkosdItwhkbc5msm2SD0odvFPImROs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SyGEZNG5TFwoEDhsAIFSRz1e4TVla3h9OW9OKoNcZlT9rJpsrqcT55WAaMdUN0aIT
	 SJogod4PHnu8WfDYax0jXRYQx5b16MQ2zOgAv75Zyq6w3S6nX9xcwlKyDHknv497Hu
	 D2JYOlCXuFqE+de2XKPUnNyek1V8V+qhg3dOB5zYYjAKO76pjCL2t6HAbSlKTYPOjA
	 McVkzxmzlTU3Vt3YZXLdsIKw6fq3LBlFhfvJ+57yhTMdnL5aOWCHwFb/RX2YgBtV5H
	 lkOYs9YdCVOFHY6H/oCXt2wHcOyg7MmgYpdhCukzoWy2YD/WxiWzoFFfLML3dC3fiI
	 T33UFhT4Y9COg==
Date: Mon, 14 Oct 2024 09:12:21 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, tsbogend@alpha.franken.de, linux-spi@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
Subject: Re: [PATCH v4 1/3] dt-bindings: spi: Add realtek,rtl9301-snand
Message-ID: <nuadh2elbry2qc4l7rdngfvs4inbsmo2vg2w72w5d4cgpnail2@zidp7kzxp7qp>
References: <20241014015245.2513738-1-chris.packham@alliedtelesis.co.nz>
 <20241014015245.2513738-2-chris.packham@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241014015245.2513738-2-chris.packham@alliedtelesis.co.nz>

On Mon, Oct 14, 2024 at 02:52:43PM +1300, Chris Packham wrote:
 
> diff --git a/Documentation/devicetree/bindings/spi/realtek,rtl9301-snand.yaml b/Documentation/devicetree/bindings/spi/realtek,rtl9301-snand.yaml
> new file mode 100644
> index 000000000000..397b32b41e86
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/realtek,rtl9301-snand.yaml
> @@ -0,0 +1,59 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spi/realtek,rtl9301-snand.yaml#
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
> +    enum:
> +      - realtek,rtl9301-snand
> +      - realtek,rtl9302b-snand
> +      - realtek,rtl9302c-snand
> +      - realtek,rtl9303-snand

All of them look compatible with each other, why not using fallback to
9301? That's common and expected pattern.

Best regards,
Krzysztof


