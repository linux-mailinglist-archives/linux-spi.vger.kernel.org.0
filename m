Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26ADB51751C
	for <lists+linux-spi@lfdr.de>; Mon,  2 May 2022 18:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243330AbiEBQ41 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 2 May 2022 12:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245618AbiEBQ4R (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 2 May 2022 12:56:17 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71E661275B
        for <linux-spi@vger.kernel.org>; Mon,  2 May 2022 09:52:30 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nlZHg-0003e7-U2
        for linux-spi@vger.kernel.org; Mon, 02 May 2022 18:52:28 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 17729734EC
        for <linux-spi@vger.kernel.org>; Mon,  2 May 2022 16:52:28 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 227D2734DB;
        Mon,  2 May 2022 16:52:27 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id b29fc3ea;
        Mon, 2 May 2022 16:52:11 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-spi@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        Marek Vasut <marex@denx.de>
Cc:     kernel@pengutronix.de, linux-imx@nxp.com,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [RFC 1/9] spi: spi-imx: fix sparse warning: add identifier name to function definition
Date:   Mon,  2 May 2022 18:52:02 +0200
Message-Id: <20220502165210.1956397-2-mkl@pengutronix.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220502165210.1956397-1-mkl@pengutronix.de>
References: <20220502165210.1956397-1-mkl@pengutronix.de>
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
index b2dd0a4d2446..bbf6fd4fe763 100644
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

base-commit: 3123109284176b1532874591f7c81f3837bbdc17
-- 
2.35.1


