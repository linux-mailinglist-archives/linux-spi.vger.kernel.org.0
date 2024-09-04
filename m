Return-Path: <linux-spi+bounces-4599-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4230396B63B
	for <lists+linux-spi@lfdr.de>; Wed,  4 Sep 2024 11:13:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 745151C22881
	for <lists+linux-spi@lfdr.de>; Wed,  4 Sep 2024 09:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 989DC1CC892;
	Wed,  4 Sep 2024 09:13:05 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from cmccmta1.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A85D1CC145;
	Wed,  4 Sep 2024 09:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725441185; cv=none; b=cPO9hbv785WckWvGHJvhyHz3ioK+y5vbpT9dHpB6bZgaX9QcFsQiYPDAKzB+4ilURI9qDPUVHGIDwwpV4Ej9BfRL132824JRW5s2Zj9WrZ13MNdqYk76kJN2EZrlRmnBuJQoO5xwcK6Q4kaWtcPBidD6PGQztqmcgKcyNFXeY2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725441185; c=relaxed/simple;
	bh=p3lALecjrvIGPb1bxqd1EYri4pSuBP8TzS9192A78Q0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EsCZTMtvZAlo2z/jVusfJQTOq3S7pmlu0vOL/XQvkwz6Maz2xEIuYRmqQ9RZ5PF6ZX3BwU/6QncrxGhD8d4crQnd1Ef83LBTtrGR5CImZgd3Bp6Z+3VSptCZ9F9d2ggm6lNRZ6uDUJwlswJ52XJK1OWBYKZjLGIbN0s48Jd0pVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app04-12004 (RichMail) with SMTP id 2ee466d82496c9c-b5591;
	Wed, 04 Sep 2024 17:12:58 +0800 (CST)
X-RM-TRANSID:2ee466d82496c9c-b5591
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.97])
	by rmsmtp-syy-appsvr06-12006 (RichMail) with SMTP id 2ee666d8249958d-2367b;
	Wed, 04 Sep 2024 17:12:58 +0800 (CST)
X-RM-TRANSID:2ee666d8249958d-2367b
From: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>
To: broonie@kernel.org
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhang jiao <zhangjiao2@cmss.chinamobile.com>
Subject: [PATCH] spi: spidev_fdx: Fix the wrong format specifier
Date: Wed,  4 Sep 2024 15:35:50 +0800
Message-Id: <20240904073550.103618-1-zhangjiao2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: zhang jiao <zhangjiao2@cmss.chinamobile.com>

The unsigned int should use "%u" instead of "%d".

Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>
---
 tools/spi/spidev_fdx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/spi/spidev_fdx.c b/tools/spi/spidev_fdx.c
index 7d2a867cd4ae..bc9c4f6c3ba8 100644
--- a/tools/spi/spidev_fdx.c
+++ b/tools/spi/spidev_fdx.c
@@ -99,7 +99,7 @@ static void dumpstat(const char *name, int fd)
 		return;
 	}
 
-	printf("%s: spi mode 0x%x, %d bits %sper word, %d Hz max\n",
+	printf("%s: spi mode 0x%x, %d bits %sper word, %u Hz max\n",
 		name, mode, bits, lsb ? "(lsb first) " : "", speed);
 }
 
-- 
2.33.0




