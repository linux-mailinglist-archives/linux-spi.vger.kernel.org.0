Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5393F2538
	for <lists+linux-spi@lfdr.de>; Fri, 20 Aug 2021 05:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237806AbhHTDUk (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 19 Aug 2021 23:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234992AbhHTDUj (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 19 Aug 2021 23:20:39 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F2ADC061575;
        Thu, 19 Aug 2021 20:20:02 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id a10so663705qka.12;
        Thu, 19 Aug 2021 20:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ILia9TnznEgu+zH0nAD0DU3ELIP+hXxx/xtqhrAXbUc=;
        b=sjjsZXWb4ZAPdSvkpjDDeS63EK6LqAuKdpTC5PXtJlmaww/87Om/upXqpvAX2p0oOE
         +LdwtSl8oH66cE9XdrtTVCLQT4iaBimtscoyGxjKhF1pdFI8qWmZ956TqWei0pjD6Dr1
         o6VecAO0cN+QaIVxrL5h/7Mfu5pkjyj6nVIJWTHsisCA7Gc0HHX+JhbwpFjpLQBqKpLp
         9seCoCjCY7GaI/udON/vlYZ0TVOIHVDafFyGKreSfAy7qGkJ6NhYCZ1ZFLdp8RxZvfcR
         a3XqHo66xcPA3XJeEOUUOK8nA9Ws2L1Ic/T0LNfM07fYd9oOvoone+7CC4vFRQGsLj2c
         oGYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ILia9TnznEgu+zH0nAD0DU3ELIP+hXxx/xtqhrAXbUc=;
        b=kkPEqadsrawwVoNoLQAL5b3kope4nbLouFGJWZqoJ5TQ7qLBD3zgexYZJe2/T24o0H
         zm65hCr2X+s7ytI5Z0RgUMM1eWLiDbwoJLA3KtkwVDzTD1//WvA/v1LL1nl6grRSvVqM
         HOXvsIutb3iB9uZ86R+RcOZgs+h6lbv6k3HHsutRRi0+Q7YvTq3WQnV1NLdYzagovI5W
         sSHwVhrMJwg8hOiq+F3KLUZeSS2jrNMNINFQ4m29QEWJYJmuCrA2sCVKEZBsxU2NBQLc
         lEduiqcmaOUYGU3JndbnFZkiZ1B8UEa/YX/OjKjcYAGBdwVUunf9YB6X7G/1HmHMavK+
         m6GQ==
X-Gm-Message-State: AOAM530kLMkiWZe8UCeYJcn86cDL1A/Bwom4a6IwFbAPtNEm8jGNp43G
        4UIvmAgrH5iYoeqrINNjXPmSwt9W4ZM=
X-Google-Smtp-Source: ABdhPJxTY3pdJ7lF569LxTmk2KWEo0QxxkuPPcsGvnR/aBGc5UP4MwjsqxL3hZHfb6Skry/C5CQFew==
X-Received: by 2002:ae9:ef4c:: with SMTP id d73mr6935367qkg.494.1629429601851;
        Thu, 19 Aug 2021 20:20:01 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id h68sm2668162qkf.126.2021.08.19.20.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 20:20:01 -0700 (PDT)
From:   CGEL <cgel.zte@gmail.com>
X-Google-Original-From: CGEL <jing.yangyang@zte.com.cn>
To:     Alain Volmat <alain.volmat@foss.st.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        jing yangyang <jing.yangyang@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] spi-stm32: fix Coccinelle warnings
Date:   Thu, 19 Aug 2021 20:19:52 -0700
Message-Id: <20210820031952.12746-1-jing.yangyang@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: jing yangyang <jing.yangyang@zte.com.cn>

WARNING !A || A && B is equivalent to !A || B

This issue was detected with the help of Coccinelle.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: jing yangyang <jing.yangyang@zte.com.cn>
---
 drivers/spi/spi-stm32.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index 14ca7ea..cc4a731 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -912,8 +912,8 @@ static irqreturn_t stm32h7_spi_irq_thread(int irq, void *dev_id)
 		if (!spi->cur_usedma && (spi->rx_buf && (spi->rx_len > 0)))
 			stm32h7_spi_read_rxfifo(spi);
 		if (!spi->cur_usedma ||
-		    (spi->cur_usedma && (spi->cur_comm == SPI_SIMPLEX_TX ||
-		     spi->cur_comm == SPI_3WIRE_TX)))
+			(spi->cur_comm == SPI_SIMPLEX_TX ||
+			spi->cur_comm == SPI_3WIRE_TX))
 			end = true;
 	}
 
-- 
1.8.3.1


