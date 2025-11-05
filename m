Return-Path: <linux-spi+bounces-11040-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD19C365EB
	for <lists+linux-spi@lfdr.de>; Wed, 05 Nov 2025 16:38:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 52FFB4FD418
	for <lists+linux-spi@lfdr.de>; Wed,  5 Nov 2025 15:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E4D335558;
	Wed,  5 Nov 2025 15:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="svs3Hkn3"
X-Original-To: linux-spi@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B0D33507E;
	Wed,  5 Nov 2025 15:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762356244; cv=none; b=Nq85WHwKQvXscApRmrMeACNbNCgMY91lSLsbfC9W7AYNuEo83Esdk9OQDV3DScxI3pOIOyPrPLxFhFNjbJWnL+bZ3u4uyvmZMRdyADvzbOA/yE6/zMYhFduWWSFFk/DkwZG3bpc6AXu7kqYFxORfhsGITBNMQgDUPS+MZROvNOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762356244; c=relaxed/simple;
	bh=GXwbdQaFXRPyLyOFxOAe1jK4fHdG0pnAJ3StTbZyCww=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=K3dRfsppCdib3lrAYM5jHUXmp+03jivt62AahoXi+bh/4mhJxn1Z48v7ZTHLRImA3+4QQS72bdUf7dPuB9nd1YghwuuubEXyOWbe6t5rAf/wO1bpMSzcYqhSuW33iuZkwmN/RXeAoRwABNg+heMhWAvikaTZSQcmCcXm47IDkRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=svs3Hkn3; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1762356243; x=1793892243;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GXwbdQaFXRPyLyOFxOAe1jK4fHdG0pnAJ3StTbZyCww=;
  b=svs3Hkn3voUC1oR26UrouQU5sC6XbD7riw5rHWsM3llQ9h7+waWIMNzm
   agbajOY0AAC1818/8zdX289bclUs4XCQMsKzpKzlW7BVJESba9D98Ncs/
   M4IDCM2pOrm0K+/ktZJBzaSer4BUe/gBmhcuWViV5mHZ/BTDXjc12fZCh
   bKmMz9rWXFtajt+XqObjwptIt33ea5FdLNCJmaGu9FA5xzcT4nveDs7PJ
   9f94NfkmQKf6NaZx4TTGjcI0AxBL1stdtf+E8PoqHEY3DTSnRgoPibyFe
   IKbt7mATm9mp+UmgWEyQ+d1P0ItcloZIaE27NCmELJlYttFTMXqRsEHZL
   g==;
X-CSE-ConnectionGUID: uJ3OEhFsR7KdS3mVaaXYNA==
X-CSE-MsgGUID: u5K7xTi8TYyqLlRpBNBwow==
X-IronPort-AV: E=Sophos;i="6.19,282,1754982000"; 
   d="scan'208";a="49225714"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 08:24:02 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex2.mchp-main.com (10.10.87.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Wed, 5 Nov 2025 08:23:49 -0700
Received: from Lily.microchip.com (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Wed, 5 Nov 2025 08:23:47 -0700
From: Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>
To: Mark Brown <broonie@kernel.org>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	<linux-riscv@lists.infradead.org>, <linux-spi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>, Conor Dooley
	<conor.dooley@microchip.com>, Daire McNamara <daire.mcnamara@microchip.com>,
	Valentina Fernandez Alanis <valentina.fernandezalanis@microchip.com>, "Cyril
 Jean" <cyril.jean@microchip.com>, Prajna Rajendra Kumar
	<prajna.rajendrakumar@microchip.com>
Subject: [PATCH v2 0/3] Add support for Microchip CoreSPI Controller
Date: Wed, 5 Nov 2025 15:28:20 +0000
Message-ID: <20251105152823.730422-1-prajna.rajendrakumar@microchip.com>
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

 .../bindings/spi/microchip,mpfs-spi.yaml      |  70 +-
 drivers/spi/Kconfig                           |  12 +-
 drivers/spi/Makefile                          |   1 +
 drivers/spi/spi-microchip-core.c              | 581 ++++++----------
 drivers/spi/spi-mpfs.c                        | 626 ++++++++++++++++++
 5 files changed, 905 insertions(+), 385 deletions(-)
 create mode 100644 drivers/spi/spi-mpfs.c

-- 
2.25.1


