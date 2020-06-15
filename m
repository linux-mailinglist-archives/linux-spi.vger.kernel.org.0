Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 128BA1F8CDB
	for <lists+linux-spi@lfdr.de>; Mon, 15 Jun 2020 06:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbgFOEGJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 15 Jun 2020 00:06:09 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:50531 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728163AbgFOEGG (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 15 Jun 2020 00:06:06 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 8F437891B0;
        Mon, 15 Jun 2020 16:05:57 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1592193957;
        bh=BtcDdq8igGetN/jELHWNV2M1CB6861dCLDtHKsKlFzY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=o62exfEMNl+ll+E9nfhS4jp9iwhjYH/X8Sl8S1PEIk67KvmzTx9EkewxFwWISGeBn
         boACE7L2ZU4qwIcEdCYtrUoGQYJ3mNCv672JB9pvju+3E2AwumJ2I2DMdBwhqnus67
         Tp1PVw0XVC6rfS07QqwA7iFqGel+RaiUW6FTBPGEk4sdocy7TsUXhzeQn3DMd0fsjB
         sXPcw5fnoj29PVQJvv+ROgnLmIogm+fgPvoGoXmr3QE3qx+cWPfl9KRbLrJ4xFTQBE
         /Df9VC+ejPrNBacXmgc34pOJDOBVC6LPfSePauvMD/sEGcsPDNF4uNx13+yFhUGqyr
         cCcFXZHeArgHg==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5ee6f3a50001>; Mon, 15 Jun 2020 16:05:57 +1200
Received: from markto-dl.ws.atlnz.lc (markto-dl.ws.atlnz.lc [10.33.23.25])
        by smtp (Postfix) with ESMTP id 9AF4F13EEBA;
        Mon, 15 Jun 2020 16:05:56 +1200 (NZST)
Received: by markto-dl.ws.atlnz.lc (Postfix, from userid 1155)
        id 4C90F341107; Mon, 15 Jun 2020 16:05:57 +1200 (NZST)
From:   Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
To:     broonie@kernel.org, kdasu.kdev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
Subject: [PATCH 1/5] spi: bcm-qspi: Add support for setting BSPI clock
Date:   Mon, 15 Jun 2020 16:05:53 +1200
Message-Id: <20200615040557.2011-2-mark.tomlinson@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200615040557.2011-1-mark.tomlinson@alliedtelesis.co.nz>
References: <20200615040557.2011-1-mark.tomlinson@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On iProc devices (unlike previous BCM SoCs) the clock rate of the SPI
can be set. This patch adds the appropriate code for setting that.

Reviewed-by: Callum Sinclair <callum.sinclair@alliedtelesis.co.nz>
Reviewed-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
Signed-off-by: Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
---
 drivers/spi/spi-bcm-qspi.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/spi/spi-bcm-qspi.c b/drivers/spi/spi-bcm-qspi.c
index 681d09085175..8fc5b9b3757b 100644
--- a/drivers/spi/spi-bcm-qspi.c
+++ b/drivers/spi/spi-bcm-qspi.c
@@ -117,6 +117,13 @@
=20
 #define MSPI_MSPI_STATUS_SPIF			BIT(0)
=20
+#define CRU_CTRL_REG				0x0
+#define QSPI_CLK_SEL_25M			0x00
+#define QSPI_CLK_SEL_50M			0x02
+#define QSPI_CLK_SEL_31M25			0x04
+#define QSPI_CLK_SEL_62M5			0x06
+#define QSPI_CLK_SEL_MASK			0x06
+
 #define INTR_BASE_BIT_SHIFT			0x02
 #define INTR_COUNT				0x07
=20
@@ -170,6 +177,7 @@ enum base_type {
 	MSPI,
 	BSPI,
 	CHIP_SELECT,
+	CRU_CTRL,
 	BASEMAX,
 };
=20
@@ -625,6 +633,7 @@ static void bcm_qspi_update_parms(struct bcm_qspi *qs=
pi,
 static int bcm_qspi_setup(struct spi_device *spi)
 {
 	struct bcm_qspi_parms *xp;
+	struct bcm_qspi *qspi =3D spi_master_get_devdata(spi->master);
=20
 	if (spi->bits_per_word > 16)
 		return -EINVAL;
@@ -639,6 +648,21 @@ static int bcm_qspi_setup(struct spi_device *spi)
 	xp->speed_hz =3D spi->max_speed_hz;
 	xp->mode =3D spi->mode;
=20
+	if (qspi->base[CRU_CTRL]) {
+		u32 tmp =3D bcm_qspi_read(qspi, CRU_CTRL, CRU_CTRL_REG);
+
+		/* Set BSPI clock rate */
+		tmp &=3D ~QSPI_CLK_SEL_MASK;
+		if (spi->max_speed_hz >=3D 62500000)
+			tmp |=3D QSPI_CLK_SEL_62M5;
+		else if (spi->max_speed_hz >=3D 50000000)
+			tmp |=3D QSPI_CLK_SEL_50M;
+		else if (spi->max_speed_hz >=3D 31250000)
+			tmp |=3D QSPI_CLK_SEL_31M25;
+		/* default is 25MHz */
+		bcm_qspi_write(qspi, CRU_CTRL, CRU_CTRL_REG, tmp);
+	}
+
 	if (spi->bits_per_word)
 		xp->bits_per_word =3D spi->bits_per_word;
 	else
@@ -1459,6 +1483,16 @@ int bcm_qspi_probe(struct platform_device *pdev,
 		qspi->soc_intc =3D NULL;
 	}
=20
+	/* iProc BSPI clock is set through CRU control */
+	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "cru_ctrl");
+	if (res) {
+		qspi->base[CRU_CTRL] =3D devm_ioremap_resource(dev, res);
+		if (IS_ERR(qspi->base[CRU_CTRL])) {
+			ret =3D PTR_ERR(qspi->base[CRU_CTRL]);
+			goto qspi_probe_err;
+		}
+	}
+
 	ret =3D clk_prepare_enable(qspi->clk);
 	if (ret) {
 		dev_err(dev, "failed to prepare clock\n");
--=20
2.27.0

