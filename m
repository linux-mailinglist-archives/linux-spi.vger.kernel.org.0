Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EFA52AA360
	for <lists+linux-spi@lfdr.de>; Sat,  7 Nov 2020 09:14:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727886AbgKGIOi (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 7 Nov 2020 03:14:38 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:57208 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727810AbgKGIOi (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 7 Nov 2020 03:14:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1604736877; x=1636272877;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6b+MfY7Lnw6uLwvcAlOQrQcVcVnJvNY26Ca7SXPyL/Q=;
  b=ioChVHyc7hSArtXZbt9ah29uDuB+BbTtOKe7jrQto0USnRsvOhwZlb47
   r+FT8gH8x5RfsXW6PXHrv+bSyPgfC23zHRaZtBz+JGG4f4M9UPaU8Osw7
   aKAmIVPpWj3dBY/yveKvkTJq/q+ImKJ/5eqzZZuI0ePvCCeKqvAFjLSXS
   BbUeA+VVPIzGQSg74IGGULogi7DgnayjqDG5Ji7+WRQgvKPa+Hhiw/mSW
   fBn1B2UfyvJPV3G9uVHaTxUYuTEpWBCIbjsNdGQ3Rr7Rrae5Z/HY/1jX8
   9X+T3i1n+RT1Yzfqe5rwmF1x3KvUDqvlGN66PptxsB4YiHUf1YRMBekVg
   A==;
IronPort-SDR: TAn5cp3r5TAU4Oto8TkIMU+ST3Z49BoyXXJzjYo4l2iN4hrSVl8wtGPS6z4C23YWBOKRTuS9tN
 kbocRFoNmPPGLiMEDuowHz2Q5YLiqEB81uTqsB7OLy+Y2e70c1eNvg7JUrIA9GcjkPgsHB20Vq
 CGu+79NkmvwNr3onpglZSGQhPhGLNTvcodtxAAwbiNgCe2cEScdIPMpmes2enD8eGr6d+ggsSm
 QNbeTMdtaE0UL1kzQljjQaOwziytCBkbhea1wAZRbtffKjl72lsmFFqyNvs8fQpGnJVfL47PDx
 S+E=
X-IronPort-AV: E=Sophos;i="5.77,459,1596470400"; 
   d="scan'208";a="156564367"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Nov 2020 16:14:37 +0800
IronPort-SDR: OJ2ye+09Fu47BaM8gl+/I/TCLcSl/QL8cB5d98MKKUk7aebTyytPcVL8cBUrt073p7vw/EprZ2
 pDN2c2aCWDuaxwLftiWDlUyINoDrKPJkL1JKvuXzU0aEjd1qFbHrsHa+4ccacFgjDTauxjCuDc
 EwtJYWlRt8Ksa5mQjdKtdZoh3XcdaU+xiI9ABi6CTY+0qLNR3zrEGUXzveXjqCI5VqwNR9t0mB
 PguDwiBMUxW8R+SyI/ffG5p61KsPgkY76SYUZnwpH29rS09KFUZQRYX6ZqODcz8EUyRzDoHK+Z
 l9dcAq+MSwH/SA5/V8dGlrVY
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2020 23:59:28 -0800
IronPort-SDR: NSr+fi+441D/Y1RoTNH84IS+7KXzRlrA3vPMRV0+N1CX0PR26ZSjF+sMYjPwDRUPIEcZkz2Rbf
 jOMvNeSaoWy5oTVBlfqzCSFG+qD34T8/i7rhLqC5WioI2B6JKCjiAldHzLUdDiP+K0dRgmzVR5
 G7hWuCLS6zsopefhObrpOae58CT5kaAQcUMZlbU/y2+dGZTsv1TbDx3jfSG5IMmNBjkZE5nMhn
 hSsR1Y1ir8AlX6JL+I/oSvG69ZIVrsLipi/Dyaa0esLFacgkelsNRm8M5rORI1GwilWaJfkd0d
 Ex8=
WDCIronportException: Internal
Received: from hdrdzf2.ad.shared (HELO twashi.fujisawa.hgst.com) ([10.84.71.85])
  by uls-op-cesaip01.wdc.com with ESMTP; 07 Nov 2020 00:14:35 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Sean Anderson <seanga2@gmail.com>
Subject: [PATCH 05/32] spi: dw: Introduce DW_SPI_CAP_POLL_NODELAY
Date:   Sat,  7 Nov 2020 17:13:53 +0900
Message-Id: <20201107081420.60325-6-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201107081420.60325-1-damien.lemoal@wdc.com>
References: <20201107081420.60325-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On slow systems, i.e. systems with a slow CPU resulting in slow context
switches, calling spi_delay_exec() when executing polled transfers
using dw_spi_poll_transfer() can lead to RX FIFO overflows. Allow
platforms to opt out of delayed polling by introducing the
DW_SPI_CAP_POLL_NODELAY DW SPI capability flag to disable
the execution of spi_delay_exec() in dw_spi_poll_transfer().

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 drivers/spi/spi-dw-core.c | 12 ++++++++----
 drivers/spi/spi-dw.h      |  1 +
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index c2ef1d8d46d5..16a6fd569145 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -385,14 +385,18 @@ static int dw_spi_poll_transfer(struct dw_spi *dws,
 	u16 nbits;
 	int ret;
 
-	delay.unit = SPI_DELAY_UNIT_SCK;
-	nbits = dws->n_bytes * BITS_PER_BYTE;
+	if (!(dws->caps & DW_SPI_CAP_POLL_NODELAY)) {
+		delay.unit = SPI_DELAY_UNIT_SCK;
+		nbits = dws->n_bytes * BITS_PER_BYTE;
+	}
 
 	do {
 		dw_writer(dws);
 
-		delay.value = nbits * (dws->rx_len - dws->tx_len);
-		spi_delay_exec(&delay, transfer);
+		if (!(dws->caps & DW_SPI_CAP_POLL_NODELAY)) {
+			delay.value = nbits * (dws->rx_len - dws->tx_len);
+			spi_delay_exec(&delay, transfer);
+		}
 
 		dw_reader(dws);
 
diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index 48a11a51a407..25f6372b993a 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -130,6 +130,7 @@ enum dw_ssi_type {
 #define DW_SPI_CAP_KEEMBAY_MST		BIT(1)
 #define DW_SPI_CAP_DWC_SSI		BIT(2)
 #define DW_SPI_CAP_DFS_32		BIT(3)
+#define DW_SPI_CAP_POLL_NODELAY		BIT(4)
 
 /* Slave spi_transfer/spi_mem_op related */
 struct dw_spi_cfg {
-- 
2.28.0

