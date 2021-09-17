Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 078F440F37B
	for <lists+linux-spi@lfdr.de>; Fri, 17 Sep 2021 09:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239283AbhIQHre convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Fri, 17 Sep 2021 03:47:34 -0400
Received: from mail.bytesnap.co.uk ([94.198.185.106]:45239 "EHLO
        mail.bytesnap.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231263AbhIQHre (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 17 Sep 2021 03:47:34 -0400
Received: from exch2016.ByteSnap.local (10.0.28.253) by
 exch2016.ByteSnap.local (10.0.28.253) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Fri, 17 Sep 2021 08:46:11 +0100
Received: from exch2016.ByteSnap.local ([fe80::fccc:6d14:b55e:d5a0]) by
 exch2016.ByteSnap.local ([fe80::fccc:6d14:b55e:d5a0%8]) with mapi id
 15.01.2308.014; Fri, 17 Sep 2021 08:46:11 +0100
From:   Ville Baillie <VilleB@bytesnap.co.uk>
To:     "tudor.ambarus@microchip.com" <tudor.ambarus@microchip.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "ludovic.desroches@microchip.com" <ludovic.desroches@microchip.com>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dan.sneddon@microchip.com" <dan.sneddon@microchip.com>,
        Ville Baillie <VilleB@bytesnap.co.uk>
Subject: [PATCH v2] spi: atmel: Fix PDC transfer setup bug
Thread-Topic: [PATCH v2] spi: atmel: Fix PDC transfer setup bug
Thread-Index: Aderl75ZSZUU23/3QUKqzWSAzGD4lQ==
Date:   Fri, 17 Sep 2021 07:46:11 +0000
Message-ID: <a86bf8dcf3154f6bbf7e1ae21c073ea1@bytesnap.co.uk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.0.27.202]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From 7f796c2004407f848f9ed97f406e24b9eadd74be Mon Sep 17 00:00:00 2001
From: Ville Baillie <villeb@bytesnap.co.uk>
Date: Thu, 16 Sep 2021 14:16:46 +0000
Subject: [PATCH v2] spi: atmel: Fix PDC transfer setup bug

Commit 5fa5e6dec762 ("spi: atmel: Switch to transfer_one transfer
method") refactored the code and changed a conditional causing
atmel_spi_dma_map_xfer to never be called in PDC mode. This causes the
driver to silently fail.

This patch changes the conditional to match the behaviour of the
previous commit before the refactor.

Signed-off-by: Ville Baillie <villeb@bytesnap.co.uk>
---
 drivers/spi/spi-atmel.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index 788dcdf25f00..f872cf196c2f 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -1301,7 +1301,7 @@ static int atmel_spi_one_transfer(struct spi_master *master,
         * DMA map early, for performance (empties dcache ASAP) and
         * better fault reporting.
         */
-       if ((!master->cur_msg_mapped)
+       if ((!master->cur_msg->is_dma_mapped)
                && as->use_pdc) {
                if (atmel_spi_dma_map_xfer(as, xfer) < 0)
                        return -ENOMEM;
@@ -1381,7 +1381,7 @@ static int atmel_spi_one_transfer(struct spi_master *master,
                }
        }

-       if (!master->cur_msg_mapped
+       if (!master->cur_msg->is_dma_mapped
                && as->use_pdc)
                atmel_spi_dma_unmap_xfer(master, xfer);

--
2.17.1
