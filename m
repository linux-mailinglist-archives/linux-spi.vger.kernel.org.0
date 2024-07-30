Return-Path: <linux-spi+bounces-4095-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98BFB941344
	for <lists+linux-spi@lfdr.de>; Tue, 30 Jul 2024 15:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08FE9B20317
	for <lists+linux-spi@lfdr.de>; Tue, 30 Jul 2024 13:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B3CC1A08A4;
	Tue, 30 Jul 2024 13:35:59 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from michel.telenet-ops.be (michel.telenet-ops.be [195.130.137.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B0C1A01B8
	for <linux-spi@vger.kernel.org>; Tue, 30 Jul 2024 13:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722346559; cv=none; b=J3k8jDO/juUw7hkKead1HhUY4gY168QVaooppG+uQGcTYJ22v4fOOVDrUhhgzTd3jraKv6E8I5o2s6FIRsBkZJo3e6m/RlyT+Ih76555qGImn1acADY26pbQp9qAlQHMg3cOcdOBe6P0Z/akyo8Pzgx2+A30v5jOsKm0azGemkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722346559; c=relaxed/simple;
	bh=8ZKVgUkDg1H9qoLmR9WGjhmiqAIJWR6xufVkeSIkI6s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SNoeCLgHNKwFwviDVL9AJw2Z0A3A5YRXgoHOvCzWwGeVuASSq1mFyXHnzTQ1fHH6wGV8rLWbJD0umNkCztiwcrr7c9aNkCeVJw2tX6IS93WICrSDiFoO9FYN3yZWJWZAoIOScQLpCp1ZPdxvt1okquyOGF2XIYyubp781dY2M0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:520d:93ad:ff6d:335e])
	by michel.telenet-ops.be with bizsmtp
	id tpbo2C00330Ayot06pbooH; Tue, 30 Jul 2024 15:35:48 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sYn0f-004Akz-4Y;
	Tue, 30 Jul 2024 15:35:48 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sYn12-00DzGt-5X;
	Tue, 30 Jul 2024 15:35:48 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Mark Brown <broonie@kernel.org>,
	Maxime Ripard <mripard@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] spi: spidev: Add missing spi_device_id for bh2228fv
Date: Tue, 30 Jul 2024 15:35:47 +0200
Message-Id: <cb571d4128f41175f31319cd9febc829417ea167.1722346539.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the of_device_id entry for "rohm,bh2228fv" was added, the
corresponding spi_device_id was forgotten, causing a warning message
during boot-up:

    SPI driver spidev has no spi_device_id for rohm,bh2228fv

Fix module autoloading and shut up the warning by adding the missing
entry.

Fixes: fc28d1c1fe3b3e2f ("spi: spidev: add correct compatible for Rohm BH2228FV")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/spi/spidev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 05e6d007f9a7f617..5304728c68c20d3a 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -700,6 +700,7 @@ static const struct class spidev_class = {
 };
 
 static const struct spi_device_id spidev_spi_ids[] = {
+	{ .name = "bh2228fv" },
 	{ .name = "dh2228fv" },
 	{ .name = "ltc2488" },
 	{ .name = "sx1301" },
-- 
2.34.1


