Return-Path: <linux-spi+bounces-11935-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB46CC0F74
	for <lists+linux-spi@lfdr.de>; Tue, 16 Dec 2025 06:12:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A66A8305978E
	for <lists+linux-spi@lfdr.de>; Tue, 16 Dec 2025 04:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A3502D7DE3;
	Tue, 16 Dec 2025 04:33:00 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3A933291A;
	Tue, 16 Dec 2025 04:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765859578; cv=none; b=LYnvLMSuCKrqWWjMHS13ejJyd3gHDSM33dFxjeyDCPAmL9fgW4B5Y8colbDEI+MeOpqKC6jqRH5r2aRDUNVQYqpgfEe9cecATn4rXsIGo7YPbY726XimlBkbrsyJmL+GmDqwQsgoWgbdTseUlRwQh1JVJj2VDLmvCKKEQ7niCrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765859578; c=relaxed/simple;
	bh=RIU1Tj0aY8wLbb/bkcLYdm1STWEU+TjQRvLdxBx1M5I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=j4OyI6nVh9fvdSvd+/Zu1/Ud0P1l+wHhi4QbQaB7G1ua6k9M5hHL40HZzlv7WeEhEz8sqba8kNfif9Ic1zjWGWuw+pum50AzVnRsS8YU95cWjTcfqs8c7vApmTUOkX3nuZPUdVGDLxP/QTLZr8YiS1D1rKdAdjh9kcdhELnlQdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-03 (Coremail) with SMTP id rQCowABHaN_j4EBp5ODbAA--.22745S2;
	Tue, 16 Dec 2025 12:32:35 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: broonie@kernel.org,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com
Cc: linux-spi@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] spi: stm32-ospi: Remove unneeded semicolon
Date: Tue, 16 Dec 2025 12:32:10 +0800
Message-Id: <20251216043210.1521722-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowABHaN_j4EBp5ODbAA--.22745S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZFWDuF4rXw4DWryfGr13CFg_yoWDJFX_CF
	1kCw1xC34qvr90y3W7Grn5Jr9Iva1DX3WFqwsYvFsxArZrXa1Uu3y8Zr17Jw47Zw4qk397
	C3Z7X34akw13KjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbs8FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r1q
	6r43MxkIecxEwVAFwVW8XwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8Jw
	C20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAF
	wI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjx
	v20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2
	jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43
	ZEXa7VUjJ5r7UUUUU==
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

Remove unnecessary semicolons reported by Coccinelle/coccicheck and the
semantic patch at scripts/coccinelle/misc/semicolon.cocci.

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 drivers/spi/spi-stm32-ospi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-stm32-ospi.c b/drivers/spi/spi-stm32-ospi.c
index c36df8d3f5cb..f396439e2281 100644
--- a/drivers/spi/spi-stm32-ospi.c
+++ b/drivers/spi/spi-stm32-ospi.c
@@ -150,7 +150,7 @@ static void stm32_ospi_read_fifo(void *val, void __iomem *addr, u8 len)
 		break;
 	case sizeof(u8):
 		*((u8 *)val) = readb_relaxed(addr);
-	};
+	}
 }
 
 static void stm32_ospi_write_fifo(void *val, void __iomem *addr, u8 len)
@@ -164,7 +164,7 @@ static void stm32_ospi_write_fifo(void *val, void __iomem *addr, u8 len)
 		break;
 	case sizeof(u8):
 		writeb_relaxed(*((u8 *)val), addr);
-	};
+	}
 }
 
 static int stm32_ospi_abort(struct stm32_ospi *ospi)
-- 
2.25.1


