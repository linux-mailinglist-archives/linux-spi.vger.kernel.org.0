Return-Path: <linux-spi+bounces-6207-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 574839FF921
	for <lists+linux-spi@lfdr.de>; Thu,  2 Jan 2025 13:06:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFE517A13B1
	for <lists+linux-spi@lfdr.de>; Thu,  2 Jan 2025 12:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A087DA9C;
	Thu,  2 Jan 2025 12:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Z39nV88d"
X-Original-To: linux-spi@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15422405F7;
	Thu,  2 Jan 2025 12:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735819567; cv=none; b=jimCRJR8VC7fY+cyAXyMPip5sKDroob2s3O7UOdu0oWa+VEM/NFK2O5LCVK8imov1Km7hnBZaXlshAzTUL4Ua8EWyH97gigdmFu6kIlgKLHB2f3zMzqLdnnJplxJdCYnC+niQk6sFbBXQV2TT//LygWbBtRp2X9bEditdEx9iOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735819567; c=relaxed/simple;
	bh=iSjYEUlrA//vGv3ItS3iy585iidbrl+YVFZv0RtnmWQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jXzQysc8C3zFOa45xWorf14pyrYB25Q7aWF4wwPshV1tDSEpZFBxmimU30Z2ltekwc3F8SmToZb2+bM4naYZSiTpripd3EPTu5E1R0+WPPMnNcvxx7OlmEP1mRZw485OFQuvvryBZoo9twcSSmLfAp/jWbSNnk2oZVTjTXDnj8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Z39nV88d; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 502C62Tx1883894
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 2 Jan 2025 06:06:02 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1735819562;
	bh=s68k9VU+p3vaDrXmbrCtfUyseTXjmoZg4Z4SgppTW5w=;
	h=From:To:CC:Subject:Date;
	b=Z39nV88ddnDZtDA+QXP0T24iRzoHwU5IDFPbMIniboUl7UpXAW75jxpHVPLsXyfc3
	 uBvOkS0/7YkZZzcCo/XPurZ3aqlQ2TzpC+eYAJKiskHkIwTjHB9liMnVmFuXj4hDBP
	 wHEWsRF9cgX2aEzxhnBk254P8b1L/rvADeXlPx3s=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 502C62D8067433;
	Thu, 2 Jan 2025 06:06:02 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 2
 Jan 2025 06:06:02 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 2 Jan 2025 06:06:02 -0600
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [172.24.227.241])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 502C5xu9027592;
	Thu, 2 Jan 2025 06:06:00 -0600
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>
CC: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <vigneshr@ti.com>, <p-mantena@ti.com>, <s-k6@ti.com>
Subject: [PATCH] spi: cadence-quadspi: Enable SPI_TX_QUAD
Date: Thu, 2 Jan 2025 17:35:44 +0530
Message-ID: <20250102120544.1407152-1-s-k6@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Enable the SPI_TX_QUAD mode bit in the host->mode_bits to support
data transmission over four lines to improve the performance.

Tested the functionality on AM62Lx EVM (W25N01JW) in 1S-4S-4S mode.

Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---

Repo: https://github.com/santhosh21/linux/tree/uL_next
Test results: https://gist.github.com/santhosh21/71ab6646dccc238a0b3c47c0382f219a

Regards,
Santhosh.

 drivers/spi/spi-cadence-quadspi.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 47477f2d9a25..594408d53400 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -49,6 +49,7 @@ static_assert(CQSPI_MAX_CHIPSELECT <= SPI_CS_CNT_MAX);
 
 /* Capabilities */
 #define CQSPI_SUPPORTS_OCTAL		BIT(0)
+#define CQSPI_SUPPORTS_QUAD		BIT(1)
 
 #define CQSPI_OP_WIDTH(part) ((part).nbytes ? ilog2((part).buswidth) : 0)
 
@@ -1888,6 +1889,8 @@ static int cqspi_probe(struct platform_device *pdev)
 						cqspi->master_ref_clk_hz);
 		if (ddata->hwcaps_mask & CQSPI_SUPPORTS_OCTAL)
 			host->mode_bits |= SPI_RX_OCTAL | SPI_TX_OCTAL;
+		if (ddata->hwcaps_mask & CQSPI_SUPPORTS_QUAD)
+			host->mode_bits |= SPI_TX_QUAD;
 		if (!(ddata->quirks & CQSPI_DISABLE_DAC_MODE)) {
 			cqspi->use_direct_mode = true;
 			cqspi->use_direct_mode_wr = true;
@@ -2062,7 +2065,7 @@ static const struct cqspi_driver_platdata k2g_qspi = {
 };
 
 static const struct cqspi_driver_platdata am654_ospi = {
-	.hwcaps_mask = CQSPI_SUPPORTS_OCTAL,
+	.hwcaps_mask = CQSPI_SUPPORTS_OCTAL | CQSPI_SUPPORTS_QUAD,
 	.quirks = CQSPI_NEEDS_WR_DELAY,
 };
 
-- 
2.34.1


