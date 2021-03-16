Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30E7F33DC41
	for <lists+linux-spi@lfdr.de>; Tue, 16 Mar 2021 19:11:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236157AbhCPSL1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 16 Mar 2021 14:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239888AbhCPSJi (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 16 Mar 2021 14:09:38 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D4F2C061763
        for <linux-spi@vger.kernel.org>; Tue, 16 Mar 2021 11:09:37 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id b130so36182616qkc.10
        for <linux-spi@vger.kernel.org>; Tue, 16 Mar 2021 11:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qJxogbokS+CnKtxRvNwiNZnwp+8rKQY6ceDesB+XkeU=;
        b=GoKN1lhvP43nG3T5HE2l6bP38A0ITNG1oBI4XGQd+HGW1RD5GMH4ErCTDijXWseOUS
         /R8HpCa5mI/X+LSSScRJ6d+2BSqOapUz51uJuKGclbG11h3xNdlAy7i1y60MnpGPNkxI
         H/5XTWRMK0A36OMP6n6mPRsuGiX6wAquLJac436Th8UJwltrtQPZgfiXNL5v0EuSc86b
         xjc6mS+0bkjIfYaQMJagSCG6ePZOzoG7eDuWQoUfUx8lBhdRxcbtekwampXrhsG82qiR
         cswtfHe4s+8VMf3sbSogkbIdTasHxH8sOf48IMTNDZsLnzs7S7daCAn3IhatD0mwBstI
         buNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qJxogbokS+CnKtxRvNwiNZnwp+8rKQY6ceDesB+XkeU=;
        b=Cid6V9SRQ3cEf5R8apCdMQ/VF4oBu1RpvHFljOWP/kfI3XYesl4P9/I7ZBbCDydCos
         Plp19i12jr4eT0PN9CdZT0IUAY05nvvtMO75XfZxLLdBfEolRwuzwP02KlcxsYsZ327T
         Oexqx4tcfdMtF1ll2UDU5JWlVzjZNyZXMz6ks0Kwwsnhsih5+BbuGz3s+FWawnUct3e4
         Ud7VMILEH8hda8A/yVVW09ZLi0hu4skw3jR/cq/4E8yImFdg6A5HxfpsLWm/yZDqIARR
         hvUfmyEGbtDClTuafG2x4KLc6hg6jdfa/sDf58giRKGcQ53sb+kQCu1fnkc7t2YNAEFy
         bwHw==
X-Gm-Message-State: AOAM530sS0DE4NV/qMT4UanKdg1bSLmlSJNFGKN0yUbMuILAlmByKv5v
        GnTXro2hvk7Ljl0fubjvwhc=
X-Google-Smtp-Source: ABdhPJy3rr9daQE63c86u0S/ptIZuj8DH3Sj5ECjnXfO6P60QUAfWmk8aS4hEkANTsRaJHFt0c28iQ==
X-Received: by 2002:a37:a9d4:: with SMTP id s203mr337128qke.244.1615918176307;
        Tue, 16 Mar 2021 11:09:36 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:482:919::1000])
        by smtp.gmail.com with ESMTPSA id c19sm15520055qkl.78.2021.03.16.11.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 11:09:35 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, s.hauer@pengutronix.de,
        Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] spi: imx: Improve driver description
Date:   Tue, 16 Mar 2021 15:09:22 -0300
Message-Id: <20210316180922.239805-1-festevam@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

"SPI Controller driver" is a too generic description.

Make it i.MX specific instead.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 drivers/spi/spi-imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 5dc4ea4b4450..cf5519227dbd 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -1801,7 +1801,7 @@ static struct platform_driver spi_imx_driver = {
 };
 module_platform_driver(spi_imx_driver);
 
-MODULE_DESCRIPTION("SPI Controller driver");
+MODULE_DESCRIPTION("i.MX SPI Controller driver");
 MODULE_AUTHOR("Sascha Hauer, Pengutronix");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:" DRIVER_NAME);
-- 
2.25.1

