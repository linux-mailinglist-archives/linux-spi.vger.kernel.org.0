Return-Path: <linux-spi+bounces-936-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E5B84545B
	for <lists+linux-spi@lfdr.de>; Thu,  1 Feb 2024 10:44:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE0501C26D5E
	for <lists+linux-spi@lfdr.de>; Thu,  1 Feb 2024 09:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B082F4DA01;
	Thu,  1 Feb 2024 09:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OF9W2g3H"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D884D9EB
	for <linux-spi@vger.kernel.org>; Thu,  1 Feb 2024 09:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706780643; cv=none; b=BIIWDvscXvaQChAfA+abj3VICNP04GBRjQvdIAEy3vkXba3wQl6MmrDsb6GnJnF/WJ2awpoKtz06+5fLVI86z1OqJOs3md0qu+J0KBKcPAe4S0O+LsqXCtX8crBLW8TaMAXRL+Y4K/64wG/EYA0VE+MGUgAix/y/WY6P1oc7bCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706780643; c=relaxed/simple;
	bh=zfOT9V9HGMGdqBj6fgdk2bIvY/8GbTZUyTcBueYbbPk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ufBjpmMFVm7OANJZX7IY/jlyz1tjj9gPDDuE0qVfc0rZZoA5ZZ6t4Ar8LIH+b1xtVbNu79Zd29CzQPKhUPqcVjLS24qVWl8IiIr9hqmkyhuC6rKwQPT+6RePTXTR5ZTyg8d/P53Jy48VyvXqLAiMgPTOcweZXi1OtbUYHAxs01o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OF9W2g3H; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-290da27f597so473857a91.2
        for <linux-spi@vger.kernel.org>; Thu, 01 Feb 2024 01:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706780641; x=1707385441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/BwZAV3NIoDVdtDo0hEnlccNiKcSAuJpwvstHeklmZU=;
        b=OF9W2g3HeTbrQ4flcHK1HhVzkk6gDNDtxcPZ7HhPmsB1ynYwqm7V04q7PEmRGjASkN
         dh0hW3glkK0pvla/Jh9ss/VR02pOcHHjY580aJpnngmWYJ629S3GLZ5JbVwVXsanOSeH
         +KuyshZPLI8avBX62375RB36XV+CBaviNCly6YVStaQa9tajMqiuYu/V5SUSwAYZ0fSr
         LFB9a2syuiLgm3WjGNZBkob3YO91urlcij601WZU55Q6RuFkPtt69DxSEu43ihDRSoTs
         8KjFz4Zg9TaM5jMlyOFcK4yIA6J8YhWjKpOSK1EA5GfrNaVRuDbyOX07s9S50kZW3MHH
         UG6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706780641; x=1707385441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/BwZAV3NIoDVdtDo0hEnlccNiKcSAuJpwvstHeklmZU=;
        b=vWwEIxObOrHqtgEPaYGlJ3Skl0ZpNIMGZUUwWqiGxXm92aYd8MOOh+fFWkLypIghks
         fWddZFVqTTS/hK2Dcz8EMo8xPx8X0T2ueu293XQq9YE7Z8fQx7noM8OrG0mdIBeZdeEr
         YeGWpzwuotqyiLsBroHjXmTKcKw7Zc3R4jdQ3e0Ho1SC/AAswx/vucQ8QJsZ+LKzhmzH
         Aec62rIgezN+1K+iLmMQ8aJtpTY3Si/fCcMKcZxHVZjcbSWMRnWUva55S9G8HQCVC+PF
         JqDivOSP1ovAxK05RW0+b2fhZ/lAKsVscLVfTPAPmP7eWtFZ91P2FSib8fTCWPZq9oQa
         7Rsg==
X-Gm-Message-State: AOJu0Yz2LryEghUOsVxM+YwpE1vf9PIZW2n/hn+DODttM0QKpnNKTUh+
	lqVsqp1itHVIzngxAkDDyAcWQoT+FqAkpxz+7++9d2EpPIVU/Pfq
X-Google-Smtp-Source: AGHT+IGa3xXJ02wWLHWB9JdeXCbgHUy/p/uqnVlX+SQX/VuU6o+dSvF2hgmOPGCsWsDsMyQDkqQetg==
X-Received: by 2002:a17:90a:be0e:b0:295:cd91:1314 with SMTP id a14-20020a17090abe0e00b00295cd911314mr4264292pjs.1.1706780641301;
        Thu, 01 Feb 2024 01:44:01 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVFGPogJoeAj0GiG82znaKn2YQOJ6mfFLndDPsCvY2mDZJOV0e5OM0Z8LcuVON8th67anqeFIduRTK0In3sjfLZ4gaMRHOW+27RNDnMtZxl87xohPqeEBruHct2eQvTkIIqwh1Dz4Oxthy8vguRDatUkwiVtkddMmJO3ZP0rMj3k8Z9Q0JiJBXtAKu9hu3HZF8869E06SeSbEHHMAy7zqeSHTSD+cR8HGejGSoYBNs5uQcInHkN0UR+y3jhoGbNOGrAVPL0uF3PLFqW0PWJAYu++a8rxtvCSb2HPLlftTopBwRw72pAb0Axb2dkAbNFnh7rqg==
Received: from twhmp6px (mxsmtp211.mxic.com.tw. [211.75.127.162])
        by smtp.gmail.com with ESMTPSA id j4-20020a17090a31c400b002961fc85e6bsm599979pjf.23.2024.02.01.01.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 01:44:01 -0800 (PST)
Received: from hqs-appsw-appswa2.mp600.macronix.com (linux-patcher [172.17.236.35])
	by twhmp6px (Postfix) with ESMTPS id 4A8978074F;
	Thu,  1 Feb 2024 17:50:01 +0800 (CST)
From: Jaime Liao <jaimeliao.tw@gmail.com>
To: linux-mtd@lists.infradead.org,
	linux-spi@vger.kernel.org,
	tudor.ambarus@linaro.org,
	pratyush@kernel.org,
	mwalle@kernel.org,
	miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com,
	broonie@kernel.org
Cc: leoyu@mxic.com.tw,
	jaimeliao@mxic.com.tw
Subject: [PATCH v8 1/9] mtd: spi-nor: add Octal DTR support for Macronix flash
Date: Thu,  1 Feb 2024 17:43:45 +0800
Message-Id: <20240201094353.33281-2-jaimeliao.tw@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240201094353.33281-1-jaimeliao.tw@gmail.com>
References: <20240201094353.33281-1-jaimeliao.tw@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: JaimeLiao <jaimeliao@mxic.com.tw>

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
Acked-by: Michael Walle <mwalle@kernel.org>
---
 drivers/mtd/spi-nor/macronix.c | 100 +++++++++++++++++++++++++++++++++
 1 file changed, 100 insertions(+)

diff --git a/drivers/mtd/spi-nor/macronix.c b/drivers/mtd/spi-nor/macronix.c
index ea6be95e75a5..dee71776b1a8 100644
--- a/drivers/mtd/spi-nor/macronix.c
+++ b/drivers/mtd/spi-nor/macronix.c
@@ -8,6 +8,24 @@
 
 #include "core.h"
 
+#define SPINOR_OP_MXIC_RD_ANY_REG	0x71		/* Read volatile configuration register 2 */
+#define SPINOR_OP_MXIC_WR_ANY_REG	0x72		/* Write volatile configuration register 2 */
+#define SPINOR_REG_MXIC_CR2_MODE	0x00000000	/* CR2 address for setting octal DTR mode */
+#define SPINOR_REG_MXIC_CR2_DC		0x00000300	/* CR2 address for setting dummy cycles */
+#define SPINOR_REG_MXIC_OPI_DTR_EN	0x2		/* Enable Octal DTR */
+#define SPINOR_REG_MXIC_SPI_EN		0x0		/* Enable SPI */
+#define SPINOR_REG_MXIC_ADDR_BYTES	4		/* Fixed R/W volatile address bytes to 4 */
+/* Convert dummy cycles to bit pattern */
+#define SPINOR_REG_MXIC_DC(p) \
+		((20 - p)/2)
+
+/* Macronix SPI NOR flash operations. */
+#define MXIC_NOR_WR_ANY_REG_OP(naddr, addr, ndata, buf)		\
+	SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_MXIC_WR_ANY_REG, 0),		\
+		   SPI_MEM_OP_ADDR(naddr, addr, 0),			\
+		   SPI_MEM_OP_NO_DUMMY,					\
+		   SPI_MEM_OP_DATA_OUT(ndata, buf, 0))
+
 static int
 mx25l25635_post_bfpt_fixups(struct spi_nor *nor,
 			    const struct sfdp_parameter_header *bfpt_header,
@@ -185,6 +203,87 @@ static const struct flash_info macronix_nor_parts[] = {
 	}
 };
 
+static int macronix_nor_octal_dtr_en(struct spi_nor *nor)
+{
+	struct spi_mem_op op;
+	u8 *buf = nor->bouncebuf, i;
+	int ret;
+
+	/* Use dummy cycles which is parse by SFDP and convert to bit pattern. */
+	buf[0] = SPINOR_REG_MXIC_DC(nor->params->reads[SNOR_CMD_READ_8_8_8_DTR].num_wait_states);
+	op = (struct spi_mem_op)
+		MXIC_NOR_WR_ANY_REG_OP(SPINOR_REG_MXIC_ADDR_BYTES,
+				       SPINOR_REG_MXIC_CR2_DC, 1, buf);
+
+	ret = spi_nor_write_any_volatile_reg(nor, &op, nor->reg_proto);
+	if (ret)
+		return ret;
+
+	/* Set the octal and DTR enable bits. */
+	buf[0] = SPINOR_REG_MXIC_OPI_DTR_EN;
+	op = (struct spi_mem_op)
+		MXIC_NOR_WR_ANY_REG_OP(SPINOR_REG_MXIC_ADDR_BYTES,
+				       SPINOR_REG_MXIC_CR2_MODE, 1, buf);
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
+		if (buf[i * 2] != buf[(i * 2) + 1] ||
+		    buf[i * 2] != nor->info->id->bytes[i])
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
+	buf[0] = SPINOR_REG_MXIC_SPI_EN;
+	buf[1] = 0x0;
+	op = (struct spi_mem_op)
+		MXIC_NOR_WR_ANY_REG_OP(SPINOR_REG_MXIC_ADDR_BYTES,
+				       SPINOR_REG_MXIC_CR2_MODE, 2, buf);
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
+	return enable ? macronix_nor_octal_dtr_en(nor) :
+			macronix_nor_octal_dtr_dis(nor);
+}
+
 static void macronix_nor_default_init(struct spi_nor *nor)
 {
 	nor->params->quad_enable = spi_nor_sr1_bit6_quad_enable;
@@ -194,6 +293,7 @@ static int macronix_nor_late_init(struct spi_nor *nor)
 {
 	if (!nor->params->set_4byte_addr_mode)
 		nor->params->set_4byte_addr_mode = spi_nor_set_4byte_addr_mode_en4b_ex4b;
+	nor->params->set_octal_dtr = macronix_nor_set_octal_dtr;
 
 	return 0;
 }
-- 
2.25.1


