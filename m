Return-Path: <linux-spi+bounces-3851-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07877930BA2
	for <lists+linux-spi@lfdr.de>; Sun, 14 Jul 2024 22:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 390C71C212C6
	for <lists+linux-spi@lfdr.de>; Sun, 14 Jul 2024 20:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E549513AD33;
	Sun, 14 Jul 2024 20:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=freemail.hu header.i=@freemail.hu header.b="Z98B2pjc"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp-out.freemail.hu (fmfe34.freemail.hu [46.107.16.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31AA7136E37;
	Sun, 14 Jul 2024 20:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.107.16.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720989128; cv=none; b=i8/TSMIS9f4bkj7+dgndzwUnf86K5Cp+Ln0EtoezrU3EM73IEvARhlqDzZCMGI6NcjdjfkI2LajdGRP2Xm0xbeGMTGAVcj4YEJvs08blPQbyf0OoTYYcT7MrlMXyl2I2UQUeEOgkOcXJWEp+D7SnwYWsbP0AIDbTNhH+TF2spD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720989128; c=relaxed/simple;
	bh=H9kSf8DV4jnoAj+ohO3964PFKoZzX0/9puU9iPCd4Yg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UXKVgeGI22JDnjXhlCsNwKGrfvbSw+CMFJmEkXalHFWOK3xMEtORKM0i1NxBdsaOgU1M1giBuXPlQJXiMvHUiSvtyydA1kkrmXgTFpe5micLNm32hX3BJ78fNwYslc2mz3uh1yY2pPjfJjqu4D9voYzEI/CdWoVCaPFyWw/SJzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freemail.hu; spf=pass smtp.mailfrom=freemail.hu; dkim=fail (2048-bit key) header.d=freemail.hu header.i=@freemail.hu header.b=Z98B2pjc reason="signature verification failed"; arc=none smtp.client-ip=46.107.16.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freemail.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freemail.hu
Received: from localhost.localdomain (catv-188-142-163-175.catv.fixed.vodafone.hu [188.142.163.175])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp.freemail.hu (Postfix) with ESMTPSA id 4WMcGW5qfxz18s;
	Sun, 14 Jul 2024 22:23:15 +0200 (CEST)
From: egyszeregy@freemail.hu
To: broonie@kernel.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Benjamin=20Sz=C5=91ke?= <egyszeregy@freemail.hu>
Subject: [PATCH] spi: spidev: add "generic-spidev" for compatible string
Date: Sun, 14 Jul 2024 22:23:03 +0200
Message-ID: <20240714202303.164-1-egyszeregy@freemail.hu>
X-Mailer: git-send-email 2.45.2.windows.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=simple/relaxed; t=1720988596;
	s=20181004; d=freemail.hu;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
	l=1164; bh=2ZkUjinkdLWy9g1nDAJXSJ1zD/vsY2RQAJc6denFkHQ=;
	b=Z98B2pjc90VXHdz1HwdqNP9OKMCVqvcPfZcW2AOmV1haiOgXh3qIJjg1ql9lOdm4
	tQrq33KR31KCHpLoXSt0QbfNgR9IN+nZbDKxlHPx6l3Lv0WDMbitJOlIgZvX24/8Z2X
	Sa1Qa7hNVic4fH8gJimnDTg5b/pEHpPPNpUNDaL0pVnmuPCJXIZrfAf5zbb7x9eAfya
	MlQluASFEtGCu+riOBkFH0cbqQwVnRKEmdBuhkE3d2WQgVo7WPLYfaZ8OKL6YeD3BWu
	cu0kuS3gbD7nwzAjhtDdELl79W0qSop1XNPaYpEpyht1Ma6NUXkPmkuxRiW0PYqrE5E
	7U3UeGKk2A==

From: Benjamin Szőke <egyszeregy@freemail.hu>

Spidev is a not an ASIC, IC or Sensor specific driver.
It is better to use a simple and generic compatible
string instead of many dummy vendor/product names
which are all just fake.

Signed-off-by: Benjamin Szőke <egyszeregy@freemail.hu>
---
 drivers/spi/spidev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 95fb5f1c91c1..bbcc5b4e9c91 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -700,6 +700,7 @@ static const struct class spidev_class = {
 };
 
 static const struct spi_device_id spidev_spi_ids[] = {
+	{ .name = "generic-spidev" },
 	{ .name = "dh2228fv" },
 	{ .name = "ltc2488" },
 	{ .name = "sx1301" },
@@ -728,6 +729,7 @@ static int spidev_of_check(struct device *dev)
 }
 
 static const struct of_device_id spidev_dt_ids[] = {
+	{ .compatible = "generic-spidev", .data = &spidev_of_check },
 	{ .compatible = "cisco,spi-petra", .data = &spidev_of_check },
 	{ .compatible = "dh,dhcom-board", .data = &spidev_of_check },
 	{ .compatible = "lineartechnology,ltc2488", .data = &spidev_of_check },
-- 
2.43.5


