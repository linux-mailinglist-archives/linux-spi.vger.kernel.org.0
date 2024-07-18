Return-Path: <linux-spi+bounces-3892-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB279346DD
	for <lists+linux-spi@lfdr.de>; Thu, 18 Jul 2024 05:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD1092825AB
	for <lists+linux-spi@lfdr.de>; Thu, 18 Jul 2024 03:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9571A34CD8;
	Thu, 18 Jul 2024 03:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="exhHyYCl"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AE23D552;
	Thu, 18 Jul 2024 03:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721274466; cv=none; b=kBORXxZtbDZW/7xZQlVzDMRH2iDu1EfgJFCAirUM1yG2uKYepxikQV9GXZQ3GzM82Ybs/83XcaNOc3iVWX1O3Kyqa3++VTTvMtJczqmTQf+6uDQpKajueMp/sAA6yF0bkD88rFn40+FUsP/sk1Wl+B3+SwdzRWhUF4g2xcDLrio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721274466; c=relaxed/simple;
	bh=eFgwPU4n6/5dAs1L0wyfm9M3VthlXX1XC4xbvigP2tE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t6c2hII+53p/CeYEdMj+P6sBkComBGXWhu3ITq2NNij13mQtxIaIjQKIKcJmcKgSPw16KR8swzIvosfJVIdOX7NyXfSLBwH0ImGXN2AoBZEy1vZWKo/X9Ml04MNRiPQbeo7gOfAGVjWW+/3kYnXSq0ySjDcnjF1zOJadmr0g/js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=exhHyYCl; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-70b2421471aso208248a12.0;
        Wed, 17 Jul 2024 20:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721274464; x=1721879264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pzLxElrWQ9zwK7gS/JxRiE2f82xa98E1x4NzX0Ply7k=;
        b=exhHyYClF18v+xJW+6m3T/zAwIc9kEhrYxjj8KG7xTeNhT5gqjDE5VpeG13ACthxhS
         9FTfddM2boI2f1xGOb3WxrXvYPKmiZPAFgaE2ywfJY89rB8CAYFxceIJDaQz8rmje8O6
         COvUrIjBWJC/m4oDA+9Ohqk/fwaDGfaAvpmGtGZn1SljdeykdfTSUY5WovnCLrt+x74S
         BIUipdykaiQeI/mMl27TPfQSdE68Tzvun3wKnuiO3Wlyz6QkJYh1thc2v0uj4au7Ei+y
         IEkCeEnXDPlf0SYBHmrTebs6qakZ26RGY982lcckSPjo4/bXn5H0VmCxej91rTAuYXxX
         HYbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721274464; x=1721879264;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pzLxElrWQ9zwK7gS/JxRiE2f82xa98E1x4NzX0Ply7k=;
        b=MII/kmvloZlmOYcMRDEmNMXIQ5wXaYJg99rSdYNL+rFodvoBOWPLlY1NPAROUGXqam
         R1NXCLo3vg0K4M+bITCHI6ttjLi+jIJYBYpmOBZPM201YFq5iDX+2cIPpJ3dWiqB5dkK
         BcIkAEHdLxn/lGNkPiCbTMo8UQrOvCAjJDEy4Rf0RGWiBOXeyYwVVJIAnSutzsQwz/zM
         WRHjOxVR6oaDZ+McQrvF4O/+aAHjcFG2WSLrooZCGCSBzskudes/+WI1T5tU5EtNd/i+
         E/pE1BmRvf1eKf/xaZpcYM3U0g2H7A5GCeeS0lROJth2q8gwyyH4xf4jXSSab47ccA8Q
         jp2A==
X-Forwarded-Encrypted: i=1; AJvYcCW2554AfDG2s2ZM070VJiNXIlFabbF5w6cfgGdWGVvmsuN78yfM/ljZmf+dSRaZk4IregnMvJYwjcr3qEh9AF6lLJe1B8fbLJE8louVPd3QsCWtPPPLGzq8R8OuhMGLJlW+BFQm/JcQ
X-Gm-Message-State: AOJu0Yx11X1IEMHV7ddOkMcEPvjQlC+N5+TpzFNmN2FXjYKX6Eg2sVw4
	KG5L0S7bHLOYLV2RHdi7ZpJBpXiSwk4GRsKM65kfUhjAcW+QnzKm
X-Google-Smtp-Source: AGHT+IFr1OWqAhW4l4NG6tilVdQj6eglU6t3bObxxl3lVgpLLrts4FrIjsoB2bkVwVjv0ARFggj79A==
X-Received: by 2002:a05:6a21:78a2:b0:1c0:f0be:1536 with SMTP id adf61e73a8af0-1c3fddb3cadmr4714398637.40.1721274464165;
        Wed, 17 Jul 2024 20:47:44 -0700 (PDT)
Received: from twhmp6px (mxsmtp211.mxic.com.tw. [211.75.127.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc265f9cccsm62394835ad.66.2024.07.17.20.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 20:47:43 -0700 (PDT)
Received: from hqs-appsw-a2o.mp600.macronix.com (linux-patcher [172.17.236.67])
	by twhmp6px (Postfix) with ESMTPS id 65583800D3;
	Thu, 18 Jul 2024 11:56:55 +0800 (CST)
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
Subject: [PATCH v9 1/6] mtd: spi-nor: add Octal DTR support for Macronix flash
Date: Thu, 18 Jul 2024 11:46:09 +0800
Message-Id: <20240718034614.484018-2-alvinzhou.tw@gmail.com>
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

Create Macronix specify method for enable Octal DTR mode and
set 20 dummy cycles to allow running at the maximum supported
frequency for Macronix Octal flash.

Use number of dummy cycles which is parse by SFDP then convert
it to bit pattern and set in CR2 register.
Set CR2 register for enable octal DTR mode.

Use Read ID to confirm that enabling/diabling octal DTR mode
was successful.

Macronix ID format is A-A-B-B-C-C in octal DTR mode.
To ensure the successful enablement of octal DTR mode, confirm
that the 6-byte data is entirely correct.

Co-developed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Signed-off-by: JaimeLiao <jaimeliao@mxic.com.tw>
Signed-off-by: AlvinZhou <alvinzhou@mxic.com.tw>
---
 drivers/mtd/spi-nor/macronix.c | 91 ++++++++++++++++++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/drivers/mtd/spi-nor/macronix.c b/drivers/mtd/spi-nor/macronix.c
index ea6be95e75a5..f039819a5252 100644
--- a/drivers/mtd/spi-nor/macronix.c
+++ b/drivers/mtd/spi-nor/macronix.c
@@ -8,6 +8,24 @@
 
 #include "core.h"
 
+#define MXIC_NOR_OP_RD_CR2	0x71		/* Read configuration register 2 opcode */
+#define MXIC_NOR_OP_WR_CR2	0x72		/* Write configuration register 2 opcode */
+#define MXIC_NOR_ADDR_CR2_MODE	0x00000000	/* CR2 address for setting spi/sopi/dopi mode */
+#define MXIC_NOR_ADDR_CR2_DC	0x00000300	/* CR2 address for setting dummy cycles */
+#define MXIC_NOR_REG_DOPI_EN	0x2		/* Enable Octal DTR */
+#define MXIC_NOR_REG_SPI_EN	0x0		/* Enable SPI */
+
+/* Convert dummy cycles to bit pattern */
+#define MXIC_NOR_REG_DC(p) \
+	((20 - (p)) >> 1)
+
+/* Macronix write CR2 operations */
+#define MXIC_NOR_WR_CR2(addr, ndata, buf)			\
+	SPI_MEM_OP(SPI_MEM_OP_CMD(MXIC_NOR_OP_WR_CR2, 0),	\
+		   SPI_MEM_OP_ADDR(4, addr, 0),			\
+		   SPI_MEM_OP_NO_DUMMY,				\
+		   SPI_MEM_OP_DATA_OUT(ndata, buf, 0))
+
 static int
 mx25l25635_post_bfpt_fixups(struct spi_nor *nor,
 			    const struct sfdp_parameter_header *bfpt_header,
@@ -185,6 +203,78 @@ static const struct flash_info macronix_nor_parts[] = {
 	}
 };
 
+static int macronix_nor_octal_dtr_en(struct spi_nor *nor)
+{
+	struct spi_mem_op op;
+	u8 *buf = nor->bouncebuf, i;
+	int ret;
+
+	/* Use dummy cycles which is parse by SFDP and convert to bit pattern. */
+	buf[0] = MXIC_NOR_REG_DC(nor->params->reads[SNOR_CMD_READ_8_8_8_DTR].num_wait_states);
+	op = (struct spi_mem_op)MXIC_NOR_WR_CR2(MXIC_NOR_ADDR_CR2_DC, 1, buf);
+	ret = spi_nor_write_any_volatile_reg(nor, &op, nor->reg_proto);
+	if (ret)
+		return ret;
+
+	/* Set the octal and DTR enable bits. */
+	buf[0] = MXIC_NOR_REG_DOPI_EN;
+	op = (struct spi_mem_op)MXIC_NOR_WR_CR2(MXIC_NOR_ADDR_CR2_MODE, 1, buf);
+	ret = spi_nor_write_any_volatile_reg(nor, &op, nor->reg_proto);
+	if (ret)
+		return ret;
+
+	/* Read flash ID to make sure the switch was successful. */
+	ret = spi_nor_read_id(nor, 4, 4, buf, SNOR_PROTO_8_8_8_DTR);
+	if (ret) {
+		dev_dbg(nor->dev, "error %d reading JEDEC ID after enabling 8D-8D-8D mode\n", ret);
+		return ret;
+	}
+
+	/* Macronix SPI-NOR flash 8D-8D-8D read ID would get 6 bytes data A-A-B-B-C-C */
+	for (i = 0; i < nor->info->id->len; i++)
+		if (buf[i * 2] != buf[(i * 2) + 1] || buf[i * 2] != nor->info->id->bytes[i])
+			return -EINVAL;
+
+	return 0;
+}
+
+static int macronix_nor_octal_dtr_dis(struct spi_nor *nor)
+{
+	struct spi_mem_op op;
+	u8 *buf = nor->bouncebuf;
+	int ret;
+
+	/*
+	 * The register is 1-byte wide, but 1-byte transactions are not
+	 * allowed in 8D-8D-8D mode. Since there is no register at the
+	 * next location, just initialize the value to 0 and let the
+	 * transaction go on.
+	 */
+	buf[0] = MXIC_NOR_REG_SPI_EN;
+	buf[1] = 0x0;
+	op = (struct spi_mem_op)MXIC_NOR_WR_CR2(MXIC_NOR_ADDR_CR2_MODE, 2, buf);
+	ret = spi_nor_write_any_volatile_reg(nor, &op, SNOR_PROTO_8_8_8_DTR);
+	if (ret)
+		return ret;
+
+	/* Read flash ID to make sure the switch was successful. */
+	ret = spi_nor_read_id(nor, 0, 0, buf, SNOR_PROTO_1_1_1);
+	if (ret) {
+		dev_dbg(nor->dev, "error %d reading JEDEC ID after disabling 8D-8D-8D mode\n", ret);
+		return ret;
+	}
+
+	if (memcmp(buf, nor->info->id->bytes, nor->info->id->len))
+		return -EINVAL;
+
+	return 0;
+}
+
+static int macronix_nor_set_octal_dtr(struct spi_nor *nor, bool enable)
+{
+	return enable ? macronix_nor_octal_dtr_en(nor) : macronix_nor_octal_dtr_dis(nor);
+}
+
 static void macronix_nor_default_init(struct spi_nor *nor)
 {
 	nor->params->quad_enable = spi_nor_sr1_bit6_quad_enable;
@@ -194,6 +284,7 @@ static int macronix_nor_late_init(struct spi_nor *nor)
 {
 	if (!nor->params->set_4byte_addr_mode)
 		nor->params->set_4byte_addr_mode = spi_nor_set_4byte_addr_mode_en4b_ex4b;
+	nor->params->set_octal_dtr = macronix_nor_set_octal_dtr;
 
 	return 0;
 }
-- 
2.25.1


