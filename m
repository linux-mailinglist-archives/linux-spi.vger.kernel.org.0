Return-Path: <linux-spi+bounces-11908-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC05CBE4ED
	for <lists+linux-spi@lfdr.de>; Mon, 15 Dec 2025 15:36:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 75A0E30115D8
	for <lists+linux-spi@lfdr.de>; Mon, 15 Dec 2025 14:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8DC28000A;
	Mon, 15 Dec 2025 14:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cqu/yXlz"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AB623EAB3
	for <linux-spi@vger.kernel.org>; Mon, 15 Dec 2025 14:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765809317; cv=none; b=eMxFWJefJevabgew95rnZe4h1I5B8q06dZQkX7u07lQ9Cs+WRLBw2YasnYSOPrRFo8j2iO6jGcNLv27TSHNGIcSXpEHyQgKSgrNWTi3UouJj8t1f7+auuMa9ck1SKeezKtsLcyBxmpWJPtjmfE/0uWwvgv0zssiuCPUWXOu8xKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765809317; c=relaxed/simple;
	bh=BW5HgqS+lsqT2bkA4kzv0rDnFw+IJOV+cYNcsROkFvE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=bCcZWkcS5CioDu9BPELAA+95YdfabaFune6Io5xObe+djuZ3zgah/LTkxzAuKZvo3xjP0nD1e1D/G+dVXt44ajuCkEt4kutqjVIaUK5Y+uM79a/H9WFxpbz5Whs1c6+VabhrfWJa4IFQH0kdxO/+AxfOCJWYyKZknP5bNm/dJlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cqu/yXlz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D68CC4CEF5;
	Mon, 15 Dec 2025 14:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765809317;
	bh=BW5HgqS+lsqT2bkA4kzv0rDnFw+IJOV+cYNcsROkFvE=;
	h=Subject:From:Date:To:From;
	b=cqu/yXlzBk20MNSGCrO4Fh8E3jPbriIQmbbowDu8RY4WeHbF4sxUUJ0KDukOyCPdl
	 MeRCaSOY+7iCoseX7INZQg6Rz1gUX7MZJMB911yFYik+jM2TRVSZnWFivg8MWu0O2f
	 vJnUok8itkcXjkEEWpuiBuKsldlVJl3h1dIVASbtaDH+e03otZsfI3UIDCxjY4Vl4C
	 S5se554Yh7j28WlMgfODAEHjCraisA7WbUlnUaJhXQ2SwR1T31WrNG3sYPgJ4IR5Ax
	 cFTLftJOiOSyMkSWs4mygrzTbD+CutpQLR76G/ySH311TXzeqcjv20oAzPdfYI0IJC
	 BsPWwdyDboqPA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0ABF380AA77;
	Mon, 15 Dec 2025 14:32:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From: patchwork-bot+spi-devel-general@kernel.org
Message-Id: 
 <176580912841.4066817.6393660081984740416.git-patchwork-summary@kernel.org>
Date: Mon, 15 Dec 2025 14:32:08 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: stm32: Update for OSPI and QSPI drivers
  Submitter: Patrice Chotard <patrice.chotard@foss.st.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1031284
  Lore link: https://lore.kernel.org/r/20251208-upstream_qspi_ospi_updates-v2-0-62526c9467dc@foss.st.com
    Patches: [v2,1/8] spi: stm32-ospi: Set DMA maxburst dynamically
             [v2,2/8] spi: stm32-ospi: Optimize FIFO accesses using u16 or u32
             [v2,3/8] spi: stm32-ospi: Remove CR_TCIE and CR_TEIE irq usage
             [v2,4/8] spi: stm32-ospi: Simplify SMIE interrupt test
             [v2,5/8] spi: stm32-qspi: Set DMA maxburst dynamically
             [v2,6/8] spi: stm32-qspi: Optimize FIFO accesses using u16 or u32
             [v2,7/8] spi: stm32-qspi: Remove CR_TCIE and CR_TEIE irq usage
             [v2,8/8] spi: stm32-qspi: Simplify SMIE interrupt test

Series: Align availability checks on fwnode child node enumeration
  Submitter: Sakari Ailus <sakari.ailus@linux.intel.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1005537
  Lore link: https://lore.kernel.org/r/20250924074602.266292-1-sakari.ailus@linux.intel.com
    Patches: [v2,01/16] ACPI: property: Make acpi_get_next_subnode() static
             [v2,02/16] ACPI: property: Use ACPI functions in acpi_graph_get_next_endpoint() only
             [v2,13/16] leds: Use fwnode_for_each_child_node() instead
             [v2,14/16] leds: Use fwnode_get_next_child_node() instead

Series: reset: rework reset-gpios handling
  Submitter: Bartosz Golaszewski <brgl@bgdev.pl>
  Committer: Philipp Zabel <p.zabel@pengutronix.de>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1025826
  Lore link: https://lore.kernel.org/r/20251120-reset-gpios-swnodes-v7-0-a100493a0f4b@linaro.org
    Patches: [v7,1/9] software node: read the reference args via the fwnode API
             [v7,2/9] software node: increase the reference of the swnode by its fwnode
             [v7,3/9] software node: allow referencing firmware nodes
             [v7,4/9] spi: cs42l43: Use actual ACPI firmware node for chip selects
             [v7,5/9] gpio: swnode: allow referencing GPIO chips by firmware nodes
             [v7,6/9] reset: order includes alphabetically in reset/core.c
             [v7,7/9] reset: make the provider of reset-gpios the parent of the reset device
             [v7,8/9] reset: gpio: convert the driver to using the auxiliary bus
             [v7,9/9] reset: gpio: use software nodes to setup the GPIO lookup

Patch: spi: spi-qpic-snand: remove superfluous qcom_spi_set_read_loc() calls
  Submitter: Gabor Juhos <j4g8y7@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1028857
  Lore link: https://lore.kernel.org/r/20251129-qpic-snand-superfluous-readloc-v1-1-b84ca17095d9@gmail.com

Series: [1/5] spi-geni-qcom: remove manual CS control
  Submitter: Jonathan Marek <jonathan@marek.ca>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1026026
  Lore link: https://lore.kernel.org/r/20251120211204.24078-1-jonathan@marek.ca
    Patches: [1/5] spi-geni-qcom: remove manual CS control
             [2/5] spi-geni-qcom: don't set max clock in setup_fifo_params
             [3/5] spi-geni-qcom: use xfer->bits_per_word for can_dma()
             [4/5] spi-geni-qcom: initialize mode related registers to 0
             [5/5] spi-geni-qcom: rework setup_fifo_params

Series: Support ECSPI dynamic burst feature for DMA mode
  Submitter: Carlos Song <carlos.song@nxp.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1030032
  Lore link: https://lore.kernel.org/r/20251203085949.2922166-1-carlos.song@nxp.com
    Patches: [v3,1/6] spi: imx: group spi_imx_dma_configure() with spi_imx_dma_transfer()
             [v3,2/6] spi: imx: introduce helper to clear DMA mode logic
             [v3,3/6] spi: imx: avoid dmaengine_terminate_all() on TX prep failure
             [v3,4/6] spi: imx: handle DMA submission errors with dma_submit_error()
             [v3,5/6] spi: imx: support dynamic burst length for ECSPI DMA mode
             [v3,6/6] spi: imx: enable DMA mode for target operation

Patch: spi: virtio: Fix confusing cleanup.h syntax
  Submitter: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1031230
  Lore link: https://lore.kernel.org/r/20251208020830.5225-2-krzysztof.kozlowski@oss.qualcomm.com

Series: Add DMA support for RZ/T2H RSPI
  Submitter: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1029315
  Lore link: https://lore.kernel.org/r/20251201134229.600817-1-cosmin-gabriel.tanislav.xa@renesas.com
    Patches: [01/13] spi: rzv2h-rspi: fix rzv2h_rspi_transfer_one() indentation
             [02/13] spi: rzv2h-rspi: remove call to spi_finalize_current_transfer()
             [03/13] spi: rzv2h-rspi: do not set SPI_TRANS_FAIL_IO
             [04/13] spi: rzv2h-rspi: use device-managed APIs
             [05/13] spi: rzv2h-rspi: store RX interrupt in state
             [06/13] spi: rzv2h-rspi: set MUST_RX/MUST_TX
             [07/13] spi: rzv2h-rspi: set TX FIFO threshold to 0
             [08/13] spi: rzv2h-rspi: enable TX buffer empty interrupt
             [09/13] spi: rzv2h-rspi: split out PIO transfer
             [10/13] dt-bindings: spi: renesas,rzv2h-rspi: document optional support for DMA
             [11/13] spi: rzv2h-rspi: add support for DMA mode

Patch: [v3] spi: spi-fsl-lpspi: convert min_t() to simple min()
  Submitter: Carlos Song <carlos.song@nxp.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1031963
  Lore link: https://lore.kernel.org/r/20251210105001.3891776-1-carlos.song@nxp.com

Patch: [v2] spi: fsl-cpm: Check length parity before switching to 16 bit mode
  Submitter: Christophe Leroy <christophe.leroy@csgroup.eu>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1025713
  Lore link: https://lore.kernel.org/r/3c4d81c3923c93f95ec56702a454744a4bad3cfc.1763627618.git.christophe.leroy@csgroup.eu

Series: spi: enable the SpacemiT K1 SoC QSPI
  Submitter: Alex Elder <elder@riscstar.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1016282
  Lore link: https://lore.kernel.org/r/20251027133008.360237-1-elder@riscstar.com
    Patches: [v4,1/9] dt-bindings: spi: fsl-qspi: support SpacemiT K1
             [v4,8/9] riscv: dts: spacemit: enable K1 SoC QSPI on BPI-F3

Patch: spi: cadence-qspi: Remove redundant pm_runtime_mark_last_busy call
  Submitter: Akif Ejaz <akifejaz40@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1030199
  Lore link: https://lore.kernel.org/r/20251203181921.97171-1-akifejaz40@gmail.com

Patch: [GIT,PULL] Reset/GPIO/swnode changes for v6.19
  Submitter: Philipp Zabel <p.zabel@pengutronix.de>
  Committer: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1025926
  Lore link: https://lore.kernel.org/r/20251120163252.34760-1-p.zabel@pengutronix.de

Patch: [v1,1/1] spi: cadence-xspi: Replace ACPI specifics by agnostic APIs
  Submitter: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1028899
  Lore link: https://lore.kernel.org/r/20251129151739.3998668-1-andriy.shevchenko@linux.intel.com

Patch: [v2] spi: cadence-quadspi: Parse DT for flashes with the rest of the DT parsing
  Submitter: Mark Brown <broonie@kernel.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1030570
  Lore link: https://lore.kernel.org/r/20251204-spi-cadence-qspi-runtime-pm-imbalance-v2-1-10af9115d531@kernel.org

Series: spi-cadence: support transmission with bits_per_word of 16 and 32
  Submitter: Jun Guo <jun.guo@cixtech.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1018037
  Lore link: https://lore.kernel.org/r/20251031073003.3289573-1-jun.guo@cixtech.com
    Patches: [v3,1/3] dt-bindings: spi: spi-cadence: update DT binding docs to support cix sky1 SoC
             [v3,3/3] arm64: dts: cix: add a compatible string for the cix sky1 SoC

Patch: spi: mpfs: Fix an error handling path in mpfs_spi_probe()
  Submitter: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1032829
  Lore link: https://lore.kernel.org/r/eb35f168517cc402ef7e78f26da02863e2f45c03.1765612110.git.christophe.jaillet@wanadoo.fr

Patch: [v1,1/1] spi: cadence-xspi: Replace OF/ACPI specifics by agnostic APIs
  Submitter: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1028898
  Lore link: https://lore.kernel.org/r/20251129150704.3998301-1-andriy.shevchenko@linux.intel.com

Series: [1/5] usb: misc: ljca: Remove Wentong's e-mail address
  Submitter: Sakari Ailus <sakari.ailus@linux.intel.com>
  Committer: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1004874
  Lore link: https://lore.kernel.org/r/20250922120632.10460-1-sakari.ailus@linux.intel.com
    Patches: [1/5] usb: misc: ljca: Remove Wentong's e-mail address


Total patches: 58

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



