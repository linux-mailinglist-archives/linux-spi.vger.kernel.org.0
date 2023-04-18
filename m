Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24FAE6E588E
	for <lists+linux-spi@lfdr.de>; Tue, 18 Apr 2023 07:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbjDRF3X (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 18 Apr 2023 01:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbjDRF3U (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 18 Apr 2023 01:29:20 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C20C859FA
        for <linux-spi@vger.kernel.org>; Mon, 17 Apr 2023 22:29:17 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id n66-20020a254045000000b00b95a177fbe4so119886yba.18
        for <linux-spi@vger.kernel.org>; Mon, 17 Apr 2023 22:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681795757; x=1684387757;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8xCBVt+yTzL9gm6ligFFQCFbRni90/tGiHt7eRsjBtY=;
        b=6XqlMtOxsqrT/1r2wZChHQ9ZpRkAmrUq+OgSX89spFBhvd/cSZJLUdWgaOp8WIePRa
         PSSby6xBdcgXm6GSBJtUxdkkVhgbn76OAIzMm/qb3Jd3d3cOI/DxQZSDVfK1Gyavudy/
         gqGBDA5QaQlZ1Vag2qsySvdPZlBZncqqptuZ3ZzRaiuuiXqI4vaA20IgbcB3lKGE8YfK
         IWIj5XP+2e2gi0GQshi/crBqMcV5H1AueWiSPrem+/BxIPu7Wrn2sn6kXDbbyHttpmfW
         1NpPO6KsFIIaezfKaU82RfGgYofxQzOg3y5qII5BkT2eSoKsN3e77Y/Fesk/40vFvwX4
         PwhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681795757; x=1684387757;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8xCBVt+yTzL9gm6ligFFQCFbRni90/tGiHt7eRsjBtY=;
        b=Swg2JesoaW0yr4HK5WwjVtYjSAdy9IfoT+OvAUCh653XQ/W/OXEidw4soiXedRgqUg
         JEYjyoicMjekdIxlESHhPkvAB9P6EH3+pK2G7ZHYLwX9u4NFiSSlMFqd8rKVfAwBgJ+F
         vf/XaKQf0lbwgUfiThRymTf5jrzktHkeBmaLImLDmU6IZ3DOy/3Y7SKrAVNc26Unusfv
         sn2PRXoDq3K9fqt87dYR1fjg+qvh9qIdJyMFCNuwdbJHldPjmsM7ESn+9vzGRNUHkXoI
         j6hyu4FUX9ERqUPFcSZolCF6sDnbFYX+sNrGuUcEKnmXc9U/BXDSkA6Ai5fI+PY4+/cz
         JEnw==
X-Gm-Message-State: AAQBX9eTmOZpEf+Vbe/uMTuLGfLQMzmYB5S/QN77uscUOK1iX/rAAFtf
        U7lTf1GbvZZoyrNYFIKyRcmpk1+hDu0prw==
X-Google-Smtp-Source: AKy350Yf//dH2i9AgFuLu9VrJMm1EIuJVblpEOY/OMkXrVfGj8yH/tow4BRilElcc+FFfJJqiUUwbRjvODXnkg==
X-Received: from joychakr.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:6ea])
 (user=joychakr job=sendgmr) by 2002:a05:690c:706:b0:545:5f92:f7ee with SMTP
 id bs6-20020a05690c070600b005455f92f7eemr11663447ywb.2.1681795757018; Mon, 17
 Apr 2023 22:29:17 -0700 (PDT)
Date:   Tue, 18 Apr 2023 05:28:59 +0000
In-Reply-To: <20230418052902.1336866-1-joychakr@google.com>
Mime-Version: 1.0
References: <20230418052902.1336866-1-joychakr@google.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <20230418052902.1336866-3-joychakr@google.com>
Subject: [PATCH v7 2/5] spi: dw: Move dw_spi_can_dma()
From:   Joy Chakraborty <joychakr@google.com>
To:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        manugautam@google.com, rohitner@google.com,
        Joy Chakraborty <joychakr@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Move dw_spi_can_dma() implementation below dw_spi_dma_convert_width()
for handing compile dependency in future patches.

Signed-off-by: Joy Chakraborty <joychakr@google.com>
---
 drivers/spi/spi-dw-dma.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-dw-dma.c b/drivers/spi/spi-dw-dma.c
index c1b42cb59965..f19c092920a1 100644
--- a/drivers/spi/spi-dw-dma.c
+++ b/drivers/spi/spi-dw-dma.c
@@ -198,14 +198,6 @@ static irqreturn_t dw_spi_dma_transfer_handler(struct dw_spi *dws)
 	return IRQ_HANDLED;
 }
 
-static bool dw_spi_can_dma(struct spi_controller *master,
-			   struct spi_device *spi, struct spi_transfer *xfer)
-{
-	struct dw_spi *dws = spi_controller_get_devdata(master);
-
-	return xfer->len > dws->fifo_len;
-}
-
 static enum dma_slave_buswidth dw_spi_dma_convert_width(u8 n_bytes)
 {
 	switch (n_bytes) {
@@ -220,6 +212,14 @@ static enum dma_slave_buswidth dw_spi_dma_convert_width(u8 n_bytes)
 	}
 }
 
+static bool dw_spi_can_dma(struct spi_controller *master,
+			   struct spi_device *spi, struct spi_transfer *xfer)
+{
+	struct dw_spi *dws = spi_controller_get_devdata(master);
+
+	return xfer->len > dws->fifo_len;
+}
+
 static int dw_spi_dma_wait(struct dw_spi *dws, unsigned int len, u32 speed)
 {
 	unsigned long long ms;
-- 
2.40.0.634.g4ca3ef3211-goog

