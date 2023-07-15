Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBCB0754604
	for <lists+linux-spi@lfdr.de>; Sat, 15 Jul 2023 03:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjGOBFV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 14 Jul 2023 21:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjGOBFS (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 14 Jul 2023 21:05:18 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 53DA43C3F;
        Fri, 14 Jul 2023 18:04:55 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.01,206,1684767600"; 
   d="scan'208";a="172657879"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 15 Jul 2023 10:04:47 +0900
Received: from mulinux.home (unknown [10.226.92.194])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 9AA9B40C4DAF;
        Sat, 15 Jul 2023 10:04:44 +0900 (JST)
From:   Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To:     Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH 09/10] spi: rzv2m-csi: Get rid of the x_trg{_words} tables
Date:   Sat, 15 Jul 2023 02:04:06 +0100
Message-Id: <20230715010407.1751715-10-fabrizio.castro.jz@renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230715010407.1751715-1-fabrizio.castro.jz@renesas.com>
References: <20230715010407.1751715-1-fabrizio.castro.jz@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Table x_trg can be replaced with ilog2(), and table x_trg_words
can be replaced with rounddown_pow_of_two().
Replace the tables usage with the corresponding macros.
While at it, remove a couple of unnecessary empty lines.

Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
---
 drivers/spi/spi-rzv2m-csi.c | 21 +++------------------
 1 file changed, 3 insertions(+), 18 deletions(-)

diff --git a/drivers/spi/spi-rzv2m-csi.c b/drivers/spi/spi-rzv2m-csi.c
index 1e5ed1089f42..1874ca1c2747 100644
--- a/drivers/spi/spi-rzv2m-csi.c
+++ b/drivers/spi/spi-rzv2m-csi.c
@@ -10,6 +10,7 @@
 #include <linux/count_zeros.h>
 #include <linux/interrupt.h>
 #include <linux/iopoll.h>
+#include <linux/log2.h>
 #include <linux/platform_device.h>
 #include <linux/reset.h>
 #include <linux/spi/spi.h>
@@ -99,20 +100,6 @@ struct rzv2m_csi_priv {
 	u32 status;
 };
 
-static const unsigned char x_trg[] = {
-	0, 1, 1, 2, 2, 2, 2, 3,
-	3, 3, 3, 3, 3, 3, 3, 4,
-	4, 4, 4, 4, 4, 4, 4, 4,
-	4, 4, 4, 4, 4, 4, 4, 5
-};
-
-static const unsigned char x_trg_words[] = {
-	1,  2,  2,  4,  4,  4,  4,  8,
-	8,  8,  8,  8,  8,  8,  8,  16,
-	16, 16, 16, 16, 16, 16, 16, 16,
-	16, 16, 16, 16, 16, 16, 16, 32
-};
-
 static void rzv2m_csi_reg_write_bit(const struct rzv2m_csi_priv *csi,
 				    int reg_offs, int bit_mask, u32 value)
 {
@@ -216,7 +203,7 @@ static inline void rzv2m_csi_calc_current_transfer(struct rzv2m_csi_priv *csi)
 	 * less than or equal to the number of bytes we need to transfer.
 	 * This may result in multiple smaller transfers.
 	 */
-	csi->words_to_transfer = x_trg_words[to_transfer - 1];
+	csi->words_to_transfer = rounddown_pow_of_two(to_transfer);
 
 	if (csi->bytes_per_word == 2)
 		csi->bytes_to_transfer = csi->words_to_transfer << 1;
@@ -227,7 +214,7 @@ static inline void rzv2m_csi_calc_current_transfer(struct rzv2m_csi_priv *csi)
 static inline void rzv2m_csi_set_rx_fifo_trigger_level(struct rzv2m_csi_priv *csi)
 {
 	rzv2m_csi_reg_write_bit(csi, CSI_FIFOTRG, CSI_FIFOTRG_R_TRG,
-				x_trg[csi->words_to_transfer - 1]);
+				ilog2(csi->words_to_transfer));
 }
 
 static inline void rzv2m_csi_enable_rx_trigger(struct rzv2m_csi_priv *csi,
@@ -300,7 +287,6 @@ static int rzv2m_csi_wait_for_tx_empty(struct rzv2m_csi_priv *csi)
 		return 0;
 
 	ret = rzv2m_csi_wait_for_interrupt(csi, CSI_INT_TREND, CSI_CNT_TREND_E);
-
 	if (ret == -ETIMEDOUT)
 		csi->errors |= TX_TIMEOUT_ERROR;
 
@@ -316,7 +302,6 @@ static inline int rzv2m_csi_wait_for_rx_ready(struct rzv2m_csi_priv *csi)
 
 	ret = rzv2m_csi_wait_for_interrupt(csi, CSI_INT_R_TRGR,
 					   CSI_CNT_R_TRGR_E);
-
 	if (ret == -ETIMEDOUT)
 		csi->errors |= RX_TIMEOUT_ERROR;
 
-- 
2.34.1

