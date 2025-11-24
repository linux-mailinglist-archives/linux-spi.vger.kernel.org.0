Return-Path: <linux-spi+bounces-11469-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B104EC7EC87
	for <lists+linux-spi@lfdr.de>; Mon, 24 Nov 2025 03:00:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7B7704E10C6
	for <lists+linux-spi@lfdr.de>; Mon, 24 Nov 2025 02:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16D4224FA;
	Mon, 24 Nov 2025 02:00:17 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644E236D50C;
	Mon, 24 Nov 2025 02:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763949617; cv=none; b=oFkHW/NkZQtpB6j3qHz1whMe1gNFVy9d7HvOpZGWiq8KxXZ4fZEZiv6G62K/2YY6e7hJWbjuXA21uIwZqjy/kM+qPQuk5bhJwcbc2oNU4jiSzToB3I3i1kJtR0HINv+uXaBa5kt+/ii+ojZ4uVR7faXpXS2wfkzfjLiCLgn/+SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763949617; c=relaxed/simple;
	bh=Iugr9KSxqxKqJVyQQZ5i340yKFREG3ihCzZBGEB0ZeU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H+pSDD6tOzpAyIngUvqskR0ll3fDn8x1oUrPxkAaUH1l20Sf/574NOs2nc7pEA1HW4Dsir5MC3xpZnBMrQbeCXe+fjnOYfl5ESbMqmq+Mur1ivt9yZDJCm00ZIbQ5m3aO+fPvoJc0bI4viAbAWoLoru2qDiR6lhoJNPO4QAaRIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from DESKTOP-L0HPE2S (unknown [124.16.141.245])
	by APP-05 (Coremail) with SMTP id zQCowABnbG0pvCNpX8_RAQ--.26659S2;
	Mon, 24 Nov 2025 10:00:10 +0800 (CST)
From: Haotian Zhang <vulab@iscas.ac.cn>
To: broonie@kernel.org
Cc: mmkurbanov@sberdevices.ru,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haotian Zhang <vulab@iscas.ac.cn>
Subject: [PATCH] spi: amlogic-spifc-a1: Handle devm_pm_runtime_enable() errors
Date: Mon, 24 Nov 2025 09:58:52 +0800
Message-ID: <20251124015852.937-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABnbG0pvCNpX8_RAQ--.26659S2
X-Coremail-Antispam: 1UD129KBjvdXoW7GF45Cr4fKw48uFW5GrW3KFg_yoWkCwc_CF
	4ruan3JF1Fqr1kC3ZrK34fZrySg348Wa1jqwnYvrZIqayUAFn7Z3yjvFn8Cw4Duw4UCr90
	9rsruF9rCryDAjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbsAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	JF0_Jw1lc2xSY4AK67AK6r4UMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r
	4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
	67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
	x0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2
	z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnU
	UI43ZEXa7VUjR6wtUUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwsQA2kjuhsIrQAAsR

devm_pm_runtime_enable() can fail due to memory allocation. The current
code ignores its return value, potentially causing runtime PM operations
to fail silently after autosuspend configuration.

Check the return value of devm_pm_runtime_enable() and return on failure.

Fixes: 909fac05b926 ("spi: add support for Amlogic A1 SPI Flash Controller")
Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
---
 drivers/spi/spi-amlogic-spifc-a1.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-amlogic-spifc-a1.c b/drivers/spi/spi-amlogic-spifc-a1.c
index 18c9aa2cbc29..eb503790017b 100644
--- a/drivers/spi/spi-amlogic-spifc-a1.c
+++ b/drivers/spi/spi-amlogic-spifc-a1.c
@@ -353,7 +353,9 @@ static int amlogic_spifc_a1_probe(struct platform_device *pdev)
 
 	pm_runtime_set_autosuspend_delay(spifc->dev, 500);
 	pm_runtime_use_autosuspend(spifc->dev);
-	devm_pm_runtime_enable(spifc->dev);
+	ret = devm_pm_runtime_enable(spifc->dev);
+	if (ret)
+		return ret;
 
 	ctrl->num_chipselect = 1;
 	ctrl->dev.of_node = pdev->dev.of_node;
-- 
2.50.1.windows.1


