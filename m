Return-Path: <linux-spi+bounces-5468-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B8A9B097A
	for <lists+linux-spi@lfdr.de>; Fri, 25 Oct 2024 18:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94C30284483
	for <lists+linux-spi@lfdr.de>; Fri, 25 Oct 2024 16:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CFA21D14FC;
	Fri, 25 Oct 2024 16:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="E8qFeGtu"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025331FB88B
	for <linux-spi@vger.kernel.org>; Fri, 25 Oct 2024 16:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729872908; cv=none; b=hN2qO9FXxTX+fRL3rKZ+YUu30kPpIkQ8w54QoKkT1xgJDSsx3c3cFWpQvoL7ERuprSLUbneEBbTCuanto1I0h2ViDpJw8zzRUZX+e67pX5XS2v9u9qD9+1dnrS/uqrBvb1IiKJ9gTgEPU3qZ3yP+E6VTK58gn/6S3iNwSwfUKv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729872908; c=relaxed/simple;
	bh=H42rK0lz4mVQzry0EAMBBAoDPCHaWbY1WKWWtbYOWow=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=N9aM8UV7kHwt2EV4tdBK9AiOT9YDhuIC5CZOqQDFLEzbDWUeIUPizsRT8kl4Rz6LAhNIWcbvPZhJuiGDNOerrngTmI3zEoYdyttWf831G4dyPO37cUryuZkT/2Jt6XdI/L9MXf49oX+7vxhP6iqYS6ufHnk5RwLLQYHCZUzT8Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=E8qFeGtu; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D2839E0004;
	Fri, 25 Oct 2024 16:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1729872904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/X3AgxqIhjMfS5rto4yq5EfvdDpAoHLw7VDDc2xoiJQ=;
	b=E8qFeGtuRS2zWi/3K6VnsIH7nlWU0UiBdbLRN31umPxMjy7mLE2nz0ulstBTkFyYJH+X12
	yoLM/QgFRIMLJZB/QzifpMO6u1pypLF6jgMDkqlBiGVHfm75wWy6VSgL1SrneyNtwtI2ia
	VTRMvXgUeldqESFWv2mqkVBGYKf8DSrVBgt454tTh3mDd+hHBOnlMJyp34DB5JltKmfvMd
	Q3QiY2XpkvGBVuwadZr0eosD9TJfexNiWOUPtivclLYI9KBLJlu5tbqh6RtO/HCJ4SBY1r
	4ARxAD6fDJQd3ISpi4fgn5/+spxiJSun/ECSQ0kLpgq17/aeAsFl1cGjlYXwww==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <michael@walle.cc>,
	<linux-mtd@lists.infradead.org>
Cc: Mark Brown <broonie@kernel.org>,
	<linux-spi@vger.kernel.org>,
	Steam Lin <stlin2@winbond.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Sanjay R Mehta <sanju.mehta@amd.com>,
	Han Xu <han.xu@nxp.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Haibo Chen <haibo.chen@nxp.com>,
	Yogesh Gaur <yogeshgaur.83@gmail.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Michal Simek <michal.simek@amd.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 00/24] spi-nand/spi-mem DTR support
Date: Fri, 25 Oct 2024 18:14:37 +0200
Message-ID: <20241025161501.485684-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
* patches 3-16 are going through all the easy controller drivers, where
  effectively supporting these per-operation limitation was easy to
  do. In practice, I believe all controllers can, but software is
  sometimes the limiting factor. All controllers without spi-mem support
  will gracefully handle the request (provided that they already care
  about the maximum speed of course), and all the updated controllers in
  this series will also handle the situation correctly. For the others,
  it's an opt-in parameter, so they will simply refuse the operation
  during the checks_op/supports_op() phase.
* patches 17-19 make use of this new possibility to fix Winbond support
* patches 20-24 are actually adding DTR support in SPI-NAND, and making
  this feature useful with Winbond chips.

Thanks,
Miquèl

Miquel Raynal (24):
  spi: spi-mem: Extend spi-mem operations with a per-operation maximum
    frequency
  spi: spi-mem: Add a new controller capability
  spi: amd: Support per spi-mem operation frequency switches
  spi: amlogic-spifc-a1: Support per spi-mem operation frequency
    switches
  spi: cadence-qspi: Support per spi-mem operation frequency switches
  spi: dw: Support per spi-mem operation frequency switches
  spi: fsl-qspi: Support per spi-mem operation frequency switches
  spi: microchip-core-qspi: Support per spi-mem operation frequency
    switches
  spi: mt65xx: Support per spi-mem operation frequency switches
  spi: mxic: Support per spi-mem operation frequency switches
  spi: nxp-fspi: Support per spi-mem operation frequency switches
  spi: rockchip-sfc: Support per spi-mem operation frequency switches
  spi: spi-sn-f-ospi: Support per spi-mem operation frequency switches
  spi: spi-ti-qspi: Support per spi-mem operation frequency switches
  spi: zynq-qspi: Support per spi-mem operation frequency switches
  spi: zynqmp-gqspi: Support per spi-mem operation frequency switches
  mtd: spinand: Create distinct fast and slow read from cache variants
  mtd: spinand: Add an optional frequency to read from cache macros
  mtd: spinand: winbond: Fix the *JW chip definitions
  spi: spi-mem: Reorder SPI_MEM_OP_CMD internals
  spi: spi-mem: Create macros for DTR operation
  mtd: spinand: Add support for read DTR operations
  mtd: spinand: winbond: Add comment about naming
  mtd: spinand: winbond: Add support for DTR operations

 drivers/mtd/nand/spi/alliancememory.c |  4 +-
 drivers/mtd/nand/spi/ato.c            |  4 +-
 drivers/mtd/nand/spi/esmt.c           |  4 +-
 drivers/mtd/nand/spi/foresee.c        |  4 +-
 drivers/mtd/nand/spi/gigadevice.c     | 16 ++++----
 drivers/mtd/nand/spi/macronix.c       |  4 +-
 drivers/mtd/nand/spi/micron.c         |  8 ++--
 drivers/mtd/nand/spi/paragon.c        |  4 +-
 drivers/mtd/nand/spi/toshiba.c        |  4 +-
 drivers/mtd/nand/spi/winbond.c        | 27 +++++++++++--
 drivers/mtd/nand/spi/xtx.c            |  4 +-
 drivers/spi/spi-amd.c                 | 10 ++++-
 drivers/spi/spi-amlogic-spifc-a1.c    |  7 +++-
 drivers/spi/spi-cadence-quadspi.c     |  3 +-
 drivers/spi/spi-dw-core.c             | 10 ++++-
 drivers/spi/spi-fsl-qspi.c            | 12 ++++--
 drivers/spi/spi-mem.c                 | 13 +++++++
 drivers/spi/spi-microchip-core-qspi.c | 26 +++++++++++--
 drivers/spi/spi-mt65xx.c              |  7 +++-
 drivers/spi/spi-mxic.c                |  3 +-
 drivers/spi/spi-nxp-fspi.c            | 12 ++++--
 drivers/spi/spi-rockchip-sfc.c        | 11 ++++--
 drivers/spi/spi-sn-f-ospi.c           |  8 +++-
 drivers/spi/spi-ti-qspi.c             |  7 +++-
 drivers/spi/spi-zynq-qspi.c           | 13 +++++--
 drivers/spi/spi-zynqmp-gqspi.c        | 13 +++++--
 include/linux/mtd/spinand.h           | 56 +++++++++++++++++++++++++--
 include/linux/spi/spi-mem.h           | 56 ++++++++++++++++++++++++++-
 28 files changed, 282 insertions(+), 68 deletions(-)

-- 
2.43.0


