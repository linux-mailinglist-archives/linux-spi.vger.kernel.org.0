Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5882C18C1F
	for <lists+linux-spi@lfdr.de>; Thu,  9 May 2019 16:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbfEIOkF (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 9 May 2019 10:40:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:48276 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726743AbfEIOkE (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 9 May 2019 10:40:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 93DC0ACBC;
        Thu,  9 May 2019 14:40:03 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Mark Brown <broonie@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-spi@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] spi: bcm2835: only split transfers that exceed DLEN if DMA available
Date:   Thu,  9 May 2019 16:39:59 +0200
Message-Id: <20190509144000.681-1-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

There is no use for this when performing non DMA operations. So we
bypass the split.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 drivers/spi/spi-bcm2835.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index 37893313e595..649fd6caed35 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -861,15 +861,17 @@ static int bcm2835_spi_prepare_message(struct spi_master *master,
 	u32 cs = bcm2835_rd(bs, BCM2835_SPI_CS);
 	int ret;
 
-	/*
-	 * DMA transfers are limited to 16 bit (0 to 65535 bytes) by the SPI HW
-	 * due to DLEN. Split up transfers (32-bit FIFO aligned) if the limit is
-	 * exceeded.
-	 */
-	ret = spi_split_transfers_maxsize(master, msg, 65532,
-					  GFP_KERNEL | GFP_DMA);
-	if (ret)
-		return ret;
+	if (master->can_dma) {
+		/*
+		 * DMA transfers are limited to 16 bit (0 to 65535 bytes) by
+		 * the SPI HW due to DLEN. Split up transfers (32-bit FIFO
+		 * aligned) if the limit is exceeded.
+		 */
+		ret = spi_split_transfers_maxsize(master, msg, 65532,
+						  GFP_KERNEL | GFP_DMA);
+		if (ret)
+			return ret;
+	}
 
 	cs &= ~(BCM2835_SPI_CS_CPOL | BCM2835_SPI_CS_CPHA);
 
-- 
2.21.0

