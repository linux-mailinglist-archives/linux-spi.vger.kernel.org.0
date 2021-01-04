Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BEF42E94E4
	for <lists+linux-spi@lfdr.de>; Mon,  4 Jan 2021 13:32:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbhADMcZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 4 Jan 2021 07:32:25 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:49849 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbhADMcZ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 4 Jan 2021 07:32:25 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4D8ZkF0tDFz1qs3D;
        Mon,  4 Jan 2021 13:31:33 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4D8ZkD6kHQz1qwHL;
        Mon,  4 Jan 2021 13:31:32 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id UBpcbJBXi3YL; Mon,  4 Jan 2021 13:31:31 +0100 (CET)
X-Auth-Info: RgYTZg3PO1nqOX+KXtrEzYKNrMuAK5yKDL3Cn6k+JsE=
Received: from tr.lan (ip-89-176-112-137.net.upcbroadband.cz [89.176.112.137])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Mon,  4 Jan 2021 13:31:31 +0100 (CET)
From:   Marek Vasut <marex@denx.de>
To:     linux-spi@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>, Alain Volmat <alain.volmat@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Amelie Delaunay <amelie.delaunay@st.com>,
        Antonio Borneo <antonio.borneo@st.com>,
        Mark Brown <broonie@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Roman Guskov <rguskov@dh-electronics.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH] spi: stm32: Simplify stm32h7_spi_prepare_fthlv()
Date:   Mon,  4 Jan 2021 13:31:14 +0100
Message-Id: <20210104123114.261596-1-marex@denx.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Simplify stm32h7_spi_prepare_fthlv() function implementation,
no functional change intended.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Alain Volmat <alain.volmat@st.com>
Cc: Alexandre Torgue <alexandre.torgue@st.com>
Cc: Amelie Delaunay <amelie.delaunay@st.com>
Cc: Antonio Borneo <antonio.borneo@st.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Roman Guskov <rguskov@dh-electronics.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-stm32@st-md-mailman.stormreply.com
To: linux-spi@vger.kernel.org
---
NOTE: Please review thoroughly and test
---
 drivers/spi/spi-stm32.c | 28 ++++------------------------
 1 file changed, 4 insertions(+), 24 deletions(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index 6017209c6d2f..510738191cd1 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -473,34 +473,14 @@ static int stm32_spi_prepare_mbr(struct stm32_spi *spi, u32 speed_hz,
  */
 static u32 stm32h7_spi_prepare_fthlv(struct stm32_spi *spi, u32 xfer_len)
 {
-	u32 fthlv, half_fifo, packet;
+	u32 packet, bpw;
 
 	/* data packet should not exceed 1/2 of fifo space */
-	half_fifo = (spi->fifo_size / 2);
-
-	/* data_packet should not exceed transfer length */
-	if (half_fifo > xfer_len)
-		packet = xfer_len;
-	else
-		packet = half_fifo;
-
-	if (spi->cur_bpw <= 8)
-		fthlv = packet;
-	else if (spi->cur_bpw <= 16)
-		fthlv = packet / 2;
-	else
-		fthlv = packet / 4;
+	packet = clamp(xfer_len, 1U, spi->fifo_size / 2);
 
 	/* align packet size with data registers access */
-	if (spi->cur_bpw > 8)
-		fthlv += (fthlv % 2) ? 1 : 0;
-	else
-		fthlv += (fthlv % 4) ? (4 - (fthlv % 4)) : 0;
-
-	if (!fthlv)
-		fthlv = 1;
-
-	return fthlv;
+	bpw = DIV_ROUND_UP(spi->cur_bpw, 8);
+	return DIV_ROUND_UP(packet, bpw);
 }
 
 /**
-- 
2.29.2

