Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 179287E477
	for <lists+linux-spi@lfdr.de>; Thu,  1 Aug 2019 22:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726888AbfHAUrX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 1 Aug 2019 16:47:23 -0400
Received: from antares.kleine-koenig.org ([94.130.110.236]:60134 "EHLO
        antares.kleine-koenig.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbfHAUrX (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 1 Aug 2019 16:47:23 -0400
Received: by antares.kleine-koenig.org (Postfix, from userid 1000)
        id 8AD41749AD4; Thu,  1 Aug 2019 22:47:21 +0200 (CEST)
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
To:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Mark Brown <broonie@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Cc:     linux-spi@vger.kernel.org
Subject: [PATCH] spi: atmel: add tracing to custom .transfer_one_message callback
Date:   Thu,  1 Aug 2019 22:47:10 +0200
Message-Id: <20190801204710.27309-1-uwe@kleine-koenig.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Driver specific implementations for .transfer_one_message need to call
the tracing stuff themself. This is necessary to make spi tracing
actually useful.

Signed-off-by: Uwe Kleine-König <uwe@kleine-koenig.org>
---
 drivers/spi/spi-atmel.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index f00b367523cd..acf318e7330c 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -23,6 +23,7 @@
 #include <linux/gpio/consumer.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/pm_runtime.h>
+#include <trace/events/spi.h>
 
 /* SPI register offsets */
 #define SPI_CR					0x0000
@@ -1409,9 +1410,13 @@ static int atmel_spi_transfer_one_message(struct spi_master *master,
 	msg->actual_length = 0;
 
 	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
+		trace_spi_transfer_start(msg, xfer);
+
 		ret = atmel_spi_one_transfer(master, msg, xfer);
 		if (ret)
 			goto msg_done;
+
+		trace_spi_transfer_stop(msg, xfer);
 	}
 
 	if (as->use_pdc)
-- 
2.20.1

