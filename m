Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C900A1E3A83
	for <lists+linux-spi@lfdr.de>; Wed, 27 May 2020 09:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387610AbgE0H23 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 27 May 2020 03:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387523AbgE0H22 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 27 May 2020 03:28:28 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C30C061A0F;
        Wed, 27 May 2020 00:28:28 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id i17so1319452pli.13;
        Wed, 27 May 2020 00:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/JV/008aPSkYotGfzM+L6zI+gJbJzTnEPoCKhdwlcaQ=;
        b=vVzh0duJ5UBz8i7EQglR29+3vO1ID79mbmwybvUcue74rvWvRigpxqp2ZVr0rab8e/
         Ry+7PIzSqJgossPgzHagNkc8BPkm3Z0LmHRCYUYMdsPKmv13jv5jgQTLyV598te+V/7S
         hqKUWRB04esPX6hcJbWLwzZbw/an7UI8rmCm4mnPxCTLeCBGBDFb+ZGq1l0/ewgwzmrC
         yyYNYr74oCMw9cpd4O/1QrtJhT0KIiKl20sUb1Sln7SGprcAslSYRWpjmIuzG+2ur+6K
         5JLbT+St99ieEkg+3fQ3MDwNRLoWeGDiEfLKkIt9bWYn039LtKtsXlf6lBBtvx3X2cNS
         QkNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/JV/008aPSkYotGfzM+L6zI+gJbJzTnEPoCKhdwlcaQ=;
        b=lQEPmOMQGRuMZcT7EIYR2R5cd+eWb9XLUoPmY9oN/5PpL6Z/2uUu3xnuftuJO2/g/I
         puvh1WwDQDY010Y1wvTbb/m2mP0bhpYcmUDps36qCI/WXfU2yjPrqu4js3AoQ0RXSGYI
         owbze003+Ks9nSDrOjEknRBhXgg2FI6gbXGnBHCFnPEkDRU4iI/3vZsv+cZt9nV53zXi
         zloWSxpH55r6FF9Ewuw92rLvBPgIMz1SqxX7GNUA6Qxh8rIZuRocCPI5EMO9bRIJtwV6
         ZBuH/3ix82uirgXIvlxTDcY5O8ITSWaWVckEPQJ7AubsbDu6zJ2FvHfLbxggt/T58oAU
         F1kw==
X-Gm-Message-State: AOAM533qHO6HsRnig1a46LoPlNbvyQy1SXsOJKNMO4JJJihT6Tfd4fhk
        /l5nRk9WRakh4WD4MUm7DSI=
X-Google-Smtp-Source: ABdhPJymWe4FoVyYbDrlihjLqkxCoTA9jfDcSnxcM8g8a/J8skMLtS/pkQ9CFWP8NSn447pUr7X8sg==
X-Received: by 2002:a17:90a:8c95:: with SMTP id b21mr3540607pjo.89.1590564508451;
        Wed, 27 May 2020 00:28:28 -0700 (PDT)
Received: from fmin-OptiPlex-7060.nreal.work ([103.206.191.44])
        by smtp.gmail.com with ESMTPSA id q201sm1371842pfq.40.2020.05.27.00.28.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 May 2020 00:28:28 -0700 (PDT)
From:   dillon.minfei@gmail.com
To:     robh+dt@kernel.org, p.zabel@pengutronix.de,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        thierry.reding@gmail.com, sam@ravnborg.org, airlied@linux.ie,
        daniel@ffwll.ch, mturquette@baylibre.com, sboyd@kernel.org,
        andy.shevchenko@gmail.com, noralf@tronnes.org,
        linus.walleij@linaro.org, broonie@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        dri-devel@lists.freedesktop.org, linux-clk@vger.kernel.org,
        dillonhua@gmail.com, dillon min <dillon.minfei@gmail.com>
Subject: [PATCH v6 9/9] spi: flags 'SPI_CONTROLLER_MUST_RX' and 'SPI_CONTROLLER_MUST_TX' can't be coexit with 'SPI_3WIRE' mode
Date:   Wed, 27 May 2020 15:27:33 +0800
Message-Id: <1590564453-24499-10-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1590564453-24499-1-git-send-email-dillon.minfei@gmail.com>
References: <1590564453-24499-1-git-send-email-dillon.minfei@gmail.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: dillon min <dillon.minfei@gmail.com>

since chip spi driver need get the transfer direction by 'tx_buf' and
'rx_buf' of 'struct spi_transfer' in 'SPI_3WIRE' mode.

so, we need bypass 'SPI_CONTROLLER_MUST_RX' and 'SPI_CONTROLLER_MUST_TX'
feature in 'SPI_3WIRE' mode

Signed-off-by: dillon min <dillon.minfei@gmail.com>
---
 drivers/spi/spi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index c92c89467e7e..f8844116f955 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1023,7 +1023,8 @@ static int spi_map_msg(struct spi_controller *ctlr, struct spi_message *msg)
 	void *tmp;
 	unsigned int max_tx, max_rx;
 
-	if (ctlr->flags & (SPI_CONTROLLER_MUST_RX | SPI_CONTROLLER_MUST_TX)) {
+	if ((ctlr->flags & (SPI_CONTROLLER_MUST_RX | SPI_CONTROLLER_MUST_TX))
+		&& !(msg->spi->mode & SPI_3WIRE)) {
 		max_tx = 0;
 		max_rx = 0;
 
-- 
2.7.4

