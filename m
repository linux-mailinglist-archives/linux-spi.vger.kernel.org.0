Return-Path: <linux-spi+bounces-9893-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 52EA7B43D4D
	for <lists+linux-spi@lfdr.de>; Thu,  4 Sep 2025 15:33:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CFBF7BCC7C
	for <lists+linux-spi@lfdr.de>; Thu,  4 Sep 2025 13:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A031D302CC3;
	Thu,  4 Sep 2025 13:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="VjUYINx6"
X-Original-To: linux-spi@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39172EA480;
	Thu,  4 Sep 2025 13:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756992756; cv=none; b=CTbXtzOMASpyH7e+2wKY7wapwjFgDMw8o21BYMq2xoidJZGQHD1GUeinjJBabm8GTA4dvSqA1uhxF+s9BtDv9pXVLYBQZt7PbleouDhy/5OLFjPbLRH7wyBizZP6ugbDYfSwHQUkecs/aJKT1JbsbimEShJV+Hk2V2ITSPGlUA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756992756; c=relaxed/simple;
	bh=KlqjwRyOyZ8RVuU0yCrHqiZjDdHNQSVtnaYeXWRiByk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aFKar48lcglcSCRCg4H9QuUbOqJF9bYjx02EaTP4wT0OHSn50M1XGqs5mx6jI4mK3rJmV0wuBDolzsI5Ydh2dtI7GgpgpSLetsF5K5T+2KP2FZJFfFFSZdGRRU+YtueAmIJ4MCygTblor7RWI17VGHznsl9v/uymMQSWH4UXP7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=VjUYINx6; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 584DWNV23083911;
	Thu, 4 Sep 2025 08:32:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1756992743;
	bh=VYuB3aj6zQtB9TojGXYO9w09Sr5XdUxpxuM9sgLqAOI=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=VjUYINx6RV55L/P05ywSIVfrrXLSvPueS530AJDoj3tgH9Jy3hklJN8aYGRbobQZV
	 Q+3kiArKHJkVbc3+loBfqkQ7BdlFZy2cION118Uuqol/ixiwEn1CXbJhtTU8sqlGrP
	 wg+hWFnstVNs20py1Z8b6GCHs9dV9VcxJOgaRCS4=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 584DWNTJ149849
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 4 Sep 2025 08:32:23 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 4
 Sep 2025 08:32:23 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 4 Sep 2025 08:32:23 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [172.24.233.254])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 584DW0DQ3325799;
	Thu, 4 Sep 2025 08:32:19 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <miquel.raynal@bootlin.com>, <broonie@kernel.org>, <vigneshr@ti.com>,
        <marex@denx.de>, <computersforpeace@gmail.com>,
        <grmoore@opensource.altera.com>, <theo.lebrun@bootlin.com>
CC: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <s-k6@ti.com>,
        <praneeth@ti.com>, <p-mantena@ti.com>, <a-dutta@ti.com>,
        <u-kumar1@ti.com>
Subject: [PATCH 4/4] spi: cadence-quadspi: Use BIT() macros where possible
Date: Thu, 4 Sep 2025 19:01:30 +0530
Message-ID: <20250904133130.3105736-5-s-k6@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250904133130.3105736-1-s-k6@ti.com>
References: <20250904133130.3105736-1-s-k6@ti.com>
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
 drivers/spi/spi-cadence-quadspi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index da3ec15abb3e..b18f095516f2 100644
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
@@ -1191,7 +1191,7 @@ static void cqspi_chipselect(struct cqspi_flash_pdata *f_pdata)
 		 * CS2 to 4b'1011
 		 * CS3 to 4b'0111
 		 */
-		chip_select = 0xF & ~(1 << chip_select);
+		chip_select = 0xF & ~BIT(chip_select);
 	}
 
 	reg &= ~(CQSPI_REG_CONFIG_CHIPSELECT_MASK
-- 
2.34.1


