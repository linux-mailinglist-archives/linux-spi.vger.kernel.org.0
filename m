Return-Path: <linux-spi+bounces-2752-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7DD58BD03F
	for <lists+linux-spi@lfdr.de>; Mon,  6 May 2024 16:28:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BFBAB211DB
	for <lists+linux-spi@lfdr.de>; Mon,  6 May 2024 14:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7486513CABF;
	Mon,  6 May 2024 14:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Es3rR7u/"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF7B1DA22;
	Mon,  6 May 2024 14:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715005690; cv=none; b=hXcz+R3tpp41a6ZyNqS0VvOeqVFfy9+h1ma+iit7DWiDgdwV5qXOUC5XUJ4kyZeDue+a2Sz5BIv3lucrKzS4Vh+80pBASamGVv0NEJosCZ4WXlAgNOGF8JbwEIcqJ7qk+kPZxuGygavVw8+6IQs1NPYYv6DtsPRCQanu/gYuZzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715005690; c=relaxed/simple;
	bh=ys/ac5b62+VTDhNwzNhTkPH6Pm/35X6rH/RPIwPLQG0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=P4AQuHxiC57y2rGFRL2XbxEHG5sdvTNlAQbb2ueJN/aXf2LYLlY8sXzHeAcZEEKPCpp/OhKV/Jz7M87vL+20v8r9r3YFIBnTM2e+wq0z1A/C8/fAnh83x4xf1k68yWZ2VnmswukWqQVCI1xKPLvDQL3808JgLu5nOPWosY0FO8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Es3rR7u/; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 594982000E;
	Mon,  6 May 2024 14:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1715005685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HCT4bNuCRAalboXbgJPQXrj7t+YFvvJi35evSOHQrr8=;
	b=Es3rR7u/87oEacsR37RMCrYGBcOiFTrQqC5iMdSt+SO0Z8utlzUNooGQKxPge3QynuOajO
	8RaVKV8hmrBKg+x+2sVrcCKumIMD1a1jA4mTKulK5F7XTBsHn4sQc7bhne+JQgCretgwCY
	xxujLgzKSwqJxu+DqwkQtpW1vu7dvpAvq01PAajXJoa0T2o7ZKctaAP99hEPU6v/9ZpF4E
	ymckgSvfrli8eLNunzaAuDgAVtIkk93Gdft39EjrGRjP8AnhyWAQ6AC6w++ElVPA2EP3tE
	l6fSq9vqip2EvL4Sv+H+lRBDAgfM2U5T2UxU2Y+hJs7tJ8IdnWMbsqif4RUOIg==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Mon, 06 May 2024 16:27:59 +0200
Subject: [PATCH v2] spi: omap2-mcspi: Ensure that CS is correctly asserted
 when switching from MULTI mode to SINGLE mode
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240506-fix-omap2-mcspi-v2-1-d9c77ba8b9c7@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAO/oOGYC/2WNwQ6CMBBEf4Xs2TVs0xDw5H8YDqVdZBOh2ALRE
 P7dijEePL7JzLwVIgfhCKdshcCLRPFDAnXIwHZmuDKKSwwqVzrXeYmtPND3ZlTY2zgKmqLRRFo
 ZVxlIqzFwquyPl/rDge9zOp5+YSdx8uG5Wxd6p19B9SdYCAlb1ZQlGaaqcOfG++kmw9H6Hupt2
 16xtovBxQAAAA==
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com, 
 yen-mei.goh@keysight.com, jeremie.dautheribes@bootlin.com, 
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2135;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=ys/ac5b62+VTDhNwzNhTkPH6Pm/35X6rH/RPIwPLQG0=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBmOOj1Z0bR5qhlR6Zut/Mp8TwM57fOgBz/jdl1N
 y62PlKx6S+JAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZjjo9QAKCRAgrS7GWxAs
 4l6qD/9RZNpcqitbNxBnyf6I5Oq6pSQuYCGDfoZe8zCllt50l+uIKus/J1JHPsqthkwBkUxlv+6
 QLRGzUwBo4KW75hFp2ZRMX7NlG03nW4/SzCciaQoCHBpJPxrjJdkHpRFeuOOnyXU2gMjDJ1LO9Q
 Ko5SHTfwY757wE0MJHkVnxHJe023PKy/U1v8NUtTw4K5HJqLAfHNxptN4rkOm4iLPde09WYuDDQ
 vdL1FpcJnsPZbqCIb0K8dFqc17SFMblOvkWR4mySt8fSEXgSf4UmPZtSwmrFMomBm7IlZsWOgq5
 bmmzDSt62FJQxaiaDKtJv7DcNcqPvVeBXHw2mYHzmhZ9oRIKSXa6fYvS23cDCeSRmHlYLtqPaeS
 7OSZ/CZobW1wY2PI0n4fKzjDETzOSvmToXwCDprLJms1x6ZG8HDELuAeDs8ZMs297yNhTM98rat
 kdh48muxY33W3tv9vLCJ0wOmNswc54LEY/zLuJtOxVL4haAlkixWuiOIYI5huWZKxnY39vkoQz3
 ancNMKOJjTRmCpqGcVvh9ztLeMeiQ3lWQrmg6qgH1SaQSRcJB0QZYRlcWDx/RYZdN4ixdniXZ7V
 faw1UZq6RyX2Xd8CsPf3+r+phxUBOgCkFQ6bdRlCGPTWB5fRMb7C9jtaJpn5oVT/fdeT79Ltbmg
 UDcPqe1DPjIxTEw==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

The OMAP2 support features a "multi" mode, where the controller
automatically sets the Chip Select (CS) when necessary. This mode allows
for shorter delays between CS selection and word content, but the CS is
always deasserted at the end.

The default transfer_one_message function expects the last transfer of a
message to keep the CS enabled. However, when two consecutive messages
use "multi" mode followed by "single" mode, the chipselect is not enabled
during the second message. This discrepancy causes the driver to time
out.

To address this issue, the CS is now reasserted for each new message that
follows a "multi"-mode message. This change ensures proper CS handling
and prevents driver timeouts.

Fixes: d153ff4056cb ("spi: omap2-mcspi: Add support for MULTI-mode")

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
Changes in v2:
- Fix build error, I used the old API (master instead of controller)
- Link to v1: https://lore.kernel.org/r/20240409-fix-omap2-mcspi-v1-1-f2b881ae196d@bootlin.com
---
 drivers/spi/spi-omap2-mcspi.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index 7e3083b83534..dd514a7504ec 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -1264,6 +1264,15 @@ static int omap2_mcspi_prepare_message(struct spi_controller *ctlr,
 	struct spi_transfer	*tr;
 	u8 bits_per_word;
 
+	/*
+	 * When the last transfer used multi-mode, the CS is not keep down by the controller.
+	 * The default transfer_one_message expect that the last transfer of a message keep the CS
+	 * active.
+	 * Ensure that the next call to spi_set_cs will work as expected if single-mode is used.
+	 */
+	if (mcspi->use_multi_mode)
+		ctlr->last_cs[0] = -1;
+
 	/*
 	 * The conditions are strict, it is mandatory to check each transfer of the list to see if
 	 * multi-mode is applicable.

---
base-commit: dfca7eb7615116b696ecdc85417c9e2df0b546dc
change-id: 20240408-fix-omap2-mcspi-a6b41142ad9a

Best regards,
-- 
Louis Chauvet <louis.chauvet@bootlin.com>


