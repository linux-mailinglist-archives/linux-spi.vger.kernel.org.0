Return-Path: <linux-spi+bounces-11249-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 66524C6310B
	for <lists+linux-spi@lfdr.de>; Mon, 17 Nov 2025 10:12:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 922C934DF82
	for <lists+linux-spi@lfdr.de>; Mon, 17 Nov 2025 09:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18431325488;
	Mon, 17 Nov 2025 09:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DMAq617t"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D15B32471C
	for <linux-spi@vger.kernel.org>; Mon, 17 Nov 2025 09:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763370375; cv=none; b=K3OFHCI7mFD5ShIhkGBzyHxZdDDumN17FHAHc9rUlg4IYHd9GHm5qmzfruatk4An/ir1PdirB3X1E7NRMP/r2ScGLYwgcIfzHxE/oj1iDu0DNx7AM3hhR+p7THIETi8e4DQSKV6LJOnaG3Cy/yAUAiD7AlQQlA9iHO4SBoB3VWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763370375; c=relaxed/simple;
	bh=hcAuad7b1ccILM/PHJHj5cUkxmyMOCNodizLhyRt8bo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ePAu8Rhuq1eZAWDYcZSvsWz0NeFr+45uaJ91fzjOAvv3rwXf45n5AxW1J8L3pPgJpBW1P1wOXLmmF8LxMRWFWkcmZn65hsjWL5RdcEDCYwRcxh+ihb9GDbVNtirgVKRkk9mhiXdtF1YAaBfXozCdTUzKJm49dAdFeUR1hcWJ8L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DMAq617t; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-bc2abdcfc6fso2341676a12.2
        for <linux-spi@vger.kernel.org>; Mon, 17 Nov 2025 01:06:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763370373; x=1763975173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OMO5ie94w8lcBT6lm38XSRIvwKFLL7hEmJp5CRt+oh8=;
        b=DMAq617t1D4aSFLXuqr9KeOSmMGlPgmpf+6v/5SjwGCeQI/8OJ/AmuXyO35mlUqHk0
         iQIvjjaDDXDspPBkzMk3ZJsd6dPorq8Gf75wbDdixhcmBNNTlioQWifsbaWB0k5bxF3Q
         vhbPjA0g90Iji3co8cYl6CEeIIVE6sCVgyxHNBcAUZnYFG9Z/6FdqXl91X7BAQZNwof0
         E11bygBXZ5zDob91BiYwxz9pBhOKLpi3x6cCn0HP9ggkMcZVZ1X2OuE/mo64+LxZtZPh
         u/sKS9BDUPHKPnm59tENL55FPW15I9xuL7v8EY17LbAjNgKOtkFlUMqDXSvrzMV3Vt9v
         c1nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763370373; x=1763975173;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OMO5ie94w8lcBT6lm38XSRIvwKFLL7hEmJp5CRt+oh8=;
        b=HDxiLsOdVp8+GyCQVXnBweWlc/9bRdaxUKMEe6GYX8zlAhGHy2+zNfdVI+HTKFi7ys
         BI8mJ+j4479vn+9nwPfHokJXyC/32kAiE/7putyrbQIWZqjJ+5W484hRWhELeK5vmJgC
         uukB3+jWrFk8ocbaAPMqrVORfjcNXGxQugDjkMeVXMDia/lo1rbiKGInP5o77J/ET0nL
         k1jlBqiZtQ+uRsFLrD9EEHc91Fgz33cNXL4ebx4GrSdoJkfe+b8frsn+8VQ3BIEdmka+
         ELeq917ChKXvpdl0/ybyykW+wxeqMn8HDLQr7t705T2S8POeQ7p3vfz7p8O/XDozdRIs
         KPBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXteonnFLkBT/6VsDsOa4lof1dvD1PxcKLHvnYX6riHLXuTaeGiPJNMPXdfppMSdh+E8fknGWp8zI0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNjdtDZNwG2Qrm5wFLxm5a10d9kBKSdavlhNmJk3xv7ts4ShKZ
	Kq19cO4vy7TKv8GTt/pi1L7ZSEkKVXFM8btSBKyCugd/lWf52TkUYVH+xwl5Fg==
X-Gm-Gg: ASbGncvWc8WDiESvOBTx8nJi80zc2yVOvkU8bKHxZdlQnepVC7w5qz1xw67DyiPED64
	jIEX4sre26jN9VDrJzsZ9C1e53OC3968rKT9QIX9U3ok8ReiYt/umjLvAcBNW7VlA1OHFWIGHTc
	JHb4Oc2Qu/P6T7t9B67la8ZQfm0Eb8dC9F8KyDaS3OPfKfqUbUmYM9ekvkOc1qBa0R88MyPCmII
	QBoUVrKa+rFBF0Bem/qB1523wqdv3+EFKL3Fe0DVcNK1mPvZIwM1dqK46NImqNMlZKQe+1HZ8ch
	zodZxt9E4SBGec852jG3RmAfpK5EnflL2dWp8IPc4SqtIuqk5nozFBpvbDlTAZNg9jD3uC6i4Lh
	ZlgZjUZzcB2yq3p9DLNFUToSecIkqS4dPVjJMZiNesAD4trM66JuSnl29bC4YGs9+js/ZBkQye2
	vjxiNXsbEjurNG5bs94ukRUPlh7XI=
X-Google-Smtp-Source: AGHT+IF/JU+kMFiIAfX2k1Dm6SWfMM6AyWK7LDvkc6/yQQso64rIW9bWr+iBK9Lwln4yavxaqi7imQ==
X-Received: by 2002:a05:7022:6621:b0:119:e56b:91e6 with SMTP id a92af1059eb24-11b411f0b58mr4788078c88.23.1763370372524;
        Mon, 17 Nov 2025 01:06:12 -0800 (PST)
Received: from localhost.localdomain ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11b06088604sm47916498c88.7.2025.11.17.01.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 01:06:12 -0800 (PST)
From: Longbin Li <looong.bin@gmail.com>
To: Mark Brown <broonie@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>
Cc: Longbin Li <looong.bin@gmail.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sophgo@lists.linux.dev
Subject: [PATCH] spi: sophgo: Fix incorrect use of bus width value macros
Date: Mon, 17 Nov 2025 17:05:39 +0800
Message-ID: <20251117090559.78288-1-looong.bin@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The previous code initialized the 'reg' value with specific bus-width
values (BUS_WIDTH_2_BIT and BUS_WIDTH_4_BIT), which introduces ambiguity.
Replace them with BUS_WIDTH_MASK to express the intention clearly.

Fixes: de16c322eefb ("spi: sophgo: add SG2044 SPI NOR controller driver")
Signed-off-by: Longbin Li <looong.bin@gmail.com>
---
 drivers/spi/spi-sg2044-nor.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-sg2044-nor.c b/drivers/spi/spi-sg2044-nor.c
index af48b1fcda93..37f1cfe10be4 100644
--- a/drivers/spi/spi-sg2044-nor.c
+++ b/drivers/spi/spi-sg2044-nor.c
@@ -42,6 +42,7 @@
 #define SPIFMC_TRAN_CSR_TRAN_MODE_RX		BIT(0)
 #define SPIFMC_TRAN_CSR_TRAN_MODE_TX		BIT(1)
 #define SPIFMC_TRAN_CSR_FAST_MODE		BIT(3)
+#define SPIFMC_TRAN_CSR_BUS_WIDTH_MASK		GENMASK(5, 4)
 #define SPIFMC_TRAN_CSR_BUS_WIDTH_1_BIT		(0x00 << 4)
 #define SPIFMC_TRAN_CSR_BUS_WIDTH_2_BIT		(0x01 << 4)
 #define SPIFMC_TRAN_CSR_BUS_WIDTH_4_BIT		(0x02 << 4)
@@ -122,8 +123,7 @@ static u32 sg2044_spifmc_init_reg(struct sg2044_spifmc *spifmc)
 	reg = readl(spifmc->io_base + SPIFMC_TRAN_CSR);
 	reg &= ~(SPIFMC_TRAN_CSR_TRAN_MODE_MASK |
 		 SPIFMC_TRAN_CSR_FAST_MODE |
-		 SPIFMC_TRAN_CSR_BUS_WIDTH_2_BIT |
-		 SPIFMC_TRAN_CSR_BUS_WIDTH_4_BIT |
+		 SPIFMC_TRAN_CSR_BUS_WIDTH_MASK |
 		 SPIFMC_TRAN_CSR_DMA_EN |
 		 SPIFMC_TRAN_CSR_ADDR_BYTES_MASK |
 		 SPIFMC_TRAN_CSR_WITH_CMD |
--
2.51.2

