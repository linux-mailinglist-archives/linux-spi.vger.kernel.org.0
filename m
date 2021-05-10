Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 309C4377CA9
	for <lists+linux-spi@lfdr.de>; Mon, 10 May 2021 08:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbhEJG7k (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 10 May 2021 02:59:40 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:2611 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbhEJG7j (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 10 May 2021 02:59:39 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FdsKK5BQKzmVDg;
        Mon, 10 May 2021 14:56:21 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Mon, 10 May 2021 14:58:24 +0800
From:   Jay Fang <f.fangjian@huawei.com>
To:     <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <linuxarm@huawei.com>,
        <huangdaode@huawei.com>
Subject: [PATCH 3/4] spi: delete repeated words in comments
Date:   Mon, 10 May 2021 14:58:22 +0800
Message-ID: <1620629903-15493-4-git-send-email-f.fangjian@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1620629903-15493-1-git-send-email-f.fangjian@huawei.com>
References: <1620629903-15493-1-git-send-email-f.fangjian@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Drop repeated words in spi-bcm2835aux.c
{are}

Drop repeated words in spi-dw-mmio.c
{the}

Drop repeated words in spi-geni-qcom.c
{our}

Drop repeated words in spi-pl022.c
{on}

Drop repeated words in spi-ppc4xx.c
{the}

Signed-off-by: Jay Fang <f.fangjian@huawei.com>
---
 drivers/spi/spi-bcm2835aux.c | 2 +-
 drivers/spi/spi-dw-mmio.c    | 2 +-
 drivers/spi/spi-geni-qcom.c  | 4 ++--
 drivers/spi/spi-pl022.c      | 4 ++--
 drivers/spi/spi-ppc4xx.c     | 2 +-
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-bcm2835aux.c b/drivers/spi/spi-bcm2835aux.c
index 75589ac..37eab10 100644
--- a/drivers/spi/spi-bcm2835aux.c
+++ b/drivers/spi/spi-bcm2835aux.c
@@ -384,7 +384,7 @@ static int bcm2835aux_spi_transfer_one(struct spi_master *master,
 	bs->pending = 0;
 
 	/* Calculate the estimated time in us the transfer runs.  Note that
-	 * there are are 2 idle clocks cycles after each chunk getting
+	 * there are 2 idle clocks cycles after each chunk getting
 	 * transferred - in our case the chunk size is 3 bytes, so we
 	 * approximate this by 9 cycles/byte.  This is used to find the number
 	 * of Hz per byte per polling limit.  E.g., we can transfer 1 byte in
diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
index 17c0603..3379720 100644
--- a/drivers/spi/spi-dw-mmio.c
+++ b/drivers/spi/spi-dw-mmio.c
@@ -56,7 +56,7 @@ struct dw_spi_mscc {
 /*
  * The Designware SPI controller (referred to as master in the documentation)
  * automatically deasserts chip select when the tx fifo is empty. The chip
- * selects then needs to be either driven as GPIOs or, for the first 4 using the
+ * selects then needs to be either driven as GPIOs or, for the first 4 using
  * the SPI boot controller registers. the final chip select is an OR gate
  * between the Designware SPI controller and the SPI boot controller.
  */
diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index 3d0d8dd..b3861fb 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -639,8 +639,8 @@ static irqreturn_t geni_spi_isr(int irq, void *data)
 		complete(&mas->abort_done);
 
 	/*
-	 * It's safe or a good idea to Ack all of our our interrupts at the
-	 * end of the function. Specifically:
+	 * It's safe or a good idea to Ack all of our interrupts at the end
+	 * of the function. Specifically:
 	 * - M_CMD_DONE_EN / M_RX_FIFO_LAST_EN: Edge triggered interrupts and
 	 *   clearing Acks. Clearing at the end relies on nobody else having
 	 *   started a new transfer yet or else we could be clearing _their_
diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
index 0c9e3f2..feebda6 100644
--- a/drivers/spi/spi-pl022.c
+++ b/drivers/spi/spi-pl022.c
@@ -288,7 +288,7 @@
 #define SPI_POLLING_TIMEOUT 1000
 
 /*
- * The type of reading going on on this chip
+ * The type of reading going on this chip
  */
 enum ssp_reading {
 	READING_NULL,
@@ -298,7 +298,7 @@ enum ssp_reading {
 };
 
 /*
- * The type of writing going on on this chip
+ * The type of writing going on this chip
  */
 enum ssp_writing {
 	WRITING_NULL,
diff --git a/drivers/spi/spi-ppc4xx.c b/drivers/spi/spi-ppc4xx.c
index 9e39745..76874a7 100644
--- a/drivers/spi/spi-ppc4xx.c
+++ b/drivers/spi/spi-ppc4xx.c
@@ -326,7 +326,7 @@ static void spi_ppc4xx_enable(struct ppc4xx_spi *hw)
 {
 	/*
 	 * On all 4xx PPC's the SPI bus is shared/multiplexed with
-	 * the 2nd I2C bus. We need to enable the the SPI bus before
+	 * the 2nd I2C bus. We need to enable the SPI bus before
 	 * using it.
 	 */
 
-- 
2.7.4

