Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4E647173
	for <lists+linux-spi@lfdr.de>; Sat, 15 Jun 2019 19:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbfFORlj (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 15 Jun 2019 13:41:39 -0400
Received: from mga06.intel.com ([134.134.136.31]:54276 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725270AbfFORlj (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Sat, 15 Jun 2019 13:41:39 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Jun 2019 10:41:38 -0700
X-ExtLoop1: 1
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 15 Jun 2019 10:41:37 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id BEE82F1; Sat, 15 Jun 2019 20:41:36 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] spi: No need to assign dummy value in spi_unregister_controller()
Date:   Sat, 15 Jun 2019 20:41:35 +0300
Message-Id: <20190615174135.86181-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The device_for_each_child() doesn't require the returned value to be checked.
Thus, drop the dummy variable completely and have no warning anymore:

drivers/spi/spi.c: In function ‘spi_unregister_controller’:
drivers/spi/spi.c:2480:6: warning: variable ‘dummy’ set but not used [-Wunused-but-set-variable]
  int dummy;
      ^~~~~

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 82063d2e4f36..caaae376d54e 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2477,7 +2477,6 @@ void spi_unregister_controller(struct spi_controller *ctlr)
 {
 	struct spi_controller *found;
 	int id = ctlr->bus_num;
-	int dummy;
 
 	/* First make sure that this controller was ever added */
 	mutex_lock(&board_lock);
@@ -2491,7 +2490,7 @@ void spi_unregister_controller(struct spi_controller *ctlr)
 	list_del(&ctlr->list);
 	mutex_unlock(&board_lock);
 
-	dummy = device_for_each_child(&ctlr->dev, NULL, __unregister);
+	device_for_each_child(&ctlr->dev, NULL, __unregister);
 	device_unregister(&ctlr->dev);
 	/* free bus id */
 	mutex_lock(&board_lock);
-- 
2.20.1

