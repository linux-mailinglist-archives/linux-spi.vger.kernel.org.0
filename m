Return-Path: <linux-spi+bounces-2442-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8EA88ACC62
	for <lists+linux-spi@lfdr.de>; Mon, 22 Apr 2024 13:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94A7A282BAD
	for <lists+linux-spi@lfdr.de>; Mon, 22 Apr 2024 11:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C390146A76;
	Mon, 22 Apr 2024 11:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bittium.com header.i=@bittium.com header.b="hjHiUyeT"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtpgw1fi.bittium.com (smtpgw1fi.bittium.com [185.171.177.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECC01448E5
	for <linux-spi@vger.kernel.org>; Mon, 22 Apr 2024 11:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.177.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713787060; cv=none; b=ceDF11AJKU3uW0/Ub2NhZAwRJ+GOuy9/g+DXe/08stU8+MHc1rP+83Ztr8WHXZXQ93sf7l1y1bzS+Hk2L8I2mj7FVoXlPD0CeEg9JmmEVnvXrwHfTw+Pam8aiZ5YsFXtgPFf3TpX3YCYzqP1BP+aUQKxsxeLVowiGmIA7t0/L8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713787060; c=relaxed/simple;
	bh=RYPm3oaf0yoiRieMZJe60BZ+cAx7fpa3bVesf5jlga0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UNKKcg9OCX2rrU25TkgEYsbhmclBqf+7OklNWg6OT5x3JrYCabc2N+29SpIanvUjBzTd2zdD5Bz2xX+KJCFmIeT1MKj2uVnyert0HUKXfC7pwrsQfl8MmOllDxvwj6nkHPXqznqSPezlMJ+jr+MuiHPzrczuW5qnE9o9Prki4IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bittium.com; spf=pass smtp.mailfrom=bittium.com; dkim=pass (2048-bit key) header.d=bittium.com header.i=@bittium.com header.b=hjHiUyeT; arc=none smtp.client-ip=185.171.177.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bittium.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bittium.com
Received: from email.bittium.com ([10.237.64.162])
	by smtpgw1fi.bittium.com  with ESMTP id 43MBgIrp013643-43MBgIrq013643;
	Mon, 22 Apr 2024 14:42:18 +0300
Received: from fil664211.bit.bittium.com (fil664211.bit.bittium.com [10.237.12.249])
	by email.bittium.com (Postfix) with ESMTP id 662DE80017;
	Mon, 22 Apr 2024 14:42:18 +0300 (EEST)
From: Heikki Keranen <heikki.keranen@bittium.com>
To: broonie@kernel.org
Cc: linux-spi@vger.kernel.org,
	Heikki Keranen <heikki.keranen@bittium.com>,
	Petri Tauriainen <petri.tauriainen@bittium.com>
Subject: [PATCH] spi: mux: Fix master controller settings after mux select
Date: Mon, 22 Apr 2024 14:41:50 +0300
Message-Id: <20240422114150.84426-1-heikki.keranen@bittium.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.237.64.162
X-FEAS-Client-IP: 10.237.64.162
X-FE-Policy-ID: 18:4:2:SYSTEM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=bittium.com; s=smtpgw; c=relaxed/relaxed;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=wwoUsBRYos2nB/5PE2MPMYRUQ+WrzM9pw0TWyOxOMTM=;
 b=hjHiUyeTqOJWem33fFg8N4zhp1fz2n1zXD3h1FK25qRos1UXJ8AErxI2/30P5ZOf2fOmvg9O1Ox0
	kCjtsl563ubP+tIWYnmuG3xXMnFosTz9rL7Led1aTHzUueFTgnw/CnJEYzyuOXQmt42KXjZICwVA
	wRq4oUGgwgx3XNLsv3jmmRLIpjILN0ktd6ZM22cJeRAFQSzB3VcDZNgffVHkMRq+jd6k0gJ/XG0C
	BhMB3kgLJ4MuJX8LTcKYy3XfEDfkoi65ltb6V5wJMWfa7HQ2woOaAoB6sQ3nNkeXqrr1AAoHyI7e
	K0GYeZJxSTQvI6xfonOLtkCY1sKe3x2HUo5GGg==

In some cases SPI child devices behind spi-mux require different
settings like: max_speed_hz, mode and bits_per_word.

Typically the slave device driver puts the settings in place and calls
spi_setup() once during probe and assumes they stay in place for all
following spi transfers.

However spi-mux forwarded spi_setup() -call to SPI master driver only
when slave driver calls spi_setup(). If second slave device was
accessed meanwhile and that driver called spi_setup(), the
settings did not change back to the first spi device.
In case of wrong max_speed_hz this caused spi trasfers to fail.

This commit adds spi_setup() call after mux is changed. This way
the right device specific parameters are set to the master driver.

The fix has been tested by using custom hardware and debugging
spi master driver speed settings.

Co-authored-by: Petri Tauriainen <petri.tauriainen@bittium.com>
Signed-off-by: Heikki Keranen <heikki.keranen@bittium.com>
---
 drivers/spi/spi-mux.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi-mux.c b/drivers/spi/spi-mux.c
index bd988f53753e..5d72e3d59df8 100644
--- a/drivers/spi/spi-mux.c
+++ b/drivers/spi/spi-mux.c
@@ -68,6 +68,8 @@ static int spi_mux_select(struct spi_device *spi)
 
 	priv->current_cs = spi_get_chipselect(spi, 0);
 
+	spi_setup(priv->spi);
+
 	return 0;
 }
 
-- 
2.39.2


