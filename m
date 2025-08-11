Return-Path: <linux-spi+bounces-9358-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BED73B21562
	for <lists+linux-spi@lfdr.de>; Mon, 11 Aug 2025 21:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89403623248
	for <lists+linux-spi@lfdr.de>; Mon, 11 Aug 2025 19:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDB662D662E;
	Mon, 11 Aug 2025 19:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="f2B30xwH"
X-Original-To: linux-spi@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032DA207A22;
	Mon, 11 Aug 2025 19:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754940829; cv=none; b=Eo9YeNZhlCAqPAorStenvMhYOJOoZVzhDDYRaecKQ3FCRYflxYk3kD4HXNj2UYqJK8PfgUALf3jzaCJVSs5aBWZzjyGLF4YehDTkK0hXRJvfI3mGBewYsn3C7LRN20XcJTSrRSRcVTPxJthlBaEI2cYWejlOENr8rDFJQ7M4+V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754940829; c=relaxed/simple;
	bh=pf5c+ZoVAYMGy0I3S72deyXTPHc0lFoJ/nL1xToERAU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dtR5KX9iJnubJcpr9EciyNtfgNoVgBz7TAIqS6Tg2Tgs3od88kJLTTOnRwnCmYs1olzHhvTetFwZ18I+2insmJ3x12lL3ms5ti7dne1lzS8OHtiGOM502TqqLD5E3aw2qDx8jvkpcukURbKPf7h2xLDeDsojagsrd8jd5nYbXY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=f2B30xwH; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57BJXBkB1678213;
	Mon, 11 Aug 2025 14:33:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1754940791;
	bh=YdngpaN6rCWaiPZrMnO8j4ato33z/K66hxWiRc0bfZs=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=f2B30xwHAzok/DYFLm6sq1Nht6Lr2fTlpiSwUCWeHbmcN7Xx9sb15htsqz1XnOlCc
	 g1wgvSvJExN0JMF7m1E90zZfNjDOfmAvw3jy0ywXvWL1myHhxaRsxyDCqccAcTkJT2
	 KLZ+PWBcVm633QwamgtUX6VJMI6VOUmPtX9Wbz/4=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57BJXBvX2910863
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 11 Aug 2025 14:33:11 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 11
 Aug 2025 14:33:10 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 11 Aug 2025 14:33:10 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [172.24.233.254])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57BJWq1q3690681;
	Mon, 11 Aug 2025 14:33:06 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <broonie@kernel.org>, <tudor.ambarus@linaro.org>,
        <pratyush@kernel.org>, <mwalle@kernel.org>, <p-mantena@ti.com>
CC: <linux-spi@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <s-k6@ti.com>, <a-dutta@ti.com>,
        <u-kumar1@ti.com>, <praneeth@ti.com>
Subject: [RFC PATCH 03/10] mtd: nand: spi: Introduce _execute_tuning for mtd devices
Date: Tue, 12 Aug 2025 01:02:12 +0530
Message-ID: <20250811193219.731851-4-s-k6@ti.com>
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

Add _execute_tuning to mtd_info allowing mtd devices to run their own
PHY tuning procedure to run at higher frequencies.

Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 drivers/mtd/nand/spi/core.c | 61 +++++++++++++++++++++++++++++++++++++
 include/linux/mtd/mtd.h     |  1 +
 2 files changed, 62 insertions(+)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index b0898990b2a5..c890a42cdb0a 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -1483,6 +1483,66 @@ static void spinand_mtd_resume(struct mtd_info *mtd)
 	spinand_ecc_enable(spinand, false);
 }
 
+static int spinand_mtd_execute_tuning(struct mtd_info *mtd, struct mtd_part *part)
+{
+	struct spinand_device *spinand = mtd_to_spinand(mtd);
+	struct nand_device *nand = spinand_to_nand(spinand);
+	struct nand_pos page_pos;
+	struct nand_page_io_req page_req;
+	struct spi_mem_op read_page_op;
+	struct spi_mem_tuning_params *tuning_params;
+	int ret, pageoffs;
+	u8 status;
+
+	tuning_params = kzalloc(sizeof(*tuning_params), GFP_KERNEL);
+	if (!tuning_params)
+		return -ENOMEM;
+
+	ret = spi_mem_get_tuning_params(spinand->spimem, tuning_params);
+	if (ret)
+		goto err_free_tuning_params;
+
+	/*
+	 * TODO:
+	 * Write the PHY pattern to cache using spinand_write_to_cache_op()
+	 * and readback pattern from cache during tuning instead of using up
+	 * the flash's space.
+	 *
+	 * For SPI NOR:
+	 * Things remain same as done here, the PHY pattern will be preflashed to
+	 * at an offset and will be readback during tuning.
+	 */
+
+	pageoffs = nanddev_offs_to_pos(nand, part->offset, &page_pos);
+	page_req.pos = page_pos;
+
+	read_page_op = *spinand->op_templates.read_cache;
+	read_page_op.addr.val = pageoffs;
+	read_page_op.data.nbytes = tuning_params->pattern_size;
+
+	ret = spinand_load_page_op(spinand, &page_req);
+	if (ret)
+		goto err_free_tuning_params;
+
+	ret = spinand_wait(spinand, SPINAND_READ_INITIAL_DELAY_US,
+			   SPINAND_READ_POLL_DELAY_US, &status);
+	if (ret < 0)
+		goto err_free_tuning_params;
+
+	spinand_ondie_ecc_save_status(nand, status);
+	ret = spi_mem_execute_tuning(spinand->spimem, &read_page_op);
+
+	/*
+	 * TODO:
+	 * Fallback to a lower frequency and a less dummy cycle in case of
+	 * PHY tuning failure
+	 */
+
+err_free_tuning_params:
+	kfree(tuning_params);
+	return ret;
+}
+
 static int spinand_init(struct spinand_device *spinand)
 {
 	struct device *dev = &spinand->spimem->spi->dev;
@@ -1551,6 +1611,7 @@ static int spinand_init(struct spinand_device *spinand)
 	mtd->_erase = spinand_mtd_erase;
 	mtd->_max_bad_blocks = nanddev_mtd_max_bad_blocks;
 	mtd->_resume = spinand_mtd_resume;
+	mtd->_execute_tuning = spinand_mtd_execute_tuning;
 
 	if (spinand_user_otp_size(spinand) || spinand_fact_otp_size(spinand)) {
 		ret = spinand_set_mtd_otp_ops(spinand);
diff --git a/include/linux/mtd/mtd.h b/include/linux/mtd/mtd.h
index 8d10d9d2e830..5ac8dc02280d 100644
--- a/include/linux/mtd/mtd.h
+++ b/include/linux/mtd/mtd.h
@@ -355,6 +355,7 @@ struct mtd_info {
 	int (*_suspend) (struct mtd_info *mtd);
 	void (*_resume) (struct mtd_info *mtd);
 	void (*_reboot) (struct mtd_info *mtd);
+	int (*_execute_tuning) (struct mtd_info *mtd, struct mtd_part *part);
 	/*
 	 * If the driver is something smart, like UBI, it may need to maintain
 	 * its own reference counting. The below functions are only for driver.
-- 
2.34.1


