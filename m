Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13F97223D73
	for <lists+linux-spi@lfdr.de>; Fri, 17 Jul 2020 15:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727888AbgGQNzQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 17 Jul 2020 09:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726949AbgGQNye (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 17 Jul 2020 09:54:34 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30173C0619D9
        for <linux-spi@vger.kernel.org>; Fri, 17 Jul 2020 06:54:33 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id z2so11258151wrp.2
        for <linux-spi@vger.kernel.org>; Fri, 17 Jul 2020 06:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R5bZU73kxT5M1JMsvuGC6Lo9dJE8hXmdkV8EdjzvhWs=;
        b=ZAC5kkaeD48hDzasHcMFBgI5ok3om/Ag5jSHoowWVEUw02KGIjIWhow3DY2EWpzj1k
         xGIQfKuwkO6ETxRSTvlinnPUEMJh5/qXsllh3rX9yQQ5qtv6gB5OoR9meWBkVvG+GZFV
         aJWhSVmI/c5AX1aCSjblRbbyZkqfNY8nX0kmHTI4kACCAYFjKYyHj9YMFXsOA0U2gl7k
         JPPPn5HFtj+Aq3tDCoBEZqm00dLcmf8Me76bz9eW43D6ng60idi56pggV1F3MsRrKQe0
         aYxadZEomTMoFaJKKr+DcDh6tNOFHztWuOeSlU+oyVZKjITYbEoH53/73ocvYz5aFLxK
         WtKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R5bZU73kxT5M1JMsvuGC6Lo9dJE8hXmdkV8EdjzvhWs=;
        b=uYWEIonpXH90zZ+uX8fLhIqU9L8cKMr3lWS7BT3HfiCDlVYoFnzk/R7mWfjpv3wLJ0
         3LPyqOPilYswZHfSXlZtDwS5l4zJyrn3B/BxPjzCSY/EfcEnBpvYiXUYJo+8U0ThNUgL
         k/A2EbhaVD3B7qWDXROzLWGYI2xgvxRLk+38HsdaC809l43EAqZFCWQ1dmzWMRmj7J4l
         AqdGNQkZCm+hTL6C3rx0BDE50b64FSBnti5xKIT5aYmS1f8NNlfDfWTDJU3qcxbtLfgn
         aO+72XpXLMPnXxOaFpOQPaKloqF23BpibPLCm7FVvV1b02Ij/HpiDMNn4InzAhPrJD3v
         u1Lg==
X-Gm-Message-State: AOAM530n9t6GPxCtovsJFOckmC2Pykv4dDuUmpANFsF+7j7MUKux0wDl
        do5UOpZfhOpBfvXe8fi8+RtSkw==
X-Google-Smtp-Source: ABdhPJxG9WExdH+no7RsXepaf01G8y07Rip1YGVf8Z/0A+HGPnfCWJrwdTxKjFDyUGuQE69jroFN6Q==
X-Received: by 2002:a5d:4607:: with SMTP id t7mr11203477wrq.251.1594994071957;
        Fri, 17 Jul 2020 06:54:31 -0700 (PDT)
Received: from localhost.localdomain ([2.27.167.94])
        by smtp.gmail.com with ESMTPSA id w128sm16118356wmb.19.2020.07.17.06.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 06:54:31 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     broonie@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Beniamino Galvani <b.galvani@gmail.com>,
        linux-amlogic@lists.infradead.org
Subject: [PATCH v2 05/14] spi: spi-meson-spifc: Fix misdocumenting of 'dev' in 'struct meson_spifc'
Date:   Fri, 17 Jul 2020 14:54:15 +0100
Message-Id: <20200717135424.2442271-6-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200717135424.2442271-1-lee.jones@linaro.org>
References: <20200717135424.2442271-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/spi/spi-meson-spifc.c:80: warning: Function parameter or member 'dev' not described in 'meson_spifc'

Cc: Kevin Hilman <khilman@baylibre.com>
Cc: Beniamino Galvani <b.galvani@gmail.com>
Cc: linux-amlogic@lists.infradead.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/spi/spi-meson-spifc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-meson-spifc.c b/drivers/spi/spi-meson-spifc.c
index c7b0399802913..8eca6f24cb799 100644
--- a/drivers/spi/spi-meson-spifc.c
+++ b/drivers/spi/spi-meson-spifc.c
@@ -70,7 +70,7 @@
  * @master:	the SPI master
  * @regmap:	regmap for device registers
  * @clk:	input clock of the built-in baud rate generator
- * @device:	the device structure
+ * @dev:	the device structure
  */
 struct meson_spifc {
 	struct spi_master *master;
-- 
2.25.1

