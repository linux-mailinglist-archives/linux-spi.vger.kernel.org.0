Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE7552713D1
	for <lists+linux-spi@lfdr.de>; Sun, 20 Sep 2020 13:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbgITLbT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 20 Sep 2020 07:31:19 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:53626 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgITL32 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 20 Sep 2020 07:29:28 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 3DBE5803202F;
        Sun, 20 Sep 2020 11:29:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Tf-Ejg2CsboI; Sun, 20 Sep 2020 14:29:24 +0300 (MSK)
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Mark Brown <broonie@kernel.org>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        "wuxu . wu" <wuxu.wu@huawei.com>, Feng Tang <feng.tang@intel.com>,
        Rob Herring <robh+dt@kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 04/30] Revert: spi: spi-dw: Add lock protect dw_spi rx/tx to prevent concurrent calls
Date:   Sun, 20 Sep 2020 14:28:48 +0300
Message-ID: <20200920112914.26501-5-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20200920112914.26501-1-Sergey.Semin@baikalelectronics.ru>
References: <20200920112914.26501-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

There is no point in having the commit 19b61392c5a8 ("spi: spi-dw: Add
lock protect dw_spi rx/tx to prevent concurrent calls") applied. The
commit author made an assumption that the problem with the rx data
mismatch was due to the lack of the data protection. While most likely it
was caused by the lack of the memory barrier. So having the
commit bfda044533b2 ("spi: dw: use "smp_mb()" to avoid sending spi data
error") applied would be enough to fix the problem.

Indeed the spin unlock operation makes sure each memory operation issued
before the release will be completed before it's completed. In other words
it works as an implicit one way memory barrier. So having both smp_mb()
and the spin_unlock_irqrestore() here is just redundant. One of them would
be enough. It's better to leave the smp_mb() since the Tx/Rx buffers
consistency is provided by the data transfer algorithm implementation:
first we initialize the buffers pointers, then make sure the assignments
are visible by the other CPUs by calling the smp_mb(), only after that
enable the interrupt, which handler uses the buffers.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

---

Folks. I have also a doubt whether the SMP memory barrier is required there
because the normal IO-methods like readl/writel imply a full memory barrier. So
any memory operation performed before them are supposed to be seen by devices
and another CPUs [1]. So most likely there could have been a problem with those
IOs implementation on the subject platform or a spurious interrupt could
have been raised during the data initialization. What do you think?
Am I missing something?

[1] "LINUX KERNEL MEMORY BARRIERS", Documentation/memory-barriers.txt,
    Section "KERNEL I/O BARRIER EFFECTS"
---
 drivers/spi/spi-dw-core.c | 14 ++------------
 drivers/spi/spi-dw.h      |  1 -
 2 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index 1af74362461d..18411f5b9954 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -142,11 +142,9 @@ static inline u32 rx_max(struct dw_spi *dws)
 
 static void dw_writer(struct dw_spi *dws)
 {
-	u32 max;
+	u32 max = tx_max(dws);
 	u16 txw = 0;
 
-	spin_lock(&dws->buf_lock);
-	max = tx_max(dws);
 	while (max--) {
 		/* Set the tx word if the transfer's original "tx" is not null */
 		if (dws->tx_end - dws->len) {
@@ -158,16 +156,13 @@ static void dw_writer(struct dw_spi *dws)
 		dw_write_io_reg(dws, DW_SPI_DR, txw);
 		dws->tx += dws->n_bytes;
 	}
-	spin_unlock(&dws->buf_lock);
 }
 
 static void dw_reader(struct dw_spi *dws)
 {
-	u32 max;
+	u32 max = rx_max(dws);
 	u16 rxw;
 
-	spin_lock(&dws->buf_lock);
-	max = rx_max(dws);
 	while (max--) {
 		rxw = dw_read_io_reg(dws, DW_SPI_DR);
 		/* Care rx only if the transfer's original "rx" is not null */
@@ -179,7 +174,6 @@ static void dw_reader(struct dw_spi *dws)
 		}
 		dws->rx += dws->n_bytes;
 	}
-	spin_unlock(&dws->buf_lock);
 }
 
 static void int_error_stop(struct dw_spi *dws, const char *msg)
@@ -291,21 +285,18 @@ static int dw_spi_transfer_one(struct spi_controller *master,
 {
 	struct dw_spi *dws = spi_controller_get_devdata(master);
 	struct chip_data *chip = spi_get_ctldata(spi);
-	unsigned long flags;
 	u8 imask = 0;
 	u16 txlevel = 0;
 	u32 cr0;
 	int ret;
 
 	dws->dma_mapped = 0;
-	spin_lock_irqsave(&dws->buf_lock, flags);
 	dws->n_bytes = DIV_ROUND_UP(transfer->bits_per_word, BITS_PER_BYTE);
 	dws->tx = (void *)transfer->tx_buf;
 	dws->tx_end = dws->tx + transfer->len;
 	dws->rx = transfer->rx_buf;
 	dws->rx_end = dws->rx + transfer->len;
 	dws->len = transfer->len;
-	spin_unlock_irqrestore(&dws->buf_lock, flags);
 
 	/* Ensure dw->rx and dw->rx_end are visible */
 	smp_mb();
@@ -464,7 +455,6 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
 	dws->master = master;
 	dws->type = SSI_MOTO_SPI;
 	dws->dma_addr = (dma_addr_t)(dws->paddr + DW_SPI_DR);
-	spin_lock_init(&dws->buf_lock);
 
 	spi_controller_set_devdata(master, dws);
 
diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index 51bab30b9f85..1ab704d1ebd8 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -131,7 +131,6 @@ struct dw_spi {
 	size_t			len;
 	void			*tx;
 	void			*tx_end;
-	spinlock_t		buf_lock;
 	void			*rx;
 	void			*rx_end;
 	int			dma_mapped;
-- 
2.27.0

