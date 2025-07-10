Return-Path: <linux-spi+bounces-9083-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73AF8AFF83F
	for <lists+linux-spi@lfdr.de>; Thu, 10 Jul 2025 06:51:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37FB03A64C8
	for <lists+linux-spi@lfdr.de>; Thu, 10 Jul 2025 04:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F91A283C9C;
	Thu, 10 Jul 2025 04:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="noUbbotQ"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4FB86334;
	Thu, 10 Jul 2025 04:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752123068; cv=none; b=Eh5xTg+HyZOx0ixXV4FCnaeSzqzWzwmEPcmR6AdADTrEJ4JgQ4bTW7h+vjheQmhPu66vjN7PhxZwnMJNEdLatfCDGI+YJrni4R/ijVTigw4ST2T96OKlDVeArTOQ92djzNJa/4sb563Rk90Kz9V/efyKX1Nw6lStpK7c5CHnUaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752123068; c=relaxed/simple;
	bh=51Oh8/ZWFHnzqPSniwuS6VMjT12ndyM8OFFbzrYGjAw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jN20FjLgGr29ZwnMDwKvCohbwKp1mlvSZWE3HES2yV2cH6QEJcYfdJ+DU0F/uedrrG8F7Uunf6LU8izXaccldn3F1lbDu3xBp0T1KYN9dbdX7EgJeO35wOuHaFWJF0pfjpoM8iQ3dz765nUsbS4usv6vJe/I9bcQFR3vfPNmQt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=noUbbotQ; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b391ca6146eso585581a12.3;
        Wed, 09 Jul 2025 21:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752123066; x=1752727866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qo/cY1BhsRPObvTFNkP36pI9mVlSPrkm/t9jXMFZOw4=;
        b=noUbbotQLk74oqjfhfHXhFsczVKoSmSfK8dMsHeNr2sJ5sQv+EYHF52bNExpTyUf6i
         pLOeOeo/Pd6pU4WkerP5UOXG7NfJ9UWo5OglvjyfC9rssqwflZi6WRpJv3GijyHjypCH
         lAhaAKvFZXXVHSc5FGeCojXAk1cpOljd1xkvX09ZwqdPylBB/ourukf9KqWzQusrgqIa
         L/U4koWiYSncJxFj8iXfPeoOX3rki8ylVr7pDEZ+U79Xw+nL7OLfPdde15I00kC9g6X1
         7ouwG7HgsaUuiM09msQbzlcqk6h1zannxyPvcjg2MZai1kkhmsWoTbVqd4yThpmjkouO
         y5mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752123066; x=1752727866;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qo/cY1BhsRPObvTFNkP36pI9mVlSPrkm/t9jXMFZOw4=;
        b=m/GdJNIuCO9MIzh+ES1jnt6kiNkPPwrWBxg97Kx/ye7sn1qSA/PBOwGFUF/SOqe0SD
         Cl/R5yP5H4DmcptIZU2tZBe8YZ7+yO6O4IZ/1bTq619WwDj5M4awwsYVnRNWRlIJVqWN
         R55iQ9rcNFLP6TOYPUwl9WtDOyMJ7ELHplQT/TSsJLk1YHonC8R1Iw3Ch+uBID8HiYUo
         LfqHym3h8cYX8LbsSXdsvdh4dOUXkh0ZFw/OkcCKYxuucBxvx/zFp4Vz6kizTxIcklTd
         Ml1HzJOfBwpvpOkh6ZIH3oYt4jl+MWmE0YSmDLnusCOpWVc6cr7v/4cVG0DRPBiTgHGD
         N38Q==
X-Forwarded-Encrypted: i=1; AJvYcCWChEWwDQRexB8bubHUKR5MxlftboufUr9qkCO9yQTykUZRRRBqYnzJuX1pdx0UTBYyUX7pll2M/qDy1fE=@vger.kernel.org, AJvYcCXxVC/jEvsi0onuN1CTcqsmUbXL5Jwh3LQ7ftIMIcZJkkXFBLG+FyZDjqCoBPognId8n0toB6SOFr7W@vger.kernel.org
X-Gm-Message-State: AOJu0YzujwOlD6yI8S1Ag8FxCnwkp+P0my6pYlH8uEHeWZSSAiQ0sVzV
	+cvOy7tds/4xM5oVbzLMJAmCW+AlCMswmzACxbIDKRzDJqkbmAx9I+ws
X-Gm-Gg: ASbGncvjcymQwG76jU8SchPJhv8faiw8pm8dNNi61BoyF19y1Y3aVZIwTPyPWpGlGle
	u7wFLViy1QieL8nNBFPp9VqAyd1LE4AhiVZYfojKTydEVOugr7W7/NIO4o/qLDK6dZPzfcNg4BS
	DrNpPmYlyKA7Bg6N9aMgEkFe4eYKmz/9zNKNCM9SqE/MRSzk5grd9Y1T62OIxZb04It8oaiGH04
	r/O+/gjqdsLhDNhREtClrQLTUuKWi/JGZyHS15p18ETPv5XjAyoixn4daTrRNV2cUAZ+FEPRKz5
	Kfau+5DYJP4wUB2kleK29ZEI3iAcxNz2MQN0aXdWUwkux7XI62Gdb1r/vb5NThfFk2KNiU3i1sc
	MfDpgpyuC/CrWudr4fQXBdkRpzK5MaKP+ORRLp4jYsg==
X-Google-Smtp-Source: AGHT+IE9r99eJR3/RVCg4fjK8SPPymUKcSjxR/TwtQQOqNbDk6Zql1wagKZDicCE7BWBhqhlWueunQ==
X-Received: by 2002:a05:6a21:400d:b0:220:103c:436c with SMTP id adf61e73a8af0-22cd846ff82mr10327600637.24.1752123065546;
        Wed, 09 Jul 2025 21:51:05 -0700 (PDT)
Received: from SIQOL-WIN-0002-DARSHAN.localdomain ([122.182.200.240])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f1b355sm771458b3a.80.2025.07.09.21.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 21:51:05 -0700 (PDT)
From: Darshan Rathod <darshanrathod475@gmail.com>
To: broonie@kernel.org,
	michal.simek@amd.com,
	linux-spi@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Darshan Rathod <darshanrathod475@gmail.com>
Subject: [PATCH] spi: xilinx: Fix block comment style and minor cleanups
Date: Thu, 10 Jul 2025 04:50:57 +0000
Message-ID: <20250710045058.1325-1-darshanrathod475@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch fixes block comment style issues and minor code cleanups as reported by checkpatch.pl.

Signed-off-by: Darshan Rathod <darshanrathod475@gmail.com>
---
 drivers/spi/spi-xilinx.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-xilinx.c b/drivers/spi/spi-xilinx.c
index ded709b2b459..d59cc8a18484 100644
--- a/drivers/spi/spi-xilinx.c
+++ b/drivers/spi/spi-xilinx.c
@@ -89,8 +89,8 @@ struct xilinx_spi {
 	u8 bytes_per_word;
 	int buffer_size;	/* buffer size in words */
 	u32 cs_inactive;	/* Level of the CS pins when inactive*/
-	unsigned int (*read_fn)(void __iomem *);
-	void (*write_fn)(u32, void __iomem *);
+	unsigned int (*read_fn)(void __iomem *addr);
+	void (*write_fn)(u32 val, void __iomem *addr);
 };
 
 static void xspi_write32(u32 val, void __iomem *addr)
@@ -251,6 +251,7 @@ static int xilinx_spi_txrx_bufs(struct spi_device *spi, struct spi_transfer *t)
 	if (xspi->irq >= 0 &&
 	    (xspi->force_irq || remaining_words > xspi->buffer_size)) {
 		u32 isr;
+
 		use_irq = true;
 		/* Inhibit irq to avoid spurious irqs on tx_empty*/
 		cr = xspi->read_fn(xspi->regs + XSPI_CR_OFFSET);
-- 
2.43.0


