Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AED031AFD75
	for <lists+linux-spi@lfdr.de>; Sun, 19 Apr 2020 21:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbgDST0p (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 19 Apr 2020 15:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbgDST0p (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 19 Apr 2020 15:26:45 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09438C061A0C;
        Sun, 19 Apr 2020 12:26:45 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id a22so3464899pjk.5;
        Sun, 19 Apr 2020 12:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pMhdquAr/HzwmzyKmiKytwMMb3XOVcxGDwBpxb4EVIg=;
        b=UlBQrYXLrdkGZ0G70SpLh4Q4zMV+/d8t+uiaDHD9q4axnbr0qlg85uy/xlPPPGwg/K
         d9GWK1QnkWSDbYzAOGgD653D3GY/kVmCCFPmmnsmax3a+ntw2LoNSZMr6eM1RrfunqbQ
         oOXOrQ9VJUKrRmZgOeHr7hEUEDiP0UQnHseBgOcvdbP7wbOJN8Qj4p/OyQXzFiZPRQld
         WJH28TWhCGh/hYlE2n0e+sQp2jcczEzB8RpxsJQOKR/0CKZFKI2KyI86GeytmpGj63fg
         rvAIR5+l5gbk8IHMKqHD8egXd2ZtreQFjlaN2KMA/9lBXEo6Sa0JqAA5/ibOKZWgTAoQ
         JrAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pMhdquAr/HzwmzyKmiKytwMMb3XOVcxGDwBpxb4EVIg=;
        b=JF5HwfXQS+h5O+o7Qmrl5Duh0GxABFFYe4YeyKyYK9wbgtlH9catu/tfsnWHDSsHAE
         qtCggMuzlFOOXAjBL9S87WN3WXOaeUnod+viW+jUiuOrAYsOP8SmLczsduLimGwf7T05
         +r9ziOjrp62XLoUL+hLvyeO5atyklcwBNdhaxmehA83/Upo7UWq1jcPC80E/hrx24SmW
         VKr/23aIVwy5JPcJP5mORkBtPr0VwE1Udv/0VS04UDQqfTvzcbPgqUST/S8ZPqchG8kY
         +cYErOMJ2gXNIe61FdzGIIhFra0AZdae1CNo5iCqS5uP2Nte6AcJsAIcnYMyn44D+EYS
         u7uQ==
X-Gm-Message-State: AGi0PubW0e0VGpZhni/IZk2/nx1Y72ncdCr8rGZa1s0umqCrU/beBEAf
        j5FsJ4bFcuuY2LsXz/D2nJka8szDbt8=
X-Google-Smtp-Source: APiQypJUCOnxdO12HZ7x4lmV0A3J9bRJMfas4lrJHVXpUZxKRi5IWl8oNDtC8PSwDtMu4uWwKPsB6A==
X-Received: by 2002:a17:90a:d3ca:: with SMTP id d10mr4836977pjw.24.1587324404651;
        Sun, 19 Apr 2020 12:26:44 -0700 (PDT)
Received: from mail.broadcom.com ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id x16sm22724383pfm.146.2020.04.19.12.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2020 12:26:44 -0700 (PDT)
From:   Kamal Dasu <kdasu.kdev@gmail.com>
To:     Kamal Dasu <kdasu.kdev@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [Patch v2 9/9] spi: bcm-qspi: MSPI_SPCR0_MSB MSTR bit exists only on legacy controllers
Date:   Sun, 19 Apr 2020 15:23:38 -0400
Message-Id: <20200419192339.32023-10-kdasu.kdev@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200419192339.32023-1-kdasu.kdev@gmail.com>
References: <20200419192339.32023-1-kdasu.kdev@gmail.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Set MASTER bit on the MSPI_SPCR0_MSB only for legacy MSPI and HIF_MSPI
controllers.

Fixes: fa236a7ef240 ("spi: bcm-qspi: Add Broadcom MSPI driver")
Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
---
 drivers/spi/spi-bcm-qspi.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-bcm-qspi.c b/drivers/spi/spi-bcm-qspi.c
index 99f2cfcbb50c..681d09085175 100644
--- a/drivers/spi/spi-bcm-qspi.c
+++ b/drivers/spi/spi-bcm-qspi.c
@@ -576,11 +576,17 @@ static void bcm_qspi_hw_set_parms(struct bcm_qspi *qspi,
 	spcr = clamp_val(spbr, bcm_qspi_spbr_min(qspi), QSPI_SPBR_MAX);
 	bcm_qspi_write(qspi, MSPI, MSPI_SPCR0_LSB, spcr);
 
-	spcr = MSPI_MASTER_BIT;
+	if (!qspi->mspi_maj_rev)
+		/* legacy controller */
+		spcr = MSPI_MASTER_BIT;
+	else
+		spcr = 0;
+
 	/* for 16 bit the data should be zero */
 	if (xp->bits_per_word != 16)
 		spcr |= xp->bits_per_word << 2;
 	spcr |= xp->mode & 3;
+
 	bcm_qspi_write(qspi, MSPI, MSPI_SPCR0_MSB, spcr);
 
 	if (bcm_qspi_has_fastbr(qspi)) {
-- 
2.17.1

