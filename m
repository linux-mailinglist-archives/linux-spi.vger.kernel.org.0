Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 069D136290A
	for <lists+linux-spi@lfdr.de>; Fri, 16 Apr 2021 22:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244249AbhDPUHM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 16 Apr 2021 16:07:12 -0400
Received: from perseus.uberspace.de ([95.143.172.134]:56362 "EHLO
        perseus.uberspace.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236363AbhDPUHM (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 16 Apr 2021 16:07:12 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Fri, 16 Apr 2021 16:07:11 EDT
Received: (qmail 11258 invoked from network); 16 Apr 2021 20:00:04 -0000
Received: from localhost (HELO localhost) (127.0.0.1)
  by perseus.uberspace.de with SMTP; 16 Apr 2021 20:00:04 -0000
From:   David Bauer <mail@david-bauer.net>
To:     broonie@kernel.org, linux-spi@vger.kernel.org
Subject: [PATCH] spi: sync up initial chipselect state
Date:   Fri, 16 Apr 2021 21:59:56 +0200
Message-Id: <20210416195956.121811-1-mail@david-bauer.net>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

When initially probing the SPI slave device, the call for disabling an
SPI device without the SPI_CS_HIGH flag is not applied, as the
condition for checking whether or not the state to be applied equals the
one currently set evaluates to true.

This however might not necessarily be the case, as the chipselect might
be active.

Add a force flag to spi_set_cs which allows to override this
early exit condition. Set it to false everywhere except when called
from spi_setup to sync up the initial CS state.

Fixes commit d40f0b6f2e21 ("spi: Avoid setting the chip select if we don't
need to")

Signed-off-by: David Bauer <mail@david-bauer.net>
---
 drivers/spi/spi.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index b08efe88ccd6..927c2a28011f 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -795,7 +795,7 @@ int spi_register_board_info(struct spi_board_info const *info, unsigned n)
 
 /*-------------------------------------------------------------------------*/
 
-static void spi_set_cs(struct spi_device *spi, bool enable)
+static void spi_set_cs(struct spi_device *spi, bool enable, bool force)
 {
 	bool enable1 = enable;
 
@@ -803,7 +803,7 @@ static void spi_set_cs(struct spi_device *spi, bool enable)
 	 * Avoid calling into the driver (or doing delays) if the chip select
 	 * isn't actually changing from the last time this was called.
 	 */
-	if ((spi->controller->last_cs_enable == enable) &&
+	if (!force && (spi->controller->last_cs_enable == enable) &&
 	    (spi->controller->last_cs_mode_high == (spi->mode & SPI_CS_HIGH)))
 		return;
 
@@ -1253,7 +1253,7 @@ static int spi_transfer_one_message(struct spi_controller *ctlr,
 	struct spi_statistics *statm = &ctlr->statistics;
 	struct spi_statistics *stats = &msg->spi->statistics;
 
-	spi_set_cs(msg->spi, true);
+	spi_set_cs(msg->spi, true, false);
 
 	SPI_STATISTICS_INCREMENT_FIELD(statm, messages);
 	SPI_STATISTICS_INCREMENT_FIELD(stats, messages);
@@ -1321,9 +1321,9 @@ static int spi_transfer_one_message(struct spi_controller *ctlr,
 					 &msg->transfers)) {
 				keep_cs = true;
 			} else {
-				spi_set_cs(msg->spi, false);
+				spi_set_cs(msg->spi, false, false);
 				_spi_transfer_cs_change_delay(msg, xfer);
-				spi_set_cs(msg->spi, true);
+				spi_set_cs(msg->spi, true, false);
 			}
 		}
 
@@ -1332,7 +1332,7 @@ static int spi_transfer_one_message(struct spi_controller *ctlr,
 
 out:
 	if (ret != 0 || !keep_cs)
-		spi_set_cs(msg->spi, false);
+		spi_set_cs(msg->spi, false, false);
 
 	if (msg->status == -EINPROGRESS)
 		msg->status = ret;
@@ -3423,11 +3423,11 @@ int spi_setup(struct spi_device *spi)
 		 */
 		status = 0;
 
-		spi_set_cs(spi, false);
+		spi_set_cs(spi, false, true);
 		pm_runtime_mark_last_busy(spi->controller->dev.parent);
 		pm_runtime_put_autosuspend(spi->controller->dev.parent);
 	} else {
-		spi_set_cs(spi, false);
+		spi_set_cs(spi, false, true);
 	}
 
 	mutex_unlock(&spi->controller->io_mutex);
-- 
2.31.1

