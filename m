Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 242522529DC
	for <lists+linux-spi@lfdr.de>; Wed, 26 Aug 2020 11:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbgHZJTV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 26 Aug 2020 05:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727994AbgHZJS6 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 26 Aug 2020 05:18:58 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E3E1C061574
        for <linux-spi@vger.kernel.org>; Wed, 26 Aug 2020 02:18:58 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id h2so607178plr.0
        for <linux-spi@vger.kernel.org>; Wed, 26 Aug 2020 02:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3zVbq7zEl/VylsOkImAEnSsEooCYxqv16B/0RWDkhJE=;
        b=K+PUZGRMtL+WeKb15tJBnfkVOHrBfTwHgTsG6Vhq5aOYQ9VzlMP8bC3D4H9s9Vmnwr
         T9UbSHeZLvi2f0631yma1BoIk5JYO0ZMUMnnNgxwstvJPuxz6OXM3Zei5mB9fjd+8QXu
         tOQbQiebKGt/CBAaRYhsoaC02PXAPOJ+6bDTE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3zVbq7zEl/VylsOkImAEnSsEooCYxqv16B/0RWDkhJE=;
        b=hF8L1OcoY37dY2ZpCQbLEYBZGJBHxjITLDcJap09mHKUWotdu87v8baXbAwfz9F1eP
         hGmUtas5rahwLdicfo6fa2j5hGMXnbvAm29fyN4WgN2TTFdVda8TLv0MiJv4qRKRB9aF
         XeV02P/PwQcSchKE8vsnf86UBBA8IzRxl9v5s/i22l+cfWuXimHGtDKY32ozuVJwxhxj
         k1kahyby92xIPStlsNKxro6CAv6UI6c/s5YsJBxB0fYquEkJNRtUCpnOeKS1TNG54QPU
         3oZASqarxh9BCtp7dMEK6Z39np3thU1U0JckwpUDOBOq6gip4Fm+ofNGmZ1vsRCc2eBN
         ddOw==
X-Gm-Message-State: AOAM5324NtSE2+E5CGBTXnT1syJmuGs1DCmvNXb4ndp/911GNPbMg+l0
        arzX+Dr5x/ao+uLZykUmuSA7pg==
X-Google-Smtp-Source: ABdhPJwmlAUvfRKgb9uu3liuf+trZDCW7x2GR14ieJBTwinOvb3MMKRDTkVHVMx+HWNAbWEyyr44TA==
X-Received: by 2002:a17:902:bb89:: with SMTP id m9mr7541350pls.108.1598433537693;
        Wed, 26 Aug 2020 02:18:57 -0700 (PDT)
Received: from ikjn-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:a8fc])
        by smtp.gmail.com with ESMTPSA id t20sm1922270pgj.27.2020.08.26.02.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 02:18:57 -0700 (PDT)
From:   Ikjoon Jang <ikjn@chromium.org>
To:     Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Bayi Cheng <bayi.cheng@mediatek.com>,
        Chuanhong Guo <gch981213@gmail.com>,
        Ikjoon Jang <ikjn@chromium.org>
Subject: [PATCH] spi: spi-mtk-nor: support standard spi properties
Date:   Wed, 26 Aug 2020 17:18:52 +0800
Message-Id: <20200826091852.519138-1-ikjn@chromium.org>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Use default supports_op() to support spi-[rt]x-bus-width properties.
And check dummy op's byte length instead of its bus width for output.

Signed-off-by: Ikjoon Jang <ikjn@chromium.org>
---
 drivers/spi/spi-mtk-nor.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/spi/spi-mtk-nor.c b/drivers/spi/spi-mtk-nor.c
index b08d8e9a8ee9..6e6ca2b8e6c8 100644
--- a/drivers/spi/spi-mtk-nor.c
+++ b/drivers/spi/spi-mtk-nor.c
@@ -211,25 +211,28 @@ static bool mtk_nor_supports_op(struct spi_mem *mem,
 	if (op->cmd.buswidth != 1)
 		return false;
 
-	/* DTR ops not supported. */
-	if (op->cmd.dtr || op->addr.dtr || op->dummy.dtr || op->data.dtr)
-		return false;
-	if (op->cmd.nbytes != 1)
-		return false;
-
 	if ((op->addr.nbytes == 3) || (op->addr.nbytes == 4)) {
-		if ((op->data.dir == SPI_MEM_DATA_IN) && mtk_nor_match_read(op))
-			return true;
-		else if (op->data.dir == SPI_MEM_DATA_OUT)
-			return (op->addr.buswidth == 1) &&
-			       (op->dummy.buswidth == 0) &&
-			       (op->data.buswidth == 1);
+		switch(op->data.dir) {
+		case SPI_MEM_DATA_IN:
+			if (!mtk_nor_match_read(op))
+				return false;
+			break;
+		case SPI_MEM_DATA_OUT:
+			if ((op->addr.buswidth != 1) ||
+			    (op->dummy.nbytes != 0) ||
+			    (op->data.buswidth != 1))
+				return false;
+			break;
+		default:
+			break;
+		}
 	}
 	len = op->cmd.nbytes + op->addr.nbytes + op->dummy.nbytes;
 	if ((len > MTK_NOR_PRG_MAX_SIZE) ||
 	    ((op->data.nbytes) && (len == MTK_NOR_PRG_MAX_SIZE)))
 		return false;
-	return true;
+
+	return spi_mem_default_supports_op(mem, op);
 }
 
 static void mtk_nor_setup_bus(struct mtk_nor *sp, const struct spi_mem_op *op)
-- 
2.28.0.297.g1956fa8f8d-goog

