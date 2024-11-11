Return-Path: <linux-spi+bounces-5661-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B29AB9C38AF
	for <lists+linux-spi@lfdr.de>; Mon, 11 Nov 2024 07:54:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CFAA1F211CD
	for <lists+linux-spi@lfdr.de>; Mon, 11 Nov 2024 06:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FAAC61FE9;
	Mon, 11 Nov 2024 06:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="mQ/nSwPE"
X-Original-To: linux-spi@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC083C3C;
	Mon, 11 Nov 2024 06:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731308089; cv=none; b=jpgrnqRFrJrGDVQra5SQv5aZFcF2d7dN/kP0p7XnP2iHYbcMJRvl6KRRR9STmn/mQCyIm2SkZHLqb77gAyP0LAQxD5DSNN5ltTmZkRBKyv+9MyS5jTNcXtkkr6rG1XtDBnHow34nt8IBjUJsmI+t8PF78rYkrSxFOst56fyXeZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731308089; c=relaxed/simple;
	bh=T5G/7MG/FAAjRjOLEwmImdy4jBQDSCLqk5vZf3jNtZo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=occmc2CYkQvb4UQaVWQdtC9ZwugZcUReFLKgHgufaI2bPjxJTz31sY+RIkEh8soj7SpOByHjUV/LbLztqS+ZResegXvVAuq2jqpxXk7oq8e1jbiqYYr43WvZLoopedVqfJw2kno64s/H7hfYfsQFdRJ2oVK30WnBj/VpCrEdIKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=mQ/nSwPE; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731308076; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=3w224ktOqagLWitq0jzUtvakJXzZioCdJS1eDcHoEak=;
	b=mQ/nSwPEa7uD+yg1UQmFLdbcNZB95sZxva9onWKnuGwuijHQZKtigeNwYK8/dTwStPYGzqfxqfj0tT3ekqvyZCzKOlD2ooeDdhv7ubR+xX8YnP2N45wh7v73rZEF+Wpo9rhn6X/fCklGa8xdDkEw8HKR5L731Dt1th9w6FxJXY8=
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0WJ6PLQ9_1731308066 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 11 Nov 2024 14:54:35 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: broonie@kernel.org
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] spi: apple: Remove unnecessary .owner for apple_spi_driver
Date: Mon, 11 Nov 2024 14:54:25 +0800
Message-Id: <20241111065425.103645-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove .owner field if calls are used which set it automatically.

./drivers/spi/spi-apple.c:522:3-8: No need to set .owner here. The core will do it.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=11799
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/spi/spi-apple.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-apple.c b/drivers/spi/spi-apple.c
index 1ce91cea89be..d4b126c8701a 100644
--- a/drivers/spi/spi-apple.c
+++ b/drivers/spi/spi-apple.c
@@ -519,7 +519,6 @@ static struct platform_driver apple_spi_driver = {
 	.probe = apple_spi_probe,
 	.driver = {
 		.name = "apple-spi",
-		.owner = THIS_MODULE,
 		.of_match_table = apple_spi_of_match,
 	},
 };
-- 
2.32.0.3.g01195cf9f


