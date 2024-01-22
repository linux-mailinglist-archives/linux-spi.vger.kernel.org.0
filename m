Return-Path: <linux-spi+bounces-572-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5650837039
	for <lists+linux-spi@lfdr.de>; Mon, 22 Jan 2024 19:40:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C10D1295239
	for <lists+linux-spi@lfdr.de>; Mon, 22 Jan 2024 18:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9E65605BA;
	Mon, 22 Jan 2024 18:08:26 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08EDB60256
	for <linux-spi@vger.kernel.org>; Mon, 22 Jan 2024 18:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705946906; cv=none; b=uujFF37D/Jjc/oIImZZ3MoRaM2XdOGbq8YIKyBMs1JD/TFm9CKO0Ha4wKU+bv8lyKnadW8mxjTBDBtzxlq63HlYYo4gH4h4/OtTdG9Wancyz4MIjIqnNRNUTtyIYZGVjyLp7/QVXmts4mI25HbpvvNKx4Eb2FefnZZsQ71/Va88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705946906; c=relaxed/simple;
	bh=+Bwcd8J9EIWwY/Wo93zN3hICZCIsRFvVUKS8EPmC1YE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RMr4jaQqyyqMGoMMzAVLAQc05KRz1nH0xOZFGKwIafykhn1Pu7XJjFoEwKLTvLEY817lzbVJLys2T3M6R34SB9jyoGRZC42sWGTzCm+GLoUzOvtmGDWZSnFiqdBu27BpBGsrSMMi8HuIlIS6wSyZzPRRWGTKem14tRviNgRcMcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rRyiV-0001pz-Tx; Mon, 22 Jan 2024 19:08:15 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rRyiU-001ePl-RG; Mon, 22 Jan 2024 19:08:14 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rRyiU-005ZxN-2S;
	Mon, 22 Jan 2024 19:08:14 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: kernel@pengutronix.de,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org
Subject: [PATCH v2 10/33] misc: gehc-achc: Follow renaming of SPI "master" to "controller"
Date: Mon, 22 Jan 2024 19:07:05 +0100
Message-ID:  <9a5c94968010aaf0c1d013f357fcbef428bb11ce.1705944943.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1705944943.git.u.kleine-koenig@pengutronix.de>
References: <cover.1705944943.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1529; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=+Bwcd8J9EIWwY/Wo93zN3hICZCIsRFvVUKS8EPmC1YE=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlrq7OFjYWLilaC8RRReNmWpwqu3I1mtgtuidRr cJ7eNh8PJKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZa6uzgAKCRCPgPtYfRL+ TrTrCACNA0WNx2N0bxGJChpw50BJC7IYMHiiYe8/a1oVkzr7cyT4ud5YLPZyoHoGSaZjBwauYse E04yMykcruJla39DUzsSLx5u5uQAScotkGjWhQbH94TvN54yIO9DFZe5f821hJMXeOM8aEgB2Vs /ZNjP71Muuf5vBMHRcZn/FpMz0cDDQ/CSuifar76fivK95mgf3IgJVgl+PzkIzdAdRrnvUnSmta VPYWNXsVB/O86UCR2tYg4TF8cvNW7qaK06qwDY1e0cSxoGMtu6xQobnsj/fBiYKKvtuzHwCKKoc e9ZE4DUcePQWGQocMJt1ve4pJm44MFeitzE0UqTQbsR9ebWE
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
 drivers/misc/gehc-achc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/gehc-achc.c b/drivers/misc/gehc-achc.c
index 4c9c5394da6f..b8fca4d393c6 100644
--- a/drivers/misc/gehc-achc.c
+++ b/drivers/misc/gehc-achc.c
@@ -65,7 +65,7 @@ static int ezport_start_programming(struct spi_device *spi, struct gpio_desc *re
 	struct spi_transfer release_cs = { };
 	int ret;
 
-	spi_bus_lock(spi->master);
+	spi_bus_lock(spi->controller);
 
 	/* assert chip select */
 	spi_message_init(&msg);
@@ -85,16 +85,16 @@ static int ezport_start_programming(struct spi_device *spi, struct gpio_desc *re
 	ret = spi_sync_locked(spi, &msg);
 
 fail:
-	spi_bus_unlock(spi->master);
+	spi_bus_unlock(spi->controller);
 	return ret;
 }
 
 static void ezport_stop_programming(struct spi_device *spi, struct gpio_desc *reset)
 {
 	/* reset without asserted chip select to return into normal mode */
-	spi_bus_lock(spi->master);
+	spi_bus_lock(spi->controller);
 	ezport_reset(reset);
-	spi_bus_unlock(spi->master);
+	spi_bus_unlock(spi->controller);
 }
 
 static int ezport_get_status_register(struct spi_device *spi)
-- 
2.43.0


