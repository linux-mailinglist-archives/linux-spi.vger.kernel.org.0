Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CEC6FA06A
	for <lists+linux-spi@lfdr.de>; Wed, 13 Nov 2019 02:44:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbfKMBou (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 12 Nov 2019 20:44:50 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37743 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727021AbfKMBou (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 12 Nov 2019 20:44:50 -0500
Received: by mail-lj1-f195.google.com with SMTP id d5so643749ljl.4
        for <linux-spi@vger.kernel.org>; Tue, 12 Nov 2019 17:44:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TSetjMkcf4RpuPYXlFbAM0zaTljwaDUanV3PLKAWDpw=;
        b=Gx9/4wLyPBmCchNwrslkyoWt00c+XPhTBrtJRbJaQthp30BZrJ0iqN1q5jOKigdLIS
         TMxaZcP9iVEuxOhzinjmVT4Y+80rqdy7XN8YBtK5Qk4XgW1U2Ufoqy7Hl0+O+r5FJvH9
         pUgtMI6o2fbew8jPafNEBEyf1Tg8exaG55ESxXy2zs39Cs7lXPuCo5XJ2wMcLTBXLh9K
         uVhlE/lDu7PjVrlKD44Ue2/cUaYZPWvzGIB1lD/IvAa6uHvVHad+s/h+fzg4fkGk0wBM
         vPbXsSCVEAgA441J0C4I8L2Kjb8/VCG2MSDx1mb1AJYo89N0gRRF43oy9qBv5J5w7dNP
         ARlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TSetjMkcf4RpuPYXlFbAM0zaTljwaDUanV3PLKAWDpw=;
        b=WgbDOSHeo80tVE9uhk/2gnKzrGEY564w9Dt6wUUISbcLFeXgb+VwXfhGdjtHyPnvKr
         tLQ4qf9KnyZHeaAaarKITHh3raiJEw6JdS7hMCW0VLXdcsIT1aP6l2N2EEwRBSqFKcLD
         SB35KdDELxeU7+BbwvgpANMxWAtLp/3qZ2SQelDMOzX8CMGhcbfNE7EzwC8Vaz0o7ENN
         jiHdxlBtSqedmUGq9w5r/n63hqkimj2zdymHihS+KFmrQeVGLn6GK6VOuAFNTWSxZsFN
         1TvXAGBUuelTT5RJy+84882f9u2/Xz5KWrZjHZ1jA2++wzFPouq8kFJMCorGoaLEIJC4
         C0xQ==
X-Gm-Message-State: APjAAAUmvLaPK2Pc2SOr7EPvwSsEQAxtIgfW0UbK7H1ZwHkyHkeHWBal
        P7hfRWSN0sqYJ1wiNWTIMu2ROOeV85ygXw==
X-Google-Smtp-Source: APXvYqwCX2MBzMEReXX1xV3jUFGB08L4MJtEtvR5BzsZ84X6TT2Gnq8chd6RudqzVPTvjBW857cnqQ==
X-Received: by 2002:a05:651c:87:: with SMTP id 7mr506151ljq.20.1573609487372;
        Tue, 12 Nov 2019 17:44:47 -0800 (PST)
Received: from localhost.bredbandsbolaget (c-79c8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.200.121])
        by smtp.gmail.com with ESMTPSA id n19sm190440lfl.85.2019.11.12.17.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 17:44:46 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc:     linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Fabio Estevam <festevam@gmail.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] spi: fsl-cpm: Correct the free:ing
Date:   Wed, 13 Nov 2019 02:44:42 +0100
Message-Id: <20191113014442.12100-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The fsl_spi_cpm_free() function does not make the same
checks as the error path in fsl_spi_cpm_init() leading
to crashes on error.

Cc: Fabio Estevam <festevam@gmail.com>
Reported-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/spi/spi-fsl-cpm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-cpm.c b/drivers/spi/spi-fsl-cpm.c
index 858f0544289e..54ad0ac121e5 100644
--- a/drivers/spi/spi-fsl-cpm.c
+++ b/drivers/spi/spi-fsl-cpm.c
@@ -392,7 +392,8 @@ void fsl_spi_cpm_free(struct mpc8xxx_spi *mspi)
 	dma_unmap_single(dev, mspi->dma_dummy_rx, SPI_MRBLR, DMA_FROM_DEVICE);
 	dma_unmap_single(dev, mspi->dma_dummy_tx, PAGE_SIZE, DMA_TO_DEVICE);
 	cpm_muram_free(cpm_muram_offset(mspi->tx_bd));
-	cpm_muram_free(cpm_muram_offset(mspi->pram));
+	if (!(mspi->flags & SPI_CPM1))
+		cpm_muram_free(cpm_muram_offset(mspi->pram));
 	fsl_spi_free_dummy_rx();
 }
 EXPORT_SYMBOL_GPL(fsl_spi_cpm_free);
-- 
2.21.0

