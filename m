Return-Path: <linux-spi+bounces-10822-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB94C06699
	for <lists+linux-spi@lfdr.de>; Fri, 24 Oct 2025 15:12:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C3213A3491
	for <lists+linux-spi@lfdr.de>; Fri, 24 Oct 2025 13:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DCB430F530;
	Fri, 24 Oct 2025 13:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hyYgdGIi"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7437031A055;
	Fri, 24 Oct 2025 13:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761311344; cv=none; b=LvmVffu8JR5GbKTukxBWqRfWQ8wY6oiguSukapfgA9yDV90YF9LAukMZ/ESIL2vhv8ocsQ/mDX8ZHQZwZOQhbr+2/6Ahl7TVkotexqdyXJsRQ21Un3qanhpGNKvs0JTR+KptjgmGq3y/j7NhGRC3UWHUMz8vV7+mP1llopNAupE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761311344; c=relaxed/simple;
	bh=9WNMNzy5xJmKDKCglHVkdCBSRkjOhFSXEZykVzhqUsE=;
	h=Message-ID:From:To:Cc:Subject:Date; b=r/ogL+zZ/wMdahRhAHniFAFFSuh9FQDhN/91MvPFp3I2q688ttWW5jrRuJyWrw8EZfm+vmHDMdRURwe0dr8QMufBZdUv19RD9235CSLf4mt/url71zSNBeeXjEv56lZfKeAgHRcJI+I46qupBAjQXdDRxRmHk4qHX/xYczF9Fas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hyYgdGIi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7AC7C4CEF1;
	Fri, 24 Oct 2025 13:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761311344;
	bh=9WNMNzy5xJmKDKCglHVkdCBSRkjOhFSXEZykVzhqUsE=;
	h=From:To:Cc:Subject:Date:From;
	b=hyYgdGIisq0qQDMJS5V1gLkrQ8PnYhH41lr2vZapX+6Os+UDVyU+l9NUt33y//Hbg
	 9D+YtBGNrDLbo1AIAjaLOe223SWFyYBh2Eidcq5m+Du7zS+cXp5x9YQ+v5T/OzJl0J
	 sB91z51KzIZpLpBpH5q7iLEDcwcX4ySvfoQNhYZ1SE7CLqXiAySmYzFxUVEdnI8DV5
	 qR78zpJMieZpv8Wd0FHp3ctVHNrxrpdMfmJUOzqb1b4Lqt457f8wD4iXjm3LXbH37+
	 bgjcX/bNNZWIHKgm6PYrxhlEB9tSX9UkkDGPpf3MHc6jffeTxtDCOzC8//267ySG7m
	 a65mPC2kdnWlQ==
Message-ID: <91559e62fdaf7b56c4a1bf9c30ea9e2a@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v6.18-rc2
Date: Fri, 24 Oct 2025 14:08:41 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The following changes since commit 3a8660878839faadb4f1a6dd72c3179c1df56787:

  Linux 6.18-rc1 (2025-10-12 13:42:36 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.18-rc2

for you to fetch changes up to 1b824134261d2db08fb6583ccbd05cb71861bd53:

  spi: dt-bindings: spi-rockchip: Add RK3506 compatible (2025-10-22 15:00:29 +0100)

----------------------------------------------------------------
spi: Fixes for v6.18

A moderately large collection of device specific changes here, mostly
fixes but also including a few new quirks and device IDs.  This is all
fairly routine even for the affected devices.

----------------------------------------------------------------
Artem Shimko (1):
      spi: dw-mmio: add error handling for reset_control_deassert()

Conor Dooley (1):
      spi: dt-bindings: cadence: add soc-specific compatible strings for zynqmp and versal-net

Haibo Chen (2):
      spi: spi-nxp-fspi: re-config the clock rate when operation require new clock rate
      spi: spi-nxp-fspi: limit the clock rate for different sample clock source selection

Han Xu (1):
      spi: spi-nxp-fspi: add extra delay after dll locked

Heiko Stuebner (1):
      spi: dt-bindings: spi-rockchip: Add RK3506 compatible

Marek Szyprowski (1):
      spi: rockchip-sfc: Fix DMA-API usage

Mark Brown (2):
      spi: Merge up v6.18-rc1
      spi: spi-nxp-fspi: few fix for flexspi

Mattijs Korpershoek (1):
      spi: cadence-quadspi: Fix pm_runtime unbalance on dma EPROBE_DEFER

Mika Westerberg (3):
      spi: intel: Add support for 128M component density
      spi: intel-pci: Add support for Arrow Lake-H SPI serial flash
      spi: intel-pci: Add support for Intel Wildcat Lake SPI serial flash

Mikhail Kshevetskiy (4):
      spi: airoha: return an error for continuous mode dirmap creation cases
      spi: airoha: add support of dual/quad wires spi modes to exec_op() handler
      spi: airoha: switch back to non-dma mode in the case of error
      spi: airoha: fix reading/writing of flashes with more than one plane per lun

Xianwei Zhao (1):
      spi: amlogic: fix spifc build error

 .../devicetree/bindings/spi/spi-cadence.yaml       |  11 +-
 .../devicetree/bindings/spi/spi-rockchip.yaml      |   1 +
 drivers/spi/spi-airoha-snfi.c                      | 128 ++++++++++++++++-----
 drivers/spi/spi-amlogic-spifc-a4.c                 |   4 +-
 drivers/spi/spi-cadence-quadspi.c                  |   5 +-
 drivers/spi/spi-dw-mmio.c                          |   4 +-
 drivers/spi/spi-intel-pci.c                        |   2 +
 drivers/spi/spi-intel.c                            |   6 +
 drivers/spi/spi-nxp-fspi.c                         |  32 +++++-
 drivers/spi/spi-rockchip-sfc.c                     |  12 +-
 10 files changed, 160 insertions(+), 45 deletions(-)

