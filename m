Return-Path: <linux-spi+bounces-9126-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31AB0B0AE2F
	for <lists+linux-spi@lfdr.de>; Sat, 19 Jul 2025 08:34:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0125C7A616F
	for <lists+linux-spi@lfdr.de>; Sat, 19 Jul 2025 06:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C99819E7D1;
	Sat, 19 Jul 2025 06:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="XEks53br"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4471EB39;
	Sat, 19 Jul 2025 06:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752906870; cv=none; b=HiwePTiRbHR/pfZpL0JaZaLcoPKq243TZvdNHCiRAuM6/5eC/MBVullEq/gtY89LnHZUG4Wqt4q5Xo8IRCq7jGqOPZcShb35c3abIat8kJKQo9AYxgJ0qwnjQsyADpgL1OIVbDPg2t1l4Zaw0aLRDBwCvvinRAN0ScjON13WJOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752906870; c=relaxed/simple;
	bh=n3KWkOCcHTVU6vNLmust/XfHc/BODC8tv2IfQRlQGps=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M0bDUxuMagp+liBRvIJ3P0E7z3kfY8ftQdFqqNgvcjLw0tAV0+OhhTJX2CIzAlZN/8iaBBrarF4SbbbY9Qi49dPF4crbtlhBStoI3W8YSj/sHglqFsaMWMlQGoUMVQKckdNrxi2S120rjT2mVuttWC+016SC8wO9fZWkYAlDz1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=XEks53br; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CD2D41026E99C;
	Sat, 19 Jul 2025 08:34:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1752906867; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=ZsJipXJnLim3ZnxtZh7I9eTppXnxH1fDA/ujGPQeeOQ=;
	b=XEks53brWlX7ocrj+LN1OD0CjB3tARg49Tu9nv0Py72fIXNIX1VV+nYUuS7+yl4XSijLii
	AToloETvfmULnZkORcGFxN5Uwjcn4X7lFO0PZihHB2WJvWbk8vHY8lqVizuwfBF41ePBiU
	cjqcqTD7nzMS7vC0Gr7YLzj4wC0SSGogh1IGmQGANZWYSsEWWfm6Id8RROvmvCDg5uHrF+
	jACXMWP9IY9JJNyeAL8/Rh464fJYfEMOh7NSapmWCsiN0I7VtsxfJKdsUxd6SFkD/hIpa9
	wRrC6nuSykFBO5lBP48oW1LAZtBTgYr/zNdOygRzM7gQO49NROppSfTJcLU9cw==
From: Heiko Schocher <hs@denx.de>
To: linux-spi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Heiko Schocher <hs@denx.de>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 2/3] spi: spidev: Add an entry for the ABB spi sensors
Date: Sat, 19 Jul 2025 08:33:53 +0200
Message-Id: <20250719063355.73111-3-hs@denx.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20250719063355.73111-1-hs@denx.de>
References: <20250719063355.73111-1-hs@denx.de>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

This sensors are currently controlled from userspace, ideally
we will add full drivers in the future.

Signed-off-by: Heiko Schocher <hs@denx.de>
---

 drivers/spi/spidev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 6108959c28d9..5300c942a2a4 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -703,6 +703,7 @@ static const struct class spidev_class = {
  * spidev_dt_ids array below. Both arrays are kept in the same ordering.
  */
 static const struct spi_device_id spidev_spi_ids[] = {
+	{ .name = /* abb */ "spi-sensor" },
 	{ .name = /* cisco */ "spi-petra" },
 	{ .name = /* dh */ "dhcom-board" },
 	{ .name = /* elgin */ "jg10309-01" },
@@ -735,6 +736,7 @@ static int spidev_of_check(struct device *dev)
 }
 
 static const struct of_device_id spidev_dt_ids[] = {
+	{ .compatible = "abb,spi-sensor", .data = &spidev_of_check },
 	{ .compatible = "cisco,spi-petra", .data = &spidev_of_check },
 	{ .compatible = "dh,dhcom-board", .data = &spidev_of_check },
 	{ .compatible = "elgin,jg10309-01", .data = &spidev_of_check },
-- 
2.20.1


