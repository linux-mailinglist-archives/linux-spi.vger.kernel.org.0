Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77B74517520
	for <lists+linux-spi@lfdr.de>; Mon,  2 May 2022 18:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386514AbiEBQ4a (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 2 May 2022 12:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385395AbiEBQ4R (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 2 May 2022 12:56:17 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41DDE1276A
        for <linux-spi@vger.kernel.org>; Mon,  2 May 2022 09:52:33 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nlZHj-0003hw-Gz
        for linux-spi@vger.kernel.org; Mon, 02 May 2022 18:52:31 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id E313173506
        for <linux-spi@vger.kernel.org>; Mon,  2 May 2022 16:52:29 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 3ED5E734F2;
        Mon,  2 May 2022 16:52:28 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id d897c645;
        Mon, 2 May 2022 16:52:11 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-spi@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        Marek Vasut <marex@denx.de>
Cc:     kernel@pengutronix.de, linux-imx@nxp.com,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [RFC 4/9] spi: spi-imx: spi_imx_buf_rx_swap_u32(): fix sparse warning
Date:   Mon,  2 May 2022 18:52:05 +0200
Message-Id: <20220502165210.1956397-5-mkl@pengutronix.de>
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

This patch fixes the following sparse warning by using a swab32()
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
index a05d823d8806..a63cb26f33fc 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -297,7 +297,7 @@ static void spi_imx_buf_rx_swap_u32(struct spi_imx_data *spi_imx)
 #ifdef __LITTLE_ENDIAN
 		bytes_per_word = spi_imx_bytes_per_word(spi_imx->bits_per_word);
 		if (bytes_per_word == 1)
-			val = cpu_to_be32(val);
+			val = swab32(val);
 		else if (bytes_per_word == 2)
 			val = (val << 16) | (val >> 16);
 #endif
@@ -353,7 +353,7 @@ static void spi_imx_buf_tx_swap_u32(struct spi_imx_data *spi_imx)
 	bytes_per_word = spi_imx_bytes_per_word(spi_imx->bits_per_word);
 
 	if (bytes_per_word == 1)
-		val = cpu_to_be32(val);
+		val = swab32(val);
 	else if (bytes_per_word == 2)
 		val = (val << 16) | (val >> 16);
 #endif
-- 
2.35.1


