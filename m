Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C95225C2EF
	for <lists+linux-spi@lfdr.de>; Thu,  3 Sep 2020 16:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729414AbgICOlL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 3 Sep 2020 10:41:11 -0400
Received: from mx1.tq-group.com ([62.157.118.193]:59778 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729406AbgICOk6 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 3 Sep 2020 10:40:58 -0400
IronPort-SDR: tWkSgVr7tIYKC56ZI0vAC5S6vowOnHNZItcy5v/nmVsG5m55D0RE/PAU/7L4IXCqgFLBzgZusl
 X0Hoca4espLj6q9/0IahoMH/DceBW+9qBKPkM62H3n6DxSbf+KHphVB9EtVdWNWzETWOILZwdL
 KaW17BZH1NnfKT9XhyD+edGGCeiwqeWiXfJQ07FlXtJTrSasWFne3zz6z69bhHlrNtIRoHjN9m
 S1kkgepTqbtfS2O0QmB+YyTB8fPa2LjZ65yQOKPms05CpDbrfLlmbhGZwP73ICRXz6N8BaXJUw
 N3A=
X-IronPort-AV: E=Sophos;i="5.76,387,1592863200"; 
   d="scan'208";a="13722541"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 03 Sep 2020 16:40:55 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Thu, 03 Sep 2020 16:40:56 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Thu, 03 Sep 2020 16:40:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1599144055; x=1630680055;
  h=from:to:cc:subject:date:message-id;
  bh=HuVYZMdnTpuIAbGh0AO6RRdKYESqvMwuJdvjWZtOvjo=;
  b=Do2UNsHQnUT/s8dV31uR/dqFZMJ0xeIqnnjx9XugtpgdbAo4c269TE2J
   rEX080JtplHQK1JFnlsuWdnOnZkIGrm8I3kmrQb1Ks3dGncJ2RJ+ArM1P
   ga5xXoBjC4erbzhpy0GJcDLCXJwNpq520V2FZRcDECKWj+ZVQHS9tui/z
   Tzn9bVVOdxk3LF3nd3FnoDiOtTyBvoogM3/yu2FKs2t5+t5HBXeezk2dB
   cdQkNbrOD1PUB/RuR9ZdHo24gDzwOD/DMzdUL+m5UIua88Wqr1eB4zX2I
   HXwlYbvq9VMZsTVjfbnmANg7ov6llvVDjfPjlU97HkebzH2ZIRRuS8SS3
   w==;
IronPort-SDR: pPiXbxI+FQucBUSsBtjmOTxuJGtkJ19sEQBeNapq3BL3fx7uw5P/ny0rX1JV6Y3DiZHBPbi0Za
 P35/aGAwImZUVYkaXU9xYpbOyddZIBghPduttFnEYEpgh+jpvzmnmwXIU6XGKXUGxmh8nQbGxS
 x30kT87vBo33Ddhk8iX/UniQ1R3tCusCs2OCkUk1ipomAT7VxNsb99HkiOuyW2HHiQw7EUh8qx
 ZcZnI8LVMME2YGdeU/R5R6xCUd7NgTV9swfnfw73/7xSMyxIAhfo+6JJbwwEDYReL+oSKkccvp
 gYE=
X-IronPort-AV: E=Sophos;i="5.76,387,1592863200"; 
   d="scan'208";a="13722540"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 03 Sep 2020 16:40:55 +0200
Received: from schifferm-ubuntu4.tq-net.de (unknown [10.117.49.26])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id BE6D5280065;
        Thu,  3 Sep 2020 16:40:55 +0200 (CEST)
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Mark Brown <broonie@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH] spi-imx: remove num-cs support, set num_chipselect to 4
Date:   Thu,  3 Sep 2020 16:40:28 +0200
Message-Id: <20200903144028.20416-1-matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The num-cs property is not considered useful, and no in-tree Device
Trees define it for spi-imx.

The default value to be used when no cs-gpios are defined is set to 4 to
give access to all native CS pins of modern i.MX SoCs (i.MX6 and newer).

In older SoCs, the number of CS pins varies (for example the i.MX27 has 3
CS pins on CSPI1 and CSPI2, and only a single CS on CSPI3). Attempting
to use the nonexisting CS pin would be an easy to notice DT
misconfiguration; making the driver catch this doesn't seem worthwhile.

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---
 drivers/spi/spi-imx.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 197f60632072..aece8482739b 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -1581,7 +1581,6 @@ static int spi_imx_probe(struct platform_device *pdev)
 	const struct spi_imx_devtype_data *devtype_data = of_id ? of_id->data :
 		(struct spi_imx_devtype_data *)pdev->id_entry->driver_data;
 	bool slave_mode;
-	u32 val;
 
 	slave_mode = devtype_data->has_slavemode &&
 			of_property_read_bool(np, "spi-slave");
@@ -1605,6 +1604,7 @@ static int spi_imx_probe(struct platform_device *pdev)
 	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(1, 32);
 	master->bus_num = np ? -1 : pdev->id;
 	master->use_gpio_descriptors = true;
+	master->num_chipselect = 4;
 
 	spi_imx = spi_master_get_devdata(master);
 	spi_imx->bitbang.master = master;
@@ -1613,17 +1613,6 @@ static int spi_imx_probe(struct platform_device *pdev)
 
 	spi_imx->devtype_data = devtype_data;
 
-	/*
-	 * Get number of chip selects from device properties. This can be
-	 * coming from device tree or boardfiles, if it is not defined,
-	 * a default value of 3 chip selects will be used, as all the legacy
-	 * board files have <= 3 chip selects.
-	 */
-	if (!device_property_read_u32(&pdev->dev, "num-cs", &val))
-		master->num_chipselect = val;
-	else
-		master->num_chipselect = 3;
-
 	spi_imx->bitbang.setup_transfer = spi_imx_setupxfer;
 	spi_imx->bitbang.txrx_bufs = spi_imx_transfer;
 	spi_imx->bitbang.master->setup = spi_imx_setup;
-- 
2.17.1

