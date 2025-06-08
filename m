Return-Path: <linux-spi+bounces-8379-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 037E6AD12A5
	for <lists+linux-spi@lfdr.de>; Sun,  8 Jun 2025 16:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 155DB3AAE8C
	for <lists+linux-spi@lfdr.de>; Sun,  8 Jun 2025 14:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE4B324DD0A;
	Sun,  8 Jun 2025 14:29:59 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F354924DFE6;
	Sun,  8 Jun 2025 14:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749392999; cv=none; b=hUbqFlt7mtwR5H4BIfLOGiaXzyc95Ngj9kWK6GNOPUMTjmK3nIzuk4e1Q4PbijLvyCGVLUk5vUuqIl+aOtFQ2kcsIqhq2euVwZ7zvXWZEplFXvtSmY4Rm3oZ0ZsM8Xl8N3zy6IJ5v/hv2EGwO+5jEH5jNodaKuyLRTtfgOc2g4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749392999; c=relaxed/simple;
	bh=DiCQiArzwbFcPFdOQvg+itZINo5n3ZPTmTduwYUCqaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y8DZcfgfcsCopRoQ4xXw8SV4s0un3+bp0t2YOG1nCM3/shqV9kMzeKWVvkLVzdyJX5atePB48Zo8jUmsQEA34lwvwRFbBzpVpE5h+t8241OzgycH02SSbG8LSy/ll+AbwPW7BL67DT8NherZ0Dlv4nU16zb7+xLPg4tCARxAMgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.3])
	by gateway (Coremail) with SMTP id _____8Bx22phnkVoEXUQAQ--.7797S3;
	Sun, 08 Jun 2025 22:29:53 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.3])
	by front1 (Coremail) with SMTP id qMiowMDxuhpbnkVo7sEQAQ--.31632S2;
	Sun, 08 Jun 2025 22:29:53 +0800 (CST)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Masahiro Yamada <masahiroy@kernel.org>,
	linux-kbuild@vger.kernel.org,
	Mark Brown <broonie@kernel.org>,
	Yinbo Zhu <zhuyinbo@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xuerui Wang <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH] spi: loongson: Fix build warnings about export.h
Date: Sun,  8 Jun 2025 22:29:39 +0800
Message-ID: <20250608142939.172108-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMDxuhpbnkVo7sEQAQ--.31632S2
X-CM-SenderInfo: hfkh0x5xdftxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj9xXoW7GFWrZw4kJryrGryDKFy8JFc_yoWDWFb_Cw
	1xCr1Igr4xtw47K3WSvF9Fyr90g34rXw4YqF1v9r13X3WDt3y5Ka43CasxG3W7Cwn0vFs5
	ur4xW348ury5CosvyTuYvTs0mTUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUb28YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_JrI_Jryl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE
	14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jOdb8UUUUU=

After commit a934a57a42f64a4 ("scripts/misc-check: check missing #include
<linux/export.h> when W=1") and 7d95680d64ac8e836c ("scripts/misc-check:
check unnecessary #include <linux/export.h> when W=1"), we get some build
warnings with W=1:

drivers/spi/spi-loongson-core.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing

So fix these build warnings for SPI/Loongson.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/spi/spi-loongson-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-loongson-core.c b/drivers/spi/spi-loongson-core.c
index 4fec226456d1..b46f072a0387 100644
--- a/drivers/spi/spi-loongson-core.c
+++ b/drivers/spi/spi-loongson-core.c
@@ -5,6 +5,7 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/err.h>
+#include <linux/export.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
-- 
2.47.1


