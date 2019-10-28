Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5D2EE6F84
	for <lists+linux-spi@lfdr.de>; Mon, 28 Oct 2019 11:11:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388170AbfJ1KLX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 28 Oct 2019 06:11:23 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44003 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388149AbfJ1KLX (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 28 Oct 2019 06:11:23 -0400
Received: by mail-pf1-f194.google.com with SMTP id 3so6582066pfb.10
        for <linux-spi@vger.kernel.org>; Mon, 28 Oct 2019 03:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=TSybe+dFKlqevnmjqNjuekSQWHSuKSnD0nflXZ2xCj4=;
        b=Ja5MjdptNY5444q7novwsPVMwKvLwr3tN+AhIwAlDX1p0OJEkudGvvoBJF6cDPWhiE
         cThwQ4pXjy69i1A5DQxz+oW5vrUzBGW279fFN21/S85xIxfSi9bddBSWxWWPrTZUShoD
         if4r2aNp80WuNFZk4r8i2WGUJhG+OlO8os7hgrp3sdBR4f2QromHByggmPO/jVhaDUgr
         EFfjr+aAC+ElJ0u3IgdEbh3uKVvmpeVh9mQAbsOsUHMIhO5H5BdQwCGxEy4YsK/vlu9J
         EMjbx9CBtcHVdPUHuv/FJ/ITLC0IXGD9DA2KfCD16Rt0bukMkHb0QNr4oVRm3PVkr8G7
         Qd1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=TSybe+dFKlqevnmjqNjuekSQWHSuKSnD0nflXZ2xCj4=;
        b=UhoX3CTBvX9WjG6Wk/QzIj3TuuBBKE8gu7EC9kYYT3Jf//MnJySQP8vnhkAP2M74/1
         DYLiiEcIeHogYYyhNs251vmQ1GAkm+5yWUnzYwkNkaSqhTFcOFXFxDNHDYimbNmb4Vgk
         oBMZRZ90WT4k6AaED+IMw5kUmTbJkccFjQBZ2hrE4PM1oHKS1xvp/X6LiSd7numY9FQa
         zQRaUvzR5RxnPOOWouVPfjyUhtifPseMGjxgT37ij/Qy/c6MRtMYS9HqxWMw3XV6tnff
         TCfkLd6NvCUZkWBE+JTRwbjbXf6PeDf6oeT1SB1eZeN8RrWetPficGyjHqz/cW6lmv+3
         w+wg==
X-Gm-Message-State: APjAAAUctaxpX19qMzjlBUbXtOwxJ3YpstZmcL4mLVCaah4mSPpe5Czs
        ChXZpC/ph/F5ogYI4MYP9JMTeQ==
X-Google-Smtp-Source: APXvYqyHgWSXAJOFrFZjXigKAOtcpWME0TG39UASF+T0yEKF0Dn0kf9T4eqYfNOumc9ZwvUcvBk9Fg==
X-Received: by 2002:a62:1646:: with SMTP id 67mr20094313pfw.183.1572257482219;
        Mon, 28 Oct 2019 03:11:22 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id m26sm3071872pgd.87.2019.10.28.03.11.19
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Oct 2019 03:11:21 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     broonie@kernel.org
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, baolin.wang@linaro.org,
        baolin.wang7@gmail.com, ling_ling.xu@unisoc.com,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] spi: sprd: adi: Set BIT_WDG_NEW bit when rebooting
Date:   Mon, 28 Oct 2019 18:10:31 +0800
Message-Id: <5655318a7252c9ea518c2f7950a61228ab8f42bf.1572257085.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <7b04711127434555e3a1a86bc6be99860cd86668.1572257085.git.baolin.wang@linaro.org>
References: <7b04711127434555e3a1a86bc6be99860cd86668.1572257085.git.baolin.wang@linaro.org>
In-Reply-To: <7b04711127434555e3a1a86bc6be99860cd86668.1572257085.git.baolin.wang@linaro.org>
References: <7b04711127434555e3a1a86bc6be99860cd86668.1572257085.git.baolin.wang@linaro.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Lingling Xu <ling_ling.xu@unisoc.com>

When rebooting system, the PMIC watchdog time loading may not be loaded
correctly when another system is feeding the PMIC watchdog, since we did
not check the watchdog busy status before loading time values.

Thus we should set the BIT_WDG_NEW bit before loading time values, that
can support multiple loads without checking busy status to make sure the
time values can be loaded successfully to avoid this potential issue.

Signed-off-by: Lingling Xu <ling_ling.xu@unisoc.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/spi/spi-sprd-adi.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/spi/spi-sprd-adi.c b/drivers/spi/spi-sprd-adi.c
index 9613cfe..87dadb6 100644
--- a/drivers/spi/spi-sprd-adi.c
+++ b/drivers/spi/spi-sprd-adi.c
@@ -77,6 +77,7 @@
 
 /* Bits definitions for register REG_WDG_CTRL */
 #define BIT_WDG_RUN			BIT(1)
+#define BIT_WDG_NEW			BIT(2)
 #define BIT_WDG_RST			BIT(3)
 
 /* Registers definitions for PMIC */
@@ -383,6 +384,10 @@ static int sprd_adi_restart_handler(struct notifier_block *this,
 	/* Unlock the watchdog */
 	sprd_adi_write(sadi, sadi->slave_pbase + REG_WDG_LOCK, WDG_UNLOCK_KEY);
 
+	sprd_adi_read(sadi, sadi->slave_pbase + REG_WDG_CTRL, &val);
+	val |= BIT_WDG_NEW;
+	sprd_adi_write(sadi, sadi->slave_pbase + REG_WDG_CTRL, val);
+
 	/* Load the watchdog timeout value, 50ms is always enough. */
 	sprd_adi_write(sadi, sadi->slave_pbase + REG_WDG_LOAD_LOW,
 		       WDG_LOAD_VAL & WDG_LOAD_MASK);
-- 
1.7.9.5

