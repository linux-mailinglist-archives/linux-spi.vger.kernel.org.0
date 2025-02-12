Return-Path: <linux-spi+bounces-6800-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A16EA33218
	for <lists+linux-spi@lfdr.de>; Wed, 12 Feb 2025 23:08:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 291563A783F
	for <lists+linux-spi@lfdr.de>; Wed, 12 Feb 2025 22:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09CBF203711;
	Wed, 12 Feb 2025 22:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HVmN2rQO"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D6C2036ED;
	Wed, 12 Feb 2025 22:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739398133; cv=none; b=H0nFVwKKoPn+cqdkTJJwyT2wJA0F5cpsTLuwC3b/WDA01W+6zP4IPTl4I6eoWyf+CU8BMKKQaBQ0clCFdgbGSSOLpnOj3BV0HGbvbeG0ifh39GuxgQQaAJFGAzwSAfJ5VxBye8l/1LcwKNVMNRm8psJ4Vzz3JwYvoUBN0678yV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739398133; c=relaxed/simple;
	bh=kO4pmiuBXJVn23fh7yK0dMENTZZ3dsQpimEg4/VR7YM=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=axy1ghdO+gXAO0z+eG7k2YwCrwUd6ceohDfYJZRBAFiHXVn0Qr/m5pna5yl5a+7nUs79HSI45WETAYyYJUVyNhoLBySG7d76dh8dbm6eiI3wn4OUi77z2r1q5yO717jFZwHxKCdEIAraBha2kYxW8GEDITWOFlWH9UebokNIrF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HVmN2rQO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26F40C4CEDF;
	Wed, 12 Feb 2025 22:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739398133;
	bh=kO4pmiuBXJVn23fh7yK0dMENTZZ3dsQpimEg4/VR7YM=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=HVmN2rQOSlZupdEeZ+yet8gDn7h4Vr3AL/qb1wa4LPnK/06A+yCt1/Z7EPcWvr+f9
	 LtWMAkjqOL1o28u1hhVnDwSNzwjGPAPnNuop/FE3ykGyICcAIBrtNNjpgo2Il36Koj
	 uB8A5Gj66Q5MiOUwAU67m6PqAHMVndGgRt1HzEWW1lqspwlQ1etEvetSBFZ+/REvtJ
	 VXJ8z8LTWt8/KegEtZjaBo9Nz4SEd5r4K/lyiIR+pdGhO/u5YA0rw7Gtipa2Is/qeK
	 ELSmUOhzrC/MimV6FtMb5MmhrT971hi18tLIg4yxMRJqvt+UM1jNtWxNUjnm7XfdPK
	 9dysLU353e4dA==
Date: Wed, 12 Feb 2025 16:08:52 -0600
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: jonathanh@nvidia.com, broonie@kernel.org, linux-spi@vger.kernel.org, 
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
 smangipudi@nvidia.com, skomatineni@nvidia.com, thierry.reding@gmail.com, 
 ldewangan@nvidia.com, kyarlagadda@nvidia.com
To: Vishwaroop A <va@nvidia.com>
In-Reply-To: <20250212144651.2433086-1-va@nvidia.com>
References: <s355cib7g6e3gmsy2663pnzx46swhfudpofv2s5tcaytjq4yuj@xqtvoa5p477n>
 <20250212144651.2433086-1-va@nvidia.com>
Message-Id: <173939808222.598724.14105549991547755635.robh@kernel.org>
Subject: Re: [PATCH v2 0/6] Configure Clocks, Add Native Dma support.


On Wed, 12 Feb 2025 14:46:45 +0000, Vishwaroop A wrote:
> This patch series configures qspi clocks, fixes combined sequence
> programming and introduces native dma support.
> 
> Vishwaroop A (6):
>   arm64: tegra: Configure QSPI clocks and add DMA
>   spi: tegra210-quad: Update dummy sequence configuration
>   spi: tegra210-quad: Fix X1_X2_X4 encoding and support x4 transfers
>   spi: tegra210-quad: remove redundant error handling code
>   spi: tegra210-quad: modify chip select (CS) deactivation
>   spi: tegra210-quad: Introduce native DMA support
> 
>  arch/arm64/boot/dts/nvidia/tegra234.dtsi |  14 ++
>  drivers/spi/spi-tegra210-quad.c          | 273 +++++++++++++----------
>  2 files changed, 174 insertions(+), 113 deletions(-)
> 
> ---
> v1 -> v2:
> 	* Removed Change-IDs from the patches.
>         * Addressed kernel test bot warnings.
> ---
> --
> 2.17.1
> 
> 
> 


My bot found new DTB warnings on the .dts files added or changed in this
series.

Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
are fixed by another series. Ultimately, it is up to the platform
maintainer whether these warnings are acceptable or not. No need to reply
unless the platform maintainer has comments.

If you already ran DT checks and didn't see these error(s), then
make sure dt-schema is up to date:

  pip3 install dtschema --upgrade


New warnings running 'make CHECK_DTBS=y for arch/arm64/boot/dts/nvidia/' for 20250212144651.2433086-1-va@nvidia.com:

arch/arm64/boot/dts/nvidia/tegra234-sim-vdk.dtb: spi@3270000: 'dmas' is a dependency of 'dma-names'
	from schema $id: http://devicetree.org/schemas/dma/dma.yaml#
arch/arm64/boot/dts/nvidia/tegra234-p3768-0000+p3767-0000.dtb: spi@3270000: Unevaluated properties are not allowed ('dma-coherent', 'iommus' were unexpected)
	from schema $id: http://devicetree.org/schemas/spi/nvidia,tegra210-quad.yaml#
arch/arm64/boot/dts/nvidia/tegra234-p3768-0000+p3767-0000.dtb: spi@3270000: 'dmas' is a dependency of 'dma-names'
	from schema $id: http://devicetree.org/schemas/dma/dma.yaml#
arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0008.dtb: spi@3270000: Unevaluated properties are not allowed ('dma-coherent', 'iommus' were unexpected)
	from schema $id: http://devicetree.org/schemas/spi/nvidia,tegra210-quad.yaml#
arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0008.dtb: spi@3270000: 'dmas' is a dependency of 'dma-names'
	from schema $id: http://devicetree.org/schemas/dma/dma.yaml#
arch/arm64/boot/dts/nvidia/tegra234-sim-vdk.dtb: spi@3300000: 'dmas' is a dependency of 'dma-names'
	from schema $id: http://devicetree.org/schemas/dma/dma.yaml#
arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dtb: spi@3270000: Unevaluated properties are not allowed ('dma-coherent', 'iommus' were unexpected)
	from schema $id: http://devicetree.org/schemas/spi/nvidia,tegra210-quad.yaml#
arch/arm64/boot/dts/nvidia/tegra234-p3768-0000+p3767-0005.dtb: spi@3270000: Unevaluated properties are not allowed ('dma-coherent', 'iommus' were unexpected)
	from schema $id: http://devicetree.org/schemas/spi/nvidia,tegra210-quad.yaml#
arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dtb: spi@3270000: 'dmas' is a dependency of 'dma-names'
	from schema $id: http://devicetree.org/schemas/dma/dma.yaml#
arch/arm64/boot/dts/nvidia/tegra234-p3768-0000+p3767-0005.dtb: spi@3270000: 'dmas' is a dependency of 'dma-names'
	from schema $id: http://devicetree.org/schemas/dma/dma.yaml#
arch/arm64/boot/dts/nvidia/tegra234-p3740-0002+p3701-0008.dtb: spi@3270000: Unevaluated properties are not allowed ('dma-coherent', 'iommus' were unexpected)
	from schema $id: http://devicetree.org/schemas/spi/nvidia,tegra210-quad.yaml#
arch/arm64/boot/dts/nvidia/tegra234-p3768-0000+p3767-0000.dtb: spi@3300000: 'dmas' is a dependency of 'dma-names'
	from schema $id: http://devicetree.org/schemas/dma/dma.yaml#
arch/arm64/boot/dts/nvidia/tegra234-p3740-0002+p3701-0008.dtb: spi@3270000: 'dmas' is a dependency of 'dma-names'
	from schema $id: http://devicetree.org/schemas/dma/dma.yaml#
arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0008.dtb: spi@3300000: 'dmas' is a dependency of 'dma-names'
	from schema $id: http://devicetree.org/schemas/dma/dma.yaml#
arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dtb: spi@3300000: 'dmas' is a dependency of 'dma-names'
	from schema $id: http://devicetree.org/schemas/dma/dma.yaml#
arch/arm64/boot/dts/nvidia/tegra234-p3768-0000+p3767-0005.dtb: spi@3300000: 'dmas' is a dependency of 'dma-names'
	from schema $id: http://devicetree.org/schemas/dma/dma.yaml#
arch/arm64/boot/dts/nvidia/tegra234-p3740-0002+p3701-0008.dtb: spi@3300000: 'dmas' is a dependency of 'dma-names'
	from schema $id: http://devicetree.org/schemas/dma/dma.yaml#






