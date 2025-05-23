Return-Path: <linux-spi+bounces-8267-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16BDFAC218F
	for <lists+linux-spi@lfdr.de>; Fri, 23 May 2025 12:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE1554E1870
	for <lists+linux-spi@lfdr.de>; Fri, 23 May 2025 10:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD7E22A814;
	Fri, 23 May 2025 10:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ULCDcBTB"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E3622A7F9;
	Fri, 23 May 2025 10:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747997712; cv=none; b=VKXHIE3mY77frndTA1Emnuo6Z0Lns2HBLfbflu3bxv7O/y0audjs+Nctx/YlcGGSqkoroHr9oXHXJyVXQoZPhfimg2ylQC1nTVK+26Mu0Jsvqx9L2kxl6yjpe5oUd0R26/hOTQ3KezYmGAQdz7s2/TpSuhlGEEIiVDlMyrEM0GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747997712; c=relaxed/simple;
	bh=wrfl3Lk72HbCltyE08DEiiUBoQE22JPWb7p1k6l72Jw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ROesFm9aKAfr8b6yUeWUu7OOW4BM9nFcI15efLvxSj43b4vWpDr9aFSk6P7c9r4S5RKR4WOGXACB14SvOy3gKCXTlaVjC/HwE22rgLnSRhQxeDQno7uEpD35NpgCD/Kz269Fz0uDIhM2tYVaDaWcDiomhN2EDZH7x+UPFYJCF8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ULCDcBTB; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7426c44e014so8638648b3a.3;
        Fri, 23 May 2025 03:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747997710; x=1748602510; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Af/z8wwyeFXwEhzwxCix9R1kShAhXfBPAEq0I6jGtUU=;
        b=ULCDcBTBvlOzBXQyvAX/qy5O+33XPlSTPJgYN0gpPbI0M3xVokTINEan9hgqMqmtQm
         MP20sj9apEQ0rXjI6rfg0huAS0NCq2DxBJwY3rug7Z1d5xUbs7FyPHSGS+jskyg7PInv
         FERP2NojwuiQ6dD02xZ8VlnKxz8psmoEA/5+SIHxQzOOO90XmXplxjiZtU8emDSnMskq
         UvZK2N+a+YrZ+4pKYhUsSmlD813lZvLvNeQZraZR+Mz2vm29EBUc+IeEX6nVYOdEHpaO
         mq/z8lj4hSYBUd5JpDdMdNUAypaUdXQPhiDVUBfAJEFr2H8Mwr1OjjDwCljkn9sIO99K
         cfTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747997710; x=1748602510;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Af/z8wwyeFXwEhzwxCix9R1kShAhXfBPAEq0I6jGtUU=;
        b=IUpvj9u1b23Q5KyQ7pkb+c7lJ2Kka5PeMA9yjvTZMcigujsvYb3E7+nRPC7xR9UkLQ
         g+eGhft4X7wj8Ab8A7M5ZJHJI/8DRKhwEUXxmz5Dbv2P3wxPQyhPrVzY8aYchlN1ZuOb
         haalypv5sYpjAhTW9tRcaXL3l6jZm2pcJXHZie3UWNpWcQ5T68+8sjAal6iyzUqcpyBO
         9OaispL4XuYY5bfP1g4Qz/6D3AH8qXCJv07PJyvz7K8/O3aIpv9aensn7BJ1nSqshxxB
         iLdfJBBHqh3cFl1gtpVfWVE9aWkLjwX/rybrRUj/ZWsNwQPs7KiWA2QOJxmQDPD3/Y43
         N/EQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSBy7ITvIn9HB/N2bOcKWo4fQQR6GSJdisGtBqZc+/x/rlJIySt66IIA/yftb3XG1QHu6VrpuoLvED@vger.kernel.org, AJvYcCVo8RzL2FGK/uASNXCFWGe70I9lPlRlN/vtz245x7G7bM206ae5FBOjRyXShM2JdNgJKmNnSqjZyFk46Arq@vger.kernel.org, AJvYcCWc68FFDCwbNQP0wuS3mVbxbHHAfmR77sPatip2ddwoPRS92xtxgHBXdvUKr89U8ujwsBhLZHNbl7E+@vger.kernel.org
X-Gm-Message-State: AOJu0YySWMVnwTAomr8V8+WgRB0WE6PtYwUvDfDrzSXaFzZ+G83RK+24
	0Y/QIDZFYJlPAuMo5g6NT3WZ2HRePUXd8M2UYcTBtu+HXfEhP0ajEqll
X-Gm-Gg: ASbGncslDn4DXSJqGhl38w01kLxYjmDF+HOSsiaUlUwRrpZF+2BIZ8CMPXCl4Rn7VfP
	E8PJke4ua2rGYCau3z82lCDbubWgkqJmqvvtP4Eye1lCTtZ0poRy/3c3mnqHWnABmgOG7NN9Vl1
	ufjX5MtzIr+hsvigmv+D5qTbRZy1ibKHwm5DdYdtookGj54EkUWMpjhhmmWhVdZ+Dd9VY5MypMy
	Fk2+H3m1FaQhMzDdXGQAjOFLKw9KoXrTNvtI7NtChNOXC1Vg+4BH+hJZdx+qCIjxoqTJU3oweOT
	W7GDbqxp5skAKHHsbtT4v5spXy4VRtfJm/bNbaE0ygC0emc2jt2icw==
X-Google-Smtp-Source: AGHT+IGI5aXReklpV2gCBTwNnneLjIs6n0VThj40N2VQD3R5/p0nmLA2VAhcsgNJkaCXO4niO0rEVA==
X-Received: by 2002:a05:6a00:4606:b0:736:7270:4d18 with SMTP id d2e1a72fcca58-742a9803dc5mr35780529b3a.14.1747997709877;
        Fri, 23 May 2025 03:55:09 -0700 (PDT)
Received: from [127.0.0.1] ([2001:250:5800:1000::3fc8])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a9739cdesm12623687b3a.82.2025.05.23.03.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 03:55:09 -0700 (PDT)
From: Zixian Zeng <sycamoremoon376@gmail.com>
Date: Fri, 23 May 2025 18:54:50 +0800
Subject: [PATCH 2/3] mtd: spi-nor: Add GD25LB512ME GigaDevice flash_info
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250523-sfg-spifmc-v1-2-4cf16cf3fd2a@gmail.com>
References: <20250523-sfg-spifmc-v1-0-4cf16cf3fd2a@gmail.com>
In-Reply-To: <20250523-sfg-spifmc-v1-0-4cf16cf3fd2a@gmail.com>
To: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Longbin Li <looong.bin@gmail.com>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 sophgo@lists.linux.dev, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 dlan@gentoo.org, ziyao@disroot.org, Zixian Zeng <sycamoremoon376@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747997691; l=1434;
 i=sycamoremoon376@gmail.com; s=20250113; h=from:subject:message-id;
 bh=wrfl3Lk72HbCltyE08DEiiUBoQE22JPWb7p1k6l72Jw=;
 b=hEwSLbpfM82rWJyMwosPQxvp3UoOlvxmIw3Db3NJlc83C7FuL8x91nrHYfnh2aHM1+AdkmrJL
 in29ql7OAPmCqgpQ3hK85RbC3cC8OF8MyPFP4WKiB+/WzK2VR/TadCn
X-Developer-Key: i=sycamoremoon376@gmail.com; a=ed25519;
 pk=OYfH6Z2Nx3aU1r0UZdvhskmddV6KC6V1nyFjsQQt4J8=

Add GD25LB512ME SPI-NOR flash information

Signed-off-by: Zixian Zeng <sycamoremoon376@gmail.com>
---
 drivers/mtd/spi-nor/gigadevice.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/mtd/spi-nor/gigadevice.c b/drivers/mtd/spi-nor/gigadevice.c
index ef1edd0add70e6ca501620798a779d621d6bb00d..223b2f598ecd651ce8df6789dfbaf938c534f94f 100644
--- a/drivers/mtd/spi-nor/gigadevice.c
+++ b/drivers/mtd/spi-nor/gigadevice.c
@@ -33,6 +33,15 @@ static const struct spi_nor_fixups gd25q256_fixups = {
 	.post_bfpt = gd25q256_post_bfpt,
 };
 
+static void gd25lb512me_default_init(struct spi_nor *nor)
+{
+	nor->params->quad_enable = spi_nor_sr1_bit6_quad_enable;
+}
+
+static const struct spi_nor_fixups gd25lb512me_fixups = {
+	.default_init = gd25lb512me_default_init,
+};
+
 static const struct flash_info gigadevice_nor_parts[] = {
 	{
 		.id = SNOR_ID(0xc8, 0x40, 0x15),
@@ -82,6 +91,14 @@ static const struct flash_info gigadevice_nor_parts[] = {
 		.size = SZ_16M,
 		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB,
 		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+	}, {
+		.id = SNOR_ID(0xc8, 0x67, 0x1a),
+		.name = "gd25lb512me",
+		.size = SZ_64M,
+		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_QUAD_READ,
+		.fixups = &gd25lb512me_fixups,
+		.fixup_flags = SPI_NOR_4B_OPCODES,
 	},
 };
 

-- 
2.49.0


