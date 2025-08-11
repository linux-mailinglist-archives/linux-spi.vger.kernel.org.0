Return-Path: <linux-spi+bounces-9360-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 190D1B21565
	for <lists+linux-spi@lfdr.de>; Mon, 11 Aug 2025 21:34:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FC3C188B899
	for <lists+linux-spi@lfdr.de>; Mon, 11 Aug 2025 19:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD47D2E2DFB;
	Mon, 11 Aug 2025 19:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qfjpm+8E"
X-Original-To: linux-spi@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B9B2D949C;
	Mon, 11 Aug 2025 19:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754940831; cv=none; b=G88yJLI72tCNSLPbnLglo1Ro4hOXh7KwoFHbfLJyyTATjXOw0d2/m95oS+e6sxVzQDFQcgNDOH2TabWnHalbM9bTWBn+5HevZ5+IZKx7KltX3UBU2xKbr6jvnLuIq8CoT2hblIf10eyPvgi2jByZKKcWv7mvLZ8/FYzLgR24/Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754940831; c=relaxed/simple;
	bh=3vK14E6SbeBnJWd93I8RGPb/B/hdo1aya9mqwBariFw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RDQJLmnboragabwFA+GDX2qhXqpdV9n0itX9ZDDYd5MIFhuQQYtuO1ejIqNIJHT/3TiG0FPbaAbUe0EKGHEI8Jb9M2f9VBVAq7/h18QaSjVMuO4gpPTxIIUBd8Jk/Q5qptdiUGv9iCawOu7a0SThEfMSaH8XeCFJp55alZ538j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=qfjpm+8E; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57BJXFEj1678217;
	Mon, 11 Aug 2025 14:33:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1754940795;
	bh=Mbm6XmTsVQep+WWUIidWCy6jZKFBV6BX76B/Uekl5C0=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=qfjpm+8E05PLNOAW/vc62xU1UTRIgM+5e6bKS4F22EGRXQbkd6ZGGwysE5q8h36QY
	 JFSY7JnG0Id0wk5jBooI+tfoPaCFC3KK1U5T+YsOW71oSpSpdlPLyv7qUkgf5SjED8
	 gsOt5Tr/FbUd7wzUtZgFIvblBrg9kKoLGssKFwTI=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57BJXFld2910894
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 11 Aug 2025 14:33:15 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 11
 Aug 2025 14:33:15 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 11 Aug 2025 14:33:15 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [172.24.233.254])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57BJWq1r3690681;
	Mon, 11 Aug 2025 14:33:11 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <broonie@kernel.org>, <tudor.ambarus@linaro.org>,
        <pratyush@kernel.org>, <mwalle@kernel.org>, <p-mantena@ti.com>
CC: <linux-spi@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <s-k6@ti.com>, <a-dutta@ti.com>,
        <u-kumar1@ti.com>, <praneeth@ti.com>
Subject: [RFC PATCH 04/10] mtd: mtdcore: Call mtd_execute_tuning during mtd_register
Date: Tue, 12 Aug 2025 01:02:13 +0530
Message-ID: <20250811193219.731851-5-s-k6@ti.com>
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

Call mtd_execute_tuning() during the mtd_register() which redirects to
the flash specific tuning procedure to run at higher frequencies.

Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 drivers/mtd/mtdcore.c | 19 +++++++++++++++++++
 drivers/mtd/mtdcore.h |  1 +
 2 files changed, 20 insertions(+)

diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index 5ba9a741f5ac..f50cebcdb670 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -1023,6 +1023,22 @@ static int mtd_otp_nvmem_add(struct mtd_info *mtd)
 	return dev_err_probe(dev, err, "Failed to register OTP NVMEM device\n");
 }
 
+int mtd_execute_tuning(struct mtd_info *mtd)
+{
+	struct mtd_part *part;
+
+	list_for_each_entry(part, &mtd->partitions, node) {
+		struct mtd_info *part_info =
+			container_of(part, struct mtd_info, part);
+		if (part_info->name &&
+		    !strcmp(part_info->name, "ospi.phypattern")) {
+			return mtd->_execute_tuning(mtd, part);
+		}
+	}
+
+	return -ENODEV;
+}
+
 /**
  * mtd_device_parse_register - parse partitions and register an MTD device.
  *
@@ -1087,6 +1103,9 @@ int mtd_device_parse_register(struct mtd_info *mtd, const char * const *types,
 	if (ret)
 		goto out;
 
+	if (mtd_execute_tuning(mtd) == -ENODEV)
+		dev_info(&mtd->dev, "PHY pattern partition not found\n");
+
 	/*
 	 * FIXME: some drivers unfortunately call this function more than once.
 	 * So we have to check if we've already assigned the reboot notifier.
diff --git a/drivers/mtd/mtdcore.h b/drivers/mtd/mtdcore.h
index b014861a06a6..04055fcd2df8 100644
--- a/drivers/mtd/mtdcore.h
+++ b/drivers/mtd/mtdcore.h
@@ -13,6 +13,7 @@ int del_mtd_device(struct mtd_info *mtd);
 int add_mtd_partitions(struct mtd_info *, const struct mtd_partition *, int);
 int del_mtd_partitions(struct mtd_info *);
 void release_mtd_partition(struct mtd_info *mtd);
+int mtd_execute_tuning(struct mtd_info *mtd);
 
 struct mtd_partitions;
 
-- 
2.34.1


