Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 026676E22D9
	for <lists+linux-spi@lfdr.de>; Fri, 14 Apr 2023 14:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbjDNMGQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 14 Apr 2023 08:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbjDNMGN (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 14 Apr 2023 08:06:13 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F24F6AD27
        for <linux-spi@vger.kernel.org>; Fri, 14 Apr 2023 05:05:49 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-54c17fb245dso239897117b3.21
        for <linux-spi@vger.kernel.org>; Fri, 14 Apr 2023 05:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681473949; x=1684065949;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Fmf17OkL5SCBMBWD99k+zYNzeo76qcWOQzqTUdEaNA4=;
        b=BjBk4IFfphPEvkF6oNu0FALs6uDTF7SOGFv3xTJX9fN+uejADR6Jzn/lNLnIuNHVaS
         7rK0a+DvjrxnYz2Nc6HcVasynWLHhIY2+xJw9uGOOQYkxclfiVPQrYrB/7tyIMsM04j0
         tt/ToVH+x2LAv0Zk66w7fjuo571bhxyaYUbq4r3r0No8bHmqgiZz0sTryCw7bvu85vKX
         WIF4wo+llgaXEzmoubYyqe5rHKGjcJ7q3xmHdwAyoWE7mITNRmDV990wb4UToHE6vdJB
         7nNI62LjTFqAyebdPa+uMh8n7u5b7PWA+50T1QrAiKnlYZctziaSErhec27QXUPE+JXD
         iK9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681473949; x=1684065949;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fmf17OkL5SCBMBWD99k+zYNzeo76qcWOQzqTUdEaNA4=;
        b=I1c9KWdI90sTojMjxJ+TKOByJ9RIavD75AR/jaQCw1JSTCxQ/SdF2QNsyZgccEuNN2
         WKDwx+QwgiWMw6gYg+aqNifamv5YMDzwXJncg47GiD46uiAUuRsU50wCfe2VhXBu8YQ7
         vrbu4HcjbVO/hlqHky4SjkwgYwrILP4E/4CxPGWmiSzs4g2Aduf/N9L5yY8aCjrjbzbl
         KGbt9GUcMnDer6qbVFHwakuVdCqe4war58H2b6+Ngo9P95h9USpk9riP5Er+beN2By3v
         yVy6xz0nC5IbcX3vU+2MHLmLDI/xCJR5WTgxNSRb1eBC/wnlZKa5YGwi6cCYzOetMC0R
         oeHg==
X-Gm-Message-State: AAQBX9ecGCp/0IwOFaEnR2J1tYGvlF5MsVLwBHzlBDcIIgJco9NkRBiV
        ZX4vCuZxsqIWL0pGhmMcu4pvk2poufyOFw==
X-Google-Smtp-Source: AKy350btW+p1AMej9BMNQTOwi1zlSSgujlz7EFCFmu5Ck4LJ+KBKvqkoAjGiLKh42cRQVIydYBvZfMzF9ULK4A==
X-Received: from joychakr.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:6ea])
 (user=joychakr job=sendgmr) by 2002:a25:ca83:0:b0:b8f:6944:afeb with SMTP id
 a125-20020a25ca83000000b00b8f6944afebmr1727314ybg.3.1681473948816; Fri, 14
 Apr 2023 05:05:48 -0700 (PDT)
Date:   Fri, 14 Apr 2023 12:05:20 +0000
In-Reply-To: <20230414120520.360291-1-joychakr@google.com>
Mime-Version: 1.0
References: <20230414120520.360291-1-joychakr@google.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <20230414120520.360291-6-joychakr@google.com>
Subject: [PATCH v6 5/5] spi: dw: Round of n_bytes to power of 2
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

n_bytes variable in the driver represents the number of bytes per word
that needs to be sent/copied to fifo. Bits/word can be between 8 and 32
bits from the client but in memory they are a power of 2, same is mentioned
in spi.h header:
"
 * @bits_per_word: Data transfers involve one or more words; word sizes
 *	like eight or 12 bits are common.  In-memory wordsizes are
 *	powers of two bytes (e.g. 20 bit samples use 32 bits).
 *	This may be changed by the device's driver, or left at the
 *	default (0) indicating protocol words are eight bit bytes.
 *	The spi_transfer.bits_per_word can override this for each transfer.
"

Hence, round of n_bytes to a power of 2 to avoid values like 3 which
would generate unalligned/odd accesses to memory/fifo.

Fixes: a51acc2400d4 ("spi: dw: Add support for 32-bits max xfer size")
Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Joy Chakraborty <joychakr@google.com>
---
 drivers/spi/spi-dw-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index c3bfb6c84cab..a6486db46c61 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -426,7 +426,7 @@ static int dw_spi_transfer_one(struct spi_controller *master,
 	int ret;
 
 	dws->dma_mapped = 0;
-	dws->n_bytes = DIV_ROUND_UP(transfer->bits_per_word, BITS_PER_BYTE);
+	dws->n_bytes = roundup_pow_of_two(DIV_ROUND_UP(transfer->bits_per_word, BITS_PER_BYTE));
 	dws->tx = (void *)transfer->tx_buf;
 	dws->tx_len = transfer->len / dws->n_bytes;
 	dws->rx = transfer->rx_buf;
-- 
2.40.0.634.g4ca3ef3211-goog

