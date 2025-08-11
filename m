Return-Path: <linux-spi+bounces-9354-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10FDDB21558
	for <lists+linux-spi@lfdr.de>; Mon, 11 Aug 2025 21:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95B7B7A7222
	for <lists+linux-spi@lfdr.de>; Mon, 11 Aug 2025 19:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE2D20298C;
	Mon, 11 Aug 2025 19:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="nBVmKFv3"
X-Original-To: linux-spi@vger.kernel.org
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD574C7F;
	Mon, 11 Aug 2025 19:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754940807; cv=none; b=S/dyrwWIGh486PcuTUBUJSH1g6crABYi/BRScvy8c4xPrd+t3aXpXgdgyRFJPPMAbNoCiZTgC7hiY/9YUeqy105/OblVUXgOYqWTQPy0zTHxt3v0gMVSLrH54QnB9krYwOFy9Qck9iER8VETxkixWTLCXdmnTYrwNzkuYguMK5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754940807; c=relaxed/simple;
	bh=g7Ah1kkIryP4xwbXIfsxZ/qF01cVHEDxpMYQcjcLvC4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GNqY4TEkEhfMs8mnvf0F57jHiDQ6NQd2lGVo0BmnbB6ZovHGr7RgEZKAUr5RHBKpWnpdmen8qT8iWn8G2p4U6q9L7fdWImKQCVA7P5HVDXlgDkCfKM/MoOsr7rBL9tuXjVu5oB3kJLWNu4GvXWKuugmgBLQURfLY0pih/17nHH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=nBVmKFv3; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57BJX6Mr1609373;
	Mon, 11 Aug 2025 14:33:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1754940786;
	bh=GnCw4UgjQY0VUHwgVnP6axN/oo0k5HxGKufTviylG+k=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=nBVmKFv3COW40w1KPfoV2SJsPzFsOb8qPz5uKlRCJUU2uD/aFYKiRJkcxPNTpxIuo
	 +K/RlK/2ejMNduU7cukySSup6Q4KhyvtfuGM9vj+iqLU7C05o8TyX3ZjPbnlNaO8YO
	 2NYp02GbwziBPx9LEIhAG3MB8Kw5Rv4zD+b+jp3s=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57BJX6t22910817
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 11 Aug 2025 14:33:06 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 11
 Aug 2025 14:33:06 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 11 Aug 2025 14:33:06 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [172.24.233.254])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57BJWq1p3690681;
	Mon, 11 Aug 2025 14:33:02 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <broonie@kernel.org>, <tudor.ambarus@linaro.org>,
        <pratyush@kernel.org>, <mwalle@kernel.org>, <p-mantena@ti.com>
CC: <linux-spi@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <s-k6@ti.com>, <a-dutta@ti.com>,
        <u-kumar1@ti.com>, <praneeth@ti.com>
Subject: [RFC PATCH 02/10] spi: spi-mem: Define spi_mem_tuning_params and spi_mem_get_tuning_params()
Date: Tue, 12 Aug 2025 01:02:11 +0530
Message-ID: <20250811193219.731851-3-s-k6@ti.com>
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

Define a structure 'spi_mem_tuning_params' to store the PHY tuning
pattern and size of the pattern. Also, define a function
'spi_mem_get_tuning_params' to retrieve the information from SPI
controller.
This is required as different SPI controller may have different
stress or attack pattern of different length that needs to be read in
order to tune the controller correctly. In absence of such callback,
spi-mem clients can use static tables on the flashes like SFDP or NAND
param page values.

Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 drivers/spi/spi-mem.c       | 11 +++++++++++
 include/linux/spi/spi-mem.h | 14 ++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index 6c254291ee23..cfee5288fc81 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -570,6 +570,17 @@ int spi_mem_execute_tuning(struct spi_mem *mem, const struct spi_mem_op *op)
 }
 EXPORT_SYMBOL_GPL(spi_mem_execute_tuning);
 
+int spi_mem_get_tuning_params(struct spi_mem *mem, struct spi_mem_tuning_params *tuning_params)
+{
+	struct spi_controller *ctlr = mem->spi->controller;
+
+	if (!ctlr->mem_ops || !ctlr->mem_ops->get_tuning_params)
+		return -EOPNOTSUPP;
+
+	return ctlr->mem_ops->get_tuning_params(mem, tuning_params);
+}
+EXPORT_SYMBOL_GPL(spi_mem_get_tuning_params);
+
 /**
  * spi_mem_adjust_op_freq() - Adjust the frequency of a SPI mem operation to
  *			      match controller, PCB and chip limitations
diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
index 639fee61251c..f0e96cd4a6d4 100644
--- a/include/linux/spi/spi-mem.h
+++ b/include/linux/spi/spi-mem.h
@@ -238,6 +238,16 @@ struct spi_mem_dirmap_desc {
 	void *priv;
 };
 
+/**
+ * struct spi_mem_tuning_params - describes the Tuning parameters
+ * @pattern_ptr: pointer to the tuning pattern
+ * @pattern_size: size of the tuning pattern
+ */
+struct spi_mem_tuning_params {
+	u8 *pattern_ptr;
+	unsigned int pattern_size;
+};
+
 /**
  * struct spi_mem - describes a SPI memory device
  * @spi: the underlying SPI device
@@ -352,6 +362,8 @@ struct spi_controller_mem_ops {
 			   unsigned long timeout_ms);
 	int (*execute_tuning)(struct spi_mem *mem,
 			      const struct spi_mem_op *op);
+	int (*get_tuning_params)(struct spi_mem *mem,
+				 struct spi_mem_tuning_params *tuning_params);
 };
 
 /**
@@ -434,6 +446,8 @@ int spi_mem_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op);
 int spi_mem_execute_tuning(struct spi_mem *mem, const struct spi_mem_op *op);
 void spi_mem_adjust_op_freq(struct spi_mem *mem, struct spi_mem_op *op);
 u64 spi_mem_calc_op_duration(struct spi_mem *mem, struct spi_mem_op *op);
+int spi_mem_get_tuning_params(struct spi_mem *mem,
+			      struct spi_mem_tuning_params *tuning_params);
 
 bool spi_mem_supports_op(struct spi_mem *mem,
 			 const struct spi_mem_op *op);
-- 
2.34.1


