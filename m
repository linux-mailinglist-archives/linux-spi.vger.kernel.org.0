Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A078B11D9E8
	for <lists+linux-spi@lfdr.de>; Fri, 13 Dec 2019 00:20:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730831AbfLLXUL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 12 Dec 2019 18:20:11 -0500
Received: from rnd-relay.smtp.broadcom.com ([192.19.229.170]:48026 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726427AbfLLXUK (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 12 Dec 2019 18:20:10 -0500
X-Greylist: delayed 444 seconds by postgrey-1.27 at vger.kernel.org; Thu, 12 Dec 2019 18:20:10 EST
Received: from mail-irv-17.broadcom.com (mail-irv-17.lvn.broadcom.net [10.75.242.48])
        by rnd-relay.smtp.broadcom.com (Postfix) with ESMTP id 1801D30C047;
        Thu, 12 Dec 2019 15:08:10 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.10.3 rnd-relay.smtp.broadcom.com 1801D30C047
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1576192090;
        bh=GUHozoaDgbqjfROjXkEJw092rtDS8++6YoSJnSbvtOs=;
        h=From:To:Cc:Subject:Date:From;
        b=TJm/Ng73wQ9MRMHSQu23Rs6/CAol/PxhHn5hDL8FSzsi1yUrQ1ZWsQx8DAQKxH5H2
         hBcjJuA6zXvysnTtThtBA3iGZkLigoAS3Lx+LNkZTmtlzVySXXaiQ3fbq4bBIKW0OT
         8Vk3JDA/NF5tR/StYpnvUvkOw/YmzBcqWOFzVoJ0=
Received: from stbsrv-and-01.and.broadcom.net (stbsrv-and-01.and.broadcom.net [10.28.16.211])
        by mail-irv-17.broadcom.com (Postfix) with ESMTP id E6F7C140069;
        Thu, 12 Dec 2019 15:12:43 -0800 (PST)
From:   Jim Quinlan <james.quinlan@broadcom.com>
To:     linux-spi@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <ray.jui@broadcom.com>,
        Scott Branden <scott.branden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jim Quinlan <james.quinlan@broadcom.com>
Subject: [PATCH] spi: bcm2835: don't print error on clk_get() DEFER
Date:   Thu, 12 Dec 2019 18:12:13 -0500
Message-Id: <20191212231213.29061-1-jquinlan@broadcom.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Otherwise one may get multiple error messages for normal
operation of a clock provider.

Signed-off-by: Jim Quinlan <jquinlan@broadcom.com>
---
 drivers/spi/spi-bcm2835.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index fb61a620effc..6c9addc9f276 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -1305,7 +1305,8 @@ static int bcm2835_spi_probe(struct platform_device *pdev)
 	bs->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(bs->clk)) {
 		err = PTR_ERR(bs->clk);
-		dev_err(&pdev->dev, "could not get clk: %d\n", err);
+		if (err != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "could not get clk: %d\n", err);
 		goto out_controller_put;
 	}
 
-- 
2.17.1

