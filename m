Return-Path: <linux-spi+bounces-11198-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F69C5CA66
	for <lists+linux-spi@lfdr.de>; Fri, 14 Nov 2025 11:44:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B65A74F71A5
	for <lists+linux-spi@lfdr.de>; Fri, 14 Nov 2025 10:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9BB930E0D0;
	Fri, 14 Nov 2025 10:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="d4dFR6br"
X-Original-To: linux-spi@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBFE30AAC1;
	Fri, 14 Nov 2025 10:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763116479; cv=none; b=nnFWiYSL3hSrUN69Xi5WMemw2PlnS8rauWxJfM4uibRgAJzNakFa6Btg1kT6TIFst62dYJ8Z0mljOK4yHpPCL0Jv+IqSH4vxMwlhNIDvkCXBsi/lkbVKTTfzlObOiP8lH/MwLkTY5j94YEvlj3nNh9dvpNxwdxEhvfHo6ZlUd5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763116479; c=relaxed/simple;
	bh=LmzioE4Q6F6/YsQ6HUWzvctwQNwjqvdOm9BlnNNnZSQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DwTxc44UeLUBCkoV7u6KBCElgUE8dTp7RNgK5kl/F2RytsKb6AYzTvEdbcC1PyftbHvAaFC2T4XaEMPRzJ/WS7jNh75hGMxfzPyB9/WizygX0yayXtK59F/gI1G6+c8L99PFU4q2c6T79U6VQOU2ForNELGqsgNx/et1CCoPimg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=d4dFR6br; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1763116479; x=1794652479;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LmzioE4Q6F6/YsQ6HUWzvctwQNwjqvdOm9BlnNNnZSQ=;
  b=d4dFR6broRpg6Er0PKcCAOqr/ql9T5kG/J1t3Pju1i0sJEKtvgzk3QAn
   Ytuoso2UMNcokynHzRQ9sLfZtht1xVvoiIwv13QqeQP1n64865XpiRbOm
   kqil+excIxZP88691Nkor8ZEBDavQahABV7BrNT4seSj2HqkM8uBiFOqo
   xb/54j049wQOz+LbZs2vtwwF1yNpBIP1xs7p3n0OJQHHdrUxYMYJ+GXGu
   B3ty/UTtT4B8/NJhlyf7T4/wGWzxe2aih47n/KsjevXFB6a2NA5iME3Jz
   UDbDJZPBt0K1vYCpOPd0pOGOWyaxJ+QF5hqriR3Pb5JJDN2xEUaWPu4+T
   A==;
X-CSE-ConnectionGUID: wYFga1SYSXSOScvbmgh0dQ==
X-CSE-MsgGUID: 1w6Bd04iRt+19rD6K4BNMQ==
X-IronPort-AV: E=Sophos;i="6.19,304,1754982000"; 
   d="scan'208";a="49141509"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2025 03:34:38 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Fri, 14 Nov 2025 03:34:18 -0700
Received: from Lily.microchip.com (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Fri, 14 Nov 2025 03:34:16 -0700
From: Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>
To: Mark Brown <broonie@kernel.org>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	<linux-riscv@lists.infradead.org>, <linux-spi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>, Conor Dooley
	<conor.dooley@microchip.com>, Daire McNamara <daire.mcnamara@microchip.com>,
	Valentina Fernandez Alanis <valentina.fernandezalanis@microchip.com>, "Cyril
 Jean" <cyril.jean@microchip.com>, Prajna Rajendra Kumar
	<prajna.rajendrakumar@microchip.com>
Subject: [PATCH v4 0/3] Add support for Microchip CoreSPI Controller
Date: Fri, 14 Nov 2025 10:45:42 +0000
Message-ID: <20251114104545.284765-1-prajna.rajendrakumar@microchip.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This patch series adds support for the Microchip FPGA CoreSPI "soft" IP 
and documents its device tree bindings.

As preparation, the existing Microchip SPI driver is renamed to clearly
indicate that it supports only the Microchip PolarFire SoC "hard" controller.
Although it was originally named with the expectation that it might also
cover the FPGA CoreSPI "soft" IP, the register layouts differ significantly, 
so separate drivers are required.

changes in v4
--------------
- Switch callback from .remove_new to .remove in mpfs-spi.c This change was missed in v2

changes in v3
--------------
- Renamed Kconfig symbol to SPI_MICROCHIP_CORE_SPI 
- Renamed CoreSPI driver from spi-microchip-core.c to spi-microchip-core-spi.c to avoid confusion

changes in v2
--------------
- Moved compatible strings into an enum and kept alphabetical order
- Replaced .remove_new callback with .remove
- Dropped unused variable reported by kernel test robot 
- Updated CoreSPI drivers commit message to include the 8-bit frame size restriction

Prajna Rajendra Kumar (3):
  spi: microchip: rename driver file and internal identifiers
  spi: dt-binding: document Microchip CoreSPI
  spi: add support for microchip "soft" spi controller

 .../bindings/spi/microchip,mpfs-spi.yaml      |  70 ++-
 drivers/spi/Kconfig                           |  28 +-
 drivers/spi/Makefile                          |   3 +-
 drivers/spi/spi-microchip-core-spi.c          | 442 ++++++++++++++++++
 .../spi/{spi-microchip-core.c => spi-mpfs.c}  | 207 ++++----
 5 files changed, 635 insertions(+), 115 deletions(-)
 create mode 100644 drivers/spi/spi-microchip-core-spi.c
 rename drivers/spi/{spi-microchip-core.c => spi-mpfs.c} (68%)

-- 
2.25.1


