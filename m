Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A97EF5A9666
	for <lists+linux-spi@lfdr.de>; Thu,  1 Sep 2022 14:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233353AbiIAMLR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 1 Sep 2022 08:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233342AbiIAMLP (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 1 Sep 2022 08:11:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7BB610B945
        for <linux-spi@vger.kernel.org>; Thu,  1 Sep 2022 05:11:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A70C161E36
        for <linux-spi@vger.kernel.org>; Thu,  1 Sep 2022 12:11:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4878C433D7;
        Thu,  1 Sep 2022 12:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662034267;
        bh=3MDc6l/CTHBGpIhLzEAzcIRM2CRiMDVAT1jy33m15U8=;
        h=From:To:Cc:Subject:Date:From;
        b=huJkOGuLMkhYMLAjxfYoo1gl9m6sJGMPxoCkrDqLIgu/ajmhALX6CKymuoMvffEzL
         QyhZ0/+yZfhHdOpJvbky3Zsf2ylb/jz2YABUZQTufRm7b6MNGUKbUogFNe0KpiE9Ye
         I4nQ9j1v3BOfG1XCAmwLAfEfc2zg+a+vU2+kC/cg3OiPB3AMvtlbi5lwFgn534Bpxu
         oLSTPT1UYcYHLxHn0qsS6aEx3Xx3Z5oGmUAKrBIuA+Ut/EFmATU1GHStzTXs1dty81
         5pP2w8Ud2F6/BAbnb+druHZuaocMUDj/mtv80glhCkonEQCTD16lzQWprIJ5/7Hb8w
         cekfdE9Wn+uyw==
From:   Mark Brown <broonie@kernel.org>
To:     David Jander <david@protonic.nl>,
        Casper Andersson <casper.casan@gmail.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v1] spi: mux: Fix mux interaction with fast path optimisations
Date:   Thu,  1 Sep 2022 13:07:32 +0100
Message-Id: <20220901120732.49245-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3371; i=broonie@kernel.org; h=from:subject; bh=3MDc6l/CTHBGpIhLzEAzcIRM2CRiMDVAT1jy33m15U8=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjEKCDdA+qC2/tZCd1TCaAbRbuwhT+fCfqe4T4NPSg Zl7MzSSJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYxCggwAKCRAk1otyXVSH0JRXB/ 9yAaaGqnHoxTcSKpArMJIW5abgzMaJR3OVnZF/pmEzDJtdU0QfnYF5VfcKEMu76xcR2xUtVU0YGaFu uyziLDo0VWr8iC7NulXiuthX8LK6jPGQ6hKYFYNRwMgWrwCbQ0VtUPOtESic5/YN9L5FSx9dvbYTmP p5f/Sp0oqZ4FwLdaLGMKXbAABmeMcatASA0v7Ry8jFl2M33aNddbOJvTgPL3/pX4nrYHxVU2pyLxkd TKc/imM0pnd6b/47Zn7FjtFOL+wG7UMhUrKdvS8htx9vthSx8ZFrvmzF7sR7RQJ3BQhKSuoR2zTPKE /cuL4JecAKQRwfjWefldWP2cVlDu7o
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The spi-mux driver is rather too clever and attempts to resubmit any
message that is submitted to it to the parent controller with some
adjusted callbacks.  This does not play at all nicely with the fast
path which now sets flags on the message indicating that it's being
handled through the fast path, we see async messages flagged as being on
the fast path.  Ideally the spi-mux code would duplicate the message but
that's rather invasive and a bit fragile in that it relies on the mux
knowing which fields in the message to copy.  Instead teach the core
that there are controllers which can't cope with the fast path and have
the mux flag itself as being such a controller, ensuring that messages
going via the mux don't get partially handled via the fast path.

This will reduce the performance of any spi-mux connected device since
we'll now always use the thread for both the actual controller and the
mux controller instead of just the actual controller but given that we
were always hitting the slow path anyway it's hopefully not too much of
an additional cost and it allows us to keep the fast path.

Fixes: ae7d2346dc89 ("spi: Don't use the message queue if possible in spi_sync")
Reported-by: Casper Andersson <casper.casan@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-mux.c   | 1 +
 drivers/spi/spi.c       | 2 +-
 include/linux/spi/spi.h | 2 ++
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mux.c b/drivers/spi/spi-mux.c
index f5d32ec4634e..0709e987bd5a 100644
--- a/drivers/spi/spi-mux.c
+++ b/drivers/spi/spi-mux.c
@@ -161,6 +161,7 @@ static int spi_mux_probe(struct spi_device *spi)
 	ctlr->num_chipselect = mux_control_states(priv->mux);
 	ctlr->bus_num = -1;
 	ctlr->dev.of_node = spi->dev.of_node;
+	ctlr->must_async = true;
 
 	ret = devm_spi_register_controller(&spi->dev, ctlr);
 	if (ret)
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 83da8862b8f2..c4ccd45ebc1a 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -4033,7 +4033,7 @@ static int __spi_sync(struct spi_device *spi, struct spi_message *message)
 	 * guard against reentrancy from a different context. The io_mutex
 	 * will catch those cases.
 	 */
-	if (READ_ONCE(ctlr->queue_empty)) {
+	if (READ_ONCE(ctlr->queue_empty) && !ctlr->must_async) {
 		message->actual_length = 0;
 		message->status = -EINPROGRESS;
 
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index e6c73d5ff1a8..f089ee1ead58 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -469,6 +469,7 @@ extern struct spi_device *spi_new_ancillary_device(struct spi_device *spi, u8 ch
  *	SPI_TRANS_FAIL_NO_START.
  * @queue_empty: signal green light for opportunistically skipping the queue
  *	for spi_sync transfers.
+ * @must_async: disable all fast paths in the core
  *
  * Each SPI controller can communicate with one or more @spi_device
  * children.  These make a small bus, sharing MOSI, MISO and SCK signals
@@ -690,6 +691,7 @@ struct spi_controller {
 
 	/* Flag for enabling opportunistic skipping of the queue in spi_sync */
 	bool			queue_empty;
+	bool			must_async;
 };
 
 static inline void *spi_controller_get_devdata(struct spi_controller *ctlr)

base-commit: b90cb1053190353cc30f0fef0ef1f378ccc063c5
-- 
2.30.2

