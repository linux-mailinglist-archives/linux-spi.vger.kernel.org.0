Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1C8223D58
	for <lists+linux-spi@lfdr.de>; Fri, 17 Jul 2020 15:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726848AbgGQNy3 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 17 Jul 2020 09:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726846AbgGQNy2 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 17 Jul 2020 09:54:28 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 664C3C0619D3
        for <linux-spi@vger.kernel.org>; Fri, 17 Jul 2020 06:54:29 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id j4so11179763wrp.10
        for <linux-spi@vger.kernel.org>; Fri, 17 Jul 2020 06:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KGFwubHFzcLZa75OH2QfePfgNHp1yNFJ+5dMrYJqOBc=;
        b=LNz53P4vPM8KOT6MgDZZt6XHv/VQQGMQknAGIrbSBeKWG/DqcokivbaP+KPiPKngn7
         wyZfusiKq6wHj1H3NRXBVRRgwn92OZuXpoHoB4COPu/LYEEaBWueviYAs+8vaToPfiIX
         +5mKXjsrA8Qsw9IgpOUyw9iRWhM+Pqy3/ulzSZ+J/rN5QrKtA3MWoVTDBIrTzip58nzf
         78MvBYGi9ddoCLEP8NDJ/ry3KnnDNBWD0fJPc1A6756DJjCdCAN9/A1eh/zaUnKZmG3t
         JvKl6C0QsjM25XYiStS/XegGKvdBvzcCc4VK+mXGcUrzHGlergl5K2K3pcv73mIL85xQ
         Grzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KGFwubHFzcLZa75OH2QfePfgNHp1yNFJ+5dMrYJqOBc=;
        b=MpP0nO4b+U2NWlcaCitJfB2+7oNIdHzId9UqUHtIq0TVeCmziPymrsN6EyympV8PBp
         mbV2U0Sj659BH2RvHxtCjfP6C5krCnJGz26g6R6+wgOYxchINABYBteJjfGT+VLsD/24
         Mu+P7mnHgYjRtzeN8pa/nlqbKJyA+GKZUoQoX0Sc0Em0E9tA48N8aTCcHoI5CMiP70Ex
         +kgUeh7ksYRHne7zqFKrYC+yaFKYkZjkR5ELsKVG3YKBS9g6GOVVq18IMUOd8Gs1kiuB
         n2a0RAdQLRJ2NkT8HEWFWiHNg7FYiLhoSyYE///pIY1bmeZbl4G9WNoF8DbnySTWTIM4
         ZNDg==
X-Gm-Message-State: AOAM530tZqKbjCTccYVxYghjG2TbUMPKSJ9n2a/IHslG6MHOq9KRMPth
        XcVuvOWdocH4HCmAToEYWmBMSw==
X-Google-Smtp-Source: ABdhPJyRBdalYFJ2SqW1AzaxyMFU8anZRL1EGLZqqUNS1odMSvESXDDxeCbz5xSprj+I0pStJ0HyWQ==
X-Received: by 2002:adf:ee4d:: with SMTP id w13mr10311012wro.245.1594994068030;
        Fri, 17 Jul 2020 06:54:28 -0700 (PDT)
Received: from localhost.localdomain ([2.27.167.94])
        by smtp.gmail.com with ESMTPSA id w128sm16118356wmb.19.2020.07.17.06.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 06:54:27 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     broonie@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Martin Sperl <kernel@martin.sperl.org>
Subject: [PATCH v2 01/14] spi: spi-loopback-test: Fix formatting issues in function header blocks
Date:   Fri, 17 Jul 2020 14:54:11 +0100
Message-Id: <20200717135424.2442271-2-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200717135424.2442271-1-lee.jones@linaro.org>
References: <20200717135424.2442271-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Kerneldoc function parameter descriptions must be in '@.*: ' format.

Fixes the following W=1 kernel build warning(s):

 drivers/spi/spi-loopback-test.c:897: warning: Function parameter or member 'spi' not described in 'spi_test_execute_msg'
 drivers/spi/spi-loopback-test.c:897: warning: Function parameter or member 'test' not described in 'spi_test_execute_msg'
 drivers/spi/spi-loopback-test.c:897: warning: Function parameter or member 'tx' not described in 'spi_test_execute_msg'
 drivers/spi/spi-loopback-test.c:897: warning: Function parameter or member 'rx' not described in 'spi_test_execute_msg'
 drivers/spi/spi-loopback-test.c:970: warning: Function parameter or member 'spi' not described in 'spi_test_run_test'
 drivers/spi/spi-loopback-test.c:970: warning: Function parameter or member 'test' not described in 'spi_test_run_test'
 drivers/spi/spi-loopback-test.c:970: warning: Function parameter or member 'tx' not described in 'spi_test_run_test'
 drivers/spi/spi-loopback-test.c:970: warning: Function parameter or member 'rx' not described in 'spi_test_run_test'

Cc: Mark Brown <broonie@kernel.org>
Cc: Martin Sperl <kernel@martin.sperl.org>
Cc: linux-spi@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/spi/spi-loopback-test.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-loopback-test.c b/drivers/spi/spi-loopback-test.c
index b6d79cd156fb5..9522d1b5786d5 100644
--- a/drivers/spi/spi-loopback-test.c
+++ b/drivers/spi/spi-loopback-test.c
@@ -885,10 +885,10 @@ static int spi_test_run_iter(struct spi_device *spi,
 /**
  * spi_test_execute_msg - default implementation to run a test
  *
- * spi: @spi_device on which to run the @spi_message
- * test: the test to execute, which already contains @msg
- * tx:   the tx buffer allocated for the test sequence
- * rx:   the rx buffer allocated for the test sequence
+ * @spi: @spi_device on which to run the @spi_message
+ * @test: the test to execute, which already contains @msg
+ * @tx:   the tx buffer allocated for the test sequence
+ * @rx:   the rx buffer allocated for the test sequence
  *
  * Returns: error code of spi_sync as well as basic error checking
  */
@@ -957,10 +957,10 @@ EXPORT_SYMBOL_GPL(spi_test_execute_msg);
  *                     including all the relevant iterations on:
  *                     length and buffer alignment
  *
- * spi:  the spi_device to send the messages to
- * test: the test which we need to execute
- * tx:   the tx buffer allocated for the test sequence
- * rx:   the rx buffer allocated for the test sequence
+ * @spi:  the spi_device to send the messages to
+ * @test: the test which we need to execute
+ * @tx:   the tx buffer allocated for the test sequence
+ * @rx:   the rx buffer allocated for the test sequence
  *
  * Returns: status code of spi_sync or other failures
  */
-- 
2.25.1

