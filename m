Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB8E10C53B
	for <lists+linux-spi@lfdr.de>; Thu, 28 Nov 2019 09:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbfK1IhY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 28 Nov 2019 03:37:24 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46613 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbfK1IhY (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 28 Nov 2019 03:37:24 -0500
Received: by mail-lj1-f193.google.com with SMTP id e9so27515245ljp.13
        for <linux-spi@vger.kernel.org>; Thu, 28 Nov 2019 00:37:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9UNTxHqliggGbmAKafmJNsv2d3zbVF42cYDw5gq+EhU=;
        b=dseqabVICFNoh3GhOyH46JX2MYbfDf8EpM4kucbqbGwYl4vV/hM6DhWYVhXd20ETms
         9WYcwSh1+03YHFfMGqVomY+BfNRAuNA0H1YQWepi2FJAxhgUF055R9bMv+o4hSGBZFuO
         xPsvhP6b6DFyka0a9mATu1kNbD/GQEUiDGO5HdLVDPl5MUs4WARrqwzRkvownZuXnp8d
         pCC3zQi+10roXtnnDv7/JR4t5GQgEcFgS8IOD2HJmLv/GBSZCYkrQ1vNg3pE5q90kB8/
         J3cHNY7kKpjOZMPLiVbLXnyzP0McRFXky5xv/6NS7SD/BrNLXed2oj5MskpKvzACRKfo
         9+3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9UNTxHqliggGbmAKafmJNsv2d3zbVF42cYDw5gq+EhU=;
        b=Iyih8Sv46lzQby1XfuBvmT3p/urVdc1IYpOwl/VNOwIFZZLCUYLhVxs+eUNOKliz/K
         VUrOfoo8708Am+LBqiMKCd7nGF4b+cE4TUJgdayycmrsM3L05wt94cxjkkWPP2RHXp5d
         9akH56yJsagcY6166H9APFtWR22NzA50CAuCZLVA6xD2DWuYc+fMrn5B0I6cW5bofNlQ
         g6ZWb9VGPXRisNUsFkrIgdrUAG7PvgI0kh3BrgyuauXb8OiEezDdKHfUCpzdYPoes57q
         N2E6EtPd3ANWCOxKr2zcxSUIFm54lkoFFG2gX8j/A7NDqJuyB7ZJcNjmySC6qXT0oEyd
         G7og==
X-Gm-Message-State: APjAAAVqtiUfpm21RKrqRu1g1dHbbIcE2GjzmZR26wrvUHyC/CTjqtyI
        T78G8RJAhQaroClHHVKD/K4xmA==
X-Google-Smtp-Source: APXvYqz2gh0BkCBfSwj23LLxEN+fJUlPxO7cHUfME4D55/nYAC1jvl0xQVO7u4AkeEPWxZO4t9i/Eg==
X-Received: by 2002:a2e:8e21:: with SMTP id r1mr33721064ljk.81.1574930241653;
        Thu, 28 Nov 2019 00:37:21 -0800 (PST)
Received: from genomnajs.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id x193sm3384013lfa.78.2019.11.28.00.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 00:37:20 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 1/3 v3] spi: fsl: Fix GPIO descriptor support
Date:   Thu, 28 Nov 2019 09:37:16 +0100
Message-Id: <20191128083718.39177-1-linus.walleij@linaro.org>
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
ChangeLog v2->v3:
- Resend with the rest of the patches.
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

