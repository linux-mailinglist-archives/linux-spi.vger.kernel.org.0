Return-Path: <linux-spi+bounces-9361-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A2A0B21602
	for <lists+linux-spi@lfdr.de>; Mon, 11 Aug 2025 21:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D6311A23631
	for <lists+linux-spi@lfdr.de>; Mon, 11 Aug 2025 19:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CAB32D6E59;
	Mon, 11 Aug 2025 19:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="PQUSTZCp"
X-Original-To: linux-spi@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDAF029BDA7;
	Mon, 11 Aug 2025 19:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754942219; cv=none; b=UxoYTL2BT/ALIJR8P36WBPYVSpNzB7DZgSO3vixveAHSTwLwvqdwvFxxlHnvSFi7PuOWDVI9AVt+CVi5i9/9rM8JEZfGVCEbMFt/1peEn7X7W0uv+P/OxlPLw+WsyxdHVmJHc22XtabXCT/TtDAOQaIAV1e4j3m0MYFFbIq+QiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754942219; c=relaxed/simple;
	bh=UH866iIoV0BmgwOwOKmrPiamvqbnZJOQBXR1xx6vmt4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JjPcLXIVa59QAL29RAB/4vORz7Yy/TkFUoM3/IBUyoWn/BazagPurzXk4cfSCATrC+xsIns8KmNoKawzR8Eowb08JR09YlU7r/VDT3WEKiKD6DFZ99wjmCvaSbTiNvNkKN2hGvTZ9wERGD/I7XVO9MBDY3xY/4jPFyaBiAfMs2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=PQUSTZCp; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57BJXg1s1227857;
	Mon, 11 Aug 2025 14:33:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1754940822;
	bh=Gqtsu4C7TidETAVnE77OpIDvlXHGXv1Mz6JMhY6rGHo=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=PQUSTZCp5bneAU1Ct823nP1oieJ9HPFezrBrDy5PJQYcEHKWnQHhym+a3JXzM7k5B
	 Lq/ZSTm2Ai6SxdgUtn38LXIvSnvZFMTFJzzTZPB6PKtvx3fCdizxk4Mq9nwIVgmBRw
	 O3zN49zwyruOIovEyOZV4kbYyDb3mBhpKrFsW9rY=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57BJXg2l2910990
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 11 Aug 2025 14:33:42 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 11
 Aug 2025 14:33:41 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 11 Aug 2025 14:33:41 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [172.24.233.254])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57BJWq1x3690681;
	Mon, 11 Aug 2025 14:33:37 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <broonie@kernel.org>, <tudor.ambarus@linaro.org>,
        <pratyush@kernel.org>, <mwalle@kernel.org>, <p-mantena@ti.com>
CC: <linux-spi@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <s-k6@ti.com>, <a-dutta@ti.com>,
        <u-kumar1@ti.com>, <praneeth@ti.com>
Subject: [RFC PATCH 10/10] spi: cadence-quadspi: Define cqspi_get_tuning_params()
Date: Tue, 12 Aug 2025 01:02:19 +0530
Message-ID: <20250811193219.731851-11-s-k6@ti.com>
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

Define cqspi_get_tuning_params() to extract information about the PHY
tuning pattern and it's size from controller.

Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 drivers/spi/spi-cadence-quadspi.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 1626cb9a9700..c9c4341d3275 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -2170,6 +2170,14 @@ static int cqspi_mem_execute_tuning(struct spi_mem *mem,
 	return ret;
 }
 
+static int cqspi_get_tuning_params(struct spi_mem *mem,
+				   struct spi_mem_tuning_params *tuning_params)
+{
+	tuning_params->pattern_ptr = phy_tuning_pattern;
+	tuning_params->pattern_size = sizeof(phy_tuning_pattern);
+	return 0;
+}
+
 static int cqspi_of_get_flash_pdata(struct platform_device *pdev,
 				    struct cqspi_flash_pdata *f_pdata,
 				    struct device_node *np)
@@ -2345,6 +2353,7 @@ static const struct spi_controller_mem_ops cqspi_mem_ops = {
 	.get_name = cqspi_get_name,
 	.supports_op = cqspi_supports_mem_op,
 	.execute_tuning = cqspi_mem_execute_tuning,
+	.get_tuning_params = cqspi_get_tuning_params,
 };
 
 static const struct spi_controller_mem_caps cqspi_mem_caps = {
-- 
2.34.1


