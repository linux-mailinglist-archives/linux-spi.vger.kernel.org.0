Return-Path: <linux-spi+bounces-2947-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 599A08C95CB
	for <lists+linux-spi@lfdr.de>; Sun, 19 May 2024 20:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B4B61C20B0A
	for <lists+linux-spi@lfdr.de>; Sun, 19 May 2024 18:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56BAC612EB;
	Sun, 19 May 2024 18:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=freemail.hu header.i=@freemail.hu header.b="0hWgjmKN"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp-out.freemail.hu (fmfe12.freemail.hu [46.107.16.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4062E58AB4;
	Sun, 19 May 2024 18:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.107.16.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716142681; cv=none; b=Ibpn64aFfLOLoVkwDtirQxE5XisRBmxcJ5NR8iQGp0wnl/zxDPli+jysu623Uwi98mx81tNUKPBgdbi38YdIYFy5IhBCsdae12k8oxZXETKb+6U8fdn/Tc+yUbj267ApRsa4sl2TOY7e4f1hwS7+Ed34kUKqbesEGkJDmu8IQxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716142681; c=relaxed/simple;
	bh=EJ6Foab+qlu7VNhHLMIvKehDQVVIHCOMsiMv3cp3kn8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=k+DbvtVr1bfoizTd8fnDUbLunuLpDNxRmC05qyJwmv525FHCbafJGXYGh7lMkwa8n1nntswoMPdD7icLUuLHocoyR4LDIicwgOi0Yh6QMKsSKbfZtsOCsbuNS0y4PhXnKZg5LghBzIjEnyFUfouJv+lGDe1+DS/2WrSbHBfpehU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freemail.hu; spf=pass smtp.mailfrom=freemail.hu; dkim=fail (2048-bit key) header.d=freemail.hu header.i=@freemail.hu header.b=0hWgjmKN reason="signature verification failed"; arc=none smtp.client-ip=46.107.16.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freemail.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freemail.hu
Received: from fizweb.elte.hu (fizweb.elte.hu [157.181.183.248])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp.freemail.hu (Postfix) with ESMTPSA id 4Vj7zb1121z6b;
	Sun, 19 May 2024 20:10:51 +0200 (CEST)
From: egyszeregy@freemail.hu
To: broonie@kernel.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Benjamin=20Sz=C5=91ke?= <egyszeregy@freemail.hu>
Subject: [PATCH] spidev: Introduce "linux,spidev-name" property for device tree of spidev.
Date: Sun, 19 May 2024 20:10:39 +0200
Message-Id: <20240519181039.23147-1-egyszeregy@freemail.hu>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=simple/relaxed; t=1716142251;
	s=20181004; d=freemail.hu;
	h=From:To:Cc:Subject:Date:MIME-Version:Content-Type:Content-Transfer-Encoding;
	l=1791; bh=8JjPylgkjJhf1YbO+GZAuXsj5MnBCud61GtXY/XF3T4=;
	b=0hWgjmKN0EvdCrAMLe2Y9+HtVqwXunqLAWVS2M9JlCZiRskccxZU+gfiN6orFe6f
	o68HQoT6xFIq9oeHiF4hSfP5Ko8JSWqGubrBVafGe+yobj0OzGl4qb2maEJscZHR+5P
	ygpReibEUtHHfMvrDDI2jZEFOyOWA5k1A4A3qUX1m5G/CT3cHzK/TS/p7OSsk3k55hI
	6HGIPq/GUpUodcoOQyoGfi52vjqj3NK7XYcrawvX3b5mCw3Ve3I64MdZRhAcqoS7I5A
	F2YB/6U38Ubpm4iucIIVWHU13/IhnEAe/t4TEWKE1JNYAgyBbfIx20jzDDirCq5HXw6
	Imc0P0Q3DA==

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
index 95fb5f1c91c1..e0071522fc6d 100644
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
+			dev = device_create(spidev_class, &spi->dev, spidev->devt,
+					    spidev, "spidev%d.%d",
+					    spi->controller->bus_num, spi_get_chipselect(spi, 0));
+		else
+			dev = device_create(spidev_class, &spi->dev, spidev->devt,
+					    spidev, "spidev-%s", name);
+
 		status = PTR_ERR_OR_ZERO(dev);
 	} else {
 		dev_dbg(&spi->dev, "no minor number available!\n");
-- 
2.39.3


