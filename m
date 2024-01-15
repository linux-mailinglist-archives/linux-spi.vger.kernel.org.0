Return-Path: <linux-spi+bounces-452-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E0882E185
	for <lists+linux-spi@lfdr.de>; Mon, 15 Jan 2024 21:21:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8ED66283949
	for <lists+linux-spi@lfdr.de>; Mon, 15 Jan 2024 20:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3943199A9;
	Mon, 15 Jan 2024 20:21:13 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB36199A7
	for <linux-spi@vger.kernel.org>; Mon, 15 Jan 2024 20:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rPTSI-0004wq-LT; Mon, 15 Jan 2024 21:21:10 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rPTSI-0005hZ-8L; Mon, 15 Jan 2024 21:21:10 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rPTSI-000N8t-0Z;
	Mon, 15 Jan 2024 21:21:10 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Mark Brown <broonie@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-spi@vger.kernel.org,
	kernel@pengutronix.de,
	Rui Miguel Silva <rmfrfs@gmail.com>,
	Viresh Kumar <vireshk@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	Alex Elder <elder@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	greybus-dev@lists.linaro.org,
	linux-staging@lists.linux.dev
Subject: [PATCH 26/33] staging: greybus: spi: Follow renaming of SPI "master" to "controller"
Date: Mon, 15 Jan 2024 21:13:12 +0100
Message-ID:  <188f907d08d4a57d1058f01bc4939f209a4c8e43.1705348270.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1705348269.git.u.kleine-koenig@pengutronix.de>
References: <cover.1705348269.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=6252; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=+bgf1pgHJVDIktxZ8peLmYEBtS27RvvwZP/EDTR1/wE=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlpZHepgF4UUU2iRxU8Sc/+uQb5wuW3uLYtXtCC yajJew1bHqJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZaWR3gAKCRCPgPtYfRL+ ToiXB/4vNgRTgJz1SRfvqrxItK8uJjsHlxp5VD/cNlKt9Xa9SC4y4s1LNmKTnLnPYXpW1fLUJoY hh3aHyUFdIy9nJrZA9bXdaPipp/4GJkDMjFbNiaqCxmy29WmTQnO1QJaZ4ms5tUjvN0cwJ0FbHE +WZMpeZ9F8qxS/eVg+v9/pVs1fRMH1YSQBFawhFPQk5z5lUXX7bUGP1FhYMAPqc5G7iMY7WeFsG Erl4qvzYAM4nAiomSVfSL6drJzvWgPDRXBmTb4CwZJ18O7uCX21huPqq6qOunmSh6Bg6X0wReNE ae5Fo4V1Wdl1oEs7iUmva9EIc3Zn+AjLSPennkT3yi0/pB0/
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org

In commit 8caab75fd2c2 ("spi: Generalize SPI "master" to "controller"")
some functions and struct members were renamed. To not break all drivers
compatibility macros were provided.

To be able to remove these compatibility macros push the renaming into
this driver.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/staging/greybus/spilib.c | 66 ++++++++++++++++----------------
 1 file changed, 33 insertions(+), 33 deletions(-)

diff --git a/drivers/staging/greybus/spilib.c b/drivers/staging/greybus/spilib.c
index efb3bec58e15..34f10685139f 100644
--- a/drivers/staging/greybus/spilib.c
+++ b/drivers/staging/greybus/spilib.c
@@ -42,7 +42,7 @@ struct gb_spilib {
 
 #define XFER_TIMEOUT_TOLERANCE		200
 
-static struct spi_master *get_master_from_spi(struct gb_spilib *spi)
+static struct spi_controller *get_controller_from_spi(struct gb_spilib *spi)
 {
 	return gb_connection_get_data(spi->connection);
 }
@@ -324,10 +324,10 @@ static void gb_spi_decode_response(struct gb_spilib *spi,
 	}
 }
 
-static int gb_spi_transfer_one_message(struct spi_master *master,
+static int gb_spi_transfer_one_message(struct spi_controller *ctlr,
 				       struct spi_message *msg)
 {
-	struct gb_spilib *spi = spi_master_get_devdata(master);
+	struct gb_spilib *spi = spi_controller_get_devdata(ctlr);
 	struct gb_connection *connection = spi->connection;
 	struct gb_spi_transfer_response *response;
 	struct gb_operation *operation;
@@ -371,21 +371,21 @@ static int gb_spi_transfer_one_message(struct spi_master *master,
 out:
 	msg->status = ret;
 	clean_xfer_state(spi);
-	spi_finalize_current_message(master);
+	spi_finalize_current_message(ctlr);
 
 	return ret;
 }
 
-static int gb_spi_prepare_transfer_hardware(struct spi_master *master)
+static int gb_spi_prepare_transfer_hardware(struct spi_controller *ctlr)
 {
-	struct gb_spilib *spi = spi_master_get_devdata(master);
+	struct gb_spilib *spi = spi_controller_get_devdata(ctlr);
 
 	return spi->ops->prepare_transfer_hardware(spi->parent);
 }
 
-static int gb_spi_unprepare_transfer_hardware(struct spi_master *master)
+static int gb_spi_unprepare_transfer_hardware(struct spi_controller *ctlr)
 {
-	struct gb_spilib *spi = spi_master_get_devdata(master);
+	struct gb_spilib *spi = spi_controller_get_devdata(ctlr);
 
 	spi->ops->unprepare_transfer_hardware(spi->parent);
 
@@ -440,7 +440,7 @@ static int gb_spi_get_master_config(struct gb_spilib *spi)
 
 static int gb_spi_setup_device(struct gb_spilib *spi, u8 cs)
 {
-	struct spi_master *master = get_master_from_spi(spi);
+	struct spi_controller *ctlr = get_controller_from_spi(spi);
 	struct gb_spi_device_config_request request;
 	struct gb_spi_device_config_response response;
 	struct spi_board_info spi_board = { {0} };
@@ -471,11 +471,11 @@ static int gb_spi_setup_device(struct gb_spilib *spi, u8 cs)
 		return -EINVAL;
 
 	spi_board.mode		= le16_to_cpu(response.mode);
-	spi_board.bus_num	= master->bus_num;
+	spi_board.bus_num	= ctlr->bus_num;
 	spi_board.chip_select	= cs;
 	spi_board.max_speed_hz	= le32_to_cpu(response.max_speed_hz);
 
-	spidev = spi_new_device(master, &spi_board);
+	spidev = spi_new_device(ctlr, &spi_board);
 	if (!spidev)
 		return -EINVAL;
 
@@ -486,52 +486,52 @@ int gb_spilib_master_init(struct gb_connection *connection, struct device *dev,
 			  struct spilib_ops *ops)
 {
 	struct gb_spilib *spi;
-	struct spi_master *master;
+	struct spi_controller *ctlr;
 	int ret;
 	u8 i;
 
 	/* Allocate master with space for data */
-	master = spi_alloc_master(dev, sizeof(*spi));
-	if (!master) {
+	ctlr = spi_alloc_master(dev, sizeof(*spi));
+	if (!ctlr) {
 		dev_err(dev, "cannot alloc SPI master\n");
 		return -ENOMEM;
 	}
 
-	spi = spi_master_get_devdata(master);
+	spi = spi_controller_get_devdata(ctlr);
 	spi->connection = connection;
-	gb_connection_set_data(connection, master);
+	gb_connection_set_data(connection, ctlr);
 	spi->parent = dev;
 	spi->ops = ops;
 
-	/* get master configuration */
+	/* get controller configuration */
 	ret = gb_spi_get_master_config(spi);
 	if (ret)
 		goto exit_spi_put;
 
-	master->bus_num = -1; /* Allow spi-core to allocate it dynamically */
-	master->num_chipselect = spi->num_chipselect;
-	master->mode_bits = spi->mode;
-	master->flags = spi->flags;
-	master->bits_per_word_mask = spi->bits_per_word_mask;
+	ctlr->bus_num = -1; /* Allow spi-core to allocate it dynamically */
+	ctlr->num_chipselect = spi->num_chipselect;
+	ctlr->mode_bits = spi->mode;
+	ctlr->flags = spi->flags;
+	ctlr->bits_per_word_mask = spi->bits_per_word_mask;
 
 	/* Attach methods */
-	master->cleanup = gb_spi_cleanup;
-	master->setup = gb_spi_setup;
-	master->transfer_one_message = gb_spi_transfer_one_message;
+	ctlr->cleanup = gb_spi_cleanup;
+	ctlr->setup = gb_spi_setup;
+	ctlr->transfer_one_message = gb_spi_transfer_one_message;
 
 	if (ops && ops->prepare_transfer_hardware) {
-		master->prepare_transfer_hardware =
+		ctlr->prepare_transfer_hardware =
 			gb_spi_prepare_transfer_hardware;
 	}
 
 	if (ops && ops->unprepare_transfer_hardware) {
-		master->unprepare_transfer_hardware =
+		ctlr->unprepare_transfer_hardware =
 			gb_spi_unprepare_transfer_hardware;
 	}
 
-	master->auto_runtime_pm = true;
+	ctlr->auto_runtime_pm = true;
 
-	ret = spi_register_master(master);
+	ret = spi_register_controller(ctlr);
 	if (ret < 0)
 		goto exit_spi_put;
 
@@ -548,12 +548,12 @@ int gb_spilib_master_init(struct gb_connection *connection, struct device *dev,
 	return 0;
 
 exit_spi_put:
-	spi_master_put(master);
+	spi_controller_put(ctlr);
 
 	return ret;
 
 exit_spi_unregister:
-	spi_unregister_master(master);
+	spi_unregister_controller(ctlr);
 
 	return ret;
 }
@@ -561,9 +561,9 @@ EXPORT_SYMBOL_GPL(gb_spilib_master_init);
 
 void gb_spilib_master_exit(struct gb_connection *connection)
 {
-	struct spi_master *master = gb_connection_get_data(connection);
+	struct spi_controller *ctlr = gb_connection_get_data(connection);
 
-	spi_unregister_master(master);
+	spi_unregister_controller(ctlr);
 }
 EXPORT_SYMBOL_GPL(gb_spilib_master_exit);
 
-- 
2.43.0


