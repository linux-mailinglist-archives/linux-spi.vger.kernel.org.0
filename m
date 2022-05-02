Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0CC5517643
	for <lists+linux-spi@lfdr.de>; Mon,  2 May 2022 20:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386793AbiEBSFj (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 2 May 2022 14:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386791AbiEBSFj (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 2 May 2022 14:05:39 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE95BBC84
        for <linux-spi@vger.kernel.org>; Mon,  2 May 2022 11:02:08 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nlaN5-00041A-Di
        for linux-spi@vger.kernel.org; Mon, 02 May 2022 20:02:07 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id AE31873639
        for <linux-spi@vger.kernel.org>; Mon,  2 May 2022 18:02:06 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id D917B73618;
        Mon,  2 May 2022 18:01:56 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 78711412;
        Mon, 2 May 2022 17:54:59 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-spi@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        Marek Vasut <marex@denx.de>
Cc:     kernel@pengutronix.de, linux-imx@nxp.com,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Baruch Siach <baruch@tkos.co.il>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v1 1/9] spi: spi-imx: fix sparse warning: add identifier name to function definition
Date:   Mon,  2 May 2022 19:54:49 +0200
Message-Id: <20220502175457.1977983-2-mkl@pengutronix.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220502175457.1977983-1-mkl@pengutronix.de>
References: <20220502175457.1977983-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This patch fixes the following and similar sparse warnings by adding
the missing identifier names to the function definitions:

| WARNING: function definition argument 'struct spi_imx_data *' should also have an identifier name
| #68: FILE: drivers/spi/spi-imx.c:68:
| +       int (*prepare_message)(struct spi_imx_data *, struct spi_message *);

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/spi/spi-imx.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 733e40e71ee6..df1f5a1abaa2 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -64,15 +64,15 @@ enum spi_imx_devtype {
 struct spi_imx_data;
 
 struct spi_imx_devtype_data {
-	void (*intctrl)(struct spi_imx_data *, int);
-	int (*prepare_message)(struct spi_imx_data *, struct spi_message *);
-	int (*prepare_transfer)(struct spi_imx_data *, struct spi_device *);
-	void (*trigger)(struct spi_imx_data *);
-	int (*rx_available)(struct spi_imx_data *);
-	void (*reset)(struct spi_imx_data *);
-	void (*setup_wml)(struct spi_imx_data *);
-	void (*disable)(struct spi_imx_data *);
-	void (*disable_dma)(struct spi_imx_data *);
+	void (*intctrl)(struct spi_imx_data *spi_imx, int enable);
+	int (*prepare_message)(struct spi_imx_data *spi_imx, struct spi_message *msg);
+	int (*prepare_transfer)(struct spi_imx_data *spi_imx, struct spi_device *spi);
+	void (*trigger)(struct spi_imx_data *spi_imx);
+	int (*rx_available)(struct spi_imx_data *spi_imx);
+	void (*reset)(struct spi_imx_data *spi_imx);
+	void (*setup_wml)(struct spi_imx_data *spi_imx);
+	void (*disable)(struct spi_imx_data *spi_imx);
+	void (*disable_dma)(struct spi_imx_data *spi_imx);
 	bool has_dmamode;
 	bool has_slavemode;
 	unsigned int fifo_size;
@@ -102,8 +102,8 @@ struct spi_imx_data {
 	unsigned int spi_drctl;
 
 	unsigned int count, remainder;
-	void (*tx)(struct spi_imx_data *);
-	void (*rx)(struct spi_imx_data *);
+	void (*tx)(struct spi_imx_data *spi_imx);
+	void (*rx)(struct spi_imx_data *spi_imx);
 	void *rx_buf;
 	const void *tx_buf;
 	unsigned int txfifo; /* number of words pushed in tx FIFO */

base-commit: 69bb9b29bf67e850beece45e9c99ca707eac7e41
-- 
2.35.1


