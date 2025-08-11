Return-Path: <linux-spi+bounces-9353-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2BFFB21556
	for <lists+linux-spi@lfdr.de>; Mon, 11 Aug 2025 21:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE2B9427585
	for <lists+linux-spi@lfdr.de>; Mon, 11 Aug 2025 19:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504572D63E5;
	Mon, 11 Aug 2025 19:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="oBKPVKhM"
X-Original-To: linux-spi@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9A24C7F;
	Mon, 11 Aug 2025 19:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754940802; cv=none; b=dfWjjQthJlJjObBPjIDjauKQyNbig0GyIG81x5JHtMuJDKY3Jx3ZDxBI+iPXXJ2wHLUOpgCGNToMKgTqQTEp/jxOT+yD3KaFr7ENhiSACS7rR91BVb2L8X4Y15p4o7ohq3Pc/45SCk1tMgqU6Ms4m3mwhnD5uXyW3ZuQJyhnYHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754940802; c=relaxed/simple;
	bh=ImbvtDUXb1pTf8oPmUPiBZCqeCqvg1xqe1HCmHaQbQA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uayvGDOChvJzwm+rtbvHX4qlV7H2cFe+ZJU+t2fs7VYqOQoV7aEdXla/F7DzdAQ4tx5bRQgq0f9RqcOZLzMMnxSAq2+6yGbsf/6Z8ZxqO13/fQf9JKkavrDhOQN5nWjDp8XG0a9hKh2lywEDzR9dedqr/OdTSvTabnZ5J3ILtL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=oBKPVKhM; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57BJX2lo1180188;
	Mon, 11 Aug 2025 14:33:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1754940782;
	bh=APF5bHQmgG8ox+n+lb2Pf49z5+3ddAxHmRPYSNB3FA0=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=oBKPVKhMyIULKXmH9flNHB70B+IJZdXWkMHJzwL97rChVbMtZwMaG/idL4kqUoSFC
	 VKFJI4J/XaiQn9bcgiC3jCxpiph5J70m+Z3545xNdmzjxOUzw3NUZ+sPaeNs/rDSA/
	 fsgFodGfSJcWZveHV/jaUalBxfsfUU7wirtcxWsc=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57BJX2PX3941521
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 11 Aug 2025 14:33:02 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 11
 Aug 2025 14:33:01 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 11 Aug 2025 14:33:01 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [172.24.233.254])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57BJWq1o3690681;
	Mon, 11 Aug 2025 14:32:57 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <broonie@kernel.org>, <tudor.ambarus@linaro.org>,
        <pratyush@kernel.org>, <mwalle@kernel.org>, <p-mantena@ti.com>
CC: <linux-spi@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <s-k6@ti.com>, <a-dutta@ti.com>,
        <u-kumar1@ti.com>, <praneeth@ti.com>
Subject: [RFC PATCH 01/10] spi: spi-mem: Introduce support for tuning controller
Date: Tue, 12 Aug 2025 01:02:10 +0530
Message-ID: <20250811193219.731851-2-s-k6@ti.com>
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

From: Pratyush Yadav <pratyush@kernel.org>

Some controllers like the Cadence OSPI controller need to perform a
tuning sequence to operate at high data rates. Tuning is needs to happen
once the device is switched to appropriate mode (say 8S-8S-8S or
8D-8D-8D). Add a hook that spi-mem client devices can call in order to tune
the controller to operate in a given mode and data rate.

This is somewhat similar to eMMC/SD tuning for higher speed modes like
HS200, but there isn't a standard specification around the same though.

Signed-off-by: Pratyush Yadav <pratyush@kernel.org>
Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 drivers/spi/spi-mem.c       | 11 +++++++++++
 include/linux/spi/spi-mem.h |  9 +++++++++
 2 files changed, 20 insertions(+)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index 064b99204d9a..6c254291ee23 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -559,6 +559,17 @@ int spi_mem_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op)
 }
 EXPORT_SYMBOL_GPL(spi_mem_adjust_op_size);
 
+int spi_mem_execute_tuning(struct spi_mem *mem, const struct spi_mem_op *op)
+{
+	struct spi_controller *ctlr = mem->spi->controller;
+
+	if (!ctlr->mem_ops || !ctlr->mem_ops->execute_tuning)
+		return -EOPNOTSUPP;
+
+	return ctlr->mem_ops->execute_tuning(mem, op);
+}
+EXPORT_SYMBOL_GPL(spi_mem_execute_tuning);
+
 /**
  * spi_mem_adjust_op_freq() - Adjust the frequency of a SPI mem operation to
  *			      match controller, PCB and chip limitations
diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
index 82390712794c..639fee61251c 100644
--- a/include/linux/spi/spi-mem.h
+++ b/include/linux/spi/spi-mem.h
@@ -314,6 +314,12 @@ static inline void *spi_mem_get_drvdata(struct spi_mem *mem)
  * @poll_status: poll memory device status until (status & mask) == match or
  *               when the timeout has expired. It fills the data buffer with
  *               the last status value.
+ * @execute_tuning: perform PHY tuning to achieve high speed SPI operations.
+ *		    Should be called after the SPI memory device has been
+ *		    completely initialized. The op passed should contain a
+ *		    template for the read operation used for the device so the
+ *		    controller can decide what type of tuning is required
+ *		    for the type of read op passed.
  *
  * This interface should be implemented by SPI controllers providing an
  * high-level interface to execute SPI memory operation, which is usually the
@@ -344,6 +350,8 @@ struct spi_controller_mem_ops {
 			   unsigned long initial_delay_us,
 			   unsigned long polling_rate_us,
 			   unsigned long timeout_ms);
+	int (*execute_tuning)(struct spi_mem *mem,
+			      const struct spi_mem_op *op);
 };
 
 /**
@@ -423,6 +431,7 @@ bool spi_mem_default_supports_op(struct spi_mem *mem,
 #endif /* CONFIG_SPI_MEM */
 
 int spi_mem_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op);
+int spi_mem_execute_tuning(struct spi_mem *mem, const struct spi_mem_op *op);
 void spi_mem_adjust_op_freq(struct spi_mem *mem, struct spi_mem_op *op);
 u64 spi_mem_calc_op_duration(struct spi_mem *mem, struct spi_mem_op *op);
 
-- 
2.34.1


