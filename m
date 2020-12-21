Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 423482E01E3
	for <lists+linux-spi@lfdr.de>; Mon, 21 Dec 2020 22:18:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbgLUVS3 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 21 Dec 2020 16:18:29 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:16136 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726413AbgLUVS2 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 21 Dec 2020 16:18:28 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fe110fc0001>; Mon, 21 Dec 2020 13:17:48 -0800
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 21 Dec
 2020 21:17:43 +0000
Received: from skomatineni-linux.nvidia.com (172.20.145.6) by mail.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Mon, 21 Dec 2020 21:17:43 +0000
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>, <lukas@wunner.de>
CC:     <skomatineni@nvidia.com>, <bbrezillon@kernel.org>,
        <p.yadav@ti.com>, <tudor.ambarus@microchip.com>,
        <linux-spi@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v5 5/9] spi: spi-mem: Mark dummy transfers by setting dummy_data bit
Date:   Mon, 21 Dec 2020 13:17:35 -0800
Message-ID: <1608585459-17250-6-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1608585459-17250-1-git-send-email-skomatineni@nvidia.com>
References: <1608585459-17250-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1608585468; bh=6bx+wsy3UKNOmMAtBxcV/nZjihJYWCwQ1WcNk7bO2Rk=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:X-NVConfidentiality:MIME-Version:Content-Type;
        b=CtkLdERtK+V6VDnoAVsWnMEWoXndfJeyfntB7L8UhQVYH+i390PtNXM9ZV9wMbBml
         WhLmhAh6TJl3norWHCBxFqVMkZK15bgJM3Qg7F6iSEpkzpTklFi8Ty4LAXqxAgj4Vl
         QPjiFTWzNQGQKqKEimfFbRsRHjYuBIROEHyEm8aSf6KTv410uugIRqua49RJOLYAkq
         n4Ijxuu61KkHBpa+5sCJDulWcm6xBl2BHRsEdoT442M4H3myaWChoUJ0fzCBBcIf18
         29KjNVUezU1kdRk6zHd8mg1NrhFFYDW4URqWtMKUCr4aaVgz5uK3npWh6+RnqQ0L6h
         nQ0Ky+DMhVkOw==
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This patch marks dummy transfer by setting dummy_data bit to 1.

Controllers supporting dummy transfer by hardware use this bit field
to skip software transfer of dummy bytes and use hardware dummy bytes
transfer.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/spi/spi-mem.c   | 1 +
 include/linux/spi/spi.h | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index f3a3f19..c64371c 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -354,6 +354,7 @@ int spi_mem_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 		xfers[xferpos].tx_buf = tmpbuf + op->addr.nbytes + 1;
 		xfers[xferpos].len = op->dummy.nbytes;
 		xfers[xferpos].tx_nbits = op->dummy.buswidth;
+		xfers[xferpos].dummy_data = 1;
 		spi_message_add_tail(&xfers[xferpos], &msg);
 		xferpos++;
 		totalxferlen += op->dummy.nbytes;
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index aa09fdc..708f2f5 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -827,6 +827,7 @@ extern void spi_res_release(struct spi_controller *ctlr,
  *      transfer. If 0 the default (from @spi_device) is used.
  * @bits_per_word: select a bits_per_word other than the device default
  *      for this transfer. If 0 the default (from @spi_device) is used.
+ * @dummy_data: indicates transfer is dummy bytes transfer.
  * @cs_change: affects chipselect after this transfer completes
  * @cs_change_delay: delay between cs deassert and assert when
  *      @cs_change is set and @spi_transfer is not the last in @spi_message
@@ -939,6 +940,7 @@ struct spi_transfer {
 	struct sg_table tx_sg;
 	struct sg_table rx_sg;
 
+	unsigned	dummy_data:1;
 	unsigned	cs_change:1;
 	unsigned	tx_nbits:3;
 	unsigned	rx_nbits:3;
-- 
2.7.4

