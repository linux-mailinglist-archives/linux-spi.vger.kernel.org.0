Return-Path: <linux-spi+bounces-3913-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 353D6938F44
	for <lists+linux-spi@lfdr.de>; Mon, 22 Jul 2024 14:46:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD8951F21D55
	for <lists+linux-spi@lfdr.de>; Mon, 22 Jul 2024 12:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC2CF16A399;
	Mon, 22 Jul 2024 12:46:25 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB9116D9C4;
	Mon, 22 Jul 2024 12:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721652385; cv=none; b=FZqR++0e0iduKZKBSjA82zYpHXn7FehglIF3TrKoF3QJcYgYEaxKnhLZhY1dFFmgVc5po5Xt/SNZkFLauyM8S8dvW3rd8URLJZxyhXPFn+T5X5SFBVHRCzcv6Eqz/3BSTeiLV4l2Ytcb9uD/cSjw7CpK4shRvzk1ilvYbN34O4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721652385; c=relaxed/simple;
	bh=D0VJEhtgDYeWeboDOm9RrZtcqVHRqzkq0Poz2aPsLgQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BmrFUCqP+H2i+3j5qZW7M4e7T/OiiEqajyMyHu+H7Zt2+JyncHTOu087FvDmogezmd5DCfgmhIZ2h+5hqxPSj2NPDd0/KykzFZ1heuU6/P6n9etek2p4IxAZNJqUR9g/n/+O+OWj1U85tEglok1TO8wqpKQf+lJ/piLNis5tgaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by APP-01 (Coremail) with SMTP id qwCowACnkMEKUp5m4KZhAA--.23554S2;
	Mon, 22 Jul 2024 20:35:31 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: broonie@kernel.org,
	sfalco@harris.com,
	sr@denx.de,
	dbrownell@users.sourceforge.net,
	jwboyer@linux.vnet.ibm.com,
	akpm@linux-foundation.org
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ma Ke <make24@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH v2] spi: ppc4xx: handle irq_of_parse_and_map() errors
Date: Mon, 22 Jul 2024 20:35:19 +0800
Message-Id: <20240722123519.333088-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowACnkMEKUp5m4KZhAA--.23554S2
X-Coremail-Antispam: 1UD129KBjvdXoW7JrWfuF17Kr4DCr4ktFWfGrg_yoWfurb_Cw
	4fZFWIgrWUC3Z3Ka1jgr4fZry09a45Xw4vvr92qFZxtrZ8JFnFv34IvFn8Xa1I93yDCry2
	kwnrX34rurnIqjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbfxFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s
	1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
	w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMc
	vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v
	4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUQvtAUUUUU=
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/

Zero and negative number is not a valid IRQ for in-kernel code and the
irq_of_parse_and_map() function returns zero on error.  So this check for
valid IRQs should only accept values > 0.

Cc: stable@vger.kernel.org
Fixes: 44dab88e7cc9 ("spi: add spi_ppc4xx driver")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
Changes in v2:
- added Cc stable line;
- added Fixes line.
---
 drivers/spi/spi-ppc4xx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spi/spi-ppc4xx.c b/drivers/spi/spi-ppc4xx.c
index 942c3117ab3a..01fdecbf132d 100644
--- a/drivers/spi/spi-ppc4xx.c
+++ b/drivers/spi/spi-ppc4xx.c
@@ -413,6 +413,9 @@ static int spi_ppc4xx_of_probe(struct platform_device *op)
 
 	/* Request IRQ */
 	hw->irqnum = irq_of_parse_and_map(np, 0);
+	if (hw->irqnum <= 0)
+		goto free_host;
+
 	ret = request_irq(hw->irqnum, spi_ppc4xx_int,
 			  0, "spi_ppc4xx_of", (void *)hw);
 	if (ret) {
-- 
2.25.1


