Return-Path: <linux-spi+bounces-11976-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A41ACC5D33
	for <lists+linux-spi@lfdr.de>; Wed, 17 Dec 2025 03:51:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AC2A33010ADC
	for <lists+linux-spi@lfdr.de>; Wed, 17 Dec 2025 02:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B59211706;
	Wed, 17 Dec 2025 02:51:04 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD73B18027;
	Wed, 17 Dec 2025 02:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765939864; cv=none; b=QpkB6X6+nS7d9H9Efzzb1cW+E2MhIwSG2QAk5D5CDQLl5c43lgY4VEhtqBmuw3VRq3iqAexy74LRkJWwEXNWOzS58z4lZASjYyj4kaMH3LMwyehkisCbHCUv0Oa98BMSapO0sUtB86dUAPfykFe2eHHsCK2QYDhUrBV9QuOGrDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765939864; c=relaxed/simple;
	bh=7Rkg3yuMCP7VSzFdSTO3LHDBeQ8KZ8MA1w9hFH9/Xp4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hQXtxxQ9/dGEICEoh79aaTF6D3Evrj1tDXELGjrgsQsSAZCq4XoP9Wve5q+PAJ3HB4jsfbvnAuZ2PU9lQxRu/voO0dA+3cr+nvIOMIBs+d15sWOV40/7bLUE6jDgBbJw5/WM2cuzOv3e4X5dfoIp179hk5Bmp2fQHnQQ7xNEIZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-03 (Coremail) with SMTP id rQCowAAnSuGCGkJpnTb1AA--.10388S2;
	Wed, 17 Dec 2025 10:50:42 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: broonie@kernel.org,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com
Cc: linux-spi@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] spi: stm32-qspi: Remove unneeded semicolon
Date: Wed, 17 Dec 2025 10:37:21 +0800
Message-Id: <20251217023721.1684244-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAAnSuGCGkJpnTb1AA--.10388S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZFWDuF4rXw4DXw43Gw18uFg_yoWDJwc_CF
	1DGr1Ik34qkryDt3W7KryrJr9xZa1DXanYqrs2qFZ8A3yDX3WUu3y8ZFnrXw47Zw4qka97
	C3ZrXw1ayr13KjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbs8FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r1q
	6r43MxkIecxEwVAFwVW8JwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8Jw
	C20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAF
	wI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjx
	v20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2
	jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43
	ZEXa7VUbLFxUUUUUU==
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

Remove unnecessary semicolons reported by Coccinelle/coccicheck and the
semantic patch at scripts/coccinelle/misc/semicolon.cocci.

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 drivers/spi/spi-stm32-qspi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-stm32-qspi.c b/drivers/spi/spi-stm32-qspi.c
index 2a0ee96786fa..d1df66875809 100644
--- a/drivers/spi/spi-stm32-qspi.c
+++ b/drivers/spi/spi-stm32-qspi.c
@@ -153,7 +153,7 @@ static void stm32_qspi_read_fifo(void *val, void __iomem *addr, u8 len)
 		break;
 	case sizeof(u8):
 		*((u8 *)val) = readb_relaxed(addr);
-	};
+	}
 }
 
 static void stm32_qspi_write_fifo(void *val, void __iomem *addr, u8 len)
@@ -167,7 +167,7 @@ static void stm32_qspi_write_fifo(void *val, void __iomem *addr, u8 len)
 		break;
 	case sizeof(u8):
 		writeb_relaxed(*((u8 *)val), addr);
-	};
+	}
 }
 
 static int stm32_qspi_tx_poll(struct stm32_qspi *qspi,
-- 
2.25.1


