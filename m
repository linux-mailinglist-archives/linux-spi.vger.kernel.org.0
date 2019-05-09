Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4ADC918894
	for <lists+linux-spi@lfdr.de>; Thu,  9 May 2019 12:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbfEIKzz (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 9 May 2019 06:55:55 -0400
Received: from 212-186-180-163.static.upcbusiness.at ([212.186.180.163]:36350
        "EHLO cgate.sperl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbfEIKzy (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 9 May 2019 06:55:54 -0400
Received: from hc1.intern.sperl.org (account martin@sperl.org [10.10.10.59] verified)
  by sperl.org (CommuniGate Pro SMTP 6.2.1 _community_)
  with ESMTPSA id 7764482; Thu, 09 May 2019 10:55:46 +0000
From:   kernel@martin.sperl.org
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Meghana Madhyastha <meghana.madhyastha@gmail.com>,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Mark Brown <broonie@kernel.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        linux-spi@vger.kernel.org
Cc:     Martin Sperl <kernel@martin.sperl.org>
Subject: [PATCH V1 1/3] spi: core: resource: fix memory leak on error and place in "correct" sequence
Date:   Thu,  9 May 2019 10:55:31 +0000
Message-Id: <20190509105533.24275-2-kernel@martin.sperl.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190509105533.24275-1-kernel@martin.sperl.org>
References: <20190509105533.24275-1-kernel@martin.sperl.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Martin Sperl <kernel@martin.sperl.org>

When an error occurs in ctlr->prepare_message or spi_map_msg
then spi_resources is not cleared leaving unexpected entries and
memory.

Also there is an ordering issue:
On ititialization:
* prepare_message
* spi_map_msg

and when releasing:
* spi_res_release (outside of finalize)
  -> this restores the spi structures
* spi_unmap_msg
* unprepare_message

So the ordering is wrong in the case that prepare_message is
modifying the spi_message and spi_message.resources.

Especially the dma unmapping of all the translations are not done.

There is still an ambiguity where is the "best" place where to place
spi_res_release - it definitely has to be after spi_unmap_msg,
but if it should be before or after unprepare message is not well
defined.

Ideally this dma unmap and unprepare_message would be executed
by spi_res_release and thus in the guaranteed order they were applied.

This incidently implements a better way for the reverted
commit c9ba7a16d0f1 ("spi: Release spi_res after finalizing message")

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
---
 drivers/spi/spi.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 8eb7460dd744..1dfb19140bbe 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1181,8 +1181,6 @@ static int spi_transfer_one_message(struct spi_controller *ctlr,
 	if (msg->status && ctlr->handle_err)
 		ctlr->handle_err(ctlr, msg);

-	spi_res_release(ctlr, msg);
-
 	spi_finalize_current_message(ctlr);

 	return ret;
@@ -1448,6 +1446,15 @@ void spi_finalize_current_message(struct spi_controller *ctlr)
 		}
 	}

+	/* where to put the release is a slight nightmare because
+	 * ctlr->prepare_message may add to resources as well.
+	 * so the question is: call it before unprepare or after?
+	 * for now leave it after - the asumption here is that
+	 * if prepare_message is using spi_res for callbacks,
+	 * then no unprepare_message is used
+	 */
+	spi_res_release(ctlr, mesg);
+
 	spin_lock_irqsave(&ctlr->queue_lock, flags);
 	ctlr->cur_msg = NULL;
 	ctlr->cur_msg_prepared = false;
--
2.11.0
