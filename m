Return-Path: <linux-spi+bounces-7623-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A52F8A8B97D
	for <lists+linux-spi@lfdr.de>; Wed, 16 Apr 2025 14:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 290B83BC5FF
	for <lists+linux-spi@lfdr.de>; Wed, 16 Apr 2025 12:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D55614B945;
	Wed, 16 Apr 2025 12:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QXcfBdH9"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441491494BB;
	Wed, 16 Apr 2025 12:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744807423; cv=none; b=XXcRRqJuPRH+BBqQxw4/64KDzNYaW1bA8NQt8kyCkTfs2mtyG6XZgZpglTzbFy085YQZR2Z9nYMJ2rqj9fHBhx6nyeVuS5ZyphRTChMSTzDclLUUjOquVgGAmL1a0+pI/js25rIRP715oRk5FUnjvY58Zirv9OiDyrwuF5x/Hdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744807423; c=relaxed/simple;
	bh=EptSh/Z5xPJhA1aDHMn9nfTawQKCHKc+FCmO0lVffUQ=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=f8jMxRsQWiGCsgRTDM2+n6aUiMQK8+K8c+/OPx9Whw1N2+NLrg8d3da8YpOZvGF2H72VBaQvKLVKZiSlCMnW4f364z/R3gQpJc2TfL9ny2iSA7VQ1KYeS1fpGDmfNbRBPhNv2OwPMWMEGIApFBo0kblCkmtk1ff40Gd3iNqJZ7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QXcfBdH9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7849DC4CEE2;
	Wed, 16 Apr 2025 12:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744807421;
	bh=EptSh/Z5xPJhA1aDHMn9nfTawQKCHKc+FCmO0lVffUQ=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=QXcfBdH9jEPiCjRYz89ioGIpTxNnOCwd0yHyigjxmBqmMyYOPp3L1BXcotqhjbsRt
	 F+dl72ZdNGecgFs45ASxQfhrnfP/X/itLyOY+j3G7WYPjuFq1mQW0JT5IuiGIJhvDU
	 UwDQiUc6eGUO0tmIkL1pkZGHoL2dB4DEgLJJQgz+kLvHZLHlW+LOV9zYQEUfGUasCC
	 DorokKdm8Q9/Js4FKAj8K3aBk0h5FSS70LCw34YxTAGzviwkoSjse5GbSZ4IY9+FEC
	 hoks8NPyQB+e0nEEoNuac8F8BvdtTFnpy88u5gr/Qx/WCVpq3WE9D8Ya/L55gd8BG+
	 +JAdIlrS8GLaA==
Date: Wed, 16 Apr 2025 07:43:39 -0500
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-tegra@vger.kernel.org, smangipudi@nvidia.com, 
 linux-spi@vger.kernel.org, skomatineni@nvidia.com, thierry.reding@gmail.com, 
 kyarlagadda@nvidia.com, ldewangan@nvidia.com, linux-kernel@vger.kernel.org, 
 broonie@kernel.org, jonathanh@nvidia.com
To: Vishwaroop A <va@nvidia.com>
In-Reply-To: <20250416110606.2737315-1-va@nvidia.com>
References: <20250416110606.2737315-1-va@nvidia.com>
Message-Id: <174480737097.2514153.5351260600015584210.robh@kernel.org>
Subject: Re: [PATCH v3 0/6] Configure Clocks, Add Internal DMA support


On Wed, 16 Apr 2025 11:06:00 +0000, Vishwaroop A wrote:
> This series introduces QSPI clock configuration and internal DMA
> support for Quad SPI controller. The patches have been reorganized
> for better logical flow and review comments from v2 have been addressed.
> 
> Vishwaroop A (6):
>   spi: tegra210-quad: Fix X1_X2_X4 encoding and support x4 transfers
>   spi: tegra210-quad: remove redundant error handling code
>   spi: tegra210-quad: modify chip select (CS) deactivation
>   arm64: tegra: Configure QSPI clocks and add DMA
>   spi: tegra210-quad: Update dummy sequence configuration
>   spi: tegra210-quad: Add support for internal DMA
> 
>  arch/arm64/boot/dts/nvidia/tegra234.dtsi |  10 +
>  drivers/spi/spi-tegra210-quad.c          | 282 +++++++++++++----------
>  2 files changed, 176 insertions(+), 116 deletions(-)
> 
> ---
> v2 -> v3:
>         * Reorganized the patches.
>         * Addressed review comments received on the patches.
> ---
> 
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


This patch series was applied (using b4) to base:
 Base: attempting to guess base-commit...
 Base: tags/v6.15-rc2-1-g36ff6c3f5084 (exact match)

If this is not the correct base, please add 'base-commit' tag
(or use b4 which does this automatically)

New warnings running 'make CHECK_DTBS=y for arch/arm64/boot/dts/nvidia/' for 20250416110606.2737315-1-va@nvidia.com:

arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0008.dtb: spi@3270000 (nvidia,tegra234-qspi): Unevaluated properties are not allowed ('iommus' was unexpected)
	from schema $id: http://devicetree.org/schemas/spi/nvidia,tegra210-quad.yaml#
arch/arm64/boot/dts/nvidia/tegra234-p3768-0000+p3767-0000.dtb: spi@3270000 (nvidia,tegra234-qspi): Unevaluated properties are not allowed ('iommus' was unexpected)
	from schema $id: http://devicetree.org/schemas/spi/nvidia,tegra210-quad.yaml#
arch/arm64/boot/dts/nvidia/tegra234-p3768-0000+p3767-0005.dtb: spi@3270000 (nvidia,tegra234-qspi): Unevaluated properties are not allowed ('iommus' was unexpected)
	from schema $id: http://devicetree.org/schemas/spi/nvidia,tegra210-quad.yaml#
arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dtb: spi@3270000 (nvidia,tegra234-qspi): Unevaluated properties are not allowed ('iommus' was unexpected)
	from schema $id: http://devicetree.org/schemas/spi/nvidia,tegra210-quad.yaml#
arch/arm64/boot/dts/nvidia/tegra234-p3740-0002+p3701-0008.dtb: spi@3270000 (nvidia,tegra234-qspi): Unevaluated properties are not allowed ('iommus' was unexpected)
	from schema $id: http://devicetree.org/schemas/spi/nvidia,tegra210-quad.yaml#






