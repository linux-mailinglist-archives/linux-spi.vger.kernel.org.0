Return-Path: <linux-spi+bounces-3915-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A436F939077
	for <lists+linux-spi@lfdr.de>; Mon, 22 Jul 2024 16:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4975C1F221CD
	for <lists+linux-spi@lfdr.de>; Mon, 22 Jul 2024 14:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A0E1EA85;
	Mon, 22 Jul 2024 14:19:02 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09DFE1D555;
	Mon, 22 Jul 2024 14:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721657942; cv=none; b=QyPa3wzfD+JT/4+J+NqMQeiRWShVuxe8giokgA/JTGWmX6V3LXxEV+cBqpVqF40UCgz4Ljbi+G1wAxVTA37QbSt5JxSEhnRHK9jEMTk/hh2m16qNJqegPg7nldstVA/yCHJDSsKRYzrfP8uc+ixFMJctyDHPLatDyin3kuS31g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721657942; c=relaxed/simple;
	bh=Xbs3UoWOYGOngJPTQG/teNnhaR6M0GSk/kW8lB9VjU0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kUR7PEjisStdsGXQ2wBVOo/EB2k1Fw9pvvQSiq5rUSPlLnxECqqStEw/vjO9f+zssCqjQQGADKBzrDQ7L89Ow5a4OTJvCDFTzhmSwSuiysuw+JHfhGepquj72YZ+00CWcBQrxs6KdRTplmohvrkxqW9U9rhVh0snls+UcSSGt/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by APP-05 (Coremail) with SMTP id zQCowAB3XTg1ap5mDvtiAA--.21150S2;
	Mon, 22 Jul 2024 22:18:32 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: broonie@kernel.org,
	jwboyer@linux.vnet.ibm.com,
	dbrownell@users.sourceforge.net,
	sfalco@harris.com,
	akpm@linux-foundation.org,
	sr@denx.de
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ma Ke <make24@iscas.ac.cn>
Subject: [PATCH v3] spi: ppc4xx: handle irq_of_parse_and_map() errors
Date: Mon, 22 Jul 2024 22:18:22 +0800
Message-Id: <20240722141822.1052370-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAB3XTg1ap5mDvtiAA--.21150S2
X-Coremail-Antispam: 1UD129KBjvdXoW7JrWfuF17Kr4DCr4kZF43KFg_yoWfurb_Cw
	4fZr4I9rWUCrnaka4UKr4fAryF9398Xw1vvr92qF9xtrZ8GFnFv34IvF1UXay09w4UGF12
	kwnrZa45ZrnIqjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbVxFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s
	1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
	w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMc
	vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v
	4I1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
	0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
	17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
	C0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY
	6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa
	73UjIFyTuYvjfUF0eHDUUUU
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/

Zero and negative number is not a valid IRQ for in-kernel code and the
irq_of_parse_and_map() function returns zero on error.  So this check for
valid IRQs should only accept values > 0.

Fixes: 44dab88e7cc9 ("spi: add spi_ppc4xx driver")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
Changes in v3:
- removed Cc stable line as suggestions.
Changes in v2:
- added Cc stable line;
- added Fixes line.
---
 drivers/spi/spi-ppc4xx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spi/spi-ppc4xx.c b/drivers/spi/spi-ppc4xx.c
index 01fdecbf132d..599c29a31269 100644
--- a/drivers/spi/spi-ppc4xx.c
+++ b/drivers/spi/spi-ppc4xx.c
@@ -416,6 +416,9 @@ static int spi_ppc4xx_of_probe(struct platform_device *op)
 	if (hw->irqnum <= 0)
 		goto free_host;
 
+	if (hw->irqnum <= 0)
+		goto free_host;
+
 	ret = request_irq(hw->irqnum, spi_ppc4xx_int,
 			  0, "spi_ppc4xx_of", (void *)hw);
 	if (ret) {
-- 
2.25.1


