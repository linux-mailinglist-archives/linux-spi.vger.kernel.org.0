Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 447C71DEC6B
	for <lists+linux-spi@lfdr.de>; Fri, 22 May 2020 17:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730058AbgEVPuN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 22 May 2020 11:50:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:59634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730181AbgEVPuJ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 22 May 2020 11:50:09 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1C052070A;
        Fri, 22 May 2020 15:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590162609;
        bh=M1XTwxSep3QkWmd2GM+8DFe52LsxnIfeCct8jLvIP5s=;
        h=From:To:Cc:Subject:Date:From;
        b=Jiynd2UaZHqWwxtiw8J7MAnggkydnEuJoFR4II+36sxQ0aJm06urPDyX8L5iNzqfc
         Ae2+y3pxxF5331A8xGDNH18bSvW4fg5eh7xlWDvnYxWY6P5D2BFq9nle1uuVtCK0V8
         kOZNEZMT6/p3yCiYxbIF76Pw3i7d+y7SIGr5N0KM=
From:   Mark Brown <broonie@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH] spi: Make spi_delay_exec() warn if called from atomic context
Date:   Fri, 22 May 2020 16:50:05 +0100
Message-Id: <20200522155005.46099-1-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

If the delay used is long enough the spi_delay_exec() will use a sleeping
function to implement it. Add a might_sleep() here to help avoid callers
using this from an atomic context and running into problems at runtime on
other systems.

Suggested-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index e02f434affca..c69d23379e08 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1160,6 +1160,8 @@ int spi_delay_exec(struct spi_delay *_delay, struct spi_transfer *xfer)
 {
 	int delay;
 
+	might_sleep();
+
 	if (!_delay)
 		return -EINVAL;
 
-- 
2.20.1

