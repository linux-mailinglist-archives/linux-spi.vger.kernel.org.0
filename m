Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA270277546
	for <lists+linux-spi@lfdr.de>; Thu, 24 Sep 2020 17:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728367AbgIXP2Y (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 24 Sep 2020 11:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728331AbgIXP2X (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 24 Sep 2020 11:28:23 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92189C0613CE;
        Thu, 24 Sep 2020 08:28:23 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id bw23so1890123pjb.2;
        Thu, 24 Sep 2020 08:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vzz0659k4nwMVwakwm/RmtcC/L9vr67nkqocIx4yobo=;
        b=OEI3vPl+yd9QIKrq9/edbzxv4ksL18bROyX1URD2V/OelcE0t1iKUAP6iDZgDIC261
         LKb8mf02MKWWNaQdnurAtYfmW9xYlXU+poqtaDanPW8I7bGg/R5caOTedxHIC3E/iIw4
         Nh/WNn0BRTsriHXreeuhR0T1JFprH3Dh1AufH4ew5tch71spMA7p4z79FY+WoC5qkBB9
         dmXPmdoRs9L5PiFnj88o6/m7IAz4I6my2tsFMvbdfHwMQr+X73NtV+/Gm9QXwJt2ETCu
         jZ4VaARxJ5X3DpFN4ACIZzyBxvvTicDqfO4Mum9tOJj3MjZ5fWt0EhKZxIp4aAt8q+Cm
         5SSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vzz0659k4nwMVwakwm/RmtcC/L9vr67nkqocIx4yobo=;
        b=iTTTX7ZhDnLi4zEvJvbFS9yyoLv/vavz34Amww7kl0rOSj3vSEipVrLzPSEumKRl02
         T0mB1mPbc5UlvS7u60HxqBEO1/1Am/HjQZrep7dQ5Pq77LJClfUCvIqW8dqzGs6WeySI
         0PbEMeOVifVfG0lYhZKcBxl8rVSy31LeVklP4XEN9gTxTL1Dgpg9B0Qg1bLmnnckHsKC
         doTC8gDEXrOheXRJJcLqpV6UJHUbGZwO2E2cVPdd/P0iiJGgYvofg+kfwn8Jo8PBGWnd
         1z5R1I3hZcJB24s2Y9AJpfaf9p5dpQxLONrpk7amt07kOVD4kHPEltRFPo2Bk6jhosqY
         dnSQ==
X-Gm-Message-State: AOAM531Q8PSWOGSGDp3PvlUrUFozWfEKYKsU7GpxWjuEvtYLWoleNnP9
        XUdYsT2HB/N75BTqhfGeNbSu94DuJ07oqQ==
X-Google-Smtp-Source: ABdhPJziJuVlIk0Pqjl8kKPAPvOSPiY8oac/jAD+WQLAQXWe0/6y7/sJek4nx6EQk8nCWigsCeI9/g==
X-Received: by 2002:a17:902:bf08:b029:d1:bafb:ae2a with SMTP id bi8-20020a170902bf08b02900d1bafbae2amr4919264plb.39.1600961302878;
        Thu, 24 Sep 2020 08:28:22 -0700 (PDT)
Received: from guoguo-omen.lan ([156.96.148.94])
        by smtp.gmail.com with ESMTPSA id e62sm3233212pfh.76.2020.09.24.08.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 08:28:22 -0700 (PDT)
From:   Chuanhong Guo <gch981213@gmail.com>
To:     linux-spi@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Ikjoon Jang <ikjn@chromium.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        bayi.cheng@mediatek.com, Chuanhong Guo <gch981213@gmail.com>
Subject: [PATCH 1/3] spi: spi-mtk-nor: make use of full capability of prg mode
Date:   Thu, 24 Sep 2020 23:27:28 +0800
Message-Id: <20200924152730.733243-2-gch981213@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200924152730.733243-1-gch981213@gmail.com>
References: <20200924152730.733243-1-gch981213@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

"program" mode on this controller can trigger up to 56 bits of data
shifting. During the operation, data in PRGDATA[0-5] will be
shifted out from MOSI, and data from MISO will be continuously filling
SHREG[0-9].
Currently this mode is used to implement transfer_one_message for 6-byte
full-duplex transfer, but it can execute a transfer for up-to 7 bytes
as long as the last byte is read only.
transfer_one_message is expected to perform full-duplex transfer,
instead of transfer with specific format. mtk_nor_spi_mem_prg is
added here to use this extra byte.

Newer version of this controller can trigger longer data shifting with
shift bytes more than PRGDATA_MAX + SHREG_MAX. This patch is implemented
with that in mind and it checks against both SHREG_MAX and PRG_CNT_MAX
for future support of new controllers.

Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
---
There are two calls of mtk_nor_spi_mem_prg in mtk_nor_exec_op,
which doesn't look great. But I'd prefer keeping it this way
to minimize change of mtk_nor_exec_op.
I'll follow up with a cleanup patchset after this one gets
merged.

 drivers/spi/spi-mtk-nor.c | 82 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 80 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-mtk-nor.c b/drivers/spi/spi-mtk-nor.c
index 62f5ff2779884..a0087a5e869b9 100644
--- a/drivers/spi/spi-mtk-nor.c
+++ b/drivers/spi/spi-mtk-nor.c
@@ -27,6 +27,7 @@
 #define MTK_NOR_CMD_MASK		GENMASK(5, 0)
 
 #define MTK_NOR_REG_PRG_CNT		0x04
+#define MTK_NOR_PRG_CNT_MAX		56
 #define MTK_NOR_REG_RDATA		0x0c
 
 #define MTK_NOR_REG_RADR0		0x10
@@ -404,6 +405,83 @@ static int mtk_nor_pp_unbuffered(struct mtk_nor *sp,
 	return mtk_nor_cmd_exec(sp, MTK_NOR_CMD_WRITE, 6 * BITS_PER_BYTE);
 }
 
+static int mtk_nor_spi_mem_prg(struct mtk_nor *sp, const struct spi_mem_op *op)
+{
+	int rx_len = 0;
+	int reg_offset = MTK_NOR_REG_PRGDATA_MAX;
+	int tx_len, prg_len;
+	int i, ret;
+	void __iomem *reg;
+	u8 bufbyte;
+
+	tx_len = op->cmd.nbytes + op->addr.nbytes;
+
+	// count dummy bytes only if we need to write data after it
+	if (op->data.dir == SPI_MEM_DATA_OUT)
+		tx_len += op->dummy.nbytes + op->data.nbytes;
+	else if (op->data.dir == SPI_MEM_DATA_IN)
+		rx_len = op->data.nbytes;
+
+	prg_len = op->cmd.nbytes + op->addr.nbytes + op->dummy.nbytes +
+		  op->data.nbytes;
+
+	// an invalid op may reach here if the caller calls exec_op without
+	// adjust_op_size. return -EINVAL instead of -ENOTSUPP so that
+	// spi-mem won't try this op again with generic spi transfers.
+	if ((tx_len > MTK_NOR_REG_PRGDATA_MAX + 1) ||
+	    (rx_len > MTK_NOR_REG_SHIFT_MAX + 1) ||
+	    (prg_len > MTK_NOR_PRG_CNT_MAX / 8))
+		return -EINVAL;
+
+	// fill tx data
+	for (i = op->cmd.nbytes; i > 0; i--, reg_offset--) {
+		reg = sp->base + MTK_NOR_REG_PRGDATA(reg_offset);
+		bufbyte = (op->cmd.opcode >> ((i - 1) * BITS_PER_BYTE)) & 0xff;
+		writeb(bufbyte, reg);
+	}
+
+	for (i = op->addr.nbytes; i > 0; i--, reg_offset--) {
+		reg = sp->base + MTK_NOR_REG_PRGDATA(reg_offset);
+		bufbyte = (op->addr.val >> ((i - 1) * BITS_PER_BYTE)) & 0xff;
+		writeb(bufbyte, reg);
+	}
+
+	if (op->data.dir == SPI_MEM_DATA_OUT) {
+		for (i = 0; i < op->dummy.nbytes; i++, reg_offset--) {
+			reg = sp->base + MTK_NOR_REG_PRGDATA(reg_offset);
+			writeb(0, reg);
+		}
+
+		for (i = 0; i < op->data.nbytes; i++, reg_offset--) {
+			reg = sp->base + MTK_NOR_REG_PRGDATA(reg_offset);
+			writeb(((const u8 *)(op->data.buf.out))[i], reg);
+		}
+	}
+
+	for (; reg_offset >= 0; reg_offset--) {
+		reg = sp->base + MTK_NOR_REG_PRGDATA(reg_offset);
+		writeb(0, reg);
+	}
+
+	// trigger op
+	writel(prg_len * BITS_PER_BYTE, sp->base + MTK_NOR_REG_PRG_CNT);
+	ret = mtk_nor_cmd_exec(sp, MTK_NOR_CMD_PROGRAM,
+			       prg_len * BITS_PER_BYTE);
+	if (ret)
+		return ret;
+
+	// fetch read data
+	reg_offset = 0;
+	if (op->data.dir == SPI_MEM_DATA_IN) {
+		for (i = op->data.nbytes - 1; i >= 0; i--, reg_offset++) {
+			reg = sp->base + MTK_NOR_REG_SHIFT(reg_offset);
+			((u8 *)(op->data.buf.in))[i] = readb(reg);
+		}
+	}
+
+	return 0;
+}
+
 static int mtk_nor_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 {
 	struct mtk_nor *sp = spi_controller_get_devdata(mem->spi->master);
@@ -411,7 +489,7 @@ static int mtk_nor_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 
 	if ((op->data.nbytes == 0) ||
 	    ((op->addr.nbytes != 3) && (op->addr.nbytes != 4)))
-		return -ENOTSUPP;
+		return mtk_nor_spi_mem_prg(sp, op);
 
 	if (op->data.dir == SPI_MEM_DATA_OUT) {
 		mtk_nor_set_addr(sp, op);
@@ -441,7 +519,7 @@ static int mtk_nor_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 		}
 	}
 
-	return -ENOTSUPP;
+	return mtk_nor_spi_mem_prg(sp, op);
 }
 
 static int mtk_nor_setup(struct spi_device *spi)
-- 
2.26.2

