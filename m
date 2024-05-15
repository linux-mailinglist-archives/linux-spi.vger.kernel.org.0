Return-Path: <linux-spi+bounces-2855-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F8A8C62FA
	for <lists+linux-spi@lfdr.de>; Wed, 15 May 2024 10:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D198A1F237F3
	for <lists+linux-spi@lfdr.de>; Wed, 15 May 2024 08:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7F74EB45;
	Wed, 15 May 2024 08:41:28 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD224DA15;
	Wed, 15 May 2024 08:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715762488; cv=none; b=lSI+z3Ru4fYoJJePT4bhA8UbT4mmYEkFOWEkZarPycfW/XIMMBU/ayYxXZ/VeU6+g++v46NupNZt84n4ms8spMQh4aJF0voH5+tasTRqqZOCySlBDUtjDuKEHxmimioepfXcOI+003K2K+FQ0CRmIyEtHJiXeUVGkyocVSUSb2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715762488; c=relaxed/simple;
	bh=8L6MR+XjIcweRFqdxmO8XAW2pW64tx8lIak3KbvXdGk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eMKIhRh/1osfE1i/zDGAiNmoSL7eyVFOtVCzi8iIwb6GJPd9dpUIqIjQPVu5WJdyQJPTmP7vZ1b8yqCL4BfMt2lBBj4KFIB7JpNJnJ65zWY2vVZ1L9dz98c6WewdaiJJDKjYTUtPAdleyTPcwWBOvAxiniwpSUBkPGaVzr260r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-05 (Coremail) with SMTP id zQCowAAnLwMWdURma6dPCw--.60167S2;
	Wed, 15 May 2024 16:40:55 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: broonie@kernel.org,
	nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev
Cc: linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] spi: atmel-quadspi: Add missing check for clk_prepare
Date: Wed, 15 May 2024 16:40:28 +0800
Message-Id: <20240515084028.3210406-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAAnLwMWdURma6dPCw--.60167S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtF4xtryfJw4kXw13XF47Jwb_yoWfKFX_CF
	WDu3sxGr43Gr4DK3Waqw1UZr9a9FWUZayI9F1qv3WfJFyDJry3uryUZF1DC3yUZr4Ikw13
	CF1UG3Z2yrnxZjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbz8FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1l42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
	14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUoOJ5UUUUU
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

Add check for the return value of clk_prepare() and return the error if
it fails in order to catch the error.

Fixes: 4a2f83b7f780 ("spi: atmel-quadspi: add runtime pm support")
Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 drivers/spi/atmel-quadspi.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index 370c4d1572ed..5aaff3bee1b7 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -756,8 +756,15 @@ static int __maybe_unused atmel_qspi_resume(struct device *dev)
 	struct atmel_qspi *aq = spi_controller_get_devdata(ctrl);
 	int ret;
 
-	clk_prepare(aq->pclk);
-	clk_prepare(aq->qspick);
+	ret = clk_prepare(aq->pclk);
+	if (ret)
+		return ret;
+
+	ret = clk_prepare(aq->qspick);
+	if (ret) {
+		clk_unprepare(aq->pclk);
+		return ret;
+	}
 
 	ret = pm_runtime_force_resume(dev);
 	if (ret < 0)
-- 
2.25.1


