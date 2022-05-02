Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5BAE517646
	for <lists+linux-spi@lfdr.de>; Mon,  2 May 2022 20:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386798AbiEBSFw (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 2 May 2022 14:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386791AbiEBSFv (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 2 May 2022 14:05:51 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A99311
        for <linux-spi@vger.kernel.org>; Mon,  2 May 2022 11:02:22 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nlaNJ-0004DF-1r
        for linux-spi@vger.kernel.org; Mon, 02 May 2022 20:02:21 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 2114373664
        for <linux-spi@vger.kernel.org>; Mon,  2 May 2022 18:02:20 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 7AA2C7363C;
        Mon,  2 May 2022 18:02:07 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id b7936f32;
        Mon, 2 May 2022 17:54:59 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-spi@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        Marek Vasut <marex@denx.de>
Cc:     kernel@pengutronix.de, linux-imx@nxp.com,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Baruch Siach <baruch@tkos.co.il>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v1 4/9] spi: spi-imx: spi_imx_buf_rx_swap_u32(): fix sparse warning: use swab32s() instead of cpu_to_be32()
Date:   Mon,  2 May 2022 19:54:52 +0200
Message-Id: <20220502175457.1977983-5-mkl@pengutronix.de>
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

This patch fixes the following sparse warning by using a swab32s()
instead of a cpu_to_be32(). The driver is used on little endian
systems only and we really want to swap the bytes.

| drivers/spi/spi-imx.c:305:29: warning: incorrect type in assignment (different base types)
| drivers/spi/spi-imx.c:305:29:    expected unsigned int val
| drivers/spi/spi-imx.c:305:29:    got restricted __be32 [usertype]
| drivers/spi/spi-imx.c:361:21: warning: incorrect type in assignment (different base types)
| drivers/spi/spi-imx.c:361:21:    expected unsigned int [assigned] [usertype] val
| drivers/spi/spi-imx.c:361:21:    got restricted __be32 [usertype]

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/spi/spi-imx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 895c7514325b..86391f869444 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -298,7 +298,7 @@ static void spi_imx_buf_rx_swap_u32(struct spi_imx_data *spi_imx)
 #ifdef __LITTLE_ENDIAN
 		bytes_per_word = spi_imx_bytes_per_word(spi_imx->bits_per_word);
 		if (bytes_per_word == 1)
-			val = cpu_to_be32(val);
+			swab32s(&val);
 		else if (bytes_per_word == 2)
 			val = (val << 16) | (val >> 16);
 #endif
@@ -354,7 +354,7 @@ static void spi_imx_buf_tx_swap_u32(struct spi_imx_data *spi_imx)
 	bytes_per_word = spi_imx_bytes_per_word(spi_imx->bits_per_word);
 
 	if (bytes_per_word == 1)
-		val = cpu_to_be32(val);
+		swab32s(&val);
 	else if (bytes_per_word == 2)
 		val = (val << 16) | (val >> 16);
 #endif
-- 
2.35.1


