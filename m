Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1C1F3B69FA
	for <lists+linux-spi@lfdr.de>; Mon, 28 Jun 2021 23:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236810AbhF1VHw (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 28 Jun 2021 17:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236768AbhF1VHu (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 28 Jun 2021 17:07:50 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84116C061574;
        Mon, 28 Jun 2021 14:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=uVkWJJEgVMmv/VM+/tI0X/gn1Id+AayZLOfLG6sl0S4=; b=CDP8AVKZWHj5qu1qJuoZQy6xvf
        E/ETdygnAZKz9/ak8vzKNKy3dWD60Vy9xb1d61vJcF61s/m0+L0wuehv6QKQq99zxvuR5Kev4LJYv
        OaFjTdOdgmugsZKKANSwqs3ocRK9nImAYuy6W9EPLIcCviLNqj3Kyhmq1R2/WMkadG+vR7BsOmmQm
        PeJPc/RGtuf0kpQ8mr8x+4ShABS0rRIv1KdeNUuk/20oDOQhkgJ4vU2/lilA+3gaRKHb+RsokJhJk
        d0MlEuskP7VzHcQzqIKjwcil+qzjTUvN2p33TxivyTVlEWnvTvZiMqHTPgPlvL/mbP0JztnlMmgeK
        S3POwxhw==;
Received: from [2601:1c0:6280:3f0::aefb] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lxyRV-009Boc-Ps; Mon, 28 Jun 2021 21:05:21 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        "William A . Kennington III" <wak@google.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Lukas Wunner <lukas@wunner.de>
Subject: [PATCH v2] spi: <linux/spi/spi.h>: add missing struct kernel-doc entry
Date:   Mon, 28 Jun 2021 14:05:20 -0700
Message-Id: <20210628210520.5712-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Fix kernel-doc warning in spi.h by adding the missing kernel-doc entry
and also correct the original comment so that they both indicate the
correct polarity of the flag.

../include/linux/spi/spi.h:673: warning: Function parameter or member 'devm_allocated' not described in 'spi_controller'

Fixes: 794aaf01444d ("spi: Fix use-after-free with devm_spi_alloc_*")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: William A. Kennington III <wak@google.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org
Cc: Lukas Wunner <lukas@wunner.de>
---
v2: correct both comments for @devm_allocated to indicate the correct polarity
    (thanks, Lukas)

 include/linux/spi/spi.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- linux-next-20210628.orig/include/linux/spi/spi.h
+++ linux-next-20210628/include/linux/spi/spi.h
@@ -339,6 +339,7 @@ extern struct spi_device *spi_new_ancill
  * @max_speed_hz: Highest supported transfer speed
  * @flags: other constraints relevant to this driver
  * @slave: indicates that this is an SPI slave controller
+ * @devm_allocated: whether the allocation of this struct is devres-managed
  * @max_transfer_size: function that returns the max transfer size for
  *	a &spi_device; may be %NULL, so the default %SIZE_MAX will be used.
  * @max_message_size: function that returns the max message size for
@@ -511,7 +512,7 @@ struct spi_controller {
 
 #define SPI_MASTER_GPIO_SS		BIT(5)	/* GPIO CS must select slave */
 
-	/* flag indicating this is a non-devres managed controller */
+	/* flag indicating if the allocation of this struct is devres-managed */
 	bool			devm_allocated;
 
 	/* flag indicating this is an SPI slave controller */
