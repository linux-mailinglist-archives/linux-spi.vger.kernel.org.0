Return-Path: <linux-spi+bounces-5891-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BECEF9E3395
	for <lists+linux-spi@lfdr.de>; Wed,  4 Dec 2024 07:36:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A7EA1647EA
	for <lists+linux-spi@lfdr.de>; Wed,  4 Dec 2024 06:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C402D187FF4;
	Wed,  4 Dec 2024 06:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cs89oZcu"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E8C18755C;
	Wed,  4 Dec 2024 06:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733294194; cv=none; b=g300pRjsx2v3hDyCcClNdMCcaAlEt9KXuSpOJTIXXUFbZXaFpkOBFBEsTq5I3sIYQRHzB+QAb/QYJYeGQ2t+9jcJKuhgIF4ZqjcgvoEzgAY5Zk3syw0+qol0U/FSnqciWnNRxIS7GQNpro9UhFMHsW4gBn/4uaMWaYaUuImzppU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733294194; c=relaxed/simple;
	bh=hBC1ogtaYzDAWZVOP6FDDScazg25qr8En+rrAKuWOms=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=uBRvGbq1Q67cNfqyd4MqLj3ix1AfSI/5KNPgq1PsqZ5MfCYvVUw5jJxHAA4vEA+BxcAaI1fZTLpxOrPE7/ahbWtMo8aQwGnX3A5ljN2rfFw+M1ufx24IILerY8FZY8LgLcdl5pMv83u1ECnG4q9vEb4BjaoyLPgCKgOw2mF8C8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cs89oZcu; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733294193; x=1764830193;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hBC1ogtaYzDAWZVOP6FDDScazg25qr8En+rrAKuWOms=;
  b=cs89oZcujKyTa2dPLX5/HLAjnMRtA0SN17IVLQ11378oserOTiiO0mf2
   vlXtT2VtgsyhlgaeO6GaLpBcEhaqxbHKPedrYU6xxYth1LMnTRf8StevL
   YTNL0HnwNvFXKDHXe0UdFF39yxbyXQjZAeayeDkXneyFETKYYmxnNJtRJ
   Fiye3OV84xRDUlj4BhReEh9tj7OPJR42+8mVANqP+pGHcI+Kuncvf0BJE
   lmHsfCJx53jNxLHw4vPK09co5lRTJ+F63yjc2PezT5IhFD8Ws+0A3i2Yb
   oQwBIzqQcexvp5GjgKifMtXhkB4sK/+8/hgtM8kpOeUk0Uk5uIxoGurEZ
   g==;
X-CSE-ConnectionGUID: PeTYC4AlTqqQIDwn3ca0Pg==
X-CSE-MsgGUID: OOzuKFtfQxqdLIq31zUdkg==
X-IronPort-AV: E=McAfee;i="6700,10204,11275"; a="33674898"
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="33674898"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 22:36:32 -0800
X-CSE-ConnectionGUID: MyNRSBhKQXeeUpObCmz7XA==
X-CSE-MsgGUID: 1CezbX9vT0qeUXLnxYkAHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="93516043"
Received: from pg15swiplab1181.png.altera.com ([10.244.232.167])
  by orviesa010.jf.intel.com with ESMTP; 03 Dec 2024 22:36:31 -0800
From: niravkumar.l.rabara@intel.com
To: Mark Brown <broonie@kernel.org>,
	niravkumar.l.rabara@intel.com,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] spi: spi-cadence-qspi: Disable STIG mode for Altera SoCFPGA.
Date: Wed,  4 Dec 2024 14:33:38 +0800
Message-Id: <20241204063338.296959-1-niravkumar.l.rabara@intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>

STIG mode is enabled by default for less than 8 bytes data read/write.
STIG mode doesn't work with Altera SocFPGA platform due hardware
limitation.
Add a quirks to disable STIG mode for Altera SoCFPGA platform.

Signed-off-by: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
---
 drivers/spi/spi-cadence-quadspi.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 0b45b7b2b3ab..a031ecb358e0 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -43,6 +43,7 @@ static_assert(CQSPI_MAX_CHIPSELECT <= SPI_CS_CNT_MAX);
 #define CQSPI_SLOW_SRAM		BIT(4)
 #define CQSPI_NEEDS_APB_AHB_HAZARD_WAR	BIT(5)
 #define CQSPI_RD_NO_IRQ			BIT(6)
+#define CQSPI_DISABLE_STIG_MODE		BIT(7)
 
 /* Capabilities */
 #define CQSPI_SUPPORTS_OCTAL		BIT(0)
@@ -103,6 +104,7 @@ struct cqspi_st {
 	bool			apb_ahb_hazard;
 
 	bool			is_jh7110; /* Flag for StarFive JH7110 SoC */
+	bool			disable_stig_mode;
 
 	const struct cqspi_driver_platdata *ddata;
 };
@@ -1416,7 +1418,8 @@ static int cqspi_mem_process(struct spi_mem *mem, const struct spi_mem_op *op)
 	 * reads, prefer STIG mode for such small reads.
 	 */
 		if (!op->addr.nbytes ||
-		    op->data.nbytes <= CQSPI_STIG_DATA_LEN_MAX)
+		    (op->data.nbytes <= CQSPI_STIG_DATA_LEN_MAX &&
+		     !cqspi->disable_stig_mode))
 			return cqspi_command_read(f_pdata, op);
 
 		return cqspi_read(f_pdata, op);
@@ -1880,6 +1883,8 @@ static int cqspi_probe(struct platform_device *pdev)
 			if (ret)
 				goto probe_reset_failed;
 		}
+		if (ddata->quirks & CQSPI_DISABLE_STIG_MODE)
+			cqspi->disable_stig_mode = true;
 
 		if (of_device_is_compatible(pdev->dev.of_node,
 					    "xlnx,versal-ospi-1.0")) {
@@ -2043,7 +2048,8 @@ static const struct cqspi_driver_platdata intel_lgm_qspi = {
 static const struct cqspi_driver_platdata socfpga_qspi = {
 	.quirks = CQSPI_DISABLE_DAC_MODE
 			| CQSPI_NO_SUPPORT_WR_COMPLETION
-			| CQSPI_SLOW_SRAM,
+			| CQSPI_SLOW_SRAM
+			| CQSPI_DISABLE_STIG_MODE,
 };
 
 static const struct cqspi_driver_platdata versal_ospi = {
-- 
2.25.1


