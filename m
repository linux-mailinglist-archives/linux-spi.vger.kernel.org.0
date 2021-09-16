Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 247EA40DE08
	for <lists+linux-spi@lfdr.de>; Thu, 16 Sep 2021 17:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239206AbhIPPc4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Thu, 16 Sep 2021 11:32:56 -0400
Received: from mail.bytesnap.co.uk ([94.198.185.106]:8716 "EHLO
        mail.bytesnap.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239233AbhIPPc4 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 16 Sep 2021 11:32:56 -0400
X-Greylist: delayed 902 seconds by postgrey-1.27 at vger.kernel.org; Thu, 16 Sep 2021 11:32:54 EDT
Received: from exch2016.ByteSnap.local (10.0.28.253) by
 exch2016.ByteSnap.local (10.0.28.253) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Thu, 16 Sep 2021 16:16:31 +0100
Received: from exch2016.ByteSnap.local ([fe80::fccc:6d14:b55e:d5a0]) by
 exch2016.ByteSnap.local ([fe80::fccc:6d14:b55e:d5a0%8]) with mapi id
 15.01.2308.014; Thu, 16 Sep 2021 16:16:31 +0100
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
Subject: [PATCH] spi: atmel: Fix PDC transfer setup bug
Thread-Topic: [PATCH] spi: atmel: Fix PDC transfer setup bug
Thread-Index: AderDWrzqf5xpvNgRsOaMaLInBknhQ==
Date:   Thu, 16 Sep 2021 15:16:31 +0000
Message-ID: <3804cb61226e433fb1f7cde911a2785a@bytesnap.co.uk>
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

From 614bcf515cc8dbd1b7573a2fbf369fc84fca0501 Mon Sep 17 00:00:00 2001
From: Ville Baillie <villeb@bytesnap.co.uk>
Date: Thu, 16 Sep 2021 14:16:46 +0000
Subject: [PATCH] spi: atmel: Fix PDC transfer setup bug

Commit d370f4b2808d ("spi: atmel: Switch to transfer_one transfer
method") refactored the code and changed a conditional causing
atmel_spi_dma_map_xfer to never be called in PDC mode. This causes the
driver to silently fail.

This patch changes the conditional to match the behaviour of the
previous commit before the refactor.

Signed-off-by: Ville Baillie <villeb@bytesnap.co.uk>
---
 drivers/spi/spi-atmel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index 788dcdf25f00..f00e9c9b426e 100644
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
--
2.17.1

