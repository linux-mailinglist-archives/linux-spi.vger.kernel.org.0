Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5A81B5FD
	for <lists+linux-spi@lfdr.de>; Mon, 13 May 2019 14:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729916AbfEMMcB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 13 May 2019 08:32:01 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:59078 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729235AbfEMMcA (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 13 May 2019 08:32:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=tWseHOJxOEX0bhw42Fv5ajJXFJoNkOy72RWm4UOIp7E=; b=BbSv0r4RN5it
        U8hVkb9U84l/J7+9v4eWOxC8V9ry3LcR3CgdKz1+BRK090zuerzWJVzJAl3UMUIWr/ckpFkUwLDms
        nFRaMAxLrebwBpYjlk+08mG7uAYzZAB21wBLBru3IY7AFOAGK6QoK6l2tOUGBzYHvjSCc3KaWBJnM
        ATkWo=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hQA7W-0006ad-Bo; Mon, 13 May 2019 12:31:54 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id C3AB41129232; Mon, 13 May 2019 13:31:53 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Martin Sperl <kernel@martin.sperl.org>
Cc:     linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "spi: core: allow reporting the effectivly used speed_hz for a transfer" to the spi tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190513123153.C3AB41129232@debutante.sirena.org.uk>
Date:   Mon, 13 May 2019 13:31:53 +0100 (BST)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: core: allow reporting the effectivly used speed_hz for a transfer

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From 5d7e2b5ed5858fe739d4cb8ad22dcce7bd9dbe7b Mon Sep 17 00:00:00 2001
From: Martin Sperl <kernel@martin.sperl.org>
Date: Sat, 23 Feb 2019 08:49:49 +0000
Subject: [PATCH] spi: core: allow reporting the effectivly used speed_hz for a
 transfer

Provide a means for the spi bus driver to report the effectively used
spi clock frequency used for each spi_transfer.

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi.c       | 1 +
 include/linux/spi/spi.h | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index cfa3c3decb8a..e9bf0c23da50 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -3126,6 +3126,7 @@ static int __spi_validate(struct spi_device *spi, struct spi_message *message)
 	 */
 	message->frame_length = 0;
 	list_for_each_entry(xfer, &message->transfers, transfer_list) {
+		xfer->effective_speed_hz = 0;
 		message->frame_length += xfer->len;
 		if (!xfer->bits_per_word)
 			xfer->bits_per_word = spi->bits_per_word;
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index f55b20254612..d0c5ba746e01 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -745,6 +745,9 @@ extern void spi_res_release(struct spi_controller *ctlr,
  *	(set by bits_per_word) transmission.
  * @word_delay: clock cycles to inter word delay after each word size
  *	(set by bits_per_word) transmission.
+ * @effective_speed_hz: the effective SCK-speed that was used to
+ *      transfer this transfer. Set to 0 if the spi bus driver does
+ *      not support it.
  * @transfer_list: transfers are sequenced through @spi_message.transfers
  * @tx_sg: Scatterlist for transmit, currently not for client use
  * @rx_sg: Scatterlist for receive, currently not for client use
@@ -835,6 +838,8 @@ struct spi_transfer {
 	u32		speed_hz;
 	u16		word_delay;
 
+	u32		effective_speed_hz;
+
 	struct list_head transfer_list;
 };
 
-- 
2.20.1

