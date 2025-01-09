Return-Path: <linux-spi+bounces-6260-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96CD7A06EF1
	for <lists+linux-spi@lfdr.de>; Thu,  9 Jan 2025 08:20:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F9D11888E3C
	for <lists+linux-spi@lfdr.de>; Thu,  9 Jan 2025 07:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1362201039;
	Thu,  9 Jan 2025 07:20:05 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78DF37160;
	Thu,  9 Jan 2025 07:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736407205; cv=none; b=pD9TNkpvh2IAOYQ1DV+qegQM5mMI4+hyCHw2lcDpbYwpQAN6TRb+Ece0Zejze/CyTo4YlCBQVMeNzabHonRpE9WdApSpLYyH60ccyU0g9XEKg0YLokl1et+dPQUwO0u5PqMXsJnY9uGKwshmxxeQyFc//4EZBvir7PgHAm5au6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736407205; c=relaxed/simple;
	bh=XZ+TmCmIoTk93QwY0Hm3NJ2mY6ezenPMduW2uK/ZBAc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UTwhPZcH2vXhtzZfwrJ28gbAjFwgcuC7jH2eOHG4oHaDy4e3SKaJZbLo/TkAKtvhwJNMwknMkD0GZD8JUb4l+0VmFyUzoURK+skvU+V/VwVeNCtMrAEgKNOwRvljJrvbRNRyBWiDXsl1RA0EroQ/n3fkmE/cN71lsLWo2J5HDjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4YTFnw6LVJz9sRs;
	Thu,  9 Jan 2025 07:52:04 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2h3jIhsljL5N; Thu,  9 Jan 2025 07:52:04 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4YTFnm5G9Pz9sSq;
	Thu,  9 Jan 2025 07:51:56 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id A34EA8B783;
	Thu,  9 Jan 2025 07:51:56 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id M-S0U1JqzR4O; Thu,  9 Jan 2025 07:51:56 +0100 (CET)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 4F7EA8B768;
	Thu,  9 Jan 2025 07:51:56 +0100 (CET)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Mark Brown <broonie@kernel.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-spi@vger.kernel.org
Subject: [PATCH] spi: fsl-spi: Remove display of virtual address
Date: Thu,  9 Jan 2025 07:51:45 +0100
Message-ID: <8a37a960ff084dfdb9233849c00714e9317ae6a5.1736405336.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736405504; l=917; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=XZ+TmCmIoTk93QwY0Hm3NJ2mY6ezenPMduW2uK/ZBAc=; b=YusKL3SFI3figWCbegHgaqV7ZBjGdUqRWCKXEvhTmrtQCognm2r22fC3dzoqhSUdfjN6Rz10C HmjjixNnzgzAmAqT6no73LmwOyv4G/NT+Fu0KH1PLgrlV5JxYvQrEFx
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

The following appears in kernel log at boot:

	fsl_spi b01004c0.spi: at 0x(ptrval) (irq = 51), QE mode

This is useless, so remove the display of that virtual address and
display the MMIO address instead, just like serial core does.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 drivers/spi/spi-fsl-spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-spi.c b/drivers/spi/spi-fsl-spi.c
index 856a4a9def66..2f2082652a1a 100644
--- a/drivers/spi/spi-fsl-spi.c
+++ b/drivers/spi/spi-fsl-spi.c
@@ -618,7 +618,7 @@ static struct spi_controller *fsl_spi_probe(struct device *dev,
 	if (ret < 0)
 		goto err_probe;
 
-	dev_info(dev, "at 0x%p (irq = %d), %s mode\n", reg_base,
+	dev_info(dev, "at MMIO %pa (irq = %d), %s mode\n", &mem->start,
 		 mpc8xxx_spi->irq, mpc8xxx_spi_strmode(mpc8xxx_spi->flags));
 
 	return host;
-- 
2.47.0


