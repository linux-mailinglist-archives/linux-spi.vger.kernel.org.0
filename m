Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BE0B2D7C32
	for <lists+linux-spi@lfdr.de>; Fri, 11 Dec 2020 18:05:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393414AbgLKRDj (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 11 Dec 2020 12:03:39 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:5171 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393257AbgLKRDG (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 11 Dec 2020 12:03:06 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fd3a5f00000>; Fri, 11 Dec 2020 09:01:36 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 11 Dec
 2020 17:01:35 +0000
Received: from skomatineni-linux.nvidia.com (172.20.145.6) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Fri, 11 Dec 2020 17:01:35 +0000
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>, <lukas@wunner.de>
CC:     <skomatineni@nvidia.com>, <linux-spi@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v2 5/9] spi: spi-mem: Allow masters to transfer dummy cycles directly by hardware
Date:   Fri, 11 Dec 2020 09:01:24 -0800
Message-ID: <1607706088-1437-8-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1607706088-1437-1-git-send-email-skomatineni@nvidia.com>
References: <1607706088-1437-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1607706096; bh=w3ehnwe0omM34FaObddURkJNKGQctD+ZomRiDYg+fkY=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:X-NVConfidentiality:MIME-Version:Content-Type;
        b=M3QtDGJ0G+ShIS2KqrK5wZz8VU8My4IP/kP7qgLkbEN9RveXHb+BLDuafNnSEfepb
         Jl/1QcV4ALz/6ulU1WiQXFUJz49nEI4AcFnx+CMZcYhShgSI80dlbGjxnri0AB1bSs
         Xib4karOu1aK6Y/NxIZHAvryLIkpyXPHvBWqXN0rdFPPboa6u7MxFrILOhcnzXz+Vt
         DHRgp4UV18Pms2tOZlUAtF303lwzpdfISmpiUTh8+NhrBGtTH8Mrvg4o2WbZwbeJxG
         1fjnN9/qTEq7LULCLS4CYb7ge6SVuNbuCJ+O2vKBJr5CHYH2f1OUaL4C6ODj+3n6FK
         Jhz2B4tLt2nbQ==
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This patch adds a flag SPI_MASTER_USES_HW_DUMMY_CYCLES for the controllers
that support transfer of dummy cycles by the hardware directly.

For controller with this flag set, spi-mem driver will skip dummy bytes
transfer in the spi message.

Controller drivers can get the number of dummy cycles from spi_message.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/spi/spi-mem.c   | 18 +++++++++++-------
 include/linux/spi/spi.h |  8 ++++++++
 2 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index f3a3f19..38a523b 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -350,13 +350,17 @@ int spi_mem_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 	}
 
 	if (op->dummy.nbytes) {
-		memset(tmpbuf + op->addr.nbytes + 1, 0xff, op->dummy.nbytes);
-		xfers[xferpos].tx_buf = tmpbuf + op->addr.nbytes + 1;
-		xfers[xferpos].len = op->dummy.nbytes;
-		xfers[xferpos].tx_nbits = op->dummy.buswidth;
-		spi_message_add_tail(&xfers[xferpos], &msg);
-		xferpos++;
-		totalxferlen += op->dummy.nbytes;
+		if (ctlr->flags & SPI_MASTER_USES_HW_DUMMY_CYCLES) {
+			msg.dummy_cycles = (op->dummy.nbytes * 8) / op->dummy.buswidth;
+		} else {
+			memset(tmpbuf + op->addr.nbytes + 1, 0xff, op->dummy.nbytes);
+			xfers[xferpos].tx_buf = tmpbuf + op->addr.nbytes + 1;
+			xfers[xferpos].len = op->dummy.nbytes;
+			xfers[xferpos].tx_nbits = op->dummy.buswidth;
+			spi_message_add_tail(&xfers[xferpos], &msg);
+			xferpos++;
+			totalxferlen += op->dummy.nbytes;
+		}
 	}
 
 	if (op->data.nbytes) {
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index aa09fdc..2024149 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -512,6 +512,8 @@ struct spi_controller {
 
 #define SPI_MASTER_GPIO_SS		BIT(5)	/* GPIO CS must select slave */
 
+#define SPI_MASTER_USES_HW_DUMMY_CYCLES	BIT(6)	/* HW dummy bytes transfer */
+
 	/* flag indicating this is an SPI slave controller */
 	bool			slave;
 
@@ -1022,6 +1024,12 @@ struct spi_message {
 	unsigned		actual_length;
 	int			status;
 
+	/*
+	 * dummy cycles in the message transfer. This is used by the controller
+	 * drivers supports transfer of dummy cycles directly by the hardware.
+	 */
+	u8			dummy_cycles;
+
 	/* for optional use by whatever driver currently owns the
 	 * spi_message ...  between calls to spi_async and then later
 	 * complete(), that's the spi_controller controller driver.
-- 
2.7.4

