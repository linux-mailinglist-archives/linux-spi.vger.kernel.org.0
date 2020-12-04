Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED402CF4E4
	for <lists+linux-spi@lfdr.de>; Fri,  4 Dec 2020 20:37:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730713AbgLDThJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 4 Dec 2020 14:37:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727913AbgLDThJ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 4 Dec 2020 14:37:09 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 652F4C08E860
        for <linux-spi@vger.kernel.org>; Fri,  4 Dec 2020 11:35:47 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id j1so3703063pld.3
        for <linux-spi@vger.kernel.org>; Fri, 04 Dec 2020 11:35:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z02bYpW+7Mv3ChAgiAsPawwOKuNxCdLfLFsK6QR3N2g=;
        b=Vs++OpkolBidQ0q+Ilza0Lha2VWjdSfRUa0ZzyaK0DdwopqPCGjYsRuljefTYyN41n
         SMbziRk4cUbUTZSxJGFsasYy+OuGga4sEI/YuO+UYsdrtDxNFg3bzdS01K0AMf1PNPgy
         XqWplByD5XICWPph7gUl2ablIZ35/fL5KvA5g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z02bYpW+7Mv3ChAgiAsPawwOKuNxCdLfLFsK6QR3N2g=;
        b=Zm588qxoAspsgUD7kRANJQVHPz1ZR0EJg0SXw6UXEj94NQCGpxpiM4Mb4LrNwGdX/B
         20Rv/EL64CVcnDm9+8Jcq9O8Wp0KMUzf/04ycIeXyLB0vQG0r76p64XpogXafjbqNtxk
         9gbB/EMtlRo9CpfXMh6iXQPxrnj/EMOT2WHtyukP0o/EPeJz5BnUvFEztoI9xaZzLliH
         Z9poMvrYaobPQu0r0l4JhRpL53ipuJv9s9Z7ncJ5ITkNHhGPw8b2W9xzNcnzwFUVzfKS
         ViCK9MZxzvTtTDm4spIxaPZH4mKLhiNq/Y7MST6n7gGFMYlq5qSuirJlbAJatdo4YmBy
         KCtw==
X-Gm-Message-State: AOAM530EDjMf/17AjEaPURgZVdS3M3crhLRuOjXhHEVYCleNs79lIbGE
        O6dIyIjAGrVzCzkwLTTUSH33kA==
X-Google-Smtp-Source: ABdhPJyziCeNS5BAMuYMAdrbPbkMe9VU91eJnl2PsGv9X03ZA9VevMGtTFXoltaP7nkzPeYtn8UPzw==
X-Received: by 2002:a17:902:aa4b:b029:d8:f87e:1f3c with SMTP id c11-20020a170902aa4bb02900d8f87e1f3cmr5331771plr.23.1607110546995;
        Fri, 04 Dec 2020 11:35:46 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:201:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id g8sm4576548pgn.47.2020.12.04.11.35.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 11:35:46 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Benson Leung <bleung@chromium.org>,
        linux-arm-msm@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Akash Asthana <akashast@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Alexandru M Stan <amstan@chromium.org>
Subject: [PATCH 3/3] spi: spi-geni-qcom: Use the new method of gpio CS control
Date:   Fri,  4 Dec 2020 11:35:40 -0800
Message-Id: <20201204193540.3047030-4-swboyd@chromium.org>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
In-Reply-To: <20201204193540.3047030-1-swboyd@chromium.org>
References: <20201204193540.3047030-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Let's set the 'use_gpio_descriptors' field so that we use the new way of
requesting the CS GPIOs in the core. This allows us to avoid having to
configure the CS pins in "output" mode with an 'output-enable' pinctrl
setting.

Cc: Akash Asthana <akashast@codeaurora.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Cc: Alexandru M Stan <amstan@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/spi/spi-geni-qcom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index 25810a7eef10..c4c88984abc9 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -636,6 +636,7 @@ static int spi_geni_probe(struct platform_device *pdev)
 	spi->auto_runtime_pm = true;
 	spi->handle_err = handle_fifo_timeout;
 	spi->set_cs = spi_geni_set_cs;
+	spi->use_gpio_descriptors = true;
 
 	init_completion(&mas->cs_done);
 	init_completion(&mas->cancel_done);
-- 
https://chromeos.dev

