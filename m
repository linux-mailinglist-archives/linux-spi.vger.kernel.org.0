Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4226277548
	for <lists+linux-spi@lfdr.de>; Thu, 24 Sep 2020 17:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728486AbgIXP2a (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 24 Sep 2020 11:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728331AbgIXP20 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 24 Sep 2020 11:28:26 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6327C0613CE;
        Thu, 24 Sep 2020 08:28:26 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id b124so2086949pfg.13;
        Thu, 24 Sep 2020 08:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6HbdXWHUUwENmYPOkj3k/38B+LwukcgShCpL4ORLWz0=;
        b=BS9G2Z10aTHODKi9DPOqtRH1BDkXHi4BDW2MIXTXfcSvRcecmRWkw+uvS+ippogC5D
         lKAPVzmuNIXIw6t4Od6roKdghQUQkPpQKVIuXGnieXc4QEhSms2UVCbN4YLHwaAGihsR
         MD6srxVduIAJIDD2GsibdS10OiSOuV1Zsndkt41hmwVqFXYyGwLpgDzna+K7anx5M/T7
         KjGyiQylxE7U56YZt+iU0W/TICckQsoPkNkiz0LSaAAwgwjdyBc1WvRAM2FXmDbX2dBx
         UaYx2IsHwnPqjkG1qWKq4FVGhyZDZC3OGHisP0d4B7mtyrjUGpkjq8VZ2/fyNv+eLtfG
         mQWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6HbdXWHUUwENmYPOkj3k/38B+LwukcgShCpL4ORLWz0=;
        b=f80wubDHb503AL6TexLFKSHVarna3a5eSpaOt+JyPTBXfVbPRVweinOOjpPHO4W7ts
         sb+7fbHc6YLCj4WzDCdEWYfuskxFxn0SXduCizH7Uw5Tj2rsv6WE2u0xy6ewVQQdAHRj
         8Qa5QZClYJw51snp8qSIsNx9IywRJU8KeOIKc5vL1zbWW+KIOgv3sihRr9tg0nPgV88S
         fOIDdOF0BzENQGa/IyIXoyfZui4rAFr3HbNz4JjNEbhF8+prfehjslgxCFIlyYMMquou
         AlHpUEBgeUjBBfX2UzTlgMDX9tcz09xeEYizi152/51Sz3pRChN3JiTpp5zYZcehF2/e
         3PRg==
X-Gm-Message-State: AOAM533FZ7sIFDtb6cIChuVRXMo7nf0FVsAWFUxaNOhr4T0VMfEnKRRV
        hLkETr3hUgwS7zifE1EEA4MuwCtNN7NqMQ==
X-Google-Smtp-Source: ABdhPJwmevCejQOrLAOkrF2jd1QUYjk5raPouovzRqWETtYfP2zCKdaTqfzhPGY4cIWcuxFEPQ0GFQ==
X-Received: by 2002:a63:ea4f:: with SMTP id l15mr148553pgk.434.1600961305967;
        Thu, 24 Sep 2020 08:28:25 -0700 (PDT)
Received: from guoguo-omen.lan ([156.96.148.94])
        by smtp.gmail.com with ESMTPSA id e62sm3233212pfh.76.2020.09.24.08.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 08:28:25 -0700 (PDT)
From:   Chuanhong Guo <gch981213@gmail.com>
To:     linux-spi@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Ikjoon Jang <ikjn@chromium.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        bayi.cheng@mediatek.com, Chuanhong Guo <gch981213@gmail.com>
Subject: [PATCH 2/3] spi: spi-mtk-nor: add helper for checking prg mode ops
Date:   Thu, 24 Sep 2020 23:27:29 +0800
Message-Id: <20200924152730.733243-3-gch981213@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200924152730.733243-1-gch981213@gmail.com>
References: <20200924152730.733243-1-gch981213@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

op checking/resizing logic for the newly added mtk_nor_spi_mem_prg is
more complicated. Add two helper functions for them:
mtk_nor_match_prg: check whether an op is supported by prg mode.
mtk_nor_adj_prg_size: adjust data size for mtk_nor_spi_mem_prg.

mtk_nor_match_prg isn't called yet because supports_op is currently
broken. It'll be used in the next fix commit.

Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
---
 drivers/spi/spi-mtk-nor.c | 76 +++++++++++++++++++++++++++++++++++----
 1 file changed, 69 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-mtk-nor.c b/drivers/spi/spi-mtk-nor.c
index a0087a5e869b9..4bbf38ef5b4b1 100644
--- a/drivers/spi/spi-mtk-nor.c
+++ b/drivers/spi/spi-mtk-nor.c
@@ -168,10 +168,76 @@ static bool mtk_nor_match_read(const struct spi_mem_op *op)
 	return false;
 }
 
-static int mtk_nor_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op)
+static bool mtk_nor_match_prg(const struct spi_mem_op *op)
 {
-	size_t len;
+	int tx_len, rx_len, prg_len, prg_left;
+
+	// prg mode is spi-only.
+	if ((op->cmd.buswidth > 1) || (op->addr.buswidth > 1) ||
+	    (op->dummy.buswidth > 1) || (op->data.buswidth > 1))
+		return false;
+
+	tx_len = op->cmd.nbytes + op->addr.nbytes;
+
+	if (op->data.dir == SPI_MEM_DATA_OUT) {
+		// count dummy bytes only if we need to write data after it
+		tx_len += op->dummy.nbytes;
+
+		// leave at least one byte for data
+		if (tx_len > MTK_NOR_REG_PRGDATA_MAX)
+			return false;
+
+		// if there's no addr, meaning adjust_op_size is impossible,
+		// check data length as well.
+		if ((!op->addr.nbytes) &&
+		    (tx_len + op->data.nbytes > MTK_NOR_REG_PRGDATA_MAX + 1))
+			return false;
+	} else if (op->data.dir == SPI_MEM_DATA_IN) {
+		if (tx_len > MTK_NOR_REG_PRGDATA_MAX + 1)
+			return false;
+
+		rx_len = op->data.nbytes;
+		prg_left = MTK_NOR_PRG_CNT_MAX / 8 - tx_len - op->dummy.nbytes;
+		if (prg_left > MTK_NOR_REG_SHIFT_MAX + 1)
+			prg_left = MTK_NOR_REG_SHIFT_MAX + 1;
+		if (rx_len > prg_left) {
+			if (!op->addr.nbytes)
+				return false;
+			rx_len = prg_left;
+		}
+
+		prg_len = tx_len + op->dummy.nbytes + rx_len;
+		if (prg_len > MTK_NOR_PRG_CNT_MAX / 8)
+			return false;
+	} else {
+		prg_len = tx_len + op->dummy.nbytes;
+		if (prg_len > MTK_NOR_PRG_CNT_MAX / 8)
+			return false;
+	}
+	return true;
+}
 
+static void mtk_nor_adj_prg_size(struct spi_mem_op *op)
+{
+	int tx_len, tx_left, prg_left;
+
+	tx_len = op->cmd.nbytes + op->addr.nbytes;
+	if (op->data.dir == SPI_MEM_DATA_OUT) {
+		tx_len += op->dummy.nbytes;
+		tx_left = MTK_NOR_REG_PRGDATA_MAX + 1 - tx_len;
+		if (op->data.nbytes > tx_left)
+			op->data.nbytes = tx_left;
+	} else if (op->data.dir == SPI_MEM_DATA_IN) {
+		prg_left = MTK_NOR_PRG_CNT_MAX / 8 - tx_len - op->dummy.nbytes;
+		if (prg_left > MTK_NOR_REG_SHIFT_MAX + 1)
+			prg_left = MTK_NOR_REG_SHIFT_MAX + 1;
+		if (op->data.nbytes > prg_left)
+			op->data.nbytes = prg_left;
+	}
+}
+
+static int mtk_nor_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op)
+{
 	if (!op->data.nbytes)
 		return 0;
 
@@ -200,11 +266,7 @@ static int mtk_nor_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op)
 		}
 	}
 
-	len = MTK_NOR_PRG_MAX_SIZE - op->cmd.nbytes - op->addr.nbytes -
-	      op->dummy.nbytes;
-	if (op->data.nbytes > len)
-		op->data.nbytes = len;
-
+	mtk_nor_adj_prg_size(op);
 	return 0;
 }
 
-- 
2.26.2

