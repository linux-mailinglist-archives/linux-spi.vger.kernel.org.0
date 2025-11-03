Return-Path: <linux-spi+bounces-10983-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A987C2CF8B
	for <lists+linux-spi@lfdr.de>; Mon, 03 Nov 2025 17:05:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3C83F4E2371
	for <lists+linux-spi@lfdr.de>; Mon,  3 Nov 2025 16:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A8B314D18;
	Mon,  3 Nov 2025 16:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="o0I2uQpN"
X-Original-To: linux-spi@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049AD314D08;
	Mon,  3 Nov 2025 16:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762185683; cv=none; b=rPeyphaXzXT25zJ5uHjlxLHse0/8AnCHv4Lzw1vh9LZ9IM0pWXfCKOzl0EmoyXgeezBq1qatGLme1N9Eg/Cl6Ueqha221NlW33dsFyAiIKtZa215x+B9GSXTfWRL0uK5/TRVxirqhYROq1acjGNEQ/gC14Cmi2kYVnnu6MuP2tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762185683; c=relaxed/simple;
	bh=Ot3iWYcj47ZwqvJJfRRJMWRtoVr4u3WTIVXuUcMeLds=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ua5UqkXj0KZORr/e9rB28nmM8xyC3r1c062QsqooAMlNO4RR7qGUBA4vttnK+bFMtKFNAVkPrMfs/Hv/A2hBgT66g0XSGV/nBX2dzgxksyhkCa3AnkNog4XA9LppBzWKs13DNnU/9o01XcWjgVaOtLbCHKM0w7FG6KXNAwLqeTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=o0I2uQpN; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1762185681; x=1793721681;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Ot3iWYcj47ZwqvJJfRRJMWRtoVr4u3WTIVXuUcMeLds=;
  b=o0I2uQpN3wTxm3fJTSBFsVrPymIUB5auwirPeHEA+rRMlc+y0r7bvOsS
   VBtyna4Uj+0lI+Wn0ecNhLIoz/aBPaBqJkRFC6wwH9LxKvDM2TGcIE0sV
   v36y9y+0+aCErGgO5iP7pbpBlFmk5PchWVYQyHjeaaolcY6/AEIpKxDCz
   mn6I1kTSbyjyEaQkMjvcsL+YzRiFIG5bkWh7cXnYQ4pk2ReBb0XfyTSg+
   zDxhymBmqkzAMkoGapwxkVcqRWCOvXVMlKRRj5jCsbT8/gLS2va6hFkcI
   9vSrCC1sAuM3+45PXXbVh45xnptY5wULaY+sRpIfjz5UQ/aA0shRFcm0g
   w==;
X-CSE-ConnectionGUID: HCNQY0jzQAeYr9vBiTkXcQ==
X-CSE-MsgGUID: kqr79KI6SMSkHm381Jn2Zw==
X-IronPort-AV: E=Sophos;i="6.19,276,1754982000"; 
   d="scan'208";a="49119074"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 09:01:17 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Mon, 3 Nov 2025 09:00:37 -0700
Received: from Lily.microchip.com (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Mon, 3 Nov 2025 09:00:35 -0700
From: Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>
To: Mark Brown <broonie@kernel.org>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	<linux-riscv@lists.infradead.org>, <linux-spi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>, Conor Dooley
	<conor.dooley@microchip.com>, Daire McNamara <daire.mcnamara@microchip.com>,
	Valentina Fernandez Alanis <valentina.fernandezalanis@microchip.com>, "Cyril
 Jean" <cyril.jean@microchip.com>, Prajna Rajendra Kumar
	<prajna.rajendrakumar@microchip.com>
Subject: [PATCH v1 0/3] Add support for Microchip CoreSPI Controller
Date: Mon, 3 Nov 2025 16:05:12 +0000
Message-ID: <20251103160515.412706-1-prajna.rajendrakumar@microchip.com>
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

Prajna Rajendra Kumar (3):
  spi: microchip: rename driver file and internal identifiers
  spi: dt-binding: document Microchip CoreSPI
  spi: add support for microchip "soft" spi controller

 .../bindings/spi/microchip,mpfs-spi.yaml      |  65 ++
 drivers/spi/Kconfig                           |  12 +-
 drivers/spi/Makefile                          |   1 +
 drivers/spi/spi-microchip-core.c              | 582 ++++++----------
 drivers/spi/spi-mpfs.c                        | 626 ++++++++++++++++++
 5 files changed, 903 insertions(+), 383 deletions(-)
 create mode 100644 drivers/spi/spi-mpfs.c

-- 
2.25.1


