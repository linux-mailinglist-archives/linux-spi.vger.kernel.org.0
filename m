Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 406482DFC01
	for <lists+linux-spi@lfdr.de>; Mon, 21 Dec 2020 13:44:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726499AbgLUMoQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 21 Dec 2020 07:44:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbgLUMoQ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 21 Dec 2020 07:44:16 -0500
X-Greylist: delayed 386 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 21 Dec 2020 04:43:35 PST
Received: from mx3.securetransport.de (mx3.securetransport.de [IPv6:2a01:4f8:c0c:92be::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 879C6C0613D3
        for <linux-spi@vger.kernel.org>; Mon, 21 Dec 2020 04:43:35 -0800 (PST)
Received: from mail.dh-electronics.com (business-24-134-97-169.pool2.vodafone-ip.de [24.134.97.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx3.securetransport.de (Postfix) with ESMTPSA id E39345DC66;
        Mon, 21 Dec 2020 13:35:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
        s=dhelectronicscom; t=1608554159;
        bh=nST8Q8AKsnuSMPVhAthOon+hadYjnWFeGYymketrh0E=;
        h=From:To:CC:Subject:Date:From;
        b=c+EXL6MUMpv8uMPslEfGiAtrr2pWMEI6ANznFBl1wBiLdGK+h1kXo0tzIATG0f1x1
         TV5o2jWXApq91i2rOgUQ4XGqIlrADrDEguxsK2AZZB0Mj0ssc0BT/5C3ilk39eff7Q
         hvkPDvyMN9g/tfYmI9vigL0Sd2S63tK1ABpZPwhPhst5PicIZO8Nac0Kz/pxE5kPLa
         BRFAm8EUH5MC5gx7G5jtiqTYaPLm5eJxoHVh2oXmV3GBASugf25Pb4/kWldGk0YNSf
         Du5CW96/xJqRjd8mfGyi22Rh4iAsB7W02eZ62+s7IC98kOa6r1etLuCkBre+/SmMDs
         4vvFhW0VxpH7g==
Received: from DHPWEX01.DH-ELECTRONICS.ORG (2001:470:76a7:2::30) by
 DHPWEX01.DH-ELECTRONICS.ORG (2001:470:76a7:2::30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.659.4;
 Mon, 21 Dec 2020 13:35:47 +0100
Received: from Stretch.dh-electronics.org (10.64.6.176) by
 DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.659.4
 via Frontend Transport; Mon, 21 Dec 2020 13:35:47 +0100
From:   Roman Guskov <rguskov@dh-electronics.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <alexandre.torgue@st.com>,
        <linux-stm32@st-md-mailman.stormreply.com>, <marex@denx.de>,
        Roman Guskov <rguskov@dh-electronics.com>
Subject: [PATCH] spi: stm32: FIFO threshold level - fix align packet size
Date:   Mon, 21 Dec 2020 13:35:32 +0100
Message-ID: <20201221123532.27272-1-rguskov@dh-electronics.com>
X-Mailer: git-send-email 2.11.0
X-klartext: yes
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

if cur_bpw <= 8 and xfer_len < 4 then the value of fthlv will be 1 and
SPI registers content may have been lost.

* If SPI data register is accessed as a 16-bit register and DSIZE <= 8bit,
  better to select FTHLV = 2, 4, 6 etc

* If SPI data register is accessed as a 32-bit register and DSIZE > 8bit,
  better to select FTHLV = 2, 4, 6 etc, while if DSIZE <= 8bit,
  better to select FTHLV = 4, 8, 12 etc

Signed-off-by: Roman Guskov <rguskov@dh-electronics.com>
---
 drivers/spi/spi-stm32.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index 9d8ceb63f7db..417c40154477 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -494,9 +494,9 @@ static u32 stm32h7_spi_prepare_fthlv(struct stm32_spi *spi, u32 xfer_len)
 
 	/* align packet size with data registers access */
 	if (spi->cur_bpw > 8)
-		fthlv -= (fthlv % 2); /* multiple of 2 */
+		fthlv += (fthlv % 2) ? 1 : 0;
 	else
-		fthlv -= (fthlv % 4); /* multiple of 4 */
+		fthlv += (fthlv % 4) ? (4 - (fthlv % 4)) : 0;
 
 	if (!fthlv)
 		fthlv = 1;
-- 
2.11.0

