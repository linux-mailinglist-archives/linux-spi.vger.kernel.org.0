Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C38511BD29
	for <lists+linux-spi@lfdr.de>; Wed, 11 Dec 2019 20:40:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbfLKTkO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 11 Dec 2019 14:40:14 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41904 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727002AbfLKTkO (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 11 Dec 2019 14:40:14 -0500
Received: by mail-wr1-f66.google.com with SMTP id c9so25405507wrw.8
        for <linux-spi@vger.kernel.org>; Wed, 11 Dec 2019 11:40:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=newoldbits-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BQmYkzxzuJFcEZEM1zZf6dMLQjogmuzV839YGrPJbCo=;
        b=FgQpTSTBkhSXGcl296Oqs66MZgJoxfXx7Bim02LCDBoV7hEBFTLWI7bTz4hncSbefv
         lPVjZGYITyVCPQzLPRwXln6FD2KEbfRZkTpUXTRXFvP86ZhrLMy5hbo9NvMDf72ZGUd7
         0JzLoK4gmfnCQRT2aBXzLp68Q12G5FaCUTe6D/xfL/Q0L+K/91iHLMeDVeqJrAUnufzh
         9gAGPUAU/VaYe6R3mYA4UzwGcxzh3JEhKE4Pwr7+398B7E/WwFJmZlS5SQvi8BT0bqKL
         yv6UMqrAK4CU4v+rDUjseSDCBgYYxci6pUdcDvPc2MJDVnC4Iv+qU05zpM4d4M/y8TFT
         /QMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BQmYkzxzuJFcEZEM1zZf6dMLQjogmuzV839YGrPJbCo=;
        b=PCJSt1jj1FoBZbBxvF/i4axCZEWSPb680VGyrqDbA3AmV75YHkxY/E6m/e/QIoSJ8k
         j5+E51yIT/OleummvY9JIWOjUt7RaoewPJk40Loo1pEqKdTX6XjSEFCCXDKpgYMPoy5+
         qXsGXt51fUzOhD3xKWTJ17UGbEzYlwRR/VBre4nKnhwb4LrpveWIi7HCvL3UkioRG/pN
         HbW3olbu3f/KL5EcJZPlWcoH6xMxyZsgNi9dO4jvxA//RXX8hIPySM7jjjoc3rxoP7ct
         I1cTMdCnQwGpw5GC8Z/Ex2jA/G+lOgPqwmpBi3FolPUOf+ajY3kJj3+w58fIuLFfYvKI
         8iaw==
X-Gm-Message-State: APjAAAVrqE5Q1j2r9pY6+lyM1phk+kfnqadqm86y5S4bItKhOgDtGrRh
        sYM+BsQzUZsyG/BBAQBtJw9enA==
X-Google-Smtp-Source: APXvYqxmrSljC7te1sBWtHOqGTVoBhPFhWAFPbU/E5oMvQVdyvKXT3hPX1LRSHLiBq6+Lk7IBkvLeQ==
X-Received: by 2002:a5d:6a52:: with SMTP id t18mr1514397wrw.391.1576093212580;
        Wed, 11 Dec 2019 11:40:12 -0800 (PST)
Received: from msilabo.lan (241.33-200-80.adsl-dyn.isp.belgacom.be. [80.200.33.241])
        by smtp.gmail.com with ESMTPSA id x1sm3309964wru.50.2019.12.11.11.40.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 11:40:12 -0800 (PST)
From:   Jean Pihet <jean.pihet@newoldbits.com>
To:     Mark Brown <broonie@kernel.org>, Tony Lindgren <tony@atomide.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-omap@vger.kernel.org, linux-spi@vger.kernel.org,
        Ryan Barnett <ryan.barnett@rockwellcollins.com>,
        Conrad Ratschan <conrad.ratschan@rockwellcollins.com>,
        Arnout Vandecappelle <arnout.vandecappelle@essensium.com>,
        Jean Pihet <jean.pihet@newoldbits.com>
Subject: [PATCH 1/3] spi: spi-ti-qspi: Remove unused macro for fclk frequency
Date:   Wed, 11 Dec 2019 20:39:52 +0100
Message-Id: <20191211193954.747745-2-jean.pihet@newoldbits.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191211193954.747745-1-jean.pihet@newoldbits.com>
References: <20191211193954.747745-1-jean.pihet@newoldbits.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The fclk and its rate are retrieved from DT.

Signed-off-by: Jean Pihet <jean.pihet@newoldbits.com>
Cc: Ryan Barnett <ryan.barnett@rockwellcollins.com>
Cc: Conrad Ratschan <conrad.ratschan@rockwellcollins.com>
Cc: Arnout Vandecappelle <arnout.vandecappelle@essensium.com>
---
 drivers/spi/spi-ti-qspi.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index 3cb65371ae3b..a18835128ad0 100644
--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -79,8 +79,6 @@ struct ti_qspi {
 
 #define QSPI_COMPLETION_TIMEOUT		msecs_to_jiffies(2000)
 
-#define QSPI_FCLK			192000000
-
 /* Clock Control */
 #define QSPI_CLK_EN			(1 << 31)
 #define QSPI_CLK_DIV_MAX		0xffff
-- 
2.23.0

