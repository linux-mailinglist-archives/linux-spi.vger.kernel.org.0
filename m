Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B42EBF4DC5
	for <lists+linux-spi@lfdr.de>; Fri,  8 Nov 2019 15:07:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729164AbfKHOHw (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 8 Nov 2019 09:07:52 -0500
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:44237 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726616AbfKHOHw (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 8 Nov 2019 09:07:52 -0500
X-Originating-IP: 86.206.246.123
Received: from localhost.localdomain (lfbn-tou-1-421-123.w86-206.abo.wanadoo.fr [86.206.246.123])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 26DDC2000E;
        Fri,  8 Nov 2019 14:07:50 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Mark Brown <broonie@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-spi@vger.kernel.org>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v2 4/7] spi: zynq-qspi: Enhance the Linear CFG bit definitions
Date:   Fri,  8 Nov 2019 15:07:41 +0100
Message-Id: <20191108140744.1734-5-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108140744.1734-1-miquel.raynal@bootlin.com>
References: <20191108140744.1734-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Using masks makes sense when manipulating fields of several bits. When
only one bit is involved, it is usual to just use the BIT() macro but
in this case using the term mask is abusive. Fix the #define macros
and their comments.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/spi/spi-zynq-qspi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-zynq-qspi.c b/drivers/spi/spi-zynq-qspi.c
index 78711fe955f4..1151443ec830 100644
--- a/drivers/spi/spi-zynq-qspi.c
+++ b/drivers/spi/spi-zynq-qspi.c
@@ -99,9 +99,9 @@
  * It is named Linear Configuration but it controls other modes when not in
  * linear mode also.
  */
-#define ZYNQ_QSPI_LCFG_TWO_MEM_MASK	BIT(30) /* LQSPI Two memories Mask */
-#define ZYNQ_QSPI_LCFG_SEP_BUS_MASK	BIT(29) /* LQSPI Separate bus Mask */
-#define ZYNQ_QSPI_LCFG_U_PAGE_MASK	BIT(28) /* LQSPI Upper Page Mask */
+#define ZYNQ_QSPI_LCFG_TWO_MEM		BIT(30) /* LQSPI Two memories */
+#define ZYNQ_QSPI_LCFG_SEP_BUS		BIT(29) /* LQSPI Separate bus */
+#define ZYNQ_QSPI_LCFG_U_PAGE		BIT(28) /* LQSPI Upper Page */
 
 #define ZYNQ_QSPI_LCFG_DUMMY_SHIFT	8
 
-- 
2.20.1

