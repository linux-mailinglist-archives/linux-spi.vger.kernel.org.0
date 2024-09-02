Return-Path: <linux-spi+bounces-4509-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88FD996882B
	for <lists+linux-spi@lfdr.de>; Mon,  2 Sep 2024 15:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FF3C1F22F0A
	for <lists+linux-spi@lfdr.de>; Mon,  2 Sep 2024 13:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF857205E31;
	Mon,  2 Sep 2024 13:00:01 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1622E205E07;
	Mon,  2 Sep 2024 12:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725282001; cv=none; b=nzXP6kyqNjApyJPHvDVygi8Mfi1Zs780K4osv8o/2M8Hzm8u4v9XZAJ/RwlDWthjgvexITkoqcLXQg0gWUYhfA/mAdorMDw3A1OlAPswDaulDJzOJLPFThHm0Xzbnu7698VM0mG8/D3osPfGpUVe63Nlk1sayg2cW8ih9p6u2J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725282001; c=relaxed/simple;
	bh=eGX3ZtogeckrKINPNSyUgH786QF1wYW2OO0xv4hti1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dZF5/6L1IkzVAAlR3NoPk1u2ciHIrP6fQB+Vz7ifGCB6tOzPlpWWTXaUKihdTdKz4VDYmAqptlwv0o+I1fmA47w51HORJ6R6Ru/B23yR8sU5APv3Sh5AvYm+1onyffOBjGNk3GifLIzFR8VH6ip1UTgT77fn+gNezWfIbTtLA40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Wy83j6KGdz4f3jt2;
	Mon,  2 Sep 2024 20:59:45 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 17CED1A018D;
	Mon,  2 Sep 2024 20:59:56 +0800 (CST)
Received: from huaweicloud.com (unknown [10.85.165.202])
	by APP4 (Coremail) with SMTP id gCh0CgD3KsfEttVmOJPAAA--.25304S8;
	Mon, 02 Sep 2024 20:59:55 +0800 (CST)
From: Yang Yingliang <yangyingliang@huaweicloud.com>
To: broonie@kernel.org,
	mchehab@kernel.org,
	Jonathan.Cameron@huawei.com,
	rmfrfs@gmail.com,
	vireshk@kernel.org,
	gregkh@linuxfoundation.org,
	deller@gmx.de,
	corbet@lwn.net,
	yangyingliang@huawei.com,
	liwei391@huawei.com
Cc: linux-media@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-spi@vger.kernel.org
Subject: [PATCH -next 4/7] spi: slave-mt27xx: switch to use spi_alloc_target()
Date: Mon,  2 Sep 2024 20:59:44 +0800
Message-ID: <20240902125947.1368-5-yangyingliang@huaweicloud.com>
X-Mailer: git-send-email 2.46.0.windows.1
In-Reply-To: <20240902125947.1368-1-yangyingliang@huaweicloud.com>
References: <20240902125947.1368-1-yangyingliang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgD3KsfEttVmOJPAAA--.25304S8
X-Coremail-Antispam: 1UD129KBjvdXoWrtw15ArW8WrykAFWrAw17trb_yoWfZFcEkF
	15urnrWrW7KF1qqFyakr4rZ3s29395WFsFgFnagFW3GrZ8W3W3A3yDJr17Jr48u3ykCr1Y
	kr1IqwsIyr1SkjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbg8YFVCjjxCrM7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r126s
	0DM28IrcIa0xkI8VCY1x0267AKxVW5JVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
	Y2AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14
	v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2
	WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkE
	bVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7
	AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
	F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GF
	ylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxV
	W8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7I
	U1aLvJUUUUU==
X-CM-SenderInfo: 51dqw5xlqjzxhdqjqx5xdzvxpfor3voofrz/

From: Yang Yingliang <yangyingliang@huawei.com>

Switch to use modern name function spi_alloc_target().

No functional changed.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/spi/spi-slave-mt27xx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-slave-mt27xx.c b/drivers/spi/spi-slave-mt27xx.c
index f1ddf4c099a3..98cbc0c30e45 100644
--- a/drivers/spi/spi-slave-mt27xx.c
+++ b/drivers/spi/spi-slave-mt27xx.c
@@ -388,9 +388,9 @@ static int mtk_spi_slave_probe(struct platform_device *pdev)
 	int irq, ret;
 	const struct of_device_id *of_id;
 
-	ctlr = spi_alloc_slave(&pdev->dev, sizeof(*mdata));
+	ctlr = spi_alloc_target(&pdev->dev, sizeof(*mdata));
 	if (!ctlr) {
-		dev_err(&pdev->dev, "failed to alloc spi slave\n");
+		dev_err(&pdev->dev, "failed to alloc spi target\n");
 		return -ENOMEM;
 	}
 
-- 
2.33.0


