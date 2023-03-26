Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13E056C9736
	for <lists+linux-spi@lfdr.de>; Sun, 26 Mar 2023 19:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbjCZRfc (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 26 Mar 2023 13:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231764AbjCZRfa (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 26 Mar 2023 13:35:30 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FE447689
        for <linux-spi@vger.kernel.org>; Sun, 26 Mar 2023 10:35:28 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id e186-20020a2537c3000000b00b72501acf50so6618432yba.20
        for <linux-spi@vger.kernel.org>; Sun, 26 Mar 2023 10:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679852128;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sPVKlHs8rdxB8UK5BU2ADWdalnh8Q9IQfmw/DaMpLMc=;
        b=n3l4VP3mBK1TbVo+LuBhHS5QICjfCzLhCC6pa7ew6+DG3lrLqM0jcVExkrHkPMB+R9
         /RnmY9i2TkcdGJZHEjrEftiOmH8ad81+0GBzt+vFoJG3ujqZkELsxafZmHOdN6ihUYM6
         mWYbIIdQO85MqMiws+BP4Gsm2WjIPMY2FafUxI/bQdMAh7py8RrdwxKUYDy72wtrnyZM
         zVOQ5FdaZeYq5ca3iPHPyLX5M93KahY1eviix1UcBl5uaj9G3FJCen4sjV9lHkK7AwPc
         OzvJ/TlkLhDFBlkPRiHvft3d+8kiN5qMHIXB4G9jZpm1h2lhKCB/OYFf39g7acaQYRGF
         gHKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679852128;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sPVKlHs8rdxB8UK5BU2ADWdalnh8Q9IQfmw/DaMpLMc=;
        b=mg1r8je9Obh6fzK6GPfKUAZ3mraM18tT8mQ0r7jrIi/4eGDN6ddsyTOgYI2tSuLlvC
         UWNBTu8vnnms7Fgc+y3Ry1AnCCG8xUh2Frqf5/Z6eHneSveLWThyHaMswsoMADGndPi4
         z9dngQLoW5Gf6NQnzt5eyEGz9mYkhE98oVFPW3w7yj0TAdGFcyhtyl7BdSBG0ppq3v7u
         gQplVXFtgODSfvawFKkAfvwiLbYtXZ6N/vJ4B9jFubAdaj2t3zu3ZYtdoUURMqGqJK1h
         KcWrcpr6EOF8Xxm6ihDKi5qsg+kq//+tiNZxrJde0HpA1bTwbBFkfdhBobEPMGLM49wI
         9Dsw==
X-Gm-Message-State: AAQBX9dIW74QeMDWK3dpEGDDmkMOGUIHwHYFfZcmYdurXbsm+gFSozd2
        KDHVexvVnCK0IR6VCNe7og8IvO612VONww==
X-Google-Smtp-Source: AKy350ZSP6WrRql/Jvriaoj5YJN/Ndy94xPRoSF7VV0rufaPFiQH2/Gn+sK8NJf8CsfNeGvIv6OF6E7Ef28NSA==
X-Received: from joychakr.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:6ea])
 (user=joychakr job=sendgmr) by 2002:a05:6902:1083:b0:b6d:1483:bc0f with SMTP
 id v3-20020a056902108300b00b6d1483bc0fmr4303725ybu.9.1679852128113; Sun, 26
 Mar 2023 10:35:28 -0700 (PDT)
Date:   Sun, 26 Mar 2023 17:35:10 +0000
In-Reply-To: <20230326173511.710749-1-joychakr@google.com>
Mime-Version: 1.0
References: <20230326173511.710749-1-joychakr@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <20230326173511.710749-2-joychakr@google.com>
Subject: [PATCH v3 1/2] spi: dw: Add 32 bpw support to DW DMA Controller
From:   Joy Chakraborty <joychakr@google.com>
To:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        manugautam@google.com, rohitner@google.com,
        Joy Chakraborty <joychakr@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add Support for AxSize = 4 bytes configuration from dw dma driver if
n_bytes i.e. number of bytes per write to fifo is 3 or 4.

Number of bytes written to fifo per write is depended on the bits/word
configuration being used which the DW core driver translates to n_bytes.

Signed-off-by: Joy Chakraborty <joychakr@google.com>
---
 drivers/spi/spi-dw-dma.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-dw-dma.c b/drivers/spi/spi-dw-dma.c
index ababb910b391..b3a88bb75907 100644
--- a/drivers/spi/spi-dw-dma.c
+++ b/drivers/spi/spi-dw-dma.c
@@ -208,12 +208,17 @@ static bool dw_spi_can_dma(struct spi_controller *master,
 
 static enum dma_slave_buswidth dw_spi_dma_convert_width(u8 n_bytes)
 {
-	if (n_bytes == 1)
+	switch (n_bytes) {
+	case 1:
 		return DMA_SLAVE_BUSWIDTH_1_BYTE;
-	else if (n_bytes == 2)
+	case 2:
 		return DMA_SLAVE_BUSWIDTH_2_BYTES;
-
-	return DMA_SLAVE_BUSWIDTH_UNDEFINED;
+	case 3:
+	case 4:
+		return DMA_SLAVE_BUSWIDTH_4_BYTES;
+	default:
+		return DMA_SLAVE_BUSWIDTH_UNDEFINED;
+	}
 }
 
 static int dw_spi_dma_wait(struct dw_spi *dws, unsigned int len, u32 speed)
-- 
2.40.0.348.gf938b09366-goog

