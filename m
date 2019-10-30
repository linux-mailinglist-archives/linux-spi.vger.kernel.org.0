Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 874CDE973B
	for <lists+linux-spi@lfdr.de>; Wed, 30 Oct 2019 08:36:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726032AbfJ3HgX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 30 Oct 2019 03:36:23 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43958 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725923AbfJ3HgX (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 30 Oct 2019 03:36:23 -0400
Received: by mail-lf1-f65.google.com with SMTP id j5so740094lfh.10
        for <linux-spi@vger.kernel.org>; Wed, 30 Oct 2019 00:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IHuCfvtvtoewtzJbmoH93KQaYqaLyKZ5qZchPWveUls=;
        b=VNQoZ8DHXVhvWoiFUj2EmkeZ1wzcYyE9OkPWbiX7vZ99XdGblKH4JCQW2eAx+SuxSZ
         LpgzIz+D0fkHbN1+QTf1QDnpV+kSuEsWrBk36m1h0VWilthuli/bZOmC1PIamAuj8vsm
         sqWP1mYQaSyTtL7kxgeKJBst90WA3C0fXaUTpCRzQxCgDjlJYOCxUNHU/wmafoedeQmk
         eOt+wKT2Vgx5E0gES+tX1TymLC4rwUNDEC0xzbt5mtU6FfylrC3g9NXAyDyHw4lqeYbU
         Cy5LMUF/nF7tkfH2OQC3Y2Vqx42aspxuXj0k4vJK18bk2sv2kpyd5iLKZE8W2Dltqoyk
         83sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IHuCfvtvtoewtzJbmoH93KQaYqaLyKZ5qZchPWveUls=;
        b=cdvvCqDRsa1biFdZllEO0yOBF39YtTf7m70DyeaIVcd3nJiylBMooG+Wa8O05emJJe
         G3/+iFh4N7aDkuUG0FOIwpV87ueozEJ4S1LeiLKhk0mYofPxqMff+Mz3Uct/hHguXGnN
         E558AzKHdVETOtx+2cvP1MdRAdGzpVHSuNkE1rLfXOkxm0S9djoFjZBDVbz2fUBKMd0i
         gV2zJUmJxwnlsz84TgHStXolfG4FGq1HL75T3vXHm/7U0TLStY1/205srvxSQjIQjHDU
         WzQ5tR34uIGuliyV8XaiLXNVvQGcJrRINWoPhTV+U4Bn2Prdoop4iWK7SDVxX/taW5wV
         uCOw==
X-Gm-Message-State: APjAAAUndan064lMTt6Qh4P2vQUfYVRTXJC2t4HYE+gUqcORCzsavVe6
        Udwkxd9MedGmaA5H+E0ybXfpeQ==
X-Google-Smtp-Source: APXvYqwDg5xFnFWqtFtLDN4LDJeiy3PZwK164nqdc3Qs8+CH3I7Ai6mTHc5lo0FNMQgkE11ds6kJ+Q==
X-Received: by 2002:a19:ad4a:: with SMTP id s10mr5036054lfd.159.1572420981150;
        Wed, 30 Oct 2019 00:36:21 -0700 (PDT)
Received: from localhost.localdomain (c-79c8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.200.121])
        by smtp.gmail.com with ESMTPSA id d27sm779413lfb.3.2019.10.30.00.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2019 00:36:19 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc:     linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] spi: dw: Drop GPIO header
Date:   Wed, 30 Oct 2019 08:34:18 +0100
Message-Id: <20191030073418.23717-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The DW driver does not use the legacy GPIO header so drop
it from the spi-dw.h include.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/spi/spi-dw.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index c9c15881e982..38c7de1f0aa9 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -4,7 +4,6 @@
 
 #include <linux/io.h>
 #include <linux/scatterlist.h>
-#include <linux/gpio.h>
 
 /* Register offsets */
 #define DW_SPI_CTRL0			0x00
-- 
2.21.0

