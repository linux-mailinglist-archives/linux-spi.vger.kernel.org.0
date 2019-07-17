Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3F966B9BE
	for <lists+linux-spi@lfdr.de>; Wed, 17 Jul 2019 12:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726081AbfGQKGC (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 17 Jul 2019 06:06:02 -0400
Received: from cmccmta3.chinamobile.com ([221.176.66.81]:2358 "EHLO
        cmccmta3.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbfGQKGC (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 17 Jul 2019 06:06:02 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.15]) by rmmx-syy-dmz-app10-12010 (RichMail) with SMTP id 2eea5d2ef2f86a5-87972; Wed, 17 Jul 2019 18:05:45 +0800 (CST)
X-RM-TRANSID: 2eea5d2ef2f86a5-87972
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[223.105.0.243])
        by rmsmtp-syy-appsvr08-12008 (RichMail) with SMTP id 2ee85d2ef2f8faa-a5075;
        Wed, 17 Jul 2019 18:05:45 +0800 (CST)
X-RM-TRANSID: 2ee85d2ef2f8faa-a5075
From:   Ding Xiang <dingxiang@cmss.chinamobile.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] spi: remove redundant put_device
Date:   Wed, 17 Jul 2019 18:05:44 +0800
Message-Id: <1563357944-24496-1-git-send-email-dingxiang@cmss.chinamobile.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

device_unregister will call put_device,
so remove the redundant put_device

Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>
---
 drivers/spi/spi.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 75ac046..d753689 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2133,11 +2133,9 @@ static ssize_t spi_slave_store(struct device *dev,
 		return -EINVAL;
 
 	child = device_find_child(&ctlr->dev, NULL, match_true);
-	if (child) {
+	if (child)
 		/* Remove registered slave */
 		device_unregister(child);
-		put_device(child);
-	}
 
 	if (strcmp(name, "(null)")) {
 		/* Register new slave */
-- 
1.9.1



