Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5258951751A
	for <lists+linux-spi@lfdr.de>; Mon,  2 May 2022 18:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386500AbiEBQ42 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 2 May 2022 12:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379683AbiEBQ4R (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 2 May 2022 12:56:17 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7887C12769
        for <linux-spi@vger.kernel.org>; Mon,  2 May 2022 09:52:32 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nlZHi-0003hG-Mi
        for linux-spi@vger.kernel.org; Mon, 02 May 2022 18:52:30 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id B17AB734FE
        for <linux-spi@vger.kernel.org>; Mon,  2 May 2022 16:52:29 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 09BCB734E9;
        Mon,  2 May 2022 16:52:27 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 774a887d;
        Mon, 2 May 2022 16:52:11 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-spi@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        Marek Vasut <marex@denx.de>
Cc:     kernel@pengutronix.de, linux-imx@nxp.com,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [RFC 3/9] spi: spi-imx: mx51_ecspi_intctrl(): prefer 'unsigned int' to bare use of 'unsigned'
Date:   Mon,  2 May 2022 18:52:04 +0200
Message-Id: <20220502165210.1956397-4-mkl@pengutronix.de>
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

This patch fixes the following checkpatch warning, by making val an
"unsigned int".

| WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
| +       unsigned val = 0;

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/spi/spi-imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index a964a7ba8c1b..a05d823d8806 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -469,7 +469,7 @@ static unsigned int mx51_ecspi_clkdiv(struct spi_imx_data *spi_imx,
 
 static void mx51_ecspi_intctrl(struct spi_imx_data *spi_imx, int enable)
 {
-	unsigned val = 0;
+	unsigned int val = 0;
 
 	if (enable & MXC_INT_TE)
 		val |= MX51_ECSPI_INT_TEEN;
-- 
2.35.1


