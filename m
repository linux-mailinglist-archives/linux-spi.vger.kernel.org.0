Return-Path: <linux-spi+bounces-8039-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5610AB171E
	for <lists+linux-spi@lfdr.de>; Fri,  9 May 2025 16:18:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B2333BE5B7
	for <lists+linux-spi@lfdr.de>; Fri,  9 May 2025 14:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD90221B9FD;
	Fri,  9 May 2025 14:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lNRTj5CO"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1C821322B;
	Fri,  9 May 2025 14:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746800231; cv=none; b=oTowVLRHKtky9pq2MKJN9r9DBbgkTRFGfigOrJXIoAkeY83Vl+zwOdnKnEEENt2JZJo9vWwbG+Z47XmnfzcGSbG78HKTuS33bfdC7Y2P2/R8Xe08e8uFTJvZJkWt5UwpzbD3btdy/P6aKvxNZe6C82STM+r5qMJqI4zIBo8gM0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746800231; c=relaxed/simple;
	bh=/PIseCcZUdjenlJfiK9ityerZ5vunYK2BIb4xzakXsY=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=eV+ELn8zMm0RXlCa/eEDnhQ25mxd4kaksEsyiJ+EX+h1+8UgF0YUWN50b8M4DwwS+ss3JT/1Be1g4VaOSOst/MuQumRV2wl6croTynJjdaZKDpKPOmGhHkcU8bZ4vD3z6IaBy1F0tkLMN2rg7LziC6CZ4qfYLtFJ4zqyXVAGspI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lNRTj5CO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18BA1C4CEEB;
	Fri,  9 May 2025 14:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746800231;
	bh=/PIseCcZUdjenlJfiK9ityerZ5vunYK2BIb4xzakXsY=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=lNRTj5COI1LxN5vFI2zoyMg5fRwlQKKh3fjA8VOUZUu5J+u3dBR8AwnlA2dm7UURL
	 olg1CYEwp94CDD3L6ZEA3Z+ujx98/8FsvRw8+bECKFZSxENdXq0S0RE5PXKxRtnmkr
	 pwbHE5a2PwrTPhEopzFF7hjcGmm52RVloMhH5Fk+ZgQnUH71hJWcH7CcySsLOgWeGP
	 Koj1/JE1dAequF97dxppbTjei2ZLWgxexZ/QP7odwZHvNE9D0FLmP7g+7UQGVUhTa8
	 ciEBi2niTEYug5BbnkyYJJ7JwBI6SuilUO1btJuB/OIIoHuf25RB1gg0rY91i82GL/
	 uOFkan+F91s7w==
Date: Fri, 09 May 2025 09:17:09 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org, 
 Larisa Grigore <Larisa.Grigore@nxp.com>, 
 Ciprian Marian Costea <ciprianmarian.costea@nxp.com>, 
 Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>, 
 linux-arm-kernel@lists.infradead.org, 
 "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>, arnd@linaro.org, 
 Dan Nica <dan.nica@nxp.com>, linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Stoica Cosmin-Stefan <cosmin.stoica@nxp.com>, 
 Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>, 
 NXP S32 Linux Team <s32@nxp.com>, dan.carpenter@linaro.org, 
 Andra-Teodora Ilie <andra.ilie@nxp.com>, 
 Xulin Sun <xulin.sun@windriver.com>, larisa.grigore@nxp.com, 
 Sascha Hauer <s.hauer@pengutronix.de>, andrei.stefanescu@nxp.com, 
 Marius Trifu <marius.trifu@nxp.com>, Chester Lin <chester62515@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Bogdan-Gabriel Roman <bogdan-gabriel.roman@nxp.com>, 
 Matthias Brugger <mbrugger@suse.com>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Shawn Guo <shawnguo@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Frank Li <Frank.Li@nxp.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>
To: James Clark <james.clark@linaro.org>
In-Reply-To: <20250509-james-nxp-spi-v1-0-32bfcd2fea11@linaro.org>
References: <20250509-james-nxp-spi-v1-0-32bfcd2fea11@linaro.org>
Message-Id: <174679985557.3369558.10881468523148413098.robh@kernel.org>
Subject: Re: [PATCH 00/14] spi: spi-fsl-dspi: DSPI support for NXP S32G
 platforms


On Fri, 09 May 2025 12:05:47 +0100, James Clark wrote:
> DT and driver changes for DSPI on S32G platforms. First 4 commits add
> new S32G registers and device settings along with restricting userspace
> register access properly for all devices. Then some DMA mode fixes along
> with adding support for target mode, which uses DMA. Followed by some
> other minor bug fixes and then finally add the DT compatibles and
> binding docs.
> 
> ---
> Andra-Teodora Ilie (1):
>       spi: spi-fsl-dspi: Enable modified transfer protocol
> 
> Bogdan-Gabriel Roman (1):
>       spi: spi-fsl-dspi: Halt the module after a new message transfer
> 
> Ciprian Marian Costea (2):
>       dt-bindings: spi: dspi: Add S32G support
>       spi: spi-fsl-dspi: Enable support for S32G platforms
> 
> James Clark (2):
>       spi: spi-fsl-dspi: Define regmaps per device
>       spi: spi-fsl-dspi: Re-use one volatile regmap for both device types
> 
> Larisa Grigore (7):
>       spi: spi-fsl-dspi: restrict register range for regmap access
>       spi: spi-fsl-dspi: Add config and regmaps for S32G platforms
>       spi: spi-fsl-dspi: Avoid setup_accel logic for DMA transfers
>       spi: spi-fsl-dspi: Reset SR flags before sending a new message
>       spi: spi-fsl-dspi: Use DMA for S32G controller in target mode
>       spi: spi-fsl-dspi: Reinitialize DSPI regs after resuming for S32G
>       arm64: dts: Add DSPI entries for S32G platforms
> 
> Marius Trifu (1):
>       spi: spi-fsl-dspi: Use spi_alloc_target for target
> 
>  .../devicetree/bindings/spi/fsl,dspi.yaml          |  18 ++
>  arch/arm64/boot/dts/freescale/s32g2.dtsi           |  78 +++++
>  arch/arm64/boot/dts/freescale/s32g3.dtsi           |  78 +++++
>  arch/arm64/boot/dts/freescale/s32gxxxa-evb.dtsi    |  87 +++++
>  arch/arm64/boot/dts/freescale/s32gxxxa-rdb.dtsi    |  77 +++++
>  drivers/spi/Kconfig                                |   4 +-
>  drivers/spi/spi-fsl-dspi.c                         | 356 +++++++++++++++------
>  7 files changed, 592 insertions(+), 106 deletions(-)
> ---
> base-commit: 9c69f88849045499e8ad114e5e13dbb3c85f4443
> change-id: 20250325-james-nxp-spi-caf1e2099231
> 
> Best regards,
> --
> James Clark <james.clark@linaro.org>
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
 Base: using specified base-commit 9c69f88849045499e8ad114e5e13dbb3c85f4443

If this is not the correct base, please add 'base-commit' tag
(or use b4 which does this automatically)

New warnings running 'make CHECK_DTBS=y for arch/arm64/boot/dts/freescale/' for 20250509-james-nxp-spi-v1-0-32bfcd2fea11@linaro.org:

arch/arm64/boot/dts/freescale/s32g399a-rdb3.dtb: pinctrl@4009c240 (nxp,s32g2-siul2-pinctrl): 'dspi1_pins', 'dspi5_pins' do not match any of the regexes: '-pins$', '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/pinctrl/nxp,s32g2-siul2-pinctrl.yaml#
arch/arm64/boot/dts/freescale/s32g274a-evb.dtb: pinctrl@4009c240 (nxp,s32g2-siul2-pinctrl): 'dspi1_pins', 'dspi5_pins' do not match any of the regexes: '-pins$', '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/pinctrl/nxp,s32g2-siul2-pinctrl.yaml#
arch/arm64/boot/dts/freescale/s32g274a-evb.dtb: spidev@0 (rohm,dh2228fv): 'fsl,spi-cs-sck-delay', 'fsl,spi-sck-cs-delay' do not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/trivial-devices.yaml#
arch/arm64/boot/dts/freescale/s32g274a-rdb2.dtb: pinctrl@4009c240 (nxp,s32g2-siul2-pinctrl): 'dspi1_pins', 'dspi5_pins' do not match any of the regexes: '-pins$', '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/pinctrl/nxp,s32g2-siul2-pinctrl.yaml#






