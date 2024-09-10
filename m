Return-Path: <linux-spi+bounces-4760-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A300597272D
	for <lists+linux-spi@lfdr.de>; Tue, 10 Sep 2024 04:26:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC262B22E9A
	for <lists+linux-spi@lfdr.de>; Tue, 10 Sep 2024 02:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4A014E2E1;
	Tue, 10 Sep 2024 02:26:33 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E7F14A09A;
	Tue, 10 Sep 2024 02:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725935193; cv=none; b=gwBfZ8d2bK+0mqZ+JlzUeDXP2l6qcs1gnZWiVDD/i01W9AtXtHPsrKBklMSq66bbXj9aHDt5tsiOoEUBOTJw0ZQDf8cHbB0FryNyYSELBkB8OEdruM7bajqnEHtUcvdKYpTIShHxtMQPpZuEH7AW2Ax4Q6AFEgVE3H4u+aOhW4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725935193; c=relaxed/simple;
	bh=V+6wYhEz7BgX2SLxOy/nESTXWdm7o7QN6FvYCRcRBT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uw+Sz2zAo9mOWGhLI8wz1p6/bcYNddVyAame3jgTCVYqcPiZSsAcgXMq5P2OLxr8Ich3hidLH7TSbuoXzRGlK3ehQgucZyKd+F/GGh/9FDhtcQquPb5ChSOQd0Z0bSxhEjhnPV4Hn7jVdrrYYQttfZFcxARyhO9cMLNffWi8D3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4X2nd10nddz4f3jsH;
	Tue, 10 Sep 2024 10:26:13 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 6FD101A0568;
	Tue, 10 Sep 2024 10:26:28 +0800 (CST)
Received: from huaweicloud.com (unknown [10.48.0.27])
	by APP4 (Coremail) with SMTP id gCh0CgDH+8dKrt9m1gKTAw--.13967S10;
	Tue, 10 Sep 2024 10:26:28 +0800 (CST)
From: Yang Yingliang <yangyingliang@huaweicloud.com>
To: broonie@kernel.org,
	hdegoede@redhat.com,
	matthias.bgg@gmail.com,
	yangyingliang@huawei.com,
	liwei391@huawei.com
Cc: linux-spi@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH -next 6/7] platform/olpc: olpc-xo175-ec: switch to use spi_target_abort().
Date: Tue, 10 Sep 2024 10:26:16 +0800
Message-ID: <20240910022618.1397-7-yangyingliang@huaweicloud.com>
X-Mailer: git-send-email 2.46.0.windows.1
In-Reply-To: <20240910022618.1397-1-yangyingliang@huaweicloud.com>
References: <20240910022618.1397-1-yangyingliang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDH+8dKrt9m1gKTAw--.13967S10
X-Coremail-Antispam: 1UD129KBjvdXoW7Jw1UJw1rXryfuryruF4UArb_yoWkuwb_Gr
	1xtrWxX3y09F4DCF1jkF4fJry0kryrWF1kXF1av3Waka45Xw1rXw4qkrW3A3Z2vrWDArZa
	ka1kZrZ5CryfCjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbf8YFVCjjxCrM7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r126s
	0DM28IrcIa0xkI8VCY1x0267AKxVW5JVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
	Y2AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14
	v26F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ew
	Av7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY
	6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI4
	8JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xv
	wVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjx
	v20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20E
	Y4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267
	AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1l_M7UUUUU==
X-CM-SenderInfo: 51dqw5xlqjzxhdqjqx5xdzvxpfor3voofrz/

From: Yang Yingliang <yangyingliang@huawei.com>

Switch to use modern name function spi_target_abort().

No functional changed.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/platform/olpc/olpc-xo175-ec.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/olpc/olpc-xo175-ec.c b/drivers/platform/olpc/olpc-xo175-ec.c
index 62ccbcb15c74..fa7b3bda688a 100644
--- a/drivers/platform/olpc/olpc-xo175-ec.c
+++ b/drivers/platform/olpc/olpc-xo175-ec.c
@@ -536,7 +536,7 @@ static int olpc_xo175_ec_cmd(u8 cmd, u8 *inbuf, size_t inlen, u8 *resp,
 		dev_err(dev, "EC cmd error: timeout in STATE %d\n",
 				priv->cmd_state);
 		gpiod_set_value_cansleep(priv->gpio_cmd, 0);
-		spi_slave_abort(priv->spi);
+		spi_target_abort(priv->spi);
 		olpc_xo175_ec_read_packet(priv);
 		return -ETIMEDOUT;
 	}
@@ -653,7 +653,7 @@ static void olpc_xo175_ec_remove(struct spi_device *spi)
 	if (pm_power_off == olpc_xo175_ec_power_off)
 		pm_power_off = NULL;
 
-	spi_slave_abort(spi);
+	spi_target_abort(spi);
 
 	platform_device_unregister(olpc_ec);
 	olpc_ec = NULL;
-- 
2.33.0


