Return-Path: <linux-spi+bounces-9357-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E75AFB2155F
	for <lists+linux-spi@lfdr.de>; Mon, 11 Aug 2025 21:34:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1ED82190864A
	for <lists+linux-spi@lfdr.de>; Mon, 11 Aug 2025 19:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00DBC2D8DCF;
	Mon, 11 Aug 2025 19:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="lQ3+b6NS"
X-Original-To: linux-spi@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544CE2D8DBD;
	Mon, 11 Aug 2025 19:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754940822; cv=none; b=aMdtrFnlMgc/O+xw/3GKRgzB2X7nPxEIzoIMXUTCDFTthPwKGwexqZVkgPrVC67E38gLKNWLr5zr/5Kr+X/8XJbkwjF273W+WOJlOJhZep27kwmAKVQqb3YldYbMsUU4vvq3IB2fvmT64fqx3R9Oe2vBjzHTn3i87LrYz55Bw6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754940822; c=relaxed/simple;
	bh=FeC0MWCqApQ7FM2kPzsZNiWDASSH962/7XVShOv6rDQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PYP8I241j2s4cjTN2Wu6DCL2KB7GysZI8bRM/uvP8mvknY1dwhYaV6+FYwL1Sqlo0FOSqQ4VVqAKvWakuIlEIO5KDQW01PA5+3GMmBHKzzoKWkwfyDcA7iRLdD8+96M24KuyNe6fP0SmzqA2G9Ip+loAff9paRRZ1m+E55pID4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=lQ3+b6NS; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57BJXXf81180243;
	Mon, 11 Aug 2025 14:33:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1754940813;
	bh=JNBUMqxnJPwUdETAbLE1uARqpWovKqp3PKZHw2LEmzU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=lQ3+b6NSeYP1ttIrztc+ztRvjbjxSGVs779MY01FZgFCYaRkruQb7K0/OuwACNKLP
	 Y5W/+EBne/UdMkl257KVEXd5X3v6v04YTVRygUWjDuYWbpEwqFGAN42sbK+akwupMc
	 ZZxJ6BtGtzyd5ziYIW6Qk8ORGdsfd3ixmlALUUNo=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57BJXXLf2910955
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 11 Aug 2025 14:33:33 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 11
 Aug 2025 14:33:32 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 11 Aug 2025 14:33:32 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [172.24.233.254])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57BJWq1v3690681;
	Mon, 11 Aug 2025 14:33:28 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <broonie@kernel.org>, <tudor.ambarus@linaro.org>,
        <pratyush@kernel.org>, <mwalle@kernel.org>, <p-mantena@ti.com>
CC: <linux-spi@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <s-k6@ti.com>, <a-dutta@ti.com>,
        <u-kumar1@ti.com>, <praneeth@ti.com>
Subject: [RFC PATCH 08/10] spi: cadence-quadspi: Enable PHY for data writes
Date: Tue, 12 Aug 2025 01:02:17 +0530
Message-ID: <20250811193219.731851-9-s-k6@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250811193219.731851-1-s-k6@ti.com>
References: <20250811193219.731851-1-s-k6@ti.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

PHY is tuned with optimal tuning point which allows controller to
run at higher speeds. Hence, increase the data writes' throughput in
OSPI/QSPI NAND flashes by enabling PHY for data writes to the NAND
flash devices.

The aim is to enable PHY only for the OSPI/QSPI NAND data writes,
so, exclude other operations like register writes to NAND flashes,
register and data writes to NOR flashes by introducing a check for
the 'n_tx' (op->data.nbytes) value before enabling.

Currently, OSPI/QSPI NOR's highest page size is 512 bytes, so, check
whether 'n_tx' is greater than or equal to 1024 and 'f_pdata->use_phy'
flag.

Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 drivers/spi/spi-cadence-quadspi.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 2096027bca4c..6c1159435577 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1202,6 +1202,9 @@ static int cqspi_indirect_write_execute(struct cqspi_flash_pdata *f_pdata,
 	if (cqspi->apb_ahb_hazard)
 		readl(reg_base + CQSPI_REG_INDIRECTWR);
 
+	if (n_tx >= SZ_1K && f_pdata->use_phy)
+		cqspi_phy_enable(f_pdata, true);
+
 	while (remaining > 0) {
 		size_t write_words, mod_bytes;
 
@@ -1242,6 +1245,9 @@ static int cqspi_indirect_write_execute(struct cqspi_flash_pdata *f_pdata,
 		goto failwr;
 	}
 
+	if (n_tx >= SZ_1K && f_pdata->use_phy)
+		cqspi_phy_enable(f_pdata, false);
+
 	/* Disable interrupt. */
 	writel(0, reg_base + CQSPI_REG_IRQMASK);
 
@@ -1253,6 +1259,9 @@ static int cqspi_indirect_write_execute(struct cqspi_flash_pdata *f_pdata,
 	return 0;
 
 failwr:
+	if (n_tx >= SZ_1K && f_pdata->use_phy)
+		cqspi_phy_enable(f_pdata, false);
+
 	/* Disable interrupt. */
 	writel(0, reg_base + CQSPI_REG_IRQMASK);
 
-- 
2.34.1


