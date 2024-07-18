Return-Path: <linux-spi+bounces-3897-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE7D69346E7
	for <lists+linux-spi@lfdr.de>; Thu, 18 Jul 2024 05:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E02DA1C22034
	for <lists+linux-spi@lfdr.de>; Thu, 18 Jul 2024 03:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D4B38F91;
	Thu, 18 Jul 2024 03:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TDwyAmke"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70058481A7;
	Thu, 18 Jul 2024 03:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721274471; cv=none; b=bUKnbUmSt7NiR7TpMrWP7XJanjO3QR54OYHM4cbx6jO95MFEAYxnut/7Hn/0zRMt5ZmU73S8gd4gXKr9L/aLz8MBLN5oPHUg2XX7FWE7zFzLm8xHX0DOZFyurGJ5USPb5QpHr1b0T55eTT4WRnNMDBSTiUA2KNSdcE8W1QT6nVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721274471; c=relaxed/simple;
	bh=F14fWKV1q9X6qHHW9Bq+NyKhnV5NFHLtS1NGnf+0VHE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fWz23ZdItrrdr9FwDxgceu330gShUvNwJ6O+Is5KIWaX9FAruKEUG4qZuw7tAd8kDPm2573Y1Q7tNIYkleR2w2mvNKzR5EIVR+Vj0YjVcE0ylDWQOWo4ffLIjPTIOR+FyGQYDUMwQGixs79FoSF7YmlwdHrY7RuLpMl5fbmcPoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TDwyAmke; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3d93df6b54dso176120b6e.2;
        Wed, 17 Jul 2024 20:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721274469; x=1721879269; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y5/8Zslr1MP/58mqMHISewZsB2/gBp8DHMSTzEl4QGQ=;
        b=TDwyAmke0nfGO8uti90r5FHKwnhtyH3vG3pKGgqYBF2OWwEOE8yzCmi8KYFE7F46qs
         4RLv0u9qsfGvvKqbdi0FkWuVo0ZGjTazLXE1N4FG8ObqO2qmSS6ZMulxn4DVkdqTudtt
         5wyb7JbdGi1zqzseOdA1OPYvgDVZluxN50i7CwJU5OXJyVuT0oZhQ2yrZGr0Mov1fS1Q
         5v3FqnFVSVY7cfjEdbcvpStDYTiR+1McJyZGkJWV7f5MC3h/Wf5DFbq9FxSi1H6pirGQ
         5fvreu4iZqBa7PfAQaDF/J301jGRwCEJUGDf5ErkxF3x5+RXOfZsZeeEA5GkCK/RY5O8
         Br3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721274469; x=1721879269;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y5/8Zslr1MP/58mqMHISewZsB2/gBp8DHMSTzEl4QGQ=;
        b=uAspFxzB8rxNlEej9UMhkg4GsBlm/JoykcfrY1pip6Et/1iCPGM3iyoQ3oY6aJSqFf
         Yzp4Qx57EoffFES44qsS89XkM3hS1PMX6nsFQSJTMFLrtwGp1LrzmkjItI/ewBt0h5SB
         Hb2Dq28tZML6gMHivm3GM1SD7YpRkIkd2WHUt7Pa7O0qhE8Zq5D5ayQDrrSQBxh/DtGC
         2VLb/DVOT2zRp7SEg4GDgeVSzDB5f3HXd0fq9VLc1Oga4ldGfgQm7qAS/UpjKLK1gIoV
         ery8XfgNLz49DWA65cLC+HCqXYS1CkUC9g8Sv1BUpodsZr+nmklmCokJDIhXfJeJQo6I
         a58g==
X-Forwarded-Encrypted: i=1; AJvYcCVkWlqzxPUvVhUPxmc/4eG43Te0QO39286/DyGVyu9cMSxeEgFoVn7knOyOYhU8vc3k/7uEW4i7ivoFcheNVUckTncZWah9/kA6lm/OdnHJnTqRw4JgUnL8hP/MQ4WjjcQPdpVhMKpz
X-Gm-Message-State: AOJu0Yy+MaVCJGO0rB6IlG+kpDw5Jww8Cw3ngGEQRRvDJwBEoa8Ap0u8
	imXMcOR+Br4y2565JFhxfpHrx6ce4ktnoLNoqzNX/Qz9ZRLGCS+3hnrTgg==
X-Google-Smtp-Source: AGHT+IFDF7qxwjD4lvstL6IWj4cD8QTRaRA0qpVS05uPxYjJp1QrxnbuNQ84hOkxLbR9ckqWdNl1uw==
X-Received: by 2002:a05:6808:14d2:b0:3d9:385d:8754 with SMTP id 5614622812f47-3dad77941a9mr2005728b6e.47.1721274469600;
        Wed, 17 Jul 2024 20:47:49 -0700 (PDT)
Received: from twhmp6px (mxsmtp211.mxic.com.tw. [211.75.127.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b7ecc9965sm8940189b3a.199.2024.07.17.20.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 20:47:49 -0700 (PDT)
Received: from hqs-appsw-a2o.mp600.macronix.com (linux-patcher [172.17.236.67])
	by twhmp6px (Postfix) with ESMTPS id D2E46805EF;
	Thu, 18 Jul 2024 11:56:59 +0800 (CST)
From: AlvinZhou <alvinzhou.tw@gmail.com>
To: linux-mtd@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tudor.ambarus@linaro.org,
	pratyush@kernel.org,
	mwalle@kernel.org,
	miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com,
	broonie@kernel.org
Cc: chengminglin@mxic.com.tw,
	leoyu@mxic.com.tw,
	AlvinZhou <alvinzhou@mxic.com.tw>,
	JaimeLiao <jaimeliao@mxic.com.tw>
Subject: [PATCH v9 6/6] mtd: spi-nor: add support for Macronix Octal flash
Date: Thu, 18 Jul 2024 11:46:14 +0800
Message-Id: <20240718034614.484018-7-alvinzhou.tw@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240718034614.484018-1-alvinzhou.tw@gmail.com>
References: <20240718034614.484018-1-alvinzhou.tw@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: AlvinZhou <alvinzhou@mxic.com.tw>

Adding Manufacture ID 0xC2 in last of ID table because of
Octal Flash need manufacturer fixup for enabling/disabling
Octal DTR mode.

Signed-off-by: JaimeLiao <jaimeliao@mxic.com.tw>
Signed-off-by: AlvinZhou <alvinzhou@mxic.com.tw>
---
 drivers/mtd/spi-nor/macronix.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/macronix.c b/drivers/mtd/spi-nor/macronix.c
index f039819a5252..1a8ccebdfe0e 100644
--- a/drivers/mtd/spi-nor/macronix.c
+++ b/drivers/mtd/spi-nor/macronix.c
@@ -200,7 +200,9 @@ static const struct flash_info macronix_nor_parts[] = {
 		.name = "mx25l3255e",
 		.size = SZ_4M,
 		.no_sfdp_flags = SECT_4K,
-	}
+	},
+	/* Need the manufacturer fixups, Keep this last */
+	{ .id = SNOR_ID(0xc2) }
 };
 
 static int macronix_nor_octal_dtr_en(struct spi_nor *nor)
-- 
2.25.1


