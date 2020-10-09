Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE97288691
	for <lists+linux-spi@lfdr.de>; Fri,  9 Oct 2020 12:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387495AbgJIKKm (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 9 Oct 2020 06:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726357AbgJIKKm (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 9 Oct 2020 06:10:42 -0400
X-Greylist: delayed 444 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 09 Oct 2020 03:10:41 PDT
Received: from mail.bugwerft.de (mail.bugwerft.de [IPv6:2a03:6000:1011::59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BD775C0613D2
        for <linux-spi@vger.kernel.org>; Fri,  9 Oct 2020 03:10:41 -0700 (PDT)
Received: from zenbar.fritz.box (p57bc9e31.dip0.t-ipconnect.de [87.188.158.49])
        by mail.bugwerft.de (Postfix) with ESMTPSA id 02F234663B1;
        Fri,  9 Oct 2020 10:03:13 +0000 (UTC)
From:   Daniel Mack <daniel@zonque.org>
To:     linux-spi@vger.kernel.org
Cc:     broonie@kernel.org, Daniel Mack <daniel@zonque.org>
Subject: [PATCH] spi: cadence: Add SPI transfer delays
Date:   Fri,  9 Oct 2020 12:03:09 +0200
Message-Id: <20201009100309.381279-1-daniel@zonque.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

When processing an SPI transfer, honor the delay that might be passed
along with it.

Signed-off-by: Daniel Mack <daniel@zonque.org>
---
 drivers/spi/spi-cadence.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-cadence.c b/drivers/spi/spi-cadence.c
index 82a0ee09cbe14..ba9bf80a34419 100644
--- a/drivers/spi/spi-cadence.c
+++ b/drivers/spi/spi-cadence.c
@@ -418,8 +418,8 @@ static int cdns_transfer_one(struct spi_master *master,
 	xspi->rx_bytes = transfer->len;
 
 	cdns_spi_setup_transfer(spi, transfer);
-
 	cdns_spi_fill_tx_fifo(xspi);
+	spi_transfer_delay_exec(transfer);
 
 	cdns_spi_write(xspi, CDNS_SPI_IER, CDNS_SPI_IXR_DEFAULT);
 	return transfer->len;
-- 
2.26.2

