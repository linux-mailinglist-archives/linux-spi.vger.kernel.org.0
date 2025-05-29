Return-Path: <linux-spi+bounces-8324-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C88D3AC7892
	for <lists+linux-spi@lfdr.de>; Thu, 29 May 2025 08:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93F664A722D
	for <lists+linux-spi@lfdr.de>; Thu, 29 May 2025 06:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C9C72505AA;
	Thu, 29 May 2025 06:14:31 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51AB53C01;
	Thu, 29 May 2025 06:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748499271; cv=none; b=pHNqaW1OSOcdp26X7fKFZ3y3r8kHgIO0FbySnfGyq7AMvCjVt44M36TKthqUcVI0nX775DL6C+qseUIacOu0wogz0YazYnGLfy1LdUlK0Pt+Lc2WjqIU2Iy3NwfLaPYVVDqud0FJDhv1LiyAXSsZM++WcCiwYkeUvTVwyXmB97c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748499271; c=relaxed/simple;
	bh=otwWydEhNz1E13Fz1W9ZYH9mDQlgtzvYXYTLqIlatl8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=neAgnYd/Rz3k6LZ70lmetYiSTYqPuNPJIGy/uBHcblG4p6DOrxKhtnjXCDK/EWXYRNqjQzb5+kAmFa9qh8u/ymYhudOkj3MZ45V5AiKQM4JQ3ThbaWHUZNo/Saq7AWzkb+AWkQpD/l1ppRMsjuvVCguCGA2MOd23dkT5ZmQi5d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4b7GFQ0bSGzCtYt;
	Thu, 29 May 2025 14:10:34 +0800 (CST)
Received: from dggpemf500006.china.huawei.com (unknown [7.185.36.235])
	by mail.maildlp.com (Postfix) with ESMTPS id B173F180080;
	Thu, 29 May 2025 14:14:19 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 dggpemf500006.china.huawei.com (7.185.36.235) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 29 May 2025 14:14:19 +0800
From: Yang Shen <shenyang39@huawei.com>
To: <broonie@kernel.org>, <prime.zeng@hisilicon.com>, <fanghao11@huawei.com>,
	<f.fangjian@huawei.com>
CC: <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>
Subject: [PATCH] MAINTAINERS: Update HiSilicon SPI Controller driver maintainer
Date: Thu, 29 May 2025 14:14:06 +0800
Message-ID: <20250529061406.183992-1-shenyang39@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 dggpemf500006.china.huawei.com (7.185.36.235)

Add Yang Shen as the maintainer of the HiSilicon SPI Controller driver,
replacing Jay Fang.

Signed-off-by: Yang Shen <shenyang39@huawei.com>
Reviewed-by: Jay Fang <f.fangjian@huawei.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7d2074d16107..73e3af200eec 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10883,7 +10883,7 @@ F:	drivers/crypto/hisilicon/sec2/sec_crypto.h
 F:	drivers/crypto/hisilicon/sec2/sec_main.c
 
 HISILICON SPI Controller DRIVER FOR KUNPENG SOCS
-M:	Jay Fang <f.fangjian@huawei.com>
+M:	Yang Shen <shenyang39@huawei.com>
 L:	linux-spi@vger.kernel.org
 S:	Maintained
 W:	http://www.hisilicon.com
-- 
2.33.0


