Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42DD72780F0
	for <lists+linux-spi@lfdr.de>; Fri, 25 Sep 2020 08:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727292AbgIYGye (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 25 Sep 2020 02:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727151AbgIYGyd (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 25 Sep 2020 02:54:33 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68481C0613CE
        for <linux-spi@vger.kernel.org>; Thu, 24 Sep 2020 23:54:33 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id k133so1722298pgc.7
        for <linux-spi@vger.kernel.org>; Thu, 24 Sep 2020 23:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X6A7I2+xa+JzqfUUJmmCkQYIIjfofSHKtXj6ieBn98k=;
        b=X6OR+Kzr1L29x1BQVGldMkJqu8KRWqcyEcYQJD+ya42lnml69EzPYF9ouzFHvDwXIU
         znn3F7jcsx24lM/hZxLfd6CZS9wcsK+YefmG7jjFFrsZna9EEaJzH1c2mMj55g4AQ1N9
         JNTp73XgNucjtRN7dYa3pW6DP0JDe8gFoxuFc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X6A7I2+xa+JzqfUUJmmCkQYIIjfofSHKtXj6ieBn98k=;
        b=pg7BEw6Qv/u8PVTEoK3LiFiPrshlWph6hqrhXBPCGfo3dEKB35RO7bgnkPAfQHV4j0
         WJt/UW2tScCWnYuZjhIJJ3ZkEosWLyFArrZkBkRBKNhf2qmKmLhmr3bH+KRJuJwxvAQ+
         AbSndAGHzcPr4FW7zFe30YZpvIsrk330UKjN+fiAPMQbmsal5oHMHaJ7k9MDXffN6BZ5
         9zlwGruZxjVJMvwcecDnSW7Fi3JorRwgyv1+B1feyrS99fy3gFfE1JyzIg+5gWoiMZpd
         dps2iXji26l4Riye1mBYLuPBD2l4TrrFGwFmt+fWhhJbPKp5YtK0x11Sn3JPBGJI7UOa
         6qJQ==
X-Gm-Message-State: AOAM532v19h7Da4d5OtPKImRcrERr2ieJbxl3czOhmH2FAUyPnXMQHAO
        wz3yoV5rHN6wyIGvkNLKeA2Wjg==
X-Google-Smtp-Source: ABdhPJz6kdElWH7oBxMzrNtroD9NdXSuNaRDKOUS8ZeMpdwM7u/op/NfT2A0F8AbN8AIg0ARptiwAg==
X-Received: by 2002:a17:902:d913:b029:d1:f388:9fa6 with SMTP id c19-20020a170902d913b02900d1f3889fa6mr2963337plz.67.1601016872951;
        Thu, 24 Sep 2020 23:54:32 -0700 (PDT)
Received: from ikjn-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:a8fc])
        by smtp.gmail.com with ESMTPSA id x27sm1549612pfp.128.2020.09.24.23.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 23:54:32 -0700 (PDT)
From:   Ikjoon Jang <ikjn@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
        devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-mtd@lists.infradead.org
Cc:     Ikjoon Jang <ikjn@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v3 2/6] spi: spi-mtk-nor: fix mishandled logics in checking SPI memory operation
Date:   Fri, 25 Sep 2020 14:54:13 +0800
Message-Id: <20200925145255.v3.2.I48d59ef5398f3633c6ebbab093da6b4b06495780@changeid>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
In-Reply-To: <20200925065418.1077472-1-ikjn@chromium.org>
References: <20200925065418.1077472-1-ikjn@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Fix a bug which limits its protocol availability in supports_op().

Fixes: a59b2c7c56bf ("spi: spi-mtk-nor: support standard spi properties")
Signed-off-by: Ikjoon Jang <ikjn@chromium.org>
---

(no changes since v1)

 drivers/spi/spi-mtk-nor.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/drivers/spi/spi-mtk-nor.c b/drivers/spi/spi-mtk-nor.c
index 6e6ca2b8e6c8..0f7d4ec68730 100644
--- a/drivers/spi/spi-mtk-nor.c
+++ b/drivers/spi/spi-mtk-nor.c
@@ -211,28 +211,24 @@ static bool mtk_nor_supports_op(struct spi_mem *mem,
 	if (op->cmd.buswidth != 1)
 		return false;
 
+	if (!spi_mem_default_supports_op(mem, op))
+		return false;
+
 	if ((op->addr.nbytes == 3) || (op->addr.nbytes == 4)) {
-		switch(op->data.dir) {
-		case SPI_MEM_DATA_IN:
-			if (!mtk_nor_match_read(op))
-				return false;
-			break;
-		case SPI_MEM_DATA_OUT:
-			if ((op->addr.buswidth != 1) ||
-			    (op->dummy.nbytes != 0) ||
-			    (op->data.buswidth != 1))
-				return false;
-			break;
-		default:
-			break;
-		}
+		if ((op->data.dir == SPI_MEM_DATA_IN) && mtk_nor_match_read(op))
+			return true;
+		else if (op->data.dir == SPI_MEM_DATA_OUT)
+			return (op->addr.buswidth == 1) &&
+			       (op->dummy.nbytes == 0) &&
+			       (op->data.buswidth == 1);
 	}
+
 	len = op->cmd.nbytes + op->addr.nbytes + op->dummy.nbytes;
 	if ((len > MTK_NOR_PRG_MAX_SIZE) ||
 	    ((op->data.nbytes) && (len == MTK_NOR_PRG_MAX_SIZE)))
 		return false;
 
-	return spi_mem_default_supports_op(mem, op);
+	return true;
 }
 
 static void mtk_nor_setup_bus(struct mtk_nor *sp, const struct spi_mem_op *op)
-- 
2.28.0.681.g6f77f65b4e-goog

