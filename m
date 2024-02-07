Return-Path: <linux-spi+bounces-1179-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22CBF84D172
	for <lists+linux-spi@lfdr.de>; Wed,  7 Feb 2024 19:44:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C14FF1F23BF4
	for <lists+linux-spi@lfdr.de>; Wed,  7 Feb 2024 18:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1324685947;
	Wed,  7 Feb 2024 18:43:21 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558BA85299
	for <linux-spi@vger.kernel.org>; Wed,  7 Feb 2024 18:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707331400; cv=none; b=ISKjY3XB5PRhyRapOG6RnPWScye1Rj7b2ELEmoc82ZDCZwqRy+CITfUm8AS8trKVGzS9Y2lED5n2d6I/V8mypaqUSpmXifvhAxv5eB6YZe4+VuPUp8kjmR9jDo0hpRNCqg0GW6ZKADlJ9lGtYa9W/di6HnIjh6vtwB3tLKVxXOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707331400; c=relaxed/simple;
	bh=f+Gz43aBncDHaeqjyCuKx4M3pTIgDVH1C6QnbLnn8E4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e6P2LqPft6QSgvHhc/n1qylZEdQZB0rAXaSOS5s/0EcnIJPCkcElZukpoKjNhLhdGu11sEp6ft628F1zbrEw4s7MnfIDUG4iYdYL1qb4BpKzYIW//Yp8tFZWgxdQGNnwG8TLY+sIYQNavaONoGUwbZcrZSGMQOhTx5mJ3twCAJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rXmtB-0007p0-Bq; Wed, 07 Feb 2024 19:43:17 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rXmtA-0054YG-UF; Wed, 07 Feb 2024 19:43:16 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rXmtA-00HRtN-2l;
	Wed, 07 Feb 2024 19:43:16 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: kernel@pengutronix.de,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 23/32] spi: spidev: Follow renaming of SPI "master" to "controller"
Date: Wed,  7 Feb 2024 19:40:37 +0100
Message-ID:  <15ebfdf58a6590962bdd51b49b2e85a69b3bf443.1707324794.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1707324793.git.u.kleine-koenig@pengutronix.de>
References: <cover.1707324793.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1094; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=f+Gz43aBncDHaeqjyCuKx4M3pTIgDVH1C6QnbLnn8E4=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlw86/oPdwhihCkIyCjc5ukJhojEhPOFeci3qVw swHLmcRSz+JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcPOvwAKCRCPgPtYfRL+ TjHYCACBp+IFKdXejHOMNxfTqboFn2a/edghYu3mR7tSY8ZSz6rJIcD4YKALjzDJrwTKOOdJR6q U5WcHS/pLQALvLaCEExTGm52vnMrwEPpKkTEQlCdSL8kEUmIqNC9yqHImiNWBx549O16KxRK3ut yH7n6tcyFHLLrOrgxUG4bosqjyUbq6jPOd74cIh6hOE0L790Vrw0otUncgOm+dmRmPq/3CEbQMP MsdST6AVuHMcHGlFqM2qLG8gEhvE82lioxIJN6gSYXiP5i9JrhImToU8g+jC++KCBQ7CycOTIgw t8v4SKj8c4LkCT1Yufk8Av1HcY4R+AXZnN74EQzN9+WhY0O5
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

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/spi/spidev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 655f2c959cd4..95fb5f1c91c1 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -802,7 +802,7 @@ static int spidev_probe(struct spi_device *spi)
 		spidev->devt = MKDEV(SPIDEV_MAJOR, minor);
 		dev = device_create(&spidev_class, &spi->dev, spidev->devt,
 				    spidev, "spidev%d.%d",
-				    spi->master->bus_num, spi_get_chipselect(spi, 0));
+				    spi->controller->bus_num, spi_get_chipselect(spi, 0));
 		status = PTR_ERR_OR_ZERO(dev);
 	} else {
 		dev_dbg(&spi->dev, "no minor number available!\n");
-- 
2.43.0


