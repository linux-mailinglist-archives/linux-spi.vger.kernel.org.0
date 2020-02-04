Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0CE21520D1
	for <lists+linux-spi@lfdr.de>; Tue,  4 Feb 2020 20:12:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbgBDTML (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 4 Feb 2020 14:12:11 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36590 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727472AbgBDTMK (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 4 Feb 2020 14:12:10 -0500
Received: by mail-pl1-f196.google.com with SMTP id a6so7667582plm.3
        for <linux-spi@vger.kernel.org>; Tue, 04 Feb 2020 11:12:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tFXhEwC/wFCkTe/lPBw8m3XC/MunfcfcPF2H9ytGoVc=;
        b=lPud0IhyMRajOMKw49bKGnWv+xpIFX1ZYKTLwemLAOwK9T0aHLDngCuhvEKt+dtJGx
         rjUBAZ7USNj9U4KRqF2gjZo37W4178z3GRxFF/oWtYDDGFZWmI9dB9RxwOMMThN6sDHO
         KLLXiB44aHmu5mI8Nx60UyYqRlRJLOTAFDSGc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tFXhEwC/wFCkTe/lPBw8m3XC/MunfcfcPF2H9ytGoVc=;
        b=K6qtE4EoG0tQzx7haRf+PO7EZ9NluPpVsjl+mEYJjy1I2Ks31A0guXCy/Cu06rT8Sg
         GrAr1jZ3eilbafbBQKYRv0Wg+h8KwdlQozP+r2HauBbLhnXihtXHFI1qsfPdV2r0qEh/
         JoLfUG+Ny7b0nFBc5pv8PhRACoHmszz94EYXnxP7sjWbhI1AxkIAKy0aWxI15sJd7V8Z
         gD27gAqniEShD5skn9Rn8i9aJ9C+o4alhd2JxubnwYBkrsBugmOCHRm0Hxcj4dfh4Kj9
         nNWfwAziZ1tJG6SxbDI2zO4Bjk4iwzXSNsFa3Snmy8PZeXt34m9apPHnuIRj/QMfaorX
         AEIw==
X-Gm-Message-State: APjAAAXXIDHS/Wr2bOxRWBSJciM+pIEZq3gBDy4NOXGDcsnXyYKiaXsn
        jWbmYRxTqQDK3dnIWC8J5Wk81Q==
X-Google-Smtp-Source: APXvYqwNQG37TNBqu0MyO3BxrbVd79f56GLuwPiZ6tu1FZGC4hxyGZHTkNe/F46qpzjEOch7mYsYhg==
X-Received: by 2002:a17:90a:ead8:: with SMTP id ev24mr688790pjb.91.1580843528907;
        Tue, 04 Feb 2020 11:12:08 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id c19sm26303229pfc.144.2020.02.04.11.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 11:12:08 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-spi@vger.kernel.org,
        Girish Mahadevan <girishm@codeaurora.org>,
        Dilip Kota <dkota@codeaurora.org>,
        Alok Chauhan <alokc@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH 1/3] spi: spi-geni-qcom: Let firmware specify irq trigger flags
Date:   Tue,  4 Feb 2020 11:12:04 -0800
Message-Id: <20200204191206.97036-2-swboyd@chromium.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
In-Reply-To: <20200204191206.97036-1-swboyd@chromium.org>
References: <20200204191206.97036-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

We don't need to force IRQF_TRIGGER_HIGH here as the DT or ACPI tables
should take care of this for us. Just use 0 instead so that we use the
flags from the firmware.

Cc: Girish Mahadevan <girishm@codeaurora.org>
Cc: Dilip Kota <dkota@codeaurora.org>
Cc: Alok Chauhan <alokc@codeaurora.org>
Cc: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/spi/spi-geni-qcom.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index 6f3d64a1a2b3..46e501fc87f3 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -585,8 +585,7 @@ static int spi_geni_probe(struct platform_device *pdev)
 	if (ret)
 		goto spi_geni_probe_runtime_disable;
 
-	ret = request_irq(mas->irq, geni_spi_isr,
-			IRQF_TRIGGER_HIGH, "spi_geni", spi);
+	ret = request_irq(mas->irq, geni_spi_isr, 0, dev_name(&pdev->dev), spi);
 	if (ret)
 		goto spi_geni_probe_runtime_disable;
 
-- 
Sent by a computer, using git, on the internet

