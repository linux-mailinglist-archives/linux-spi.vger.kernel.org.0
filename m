Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B43F8356883
	for <lists+linux-spi@lfdr.de>; Wed,  7 Apr 2021 11:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346529AbhDGJ4C (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 7 Apr 2021 05:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234496AbhDGJ4B (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 7 Apr 2021 05:56:01 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D65C061756
        for <linux-spi@vger.kernel.org>; Wed,  7 Apr 2021 02:55:52 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id y13so23198871ybk.20
        for <linux-spi@vger.kernel.org>; Wed, 07 Apr 2021 02:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=VWa5xUA+9GCbJ9DlX5ZS/vYDVMc9Ch1YyfdrjHd7dd4=;
        b=l4ISsIo1bCuQjUNIgt5hBLv04y2KMWkLr8ycFUvTmUS1L60UoCeg6r+xF2uXACr9G7
         gtff5aMua90RcvRhqs0K6ZxyqBgkJLp/O8NIXvdzKp8NSYCQIAVKALwnZtmVzrnlTdqY
         pLkcrC9RQCmCdoXht41Ltsf1XOEA8n2es//viRP+JwcHmYZdpOdQZxnRB+lJbqEv16sJ
         9sRqNu9M7dm/gaoNQLvhZAir9oSgytTkAkS8fgzEiQaaTmb5p9nZ+KHrc60CgtvlCvxJ
         70LmqbFCnO4S53pFGa65A3NYsvKcDw1M9Q+5E2TJN+69oHiHX1MOidauxabSv9wWmBB8
         eyPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=VWa5xUA+9GCbJ9DlX5ZS/vYDVMc9Ch1YyfdrjHd7dd4=;
        b=iRNPwsTQwVSBDylDED3ZJl1rc2cvaT/JRK4ixlfCIsvMkpsxnZv7zOURy+p49Ve/hi
         0Ax2AttbBAu0s/ySbsV5zGUMqCQ2/XFxOPUpewOs19W2MLeOdChqgQzwVeTmqZl9P5Vw
         L9tXA6vJeOPwJwz8974wlyBzKC7fuTh+XjEP7Zt7zE63GlmFrRtZYTdQyNt8Qmp5c+NI
         KD6AXlpcazKjxRQaKXvK9YfbBrjKeqsOghdyIX0AtNWn3bWjRhDnkVlj/Z3tjzzDmJsv
         or5YhqSYjZxEczWGLg3HzwTFpkLB5VVStVC40RFwWsFXOtn7Owjg2ZE4TDlAs9WRbhq+
         sMjQ==
X-Gm-Message-State: AOAM532A+QkqFA+iAtIYvI6OOuLjmFET84EY486H3YVirF/eWX/W0U8T
        XG40GAPpJp/N4BGUmuhFnS5tvj8=
X-Google-Smtp-Source: ABdhPJyJvh62KGCku6InpD3zbdy6kT1gK50K3AlsQwz2jwnin3/vG1dPL3EQ/d36idH/3WQsHniYwSU=
X-Received: from wak-linux.svl.corp.google.com ([2620:15c:2c5:3:d5a1:fccd:85fb:f380])
 (user=wak job=sendgmr) by 2002:a25:d0c7:: with SMTP id h190mr3349871ybg.428.1617789351418;
 Wed, 07 Apr 2021 02:55:51 -0700 (PDT)
Date:   Wed,  7 Apr 2021 02:55:27 -0700
Message-Id: <20210407095527.2771582-1-wak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.0.208.g409f899ff0-goog
Subject: [PATCH] spi: Fix use-after-free with devm_spi_alloc_*
From:   "William A. Kennington III" <wak@google.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Joel Stanley <joel@jms.id.au>,
        "William A. Kennington III" <wak@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

We can't rely on the contents of the devres list during
spi_unregister_controller(), as the list is already torn down at the
time we perform devres_find() for devm_spi_release_controller. This
causes devices registered with devm_spi_alloc_{master,slave}() to be
mistakenly identified as legacy, non-devm managed devices and have their
reference counters decremented below 0.

------------[ cut here ]------------
WARNING: CPU: 1 PID: 660 at lib/refcount.c:28 refcount_warn_saturate+0x108/0x174
[<b0396f04>] (refcount_warn_saturate) from [<b03c56a4>] (kobject_put+0x90/0x98)
[<b03c5614>] (kobject_put) from [<b0447b4c>] (put_device+0x20/0x24)
 r4:b6700140
[<b0447b2c>] (put_device) from [<b07515e8>] (devm_spi_release_controller+0x3c/0x40)
[<b07515ac>] (devm_spi_release_controller) from [<b045343c>] (release_nodes+0x84/0xc4)
 r5:b6700180 r4:b6700100
[<b04533b8>] (release_nodes) from [<b0454160>] (devres_release_all+0x5c/0x60)
 r8:b1638c54 r7:b117ad94 r6:b1638c10 r5:b117ad94 r4:b163dc10
[<b0454104>] (devres_release_all) from [<b044e41c>] (__device_release_driver+0x144/0x1ec)
 r5:b117ad94 r4:b163dc10
[<b044e2d8>] (__device_release_driver) from [<b044f70c>] (device_driver_detach+0x84/0xa0)
 r9:00000000 r8:00000000 r7:b117ad94 r6:b163dc54 r5:b1638c10 r4:b163dc10
[<b044f688>] (device_driver_detach) from [<b044d274>] (unbind_store+0xe4/0xf8)

Instead, determine the devm allocation state as a flag on the
controller which is guaranteed to be stable during cleanup.

Fixes: 5e844cc37a5c ("spi: Introduce device-managed SPI controller allocation")
Signed-off-by: William A. Kennington III <wak@google.com>
---
 drivers/spi/spi.c       | 9 ++-------
 include/linux/spi/spi.h | 3 +++
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index b08efe88ccd6..904a353798b6 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2496,6 +2496,7 @@ struct spi_controller *__devm_spi_alloc_controller(struct device *dev,
 
 	ctlr = __spi_alloc_controller(dev, size, slave);
 	if (ctlr) {
+		ctlr->devm_allocated = true;
 		*ptr = ctlr;
 		devres_add(dev, ptr);
 	} else {
@@ -2842,11 +2843,6 @@ int devm_spi_register_controller(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(devm_spi_register_controller);
 
-static int devm_spi_match_controller(struct device *dev, void *res, void *ctlr)
-{
-	return *(struct spi_controller **)res == ctlr;
-}
-
 static int __unregister(struct device *dev, void *null)
 {
 	spi_unregister_device(to_spi_device(dev));
@@ -2893,8 +2889,7 @@ void spi_unregister_controller(struct spi_controller *ctlr)
 	/* Release the last reference on the controller if its driver
 	 * has not yet been converted to devm_spi_alloc_master/slave().
 	 */
-	if (!devres_find(ctlr->dev.parent, devm_spi_release_controller,
-			 devm_spi_match_controller, ctlr))
+	if (!ctlr->devm_allocated)
 		put_device(&ctlr->dev);
 
 	/* free bus id */
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 592897fa4f03..643139b1eafe 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -510,6 +510,9 @@ struct spi_controller {
 
 #define SPI_MASTER_GPIO_SS		BIT(5)	/* GPIO CS must select slave */
 
+	/* flag indicating this is a non-devres managed controller */
+	bool			devm_allocated;
+
 	/* flag indicating this is an SPI slave controller */
 	bool			slave;
 
-- 
2.31.0.208.g409f899ff0-goog

