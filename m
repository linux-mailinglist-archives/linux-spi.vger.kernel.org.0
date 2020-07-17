Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB92223D65
	for <lists+linux-spi@lfdr.de>; Fri, 17 Jul 2020 15:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbgGQNy6 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 17 Jul 2020 09:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727071AbgGQNyk (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 17 Jul 2020 09:54:40 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A122FC0619D2
        for <linux-spi@vger.kernel.org>; Fri, 17 Jul 2020 06:54:40 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id 17so17180587wmo.1
        for <linux-spi@vger.kernel.org>; Fri, 17 Jul 2020 06:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CPH+QD7EGY89rpfM+jPOD+8I8Jq38VLlFewJk4yzuOM=;
        b=VjzgIcU3+ooip1M3AXK8TOgT0tdwcKF6NfoM8oDGAwDytuhYS3FzrGb+gD0Sjj04RP
         6tyujb+FQaCiDYHM2ixzWByHiOOkfBd0lBsy9VaxV+PtktCvhVOceqQZ+cKcGruuUrA0
         O7Gv5SFLmuApMRfZ4hdAu4HGPK1lB5nEBEfUyYFoDANRIzWirPpShVehPf4xCLYivPps
         iB2xoC8Y6/AfyoniZHOquXz01a98gHtBPW5io+sA1mafGTG8zdNDuQHU+/7aGle0kbSz
         m/3XeCqXw41/d+ARjP+Ax1G3nDZ5ChIQ52kQUK5FqdILlK3EDB/vZfoYqY0F57+cPyl0
         1E9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CPH+QD7EGY89rpfM+jPOD+8I8Jq38VLlFewJk4yzuOM=;
        b=SMCZrRTu7axVwEQU0/qBOpO55ubkevYFq75YZbiQ+eQUyP5pmNODjePHtNzGQn51be
         JE4mjJicf1sTvbSw0IwWltzf4YaZ/fO7rYY4QfeutkmyoiryObxzt30Di1c+WY+ql6M+
         wgH0xGJxNc11F9ul/e6S63LJjJVPRSCtk7Ph5TH3BXbooWV14XaFOrAjWmaLktzupe5n
         pXotBbiNsZjxUQIk52tJUjIORIkUeBEMPUhNIZoT00cWMrbuc5B5N28qKPqV66PZfGpQ
         YZI9GWB/YWvU/NZrYJL0t5beEustT2DTr92+2oFPSnemhOIjEYeaXocvprY60MG8QjjQ
         IERA==
X-Gm-Message-State: AOAM53020M617DZVG8q9xgLvAYfbFSeohidlt/z4mXB0Cahs8AWjmF5a
        kqXb6xnH7sAlnxAijmsFqNmqLA==
X-Google-Smtp-Source: ABdhPJw8rtOM08fs2Dc82BjfBnHOOT1pIb5vMuLLZE4XFUuoUcXbreINH3AZhhkT4VVddL8v21h2jw==
X-Received: by 2002:a1c:48d7:: with SMTP id v206mr9115687wma.145.1594994079322;
        Fri, 17 Jul 2020 06:54:39 -0700 (PDT)
Received: from localhost.localdomain ([2.27.167.94])
        by smtp.gmail.com with ESMTPSA id w128sm16118356wmb.19.2020.07.17.06.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 06:54:38 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     broonie@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Radu Pirea <radu_nicolae.pirea@upb.ro>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v2 12/14] spi: spi-at91-usart: Remove unused OF table 'struct of_device_id'
Date:   Fri, 17 Jul 2020 14:54:22 +0100
Message-Id: <20200717135424.2442271-13-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200717135424.2442271-1-lee.jones@linaro.org>
References: <20200717135424.2442271-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The only way this driver can be probed by MFD via its parent device.

No other reference to 'microchip,at91sam9g45-usart-spi' exists in the kernel.

Fixes the following W=1 kernel build warning(s):

 drivers/spi/spi-at91-usart.c:684:34: warning: ‘at91_usart_spi_dt_ids’ defined but not used [-Wunused-const-variable=]
 684 | static const struct of_device_id at91_usart_spi_dt_ids[] = {
 | ^~~~~~~~~~~~~~~~~~~~~

Cc: Radu Pirea <radu_nicolae.pirea@upb.ro>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Ludovic Desroches <ludovic.desroches@microchip.com>
Suggested-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/spi/spi-at91-usart.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/spi/spi-at91-usart.c b/drivers/spi/spi-at91-usart.c
index 88033422a42ae..8c8352625d232 100644
--- a/drivers/spi/spi-at91-usart.c
+++ b/drivers/spi/spi-at91-usart.c
@@ -681,13 +681,6 @@ static const struct dev_pm_ops at91_usart_spi_pm_ops = {
 			   at91_usart_spi_runtime_resume, NULL)
 };
 
-static const struct of_device_id at91_usart_spi_dt_ids[] = {
-	{ .compatible = "microchip,at91sam9g45-usart-spi"},
-	{ /* sentinel */}
-};
-
-MODULE_DEVICE_TABLE(of, at91_usart_spi_dt_ids);
-
 static struct platform_driver at91_usart_spi_driver = {
 	.driver = {
 		.name = "at91_usart_spi",
-- 
2.25.1

