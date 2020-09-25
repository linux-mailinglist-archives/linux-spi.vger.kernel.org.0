Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3B22780F4
	for <lists+linux-spi@lfdr.de>; Fri, 25 Sep 2020 08:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbgIYGyh (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 25 Sep 2020 02:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727304AbgIYGyf (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 25 Sep 2020 02:54:35 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA3CC0613D3
        for <linux-spi@vger.kernel.org>; Thu, 24 Sep 2020 23:54:35 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id n14so2245260pff.6
        for <linux-spi@vger.kernel.org>; Thu, 24 Sep 2020 23:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nzcKjvh4JoY0QitgZl8v+rPty87BwMtZ3v0cSqAKG3I=;
        b=Rxf2S/HREm6VaApX0ixCEMuRvDtmyK902EC/jBtCqsg0+QIAQUFpuCw+3FcOZ64fG+
         miJR6LzvQ1KEBuFCLbETuKfsvQgXUEMaKjxffgtLyAZXFRY/68Xkcyg12WeatubDH9gS
         FD0E7XqaU1fZNwm4BaVOKXuTUPgQs3wAJmpUg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nzcKjvh4JoY0QitgZl8v+rPty87BwMtZ3v0cSqAKG3I=;
        b=flB3fibLnpoOTjK0TJeHtDbr24LIPM3Zkuvy8y/fCM4gy5tXSW6Ibnpwz9kVDqKgdi
         a1Ief+5ABINzMIm3GvG6tb8SITgA7/XaFt/7q11Dmo3VrDLSEbAcanQqvUW1xscUvNkI
         oYf9ezMRXH7C6JexL3F5wpv7i8sUzvns/X78Z4weBff/rgYqp5zHgZZnWDuP5+qxcaWG
         q06HW0/zozvzizWk9SLJTszim9iqW//ckR9D38vy6cxzAD6zc+fy2e//AEn98XrlNY0B
         1zV4xuWfnjwn0rLxfR6LWWNsmJ65i58ekJWupGE4OOlFpAoFKNMD/asaZ8RudlxUuBx7
         akCA==
X-Gm-Message-State: AOAM5318t+7EItcKlL3DuVnYdvVkaWufYKioS3bWBNNmIlDj2ZHaFI++
        cWAnpwP3JKH0+zMIKmBdIBtVqw==
X-Google-Smtp-Source: ABdhPJwfu5FpqZVVPhzaJh/cZWIo7V61gqtv5b9Tzw6224GwK/gb1kSsaD1AfFX7zvhQi7lgZOEYOA==
X-Received: by 2002:a63:3192:: with SMTP id x140mr2432715pgx.416.1601016875338;
        Thu, 24 Sep 2020 23:54:35 -0700 (PDT)
Received: from ikjn-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:a8fc])
        by smtp.gmail.com with ESMTPSA id x27sm1549612pfp.128.2020.09.24.23.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 23:54:34 -0700 (PDT)
From:   Ikjoon Jang <ikjn@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
        devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-mtd@lists.infradead.org
Cc:     Ikjoon Jang <ikjn@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v3 3/6] spi: spi-mtk-nor: support 7 bytes transfer of generic spi
Date:   Fri, 25 Sep 2020 14:54:14 +0800
Message-Id: <20200925145255.v3.3.I7a3fc5678a81654574e8852d920db94bcc4d3eb8@changeid>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
In-Reply-To: <20200925065418.1077472-1-ikjn@chromium.org>
References: <20200925065418.1077472-1-ikjn@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

When mtk-nor fallbacks to generic spi transfers, it can actually
transfer up to 7 bytes.

This patch fixes adjust_op_size() and supports_op() to explicitly
check 7 bytes range and also fixes possible under/overflow conditions
in register offsets calculation.

Signed-off-by: Ikjoon Jang <ikjn@chromium.org>
---

(no changes since v1)

 drivers/spi/spi-mtk-nor.c | 102 ++++++++++++++++++++++++++++----------
 1 file changed, 76 insertions(+), 26 deletions(-)

diff --git a/drivers/spi/spi-mtk-nor.c b/drivers/spi/spi-mtk-nor.c
index 0f7d4ec68730..e7719d249095 100644
--- a/drivers/spi/spi-mtk-nor.c
+++ b/drivers/spi/spi-mtk-nor.c
@@ -79,7 +79,11 @@
 #define MTK_NOR_REG_DMA_DADR		0x720
 #define MTK_NOR_REG_DMA_END_DADR	0x724
 
+/* maximum bytes of TX in PRG mode */
 #define MTK_NOR_PRG_MAX_SIZE		6
+/* maximum bytes of TX + RX is 7, last 1 byte is always being sent as zero */
+#define MTK_NOR_PRG_MAX_CYCLES		7
+
 // Reading DMA src/dst addresses have to be 16-byte aligned
 #define MTK_NOR_DMA_ALIGN		16
 #define MTK_NOR_DMA_ALIGN_MASK		(MTK_NOR_DMA_ALIGN - 1)
@@ -167,6 +171,24 @@ static bool mtk_nor_match_read(const struct spi_mem_op *op)
 	return false;
 }
 
+static bool mtk_nor_check_prg(const struct spi_mem_op *op)
+{
+	size_t len = op->cmd.nbytes + op->addr.nbytes + op->dummy.nbytes;
+
+	if (len > MTK_NOR_PRG_MAX_SIZE)
+		return false;
+
+	if (!op->data.nbytes)
+		return true;
+
+	if (op->data.dir == SPI_MEM_DATA_OUT)
+		return ((len + op->data.nbytes) <= MTK_NOR_PRG_MAX_SIZE);
+	else if (op->data.dir == SPI_MEM_DATA_IN)
+		return ((len + op->data.nbytes) <= MTK_NOR_PRG_MAX_CYCLES);
+	else
+		return true;
+}
+
 static int mtk_nor_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op)
 {
 	size_t len;
@@ -195,10 +217,22 @@ static int mtk_nor_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op)
 		}
 	}
 
-	len = MTK_NOR_PRG_MAX_SIZE - op->cmd.nbytes - op->addr.nbytes -
-	      op->dummy.nbytes;
-	if (op->data.nbytes > len)
-		op->data.nbytes = len;
+	if (mtk_nor_check_prg(op))
+		return 0;
+
+	len = op->cmd.nbytes + op->addr.nbytes + op->dummy.nbytes;
+
+	if (op->data.dir == SPI_MEM_DATA_OUT) {
+		if (len == MTK_NOR_PRG_MAX_SIZE)
+			return -EINVAL;
+		op->data.nbytes = min_t(unsigned int, op->data.nbytes,
+					MTK_NOR_PRG_MAX_SIZE - len);
+	} else  {
+		if (len == MTK_NOR_PRG_MAX_CYCLES)
+			return -EINVAL;
+		op->data.nbytes = min_t(unsigned int, op->data.nbytes,
+					MTK_NOR_PRG_MAX_CYCLES - len);
+	}
 
 	return 0;
 }
@@ -206,8 +240,6 @@ static int mtk_nor_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op)
 static bool mtk_nor_supports_op(struct spi_mem *mem,
 				const struct spi_mem_op *op)
 {
-	size_t len;
-
 	if (op->cmd.buswidth != 1)
 		return false;
 
@@ -223,12 +255,11 @@ static bool mtk_nor_supports_op(struct spi_mem *mem,
 			       (op->data.buswidth == 1);
 	}
 
-	len = op->cmd.nbytes + op->addr.nbytes + op->dummy.nbytes;
-	if ((len > MTK_NOR_PRG_MAX_SIZE) ||
-	    ((op->data.nbytes) && (len == MTK_NOR_PRG_MAX_SIZE)))
+	/* fallback to generic spi xfer */
+	if (op->cmd.buswidth > 1 || op->addr.buswidth > 1 || op->data.buswidth > 1)
 		return false;
 
-	return true;
+	return mtk_nor_check_prg(op);
 }
 
 static void mtk_nor_setup_bus(struct mtk_nor *sp, const struct spi_mem_op *op)
@@ -459,22 +490,36 @@ static int mtk_nor_transfer_one_message(struct spi_controller *master,
 	int stat = 0;
 	int reg_offset = MTK_NOR_REG_PRGDATA_MAX;
 	void __iomem *reg;
-	const u8 *txbuf;
-	u8 *rxbuf;
-	int i;
+	int i, tx_len = 0, rx_len = 0;
 
 	list_for_each_entry(t, &m->transfers, transfer_list) {
-		txbuf = t->tx_buf;
-		for (i = 0; i < t->len; i++, reg_offset--) {
+		const u8 *txbuf = t->tx_buf;
+
+		if (!txbuf) {
+			rx_len += t->len;
+			continue;
+		}
+
+		if (rx_len) {
+			stat = -EPROTO;
+			goto msg_done;
+		}
+
+		for (i = 0; i < t->len && reg_offset >= 0; i++, reg_offset--) {
 			reg = sp->base + MTK_NOR_REG_PRGDATA(reg_offset);
-			if (txbuf)
-				writeb(txbuf[i], reg);
-			else
-				writeb(0, reg);
+			writeb(txbuf[i], reg);
+			tx_len++;
 		}
-		trx_len += t->len;
 	}
 
+	while (reg_offset >= 0) {
+		writeb(0, sp->base + MTK_NOR_REG_PRGDATA(reg_offset));
+		reg_offset--;
+	}
+
+	rx_len = min_t(unsigned long, MTK_NOR_PRG_MAX_CYCLES - tx_len, rx_len);
+	trx_len = tx_len + rx_len;
+
 	writel(trx_len * BITS_PER_BYTE, sp->base + MTK_NOR_REG_PRG_CNT);
 
 	stat = mtk_nor_cmd_exec(sp, MTK_NOR_CMD_PROGRAM,
@@ -482,13 +527,18 @@ static int mtk_nor_transfer_one_message(struct spi_controller *master,
 	if (stat < 0)
 		goto msg_done;
 
-	reg_offset = trx_len - 1;
-	list_for_each_entry(t, &m->transfers, transfer_list) {
-		rxbuf = t->rx_buf;
-		for (i = 0; i < t->len; i++, reg_offset--) {
-			reg = sp->base + MTK_NOR_REG_SHIFT(reg_offset);
-			if (rxbuf)
+	if (rx_len > 0) {
+		reg_offset = rx_len - 1;
+		list_for_each_entry(t, &m->transfers, transfer_list) {
+			u8 *rxbuf = t->rx_buf;
+
+			if (!rxbuf)
+				continue;
+
+			for (i = 0; i < t->len && reg_offset >= 0; i++, reg_offset--) {
+				reg = sp->base + MTK_NOR_REG_SHIFT(reg_offset);
 				rxbuf[i] = readb(reg);
+			}
 		}
 	}
 
-- 
2.28.0.681.g6f77f65b4e-goog

