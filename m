Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 223D942C2F9
	for <lists+linux-spi@lfdr.de>; Wed, 13 Oct 2021 16:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237387AbhJMOZv (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 13 Oct 2021 10:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237307AbhJMOZq (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 13 Oct 2021 10:25:46 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A66FAC061570
        for <linux-spi@vger.kernel.org>; Wed, 13 Oct 2021 07:23:35 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mafAM-0007eD-1P; Wed, 13 Oct 2021 16:23:34 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mafAK-0005d9-Oo; Wed, 13 Oct 2021 16:23:32 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mafAK-0007jZ-O4; Wed, 13 Oct 2021 16:23:32 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     kernel@pengutronix.de, linux-spi@vger.kernel.org
Subject: [PATCH 2/2] spi-mux: Fix false-positive lockdep splats
Date:   Wed, 13 Oct 2021 15:37:10 +0200
Message-Id: <20211013133710.2679703-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211013133710.2679703-1-u.kleine-koenig@pengutronix.de>
References: <20211013133710.2679703-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=GmV54BYZllLKsz7VkfghoOiGcoTv0LJ4fEcz/X0yKXw=; m=0dPnly2CxBt+MmNXnYpm2iVb63Kl480qW3iOirV/2vo=; p=xVK2ofTkqv137h/cJDorRBFEdRbDk87NQip2N6JtYNs=; g=bb34e4727a2f3720e1e64ab56c8766185ece3e56
X-Patch-Sig: m=pgp; i=u.kleine-koenig@pengutronix.de; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmFm4QMACgkQwfwUeK3K7AmHVwgAg+E KsqEy5riOT1rXkJ2iZG01WwvKyyqtC6pdIP/eIQZ8qe38W1UuexnDJ4qtkKsvdFwKZfDPi/REVCaO YAcK7OUSIRV0wwpqbDW/vqJgJKStWI8Y7xZa3j9CHmECQpbg7yAvO9aM82OLNI+BYh1XGEAUO4OSh 8sOG3ALMzMZf00Rz340ZjSWhWQSvwkZepIGWnLrdDeQxztO8K7Kv43Cbw4f3ynWC6S+wOUyzSISg4 +5qHRRZsXVdG+ZoeOwbCzNt91KoIDEDHwjbzwPoWzTS0wtKAmwXgrPA8actCj/DFDxxQzIL6MrO4x 4t2yBmlxIttNRT4qdM46F7a3KODsXFw==
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

io_mutex is taken by spi_setup() and spi-mux's .setup() callback calls
spi_setup() which results in a nested lock of io_mutex.

add_lock is taken by spi_add_device(). The device_add() call in there
can result in calling spi-mux's .probe() callback which registers its
own spi controller which in turn results in spi_add_device() being
called again.

To fix this initialize the controller's locks already in
spi_alloc_controller() to give spi_mux_probe() a chance to set the
lockdep subclass.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/spi/spi-mux.c |  7 +++++++
 drivers/spi/spi.c     | 12 ++++++------
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-mux.c b/drivers/spi/spi-mux.c
index 9708b7827ff7..f5d32ec4634e 100644
--- a/drivers/spi/spi-mux.c
+++ b/drivers/spi/spi-mux.c
@@ -137,6 +137,13 @@ static int spi_mux_probe(struct spi_device *spi)
 	priv = spi_controller_get_devdata(ctlr);
 	priv->spi = spi;
 
+	/*
+	 * Increase lockdep class as these lock are taken while the parent bus
+	 * already holds their instance's lock.
+	 */
+	lockdep_set_subclass(&ctlr->io_mutex, 1);
+	lockdep_set_subclass(&ctlr->add_lock, 1);
+
 	priv->mux = devm_mux_control_get(&spi->dev, NULL);
 	if (IS_ERR(priv->mux)) {
 		ret = dev_err_probe(&spi->dev, PTR_ERR(priv->mux),
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 193e3264f7eb..72826bdab270 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2626,6 +2626,12 @@ struct spi_controller *__spi_alloc_controller(struct device *dev,
 		return NULL;
 
 	device_initialize(&ctlr->dev);
+	INIT_LIST_HEAD(&ctlr->queue);
+	spin_lock_init(&ctlr->queue_lock);
+	spin_lock_init(&ctlr->bus_lock_spinlock);
+	mutex_init(&ctlr->bus_lock_mutex);
+	mutex_init(&ctlr->io_mutex);
+	mutex_init(&ctlr->add_lock);
 	ctlr->bus_num = -1;
 	ctlr->num_chipselect = 1;
 	ctlr->slave = slave;
@@ -2898,12 +2904,6 @@ int spi_register_controller(struct spi_controller *ctlr)
 			return id;
 		ctlr->bus_num = id;
 	}
-	INIT_LIST_HEAD(&ctlr->queue);
-	spin_lock_init(&ctlr->queue_lock);
-	spin_lock_init(&ctlr->bus_lock_spinlock);
-	mutex_init(&ctlr->bus_lock_mutex);
-	mutex_init(&ctlr->io_mutex);
-	mutex_init(&ctlr->add_lock);
 	ctlr->bus_lock_flag = 0;
 	init_completion(&ctlr->xfer_completion);
 	if (!ctlr->max_dma_len)
-- 
2.30.2

