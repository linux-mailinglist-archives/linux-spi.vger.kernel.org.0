Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 118466E5894
	for <lists+linux-spi@lfdr.de>; Tue, 18 Apr 2023 07:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbjDRF3s (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 18 Apr 2023 01:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbjDRF3q (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 18 Apr 2023 01:29:46 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E16C65B0
        for <linux-spi@vger.kernel.org>; Mon, 17 Apr 2023 22:29:31 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-24708bfb463so1347358a91.0
        for <linux-spi@vger.kernel.org>; Mon, 17 Apr 2023 22:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681795771; x=1684387771;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Fmf17OkL5SCBMBWD99k+zYNzeo76qcWOQzqTUdEaNA4=;
        b=ZLGNlq1PGDuNXmKXCLEpwmCrcSVfz8bJTIn49O4DCgqv4BhkDZPhhsZZqXBoVChY4+
         Ra4LogSmWM4SDLlCF7CSa4DPJ5nSCBspbm82HDOGzaGkTlGaNSBT0E1ZSB7aNab3llYn
         Ix7lWThLXLkhH0eOr+JohXRTjVQUdlA++00RQl2KVy784t6G/WBvEmUXA7+NnFt8AP18
         xCt2KWflMpoZkec7CqL5XH/aZXVICoNiD+ymyHfhXbGnazme9J1wWTxmpnZLXlF7GlMy
         QsJ7TbF3vu4Y9erMH8vv+2tqX9teQG0ilKR6CUhtZFSnnEYffZj5ANb6hn7OBDEqBP7x
         ZTtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681795771; x=1684387771;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fmf17OkL5SCBMBWD99k+zYNzeo76qcWOQzqTUdEaNA4=;
        b=ExLDBrH0cP337FcKRCPuZsUtvids6svlH6856Ng2RoOzBKcpjgMxU+089J+0DL7Ycd
         2/dVCufpNPSSPMC6uzN3OF/YIKmt2622+fv7oq3dfT25o+k4lYC/BgToQRO0k8MaR9sG
         8gA8dS4Bb64GN+x0M15zPbYQM4A/VPbZ/rPimuYsr8N5YzwtU8eOHtYkRn/qyNyCmje6
         j1i0LJ+/khUnuOXNGJ1IC9sneFbBb5Fvlc/LOcru1iwgA/onWsoQHwLqaoMdmnBP+hIA
         dqCsxIXHfiSNBHswHDbF1/fOQ195c13P9bx3B3j8faP6cbbeIiQwUDTE2v9+ZJ35XheZ
         kXQA==
X-Gm-Message-State: AAQBX9d7sIy6Zq7k24YuxWIDuQQOwRTCG/tOMl6ZcLKlItqR/V+NN6nY
        DPtZeqsoNV2zewGqfEJALPlqauKBl66Qzg==
X-Google-Smtp-Source: AKy350aajvAgsYG7NiI4EKXnrMPoSQwdFAFDCxuRpR+k/AvuEzgKLZO54jV/kPal++hSl5YcIVmP4pdBx8AHtw==
X-Received: from joychakr.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:6ea])
 (user=joychakr job=sendgmr) by 2002:a17:90a:2b07:b0:240:c13d:1325 with SMTP
 id x7-20020a17090a2b0700b00240c13d1325mr280814pjc.5.1681795771097; Mon, 17
 Apr 2023 22:29:31 -0700 (PDT)
Date:   Tue, 18 Apr 2023 05:29:02 +0000
In-Reply-To: <20230418052902.1336866-1-joychakr@google.com>
Mime-Version: 1.0
References: <20230418052902.1336866-1-joychakr@google.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <20230418052902.1336866-6-joychakr@google.com>
Subject: [PATCH v7 5/5] spi: dw: Round of n_bytes to power of 2
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

