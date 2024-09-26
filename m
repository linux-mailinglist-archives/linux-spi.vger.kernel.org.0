Return-Path: <linux-spi+bounces-4993-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 176E4986F82
	for <lists+linux-spi@lfdr.de>; Thu, 26 Sep 2024 11:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E8221C220F4
	for <lists+linux-spi@lfdr.de>; Thu, 26 Sep 2024 09:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 306E9188CB8;
	Thu, 26 Sep 2024 09:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b="SANw2WbD"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED05B208CA;
	Thu, 26 Sep 2024 09:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.92.40.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727341447; cv=none; b=TLhWOWiV68SmU+tDergTkbBg5lkaOa+bCBDuQS6xgKiO5LBQAGTXg14U9nULsO+3HDf5pY+2Dwh2geSLRiNoMIuZiemJhTMf499cQpykTbg+Kv8234ZFAeFc4sNN06b1MmxDi02y9GWEhYjOGiGirKXb6BIzE5zvpUGkRHtDTSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727341447; c=relaxed/simple;
	bh=RaqbYMabqh/rtpF8KrqwCZ0nEPmA46blm8d7wiKFA8k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qgMc/vyKmSvZSNZcTrlF6CiLbJViAqQGPS18TRkK9hJjN2I9xsRSGX2XyboeVa/dYUyWn4oE4a1DaGwNnJoXn3g0W+7m9qozKecQ4h/IaTonv+sQVB9ynxbsjZQd96AHFYrJIOsZVmowPNbX/Z0fSQsdhJHZxziOiQ7xaA0iZgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com; spf=pass smtp.mailfrom=thorsis.com; dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b=SANw2WbD; arc=none smtp.client-ip=217.92.40.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 20BE91486845;
	Thu, 26 Sep 2024 11:04:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
	t=1727341442; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=YerQMbh2SXmIPNoVbAJiCzp0lKj3lArlIsJMwwpDYQk=;
	b=SANw2WbDEm9YDkv+7rROoSh+Wg5RCiKUYSU2FODxpwqDzTZFJqJAcSDo9uAAfW2q8xn5Fc
	cf0r8NQ2eAp0MMwOcDBKnA9MSk32ohBtXJYT8mMeRG42anlpZiE/sYb+TRFKXn8BHOlq4V
	cv6d2SJ38aMIjnDCClAIOmCgntEjX4x9/O62d5n61PxOnd8+spf52pyl5+PadwoJgmvxAC
	8onl71B8nC6aLBttT2BVjdEWNIbZjlmfYUj08MsNjJPyNk5FBYnCPa3K3XfMf5rh+cmdq2
	85b250MCLfkyvfKPQ3V/+CiOfLknPlQc8TGYYSIA8y+V06eV9rixH5lylQmYJQ==
From: Alexander Dahl <ada@thorsis.com>
To: Mark Brown <broonie@kernel.org>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	linux-spi@vger.kernel.org (open list:SPI SUBSYSTEM),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Microchip (AT91) SoC support),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] spi: atmel-quadspi: Fix wrong register value written to MR
Date: Thu, 26 Sep 2024 11:03:56 +0200
Message-Id: <20240926090356.105789-1-ada@thorsis.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

aq->mr should go to MR, nothing else.

Fixes: 329ca3eed4a9 ("spi: atmel-quadspi: Avoid overwriting delay register settings")
Signed-off-by: Alexander Dahl <ada@thorsis.com>
Link: https://lore.kernel.org/linux-spi/20240926-macarena-wincing-7c4995487a29@thorsis.com/T/#u
---

Notes:
    based on today's master

 drivers/spi/atmel-quadspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index 4f288f07e38f..95cdfc28361e 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -377,7 +377,7 @@ static int atmel_qspi_set_cfg(struct atmel_qspi *aq,
 	 */
 	if (!(aq->mr & QSPI_MR_SMM)) {
 		aq->mr |= QSPI_MR_SMM;
-		atmel_qspi_write(aq->scr, aq, QSPI_MR);
+		atmel_qspi_write(aq->mr, aq, QSPI_MR);
 	}
 
 	/* Clear pending interrupts */

base-commit: 11a299a7933e03c83818b431e6a1c53ad387423d
-- 
2.39.5


