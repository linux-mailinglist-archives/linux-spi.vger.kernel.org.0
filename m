Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD4E27AB8A4
	for <lists+linux-spi@lfdr.de>; Fri, 22 Sep 2023 19:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233390AbjIVRzl (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 22 Sep 2023 13:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233167AbjIVRzT (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 22 Sep 2023 13:55:19 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C7F272A
        for <linux-spi@vger.kernel.org>; Fri, 22 Sep 2023 10:53:25 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-274b3d48e15so1682742a91.0
        for <linux-spi@vger.kernel.org>; Fri, 22 Sep 2023 10:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695405204; x=1696010004; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IKU0OOROZX8GtXmlmWtOSoc3m5tAbejEF8ueJbXNfc4=;
        b=F58ptNvBVKPGVaAMka8B0iZ/kGkA3NLoJFen4r6FZYlwVinh261WVZhVNwNNOciVny
         4DcqwtxzJHW1bv6vFwI/MR920QoJP15/trvKvGxJsVx96ij95Z1Aks9iOS8+gGq523HI
         cOfOqNse7sm2a4Gnr26nKCWAqoRuwkrzH8yPE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695405204; x=1696010004;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IKU0OOROZX8GtXmlmWtOSoc3m5tAbejEF8ueJbXNfc4=;
        b=Fqm5wEe3rN4KYDQDCnH+iQvjwnJI0WAEsawvvsaplsXU7k+cI3rp/4iITz7tLf9LX7
         08MuPxcSyMpvMiUS07Ss6843P0x0cryAyfiJs6KdXmz6aaQkGPrvNPq4c2XZ1ElKjAb4
         x4rILsbbqH/XIsa9WQRAREPvf/hO9sNk5nBat75C+6dExapSvPmYoWS9MIRgzVamzjGY
         W8lkRwH66hO8pkiiOqMr2ia0J3bAhfFZYP6zNaAVsmBxRnDasnufjdrZJ5BRUyL4fyIA
         8lrObETnGHBcADowNXmoeex0vT4smMIFwFMTxLRJ3Y/7xgW/j7LquiErxCoZ5wiOvNTV
         aDCA==
X-Gm-Message-State: AOJu0YwRcdUJ1atm7T6J1II8C4t05biNggBMEo6Xq8P21pkuh6kjJcGx
        YwnMmQJjHy8DmSEuCm2Ytx3v5w==
X-Google-Smtp-Source: AGHT+IH/7MhTV633GUCdb/yWyD942bovfP7gG5TgqmAQGp2zBjX1j6I8VUXAYvte8NevDqdv1szPDw==
X-Received: by 2002:a17:90b:1010:b0:274:6839:6a8c with SMTP id gm16-20020a17090b101000b0027468396a8cmr417452pjb.6.1695405204678;
        Fri, 22 Sep 2023 10:53:24 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id gp24-20020a17090adf1800b00268032f6a64sm5263304pjb.25.2023.09.22.10.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 10:53:24 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-spi@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: [PATCH] spi: mchp-pci1xxxx: Annotate struct pci1xxxx_spi with __counted_by
Date:   Fri, 22 Sep 2023 10:53:23 -0700
Message-Id: <20230922175322.work.170-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1195; i=keescook@chromium.org;
 h=from:subject:message-id; bh=e8Sf0qGa4GnkduLkbR5QVFirRy5SjwftZRC9XwaCaCY=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlDdSTbzRFK4+Or9MsQ5t6WkcBxx10MfOAmUZo3
 pFRqrY3QsqJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQ3UkwAKCRCJcvTf3G3A
 JtW1D/0Z2xHXPyQGLIdKy1N7E/opbora00YtESYD+ty6cAdcM4pNdrtP+Jq3IH5IOOGBWn9n1eS
 8uG7hhmdw03xWE2evg0UZh3CgNCbhMBtcmy8MK8iPe3+gN/eTFfXr2sJrgUB2Qw749p3CWg2iew
 IfNsRu1jQAo6Aa77Jkp3bwvCKP0d3k196ICBYnePUOrosEyIETz+XId1BgfUFQIYfsN2oK8h875
 Tsu5WRENvEW1sI7BcjEk4hdYF6bLypg4kZpU+T9Ss5majLz4bYsG60uxFt77nH92rr5Qm78V+LR
 z8XII87IrDNiXgFrE7X6V/wyLDQ7feSQq5Y51LZIyQM9NQcH1humoQ2mCYrabvaWFaqEF3cEsF7
 275CdvQYgQXmatoG6GDm/mM5aeAU/5i/vvkAI35lEmW/Vf4VMbtcuB335o2K5v4R4kwZLkTf3Qg
 VQ62z2h9jSMFmNhCX/nL0h4aWZYOo6j0zjy42/nyQT+7jTvC2a4c6bmcOnwBiX/bI58sPtDBgnA
 Ick8nKcuJTVRD+DFYmPiAExYWBqzEfcggr7Ex5akn7SYwglRZ4bC84R8lksWvp19CN9VOaJy5mp
 vI5eTc1MJxnXmy6bVagZocn/17k/A1thqk5TU7ysuKVlx6nGUCcIR9AEhvvJ/KJEnGWV3I9wErM
 Uo/pDz6 SkGkVu0g==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
(for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct pci1xxxx_spi.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/spi/spi-pci1xxxx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-pci1xxxx.c b/drivers/spi/spi-pci1xxxx.c
index 3638e974f5d4..5b2d3e4e21b7 100644
--- a/drivers/spi/spi-pci1xxxx.c
+++ b/drivers/spi/spi-pci1xxxx.c
@@ -77,7 +77,7 @@ struct pci1xxxx_spi {
 	struct pci_dev *dev;
 	u8 total_hw_instances;
 	void __iomem *reg_base;
-	struct pci1xxxx_spi_internal *spi_int[];
+	struct pci1xxxx_spi_internal *spi_int[] __counted_by(total_hw_instances);
 };
 
 static const struct pci_device_id pci1xxxx_spi_pci_id_table[] = {
-- 
2.34.1

