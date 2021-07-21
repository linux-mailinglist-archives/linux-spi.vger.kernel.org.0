Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F254A3D0CBB
	for <lists+linux-spi@lfdr.de>; Wed, 21 Jul 2021 13:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235092AbhGUJnO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 21 Jul 2021 05:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238334AbhGUJMu (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 21 Jul 2021 05:12:50 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C897CC061574
        for <linux-spi@vger.kernel.org>; Wed, 21 Jul 2021 02:53:26 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m68uq-0000f0-6Y; Wed, 21 Jul 2021 11:53:24 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m68uo-00086w-DZ; Wed, 21 Jul 2021 11:53:22 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m68uo-0008L1-CK; Wed, 21 Jul 2021 11:53:22 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Peter Rosin <peda@axentia.se>, Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH] spi: spi-mux: Add module info needed for autoloading
Date:   Wed, 21 Jul 2021 11:53:21 +0200
Message-Id: <20210721095321.2165453-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

With the spi device table udev can autoload the spi-mux module in
the presence of an spi-mux device.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/spi/spi-mux.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/spi/spi-mux.c b/drivers/spi/spi-mux.c
index 37dfc6e82804..9708b7827ff7 100644
--- a/drivers/spi/spi-mux.c
+++ b/drivers/spi/spi-mux.c
@@ -167,10 +167,17 @@ static int spi_mux_probe(struct spi_device *spi)
 	return ret;
 }
 
+static const struct spi_device_id spi_mux_id[] = {
+	{ "spi-mux" },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, spi_mux_id);
+
 static const struct of_device_id spi_mux_of_match[] = {
 	{ .compatible = "spi-mux" },
 	{ }
 };
+MODULE_DEVICE_TABLE(of, spi_mux_of_match);
 
 static struct spi_driver spi_mux_driver = {
 	.probe  = spi_mux_probe,
@@ -178,6 +185,7 @@ static struct spi_driver spi_mux_driver = {
 		.name   = "spi-mux",
 		.of_match_table = spi_mux_of_match,
 	},
+	.id_table = spi_mux_id,
 };
 
 module_spi_driver(spi_mux_driver);
-- 
2.30.2

