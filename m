Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C564F10B0A6
	for <lists+linux-spi@lfdr.de>; Wed, 27 Nov 2019 14:54:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbfK0NyW (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 27 Nov 2019 08:54:22 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40519 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbfK0NyV (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 27 Nov 2019 08:54:21 -0500
Received: by mail-lf1-f68.google.com with SMTP id y5so4525443lfy.7
        for <linux-spi@vger.kernel.org>; Wed, 27 Nov 2019 05:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=44702Gw3ZAM2iREdSIkTlwApDDVA5N67h6DOU9Ptf4I=;
        b=hdOIu4tv6tllw/KWE2yRviLR61rwCfpLpUHi5G9WBuFmm9quzNH+avKQZC7QukVlSd
         S8Xn9EU5RmJKJTad/mZc3A37j8SMokiwphzSGnB8JmsTgxE5TqbftomZlNUOO1AQhpnm
         fmtYyWA5ZTxjh0rEymmo3KtvVnU7Rt19yI5/zrXUSAASNS1x0V3b6aPozhO7zrvilji2
         czH+s90iXRqYlerl5GIt2tLsr1DYsKnd6qFSjyHH3ClCANYXXRrIMZ6MyvDGpKoJ76qL
         37xS8mnHU9Z+DQdw7ZqJb7SzaeQkHnyCi52rQ9uUlzj1L7i0ifIY2ypUUA2Y6Kn/73xc
         hMJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=44702Gw3ZAM2iREdSIkTlwApDDVA5N67h6DOU9Ptf4I=;
        b=BWFnm6I6c2ZmhvGk9yqVKhPny1CeHIphJMDE2TB/HOVFUWTY/nEI00GjG2N6Gl3dOA
         Sw+Pjtj8FJqSMS57SSYh4TkV77TroaqjR0L/88D2fmLC6uWWkyse9DAjZAaiVa/hWIAC
         t17Vu+yXoLLv57IZCrPfB/AVhHZ06DgAotPH4Z7kJtPmx3lIf+9guinr0fgDcL/svkUC
         6lMEfpfOKcCk9ia7TPCnmHPkNrjkLJxnpI1kU3y4gU7CiL7m0e7hhhf3qqNk/73XWDOn
         bX5oEbXGg9L92ChY0a9UbU1r7MVfdMHc65pUidZSp+QFpakK2rxz1bT6VGdYryR1acIN
         Ib7Q==
X-Gm-Message-State: APjAAAWDpoSGaK3eypm8ziaMFR7IdRj+aol8eE7jllLtd77X06skg2yU
        zx0KXoqBL9u+WHY5qyaLv1jTQw==
X-Google-Smtp-Source: APXvYqzdBzf7ut1/0PTCCMX+tHlGncPt21Pjc/XWXrRIJyp2zmA3XK4MzfHdrJ1WmguGg4CFBTfxtQ==
X-Received: by 2002:ac2:455c:: with SMTP id j28mr25414287lfm.184.1574862859524;
        Wed, 27 Nov 2019 05:54:19 -0800 (PST)
Received: from genomnajs.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id j18sm2343561lfh.6.2019.11.27.05.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 05:54:17 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 1/3 v2] spi: fsl: Fix GPIO descriptor support
Date:   Wed, 27 Nov 2019 14:54:08 +0100
Message-Id: <20191127135410.156430-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This makes the driver actually support looking up GPIO
descriptor. A coding mistake in the initial descriptor
support patch was that it was failing to turn on the very
feature it was implementing. Mea culpa.

Cc: Christophe Leroy <christophe.leroy@c-s.fr>
Reported-by: Christophe Leroy <christophe.leroy@c-s.fr>
Fixes: 0f0581b24bd0 ("spi: fsl: Convert to use CS GPIO descriptors")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- New patch fixing this specific problem.
---
 drivers/spi/spi-fsl-spi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-fsl-spi.c b/drivers/spi/spi-fsl-spi.c
index 114801a32371..c87e9c4506c2 100644
--- a/drivers/spi/spi-fsl-spi.c
+++ b/drivers/spi/spi-fsl-spi.c
@@ -611,6 +611,7 @@ static struct spi_master * fsl_spi_probe(struct device *dev,
 	master->setup = fsl_spi_setup;
 	master->cleanup = fsl_spi_cleanup;
 	master->transfer_one_message = fsl_spi_do_one_msg;
+	master->use_gpio_descriptors = true;
 
 	mpc8xxx_spi = spi_master_get_devdata(master);
 	mpc8xxx_spi->max_bits_per_word = 32;
-- 
2.23.0

