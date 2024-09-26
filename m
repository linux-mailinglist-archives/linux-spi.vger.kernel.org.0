Return-Path: <linux-spi+bounces-4999-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68DED98758B
	for <lists+linux-spi@lfdr.de>; Thu, 26 Sep 2024 16:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D769A1F21CBA
	for <lists+linux-spi@lfdr.de>; Thu, 26 Sep 2024 14:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2365136347;
	Thu, 26 Sep 2024 14:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MOns2biF"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5262C152E0C;
	Thu, 26 Sep 2024 14:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727360715; cv=none; b=e56lz9YcsI0y4ju7KG02WpweKv4BnjaZjfT3fqxUA8Zi+sAF1G82ptcAO99djfQCLib5hWvrXJeqlo9BIrfRP8qzG90rlOrc7NvHYMUCEzdjrco7FTAkv4lJsvmMqXOps9rukPGCq4Rb1zgRF0GxE3yES3MowexyR1rNx5h2fR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727360715; c=relaxed/simple;
	bh=rohIPkPHx/We1NH5EgVF26sUqnVtFhtbebzyRMy9bCA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E9z5PBiH4BZlvN3IbWhr1tj1IlcjsPn/CX6uVkdDXgHqVGRk7H2TFv1/6aiKJybAtDZdreDCt+dUCKa2AWY1pq1N7KVFE5nBZw3l5rc4XEsqmalshQeWGevF/3/NzoaT34+qXqvoE/lFYmV7Wmth7UypMzZw/QJsdO4gGL2Td9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MOns2biF; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2da4ea59658so933818a91.0;
        Thu, 26 Sep 2024 07:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727360713; x=1727965513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7MNbHUjaElO2sctpFFvlUsXRoBevroY7p0SuuxxIX0Q=;
        b=MOns2biFsrTqWU23saCRL6DFGHIXrcJNbqVfV/uLdckLYO6W4j8tJm6ymTt/hRXGEV
         GXXKGP6GsNKTuaA1DaN9VRWoalDFdxnSCNHcR4FX/EvGVPu5nlg/Frnee3yAZDerNdqK
         5OznEhT9hA4/kW5F81e4WpGFbpoGsSEzDtF1uLa8kDOcIeAl4auJRFwfDwVsaVCQWwdK
         LV6D0da/utf+1JYNv7zYnd1p54TsDSUFPoSUjYFXIXVcPqXzBnWxrs6XykuA0hFvRgDX
         ZYvI4LwxeZyR2iY2A5wQBqOvChOc5v1/D8qb6cmSXsQ7ky02ZqSNTWpCpmKDyB3sLOJd
         PB0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727360713; x=1727965513;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7MNbHUjaElO2sctpFFvlUsXRoBevroY7p0SuuxxIX0Q=;
        b=Ib0aMqePMYLXUqKXnEP0uII0Xt9Oc519BVo7sYQwuJNqWzqsAoUOBwzybya9Af8Ycl
         1h3wM4husq4xcHt3kK7836phgQ1PArrFMFolXBnUx0Z9ZRWWgt300x99JW+/cO6za/YO
         5ce9APD2pvlh7tCGI14M1fqs7SVkFzoGR+SP7+MQjtacOK2JrH1dL0HPRWX28ZjATzu+
         aElc8RVmBYJNBcxx9myMraubZ/+RRP801zaYaeNBhinkOYIM3KkHTNeYmI46pRIBCnh8
         Cs+qY6n0CDLwJ0tqq1504t1R39aP3nUtlYNY3bbFMh3yTIHFKyrkCi7oeMp2YcmW0Zsr
         BZVg==
X-Forwarded-Encrypted: i=1; AJvYcCWVDdbrUp8omUUOxLBYjE82Tt8g18+VN/yWstxlqNoy8/JfVb373ikVYiLckqp94SizhL5aaFyZw0zf7mM=@vger.kernel.org, AJvYcCXt94F4QLrT3coNuvUKcgWk7dqIP9MCLC8hy8Q65s9XnOZsSPhIkVG39dOYbSkGL+6qxDyStiX8LAAz@vger.kernel.org
X-Gm-Message-State: AOJu0YxFuRa9OLAQER1aDuuUgeM2jAZn/0h/5fEeiQ25RjkkFHwjxC2F
	AH1OxLxuFXJ5HF0sYlDi+R8qIlTYwxbvy5GkKT3X0nECn0UKrbZhK7ed9A==
X-Google-Smtp-Source: AGHT+IGQ8aXlt5Srv+G0rBaxkopWyRA/YJw8UA5n/oKow7VUx+iht7yecIrSrolBtJ5uPPIGKRmQSg==
X-Received: by 2002:a17:90b:30ca:b0:2e0:90fe:cc2c with SMTP id 98e67ed59e1d1-2e090feee89mr3719879a91.26.1727360713363;
        Thu, 26 Sep 2024 07:25:13 -0700 (PDT)
Received: from twhmp6px (mxsmtp211.mxic.com.tw. [211.75.127.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e0b6c4bc3bsm49136a91.2.2024.09.26.07.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 07:25:12 -0700 (PDT)
Received: from hqs-appsw-a2o.mp600.macronix.com (linux-patcher [172.17.236.67])
	by twhmp6px (Postfix) with ESMTPS id A847E802C9;
	Thu, 26 Sep 2024 22:32:59 +0800 (CST)
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
Subject: [PATCH v10 1/6] mtd: spi-nor: add Octal DTR support for Macronix flash
Date: Thu, 26 Sep 2024 22:19:51 +0800
Message-Id: <20240926141956.2386374-2-alvinzhou.tw@gmail.com>
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

Create Macronix specify method for enable Octal DTR mode and
set 20 dummy cycles to allow running at the maximum supported
frequency for Macronix Octal flash.

Use number of dummy cycles which is parse by SFDP then convert
it to bit pattern and set in CR2 register.
Set CR2 register for enable octal DTR mode.

Use Read ID to confirm that enabling/disabling octal DTR mode
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


