Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BEE14A68BA
	for <lists+linux-spi@lfdr.de>; Wed,  2 Feb 2022 00:47:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbiBAXrm (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 1 Feb 2022 18:47:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbiBAXrl (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 1 Feb 2022 18:47:41 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4B77C061714
        for <linux-spi@vger.kernel.org>; Tue,  1 Feb 2022 15:47:40 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id u14so37066972lfo.11
        for <linux-spi@vger.kernel.org>; Tue, 01 Feb 2022 15:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tDl91pCxTReCNE1aU2nzUISNbuzO3L0SJItkPcl6pUM=;
        b=urfUC2Te907xmj6E2xNYtO5fCaL7szA/68O2FXd8oWgZWUkuO3zgR+aiv8Qa8hvW9K
         bMIpu009wuaNGvAZ+EB/np1qhOOFVwPiKqdIL0qGCkgnvH8PqNv9aTgEvvqAeVb4DGnQ
         CfSuUdvWHbr2xOUC2ebAtv2k+uXCv5gVTEcmOo0h4VsgyoUd5e7ecwTbsggUJ4XCncEB
         /SPJ7YrK0nmO3Kb/UaTc9gQmWZzM8rMAfcWypdTG4j3wRgVMKWEbqziJCGO09LcnOmwc
         YkBelE4cu7jMmFnTj3xW283XL/zIQTFkmAkWl8OZ1RyS3RuMy3AwJGbVOeU5nmL8Gqa/
         +uIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tDl91pCxTReCNE1aU2nzUISNbuzO3L0SJItkPcl6pUM=;
        b=n0QTgdanKrfHhZmEvkxmkUxDWzs+5FfT9iW7CzjWVBsNK2TizhmPHrBNMCBFUrVNqu
         XHaQ+QMZo+il4u8lVK8iGrgsViE+/fEkvk6i+6u8DrKmgLBxbn70FIOR5DDqyXVW3G33
         kW4CD1kBlj1VZqZYK1JBLJnAo+2r5JByT4c8sX+Um8N7IZoIrDomQmsW5db4yOQpG3ZM
         L0284yVgENtRO1y2VE9mOOfQH4Ymcl9wpFZbo9L6yNoeyBHKsTPyQ1N/P4Ohvr7e1esK
         R1wXWCfMPpA5y3vgA7ASwynGejXHr42LnWxoKPhkO2U/1giRDDd6ky+qayv+7L3JFjcL
         K7KA==
X-Gm-Message-State: AOAM532DhmwRL36iZ4tcs1hGle3ieThJFi71dg3sevnLhZblVe94gNjO
        76OGgnDZ2AEUSxQRQGnHwX1I4A==
X-Google-Smtp-Source: ABdhPJzYRFKveyx4qbvl5fhnYo3J6NQY4iqSZXvFmmwqmIdcBYyS6ujxmuOYjqn2ftOlU7ARNsnNog==
X-Received: by 2002:ac2:5ccc:: with SMTP id f12mr21482408lfq.335.1643759259268;
        Tue, 01 Feb 2022 15:47:39 -0800 (PST)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id o8sm4280202lft.135.2022.02.01.15.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 15:47:38 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Anatolij Gustschin <agust@denx.de>,
        linuxppc-dev@lists.ozlabs.org, kernel test robot <lkp@intel.com>
Subject: [PATCH] spi: mpc512x-psc: Fix compile errors
Date:   Wed,  2 Feb 2022 00:45:35 +0100
Message-Id: <20220201234535.569973-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

My patch created compilation bugs in the MPC512x-PSC driver.
Fix them up.

Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Cc: Anatolij Gustschin <agust@denx.de>
Cc: linuxppc-dev@lists.ozlabs.org
Reported-by: kernel test robot <lkp@intel.com>
Fixes: 2818824ced4b (" spi: mpc512x-psc: Convert to use GPIO descriptors")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
(This is because I don't have a PPC cross compiler.)
---
 drivers/spi/spi-mpc512x-psc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/spi/spi-mpc512x-psc.c b/drivers/spi/spi-mpc512x-psc.c
index 8a488d8e4c1b..03630359ce70 100644
--- a/drivers/spi/spi-mpc512x-psc.c
+++ b/drivers/spi/spi-mpc512x-psc.c
@@ -127,7 +127,7 @@ static void mpc512x_psc_spi_activate_cs(struct spi_device *spi)
 	out_be32(psc_addr(mps, ccr), ccr);
 	mps->bits_per_word = cs->bits_per_word;
 
-	if (cs->gpiod) {
+	if (spi->cs_gpiod) {
 		if (mps->cs_control)
 			/* boardfile override */
 			mps->cs_control(spi, (spi->mode & SPI_CS_HIGH) ? 1 : 0);
@@ -373,7 +373,6 @@ static int mpc512x_psc_spi_unprep_xfer_hw(struct spi_master *master)
 static int mpc512x_psc_spi_setup(struct spi_device *spi)
 {
 	struct mpc512x_psc_spi_cs *cs = spi->controller_state;
-	int ret;
 
 	if (spi->bits_per_word % 8)
 		return -EINVAL;
-- 
2.34.1

