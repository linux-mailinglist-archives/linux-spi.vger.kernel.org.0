Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF5795469CF
	for <lists+linux-spi@lfdr.de>; Fri, 10 Jun 2022 17:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243859AbiFJPut (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 10 Jun 2022 11:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344090AbiFJPus (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 10 Jun 2022 11:50:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ADE1253
        for <linux-spi@vger.kernel.org>; Fri, 10 Jun 2022 08:50:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AA938B83325
        for <linux-spi@vger.kernel.org>; Fri, 10 Jun 2022 15:50:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62562C3411B;
        Fri, 10 Jun 2022 15:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654876244;
        bh=mUpK+6sJGpYDjPP5YJCxa2OYGApdHsaKWkI2cKj+9qE=;
        h=From:To:Cc:Subject:Date:From;
        b=SXOzR5jQ8snpcMLVlCed5We1ZuFwpm3E/LxvSPvGcDcRV4JRLD6Ccbk46Bgnc6fi+
         F5rds3x+x88lk54DT5kGkreBH8VwMade2hhiB8SeAeaRU2W0Zzjs1jlXR7xQH2eqOi
         xkKCbRFr0Ad9b8pk6NVIn3Sb3I/XJ6ke3sEY5rzPp8Ckvxols+fGgPuqMmMZAEfCiO
         UNyz9tUNXCiwdTxbbewgiE/URxY6QE9RJZAgBCKJOMXDfKsdjsSupVXvtgm9o+y5T+
         Agt2Z73OAsOQqHq8pZluJeqV4wCz9vbIx69IGjJfuj68zJlupqBVzptSZGCaswnTDn
         b4aEVV70iMxRA==
From:   Mark Brown <broonie@kernel.org>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH] spi: sh: Switch to using core message queue
Date:   Fri, 10 Jun 2022 16:46:49 +0100
Message-Id: <20220610154649.1707851-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5516; h=from:subject; bh=mUpK+6sJGpYDjPP5YJCxa2OYGApdHsaKWkI2cKj+9qE=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBio2dABJ9/GWSajRgJ9Bylje6oCBVZa2Op0xS20aiF rJsNqHyJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYqNnQAAKCRAk1otyXVSH0ElBB/ 41ICo3z60uabPDQynMoJB9UlNO7pMp8OXoC6d9Qv4xDi7ic5SmKt8A2XmYdVP9i36mBj3arVXRo8+n xEBYYRyUlRY4Yr6RHxArt0ViEwhi/CrEJiV1LW4SbzFNuJ96iiYpjQBcPL5YmYUCKfG8v/Jsi6JGKM 6eVvfpNuUop3x/7UhcVjK5ssoGTS+dWLwDB1OkOHyaaU608RJVpPOAup5X5plWZRb/BG1tjjEj1Sfw FEHNz9XF5nRjpjo67dP+W4y3osaxevvMSDaG7ElrU1+EhCeeKN0bZ4bg7028ZsaBeWbvPgQjKIPvDs tE8N4hWD51gy9VdGee1EYfKf9nBaKl
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

We deprecated open coding of the transfer queue back in 2017 so it's high
time we finished up converting drivers to use the standard message queue
code. The SH driver is fairly straightforward so convert to use
transfer_one_message(), it looks like the driver would be a good fit for
transfer_one() with a little bit of updating but this smaller change seems
safer.

I'm not actually clear how the driver worked robustly previously, it
clears SSA and CR1 when queueing a transfer which looks like it would
interfere with any running transfer. This clearing has been moved to the
start of the message transfer function.

I'm also unclear how exactly the chip select is managed with this driver.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-sh.c | 94 +++++++++++++-------------------------------
 1 file changed, 28 insertions(+), 66 deletions(-)

diff --git a/drivers/spi/spi-sh.c b/drivers/spi/spi-sh.c
index 45f304935332..3e72fad99adf 100644
--- a/drivers/spi/spi-sh.c
+++ b/drivers/spi/spi-sh.c
@@ -73,11 +73,8 @@ struct spi_sh_data {
 	void __iomem *addr;
 	int irq;
 	struct spi_master *master;
-	struct list_head queue;
-	struct work_struct ws;
 	unsigned long cr1;
 	wait_queue_head_t wait;
-	spinlock_t lock;
 	int width;
 };
 
@@ -271,47 +268,39 @@ static int spi_sh_receive(struct spi_sh_data *ss, struct spi_message *mesg,
 	return 0;
 }
 
-static void spi_sh_work(struct work_struct *work)
+static int spi_sh_transfer_one_message(struct spi_controller *ctlr,
+					struct spi_message *mesg)
 {
-	struct spi_sh_data *ss = container_of(work, struct spi_sh_data, ws);
-	struct spi_message *mesg;
+	struct spi_sh_data *ss = spi_controller_get_devdata(ctlr);
 	struct spi_transfer *t;
-	unsigned long flags;
 	int ret;
 
 	pr_debug("%s: enter\n", __func__);
 
-	spin_lock_irqsave(&ss->lock, flags);
-	while (!list_empty(&ss->queue)) {
-		mesg = list_entry(ss->queue.next, struct spi_message, queue);
-		list_del_init(&mesg->queue);
-
-		spin_unlock_irqrestore(&ss->lock, flags);
-		list_for_each_entry(t, &mesg->transfers, transfer_list) {
-			pr_debug("tx_buf = %p, rx_buf = %p\n",
-					t->tx_buf, t->rx_buf);
-			pr_debug("len = %d, delay.value = %d\n",
-					t->len, t->delay.value);
-
-			if (t->tx_buf) {
-				ret = spi_sh_send(ss, mesg, t);
-				if (ret < 0)
-					goto error;
-			}
-			if (t->rx_buf) {
-				ret = spi_sh_receive(ss, mesg, t);
-				if (ret < 0)
-					goto error;
-			}
-			mesg->actual_length += t->len;
-		}
-		spin_lock_irqsave(&ss->lock, flags);
+	spi_sh_clear_bit(ss, SPI_SH_SSA, SPI_SH_CR1);
 
-		mesg->status = 0;
-		if (mesg->complete)
-			mesg->complete(mesg->context);
+	list_for_each_entry(t, &mesg->transfers, transfer_list) {
+		pr_debug("tx_buf = %p, rx_buf = %p\n",
+			 t->tx_buf, t->rx_buf);
+		pr_debug("len = %d, delay.value = %d\n",
+			 t->len, t->delay.value);
+
+		if (t->tx_buf) {
+			ret = spi_sh_send(ss, mesg, t);
+			if (ret < 0)
+				goto error;
+		}
+		if (t->rx_buf) {
+			ret = spi_sh_receive(ss, mesg, t);
+			if (ret < 0)
+				goto error;
+		}
+		mesg->actual_length += t->len;
 	}
 
+	mesg->status = 0;
+	spi_finalize_current_message(ctlr);
+
 	clear_fifo(ss);
 	spi_sh_set_bit(ss, SPI_SH_SSD, SPI_SH_CR1);
 	udelay(100);
@@ -321,12 +310,11 @@ static void spi_sh_work(struct work_struct *work)
 
 	clear_fifo(ss);
 
-	spin_unlock_irqrestore(&ss->lock, flags);
-
-	return;
+	return 0;
 
  error:
 	mesg->status = ret;
+	spi_finalize_current_message(ctlr);
 	if (mesg->complete)
 		mesg->complete(mesg->context);
 
@@ -334,6 +322,7 @@ static void spi_sh_work(struct work_struct *work)
 			 SPI_SH_CR1);
 	clear_fifo(ss);
 
+	return ret;
 }
 
 static int spi_sh_setup(struct spi_device *spi)
@@ -355,29 +344,6 @@ static int spi_sh_setup(struct spi_device *spi)
 	return 0;
 }
 
-static int spi_sh_transfer(struct spi_device *spi, struct spi_message *mesg)
-{
-	struct spi_sh_data *ss = spi_master_get_devdata(spi->master);
-	unsigned long flags;
-
-	pr_debug("%s: enter\n", __func__);
-	pr_debug("\tmode = %02x\n", spi->mode);
-
-	spin_lock_irqsave(&ss->lock, flags);
-
-	mesg->actual_length = 0;
-	mesg->status = -EINPROGRESS;
-
-	spi_sh_clear_bit(ss, SPI_SH_SSA, SPI_SH_CR1);
-
-	list_add_tail(&mesg->queue, &ss->queue);
-	schedule_work(&ss->ws);
-
-	spin_unlock_irqrestore(&ss->lock, flags);
-
-	return 0;
-}
-
 static void spi_sh_cleanup(struct spi_device *spi)
 {
 	struct spi_sh_data *ss = spi_master_get_devdata(spi->master);
@@ -416,7 +382,6 @@ static int spi_sh_remove(struct platform_device *pdev)
 	struct spi_sh_data *ss = platform_get_drvdata(pdev);
 
 	spi_unregister_master(ss->master);
-	flush_work(&ss->ws);
 	free_irq(ss->irq, ss);
 
 	return 0;
@@ -467,9 +432,6 @@ static int spi_sh_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "ioremap error.\n");
 		return -ENOMEM;
 	}
-	INIT_LIST_HEAD(&ss->queue);
-	spin_lock_init(&ss->lock);
-	INIT_WORK(&ss->ws, spi_sh_work);
 	init_waitqueue_head(&ss->wait);
 
 	ret = request_irq(irq, spi_sh_irq, 0, "spi_sh", ss);
@@ -481,7 +443,7 @@ static int spi_sh_probe(struct platform_device *pdev)
 	master->num_chipselect = 2;
 	master->bus_num = pdev->id;
 	master->setup = spi_sh_setup;
-	master->transfer = spi_sh_transfer;
+	master->transfer_one_message = spi_sh_transfer_one_message;
 	master->cleanup = spi_sh_cleanup;
 
 	ret = spi_register_master(master);
-- 
2.30.2

