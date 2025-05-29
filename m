Return-Path: <linux-spi+bounces-8325-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED1E2AC7896
	for <lists+linux-spi@lfdr.de>; Thu, 29 May 2025 08:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 135043BCFE5
	for <lists+linux-spi@lfdr.de>; Thu, 29 May 2025 06:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D462522A1;
	Thu, 29 May 2025 06:17:22 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42E81F4717;
	Thu, 29 May 2025 06:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748499442; cv=none; b=Ji1JR5YlbKABwSeVBGI5oVX/D9YahkM6ot5s3GmdNEiWs27II3rCCBiRLIrQibqArHC7SN0caRqZtuAp1idvFnwBDb3kcjFDwpuG4rSi90xEJ+WemZOGLsC7D+0Kh/+lgWyET8+S2g6PjtXC8m8N3avWARyC005Osp7ArLZy/uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748499442; c=relaxed/simple;
	bh=SVySeRXs71QN4VSaOQbInEZrGqsby4xHn2l/bWyt9I8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mYFT8TwXCn0fjsFfCIFITeer302hSXXopAPwa5rgZtBnACuG7Ke9erDmBaoCpaQ120i3gAggs+5hdHhNk1S1EQltOyMg/DNcE6f1EMsJAVbPAcot9iU79JGqw/Ew3/yQ9PAmY7AJyRSLEnRNipRjOjp4gAZniwxJrwrclAS08TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4b7GJ34d9Yz10WLG;
	Thu, 29 May 2025 14:12:51 +0800 (CST)
Received: from dggpemf500006.china.huawei.com (unknown [7.185.36.235])
	by mail.maildlp.com (Postfix) with ESMTPS id CD46F1400F4;
	Thu, 29 May 2025 14:17:16 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 dggpemf500006.china.huawei.com (7.185.36.235) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 29 May 2025 14:17:16 +0800
From: Yang Shen <shenyang39@huawei.com>
To: <broonie@kernel.org>, <prime.zeng@hisilicon.com>, <fanghao11@huawei.com>,
	<f.fangjian@huawei.com>
CC: <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>
Subject: [PATCH] MAINTAINERS: Update HiSilicon SFC driver maintainer
Date: Thu, 29 May 2025 14:17:04 +0800
Message-ID: <20250529061704.190725-1-shenyang39@huawei.com>
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

Add Yang Shen as the maintainer of the HiSilicon SFC driver,
replacing Jay Fang.

Signed-off-by: Yang Shen <shenyang39@huawei.com>
Reviewed-by: Jay Fang <f.fangjian@huawei.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7d2074d16107..2e95f7f45a9b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10909,7 +10909,7 @@ S:	Maintained
 F:	drivers/crypto/hisilicon/trng/trng.c
 
 HISILICON V3XX SPI NOR FLASH Controller Driver
-M:	Jay Fang <f.fangjian@huawei.com>
+M:	Yang Shen <shenyang39@huawei.com>
 S:	Maintained
 W:	http://www.hisilicon.com
 F:	drivers/spi/spi-hisi-sfc-v3xx.c
-- 
2.33.0


