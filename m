Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DBE9221034
	for <lists+linux-spi@lfdr.de>; Wed, 15 Jul 2020 17:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbgGOPGl (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 15 Jul 2020 11:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727848AbgGOPGk (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 15 Jul 2020 11:06:40 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4AC2C08C5DE
        for <linux-spi@vger.kernel.org>; Wed, 15 Jul 2020 08:06:39 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id 22so5935308wmg.1
        for <linux-spi@vger.kernel.org>; Wed, 15 Jul 2020 08:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vKemoWjqR6g96Xgsgirmftjm/E0sdVIsOFgpktr/D0I=;
        b=MuVa6YUilZbMg938X6+LEiTeMKwmIyt0RScRI3mHKMSuc868HMtye15e+tdjz7hn5l
         pm6AT7nOyryMAZpDFrCikxebECb2ckO+QnyNGZ5PNQYIudu90DgxNcpa4DuPtVhVjIUa
         SN8IPX+xnfZAB8oFwQjswqvmWXCNl5KOCfrc+RCbt7EJY9QOTaIuoG+4Ay8r/xYX+oJh
         iZGI4AKMukXc74MYDDnc2SxtzANeEqihLcQ94ZD+XxjhGJHuZ3b07myurXNAUcCQLAD/
         g50CYKeZ/F5UaVtwBdnc/n2IPvzfF6dQV/1Bf5xrb2Hm5uRn+r/OYpDGHLKgLuhHWo1R
         IO7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vKemoWjqR6g96Xgsgirmftjm/E0sdVIsOFgpktr/D0I=;
        b=YyVI9Tc30gmZfCd1hyxfVE1RCO9IOS/txR8JwxQh22Ic+qUCix0c/kM7jmVadm3ucP
         bDdBSNZL7msgTlu625ZDXkk7YhrvZ+kcFmtldBTzRTvQ+IvUOOg3JAAV71GQatifAYdk
         5t4KpHhGHtnMIlA8CrB36qOQ0gGRAB6uqt885yyQqAw0wC6CcCZDgVjkqQRceeKdqz3S
         h3Ej7qGJJh4s5xja8lmaOsx0RTHl5e4NYK2+tWQgUTr+FkPgXEEeq4P/86fWkOtIEByt
         YO1qyPxNH/avzL38HJqcTyjkMsKKVTnoenI8FFpsqWU2J4ZBU1Nr7/7tAzxILkjkP2cX
         UXoQ==
X-Gm-Message-State: AOAM5314ln5U3ZFDD+faQPOFDu6/ZjCMLNEoOvjZNuCBTptLG2P1OE9y
        2v8u7DNKho0K5P2QfGetd3rvqA==
X-Google-Smtp-Source: ABdhPJyX7pdGpzS47hcVgtTiOYRgvA0VEgqvOXAjH60JAODiKRtGtZA78dSsUpVRg8hrCzcXmu+7PA==
X-Received: by 2002:a7b:c403:: with SMTP id k3mr9037305wmi.35.1594825598535;
        Wed, 15 Jul 2020 08:06:38 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id w2sm3906140wrs.77.2020.07.15.08.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 08:06:37 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     broonie@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 03/14] spi: spi-davinci: Fix a few kerneldoc misspellings and API slippages
Date:   Wed, 15 Jul 2020 16:06:21 +0100
Message-Id: <20200715150632.409077-4-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200715150632.409077-1-lee.jones@linaro.org>
References: <20200715150632.409077-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/spi/spi-davinci.c:249: warning: Function parameter or member 'dspi' not described in 'davinci_spi_get_prescale'
 drivers/spi/spi-davinci.c:249: warning: Function parameter or member 'max_speed_hz' not described in 'davinci_spi_get_prescale'
 drivers/spi/spi-davinci.c:249: warning: Excess function parameter 'maxspeed_hz' description in 'davinci_spi_get_prescale'
 drivers/spi/spi-davinci.c:719: warning: Function parameter or member 'data' not described in 'dummy_thread_fn'
 drivers/spi/spi-davinci.c:719: warning: Excess function parameter 'context_data' description in 'dummy_thread_fn'
 drivers/spi/spi-davinci.c:735: warning: Function parameter or member 'data' not described in 'davinci_spi_irq'
 drivers/spi/spi-davinci.c:735: warning: Excess function parameter 'context_data' description in 'davinci_spi_irq'

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/spi/spi-davinci.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
index f50c0c79cbdfa..818f2b22875d2 100644
--- a/drivers/spi/spi-davinci.c
+++ b/drivers/spi/spi-davinci.c
@@ -236,7 +236,8 @@ static void davinci_spi_chipselect(struct spi_device *spi, int value)
 
 /**
  * davinci_spi_get_prescale - Calculates the correct prescale value
- * @maxspeed_hz: the maximum rate the SPI clock can run at
+ * @dspi: the controller data
+ * @max_speed_hz: the maximum rate the SPI clock can run at
  *
  * This function calculates the prescale value that generates a clock rate
  * less than or equal to the specified maximum.
@@ -710,7 +711,7 @@ static int davinci_spi_bufs(struct spi_device *spi, struct spi_transfer *t)
 /**
  * dummy_thread_fn - dummy thread function
  * @irq: IRQ number for this SPI Master
- * @context_data: structure for SPI Master controller davinci_spi
+ * @data: structure for SPI Master controller davinci_spi
  *
  * This is to satisfy the request_threaded_irq() API so that the irq
  * handler is called in interrupt context.
@@ -723,7 +724,7 @@ static irqreturn_t dummy_thread_fn(s32 irq, void *data)
 /**
  * davinci_spi_irq - Interrupt handler for SPI Master Controller
  * @irq: IRQ number for this SPI Master
- * @context_data: structure for SPI Master controller davinci_spi
+ * @data: structure for SPI Master controller davinci_spi
  *
  * ISR will determine that interrupt arrives either for READ or WRITE command.
  * According to command it will do the appropriate action. It will check
-- 
2.25.1

