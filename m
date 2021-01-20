Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E69362FD5B1
	for <lists+linux-spi@lfdr.de>; Wed, 20 Jan 2021 17:33:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403945AbhATQ0e (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 20 Jan 2021 11:26:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:44124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403985AbhATQWH (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 20 Jan 2021 11:22:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A3C63233E2
        for <linux-spi@vger.kernel.org>; Wed, 20 Jan 2021 16:21:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
        dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="fV2JX3v5"
Envelope-to: broonie@sirena.co.uk
Delivery-date: Wed, 20 Jan 2021 08:28:55 +0000
Received: from mail.kernel.org ([198.145.29.99])
        by cassiel.sirena.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <SRS0=RSKV=GX=163.com=bianpan2016@kernel.org>)
        id 1l28rE-00042q-WB
        for broonie@sirena.co.uk; Wed, 20 Jan 2021 08:28:55 +0000
Received: by mail.kernel.org (Postfix)
        id 301B72070A; Wed, 20 Jan 2021 08:28:51 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with SMTP id DA0AC20708
        for <broonie@kernel.org>; Wed, 20 Jan 2021 08:28:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA0AC20708
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bianpan2016@163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=Eh350+X8i989rkP9zo
        TRQgT+/kI9qgKijy4ckdHaZTM=; b=fV2JX3v5o+bBszv/8RO8ZweNX34mmadYX2
        zmzdzBOM3Sp6mjiRcvyyHZ7ahpqknn5mTwbO1CSa8VRNoWio1ENwvPiiBzbplu4s
        YwYsmYs/yImnRF52128JiY7LKaHwUspTzYV/YfUa5+tu4PpT1/7NvvxbGi85qKWN
        XNcVzsp4E=
Received: from localhost.localdomain (unknown [119.3.119.20])
        by smtp7 (Coremail) with SMTP id C8CowAB3O60_6QdgKknUJg--.53825S4;
        Wed, 20 Jan 2021 16:26:43 +0800 (CST)
From:   Pan Bian <bianpan2016@163.com>
To:     Mark Brown <broonie@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Tom Rix <trix@redhat.com>, Wu Hao <hao.wu@intel.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pan Bian <bianpan2016@163.com>
Date:   Wed, 20 Jan 2021 00:26:35 -0800
Message-Id: <20210120082635.49304-1-bianpan2016@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: C8CowAB3O60_6QdgKknUJg--.53825S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7JF18GrykKryDCr48Zr1UZFb_yoW3Zrb_ur
        s09r1xGrW0kFsrt3ZIgw4rZrWSqFW5W3W09FZFyrWSgr4DAw15u3yDJryYgw47Aw47AryD
        Crn09Fyj9r15KjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUj6BT7UUUUU==
X-Originating-IP: [119.3.119.20]
X-CM-SenderInfo: held01tdqsiiqw6rljoofrz/1tbiDgMgclXly8A2JgAAs0
X-SA-Exim-Connect-IP: 198.145.29.99
X-SA-Exim-Mail-From: SRS0=RSKV=GX=163.com=bianpan2016@kernel.org
Subject: [PATCH] spi: altera: Fix memory leak on error path
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: No (on cassiel.sirena.org.uk); Unknown failure
X-TUID: 8KJBQL31FCBv
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Release master that have been previously allocated if the number of
chipselect is invalid.

Fixes: 8e04187c1bc7 ("spi: altera: add SPI core parameters support via platform data.")
Signed-off-by: Pan Bian <bianpan2016@163.com>
---
 drivers/spi/spi-altera.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-altera.c b/drivers/spi/spi-altera.c
index cbc4c28c1541..62ea0c9e321b 100644
--- a/drivers/spi/spi-altera.c
+++ b/drivers/spi/spi-altera.c
@@ -254,7 +254,8 @@ static int altera_spi_probe(struct platform_device *pdev)
 			dev_err(&pdev->dev,
 				"Invalid number of chipselect: %hu\n",
 				pdata->num_chipselect);
-			return -EINVAL;
+			err = -EINVAL;
+			goto exit;
 		}
 
 		master->num_chipselect = pdata->num_chipselect;
-- 
2.17.1

