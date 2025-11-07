Return-Path: <linux-spi+bounces-11112-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C73C3FDED
	for <lists+linux-spi@lfdr.de>; Fri, 07 Nov 2025 13:17:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 682DD188E9B1
	for <lists+linux-spi@lfdr.de>; Fri,  7 Nov 2025 12:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F69283683;
	Fri,  7 Nov 2025 12:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Lp/QnDRh"
X-Original-To: linux-spi@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDCC184540;
	Fri,  7 Nov 2025 12:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762517826; cv=none; b=H+ACTOronfuV7X37KSYNe86fottirmEYvu4dff/qTLHKJZlzJ0ph50FZ+jJ2IeNjQQVNzY4goriHe30TaZxHLaEJmlTMrKFV5hdqPCOgnqf9eIrj7kjgmFJTPoVzBSdIMcWfm6Pi5dLo98CozHgXXkPtdreKL8Mgl5wcZG5Ce/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762517826; c=relaxed/simple;
	bh=fKFaVGRCYqdZdfnsZlL0kIN99ZrW6FxHqWyJRYYzsyk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qYeJYmUUS0lpC/hqsyEhk39mUSUCgvTu6bg0w5OmO83ToFJ788bz1XSqFDOZN1n6PFpVRSrGfpnol26qsYeA2kVJqAHmK5j7KhuIt4hsOUU5fmIepCy+PPixU5UkABHCFQbe518LTijEqsc+FFJvL9X60WwqgFd1hdL5nE1G+nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Lp/QnDRh; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1762517824; x=1794053824;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fKFaVGRCYqdZdfnsZlL0kIN99ZrW6FxHqWyJRYYzsyk=;
  b=Lp/QnDRhmgz3x0DJz7ODMt9yL1lCy6bpB5t2H/f9KwC1tF3xkCXZd3nu
   9dhcsmGlRfhM8cEHWWSmxgmMnOuume2ByYmur9ZRpM8AT2uvW1ZD/hTW3
   u/Whkg8TxFAmEzUgzpuqZpY5epJ7TjTqxR5i40d1/icNnZFxoq7v8nGun
   3PX1ZAeBlUDN3e6plJlJWqSN6Yhz3jnVwPYLtUyYIbqe2cpSj34p9T12E
   LSQlptnVeChx/E52aHrl0EvR7r0iYI5s0wqanrJM9Kt9bkVKR8EK1J2xP
   HAWYRvOpR+q0oqnKr5TunhpKNdSPXHCof3qGiN9SCs25jOPCpuYLAM2YT
   A==;
X-CSE-ConnectionGUID: BMvHhjAdT6y1+HEhZwPKDQ==
X-CSE-MsgGUID: Ztzym4YlSXOXoPc+PKmwNg==
X-IronPort-AV: E=Sophos;i="6.19,286,1754982000"; 
   d="scan'208";a="55218261"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2025 05:17:03 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Fri, 7 Nov 2025 05:16:34 -0700
Received: from Lily.microchip.com (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Fri, 7 Nov 2025 05:16:32 -0700
From: Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>
To: Mark Brown <broonie@kernel.org>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	<linux-riscv@lists.infradead.org>, <linux-spi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>, Conor Dooley
	<conor.dooley@microchip.com>, Daire McNamara <daire.mcnamara@microchip.com>,
	Valentina Fernandez Alanis <valentina.fernandezalanis@microchip.com>, "Cyril
 Jean" <cyril.jean@microchip.com>, Prajna Rajendra Kumar
	<prajna.rajendrakumar@microchip.com>
Subject: [PATCH v3 0/3] Add support for Microchip CoreSPI Controller
Date: Fri, 7 Nov 2025 12:21:01 +0000
Message-ID: <20251107122104.1389301-1-prajna.rajendrakumar@microchip.com>
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


