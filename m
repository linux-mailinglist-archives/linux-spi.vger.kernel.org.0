Return-Path: <linux-spi+bounces-4506-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD33E968821
	for <lists+linux-spi@lfdr.de>; Mon,  2 Sep 2024 15:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 583E21F22D9E
	for <lists+linux-spi@lfdr.de>; Mon,  2 Sep 2024 13:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 484AF19C56F;
	Mon,  2 Sep 2024 12:59:59 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CA01D1F44;
	Mon,  2 Sep 2024 12:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725281999; cv=none; b=IB46d/tEa4xl8DcsHO2pu4J159kbzeh630t3zK09JuRE9F82RMvzfghe2kFvlTub7g53xDAh5eJxFu7l34z8JCozT7BYvqknPHkjAAfTpbd+CE8EC9LbJBaR4yFr1jJiWD5M993rsKSav5vtz0s52UKLVq3VMksxTqI9w2BhXSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725281999; c=relaxed/simple;
	bh=VfL0rVvkqV7KN/5mT6XRH9xVHWl+tfxDMjV+Cf5ivas=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LelDOSpZhFgQzU/ncliGIKXRwOjaj/1cLuLZK9aFxEQI/60d0xKH5D6Unoyheqlei+9cRihN6mc6kzTaA6snlbNiLlMVkQbyvStMrwBoX5bpWWE5X5PTGx9zWUL6hQryl9VpG3907Vaxft4Jkmm+HiUBlh1GPa7ChUHGntR4aZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Wy83Y5xhqz4f3jHc;
	Mon,  2 Sep 2024 20:59:37 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id B468F1A19D9;
	Mon,  2 Sep 2024 20:59:52 +0800 (CST)
Received: from huaweicloud.com (unknown [10.85.165.202])
	by APP4 (Coremail) with SMTP id gCh0CgD3KsfEttVmOJPAAA--.25304S5;
	Mon, 02 Sep 2024 20:59:52 +0800 (CST)
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
Subject: [PATCH -next 1/7] media: usb/msi2500: switch to use spi_alloc_host()
Date: Mon,  2 Sep 2024 20:59:41 +0800
Message-ID: <20240902125947.1368-2-yangyingliang@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgD3KsfEttVmOJPAAA--.25304S5
X-Coremail-Antispam: 1UD129KBjvdXoWrtw17Gw17ZFyUJr4UXr1kXwb_yoWfJrXE93
	Z3uw4xW34qkr1F9r1UK34Iv340krWxWF4kWa4Yyw13AF15W3WDJwnFkr18Zr1j9r4akFnx
	tw1kXr429rnrCjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbDAYFVCjjxCrM7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r18M2
	8IrcIa0xkI8VCY1x0267AKxVW8JVW5JwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK
	021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r
	4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx
	0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWU
	JVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxV
	WUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F
	4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jnpnQU
	UUUU=
X-CM-SenderInfo: 51dqw5xlqjzxhdqjqx5xdzvxpfor3voofrz/

From: Yang Yingliang <yangyingliang@huawei.com>

Switch to use modern name function spi_alloc_host().

No functional changed.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/media/usb/msi2500/msi2500.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/usb/msi2500/msi2500.c b/drivers/media/usb/msi2500/msi2500.c
index 5138486abfa0..05b0550e840c 100644
--- a/drivers/media/usb/msi2500/msi2500.c
+++ b/drivers/media/usb/msi2500/msi2500.c
@@ -1219,8 +1219,8 @@ static int msi2500_probe(struct usb_interface *intf,
 		goto err_free_mem;
 	}
 
-	/* SPI master adapter */
-	ctlr = spi_alloc_master(dev->dev, 0);
+	/* SPI host adapter */
+	ctlr = spi_alloc_host(dev->dev, 0);
 	if (ctlr == NULL) {
 		ret = -ENOMEM;
 		goto err_unregister_v4l2_dev;
-- 
2.33.0


