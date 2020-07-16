Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30BD0221983
	for <lists+linux-spi@lfdr.de>; Thu, 16 Jul 2020 03:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbgGPBay (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 15 Jul 2020 21:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726785AbgGPBay (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 15 Jul 2020 21:30:54 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C30D6C061755;
        Wed, 15 Jul 2020 18:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:To:Subject:From:Sender:Reply-To:Cc:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=Zz5Aq+96SN77uF1lNeO43nOEFQNGv4DNbkTuZ3vBpMc=; b=TB3l81M/m2PsofjiC3KOLWZuzm
        DWa91LmsABx6wnuAj8WU4nO2sl68Tm/9FTtw4sjtsTWbAAkzyZScC8G0HyRqyXYVnR+FOBMP8C9FN
        00wSQLRwKsgKxRBYjedmNXHzRqmtXMRFkijt4G3mWcXvN68DOJt9NC4EAhXFhR7eqNMVuVKal5wnl
        Se72Mt9fCNqBBszlTwK8ReXNlfwQpXvvHSBCPqSX2+OPXI3LQCvefn9Ji6QZ33ZB/PrBzrLQ/xPRI
        1sq3A0wRhbGKpsjmh7dq15vlDXZWUOsOIjBLQVj6HIX4VYQFgH3n4NRnQ8AtSKAezcME5aZdeDilo
        PLROg+fg==;
Received: from [2601:1c0:6280:3f0::19c2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jvsjb-0000ZB-KU; Thu, 16 Jul 2020 01:30:52 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] spi: fix duplicated word in <linux/spi/spi.h>
To:     LKML <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
Message-ID: <40354d64-be71-3952-a980-63a76a278145@infradead.org>
Date:   Wed, 15 Jul 2020 18:30:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Change doubled word "as" to "as a".

Change "Return: Return:" in kernel-doc notation to have only one
"Return:".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org
---
 include/linux/spi/spi.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20200714.orig/include/linux/spi/spi.h
+++ linux-next-20200714/include/linux/spi/spi.h
@@ -971,7 +971,7 @@ struct spi_transfer {
  * each represented by a struct spi_transfer.  The sequence is "atomic"
  * in the sense that no other spi_message may use that SPI bus until that
  * sequence completes.  On some systems, many such sequences can execute as
- * as single programmed DMA transfer.  On all systems, these messages are
+ * a single programmed DMA transfer.  On all systems, these messages are
  * queued, and might complete after transactions to other devices.  Messages
  * sent to a given spi_device are always executed in FIFO order.
  *
@@ -1234,7 +1234,7 @@ extern int spi_bus_unlock(struct spi_con
  *
  * For more specific semantics see spi_sync().
  *
- * Return: Return: zero on success, else a negative error code.
+ * Return: zero on success, else a negative error code.
  */
 static inline int
 spi_sync_transfer(struct spi_device *spi, struct spi_transfer *xfers,


