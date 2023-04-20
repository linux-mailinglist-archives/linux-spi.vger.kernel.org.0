Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C502C6E89C8
	for <lists+linux-spi@lfdr.de>; Thu, 20 Apr 2023 07:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233633AbjDTFw4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 20 Apr 2023 01:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232786AbjDTFwx (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 20 Apr 2023 01:52:53 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA2140D9
        for <linux-spi@vger.kernel.org>; Wed, 19 Apr 2023 22:52:52 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id n66-20020a254045000000b00b95a177fbe4so1318716yba.18
        for <linux-spi@vger.kernel.org>; Wed, 19 Apr 2023 22:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681969971; x=1684561971;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nKDaeGp5EKkZDqIsokus1OmDmfvkWgZNrRNY08uRrUc=;
        b=hBdio5Hud+tuSe+ZQm4GoT0N6QYKFYKojEcyGL/qjoyc/axMq0gDkSpE/VFgh26tbc
         9q8iGkzUfuitRECTe5d1TJDHxKIm68sYk9FF+2MLlGf8ehbAadYIXFn7QdnMecMeY5Fj
         LRSXD3aAKe5FaJ/yWBXcVwVpasAaWJ1hXi4lkvhtQFsmrlluih/cIQc+YesdMJaAPopG
         p4ZeKe5wK2visIca0s9Uq53oKncjovWGL61aF0nIW5v3YmpZuniZF0+u3C6jjLrI23Bj
         1EzesEb/RvRHXb2DfDm5DByZUrgffeA8os1m2UO1GM0n12djtpg2+3JkRZCaF+HnRb5K
         jqlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681969971; x=1684561971;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nKDaeGp5EKkZDqIsokus1OmDmfvkWgZNrRNY08uRrUc=;
        b=I2X4fOyl22ywp6mnQDSA8GpcTk+5buTsU/cpVso4w2on+XDFk8zi3jWY9vXNxuCOLB
         gIJum/JykkUzi28kLIQYbL1yU5MH8vBu09dCMbMHLmfnZnlNc6w2d9Bg0Db8qV+pQJJ8
         gxgh2VOQp8GEboK421GsjcW2GeQ+L+tjbvuKUPbqpyF5NaMYHG1TkoycpQO15n/iMd8r
         JCdT5MHK2c4X/eOsPh2f+aEemPiqxk67lsq/15LbFGd1XH5MkaXNCW/iOuZO7T9jRo44
         nW40HL/m2adp9/Pv/pnabPpuGAsdK431kZ0lMOQj9oTg9VX8tKC2qo063/Neqwi++sRE
         bjBA==
X-Gm-Message-State: AAQBX9cB2wTeYxozQJzcpQjevWTAhkSue8LDjpays147jcf9OCMx+Yzz
        EVb7LPVNNQjwrmMoozru3/LobwbaD4QT3g==
X-Google-Smtp-Source: AKy350Zbkqg+2egd1zA6LpwJpF6Lng4fPe/eUc7oJU056vMPU6dj6eIsj7Vu0a4/TXGx9hYvanOn+J4Ea0qdNw==
X-Received: from joychakr.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:6ea])
 (user=joychakr job=sendgmr) by 2002:a25:d284:0:b0:b92:2c78:1481 with SMTP id
 j126-20020a25d284000000b00b922c781481mr308871ybg.12.1681969971649; Wed, 19
 Apr 2023 22:52:51 -0700 (PDT)
Date:   Thu, 20 Apr 2023 05:51:27 +0000
In-Reply-To: <20230420055131.2048959-1-joychakr@google.com>
Mime-Version: 1.0
References: <20230420055131.2048959-1-joychakr@google.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <20230420055131.2048959-2-joychakr@google.com>
Subject: [PATCH v8 1/5] spi: dw: Add 32 bpw support to SPI DW DMA driver
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add Support for AxSize = 4 bytes configuration from dw dma driver if
n_bytes i.e. number of bytes per write to fifo is 4.

Number of bytes written to fifo per write is depended on the bits/word
configuration being used which the DW core driver translates to n_bytes.
Hence, for bits per word values between 17 and 32 n_bytes should be
equal to 4.

Signed-off-by: Joy Chakraborty <joychakr@google.com>
---
 drivers/spi/spi-dw-dma.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-dw-dma.c b/drivers/spi/spi-dw-dma.c
index ababb910b391..c1b42cb59965 100644
--- a/drivers/spi/spi-dw-dma.c
+++ b/drivers/spi/spi-dw-dma.c
@@ -208,12 +208,16 @@ static bool dw_spi_can_dma(struct spi_controller *master,
 
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
+	case 4:
+		return DMA_SLAVE_BUSWIDTH_4_BYTES;
+	default:
+		return DMA_SLAVE_BUSWIDTH_UNDEFINED;
+	}
 }
 
 static int dw_spi_dma_wait(struct dw_spi *dws, unsigned int len, u32 speed)
-- 
2.40.0.634.g4ca3ef3211-goog

