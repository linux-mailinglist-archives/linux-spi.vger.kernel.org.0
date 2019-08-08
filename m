Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D57D8650F
	for <lists+linux-spi@lfdr.de>; Thu,  8 Aug 2019 17:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730768AbfHHPD2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 8 Aug 2019 11:03:28 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45319 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727096AbfHHPD2 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 8 Aug 2019 11:03:28 -0400
Received: by mail-lj1-f195.google.com with SMTP id t3so666072ljj.12
        for <linux-spi@vger.kernel.org>; Thu, 08 Aug 2019 08:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mmnFZZttzNll6Mb5XmwQX5FbW4sfyb4MRTiyZMXbxWg=;
        b=MX6wtxj/Lge1vMMnI1h6iHZbUVKMELdiW/nhVQO5y0r1HlVIwEc4NbOIU2EJDo6wI3
         fhlc1ud1ZYizA3b1dK+6vCSE07SJPfM/uu3F5wYCnkm+KcbuW4HEm25LTf1HNE70PTnR
         HT0FpUjDV+M10cwqHm48zWTMcBt0zCVl9r54YZ/5nAgwfP7zejGLSDiPCvZX1Y0jUiwr
         8lRfvlYWYiFlS9TOo0ZZ55NvbPmzGRmcr8U/HQiVAhp4mHe6TZx4pIlJQXr4Zgc4SkJd
         EmxQBUdGX7bHKxW9IYbmxavMmwOeH5yrT7ljAOlseFZMODy/qghDQEkdeUr76Ilkb+IP
         y3zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mmnFZZttzNll6Mb5XmwQX5FbW4sfyb4MRTiyZMXbxWg=;
        b=F/llF+J7x1gOwRah6iBn7a62oAhCTeviLHQQ9XGdMzqM1lBRXtzaW+OrskHVLk9mxx
         s+ByyiOxxre2fuPvYBjmeWbz/N1Dc9S5hhFihLm9EVWPqY6MMkZ9t3lNge595ROT1GET
         PHbAICHRhgr8VINgy/jwGhip9CJ1tmE3Abi9jFKflEHN0pZ1H7x+KAd2f5l8OKNaTsYJ
         VhZfhTCQmtzs+QgjhHomZx48acLhDBnadMQk32zcOj2YlZSCMlhTaAcHb1eAPd5nmwxg
         Rj9qZAeaVIlByfKRTfR20w4O9yDy5x7j3/YyexyBsIteHF2QQOK0zRrdZSYcxAXfAuQx
         W5tg==
X-Gm-Message-State: APjAAAU5SG5045uo0NwqoxK/IcLgCaM38Ac8iHV8wVwtxeTpzK9N89U1
        rojBwWHuO/tEgwLrI6rPvtAEPA==
X-Google-Smtp-Source: APXvYqx5jBVZ+U8o+QEk+Eln2jVbnq3YUSTLl/i/iei4yhxc/PRs4RRk4Wt1np88KOo1uQG5EfCh/g==
X-Received: by 2002:a2e:890c:: with SMTP id d12mr8436882lji.103.1565276606115;
        Thu, 08 Aug 2019 08:03:26 -0700 (PDT)
Received: from genomnajs.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id m28sm18845209ljb.68.2019.08.08.08.03.24
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 08 Aug 2019 08:03:24 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc:     linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] spi: Rename of_spi_register_master() function
Date:   Thu,  8 Aug 2019 17:03:21 +0200
Message-Id: <20190808150321.23319-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Rename this function to of_spi_get_gpio_numbers() as this
is what the function does, it does not register a master,
it is called in the path of registering a master so the
name is logical in a convoluted way, but it is better to
follow Rusty Russell's ABI level no 7:
"The obvious use is (probably) the correct one"

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/spi/spi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 75ac046cae52..79d7526e1337 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2236,7 +2236,7 @@ struct spi_controller *__spi_alloc_controller(struct device *dev,
 EXPORT_SYMBOL_GPL(__spi_alloc_controller);
 
 #ifdef CONFIG_OF
-static int of_spi_register_master(struct spi_controller *ctlr)
+static int of_spi_get_gpio_numbers(struct spi_controller *ctlr)
 {
 	int nb, i, *cs;
 	struct device_node *np = ctlr->dev.of_node;
@@ -2269,7 +2269,7 @@ static int of_spi_register_master(struct spi_controller *ctlr)
 	return 0;
 }
 #else
-static int of_spi_register_master(struct spi_controller *ctlr)
+static int of_spi_get_gpio_numbers(struct spi_controller *ctlr)
 {
 	return 0;
 }
@@ -2456,7 +2456,7 @@ int spi_register_controller(struct spi_controller *ctlr)
 			ctlr->mode_bits |= SPI_CS_HIGH;
 		} else {
 			/* Legacy code path for GPIOs from DT */
-			status = of_spi_register_master(ctlr);
+			status = of_spi_get_gpio_numbers(ctlr);
 			if (status)
 				return status;
 		}
-- 
2.21.0

