Return-Path: <linux-spi+bounces-8396-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A67AD2200
	for <lists+linux-spi@lfdr.de>; Mon,  9 Jun 2025 17:13:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 478FA3A1F33
	for <lists+linux-spi@lfdr.de>; Mon,  9 Jun 2025 15:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5156E72606;
	Mon,  9 Jun 2025 15:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JjEVpKPL"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7731A841A
	for <linux-spi@vger.kernel.org>; Mon,  9 Jun 2025 15:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749481699; cv=none; b=Tya9TNjV9OpF1H1RXC+jnGPofDRoPy45Cw28dIGRjcOFKEtS3M+ozOAaZOajKxNwBVwqxp7vr1iKbijRHdu3jiDTDQt7ovjRGI1rmSoM0fQl3O+HCHaNhRkDEA8OHvRkJzC990kgSri1JZxHtUctfjkFGGOdOGnO++Ax3ideTyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749481699; c=relaxed/simple;
	bh=9mFa0rp8B+5wNs/R5dyPySMEUZgssjrZ7l5QQ5LDHhU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=KkALslxUGA/9rp+2XTyON9jILlTCTvu0P4ihNrdFtSHPrD0MFSjWEgPAKqv8Zizc3BzBKiUY8M/2Z2zj1rI2MfCmoERqryosZHaxVH+bZO7KSV8wDC299Qm3lLdFGd3WHjwvd0GBijUec3toYmoXd5IMPmcB/d/VL5xxar5WlfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JjEVpKPL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0A41C4CEEB;
	Mon,  9 Jun 2025 15:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749481697;
	bh=9mFa0rp8B+5wNs/R5dyPySMEUZgssjrZ7l5QQ5LDHhU=;
	h=Subject:From:Date:To:From;
	b=JjEVpKPLAfPktuCHAKDok56aOUCJeLzxa9ZuApFeyRtotVsIHeLWr3hTCFX9IItdP
	 W9911jR6SEsx3a5eGEBQ8SMrEQG/owm/ctocbIiySh2+hg73D+hn3keQneDjkLUnhD
	 +5SMqGHzpin/GEbz8Db/F+292y3psdufMgkxE6iaSujzIfPbzSVMlCAj8qGJcxIGY4
	 VRnbMS/Se9eHZoLir6lc6duXveT7IQzTQYUT80fQgRew01eVfNlEqnWuiSkNYGc4Ws
	 x2VHWm3wqtcbmrNN3CwQ34FVoIYn+EQ/E4wIPoPPZdC0Kk6rLWC2RYdQsmI1RqI3Vz
	 zVJI//Z5BxM+g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7501F380DBE9;
	Mon,  9 Jun 2025 15:08:49 +0000 (UTC)
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
 <174948172792.1126847.9443962717566870401.git-patchwork-summary@kernel.org>
Date: Mon, 09 Jun 2025 15:08:47 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: ASoC: add Renesas MSIOF sound driver
  Submitter: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=954674
  Lore link: https://lore.kernel.org/r/871ptq4blr.wl-kuninori.morimoto.gx@renesas.com
    Patches: [v4,1/9] dt-bindings: renesas,sh-msiof: Add MSIOF I2S Sound support
             [v4,4/9] ASoC: renesas: rsnd: allow to use ADG as standalone
             [v4,5/9] ASoC: renesas: rsnd: care BRGA/BRGB select in rsnd_adg_clk_enable()
             [v4,6/9] ASoC: renesas: rsnd: enable to use "adg" clock
             [v4,7/9] ASoC: renesas: add MSIOF sound support
             [v4,9/9] arm64: defconfig: add Renesas MSIOF sound support

Patch: spi: loongson: Fix build warnings about export.h
  Submitter: Huacai Chen <chenhuacai@loongson.cn>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=969585
  Lore link: https://lore.kernel.org/r/20250608142939.172108-1-chenhuacai@loongson.cn

Patch: [next] spi: spi-pci1xxxx: Fix error code in probe
  Submitter: Dan Carpenter <dan.carpenter@linaro.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=969189
  Lore link: https://lore.kernel.org/r/aEKvDrUxD19GWi0u@stanley.mountain

Series: QPIC v2 fixes for SDX75
  Submitter: Md Sadre Alam <quic_mdalam@quicinc.com>
  Committer: Miquel Raynal <miquel.raynal@bootlin.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=951957
  Lore link: https://lore.kernel.org/r/20250410100019.2872271-1-quic_mdalam@quicinc.com
    Patches: [v4,1/3] mtd: rawnand: qcom: Pass 18 bit offset from NANDc base to BAM base
             [v4,2/3] mtd: rawnand: qcom: Fix last codeword read in qcom_param_page_type_exec()
             [v4,3/3] mtd: rawnand: qcom: Fix read len for onfi param page

Patch: dt-bindings: remove RZ/N1S bindings
  Submitter: Wolfram Sang <wsa+renesas@sang-engineering.com>
  Committer: Rob Herring (Arm) <robh@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=952624
  Lore link: https://lore.kernel.org/r/20250411194849.11067-2-wsa+renesas@sang-engineering.com

Patch: [1/1] spi: dt-bindings: mxs-spi: allow clocks properpty
  Submitter: Frank Li <Frank.Li@nxp.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=967165
  Lore link: https://lore.kernel.org/r/20250528222821.728544-1-Frank.Li@nxp.com

Patch: spi: spi-qpic-snand: use NANDC_STEP_SIZE consistently
  Submitter: Gabor Juhos <j4g8y7@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=966229
  Lore link: https://lore.kernel.org/r/20250525-qpic-snand-nandc_step_size-v1-1-6039e9bfe1c6@gmail.com

Series: [RESEND,1/3] spi: tegra210-quad: Add iommus property to DT bindings
  Submitter: Vishwaroop A <va@nvidia.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=960089
  Lore link: https://lore.kernel.org/r/20250506152350.3370291-1-va@nvidia.com
    Patches: [RESEND,1/3] spi: tegra210-quad: Add iommus property to DT bindings
             [RESEND,2/3] arm64: tegra: Configure QSPI clocks and add DMA

Patch: spi: spi-qpic-snand: remove 'qpic_snand_op' structure
  Submitter: Gabor Juhos <j4g8y7@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=967403
  Lore link: https://lore.kernel.org/r/20250529-qpic-snand-remove-qpic_snand_op-v1-1-6e42b772d748@gmail.com

Series: Add basic SPI support for SG2042 SoC
  Submitter: Zixian Zeng <sycamoremoon376@gmail.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=950358
  Lore link: https://lore.kernel.org/r/20250407-sfg-spi-v4-0-30ac949a1e35@gmail.com
    Patches: [v4,1/2] spi: dt-bindings: snps,dw-apb-ssi: Add compatible for SOPHGO SG2042 SoC
             [v4,2/2] riscv: sophgo: dts: Add spi controller for SG2042

Series: Add basic SPI support for SOPHGO SG2042 SoC
  Submitter: Zixian Zeng <sycamoremoon376@gmail.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=956817
  Lore link: https://lore.kernel.org/r/20250425-sfg-spi-v6-0-2dbe7bb46013@gmail.com
    Patches: [v6,1/3] spi: dt-bindings: snps,dw-apb-ssi: Merge duplicate compatible entry
             [v6,3/3] riscv: sophgo: dts: Add spi controller for SG2042

Series: reset: Add devm_reset_control_array_get_exclusive_released()
  Submitter: Patrice CHOTARD <patrice.chotard@foss.st.com>
  Committer: Philipp Zabel <p.zabel@pengutronix.de>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=952506
  Lore link: https://lore.kernel.org/r/20250411-b4-upstream_ospi_reset_update-v2-0-4de7f5dd2a91@foss.st.com
    Patches: [v2,1/2] reset: Add devm_reset_control_array_get_exclusive_released()

Patch: Add support for SAMA7D65
  Submitter: Ryan Wanner <Ryan.Wanner@microchip.com>
  Committer: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=959147
  Lore link: https://lore.kernel.org/r/cover.1746201835.git.Ryan.Wanner@microchip.com

Patch: [v1,for-next] spi: spi-pci1xxxx: Add support for 25MHz Clock frequency in C0
  Submitter: Thangaraj Samynathan <thangaraj.s@microchip.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=966393
  Lore link: https://lore.kernel.org/r/20250526104908.404564-1-thangaraj.s@microchip.com


Total patches: 24

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



