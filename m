Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9261242BFE8
	for <lists+linux-spi@lfdr.de>; Wed, 13 Oct 2021 14:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbhJMM2r (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 13 Oct 2021 08:28:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:35370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232711AbhJMM2r (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 13 Oct 2021 08:28:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6418D610E7;
        Wed, 13 Oct 2021 12:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634128003;
        bh=CgEhGQJKAtbcV+txw1powHsZ1nVC7mQRlQFB0yTie/M=;
        h=From:To:Cc:Subject:Date:From;
        b=c0gSbk9/3L8wgTA8pXDvlyWVXbyzxGvWuHXMmiQ5ngJDqbr6jzrcYKVf1UiAZqFxP
         2LcOHJVQ3ZvQKB+HQso2N6wT+Q0q+uSYsc9S2BaGkOT8qZzCbewvbqNfzoQvpWPt2f
         Bh2VfKZU8fCjQ0IoI1smhH4WWNtkfozq+n3PF25eacCIxLPTdTqdPE/Qoncw2Lk4t3
         pbTGdzCYV1lekBzhrBpsV++nYNFF3cporcRDw6YwP4mwB+ERH76yL9tNRI78s/V62r
         djnwfN42evoJVex1aQ3L4/0p+vMI+TQRrl+l8vMXvAVIyCsjOgczSy+DT5aQ9HiX4p
         qgCHi8ihQXr6g==
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: [PATCH] spi: Fix deadlock when adding SPI controllers on SPI buses
Date:   Wed, 13 Oct 2021 13:26:28 +0100
Message-Id: <20211013122628.1369702-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3617; h=from:subject; bh=CgEhGQJKAtbcV+txw1powHsZ1nVC7mQRlQFB0yTie/M=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhZtBPrSA54TByX1/8cuWo2SAtYO/E5Xy4uTvz/GeN sNJnAhGJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYWbQTwAKCRAk1otyXVSH0OugB/ 44yNaBWGvwPQ5Kxr9aS2DfCFbQF5Yc3ATHfLvxjyUZRvP5LR/zk4p7PjFlYBgYi/labU1ZVCyZit6+ oXnKJ5vOS24O+n3s/DRU4AU5XuJtP1jnkhsFRCkI5eoUv1+Iz99knG3LeFwVguSTD347rnOUtJFw4Z 7ykyqRoxe7mQ+J45/3Shho33do+njf4A6g5fIdtnWqW7+U53HUmczPLM/6sylz435M3eQ8mkBFQUQo pYjKxFfa/cwCbByq71UkwBglB1MDJdlcAWLI7UxLwt92uvqF2UcXj31mkd+atlLCP5x8WyHPb9Xtsq I6ysI9w7aCpESuTdRRarmx5fA96N7D
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Currently we have a global spi_add_lock which we take when adding new
devices so that we can check that we're not trying to reuse a chip
select that's already controlled.  This means that if the SPI device is
itself a SPI controller and triggers the instantiation of further SPI
devices we trigger a deadlock as we try to register and instantiate
those devices while in the process of doing so for the parent controller
and hence already holding the global spi_add_lock.  Since we only care
about concurrency within a single SPI bus move the lock to be per
controller, avoiding the deadlock.

This can be easily triggered in the case of spi-mux.

Reported-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi.c       | 21 ++++++++++-----------
 include/linux/spi/spi.h |  3 +++
 2 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 401f62f6f5b5..71d061132ada 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -518,12 +518,6 @@ static LIST_HEAD(spi_controller_list);
  */
 static DEFINE_MUTEX(board_lock);
 
-/*
- * Prevents addition of devices with same chip select and
- * addition of devices below an unregistering controller.
- */
-static DEFINE_MUTEX(spi_add_lock);
-
 /**
  * spi_alloc_device - Allocate a new SPI device
  * @ctlr: Controller to which device is connected
@@ -676,9 +670,13 @@ static int spi_add_device(struct spi_device *spi)
 	/* Set the bus ID string */
 	spi_dev_set_name(spi);
 
-	mutex_lock(&spi_add_lock);
+	/* We need to make sure there's no other device with this
+	 * chipselect **BEFORE** we call setup(), else we'll trash
+	 * its configuration.  Lock against concurrent add() calls.
+	 */
+	mutex_lock(&ctlr->add_lock);
 	status = __spi_add_device(spi);
-	mutex_unlock(&spi_add_lock);
+	mutex_unlock(&ctlr->add_lock);
 	return status;
 }
 
@@ -697,7 +695,7 @@ static int spi_add_device_locked(struct spi_device *spi)
 	/* Set the bus ID string */
 	spi_dev_set_name(spi);
 
-	WARN_ON(!mutex_is_locked(&spi_add_lock));
+	WARN_ON(!mutex_is_locked(&ctlr->add_lock));
 	return __spi_add_device(spi);
 }
 
@@ -2950,6 +2948,7 @@ int spi_register_controller(struct spi_controller *ctlr)
 	spin_lock_init(&ctlr->bus_lock_spinlock);
 	mutex_init(&ctlr->bus_lock_mutex);
 	mutex_init(&ctlr->io_mutex);
+	mutex_init(&ctlr->add_lock);
 	ctlr->bus_lock_flag = 0;
 	init_completion(&ctlr->xfer_completion);
 	if (!ctlr->max_dma_len)
@@ -3086,7 +3085,7 @@ void spi_unregister_controller(struct spi_controller *ctlr)
 
 	/* Prevent addition of new devices, unregister existing ones */
 	if (IS_ENABLED(CONFIG_SPI_DYNAMIC))
-		mutex_lock(&spi_add_lock);
+		mutex_lock(&ctlr->add_lock);
 
 	device_for_each_child(&ctlr->dev, NULL, __unregister);
 
@@ -3117,7 +3116,7 @@ void spi_unregister_controller(struct spi_controller *ctlr)
 	mutex_unlock(&board_lock);
 
 	if (IS_ENABLED(CONFIG_SPI_DYNAMIC))
-		mutex_unlock(&spi_add_lock);
+		mutex_unlock(&ctlr->add_lock);
 }
 EXPORT_SYMBOL_GPL(spi_unregister_controller);
 
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 29e21d49aafc..eb7ac8a1e03c 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -527,6 +527,9 @@ struct spi_controller {
 	/* I/O mutex */
 	struct mutex		io_mutex;
 
+	/* Used to avoid adding the same CS twice */
+	struct mutex		add_lock;
+
 	/* lock and mutex for SPI bus locking */
 	spinlock_t		bus_lock_spinlock;
 	struct mutex		bus_lock_mutex;
-- 
2.30.2

