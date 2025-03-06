Return-Path: <linux-spi+bounces-7048-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E464FA540D2
	for <lists+linux-spi@lfdr.de>; Thu,  6 Mar 2025 03:47:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 278223AF023
	for <lists+linux-spi@lfdr.de>; Thu,  6 Mar 2025 02:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2771F18BC20;
	Thu,  6 Mar 2025 02:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="c+M8MZHa"
X-Original-To: linux-spi@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4CC33C9;
	Thu,  6 Mar 2025 02:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741229260; cv=none; b=p5YCYMNq4mcInlbs1ZRqkoC2L9ies6ur4OEvN3Jf7D7dCpzLUGs0CI6TKxQkcqounzUiskObnQGgg1EpdWBfVNOk1vqaFK801UJI1UUSvHjhLvNClZngztGGtxCIvWHwaauDWyl2uItNrxa6jcf1wRar5IMBBHh46Qdr825a+Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741229260; c=relaxed/simple;
	bh=jIVdm4fhslc+0D4sQTi+TKvZxbyjwooBpCWrRRwAbW8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=S8U/IlVEgJ/XNE3pYhgTnzkwGDvg01WNcO8PPH1UYmUKtLjRdIiP9t5xGP/xN37uOhMAsAogW1W79Rwc3XlDuxV7ZwN7iCI1erm8dKpcWoX64/s/SefNaP/LWYv0RTzGTllOiYlqbA9RgLWm1/fY5qx1yEd7s9vdE1W6TNZ/W70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=c+M8MZHa; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1741229248; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=cydds6dcxAFRZNEZZYF8UB6twxkEdfSrIDqXvVzSON8=;
	b=c+M8MZHagkMJmSY8ANFKTpaa5lI+SdkeUVTzZEkNr0Dgd5lILu4vkuICDw1Pa0OpM+N/QFOYjAklNSSuyFpCI9GbO3eMcCKloj4CH8RVq061sd3oaEe29rrByTsusv3t9u8Kf66a7x99Lz9k+oTxpi4rM1llLc6sVvcJAy7RdM8=
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0WQn5zoS_1741229237 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 06 Mar 2025 10:47:27 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: broonie@kernel.org
Cc: mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	linux-spi@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] spi: stm32: Remove unnecessary print function dev_err()
Date: Thu,  6 Mar 2025 10:47:16 +0800
Message-Id: <20250306024716.27856-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The print function dev_err() is redundant because platform_get_irq()
already prints an error.

./drivers/spi/spi-stm32-ospi.c:798:2-9: line 798 is redundant because platform_get_irq() already prints an error.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=19220
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/spi/spi-stm32-ospi.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/spi/spi-stm32-ospi.c b/drivers/spi/spi-stm32-ospi.c
index 8eadcb64f34a..114ebb1516d4 100644
--- a/drivers/spi/spi-stm32-ospi.c
+++ b/drivers/spi/spi-stm32-ospi.c
@@ -794,10 +794,8 @@ static int stm32_ospi_get_resources(struct platform_device *pdev)
 	}
 
 	ospi->irq = platform_get_irq(pdev, 0);
-	if (ospi->irq < 0) {
-		dev_err(dev, "Can't get irq %d\n", ospi->irq);
+	if (ospi->irq < 0)
 		return ospi->irq;
-	}
 
 	ret = devm_request_irq(dev, ospi->irq, stm32_ospi_irq, 0,
 			       dev_name(dev), ospi);
-- 
2.32.0.3.g01195cf9f


