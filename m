Return-Path: <linux-spi+bounces-9924-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E2CB46305
	for <lists+linux-spi@lfdr.de>; Fri,  5 Sep 2025 21:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85B881D222C9
	for <lists+linux-spi@lfdr.de>; Fri,  5 Sep 2025 19:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A0827F4CA;
	Fri,  5 Sep 2025 19:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="dUXptnG3"
X-Original-To: linux-spi@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BEE2750F4;
	Fri,  5 Sep 2025 19:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757098849; cv=none; b=n//p8Osm8GKvIHb78gREPlliwkBFuHHCYomzfGwpuJQRcoN6Zivwsnl7rk4C/qFF7eEPnuHewYF7drMMX/etQlYXsFkcWko/3uLHBzyvewKc3mY83T9J9eQAd4oGV8wwHRxmT453jmFV/ey8DABU2zFM+bWnsdAYoNTLrJN98yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757098849; c=relaxed/simple;
	bh=plIf6/KUkFBH5PX9p8aUxr3IY8vcecmmfDSvOTVOKPo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r3XXn+9zgAFFL85IP7yWa7kpcHAeKxA1lcASerPNBJVp33N904MokMEgunITy1Ng63cyhOX+I6WuXUF5B2Pr+o/v+SouYJs/7D3kNpb4gvGU6kISJk6y2fPxhLc5THWES7bHxf6CpK0UIELq4Ypf90zv0c5XxG0BRMgAvjs9OKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=dUXptnG3; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 585J0W3h3316339;
	Fri, 5 Sep 2025 14:00:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757098832;
	bh=yT0Mbn+mlYN05hR1yOT6laH/TJ/RFBidav59oah/GAE=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=dUXptnG32DIZww06bftLGKXIJ23kAcLQJBk9t1Hb8aPWcxAX3gd67/rHjFXQuGJEb
	 6jup1VDhHI/zI9enZvVjQaIDr1pOZjF5FvTsf8CRujTrffKDE6pjzIFTP20KSEa95a
	 wsBCL3UefEoBctfoMAJBqdKuwqt43SUh55aKZryA=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 585J0W8A562057
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 5 Sep 2025 14:00:32 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 5
 Sep 2025 14:00:31 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Fri, 5 Sep 2025 14:00:31 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [172.24.233.254])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 585J09kS887531;
	Fri, 5 Sep 2025 14:00:28 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <miquel.raynal@bootlin.com>, <broonie@kernel.org>, <vigneshr@ti.com>,
        <marex@denx.de>, <computersforpeace@gmail.com>,
        <theo.lebrun@bootlin.com>
CC: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <s-k6@ti.com>,
        <praneeth@ti.com>, <p-mantena@ti.com>, <a-dutta@ti.com>,
        <u-kumar1@ti.com>
Subject: [PATCH v2 4/4] spi: cadence-quadspi: Use BIT() macros where possible
Date: Sat, 6 Sep 2025 00:29:58 +0530
Message-ID: <20250905185958.3575037-5-s-k6@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250905185958.3575037-1-s-k6@ti.com>
References: <20250905185958.3575037-1-s-k6@ti.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

From: Vignesh Raghavendra <vigneshr@ti.com>

Convert few open coded bit shifts to BIT() macro for better readability.
No functional changes intended.

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 drivers/spi/spi-cadence-quadspi.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 6627a3059ea3..af253b86f1ab 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -335,7 +335,7 @@ static bool cqspi_is_idle(struct cqspi_st *cqspi)
 {
 	u32 reg = readl(cqspi->iobase + CQSPI_REG_CONFIG);
 
-	return reg & (1UL << CQSPI_REG_CONFIG_IDLE_LSB);
+	return reg & BIT(CQSPI_REG_CONFIG_IDLE_LSB);
 }
 
 static u32 cqspi_get_rd_sram_level(struct cqspi_st *cqspi)
@@ -571,7 +571,7 @@ static int cqspi_command_read(struct cqspi_flash_pdata *f_pdata,
 		reg |= (dummy_clk & CQSPI_REG_CMDCTRL_DUMMY_MASK)
 		     << CQSPI_REG_CMDCTRL_DUMMY_LSB;
 
-	reg |= (0x1 << CQSPI_REG_CMDCTRL_RD_EN_LSB);
+	reg |= BIT(CQSPI_REG_CMDCTRL_RD_EN_LSB);
 
 	/* 0 means 1 byte. */
 	reg |= (((n_rx - 1) & CQSPI_REG_CMDCTRL_RD_BYTES_MASK)
@@ -579,7 +579,7 @@ static int cqspi_command_read(struct cqspi_flash_pdata *f_pdata,
 
 	/* setup ADDR BIT field */
 	if (op->addr.nbytes) {
-		reg |= (0x1 << CQSPI_REG_CMDCTRL_ADDR_EN_LSB);
+		reg |= BIT(CQSPI_REG_CMDCTRL_ADDR_EN_LSB);
 		reg |= ((op->addr.nbytes - 1) &
 			CQSPI_REG_CMDCTRL_ADD_BYTES_MASK)
 			<< CQSPI_REG_CMDCTRL_ADD_BYTES_LSB;
@@ -646,7 +646,7 @@ static int cqspi_command_write(struct cqspi_flash_pdata *f_pdata,
 	reg = opcode << CQSPI_REG_CMDCTRL_OPCODE_LSB;
 
 	if (op->addr.nbytes) {
-		reg |= (0x1 << CQSPI_REG_CMDCTRL_ADDR_EN_LSB);
+		reg |= BIT(CQSPI_REG_CMDCTRL_ADDR_EN_LSB);
 		reg |= ((op->addr.nbytes - 1) &
 			CQSPI_REG_CMDCTRL_ADD_BYTES_MASK)
 			<< CQSPI_REG_CMDCTRL_ADD_BYTES_LSB;
@@ -655,7 +655,7 @@ static int cqspi_command_write(struct cqspi_flash_pdata *f_pdata,
 	}
 
 	if (n_tx) {
-		reg |= (0x1 << CQSPI_REG_CMDCTRL_WR_EN_LSB);
+		reg |= BIT(CQSPI_REG_CMDCTRL_WR_EN_LSB);
 		reg |= ((n_tx - 1) & CQSPI_REG_CMDCTRL_WR_BYTES_MASK)
 			<< CQSPI_REG_CMDCTRL_WR_BYTES_LSB;
 		data = 0;
@@ -1191,7 +1191,7 @@ static void cqspi_chipselect(struct cqspi_flash_pdata *f_pdata)
 		 * CS2 to 4b'1011
 		 * CS3 to 4b'0111
 		 */
-		chip_select = 0xF & ~(1 << chip_select);
+		chip_select = 0xF & ~BIT(chip_select);
 	}
 
 	reg &= ~(CQSPI_REG_CONFIG_CHIPSELECT_MASK
@@ -1277,9 +1277,9 @@ static void cqspi_readdata_capture(struct cqspi_st *cqspi,
 	reg = readl(reg_base + CQSPI_REG_READCAPTURE);
 
 	if (bypass)
-		reg |= (1 << CQSPI_REG_READCAPTURE_BYPASS_LSB);
+		reg |= BIT(CQSPI_REG_READCAPTURE_BYPASS_LSB);
 	else
-		reg &= ~(1 << CQSPI_REG_READCAPTURE_BYPASS_LSB);
+		reg &= ~BIT(CQSPI_REG_READCAPTURE_BYPASS_LSB);
 
 	reg &= ~(CQSPI_REG_READCAPTURE_DELAY_MASK
 		 << CQSPI_REG_READCAPTURE_DELAY_LSB);
-- 
2.34.1


