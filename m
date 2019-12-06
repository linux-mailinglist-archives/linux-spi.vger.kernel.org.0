Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3F981154BE
	for <lists+linux-spi@lfdr.de>; Fri,  6 Dec 2019 17:00:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbfLFQA0 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 6 Dec 2019 11:00:26 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39767 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbfLFQAZ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 6 Dec 2019 11:00:25 -0500
Received: by mail-wr1-f67.google.com with SMTP id y11so8310920wrt.6
        for <linux-spi@vger.kernel.org>; Fri, 06 Dec 2019 08:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=newoldbits-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7LlOYdOlwyOQe/T3jn5qpLPyeLc1jpyOUw2w7YnN5+A=;
        b=bmPSKSxZ15XLOFepLRVLG4iobsqRquo7BfqKAknB6/Ftq09A4iFtVSY6BB5pcRXt+7
         0IXr+keD46nvi/CjA9XVA2sA13jKCxPoP53VOhpQdJVekW/9my0Gx7aIFjAXc3G6wLQL
         6m2qFkDnl7FN8GF/kywLSjgLPaM1R3ghSwK7J0O2jA4hNyhnoPsrtySoAF9V4dUUZFqZ
         F0x7zAxuIlDuoM+1g3xuthtjTTDiTEcGIqHtWo27saBB/dX+iIgp2t++BzYIlkpdR14L
         a6pRVZy9Pxkp1jOGk6sjbjT8QB/n5adXfH5YfYJrjDhI80q5q4d1rEkr4PlywgvbGAiQ
         CtgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7LlOYdOlwyOQe/T3jn5qpLPyeLc1jpyOUw2w7YnN5+A=;
        b=FVmJOgL4aKWNdUhBoaR5GXXv/HGZAgOeLpoP9u0fBYcCD1ovtIDfLnJMMCKU6fbWL5
         n7r75MvW/0YFosIiWYxGPVavdTfCY/VRpEhwEmhTR2Ir1cWaDJRmxeWtER/ThKKANtxk
         0To6nAcxkynKlVEEFNWbpcesqeoNbZDNZL5mST3u/Mo3JuyucRiJgP5mP4MaYFMuz3e5
         JJ1lAT3LiMa9MbieSJ3YOyPOTLNYFn1wS62Nn34raktNn6AwWjRP+j0vp+prjkcAVFUZ
         gMNXVd1g4lo08PAxPRAssqDMf9w5vK3+/1WiNXTysXThSnURWUOqamHwImi7IQRoJwMr
         AQIQ==
X-Gm-Message-State: APjAAAVm/tCvp/308OpimE7Tl8PHQkWYQKKLsZNj1iJk2r7rbHc582aw
        a/PtOsMN4+Y6RhPdjdA42UiZzQ==
X-Google-Smtp-Source: APXvYqygtAC0GnCtoe88Jg0onEgQJqKm9U1HvdZxe4QiMPEQsCJG6hvoHDAVy6tOo795J1KH3+KCCA==
X-Received: by 2002:a5d:50cf:: with SMTP id f15mr16476060wrt.381.1575648023717;
        Fri, 06 Dec 2019 08:00:23 -0800 (PST)
Received: from msilabo.lan (241.33-200-80.adsl-dyn.isp.belgacom.be. [80.200.33.241])
        by smtp.gmail.com with ESMTPSA id d19sm3891496wmd.38.2019.12.06.08.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 08:00:23 -0800 (PST)
From:   Jean Pihet <jean.pihet@newoldbits.com>
To:     Mark Brown <broonie@kernel.org>, Tero Kristo <t-kristo@ti.com>
Cc:     linux-omap@vger.kernel.org, linux-spi@vger.kernel.org,
        Ryan Barnett <ryan.barnett@rockwellcollins.com>,
        Conrad Ratschan <conrad.ratschan@rockwellcollins.com>,
        Jean Pihet <jean.pihet@newoldbits.com>
Subject: [PATCH 1/3] TI QSPI: Fix fclk frequency
Date:   Fri,  6 Dec 2019 17:00:05 +0100
Message-Id: <20191206160007.331801-2-jean.pihet@newoldbits.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191206160007.331801-1-jean.pihet@newoldbits.com>
References: <20191206160007.331801-1-jean.pihet@newoldbits.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The QSPI IP is clocked by two clocks:
- CORE_CLKOUTM4 / 2 (L3) as interface clock,
- PER_CLKOUTM2 / 4 (L4) as functional clock, which is PER_CLKOUTM2
  divided by 4, so at 192Mhz / 4 = 48MHz.

Fix the use of the correct fclk by the driver and fix the frequency
value so that the divider is correctly programmed to generate the
desired frequency of QSPI_CLK.
---
 drivers/spi/spi-ti-qspi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index 3cb65371ae3b..4680dad38ab2 100644
--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -79,7 +79,7 @@ struct ti_qspi {
 
 #define QSPI_COMPLETION_TIMEOUT		msecs_to_jiffies(2000)
 
-#define QSPI_FCLK			192000000
+#define QSPI_FCLK			48000000
 
 /* Clock Control */
 #define QSPI_CLK_EN			(1 << 31)
@@ -748,7 +748,7 @@ static int ti_qspi_probe(struct platform_device *pdev)
 		}
 	}
 
-	qspi->fclk = devm_clk_get(&pdev->dev, "fck");
+	qspi->fclk = devm_clk_get(&pdev->dev, "dpll_per_m2_div4_ck");
 	if (IS_ERR(qspi->fclk)) {
 		ret = PTR_ERR(qspi->fclk);
 		dev_err(&pdev->dev, "could not get clk: %d\n", ret);
-- 
2.23.0

