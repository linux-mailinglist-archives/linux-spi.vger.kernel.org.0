Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E35284FC453
	for <lists+linux-spi@lfdr.de>; Mon, 11 Apr 2022 20:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349235AbiDKSsb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 11 Apr 2022 14:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349224AbiDKSs3 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 11 Apr 2022 14:48:29 -0400
Received: from mail.tkos.co.il (guitar.tkos.co.il [84.110.109.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD871BEA1
        for <linux-spi@vger.kernel.org>; Mon, 11 Apr 2022 11:46:13 -0700 (PDT)
Received: from tarshish.tkos.co.il (unknown [10.0.8.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.tkos.co.il (Postfix) with ESMTPS id 62411440850;
        Mon, 11 Apr 2022 21:45:39 +0300 (IDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
        s=default; t=1649702739;
        bh=A46Vf+O4fgj2Kf0M0kC0BdmGePrGz2TiFZvx75W3cnA=;
        h=From:To:Cc:Subject:Date:From;
        b=N2g2iTk0YcZJ/fbTR48Cllipjd9yWh5Z2VbR7YoraOYNZokky2pSj5r5/AGYd+xbx
         oHWY87iNCDMm8Kec2KLrigF3pKvbN6zGq1zixtwjamXAL7wFEuEeJVjUUJn9ksGnff
         xbIoCYUmdXr118yy3HOHPjqMWb5xko7sPOG86P1rtV8kQro2HZ0P7WzmWzJYL5lN6c
         sAh0327dKc9JrZuLFeAw6+6sz+AfvUQjwRtvSbfkQWwt0XBiF9Lv7B6mO3QpMNW47A
         q3AVtybBpE9oh+qVf4b1nlOYybBWV4uJ7RGrjNCrJUAmQO4bibd21CuEYcqRDVEWrp
         igLKj0tcHNpDA==
From:   Baruch Siach <baruch@tkos.co.il>
To:     Mark Brown <broonie@kernel.org>
Cc:     Baruch Siach <baruch.siach@siklu.com>, linux-spi@vger.kernel.org,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/3] spi: add SPI_RX_CPHA_FLIP mode bit
Date:   Mon, 11 Apr 2022 21:45:27 +0300
Message-Id: <a715ca92713ca02071f33dcca9960a66a03c949a.1649702729.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Baruch Siach <baruch.siach@siklu.com>

Some SPI devices latch MOSI bits on one clock phase, but produce valid
MISO bits on the other phase. Add SPI_RX_CPHA_FLIP mode to instruct the
controller driver to flip CPHA for Rx (MISO) only transfers.

Signed-off-by: Baruch Siach <baruch.siach@siklu.com>
---
 include/uapi/linux/spi/spi.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/spi/spi.h b/include/uapi/linux/spi/spi.h
index 236a85f08ded..9d5f58059703 100644
--- a/include/uapi/linux/spi/spi.h
+++ b/include/uapi/linux/spi/spi.h
@@ -27,6 +27,7 @@
 #define	SPI_TX_OCTAL		_BITUL(13)	/* transmit with 8 wires */
 #define	SPI_RX_OCTAL		_BITUL(14)	/* receive with 8 wires */
 #define	SPI_3WIRE_HIZ		_BITUL(15)	/* high impedance turnaround */
+#define	SPI_RX_CPHA_FLIP	_BITUL(16)	/* flip CPHA on Rx only xfer */
 
 /*
  * All the bits defined above should be covered by SPI_MODE_USER_MASK.
@@ -36,6 +37,6 @@
  * These bits must not overlap. A static assert check should make sure of that.
  * If adding extra bits, make sure to increase the bit index below as well.
  */
-#define SPI_MODE_USER_MASK	(_BITUL(16) - 1)
+#define SPI_MODE_USER_MASK	(_BITUL(17) - 1)
 
 #endif /* _UAPI_SPI_H */
-- 
2.35.1

