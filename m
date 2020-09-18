Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2215626F84C
	for <lists+linux-spi@lfdr.de>; Fri, 18 Sep 2020 10:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbgIRIbh (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 18 Sep 2020 04:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbgIRIbg (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 18 Sep 2020 04:31:36 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A409C061788
        for <linux-spi@vger.kernel.org>; Fri, 18 Sep 2020 01:31:36 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id j34so3044852pgi.7
        for <linux-spi@vger.kernel.org>; Fri, 18 Sep 2020 01:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PtgT8oGdi7tJWYrZylWP5X+Qu5mtWrTjssOMjWBLBio=;
        b=gIWNzXXI/65W9lRuW4rM4ZuoKImgBcadG9k1ZTZdlozcVR0w6y7VHSw5ovnfxV+y4s
         me4YUC5KA0N/CovI2zxVtNEXpQ8aXA1C+c8tsuTUo/mPKvhbcVunwTsO8sq35KVqV2wP
         tRlaD2cHR/DshX6cxwuMkOhzPkx4cdjcbJxpY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PtgT8oGdi7tJWYrZylWP5X+Qu5mtWrTjssOMjWBLBio=;
        b=sXRcQLBlmTeU6lNrxfAOH/BrWFKU1NUdbWywBKoANADwEdVjXFpdQo8DAu5/r++Bhd
         pFilfIjBV2JRySCWxvbRPO6X0lreFEw+p2SYn/x2AqEUsf9cCCuRhbv9IclWNDQVvcZy
         eAq4GyREaUyRoB8KJ9JXRQMxQjHWaxrSpKx5rRNSF6hWUD4QjZ1FNFUSntWAEsOGJG+i
         yZV38xxNUNIgusBBU/XEmKWwZbuJnhdlYidK7ZkIJHh4NfLyjXoAH70ZgCq4bnPbFgem
         JId8kISxL0/UOhKFMY09PcLPeuKpLQeKJliC8gmXwTqQzuEf7EKbSKnXoqFtVQ3JFoGt
         oNKQ==
X-Gm-Message-State: AOAM530ww8x8yfY/AL31qK1xLgmLNwmKmLb1nw4nHbpYWvw3i7AKKaro
        fKE6a2ajOG9NjTPz3n8gBgMZLg==
X-Google-Smtp-Source: ABdhPJylLeVr7aTAeXl/TquJqTgllezEHHoyI6zJ5/+F2fB1EMgD/15lCBC8Kt+Lo/SC0WxayecFLQ==
X-Received: by 2002:aa7:934e:0:b029:13f:d056:593 with SMTP id 14-20020aa7934e0000b029013fd0560593mr25187131pfn.15.1600417896081;
        Fri, 18 Sep 2020 01:31:36 -0700 (PDT)
Received: from ikjn-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:a8fc])
        by smtp.gmail.com with ESMTPSA id g206sm2193172pfb.178.2020.09.18.01.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 01:31:35 -0700 (PDT)
From:   Ikjoon Jang <ikjn@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
        devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-mtd@lists.infradead.org
Cc:     Ikjoon Jang <ikjn@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v2 2/5] spi: spi-mtk-nor: fix mishandled logics in checking SPI memory operation
Date:   Fri, 18 Sep 2020 16:31:20 +0800
Message-Id: <20200918162834.v2.2.I3de2918f09b817cc2ae6d324f1ece62779ecc7cf@changeid>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
In-Reply-To: <20200918083124.3921207-1-ikjn@chromium.org>
References: <20200918083124.3921207-1-ikjn@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Fix a simple bug which can limits its transfer size,
and add a simple helper function for code cleanups.

Fixes: a59b2c7c56bf ("spi: spi-mtk-nor: support standard spi properties")
Signed-off-by: Ikjoon Jang <ikjn@chromium.org>

---

(no changes since v1)

 drivers/spi/spi-mtk-nor.c | 62 ++++++++++++++++++++++++---------------
 1 file changed, 38 insertions(+), 24 deletions(-)

diff --git a/drivers/spi/spi-mtk-nor.c b/drivers/spi/spi-mtk-nor.c
index 6e6ca2b8e6c8..54b2c0fde95b 100644
--- a/drivers/spi/spi-mtk-nor.c
+++ b/drivers/spi/spi-mtk-nor.c
@@ -167,52 +167,63 @@ static bool mtk_nor_match_read(const struct spi_mem_op *op)
 	return false;
 }
 
-static int mtk_nor_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op)
+static bool need_bounce(void *cpu_addr, unsigned long len)
 {
-	size_t len;
+	return !!(((uintptr_t)cpu_addr) & MTK_NOR_DMA_ALIGN_MASK);
+}
 
+static int mtk_nor_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op)
+{
 	if (!op->data.nbytes)
 		return 0;
 
 	if ((op->addr.nbytes == 3) || (op->addr.nbytes == 4)) {
-		if ((op->data.dir == SPI_MEM_DATA_IN) &&
-		    mtk_nor_match_read(op)) {
+		switch (op->data.dir) {
+		case SPI_MEM_DATA_IN:
+			if (!mtk_nor_match_read(op))
+				return -EINVAL;
+			/* check if it's DMAable */
 			if ((op->addr.val & MTK_NOR_DMA_ALIGN_MASK) ||
-			    (op->data.nbytes < MTK_NOR_DMA_ALIGN))
+			    (op->data.nbytes < MTK_NOR_DMA_ALIGN)) {
 				op->data.nbytes = 1;
-			else if (!((ulong)(op->data.buf.in) &
-				   MTK_NOR_DMA_ALIGN_MASK))
+			} else {
+				if (need_bounce(op->data.buf.in, op->data.nbytes) &&
+				    (op->data.nbytes > MTK_NOR_BOUNCE_BUF_SIZE))
+					op->data.nbytes = MTK_NOR_BOUNCE_BUF_SIZE;
 				op->data.nbytes &= ~MTK_NOR_DMA_ALIGN_MASK;
-			else if (op->data.nbytes > MTK_NOR_BOUNCE_BUF_SIZE)
-				op->data.nbytes = MTK_NOR_BOUNCE_BUF_SIZE;
-			return 0;
-		} else if (op->data.dir == SPI_MEM_DATA_OUT) {
+			}
+			break;
+		case SPI_MEM_DATA_OUT:
 			if (op->data.nbytes >= MTK_NOR_PP_SIZE)
 				op->data.nbytes = MTK_NOR_PP_SIZE;
 			else
 				op->data.nbytes = 1;
-			return 0;
+			break;
+		default:
+			break;
 		}
+	} else {
+		u8 len = op->cmd.nbytes + op->addr.nbytes + op->dummy.nbytes;
+
+		if (len > MTK_NOR_PRG_MAX_SIZE)
+			return -EINVAL;
+		if (op->data.nbytes && !(MTK_NOR_PRG_MAX_SIZE - len))
+			return -EINVAL;
+		if (op->data.nbytes > (MTK_NOR_PRG_MAX_SIZE - len))
+			op->data.nbytes = MTK_NOR_PRG_MAX_SIZE - len;
 	}
 
-	len = MTK_NOR_PRG_MAX_SIZE - op->cmd.nbytes - op->addr.nbytes -
-	      op->dummy.nbytes;
-	if (op->data.nbytes > len)
-		op->data.nbytes = len;
-
 	return 0;
 }
 
 static bool mtk_nor_supports_op(struct spi_mem *mem,
 				const struct spi_mem_op *op)
 {
-	size_t len;
-
 	if (op->cmd.buswidth != 1)
 		return false;
 
 	if ((op->addr.nbytes == 3) || (op->addr.nbytes == 4)) {
-		switch(op->data.dir) {
+		switch (op->data.dir) {
 		case SPI_MEM_DATA_IN:
 			if (!mtk_nor_match_read(op))
 				return false;
@@ -226,11 +237,14 @@ static bool mtk_nor_supports_op(struct spi_mem *mem,
 		default:
 			break;
 		}
+	} else {
+		u8 len = op->cmd.nbytes + op->addr.nbytes + op->dummy.nbytes;
+
+		if (len > MTK_NOR_PRG_MAX_SIZE)
+			return false;
+		if (op->data.nbytes && !(MTK_NOR_PRG_MAX_SIZE - len))
+			return false;
 	}
-	len = op->cmd.nbytes + op->addr.nbytes + op->dummy.nbytes;
-	if ((len > MTK_NOR_PRG_MAX_SIZE) ||
-	    ((op->data.nbytes) && (len == MTK_NOR_PRG_MAX_SIZE)))
-		return false;
 
 	return spi_mem_default_supports_op(mem, op);
 }
-- 
2.28.0.681.g6f77f65b4e-goog

