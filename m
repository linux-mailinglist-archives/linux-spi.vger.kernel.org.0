Return-Path: <linux-spi+bounces-9894-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD310B43D4A
	for <lists+linux-spi@lfdr.de>; Thu,  4 Sep 2025 15:33:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DB473A5AF5
	for <lists+linux-spi@lfdr.de>; Thu,  4 Sep 2025 13:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE54C3054C8;
	Thu,  4 Sep 2025 13:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="tlhYCI2R"
X-Original-To: linux-spi@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC0F303C9B;
	Thu,  4 Sep 2025 13:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756992757; cv=none; b=UuaLR4Y7m61t7m8iv3/jNrx7DyNdrmfUBTXPIJXsGIZIqIALOVtSBU8jLnyU1WUNNqhq1MqqbxesVDVwG1ZQc+l+nLQUM1m1WThs8AfbtOge92+VntgsvniHfc1cg/4ZNSGpb+xr5RndTEVtjA8JuOaeC+8jA+4sOgg625Rd18M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756992757; c=relaxed/simple;
	bh=oItnaSCSDsa8nd0WoT2xiv18hJR3qNcqdqdRY0ysN6U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kvOkYPk3ius1ZLFN734x7ONmYq+nD5mO/B+N6dZ3Ts4cgmgYBh/glOr/+zhJF0tcW/MJ8psCgIhWJpWhSAzknkvNg49xtZheX5Xa92++JlWhB++z+kNghzipjed8oep/rArBO/ft7TKK/uK4L7Q95N9En5gsxERD0cKA3RnG+Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=tlhYCI2R; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 584DWJfL3518013;
	Thu, 4 Sep 2025 08:32:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1756992739;
	bh=Tw6vls1StU4RNUesLDoJ8Bhc3qDiBuENJydPRRnQskE=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=tlhYCI2RjmLEfy9mfmUqG88xoeE8pBVQKiPWbwRvwYdlFvqt01trak7WwFK2lA56w
	 EFaQg4xXSDDHsorcin6mIyk7w9A/cJLm3xh1kv53F42pLjxq8IsWOUcYxLTV9clIgZ
	 MZilYlALWCFD882UWje3g31tEt1t4iqckRk9Rneo=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 584DWJa1149830
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 4 Sep 2025 08:32:19 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 4
 Sep 2025 08:32:18 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 4 Sep 2025 08:32:19 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [172.24.233.254])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 584DW0DP3325799;
	Thu, 4 Sep 2025 08:32:15 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <miquel.raynal@bootlin.com>, <broonie@kernel.org>, <vigneshr@ti.com>,
        <marex@denx.de>, <computersforpeace@gmail.com>,
        <grmoore@opensource.altera.com>, <theo.lebrun@bootlin.com>
CC: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <s-k6@ti.com>,
        <praneeth@ti.com>, <p-mantena@ti.com>, <a-dutta@ti.com>,
        <u-kumar1@ti.com>
Subject: [PATCH 3/4] spi: cadence-quadspi: Fix cqspi_setup_flash()
Date: Thu, 4 Sep 2025 19:01:29 +0530
Message-ID: <20250904133130.3105736-4-s-k6@ti.com>
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

The 'max_cs' stores the largest chip select number. It should only
be updated when the current 'cs' is greater than existing 'max_cs'. So,
fix the condition accordingly.

Fixes: 0f3841a5e115 ("spi: cadence-qspi: report correct number of chip-select")
Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 drivers/spi/spi-cadence-quadspi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 447a32a08a93..da3ec15abb3e 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1722,7 +1722,7 @@ static const struct spi_controller_mem_caps cqspi_mem_caps = {
 
 static int cqspi_setup_flash(struct cqspi_st *cqspi)
 {
-	unsigned int max_cs = cqspi->num_chipselect - 1;
+	unsigned int max_cs = 0;
 	struct platform_device *pdev = cqspi->pdev;
 	struct device *dev = &pdev->dev;
 	struct cqspi_flash_pdata *f_pdata;
@@ -1740,7 +1740,7 @@ static int cqspi_setup_flash(struct cqspi_st *cqspi)
 		if (cs >= cqspi->num_chipselect) {
 			dev_err(dev, "Chip select %d out of range.\n", cs);
 			return -EINVAL;
-		} else if (cs < max_cs) {
+		} else if (cs > max_cs) {
 			max_cs = cs;
 		}
 
-- 
2.34.1


