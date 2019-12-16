Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35051121EC4
	for <lists+linux-spi@lfdr.de>; Tue, 17 Dec 2019 00:10:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbfLPXIX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 16 Dec 2019 18:08:23 -0500
Received: from rnd-relay.smtp.broadcom.com ([192.19.229.170]:44532 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726487AbfLPXIX (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 16 Dec 2019 18:08:23 -0500
Received: from mail-irv-17.broadcom.com (mail-irv-17.lvn.broadcom.net [10.75.242.48])
        by rnd-relay.smtp.broadcom.com (Postfix) with ESMTP id 5352B30C314;
        Mon, 16 Dec 2019 15:03:34 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.10.3 rnd-relay.smtp.broadcom.com 5352B30C314
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1576537414;
        bh=tNe9jvD+5chQn79aLCyEclvjgXPj+VGw2GW/43TZLBY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=srSXHoz4cswAPHaty5INghjNTJz8PHS1SNmf6+y06EP2p5RSwglJMjUD7hjggaZPF
         9376L+OpNBCMOCH9xn46VW/r+lsPvfv3Mior5xZjgbAREDLi7E1GqXoMd2Xclbh0ME
         WlbVQe+4hqagWEVOo5+AnHfuUTBx7LwWkwlajgqg=
Received: from stbsrv-and-01.and.broadcom.net (stbsrv-and-01.and.broadcom.net [10.28.16.211])
        by mail-irv-17.broadcom.com (Postfix) with ESMTP id 92E63140069;
        Mon, 16 Dec 2019 15:08:20 -0800 (PST)
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
Subject: [PATCH v2 1/1] spi: bcm2835: no dev_err() on clk_get() -EPROBE_DEFER
Date:   Mon, 16 Dec 2019 18:08:02 -0500
Message-Id: <20191216230802.45715-2-jquinlan@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191216230802.45715-1-jquinlan@broadcom.com>
References: <20191216230802.45715-1-jquinlan@broadcom.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Use dev_dbg() on -EPROBE_DEFER and dev_err() on all
other errors.

Signed-off-by: Jim Quinlan <jquinlan@broadcom.com>
---
 drivers/spi/spi-bcm2835.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index fb61a620effc..e4b57b751ce2 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -1305,7 +1305,10 @@ static int bcm2835_spi_probe(struct platform_device *pdev)
 	bs->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(bs->clk)) {
 		err = PTR_ERR(bs->clk);
-		dev_err(&pdev->dev, "could not get clk: %d\n", err);
+		if (err == -EPROBE_DEFER)
+			dev_dbg(&pdev->dev, "could not get clk: %d\n", err);
+		else
+			dev_err(&pdev->dev, "could not get clk: %d\n", err);
 		goto out_controller_put;
 	}
 
-- 
2.17.1

