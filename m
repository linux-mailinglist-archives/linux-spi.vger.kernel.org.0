Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF9F4A6DD
	for <lists+linux-spi@lfdr.de>; Tue, 18 Jun 2019 18:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729594AbfFRQ2W (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 18 Jun 2019 12:28:22 -0400
Received: from mleia.com ([178.79.152.223]:36298 "EHLO mail.mleia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729295AbfFRQ2W (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 18 Jun 2019 12:28:22 -0400
Received: from mail.mleia.com (localhost [127.0.0.1])
        by mail.mleia.com (Postfix) with ESMTP id 89BAD3826A5;
        Tue, 18 Jun 2019 17:28:20 +0100 (BST)
From:   Vladimir Zapolskiy <vz@mleia.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org
Subject: [PATCH] spi: don't open code list_for_each_entry_safe_reverse()
Date:   Tue, 18 Jun 2019 19:28:18 +0300
Message-Id: <20190618162818.24415-1-vz@mleia.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20190618_172820_595119_0022EEF8 
X-CRM114-Status: UNSURE (   8.72  )
X-CRM114-Notice: Please train this message. 
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The loop declaration in function spi_res_release() can be simplified
by reusing the common list_for_each_entry_safe_reverse() helper
macro.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 drivers/spi/spi.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 74113ee9ce44..ebef6d4a6792 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2740,12 +2740,9 @@ EXPORT_SYMBOL_GPL(spi_res_add);
  */
 void spi_res_release(struct spi_controller *ctlr, struct spi_message *message)
 {
-	struct spi_res *res;
-
-	while (!list_empty(&message->resources)) {
-		res = list_last_entry(&message->resources,
-				      struct spi_res, entry);
+	struct spi_res *res, *tmp;
 
+	list_for_each_entry_safe_reverse(res, tmp, &message->resources, entry) {
 		if (res->release)
 			res->release(ctlr, message, res->data);
 
-- 
2.20.1

