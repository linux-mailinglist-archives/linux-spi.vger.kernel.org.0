Return-Path: <linux-spi+bounces-6160-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB679FC081
	for <lists+linux-spi@lfdr.de>; Tue, 24 Dec 2024 18:06:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D91CA164F6F
	for <lists+linux-spi@lfdr.de>; Tue, 24 Dec 2024 17:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 240DF1D89E5;
	Tue, 24 Dec 2024 17:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ji12gTav"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CD41C4A24;
	Tue, 24 Dec 2024 17:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735059994; cv=none; b=IEdcpPI0nWsLFk/KdeEkAxaYnd4L+gcvrdhuzSsuQkilL88MIvYYeWcFs+54++C5tTq/gHny8nhxY0oEtyrGBSuphKI2QqWvuYY8YG2ljTgMcOBUHAlAwoviN7eD1Nt32uqdn/R5ESz5M+u/6/tXRQ1M6ogEUzUb6cMMVF3ywXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735059994; c=relaxed/simple;
	bh=Kk5h4cnnOsYNuUBFGJHNCgTfRRlkJVKs1n7IQTVr72A=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=B54onaBBam6sCbNBDWP5ScTs9MbfpnnZS2VsZ+tlfm8cOsDBHWKDOLfQKAkPRvaKXQjkmox//cVfFSPrOdwYigRc+Ulc9WYfEbmiqqvyFF/cHekPfgmubVqX8c3IYR0Bv7GOax/8Ry6a/9CQP/QmUl2x6QTHdGXZc38Czrf3Kv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ji12gTav; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7712C40004;
	Tue, 24 Dec 2024 17:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1735059983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=r/Gn3c6Z2+oOxsTlq15aX44iSBF2ngtpY5A8qzg8rVM=;
	b=ji12gTaveVn1lCP9UvPR+lkewDUv8CjCn0LOn5zGo0v79llUFWB6v2y+102nr1zl6n9jBC
	0clzBYCG3ZysNzwaHVFSlmYUHUiVmLTmNEocUe48zTa0Vz5JtEW8Pf44pvyi7zbtozvv2r
	LzXmlzO4kxANnZVsIvaWHRuRro9pdTSe3WVI7xKA/gaJHGhedzr0uVbu+2qROKMI4a7sNz
	ADkmUKNe+kuhpOajUlCu0MaTzP+u+fssGUgj80ySYyhqmKQYNQnF0BYJiEkzRX8EaQS0AP
	vW8Yiwy5rO5E+wjkrkXA3jg7McS1I4rk4AsLkRIAv6CgT6vbd7JEjJeycg4/Wg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v2 00/27] spi-nand/spi-mem DTR support
Date: Tue, 24 Dec 2024 18:05:45 +0100
Message-Id: <20241224-winbond-6-11-rc1-quad-support-v2-0-ad218dbc406f@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOnpamcC/yXNyw6DIBCF4VcxrDuGmYAxXfU9GheotE6ioOClx
 vjupXb5ncV/DhFtYBvFPTtEsCtH9i6BbploOuPeFrhNFiRJIaGEjV3tXQsFIEJoEKbFtBCXcfR
 hBomqJKkNoSGRGmOwL/5c/WeV3HGcfdivuxV/678sSWOBWmKuSl2UChAGnhbb58HszvSP2vu5Z
 5c3fhDVeZ5f4IGW6LkAAAA=
X-Change-ID: 20241210-winbond-6-11-rc1-quad-support-0148205a21a2
To: Mark Brown <broonie@kernel.org>, Sanjay R Mehta <sanju.mehta@amd.com>, 
 Serge Semin <fancer.lancer@gmail.com>, Han Xu <han.xu@nxp.com>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Daire McNamara <daire.mcnamara@microchip.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Haibo Chen <haibo.chen@nxp.com>, Yogesh Gaur <yogeshgaur.83@gmail.com>, 
 Heiko Stuebner <heiko@sntech.de>, Michal Simek <michal.simek@amd.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Jacky Huang <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>, 
 Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Avi Fishman <avifishman70@gmail.com>, Tomer Maimon <tmaimon77@gmail.com>, 
 Tali Perry <tali.perry1@gmail.com>, Patrick Venture <venture@google.com>, 
 Nancy Yuen <yuenn@google.com>, Benjamin Fair <benjaminfair@google.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Raju Rangoju <Raju.Rangoju@amd.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Steam Lin <stlin2@winbond.com>, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-mtd@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
 openbmc@lists.ozlabs.org, linux-stm32@st-md-mailman.stormreply.com, 
 Pratyush Yadav <pratyush@kernel.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, stable+noautosel@kernel.org
X-Mailer: b4 0.15-dev
X-GND-Sasl: miquel.raynal@bootlin.com

Hello Mark, hello MTD folks,

Here is a (big) series supposed to bring DTR support in SPI-NAND.

I could have split this into two but I eventually preferred showing the
big picture. Once v1 will be over, I can make it two. However when we'll
discuss merging, we'll have to share an immutable tag among the two
subsystems.

Here is the logic:
* patches 1 & 2 add support for spi-mem operations with a specific
  frequency limitation. This is not only related to DTR support, because
  as you can see I could use this to support basic features in the
  Winbond driver.
* patches 3-17 are going through all the easy controller drivers, where
  effectively supporting these per-operation limitation was easy to
  do. In practice, I believe all controllers can, but software is
  sometimes the limiting factor. All controllers without spi-mem support
  will gracefully handle the request (provided that they already care
  about the maximum speed of course), and all the updated controllers in
  this series will also handle the situation correctly. For the others,
  it's an opt-in parameter, so they will simply refuse the operation
  during the checks_op/supports_op() phase.
* patches 18-20 add DTR support in spi-mem.
* patches 21-24 add DTR support in SPI-NAND.
* patches 25-27 add DTR support to Winbon chips.

---
Changes in v2:
- Fixed breakage reported by Mark.
- Created an "adjust_op_freq" helper in the core and used it from
  spi_mem_exec_op(). This way it is called only once. The main parameter
  must still be casted otherwise we would need to do the call outside of
  spi_mem_exec_op() which would imply about 40 different changes in the
  core and drivers and also the assurance that we would get it wrong
  again later.
- Reworked the logic for picking the best variant to include all
  subtleties due to maximum/supported frequencies. The choice takes
  slightly longer now but should return the truly fastest variant for
  each case.
- Removed unique parenthesis in some kdoc comment.
- Fixed the inconsistency when handling the maximum per operation
  frequencies between spi-mem and non spi-mem controllers.
- Fixed many typos.
- Added a core check to validate the per op frequency against the minimum
  supported frequencies by controller drivers.
- Removed a useless check from the amd driver and turned a function
  void. Also used the controller parameters in this driver rather than
  the top-level definitions.
- Clarified some of the commit logs.
- Collected tags.
- Prevented a patch from being picked-up automatically by the stable
  team.
- Reordered some terms in macros in the spi-mem core.
- Rebased on top of v6.13-rc1.
- Link to v1: https://lore.kernel.org/r/20241025161501.485684-1-miquel.raynal@bootlin.com

---
Miquel Raynal (27):
      spi: spi-mem: Extend spi-mem operations with a per-operation maximum frequency
      spi: spi-mem: Add a new controller capability
      spi: amd: Support per spi-mem operation frequency switches
      spi: amd: Drop redundant check
      spi: amlogic-spifc-a1: Support per spi-mem operation frequency switches
      spi: cadence-qspi: Support per spi-mem operation frequency switches
      spi: dw: Support per spi-mem operation frequency switches
      spi: fsl-qspi: Support per spi-mem operation frequency switches
      spi: microchip-core-qspi: Support per spi-mem operation frequency switches
      spi: mt65xx: Support per spi-mem operation frequency switches
      spi: mxic: Support per spi-mem operation frequency switches
      spi: nxp-fspi: Support per spi-mem operation frequency switches
      spi: rockchip-sfc: Support per spi-mem operation frequency switches
      spi: spi-sn-f-ospi: Support per spi-mem operation frequency switches
      spi: spi-ti-qspi: Support per spi-mem operation frequency switches
      spi: zynq-qspi: Support per spi-mem operation frequency switches
      spi: zynqmp-gqspi: Support per spi-mem operation frequency switches
      spi: spi-mem: Reorder spi-mem macro assignments
      spi: spi-mem: Create macros for DTR operation
      spi: spi-mem: Estimate the time taken by operations
      mtd: spinand: Create distinct fast and slow read from cache variants
      mtd: spinand: Add an optional frequency to read from cache macros
      mtd: spinand: Enhance the logic when picking a variant
      mtd: spinand: Add support for read DTR operations
      mtd: spinand: winbond: Update the *JW chip definitions
      mtd: spinand: winbond: Add comment about naming
      mtd: spinand: winbond: Add support for DTR operations

 drivers/mtd/nand/spi/alliancememory.c |  4 +--
 drivers/mtd/nand/spi/ato.c            |  4 +--
 drivers/mtd/nand/spi/core.c           | 15 ++++++--
 drivers/mtd/nand/spi/esmt.c           |  4 +--
 drivers/mtd/nand/spi/foresee.c        |  4 +--
 drivers/mtd/nand/spi/gigadevice.c     | 16 ++++-----
 drivers/mtd/nand/spi/macronix.c       |  4 +--
 drivers/mtd/nand/spi/micron.c         |  8 ++---
 drivers/mtd/nand/spi/paragon.c        |  4 +--
 drivers/mtd/nand/spi/toshiba.c        |  4 +--
 drivers/mtd/nand/spi/winbond.c        | 27 ++++++++++++---
 drivers/mtd/nand/spi/xtx.c            |  4 +--
 drivers/spi/spi-amd.c                 | 21 ++++++------
 drivers/spi/spi-amlogic-spifc-a1.c    |  7 +++-
 drivers/spi/spi-cadence-quadspi.c     |  3 +-
 drivers/spi/spi-dw-core.c             | 10 ++++--
 drivers/spi/spi-fsl-qspi.c            | 12 +++++--
 drivers/spi/spi-mem.c                 | 64 +++++++++++++++++++++++++++++++++++
 drivers/spi/spi-microchip-core-qspi.c | 26 +++++++++++---
 drivers/spi/spi-mt65xx.c              |  7 +++-
 drivers/spi/spi-mxic.c                |  3 +-
 drivers/spi/spi-nxp-fspi.c            | 12 +++++--
 drivers/spi/spi-rockchip-sfc.c        | 11 ++++--
 drivers/spi/spi-sn-f-ospi.c           |  8 +++--
 drivers/spi/spi-ti-qspi.c             |  7 +++-
 drivers/spi/spi-zynq-qspi.c           | 13 +++++--
 drivers/spi/spi-zynqmp-gqspi.c        | 13 ++++---
 include/linux/mtd/spinand.h           | 58 ++++++++++++++++++++++++++++---
 include/linux/spi/spi-mem.h           | 56 +++++++++++++++++++++++++++++-
 29 files changed, 349 insertions(+), 80 deletions(-)
---
base-commit: 9100187b36091e5cc046d1f415f50a04ec31c25f
change-id: 20241210-winbond-6-11-rc1-quad-support-0148205a21a2

Best regards,
-- 
Miquel Raynal <miquel.raynal@bootlin.com>


