Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 014422AA34F
	for <lists+linux-spi@lfdr.de>; Sat,  7 Nov 2020 09:14:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727892AbgKGIOa (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 7 Nov 2020 03:14:30 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:57208 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727833AbgKGIOa (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 7 Nov 2020 03:14:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1604736869; x=1636272869;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fn84oUZ4BNOGbDuiZmuvLT5yqWitqbl3jm2qr9SJ9bI=;
  b=edEe2bsF7O2amA9pJV2t9HKaazSKyc6ecuGi9rkzU+Ra9TzEqo633C8h
   aiwZ2l56NqwtgRS0UYiZJr2uMQXXd+wGXp5hkgelJCVLbxZuvW7Qq+Yy3
   b3+g/OjNeX7lUt2t72sdLxnOCammeBeWMAcPT161Ut+t8mmcjSR5zFBxZ
   N8Fx8Gs0a+3sGvs8zCqu/k+V0m6LgZGpQs5Ewivm1AzXk6Qjg/BqXhqAD
   tQ7/3JoK4MTA6LU1aeij1tEGbG+hJLmv39k6uqdroQpBDSihMUSxRUo3K
   pqKBiM85YbF+Y/3dvAj2KDY6kAV/oDE2xpvfX3a97lbagU5ohhw9HzBGW
   g==;
IronPort-SDR: n6bxo9BMXs8tOxfB8F51PMEkY7MmWlGZYFrUCpTftKzpydzyiImc79nFe+e5lQDpqDR3SGel1w
 fVaIbV7cEpRfge3u+L2YlaeleZJWOZOaCMXvgzWWvLeRTmzeRTI2pF5DhWgeYbwNQ13KRCqxCd
 ACZ9r2g60Ju+yFvzMvAZv58g2hIqVjogw2f2UgIxsK10Fd4KVf6iEaSE1CGXAJAzjSSbgdNRuj
 y9t+SJSA6k6vZvNW/6SL8rBuJCP/dE4GBaQ06rJlX1aHEkBGL/XSe77mLsXBsCpag1GJnOAk18
 Hms=
X-IronPort-AV: E=Sophos;i="5.77,459,1596470400"; 
   d="scan'208";a="156564358"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Nov 2020 16:14:28 +0800
IronPort-SDR: ujIRzSqCMmY6Vmwv2MOOv+fBgnUaQgcAYsJbqzHzspAq2vU020ZbtPtreqerLQh2wbZBdPQO+K
 xzmm3OvYPQvsb1Q7VEvJSNGQ0OaCi/k4kGNAgr2p0e41g8qHEz/LSZVPqil9fCmya8aMBq2nbY
 J70YerqdU8B0Uxkk92CRwcA6/G0fE4CS3PTT+h5r944YcHX0kK3+4KF0Viz1/dbfR0/mqqrD9+
 fyzY1kAOmxvyLF40XB+MdAFlGmjpH5i9klRDOLNkCiKaNYK65Czy8M9hPxf3+8EjY00nXKbQ7S
 3VQMqe/2qqzVz9q/RgSyPgrZ
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2020 23:59:20 -0800
IronPort-SDR: Pjy+CvffHDUeaBXBpKnVSfEEU+ksIQROzGmmXPC5PVw7W7LyOuXXasEaoNM6f2hnV3YBECU9iq
 LnhkeIJzWOWBBFB12SV915WaNLKoDeKBQAlm7wE6ylqZDcZgeX7vg18qvU4TLQeIZea9IAf/N5
 I/Z9Kje7pGer8lGFz4ym/VEXgpvR8GX9vS6cccuowARmvkDKv4pwcaXx6DsKcVZyvwULF4rSo7
 tgkrLgReXXsDTAjMXLh8x2qgfjYOktPdjaRoIl6Ew59pEikbYpOPsXvP7jJ5M1w1uqP8qplYF+
 tQY=
WDCIronportException: Internal
Received: from hdrdzf2.ad.shared (HELO twashi.fujisawa.hgst.com) ([10.84.71.85])
  by uls-op-cesaip01.wdc.com with ESMTP; 07 Nov 2020 00:14:27 -0800
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
Subject: [PATCH 02/32] spi: dw: Add support for 32-bits ctrlr0 layout
Date:   Sat,  7 Nov 2020 17:13:50 +0900
Message-Id: <20201107081420.60325-3-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201107081420.60325-1-damien.lemoal@wdc.com>
References: <20201107081420.60325-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Synopsis DesignWare DW_apb_ssi version 4 defines a 32-bit layout of
the ctrlr0 register for SPI masters. The layout of ctrlr0 is:

|   31 .. 23  | 22 .. 21 | 20 .. 16 |
| other stuff | spi_frf  |  dfs_32  |

|   15 .. 10  | 9 .. 8 | 7 .. 6 | 5 .. 4 | 3 .. 0 |
| other stuff |  tmod  |  mode  |  frf   |  dfs   |

Th main difference of this layout with the 16-bits version is the data
frame format field which resides in bits 16..20 instead of bits 3..0.

Introduce the DW SPI capability flag DW_SPI_CAP_DFS_32 to let a
platform signal that this layout is in use. Modify
dw_spi_update_config() to test this capability flag to set the data
frame format field at the correct register location.

Suggested-by: Sean Anderson <seanga2@gmail.com>
Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 drivers/spi/spi-dw-core.c | 8 ++++++--
 drivers/spi/spi-dw.h      | 9 +++++++++
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index 2e50cc0a9291..841c85247f01 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -311,8 +311,12 @@ void dw_spi_update_config(struct dw_spi *dws, struct spi_device *spi,
 	u32 speed_hz;
 	u16 clk_div;
 
-	/* CTRLR0[ 4/3: 0] Data Frame Size */
-	cr0 |= (cfg->dfs - 1);
+	if (!(dws->caps & DW_SPI_CAP_DFS_32))
+		/* CTRLR0[ 4/3: 0] Data Frame Size */
+		cr0 |= (cfg->dfs - 1);
+	else
+		/* CTRLR0[20: 16] Data Frame Size */
+		cr0 |= (cfg->dfs - 1) << DWC_APB_CTRLR0_32_DFS_OFFSET;
 
 	if (!(dws->caps & DW_SPI_CAP_DWC_SSI))
 		/* CTRLR0[ 9:8] Transfer Mode */
diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index faf40cb66498..48a11a51a407 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -9,6 +9,7 @@
 #include <linux/io.h>
 #include <linux/scatterlist.h>
 #include <linux/spi/spi-mem.h>
+#include <linux/bitfield.h>
 
 /* Register offsets */
 #define DW_SPI_CTRLR0			0x00
@@ -72,6 +73,13 @@
 #define DWC_SSI_CTRLR0_FRF_OFFSET	6
 #define DWC_SSI_CTRLR0_DFS_OFFSET	0
 
+/*
+ * Bit fields in CTRLR0 for DWC_apb_ssi v4 32-bits ctrlr0.
+ * Based on DW_apb_ssi Databook v4.02a.
+ */
+#define DWC_APB_CTRLR0_32_DFS_OFFSET	16
+#define DWC_APB_CTRLR0_32_DFS_MASK	GENMASK(20, 16)
+
 /*
  * For Keem Bay, CTRLR0[31] is used to select controller mode.
  * 0: SSI is slave
@@ -121,6 +129,7 @@ enum dw_ssi_type {
 #define DW_SPI_CAP_CS_OVERRIDE		BIT(0)
 #define DW_SPI_CAP_KEEMBAY_MST		BIT(1)
 #define DW_SPI_CAP_DWC_SSI		BIT(2)
+#define DW_SPI_CAP_DFS_32		BIT(3)
 
 /* Slave spi_transfer/spi_mem_op related */
 struct dw_spi_cfg {
-- 
2.28.0

