Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80FAF2FD596
	for <lists+linux-spi@lfdr.de>; Wed, 20 Jan 2021 17:26:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403914AbhATQ0b (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 20 Jan 2021 11:26:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:44306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732197AbhATQWR (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 20 Jan 2021 11:22:17 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E5FD7233EB
        for <linux-spi@vger.kernel.org>; Wed, 20 Jan 2021 16:21:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
        dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="GL4cQ3DS"
Envelope-to: broonie@sirena.co.uk
Delivery-date: Wed, 20 Jan 2021 12:51:58 +0000
Received: from mail.kernel.org ([198.145.29.99])
        by cassiel.sirena.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <SRS0=RSKV=GX=163.com=bianpan2016@kernel.org>)
        id 1l2Cxo-0005UN-11
        for broonie@sirena.co.uk; Wed, 20 Jan 2021 12:51:58 +0000
Received: by mail.kernel.org (Postfix)
        id 3F43C23355; Wed, 20 Jan 2021 12:51:54 +0000 (UTC)
X-Greylist: delayed 1037 seconds by postgrey-1.34 at mail.kernel.org; Wed, 20 Jan 2021 12:51:48 UTC
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBFA62333C
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bianpan2016@163.com
Received: by mail.kernel.org (Postfix) with SMTP id DBFA62333C
        for <broonie@kernel.org>; Wed, 20 Jan 2021 12:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=QKBPJdPhe6W3ktMeVz
        19YEpmtpvlJjr+9MD8d5vLnQc=; b=GL4cQ3DSEwXQ3/jn/OTpk3Nih5M4X1pnhP
        H7zdG+1pJntREwK7czGn0zQ7ipNtbKhBcL/YZC17JMzRTNbqJZJz9VdquacdWcs6
        bsyX/q5awCDYd4FFqk/2jdpDPNeQPvwW4tdg6C49mstAWpN6gOVEVkTCb5DJrw73
        p3gAPT/Lo=
Received: from localhost.localdomain (unknown [119.3.119.20])
        by smtp8 (Coremail) with SMTP id DMCowADHLNoLIwhgVejfMw--.54081S4;
        Wed, 20 Jan 2021 20:33:18 +0800 (CST)
From:   Pan Bian <bianpan2016@163.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Carlo Caione <carlo@caione.org>
Cc:     linux-kernel@vger.kernel.org, Pan Bian <bianpan2016@163.com>
Date:   Wed, 20 Jan 2021 04:33:13 -0800
Message-Id: <20210120123313.107640-1-bianpan2016@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: DMCowADHLNoLIwhgVejfMw--.54081S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kw45Jr4fJr1ftFykXry7KFg_yoW8JFyDpa
        15WFZFkr48CFy8Gw48G39Fva4YqF1jy3s7Z3y8GwsYkF98JFnxJrn7ZFy5AayrKrykJr42
        yrZrtr18AF18XrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07bxv38UUUUU=
X-Originating-IP: [119.3.119.20]
X-CM-SenderInfo: held01tdqsiiqw6rljoofrz/xtbBUQ8gclaD9tCoEwAAsE
X-SA-Exim-Connect-IP: 198.145.29.99
X-SA-Exim-Mail-From: SRS0=RSKV=GX=163.com=bianpan2016@kernel.org
Subject: [PATCH] regulator: axp20x: Fix reference cout leak
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: No (on cassiel.sirena.org.uk); Unknown failure
X-TUID: H60/oaCO9bgn
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Decrements the reference count of device node and its child node.

Fixes: dfe7a1b058bb ("regulator: AXP20x: Add support for regulators subsystem")
Signed-off-by: Pan Bian <bianpan2016@163.com>
---
 drivers/regulator/axp20x-regulator.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
index 90cb8445f721..d260c442b788 100644
--- a/drivers/regulator/axp20x-regulator.c
+++ b/drivers/regulator/axp20x-regulator.c
@@ -1070,7 +1070,7 @@ static int axp20x_set_dcdc_freq(struct platform_device *pdev, u32 dcdcfreq)
 static int axp20x_regulator_parse_dt(struct platform_device *pdev)
 {
 	struct device_node *np, *regulators;
-	int ret;
+	int ret = 0;
 	u32 dcdcfreq = 0;
 
 	np = of_node_get(pdev->dev.parent->of_node);
@@ -1085,13 +1085,12 @@ static int axp20x_regulator_parse_dt(struct platform_device *pdev)
 		ret = axp20x_set_dcdc_freq(pdev, dcdcfreq);
 		if (ret < 0) {
 			dev_err(&pdev->dev, "Error setting dcdc frequency: %d\n", ret);
-			return ret;
 		}
-
 		of_node_put(regulators);
 	}
 
-	return 0;
+	of_node_put(np);
+	return ret;
 }
 
 static int axp20x_set_dcdc_workmode(struct regulator_dev *rdev, int id, u32 workmode)
-- 
2.17.1


