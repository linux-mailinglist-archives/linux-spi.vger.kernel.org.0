Return-Path: <linux-spi+bounces-5004-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE070987595
	for <lists+linux-spi@lfdr.de>; Thu, 26 Sep 2024 16:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A8501C25A67
	for <lists+linux-spi@lfdr.de>; Thu, 26 Sep 2024 14:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7BDD15B0EB;
	Thu, 26 Sep 2024 14:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G00fykmy"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53720152E0C;
	Thu, 26 Sep 2024 14:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727360721; cv=none; b=F6mVA2852MeTzANHUpGp8hQ4fOkYkn7x+FpyeJr8qQ6vBeI8KWpuPzhmuA/n0v6cVY8BTpEMD5bfdqGO4G/ZvSXPD0bPqFdIvEyY+0zGxMehW8VGL8fUalk4c2Nb2D/5hIgjaxP7DEyaOKz19/xl1ZYXd2zwJ9DKhLJiU5/8Jnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727360721; c=relaxed/simple;
	bh=GXeltH6QBHAXEDPRsJkkeR5rr+zPIaXydtKS+kLZsYE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Zl80zfh7Xd418UQzlrZReu6piAgIwYEb37R39Zn/RZfvbXE8uBe56GqwnDpbbb4lpAJJEk4NMujBamEsPbwFiSxe13/716U3oU2EsvS3v7LBN3HdvggrZ19TwJk1Yqnb9vBeG9Uvk5BFuCRy9ETWKO7BQoT3oi8t6MDPRSA6y70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G00fykmy; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7db4c1a54easo624544a12.1;
        Thu, 26 Sep 2024 07:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727360720; x=1727965520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LbPIZJpcVIEhpHEVG/j37aleyqQqnMhNui3ve62e6y8=;
        b=G00fykmyOT0MtlUdvq2FGZnVwnoAMpM6//5+kq73CwWROmlIwizcezhaRUHLZJW6Wy
         pgxQJbKr07ppevMVWAJW7ZCN8GNSrTY+wo9CBiP3A6/6UyB9rqccBG0BZayR563g88Zq
         +OEyCQou2tkIi1x/rAJfXfN2/1eowxh2BTuW7MUAmNHCqoWO9VZX0se7n7hgFPuBrcbv
         +AxlmFRmIzvWVPM3cqsc3GsONlTZWlyQc7mz6RqgjsXqAXBOnQ2ROKErSuDD67nmNtD1
         eVL1z8PQANkkMVsq0A9IUU1lOUMliyaGJmI36OmyXn+EPNg0Nb2nebMrGa7bEbyCMkzo
         lDkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727360720; x=1727965520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LbPIZJpcVIEhpHEVG/j37aleyqQqnMhNui3ve62e6y8=;
        b=HW4kxP+jvUk1yOVoLOC6WMXqH4noz5yPUs7P9Pp/lfLIPhdM0KmcIWIb9m/CvaqMIr
         JmHhYbxnm71fzBc+v6cxBcMt35x2RpcEl+yEtiQpinFsd1YUjAQbdRujDcCeG6mIaUns
         /jEFVDgtPthti8nGqzrjJeNJPEgwffQjwtzKaMtsFGshrQ/fmU3FmCB67isw5Xcn/OrI
         Q1fN8W/ZOqmIELtjp7pw0KgBcrPDSNO9x4/72xtggITdRzsQQfhGEfM+3JsrUNhgAFyB
         FvnQbjLCJaVwmg1WHKum5lgQZB3HlS6CyeE557OBgQrVqS7oOObJgEWFK9NlBmEKw+XY
         wJsw==
X-Forwarded-Encrypted: i=1; AJvYcCUWGR6xdhPWW8ob/iWUUSgj0OzQQniYqWrZgw4OAoZYnE9ilmm4Zp9mr4O0gstd6tlWuzmofOwH3HaO@vger.kernel.org, AJvYcCVLvdakpnNcM9AockxmBaJ1OQga9E9ja25AHxW4wi/MgKXlAk5bMTLhMV+mNuUh4TbNkdcfkyN1rRzbKFY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQuFZsDZAnEA+tDUvLnmX6gn/UvBsmTf1EZpddr8rgeX8ydRle
	74na2LSNJrjKu09WuuyibS6SLrVvabueslUW1dlnJQahYVzJyN0g
X-Google-Smtp-Source: AGHT+IHisqnk7KIiPORJnFsqOHN+dwrtS5lGQysFzmZKGyTwiAq/CDdvSpjHomonSIfnNNGUcrdOyg==
X-Received: by 2002:a17:90b:3e82:b0:2d8:dd14:79ed with SMTP id 98e67ed59e1d1-2e06afbe5c7mr7237287a91.31.1727360719702;
        Thu, 26 Sep 2024 07:25:19 -0700 (PDT)
Received: from twhmp6px (mxsmtp211.mxic.com.tw. [211.75.127.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e085341490sm2751779a91.21.2024.09.26.07.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 07:25:19 -0700 (PDT)
Received: from hqs-appsw-a2o.mp600.macronix.com (linux-patcher [172.17.236.67])
	by twhmp6px (Postfix) with ESMTPS id CB751802C9;
	Thu, 26 Sep 2024 22:33:06 +0800 (CST)
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
Subject: [PATCH v10 6/6] mtd: spi-nor: add support for Macronix Octal flash
Date: Thu, 26 Sep 2024 22:19:56 +0800
Message-Id: <20240926141956.2386374-7-alvinzhou.tw@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240926141956.2386374-1-alvinzhou.tw@gmail.com>
References: <20240926141956.2386374-1-alvinzhou.tw@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: AlvinZhou <alvinzhou@mxic.com.tw>

Adding manufacturer ID 0xC2 at the end of ID table
to allow manufacturer fixup to be applied for any
Macronix flashes instead of needing to list each
flash ID in the ID table.

Such as macronix_nor_set_octal_dtr function in the
manufacturer fixup can be applied to any Macronix
Octal Flashes without the need to add the specific
ID in the ID table.

Suggested-by: Michael Walle <mwalle@kernel.org>
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


