Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE6E211236D
	for <lists+linux-spi@lfdr.de>; Wed,  4 Dec 2019 08:15:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbfLDHOm (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 4 Dec 2019 02:14:42 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43561 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727286AbfLDHOm (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 4 Dec 2019 02:14:42 -0500
Received: by mail-pf1-f195.google.com with SMTP id h14so3154629pfe.10;
        Tue, 03 Dec 2019 23:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=yyLimGD4f12DqzRTDHXGiQPmCcJPxnl3/Nn96acsv98=;
        b=NWPoNEpr+2n1OE+peRK1EqCGnArK/SkCMhZR0QpNKiiv3Rd8vMTzfibhm9vtm1wYK2
         YqmiYIM2+V/DhvZ/2flVIAn5iHxC7BmgV83d8Aj+YMnmBYH0oRBEFSEeUDPnEby2WtsK
         owk1Kd4goB65oRfx++EoLTN5ecczZvhZfFFXm4VAKo+QEZ4H63MfEoZ8isDCZ+dEO2oS
         yPl1tRK/OeDHEW0+onwKbT7CagyjBrAiGWQ+UEzjaserorjprekSAs5fvY0gYpdRcc0r
         RBEKq6NZNFTR6aC7S7sDs8yFpxZXR8Zte4V00deAY4OQP/7KH3+M8vcFhlimtUAHTiN6
         BjtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yyLimGD4f12DqzRTDHXGiQPmCcJPxnl3/Nn96acsv98=;
        b=PKoJ505LvqgaDnk+WgEaFnUIJSiZXvuVg0qguQaAaYRMi2FSXfPucQcfFTO1UiO248
         n2Y7gTu6H0LWxfd82pJxS3w7Ro8BqRG8ZWbB2St5h8AqsmOC2lBPx7cWrJVNOjrFCUYi
         S95Mmepd0fUPXpDyxuVs1xEbu6pZlwz8hzW6aELjlapua1h2V9ltCDwyZo0xOwC01o6P
         n/m8WvmFh7X5oZg9v3/VRO6nrPxbZR4lP73pACyElKbi70GB8FvhjHfVcmR3I3Vavr5l
         QqV/5AZyEkNFF78s97/YcA003Ah7JE4n7Jr5wlD9iXWsQDND7x1WZwQci/ZlgROEPNxR
         S0yw==
X-Gm-Message-State: APjAAAWzSAZFuEGomEmqmIukqqomrxbya8Emq57TlGl80z5Z+DAx+RJC
        l7juo6z3/aZAxmOasfaZ8UI=
X-Google-Smtp-Source: APXvYqwmiSTz4VuzXFxIWjnodDj3ScjphNtZmai9HxMeTn/1ZOshDjZamXqvEzddOsc1Teq19EcqcQ==
X-Received: by 2002:a62:7b46:: with SMTP id w67mr2080477pfc.113.1575443681576;
        Tue, 03 Dec 2019 23:14:41 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id q12sm848316pfh.158.2019.12.03.23.14.38
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 Dec 2019 23:14:40 -0800 (PST)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     broonie@kernel.org
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, baolin.wang7@gmail.com,
        huanpeng.xin@unisoc.com, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] spi: sprd: Fix the incorrect SPI register
Date:   Wed,  4 Dec 2019 15:13:59 +0800
Message-Id: <b4f7f89ec0fdc595335687bfbd9f962213bc4a1d.1575443510.git.baolin.wang7@gmail.com>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Huanpeng Xin <huanpeng.xin@unisoc.com>

The original code used an incorrect SPI register to initialize the SPI
controller in sprd_spi_init_hw(), thus fix it.

Fixes: e7d973a31c24 ("spi: sprd: Add SPI driver for Spreadtrum SC9860")
Signed-off-by: Huanpeng Xin <huanpeng.xin@unisoc.com>
Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
---
 drivers/spi/spi-sprd.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-sprd.c b/drivers/spi/spi-sprd.c
index 2ee1feb..6678f1c 100644
--- a/drivers/spi/spi-sprd.c
+++ b/drivers/spi/spi-sprd.c
@@ -678,7 +678,7 @@ static int sprd_spi_init_hw(struct sprd_spi *ss, struct spi_transfer *t)
 	if (d->unit != SPI_DELAY_UNIT_SCK)
 		return -EINVAL;
 
-	val = readl_relaxed(ss->base + SPRD_SPI_CTL7);
+	val = readl_relaxed(ss->base + SPRD_SPI_CTL0);
 	val &= ~(SPRD_SPI_SCK_REV | SPRD_SPI_NG_TX | SPRD_SPI_NG_RX);
 	/* Set default chip selection, clock phase and clock polarity */
 	val |= ss->hw_mode & SPI_CPHA ? SPRD_SPI_NG_RX : SPRD_SPI_NG_TX;
-- 
1.7.9.5

