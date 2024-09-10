Return-Path: <linux-spi+bounces-4756-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 817F2972724
	for <lists+linux-spi@lfdr.de>; Tue, 10 Sep 2024 04:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26B371F24C8E
	for <lists+linux-spi@lfdr.de>; Tue, 10 Sep 2024 02:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1774E14A4F1;
	Tue, 10 Sep 2024 02:26:30 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC4C143C6E;
	Tue, 10 Sep 2024 02:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725935190; cv=none; b=erxQ+qZdB1EuED2UvXgqSu+LKb16qVbKIlcYb7RG7Qp9kps9tk0Xb96wgnPv1+YyqNfDiVUm7faklZTP3v+FVj0HNFLPJPRIs6FzLh4bFMEt4b3bhoDeJ4DoVAnc6MuA/s86A0KTucVeflB5S2BO3y4Oal5+DdYhIJBGaYeM1Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725935190; c=relaxed/simple;
	bh=glINnQqD0Ffy6xgU1TMYl5QpTlSq+B9X2f4Ifbo+Rn4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qp/AF+3KE1rqhd+2MzdHqsRqvQxxJuvvd8Y2h5MmjFDgcnhQmsnRi05DdIw7SXxRZz7L+hNiOkYQMtil/Fj2POo8XWgdbo9uT4Vb4OmEcjq/aXwAgvlVmey1pAXBUJ3f1RKfcYZl34ufEU1WZnDUz/o67uAnspql5jm4pIdfe+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4X2ncy1Yw2z4f3jHh;
	Tue, 10 Sep 2024 10:26:10 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 8AF171A0359;
	Tue, 10 Sep 2024 10:26:25 +0800 (CST)
Received: from huaweicloud.com (unknown [10.48.0.27])
	by APP4 (Coremail) with SMTP id gCh0CgDH+8dKrt9m1gKTAw--.13967S7;
	Tue, 10 Sep 2024 10:26:25 +0800 (CST)
From: Yang Yingliang <yangyingliang@huaweicloud.com>
To: broonie@kernel.org,
	hdegoede@redhat.com,
	matthias.bgg@gmail.com,
	yangyingliang@huawei.com,
	liwei391@huawei.com
Cc: linux-spi@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH -next 3/7] spi: slave-system-control: switch to use spi_target_abort()
Date: Tue, 10 Sep 2024 10:26:13 +0800
Message-ID: <20240910022618.1397-4-yangyingliang@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgDH+8dKrt9m1gKTAw--.13967S7
X-Coremail-Antispam: 1UD129KBjvdXoW7Jw1UJw1rWr4rKw13uF45Jrb_yoW3KFb_AF
	47XF1xZr47KF9FkF1qkr1rJF929rWYgF4vgwnFyFW5Ka9Fvw1rXr1vya1Iyw15ZFWrWrya
	yrn3Jw45AwnxGjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbTxYFVCjjxCrM7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r1rM2
	8IrcIa0xkI8VCY1x0267AKxVW5JVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK
	021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F
	4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0
	oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7V
	C0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j
	6r4UM4x0Y48IcxkI7VAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMx
	C20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAF
	wI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20x
	vE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v2
	0xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxV
	W8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1ByIUUUUUU==
X-CM-SenderInfo: 51dqw5xlqjzxhdqjqx5xdzvxpfor3voofrz/

From: Yang Yingliang <yangyingliang@huawei.com>

Switch to use modern name function spi_target_abort().

No functional changed.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/spi/spi-slave-system-control.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-slave-system-control.c b/drivers/spi/spi-slave-system-control.c
index d37cfe995a63..8f5c32b61a5b 100644
--- a/drivers/spi/spi-slave-system-control.c
+++ b/drivers/spi/spi-slave-system-control.c
@@ -136,7 +136,7 @@ static void spi_slave_system_control_remove(struct spi_device *spi)
 {
 	struct spi_slave_system_control_priv *priv = spi_get_drvdata(spi);
 
-	spi_slave_abort(spi);
+	spi_target_abort(spi);
 	wait_for_completion(&priv->finished);
 }
 
-- 
2.33.0


