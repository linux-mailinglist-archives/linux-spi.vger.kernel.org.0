Return-Path: <linux-spi+bounces-6885-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9350FA3FA4E
	for <lists+linux-spi@lfdr.de>; Fri, 21 Feb 2025 17:11:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC00670595B
	for <lists+linux-spi@lfdr.de>; Fri, 21 Feb 2025 16:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B22218AD2;
	Fri, 21 Feb 2025 15:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="LN4ajsLe"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0F921858C;
	Fri, 21 Feb 2025 15:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740153425; cv=none; b=tCtol3D7OGXHjVYtvuQWMfUzQZTttXU10ikWQ+AfCrS9g3OUsA1gla6ZSx35V3RYl8hrB6wewBLWjFVCysRinrcf3zVXsALAW8a1Qcz87n27Uqm7tOyDp/jJeP5Z0D1Q2OgEJMkD9ObGeYEhIoLAZaob5aTbQXqOmIW7ywtvUsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740153425; c=relaxed/simple;
	bh=492TM+ddBdtrEar4I4w7H8TW4P41zEk1hJNB3oHWQlM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HFP8yxnh2Crc3exOxMiz9sHqp99je/b9fgDxA4F6BEP5iQJCIYg+rx5TXb3fPaHcMoDZPOaxjkO2QrbxcVLdYGpk9G0hllbat0VQzNoM9XiyZGzb4ieGx2FkNUz/Qx44AwUW02ja0lkT6EhXUK5YZ4kHLRQ+dSGMm87/75yExnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=LN4ajsLe; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 96538103BB5D9;
	Fri, 21 Feb 2025 16:57:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1740153421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NTPkJC8S7Tc2Qw4+IVsZXDQLXEDTO6mvUFRRMEEVFYA=;
	b=LN4ajsLeHjC107GeauITx1TiuGChfkP2tN3BZ/ycBSTaOEtLajVpzMA9Vlleu3pUhBdb/u
	qApAlJKSvrEIJ9+s/jic0icoUjIjVMZePAe/2iN/1MIKZPdRn494k3LF0n9fuzQ5LpycdG
	Kgxxzb3TJzd41Rta0LZ3YlpTNMO44Mif1WGb4o6c//o56zRTkX8AUO2EeIboOTmIRj+fom
	NRPxSOG43+JEfosRAV4WQVydxzyY5hC2MV1sycxuRBrl59N9BuQfZ8TaifjM9DwCbKIUeV
	o2uzL6PBRKFJ7mmCOUNB1WxueGtYWBgNIbPtIgu9ZqTPiJiWdP8buPowbYg/dw==
From: Lukasz Majewski <lukma@denx.de>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukasz Majewski <lukma@denx.de>
Subject: [PATCH] spi: spidev: Add compatible for LWE's btt device
Date: Fri, 21 Feb 2025 16:56:44 +0100
Message-Id: <20250221155644.1168860-1-lukma@denx.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The Liebherr's BTT devices are using spidev to communicate via
SPI to monitoring devices. Extend compatibles to allow proper
DTS description.

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---
 drivers/spi/spidev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 58ae4304fdab..ceaccc5cf8f5 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -707,6 +707,7 @@ static const struct spi_device_id spidev_spi_ids[] = {
 	{ .name = /* dh */ "dhcom-board" },
 	{ .name = /* elgin */ "jg10309-01" },
 	{ .name = /* lineartechnology */ "ltc2488" },
+	{ .name = /* lwe */ "btt" },
 	{ .name = /* lwn */ "bk4" },
 	{ .name = /* lwn */ "bk4-spi" },
 	{ .name = /* menlo */ "m53cpld" },
@@ -738,6 +739,7 @@ static const struct of_device_id spidev_dt_ids[] = {
 	{ .compatible = "dh,dhcom-board", .data = &spidev_of_check },
 	{ .compatible = "elgin,jg10309-01", .data = &spidev_of_check },
 	{ .compatible = "lineartechnology,ltc2488", .data = &spidev_of_check },
+	{ .compatible = "lwe,btt", .data = &spidev_of_check },
 	{ .compatible = "lwn,bk4", .data = &spidev_of_check },
 	{ .compatible = "lwn,bk4-spi", .data = &spidev_of_check },
 	{ .compatible = "menlo,m53cpld", .data = &spidev_of_check },
-- 
2.39.5


