Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5398277549
	for <lists+linux-spi@lfdr.de>; Thu, 24 Sep 2020 17:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728491AbgIXP2a (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 24 Sep 2020 11:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728381AbgIXP2a (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 24 Sep 2020 11:28:30 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF9FC0613D3;
        Thu, 24 Sep 2020 08:28:30 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id m15so1848316pls.8;
        Thu, 24 Sep 2020 08:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ydse9JJ+ftTyRWsvhcjm/YwUAWDIwbgK0aq4Xyc/pN8=;
        b=knL//JbbhIACLiQWUd5tja3co0hcd2If1nx/SGslZd13vEJI3NG9V0tLfyx38WXjOp
         d5sOdxkLd1CwWw6QFJ/IS6BcPPGHSd+0A5Z65VB/ZjlfR4LpbCKgqtJYiPdEu8ZD7Zdr
         7b1y37RbdH1IzBFOsLRbb0JlFj7FquwrV9kheoYHfsiIhTRW+ZJGpJRl22lfWUacMhDu
         Wq1mng24/fMotHwEcTWgTNmeE3gSkuNwnhwfDTu8fYLhGj/oHn0LwWOhceG4t5JF2Y5r
         5LEGswbVc8YoTsIAV2d5j1PFugoocmqh8NzgOdA8f6UdtLMpeKOW72S/OL1EbIoqEPkx
         7MCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ydse9JJ+ftTyRWsvhcjm/YwUAWDIwbgK0aq4Xyc/pN8=;
        b=Y+ehIx+gr8TjgJkSytCDes8+USmBn6Rr8O+/3T5cOuK0XO+ornkJfRhOuuBjMeM1Ig
         q+a8b6j92Me1JmcMRa8V4E62ykiGMXRdDP7DfzxWIVSPqMsxnoA3OUYjE/o1T1MQ0pjN
         G30zc8KHTiM35n/KTHIWxdp70Q113uumH17/g/SKlH80V42JIiMQ9xSiikx8nVeuZ+ox
         3IHqm26CyP9kMBwrFgWQAN/6/1N5iiyXrhAClpG7cekzdcPXFmJKRwRFFb/otq9COJ0n
         Rwi1vKn8BXdnnwLSykx2QVwplXm/d3CgIENUf9joZaIL0FKvrAm0QJA0aiCKPyttg7Wy
         u75w==
X-Gm-Message-State: AOAM533kuFknt4AWaZSKrK/o4UoYCfciA+Zm2jxpxX0Uv2wfSmATlGyn
        8mUU5370QxfqFW+uVQ3lMoKioJ9jigofwg==
X-Google-Smtp-Source: ABdhPJwj0O9VBAEbiiRMiUQP412SndgpBFZlx6tI3A6GsG2itd7F6Gc5r4f6bDJSVHSJD6gBN4IWrg==
X-Received: by 2002:a17:90a:c255:: with SMTP id d21mr4647745pjx.212.1600961309445;
        Thu, 24 Sep 2020 08:28:29 -0700 (PDT)
Received: from guoguo-omen.lan ([156.96.148.94])
        by smtp.gmail.com with ESMTPSA id e62sm3233212pfh.76.2020.09.24.08.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 08:28:29 -0700 (PDT)
From:   Chuanhong Guo <gch981213@gmail.com>
To:     linux-spi@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Ikjoon Jang <ikjn@chromium.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        bayi.cheng@mediatek.com, Chuanhong Guo <gch981213@gmail.com>
Subject: [PATCH 3/3] spi: spi-mtk-nor: fix op checks in supports_op
Date:   Thu, 24 Sep 2020 23:27:30 +0800
Message-Id: <20200924152730.733243-4-gch981213@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200924152730.733243-1-gch981213@gmail.com>
References: <20200924152730.733243-1-gch981213@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

commit a59b2c7c56bf7 ("spi: spi-mtk-nor: support standard spi properties")
tries to inverse the logic of supports_op when adding
spi_mem_default_supports_op check, but it didn't get it done properly.
There are two regressions introduced by this commit:
1. reading ops supported by program mode is rejected.
2. all ops with special controller routines are incorrectly further
   checked against program mode.

This commits inverses the logic back:
1. check spi_mem_default_supports_op and reject unsupported ops first.
2. return true for ops with special controller routines.
3. check the left ops against controller program mode.

Fixes: a59b2c7c56bf7 ("spi: spi-mtk-nor: support standard spi properties")
Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
---
 drivers/spi/spi-mtk-nor.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/spi-mtk-nor.c b/drivers/spi/spi-mtk-nor.c
index 4bbf38ef5b4b1..ea39736de2918 100644
--- a/drivers/spi/spi-mtk-nor.c
+++ b/drivers/spi/spi-mtk-nor.c
@@ -273,7 +273,8 @@ static int mtk_nor_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op)
 static bool mtk_nor_supports_op(struct spi_mem *mem,
 				const struct spi_mem_op *op)
 {
-	size_t len;
+	if (!spi_mem_default_supports_op(mem, op))
+		return false;
 
 	if (op->cmd.buswidth != 1)
 		return false;
@@ -281,25 +282,21 @@ static bool mtk_nor_supports_op(struct spi_mem *mem,
 	if ((op->addr.nbytes == 3) || (op->addr.nbytes == 4)) {
 		switch(op->data.dir) {
 		case SPI_MEM_DATA_IN:
-			if (!mtk_nor_match_read(op))
-				return false;
+			if (mtk_nor_match_read(op))
+				return true;
 			break;
 		case SPI_MEM_DATA_OUT:
-			if ((op->addr.buswidth != 1) ||
-			    (op->dummy.nbytes != 0) ||
-			    (op->data.buswidth != 1))
-				return false;
+			if ((op->addr.buswidth == 1) &&
+			    (op->dummy.nbytes == 0) &&
+			    (op->data.buswidth == 1))
+				return true;
 			break;
 		default:
 			break;
 		}
 	}
-	len = op->cmd.nbytes + op->addr.nbytes + op->dummy.nbytes;
-	if ((len > MTK_NOR_PRG_MAX_SIZE) ||
-	    ((op->data.nbytes) && (len == MTK_NOR_PRG_MAX_SIZE)))
-		return false;
 
-	return spi_mem_default_supports_op(mem, op);
+	return mtk_nor_match_prg(op);
 }
 
 static void mtk_nor_setup_bus(struct mtk_nor *sp, const struct spi_mem_op *op)
-- 
2.26.2

