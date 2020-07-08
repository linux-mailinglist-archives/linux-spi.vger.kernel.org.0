Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8201A218960
	for <lists+linux-spi@lfdr.de>; Wed,  8 Jul 2020 15:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729679AbgGHNnJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 8 Jul 2020 09:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729450AbgGHNnJ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 8 Jul 2020 09:43:09 -0400
X-Greylist: delayed 582 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 08 Jul 2020 06:43:09 PDT
Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f236:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53F47C061A0B
        for <linux-spi@vger.kernel.org>; Wed,  8 Jul 2020 06:43:09 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by mailout3.hostsharing.net (Postfix) with ESMTPS id 34935101E69A5;
        Wed,  8 Jul 2020 15:33:23 +0200 (CEST)
Received: from localhost (unknown [87.130.102.138])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id C340F6106EC8;
        Wed,  8 Jul 2020 15:33:22 +0200 (CEST)
X-Mailbox-Line: From de88a23a6fe0ef70f7cfd13c8aea9ab51b4edab6 Mon Sep 17 00:00:00 2001
Message-Id: <de88a23a6fe0ef70f7cfd13c8aea9ab51b4edab6.1594214103.git.lukas@wunner.de>
In-Reply-To: <cover.1594214103.git.lukas@wunner.de>
References: <cover.1594214103.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Wed, 8 Jul 2020 15:27:01 +0200
Subject: [PATCH 1/3] driver core: Avoid binding drivers to dead devices
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Commit 3451a495ef24 ("driver core: Establish order of operations for
device_add and device_del via bitflag") sought to prevent asynchronous
driver binding to a device which is being removed.  It added a
per-device "dead" flag which is checked in the following code paths:

* asynchronous binding in __driver_attach_async_helper()
*  synchronous binding in device_driver_attach()
* asynchronous binding in __device_attach_async_helper()

It did *not* check the flag upon:

*  synchronous binding in __device_attach()

However __device_attach() may also be called asynchronously from:

deferred_probe_work_func()
  bus_probe_device()
    device_initial_probe()
      __device_attach()

So if the commit's intention was to check the "dead" flag in all
asynchronous code paths, then a check is also necessary in
__device_attach().  Add the missing check.

Fixes: 3451a495ef24 ("driver core: Establish order of operations for device_add and device_del via bitflag")
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: stable@vger.kernel.org # v5.1+
Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
---
 drivers/base/dd.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 9a1d940342ac4..31c668651e824 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -848,7 +848,9 @@ static int __device_attach(struct device *dev, bool allow_async)
 	int ret = 0;
 
 	device_lock(dev);
-	if (dev->driver) {
+	if (dev->p->dead) {
+		goto out_unlock;
+	} else if (dev->driver) {
 		if (device_is_bound(dev)) {
 			ret = 1;
 			goto out_unlock;
-- 
2.27.0

