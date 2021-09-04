Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72B7B4008FD
	for <lists+linux-spi@lfdr.de>; Sat,  4 Sep 2021 03:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350815AbhIDBct (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 3 Sep 2021 21:32:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:38792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350825AbhIDBcr (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 3 Sep 2021 21:32:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E2921604AC;
        Sat,  4 Sep 2021 01:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630719107;
        bh=mmkMkRBAnkAJJYDK5SYKwyWWceGVYrhUN1xo0AdUh04=;
        h=From:To:Cc:Subject:Date:From;
        b=I2IeIRIUlqN8IVK6JIziG72TTXJLYw3+6jIHRfSmed2jpItZQRm3J+7AugqiX0e/V
         REL2fe8/DsaOaCE/qEjRgyaShJc/wmFJegUaUxXbuFT4lFhUPpn7VuGkeIR8/Duh9q
         DwZh98TIJCJTdwEgdUAm5nU15siLG543lV4REbQW875Ck3EgslwdNWT3etf1o1ZR63
         Bm3w6rSUMtLPhR4AdfFJRLZJNuUvROKuPAkSQ6hQcmvXJ124qEmcVZHypUCzJedL6b
         JXG9qIe304JxtYxM9ZfLGsDHuf2slS73RM/4Co7yXjnybiUemyrla1XjuR604yem5W
         9xqAIpSidAhyg==
From:   Jakub Kicinski <kuba@kernel.org>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, vladimir.oltean@nxp.com,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH] ptp: don't include ptp_clock_kernel.h in spi.h
Date:   Fri,  3 Sep 2021 18:31:40 -0700
Message-Id: <20210904013140.2377609-1-kuba@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Commit b42faeee718c ("spi: Add a PTP system timestamp
to the transfer structure") added an include of ptp_clock_kernel.h
to spi.h for struct ptp_system_timestamp but a forward declaration
is enough. Let's use that to limit the number of objects we have
to rebuild every time we touch networking headers.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/spi/spi.c       | 1 +
 include/linux/spi/spi.h | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 65d14af9c015..fc778492d254 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -33,6 +33,7 @@
 #include <linux/highmem.h>
 #include <linux/idr.h>
 #include <linux/platform_data/x86/apple.h>
+#include <linux/ptp_clock_kernel.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/spi.h>
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 8371bca13729..31f05dd27a6d 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -14,12 +14,12 @@
 #include <linux/completion.h>
 #include <linux/scatterlist.h>
 #include <linux/gpio/consumer.h>
-#include <linux/ptp_clock_kernel.h>
 
 #include <uapi/linux/spi/spi.h>
 
 struct dma_chan;
 struct software_node;
+struct ptp_system_timestamp;
 struct spi_controller;
 struct spi_transfer;
 struct spi_controller_mem_ops;
-- 
2.31.1

