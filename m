Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 737D83191F0
	for <lists+linux-spi@lfdr.de>; Thu, 11 Feb 2021 19:13:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231936AbhBKSLM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 11 Feb 2021 13:11:12 -0500
Received: from mx2.suse.de ([195.135.220.15]:51450 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232662AbhBKSJJ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 11 Feb 2021 13:09:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 60092AE87;
        Thu, 11 Feb 2021 18:08:27 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Mark Brown <broonie@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Phil Elwell <phil@raspberrypi.com>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] spi: Skip zero-length transfers in spi_transfer_one_message()
Date:   Thu, 11 Feb 2021 19:08:20 +0100
Message-Id: <20210211180820.25757-1-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

With the introduction of 26751de25d25 ("spi: bcm2835: Micro-optimise
FIFO loops") it has become apparent that some users might initiate
zero-length SPI transfers. A fact the micro-optimization omitted, and
which turned out to cause crashes[1].

Instead of changing the micro-optimization itself, use a bigger hammer
and skip zero-length transfers altogether for drivers using the default
transfer_one_message() implementation.

Reported-by: Phil Elwell <phil@raspberrypi.com>
Fixes: 26751de25d25 ("spi: bcm2835: Micro-optimise FIFO loops")
Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

[1] https://github.com/raspberrypi/linux/issues/4100

---

NOTE: I've reviewed a bunch of drivers and couldn't find a compelling
reason why zero-length transfers should be passed into them. But I
might be missing something.

 drivers/spi/spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 7745eec994fd..b08efe88ccd6 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1269,7 +1269,7 @@ static int spi_transfer_one_message(struct spi_controller *ctlr,
 			ptp_read_system_prets(xfer->ptp_sts);
 		}
 
-		if (xfer->tx_buf || xfer->rx_buf) {
+		if ((xfer->tx_buf || xfer->rx_buf) && xfer->len) {
 			reinit_completion(&ctlr->xfer_completion);
 
 fallback_pio:
-- 
2.30.0

