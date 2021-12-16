Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7720477002
	for <lists+linux-spi@lfdr.de>; Thu, 16 Dec 2021 12:17:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233960AbhLPLRc (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 16 Dec 2021 06:17:32 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:45187 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233940AbhLPLRc (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 16 Dec 2021 06:17:32 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 7AC58E0013;
        Thu, 16 Dec 2021 11:17:29 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Mark Brown <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>,
        <linux-mtd@lists.infradead.org>, Rob Herring <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>
Cc:     Julien Su <juliensu@mxic.com.tw>,
        Jaime Liao <jaimeliao@mxic.com.tw>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v6 19/28] spi: spi-mem: Introduce a capability structure
Date:   Thu, 16 Dec 2021 12:16:45 +0100
Message-Id: <20211216111654.238086-20-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211216111654.238086-1-miquel.raynal@bootlin.com>
References: <20211216111654.238086-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Create a spi_controller_mem_caps structure and put it within the
spi_controller_mem_ops structure as these are highly related. So far the
only field in this structure is the support for dtr operations, but soon
we will add another parameter.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 include/linux/spi/spi-mem.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
index 85e2ff7b840d..42f3850610b5 100644
--- a/include/linux/spi/spi-mem.h
+++ b/include/linux/spi/spi-mem.h
@@ -220,6 +220,14 @@ static inline void *spi_mem_get_drvdata(struct spi_mem *mem)
 	return mem->drvpriv;
 }
 
+/**
+ * struct spi_controller_mem_caps - SPI memory controller capabilities
+ * @dtr: Supports DTR operations
+ */
+struct spi_controller_mem_caps {
+	bool dtr;
+};
+
 /**
  * struct spi_controller_mem_ops - SPI memory operations
  * @adjust_op_size: shrink the data xfer of an operation to match controller's
@@ -253,6 +261,7 @@ static inline void *spi_mem_get_drvdata(struct spi_mem *mem)
  * @poll_status: poll memory device status until (status & mask) == match or
  *               when the timeout has expired. It fills the data buffer with
  *               the last status value.
+ * @caps: controller capabilities for the handling of the above operations.
  *
  * This interface should be implemented by SPI controllers providing an
  * high-level interface to execute SPI memory operation, which is usually the
@@ -283,6 +292,7 @@ struct spi_controller_mem_ops {
 			   unsigned long initial_delay_us,
 			   unsigned long polling_rate_us,
 			   unsigned long timeout_ms);
+	const struct spi_controller_mem_caps *caps;
 };
 
 /**
-- 
2.27.0

