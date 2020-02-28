Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61CA3173B46
	for <lists+linux-spi@lfdr.de>; Fri, 28 Feb 2020 16:23:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbgB1PXN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 28 Feb 2020 10:23:13 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:40906 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726940AbgB1PXG (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 28 Feb 2020 10:23:06 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id E895CBCDD998B0D1E4CE;
        Fri, 28 Feb 2020 23:22:53 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.439.0; Fri, 28 Feb 2020 23:22:44 +0800
From:   John Garry <john.garry@huawei.com>
To:     <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>,
        <andriy.shevchenko@linux.intel.com>, <linuxarm@huawei.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH RFC 1/3] spi: Allow SPI controller override device buswidth
Date:   Fri, 28 Feb 2020 23:18:49 +0800
Message-ID: <1582903131-160033-2-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1582903131-160033-1-git-send-email-john.garry@huawei.com>
References: <1582903131-160033-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Currently ACPI firmware description for a SPI device does not have any
method to describe the data buswidth on the board.

So even through the controller and device may support higher modes than
standard SPI, it cannot be assumed that the board does - as such, that
device is limited to standard SPI in such a circumstance.

As a workaround, allow the controller driver supply buswidth override bits,
which are used inform the core code that the controller driver knows the
buswidth supported on that board for that device.

A host controller driver might know this info from DMI tables, for example.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/spi/spi.c       | 4 +++-
 include/linux/spi/spi.h | 3 +++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 38b4c78df506..292f26807b41 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -510,6 +510,7 @@ struct spi_device *spi_alloc_device(struct spi_controller *ctlr)
 	spi->dev.bus = &spi_bus_type;
 	spi->dev.release = spidev_release;
 	spi->cs_gpio = -ENOENT;
+	spi->mode = ctlr->buswidth_override_bits;
 
 	spin_lock_init(&spi->statistics.lock);
 
@@ -2181,9 +2182,10 @@ static acpi_status acpi_register_spi_device(struct spi_controller *ctlr,
 		return AE_NO_MEMORY;
 	}
 
+
 	ACPI_COMPANION_SET(&spi->dev, adev);
 	spi->max_speed_hz	= lookup.max_speed_hz;
-	spi->mode		= lookup.mode;
+	spi->mode		|= lookup.mode;
 	spi->irq		= lookup.irq;
 	spi->bits_per_word	= lookup.bits_per_word;
 	spi->chip_select	= lookup.chip_select;
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 6d16ba01ff5a..600e3793303e 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -481,6 +481,9 @@ struct spi_controller {
 	/* spi_device.mode flags understood by this controller driver */
 	u32			mode_bits;
 
+	/* spi_device.mode flags override flags for this controller */
+	u32			buswidth_override_bits;
+
 	/* bitmask of supported bits_per_word for transfers */
 	u32			bits_per_word_mask;
 #define SPI_BPW_MASK(bits) BIT((bits) - 1)
-- 
2.17.1

