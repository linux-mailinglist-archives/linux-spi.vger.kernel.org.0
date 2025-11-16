Return-Path: <linux-spi+bounces-11237-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 75CB2C61206
	for <lists+linux-spi@lfdr.de>; Sun, 16 Nov 2025 10:33:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1498C4E1DAB
	for <lists+linux-spi@lfdr.de>; Sun, 16 Nov 2025 09:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DFBE22FAFD;
	Sun, 16 Nov 2025 09:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TqcPZTcS"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF58A8634C
	for <linux-spi@vger.kernel.org>; Sun, 16 Nov 2025 09:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763285622; cv=none; b=u6Zf2YcU/PLeAnfCkgmkUloRhBYTfZFIp2iRmrUl0fpNLc4r/zpIIR7pHR1iz6FGrFrN7TwTTjMc906o15WTytX4aivq1/2OzLpIO3WhXM4envhpgRl3Ez/ciYGJQfVgJpBvzR2Rkssvhjy9lQ+050JDX1Ecp55l0I4n41VsTJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763285622; c=relaxed/simple;
	bh=/yXKKKKHLLAQFDUQirh98IqOxjGZuB7ZkC9cAWPgZuE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CCsnMpT4lHrlaeawYs2oZrGYRmH7QdOLvCn2anF9dAwTJjupC1VlBTstCENPm2twBOrNnYUVYBS5jZruSh1Qd2WPnNgIdm3U2hgjOVPIhP18iuguvTCA5/yC7Xk3Qp92xPa/sJu9+t4m9L33Ot4J1HGNHWLaiQLaqpGY8F7DMaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TqcPZTcS; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b7373fba6d1so265066666b.3
        for <linux-spi@vger.kernel.org>; Sun, 16 Nov 2025 01:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763285619; x=1763890419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W7K7Zh/4TDUjOsx11sUCPxvPTzeLl/SQbNAQ3wxtwbg=;
        b=TqcPZTcSp7ezteWsJp4MDDUMFsFskZjQlW6nATXnim6aih3O6Opu99sd/UCP4T8uJR
         h73zi1//W6pvof8fWpH6rfYTsi/Jg8XvbbDhONzP5xLsHszws+9LZT/9FKre3w3p1olW
         VcZA/Shvwa7AcBcNgF3ZmQQOi0cycqKvrMaJQwB0ucLLul1P+tuuHG8RbyeuSvHpywgI
         xtGVzXj920CTquTQFsOlhI61diBScR6T3cVSuszZFk+bsSJUCcGCnD8MabgbT3sBFCf5
         CbawzeYFpwDylZRKWXivztYjanbnYUr9YZQehd6/XksU+PxYfeu/CTfRhHkDdAjLI+Ck
         TaDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763285619; x=1763890419;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W7K7Zh/4TDUjOsx11sUCPxvPTzeLl/SQbNAQ3wxtwbg=;
        b=JAQgi17MZy1+HZoL0DYHbErsvC5blUErnkCa8p1f26jY7ZGcRlmiWLdY7FVg1G4sdp
         85UYAxjyHhzw5as34GgdlMbEXoYWZEU5UNbc/xiYSPcgwOxg4YN+4bpcJte83BcwROTm
         vQW/Kb5mDmccCFbloS35skpp6AyoePl+hi4f8NiO48JaqCYjp+77ZXMau4Gz0lPFkwOA
         ZiaZqIHez8ALc/Ya+6YrYb1cX/jG70kJGlwOMmNJXmTlGvzRhrsejw84TW300OBBdxRG
         lLb+4QEt3wcxulxom/YYP3V/TQDCGpDHYg7XyOREZn3tIoD0jQfJbMrJnmug7qbVqrTN
         WqEA==
X-Gm-Message-State: AOJu0Yw4dCZIb2zSeBYC8cHVor1cEEdeQcMGJef+I6fgQ81KeaX3IkOB
	QJ5LabteCPsAwQ0iThivFw8sobm4ChNk+utw4jyzmXYiQBgTsrbSJzeh
X-Gm-Gg: ASbGncsHJ6rq9A+56SA8qD2ZPJZWyQhv/o8jd1m2gRfBdxWKAGY5yWC7k8aebEzWY1x
	t8sdIQYBCPLYaZjsz9+tWkV9iBqQfshUF8v5Z9IG2XMJUkQpxscmJ9MjKFVYcpcmpN4KZh1HTnk
	e0RAP4GPqXU9WdDnBL5dQgAJLukvVbwj1a6D3tcHw/URNFm7sSAMkWbJCzre9Qa6xfF4+O0DfsL
	/VyPGZrza47vCg0ajJHAGG5Pj+DUXyGjhV2jcH8TyxNInBvpr2q8LwcB3Qg/ZP70BVsfjA+sUeS
	F7mpUzK6aRQaN2PyPrvkjuzcwtUWhmczmm1f2etEoHA0EBAnfPSktONeBDE+QeSxyzJ5TtV4V0S
	TBoZB9ynBIagzICKC4b58yj2h5ZZ0Zr1ToEKXKhBIRDp1gySam0zlpm5GZ6+1dLmm62m8LAYLcN
	2+uGxt4ru/+E2FuOl0axdNlYYmwZ+sHbv4fONwHxUSB5XRl1T0ppUXLIiRTkZYORxUAFg=
X-Google-Smtp-Source: AGHT+IF0lzcWcCCr8TRt4S3Qm2DDxa0YSK5/L8zJ8yOcK3dpoxigT/zbrBcPqGjZxlQ7NF4Bl5Klog==
X-Received: by 2002:a17:907:d18:b0:b73:9b4a:5c02 with SMTP id a640c23a62f3a-b739b4a5cb6mr21502266b.49.1763285618980;
        Sun, 16 Nov 2025 01:33:38 -0800 (PST)
Received: from localhost (dslb-002-205-018-238.002.205.pools.vodafone-ip.de. [2.205.18.238])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b734fad3edasm802751466b.17.2025.11.16.01.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Nov 2025 01:33:38 -0800 (PST)
From: Jonas Gorski <jonas.gorski@gmail.com>
To: Mark Brown <broonie@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Tanguy Bouzeloc <tanguy.bouzeloc@efixo.com>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] spi: bcm63xx: drop wrong casts in probe()
Date: Sun, 16 Nov 2025 10:33:34 +0100
Message-ID: <20251116093334.17423-1-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both bs->regs and bs->{rx,tx}_io are tagged __iomem, so we shouldn't
cast them to anything else.

Silences the following sparse warning:

drivers/spi/spi-bcm63xx.c:571:22: warning: cast removes address space '__iomem' of expression
drivers/spi/spi-bcm63xx.c:571:19: warning: incorrect type in assignment (different address spaces)
drivers/spi/spi-bcm63xx.c:571:19:    expected unsigned char [noderef] [usertype] __iomem *tx_io
drivers/spi/spi-bcm63xx.c:571:19:    got unsigned char [usertype] *
drivers/spi/spi-bcm63xx.c:572:22: warning: cast removes address space '__iomem' of expression
drivers/spi/spi-bcm63xx.c:572:19: warning: incorrect type in assignment (different address spaces)
drivers/spi/spi-bcm63xx.c:572:19:    expected unsigned char const [noderef] [usertype] __iomem *rx_io
drivers/spi/spi-bcm63xx.c:572:19:    got unsigned char const [usertype] *

Fixes: b42dfed83d95 ("spi: add Broadcom BCM63xx SPI controller driver")
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 drivers/spi/spi-bcm63xx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-bcm63xx.c b/drivers/spi/spi-bcm63xx.c
index b56210734caa..55db5299d725 100644
--- a/drivers/spi/spi-bcm63xx.c
+++ b/drivers/spi/spi-bcm63xx.c
@@ -568,8 +568,8 @@ static int bcm63xx_spi_probe(struct platform_device *pdev)
 	host->auto_runtime_pm = true;
 	bs->msg_type_shift = bs->reg_offsets[SPI_MSG_TYPE_SHIFT];
 	bs->msg_ctl_width = bs->reg_offsets[SPI_MSG_CTL_WIDTH];
-	bs->tx_io = (u8 *)(bs->regs + bs->reg_offsets[SPI_MSG_DATA]);
-	bs->rx_io = (const u8 *)(bs->regs + bs->reg_offsets[SPI_RX_DATA]);
+	bs->tx_io = bs->regs + bs->reg_offsets[SPI_MSG_DATA];
+	bs->rx_io = bs->regs + bs->reg_offsets[SPI_RX_DATA];
 
 	/* Initialize hardware */
 	ret = clk_prepare_enable(bs->clk);
-- 
2.43.0


