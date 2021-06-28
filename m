Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90E963B5662
	for <lists+linux-spi@lfdr.de>; Mon, 28 Jun 2021 02:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231849AbhF1Amt (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 27 Jun 2021 20:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231737AbhF1Ams (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 27 Jun 2021 20:42:48 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 784F1C061574;
        Sun, 27 Jun 2021 17:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=8hAFSlHFWdnPhlaMXpF6GcfhzBmf4yRkDGhXefLS0Ro=; b=dYLeBaC62HAnbE9R08Nq9sSl9o
        eVqDvzPqf+3rMtsYMm+1RHdsaovcd9bPvvujD9dFoLXsS7cUbEwpWpc9MXDZClJhLq3nEGmsG5MUZ
        9zqXLhPxlsmhnqe3X3RoA+K64tSHwU0OkWdUZImeOSqSBl1dmNDkiJk+Ba3IfjEjsffez4RiLFQe3
        96ugUUYxaqOAhT0Ob6z7VZ4qgVkXzSCEfLzbTRdlRjrdZ3v87gMM8O5D8zjeI9Ypv7LivAVmYN9k+
        f9RHukdArjlNoBTW6zUvgUnfDNF1qE6ryyV9rpJEjn7buoi5jCRZ/W0LaFdbqw18+sdrOPyazdbC7
        hwaPOtUQ==;
Received: from [2601:1c0:6280:3f0::aefb] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lxfK3-006MXp-TQ; Mon, 28 Jun 2021 00:40:24 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        "William A . Kennington III" <wak@google.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Subject: [PATCH] spi: <linux/spi/spi.h>: add missing struct kernel-doc entry
Date:   Sun, 27 Jun 2021 17:40:23 -0700
Message-Id: <20210628004023.7371-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Fix kernel-doc warning in spi.h:

../include/linux/spi/spi.h:673: warning: Function parameter or member 'devm_allocated' not described in 'spi_controller'

Fixes: 794aaf01444d ("spi: Fix use-after-free with devm_spi_alloc_*")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: William A. Kennington III <wak@google.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org
---
 include/linux/spi/spi.h |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20210625.orig/include/linux/spi/spi.h
+++ linux-next-20210625/include/linux/spi/spi.h
@@ -339,6 +339,7 @@ extern struct spi_device *spi_new_ancill
  * @max_speed_hz: Highest supported transfer speed
  * @flags: other constraints relevant to this driver
  * @slave: indicates that this is an SPI slave controller
+ * @devm_allocated: flag indicating this is a non-devres managed controller
  * @max_transfer_size: function that returns the max transfer size for
  *	a &spi_device; may be %NULL, so the default %SIZE_MAX will be used.
  * @max_message_size: function that returns the max message size for
