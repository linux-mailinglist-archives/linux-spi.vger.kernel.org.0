Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB68F75FA5
	for <lists+linux-spi@lfdr.de>; Fri, 26 Jul 2019 09:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbfGZHVa (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 26 Jul 2019 03:21:30 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45690 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726425AbfGZHV3 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 26 Jul 2019 03:21:29 -0400
Received: by mail-pf1-f195.google.com with SMTP id r1so24058666pfq.12
        for <linux-spi@vger.kernel.org>; Fri, 26 Jul 2019 00:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=b1L8klkoL2Oqr4w2X+VMFT6OyaJM5PiYuc6bxPNU4L8=;
        b=vFi7c+GFBkJu3RCOXu9B84n2sjWjYyooQbcp5xnohrzGwUanT74gDGHm+agculUfuB
         e+79A1x/faNu+a9h13lWaqV6TWZpV6mecRdyBZ6TTI+KoZWr25dixirBm4GiFD5OwLdH
         tXpgF3leSF9Hs5VNpLmJ/1VMcVsFxY8oZ2tvjTCBmcxd+nyxhsxNINiJiMZWFB7r0bMw
         nqP6whtn/2Twy8dv5V44OsUyAZiiEPr5BLB9z4reDW3slv0nfeAYEikjH6tR2mHedotn
         43lqm3+QaTTwusAVyqhZ+Fb6WO7w9H+n7v9xTrvAgCehB6j4/OOEAyLxgRGq0nTQHjHh
         IG/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=b1L8klkoL2Oqr4w2X+VMFT6OyaJM5PiYuc6bxPNU4L8=;
        b=L422QloKt4mDmfrHsfUGh6wEfHtV36iMjBB9pDq6JWIY5SRAVk1R1d1zesh9hSvB1F
         hAT85vQga77CJzHyw7ti9KSnR5LIl1DciZrGGRovkEHej8iFp8ynx8g94ZCEJdhtoErO
         fdrMWtlyO+Fi9i4l7HwQo3OXWzqTtOiSFhujniLO8ytSFFQSV2Cy/CuOnOI65zM9RUCF
         WiJWoCjOOnH9M0Y5etCConhcrdeTUpJunAW4jZrcZjGbpaWZIJmWkIl50NmWn6scZFXe
         +rvb8zz8+XrVJhWZKhKdj/d7cCJIapBxwy20ikmInet6e/n+1VulLP8ZSewgHC6Yvobv
         +bWw==
X-Gm-Message-State: APjAAAW5wNQz/Lyq7fT5Dqd7lrAxC7AS2MdIBt7c2e5M7BiA4e4+zgkL
        KNsR3KfLH3KiOy+OueFm8pS4iQ==
X-Google-Smtp-Source: APXvYqytiXGy9298ahfsFwdG/dHp5uFRVOPA+85oJZChaPzhIOEXor/W3Ofvm32sNABxSRQxJdN3JA==
X-Received: by 2002:a65:6691:: with SMTP id b17mr74681456pgw.217.1564125689079;
        Fri, 26 Jul 2019 00:21:29 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id o12sm39216152pjr.22.2019.07.26.00.21.25
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 26 Jul 2019 00:21:28 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        orsonzhai@gmail.com, zhang.lyra@gmail.com
Cc:     weicx@spreadst.com, sherry.zong@unisoc.com, baolin.wang@linaro.org,
        vincent.guittot@linaro.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] spi: sprd: adi: Add a reset reason for TOS panic
Date:   Fri, 26 Jul 2019 15:20:49 +0800
Message-Id: <97583aad1f2b849d69b4e76e8d29113da72a9fff.1564125131.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1564125131.git.baolin.wang@linaro.org>
References: <cover.1564125131.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1564125131.git.baolin.wang@linaro.org>
References: <cover.1564125131.git.baolin.wang@linaro.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Chenxu Wei <weicx@spreadst.com>

Add a new reset flag to indicate the reset reason is caused by TOS.

Signed-off-by: Chenxu Wei <weicx@spreadst.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/spi/spi-sprd-adi.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spi/spi-sprd-adi.c b/drivers/spi/spi-sprd-adi.c
index 11880db..0b3f23a 100644
--- a/drivers/spi/spi-sprd-adi.c
+++ b/drivers/spi/spi-sprd-adi.c
@@ -86,6 +86,7 @@
 #define BIT_WDG_EN			BIT(2)
 
 /* Definition of PMIC reset status register */
+#define HWRST_STATUS_SECURITY		0x02
 #define HWRST_STATUS_RECOVERY		0x20
 #define HWRST_STATUS_NORMAL		0x40
 #define HWRST_STATUS_ALARM		0x50
@@ -336,6 +337,8 @@ static int sprd_adi_restart_handler(struct notifier_block *this,
 		reboot_mode = HWRST_STATUS_IQMODE;
 	else if (!strncmp(cmd, "sprdisk", 7))
 		reboot_mode = HWRST_STATUS_SPRDISK;
+	else if (!strncmp(cmd, "tospanic", 8))
+		reboot_mode = HWRST_STATUS_SECURITY;
 	else
 		reboot_mode = HWRST_STATUS_NORMAL;
 
-- 
1.7.9.5

