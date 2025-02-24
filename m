Return-Path: <linux-spi+bounces-6893-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4236EA41FCB
	for <lists+linux-spi@lfdr.de>; Mon, 24 Feb 2025 14:01:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BAC93A57EA
	for <lists+linux-spi@lfdr.de>; Mon, 24 Feb 2025 12:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5EFE11185;
	Mon, 24 Feb 2025 12:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="OJZR1rd+"
X-Original-To: linux-spi@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89612571A1;
	Mon, 24 Feb 2025 12:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740401751; cv=none; b=Bz4aXg122y6X/9fG1IbsPtSbnlnwtdhz+LPWmkCFSshoT2BvQ6JaPUK0sA41UGa9XZpiiWy//KoHr/8LC9f9cbbnqnWRSCzIWGtmebk2e7r/+4RzG+S83L3ExtDIYGU0Vl/pEqeiQF6rMK70+fst1K0JZX/RzAVySHrIjC/FPjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740401751; c=relaxed/simple;
	bh=2FOD7ueO1lpP0lFcbQNPAEJ9bOQMhzziN7e+H5DRTgU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=das+ETpjW2xie1mcB4kBtBvB0LMUdDFKSGNd/BsCSi1XjGiCAAV6ezK7EhwRJh9Nn8xhRA1PKMr+ioXpVzYcVNXbbAKNQUzYCrrrdpKnuDXriKx8tthvgxQjZa9WBRYcHDxpPG+7W4gxsWJ9tYZCz4WdgyXROEQg2bZsgrwYwgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=OJZR1rd+; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1740401750; x=1771937750;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2FOD7ueO1lpP0lFcbQNPAEJ9bOQMhzziN7e+H5DRTgU=;
  b=OJZR1rd+s6Crlc1EaqDTuVtx2agy8hCFq76eSBWh6rXDndqLcb9Lp+Hq
   30hoqusUBQ0SnfA6C55HeHy8+UzBu2AZjBmpiK3babNY1ORIyRdkhO9h2
   CeGNUXzcvgEuk1VGEj+YC2yVo4G3oYks1ACAdRTmicxpWjsESQYODbUN2
   +MS9S/vr16nG8yjUtRXWS+UPwSnn4wnzqBpSs3GJzBENtA+nC3QAm/Qbo
   AV/mH+ZIhYay/djFU1K/WyL8jYE2af5ErFWpXDbYUJnC+hBPWCBamuPSQ
   GNl2kqzd2XfnSMCucmFi1CzpCrpo0pvPq619IQL7Mkx4Qalq1hr6qe+7z
   Q==;
X-CSE-ConnectionGUID: /8fsfx1RQVGJXkJVz/DYcQ==
X-CSE-MsgGUID: VzYruJjPTO+HV1b/5yIYgg==
X-IronPort-AV: E=Sophos;i="6.13,309,1732604400"; 
   d="scan'208";a="38044922"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Feb 2025 05:55:49 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 24 Feb 2025 05:55:28 -0700
Received: from che-dk-ungapp03lx.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 24 Feb 2025 05:55:26 -0700
From: Rengarajan S <rengarajan.s@microchip.com>
To: <unglinuxdriver@microchip.com>, <broonie@kernel.org>,
	<linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <rengarajan.s@microchip.com>
Subject: [PATCH v1 for-next] spi: mchp-pci1xxxx: Updated memcpy implementation for x64 and bcm2711 processors
Date: Mon, 24 Feb 2025 18:21:53 +0530
Message-ID: <20250224125153.13728-1-rengarajan.s@microchip.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

In Raspberry-pi CM4 devices with BCM2711 processor, the documentation
points to a limitation with 64-bit accesses. Using memcpy_fromio and
memcpy_toio for each 64-bit SPI read/write causes the first 4 bytes to be
repeated. To address the limitation, each read/write is limited to 4
bytes in case of BCM2711 processors.

On x64 systems, using memcpy_toio and memcpy_fromio results in 4-byte TLP
writes instead of 8-byte. Add the custom IO write and read for enabling
64-bit access by default.

Tested and verified performance improvement on x64 devices while
transferring 1024 bytes for 20000 iterations at 25 MHz clock frequency:

Test 1: With memcpy_fromio and memcpy_toio
spi mode: 0x0
bits per word: 8
max speed: 25000000 Hz (25000 kHz)
rate: tx 6232.5kbps, rx 6232.5kbps
rate: tx 6889.5kbps, rx 6889.5kbps
rate: tx 6765.0kbps, rx 6765.0kbps
rate: tx 6873.1kbps, rx 6873.1kbps
total: tx 20000.0KB, rx 20000.0KB

Test 2: With the custom IO write and read
spi mode: 0x0
bits per word: 8
max speed: 25000000 Hz (25000 kHz)
rate: tx 9774.7kbps, rx 9774.7kbps
rate: tx 10985.5kbps, rx 10985.5kbps
rate: tx 10749.5kbps, rx 10749.5kbps
total: tx 20000.0KB, rx 20000.0KB

Signed-off-by: Rengarajan S <rengarajan.s@microchip.com>
---
 drivers/spi/spi-pci1xxxx.c | 95 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 91 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-pci1xxxx.c b/drivers/spi/spi-pci1xxxx.c
index fc98979eba48..ae1d76f03268 100644
--- a/drivers/spi/spi-pci1xxxx.c
+++ b/drivers/spi/spi-pci1xxxx.c
@@ -12,6 +12,7 @@
 #include <linux/irq.h>
 #include <linux/module.h>
 #include <linux/msi.h>
+#include <linux/of.h>
 #include <linux/pci_regs.h>
 #include <linux/pci.h>
 #include <linux/spinlock.h>
@@ -407,6 +408,68 @@ static void pci1xxxx_start_spi_xfer(struct pci1xxxx_spi_internal *p, u8 hw_inst)
 	writel(regval, p->parent->reg_base + SPI_MST_CTL_REG_OFFSET(hw_inst));
 }
 
+static void pci1xxxx_spi_write_to_io(void __iomem *to, const void *from,
+				     size_t count, size_t size)
+{
+	while (count) {
+		if (size == 8 && (IS_ALIGNED((unsigned long)to, 8)) &&
+		    count >= 8) {
+			__raw_writeq(*(u64 *)from, to);
+			from += 8;
+			to += 8;
+			count -= 8;
+		} else if (size >= 4 && (IS_ALIGNED((unsigned long)to, 4)) &&
+			   count >= 4) {
+			__raw_writel(*(u32 *)from, to);
+			from += 4;
+			to += 4;
+			count -= 4;
+		} else if (size >= 2 && (IS_ALIGNED((unsigned long)to, 2)) &&
+			   count >= 2) {
+			__raw_writew(*(u16 *)from, to);
+			from += 2;
+			to += 2;
+			count -= 2;
+		} else {
+			__raw_writeb(*(u8 *)from, to);
+			from += 1;
+			to += 1;
+			count -= 1;
+		}
+	}
+}
+
+static void pci1xxxx_spi_read_from_io(void *to, const void __iomem *from,
+				      size_t count, size_t size)
+{
+	while (count) {
+		if (size == 8 && (IS_ALIGNED((unsigned long)from, 8)) &&
+		    count >= 8) {
+			*(u64 *)to = __raw_readq(from);
+			from += 8;
+			to += 8;
+			count -= 8;
+		} else if (size >= 4 && (IS_ALIGNED((unsigned long)from, 4)) &&
+			   count >= 4) {
+			*(u32 *)to = __raw_readl(from);
+			from += 4;
+			to += 4;
+			count -= 4;
+		} else if (size >= 2 && (IS_ALIGNED((unsigned long)from, 2)) &&
+			   count >= 2) {
+			*(u16 *)to = __raw_readw(from);
+			from += 2;
+			to += 2;
+			count -= 2;
+		} else {
+			*(u8 *)to = __raw_readb(from);
+			from += 1;
+			to += 1;
+			count -= 1;
+		}
+	}
+}
+
 static int pci1xxxx_spi_transfer_with_io(struct spi_controller *spi_ctlr,
 					 struct spi_device *spi, struct spi_transfer *xfer)
 {
@@ -444,8 +507,23 @@ static int pci1xxxx_spi_transfer_with_io(struct spi_controller *spi_ctlr,
 				len = transfer_len % SPI_MAX_DATA_LEN;
 
 			reinit_completion(&p->spi_xfer_done);
-			memcpy_toio(par->reg_base + SPI_MST_CMD_BUF_OFFSET(p->hw_inst),
-				    &tx_buf[bytes_transfered], len);
+			/*
+			 * Raspberry Pi CM4 BCM2711 doesn't support 64-bit
+			 * accesses.
+			 */
+			if (of_machine_is_compatible("brcm,bcm2711")) {
+				pci1xxxx_spi_write_to_io(par->reg_base +
+							 SPI_MST_CMD_BUF_OFFSET
+							 (p->hw_inst),
+							 &tx_buf[bytes_transfered],
+							 len, 4);
+			} else {
+				pci1xxxx_spi_write_to_io(par->reg_base +
+							 SPI_MST_CMD_BUF_OFFSET
+							 (p->hw_inst),
+							 &tx_buf[bytes_transfered],
+							 len, 8);
+			}
 			bytes_transfered += len;
 			pci1xxxx_spi_setup(par, p->hw_inst, spi->mode, clkdiv, len);
 			pci1xxxx_start_spi_xfer(p, p->hw_inst);
@@ -457,8 +535,17 @@ static int pci1xxxx_spi_transfer_with_io(struct spi_controller *spi_ctlr,
 				return -ETIMEDOUT;
 
 			if (rx_buf) {
-				memcpy_fromio(&rx_buf[bytes_recvd], par->reg_base +
-					      SPI_MST_RSP_BUF_OFFSET(p->hw_inst), len);
+				if (of_machine_is_compatible("brcm,bcm2711")) {
+					pci1xxxx_spi_read_from_io(&rx_buf[bytes_recvd],
+								  par->reg_base +
+								  SPI_MST_RSP_BUF_OFFSET
+								  (p->hw_inst), len, 4);
+				} else {
+					pci1xxxx_spi_read_from_io(&rx_buf[bytes_recvd],
+								  par->reg_base +
+								  SPI_MST_RSP_BUF_OFFSET
+								  (p->hw_inst), len, 8);
+				}
 				bytes_recvd += len;
 			}
 		}
-- 
2.25.1


