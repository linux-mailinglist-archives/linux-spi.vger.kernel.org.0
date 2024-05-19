Return-Path: <linux-spi+bounces-2950-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD698C96C1
	for <lists+linux-spi@lfdr.de>; Sun, 19 May 2024 23:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A2E01C20A7B
	for <lists+linux-spi@lfdr.de>; Sun, 19 May 2024 21:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B40256E602;
	Sun, 19 May 2024 21:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=freemail.hu header.i=@freemail.hu header.b="LYF8rZbc"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp-out.freemail.hu (fmfe34.freemail.hu [46.107.16.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2E318EB1;
	Sun, 19 May 2024 21:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.107.16.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716153793; cv=none; b=FE6fT/SB/m02WBL32UaYqd101UE6aaEZDa+ivZzxgMR1wZQxU6O5vxjhJTve9MZk0tTZcvlsyeJj0QlCE12Un9A+a15JuVHEgqTZ2DUqPH04MX2HQ/AAXRsIOrAlg9A7ShQZKbdTQW7wMLM0/6vlKUXw3O6bPKIGTLQaCoD1tDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716153793; c=relaxed/simple;
	bh=O1suXOBMrHWELWTrCR01dq1SXrfYu8q3ptBqYca80kw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=a6LYfP/0iN4KXLfXyQjA8aFQtgaKq1mCE6Tlkoq4N8PBeJ728epFMD+6LPyanSz9AqtJ3r0lSxcnY1wpK5dEO+ysL610e1KEkS6lkPdQjfDt2pvfAEEYrrLGg4Ef7+rN42XMBp1JubT/ym6pCVL2LOxCC18/P1srT2SfnCJElLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freemail.hu; spf=pass smtp.mailfrom=freemail.hu; dkim=fail (2048-bit key) header.d=freemail.hu header.i=@freemail.hu header.b=LYF8rZbc reason="signature verification failed"; arc=none smtp.client-ip=46.107.16.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freemail.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freemail.hu
Received: from fizweb.elte.hu (fizweb.elte.hu [157.181.183.248])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp.freemail.hu (Postfix) with ESMTPSA id 4VjD2n2fkVz59h;
	Sun, 19 May 2024 23:13:53 +0200 (CEST)
From: egyszeregy@freemail.hu
To: broonie@kernel.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Benjamin=20Sz=C5=91ke?= <egyszeregy@freemail.hu>
Subject: [PATCH v2] spidev: Introduce "linux,spidev-name" property for device tree of spidev.
Date: Sun, 19 May 2024 23:13:46 +0200
Message-Id: <20240519211346.30323-1-egyszeregy@freemail.hu>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=simple/relaxed; t=1716153233;
	s=20181004; d=freemail.hu;
	h=From:To:Cc:Subject:Date:MIME-Version:Content-Type:Content-Transfer-Encoding;
	l=1793; bh=pM8mY8PODejfuv3dytVo9l+AJzQhcJoSsmMu1QYesOY=;
	b=LYF8rZbcIIHoe4gvJYfvs5Jrsvq+EFtSMO8gvyP3j9v18W6XNFKI9uu1nhJngpEK
	5vk1x72aqt/4eRmHil/FIO3vZQDjJyYlSEh14BMTkUZ/PAMl0LL8KUaiPHGgAOon11D
	UNJlTx/gv31XCWODiqJPwuOW4ljbrjmyamB8ILEbmqeZoG+3Xs3BfrTouvrfEl6sSva
	pkmYJQwMaaPcQ/OBnzZwCG765c9wuJLD28lpO1f7ciGSDymSPnvUNjb8TrOyDzhkysn
	gZ/tJ0/kGhLAw5Z7/8cF/nIrcFgeN+r7AK9dFtBUw9qyc9A65BKHvzkob5wSakrMLQT
	U1UiYOb6LQ==

From: Benjamin Szőke <egyszeregy@freemail.hu>

Optionally, spidev may have a "linux,spidev-name" property.
This is a string which is defining a custom suffix name for spi device in
/dev/spidev-<name> format. It helps to improve software portability between
various SoCs and reduce complexities of hardware related codes in SWs.

Signed-off-by: Benjamin Szőke <egyszeregy@freemail.hu>
---
 drivers/spi/spidev.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 95fb5f1c91c1..389baaf38e99 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -767,6 +767,8 @@ MODULE_DEVICE_TABLE(acpi, spidev_acpi_ids);
 
 static int spidev_probe(struct spi_device *spi)
 {
+	int ret;
+	const char *name;
 	int (*match)(struct device *dev);
 	struct spidev_data	*spidev;
 	int			status;
@@ -800,9 +802,20 @@ static int spidev_probe(struct spi_device *spi)
 		struct device *dev;
 
 		spidev->devt = MKDEV(SPIDEV_MAJOR, minor);
-		dev = device_create(&spidev_class, &spi->dev, spidev->devt,
-				    spidev, "spidev%d.%d",
-				    spi->controller->bus_num, spi_get_chipselect(spi, 0));
+
+		/*
+		 * If "linux,spidev-name" is specified in device tree, use /dev/spidev-<name>
+		 * in Linux userspace, otherwise use /dev/spidev<bus_num>.<cs_num>.
+		 */
+		ret = device_property_read_string(&spi->dev, "linux,spidev-name", &name);
+		if (ret < 0)
+			dev = device_create(&spidev_class, &spi->dev, spidev->devt,
+					    spidev, "spidev%d.%d",
+					    spi->controller->bus_num, spi_get_chipselect(spi, 0));
+		else
+			dev = device_create(&spidev_class, &spi->dev, spidev->devt,
+					    spidev, "spidev-%s", name);
+
 		status = PTR_ERR_OR_ZERO(dev);
 	} else {
 		dev_dbg(&spi->dev, "no minor number available!\n");
-- 
2.39.3


