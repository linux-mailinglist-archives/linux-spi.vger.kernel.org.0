Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDC916FC1AB
	for <lists+linux-spi@lfdr.de>; Tue,  9 May 2023 10:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234839AbjEIIXh (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 9 May 2023 04:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233749AbjEIIX0 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 9 May 2023 04:23:26 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F8D8D2F7
        for <linux-spi@vger.kernel.org>; Tue,  9 May 2023 01:23:14 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-55d9a9d19c9so77452427b3.1
        for <linux-spi@vger.kernel.org>; Tue, 09 May 2023 01:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683620593; x=1686212593;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EOqtouxRu25HRRsWlk2RLw7lnYbQ6zK+okIr8VJZgWs=;
        b=DzKDPmMEpZHjb9GuaKoRNMsHWMhtL9oVCv0krVFeDx3758tICEhyUNkOrse8cAKqLS
         3phGAD7as5/VjeDKqJAc7r8JScHrf9QIQ7hPFdfbPNXYOcxXP/tbUqeP3SroM2IMIQ+j
         W3MS7WdHxLXxKFyWDF7s5buuMqpLjryFJIERteQbjNtAyssZK7P30HxanRG2FtHfj6rA
         irmKx5af8Dixewafm4ngw2zEVpyeTMGddd7k7xTzTRfboRUySqZXbhhyODBkVUyijzMc
         l5+Gxi2eM95Vv29rd/EqJ3jOzqxQKIyVcEV+qDRUEkRS0El5b6Nov5RxWB6vh9eA3pVy
         RDzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683620593; x=1686212593;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EOqtouxRu25HRRsWlk2RLw7lnYbQ6zK+okIr8VJZgWs=;
        b=IDkQidm38LY7+EPo1RP4E3Us2uXv794xNDdkSUBCdS7lhzBsUlBf/1az3zNs4Mj4ki
         +XgftGRr/zNONdhtRVObgH9m46Y4Y5hVQmKggilxMj7RRkMjAxyXcZL168wdE0pMirGn
         oHK4gR5nGn9KNWqLqGZXZBwywgsS3QqdcmwGSpcoY9x5Kz+ibRonVRNgdZpNc6a3h0U9
         iBVQEWlqTfoYQGi04agfQl78kHloW8wMIYFNbfbTJyZIoJhvRfr8Uzg+Euy+01spQL5e
         Zujw6Mc7duVcb43VtCXBfbXp2tGHJ0Aw8YixtPxLACsxEFCnbsyxvfRAtIL3NTLZ+2fR
         U48g==
X-Gm-Message-State: AC+VfDzWpzXUIo/Hoe6duFxYhz6GfpHZioAopT5Pt3qR2s7PPsC9KMP6
        UG/q/U5txZusBpK+tGibPRADX9coS/ebfg==
X-Google-Smtp-Source: ACHHUZ4XbHXAlK/d1ZXHVHpmbaQP/hWvDOZbsJII83AzL84Im5dgEZyeWJYq2SKh58+6rINiLiFE2xjNvOqoSA==
X-Received: from joychakr.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:6ea])
 (user=joychakr job=sendgmr) by 2002:a81:af0e:0:b0:55a:5641:54be with SMTP id
 n14-20020a81af0e000000b0055a564154bemr8245389ywh.6.1683620593763; Tue, 09 May
 2023 01:23:13 -0700 (PDT)
Date:   Tue,  9 May 2023 08:22:44 +0000
In-Reply-To: <20230509082244.1069623-1-joychakr@google.com>
Mime-Version: 1.0
References: <20230509082244.1069623-1-joychakr@google.com>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
Message-ID: <20230509082244.1069623-6-joychakr@google.com>
Subject: [PATCH v10 5/5] spi: dw: Round of n_bytes to power of 2
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
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
Tested-by: Serge Semin <fancer.lancer@gmail.com>
* tested on Baikal-T1 based system with DW SPI-looped back interface
transferring a chunk of data with DFS:8,12,16.
---
 drivers/spi/spi-dw-core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index c3bfb6c84cab..4976e3b8923e 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -426,7 +426,10 @@ static int dw_spi_transfer_one(struct spi_controller *master,
 	int ret;
 
 	dws->dma_mapped = 0;
-	dws->n_bytes = DIV_ROUND_UP(transfer->bits_per_word, BITS_PER_BYTE);
+	dws->n_bytes =
+		roundup_pow_of_two(DIV_ROUND_UP(transfer->bits_per_word,
+						BITS_PER_BYTE));
+
 	dws->tx = (void *)transfer->tx_buf;
 	dws->tx_len = transfer->len / dws->n_bytes;
 	dws->rx = transfer->rx_buf;
-- 
2.40.1.521.gf1e218fcd8-goog

