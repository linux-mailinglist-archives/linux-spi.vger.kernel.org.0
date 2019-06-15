Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1D247178
	for <lists+linux-spi@lfdr.de>; Sat, 15 Jun 2019 19:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725535AbfFORrm (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 15 Jun 2019 13:47:42 -0400
Received: from mga06.intel.com ([134.134.136.31]:45051 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725270AbfFORrl (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Sat, 15 Jun 2019 13:47:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Jun 2019 10:47:40 -0700
X-ExtLoop1: 1
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 15 Jun 2019 10:47:39 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 6AE7FF1; Sat, 15 Jun 2019 20:47:38 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] spi: Add a prototype for exported spi_set_cs_timing()
Date:   Sat, 15 Jun 2019 20:47:37 +0300
Message-Id: <20190615174737.4868-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Compiler is not happy about spi_set_cs_timing() prototype.

drivers/spi/spi.c:3016:6: warning: no previous prototype for ‘spi_set_cs_timing’ [-Wmissing-prototypes]
 void spi_set_cs_timing(struct spi_device *spi, u8 setup, u8 hold,
      ^~~~~~~~~~~~~~~~~

Let's add it to the header.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/spi/spi.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 053abd22ad31..ffe3a13d898b 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -967,6 +967,8 @@ static inline void spi_message_free(struct spi_message *m)
 	kfree(m);
 }
 
+extern void spi_set_cs_timing(struct spi_device *spi, u8 setup, u8 hold, u8 inactive_dly);
+
 extern int spi_setup(struct spi_device *spi);
 extern int spi_async(struct spi_device *spi, struct spi_message *message);
 extern int spi_async_locked(struct spi_device *spi,
-- 
2.20.1

