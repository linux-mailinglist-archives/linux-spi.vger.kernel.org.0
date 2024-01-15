Return-Path: <linux-spi+bounces-474-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0FA82E1B2
	for <lists+linux-spi@lfdr.de>; Mon, 15 Jan 2024 21:22:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 366A01C22204
	for <lists+linux-spi@lfdr.de>; Mon, 15 Jan 2024 20:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C189119BAB;
	Mon, 15 Jan 2024 20:21:25 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7D61A5B5
	for <linux-spi@vger.kernel.org>; Mon, 15 Jan 2024 20:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rPTSH-0004gC-3u; Mon, 15 Jan 2024 21:21:09 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rPTSD-0005gB-Pw; Mon, 15 Jan 2024 21:21:05 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rPTSD-000N7N-2H;
	Mon, 15 Jan 2024 21:21:05 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Mark Brown <broonie@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-spi@vger.kernel.org,
	kernel@pengutronix.de,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rayyan Ansari <rayyan@ansari.sh>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-input@vger.kernel.org
Subject: [PATCH 05/33] Input: synaptics-rmi4 - follow renaming of SPI "master" to "controller"
Date: Mon, 15 Jan 2024 21:12:51 +0100
Message-ID:  <5257de51fe406cf8405310dd638f648a232f4a6c.1705348269.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=999; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=xNp8+Dfm+EIe+qXYL7ffoOmuQD29EViiqqJIkWTp+/8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlpZHGUROwY7gSiKhm7vFe2LyN7SMEhrw3gqNEL piBfFQsIniJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZaWRxgAKCRCPgPtYfRL+ TshGB/9ZWGcAkrqhB576nUPfyFxO90rCudqYonICFb2n0+G/zFvYxfnkeW4KrrsxqCDQDoIZREc eyVeqJTgJbTmC3B4sopiiiFBW8jlcMSAqwoegk9rGvgPBMmDYtaJKCoqwzqZzr/4tWCFMDZN3XU v2v7Mub7Vox5ZHFRHae0o9CIkLTG0J1eC+ZyEXeOjqb5oQiC9bVqUKC4dFf1tbqOihLePWqpPnt a0jnH51QZfKqApTwjr7n1+pezYMyVHxYnjT8Gyu9c0h+DXx0d2gmaZhYlWa6LjbDThGnf0cPAGL BxAtCTa/HjFDzJwv51K2T9sUjV0+IADBXe7SzLWokKrkL3e5
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
 drivers/input/rmi4/rmi_spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/rmi4/rmi_spi.c b/drivers/input/rmi4/rmi_spi.c
index 07c866f42296..9d92129aa432 100644
--- a/drivers/input/rmi4/rmi_spi.c
+++ b/drivers/input/rmi4/rmi_spi.c
@@ -375,7 +375,7 @@ static int rmi_spi_probe(struct spi_device *spi)
 	struct rmi_device_platform_data *spi_pdata = spi->dev.platform_data;
 	int error;
 
-	if (spi->master->flags & SPI_CONTROLLER_HALF_DUPLEX)
+	if (spi->controller->flags & SPI_CONTROLLER_HALF_DUPLEX)
 		return -EINVAL;
 
 	rmi_spi = devm_kzalloc(&spi->dev, sizeof(struct rmi_spi_xport),
-- 
2.43.0


