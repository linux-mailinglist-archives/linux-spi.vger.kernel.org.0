Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 805A9F452C
	for <lists+linux-spi@lfdr.de>; Fri,  8 Nov 2019 11:59:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730616AbfKHK73 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 8 Nov 2019 05:59:29 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:45975 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730224AbfKHK73 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 8 Nov 2019 05:59:29 -0500
X-Originating-IP: 86.206.246.123
Received: from localhost.localdomain (lfbn-tou-1-421-123.w86-206.abo.wanadoo.fr [86.206.246.123])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id E13E7E0009;
        Fri,  8 Nov 2019 10:59:26 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Mark Brown <broonie@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-spi@vger.kernel.org>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 4/7] spi: zynq-qspi: Enhance the Linear CFG bit definitions
Date:   Fri,  8 Nov 2019 11:59:17 +0100
Message-Id: <20191108105920.19014-5-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108105920.19014-1-miquel.raynal@bootlin.com>
References: <20191108105920.19014-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Using masks makes sense when manipulating fields of several bits. When
only one bit is involved, let's just use the BIT() macro to define the
actual bit instead of the needed shift to obtain it and use a better
naming.

These definitions will be used in a following change.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/spi/spi-zynq-qspi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-zynq-qspi.c b/drivers/spi/spi-zynq-qspi.c
index 11a484aa3186..34c24b2ad3cf 100644
--- a/drivers/spi/spi-zynq-qspi.c
+++ b/drivers/spi/spi-zynq-qspi.c
@@ -99,9 +99,9 @@
  * It is named Linear Configuration but it controls other modes when not in
  * linear mode also.
  */
-#define ZYNQ_QSPI_LCFG_TWO_MEM_MASK	0x40000000 /* LQSPI Two memories Mask */
-#define ZYNQ_QSPI_LCFG_SEP_BUS_MASK	0x20000000 /* LQSPI Separate bus Mask */
-#define ZYNQ_QSPI_LCFG_U_PAGE_MASK	0x10000000 /* LQSPI Upper Page Mask */
+#define ZYNQ_QSPI_LCFG_TWO_MEM		BIT(30) /* LQSPI Two memories */
+#define ZYNQ_QSPI_LCFG_SEP_BUS		BIT(29) /* LQSPI Separate bus */
+#define ZYNQ_QSPI_LCFG_U_PAGE		BIT(28) /* LQSPI Upper Page */
 
 #define ZYNQ_QSPI_LCFG_DUMMY_SHIFT	8
 
-- 
2.20.1

