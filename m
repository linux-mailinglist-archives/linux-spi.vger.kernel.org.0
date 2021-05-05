Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 485623746DC
	for <lists+linux-spi@lfdr.de>; Wed,  5 May 2021 19:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233520AbhEERcH (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 5 May 2021 13:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240422AbhEERVI (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 5 May 2021 13:21:08 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C024DC06119E
        for <linux-spi@vger.kernel.org>; Wed,  5 May 2021 09:47:42 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id a18-20020a0cca920000b02901d3c6996bb7so2116076qvk.6
        for <linux-spi@vger.kernel.org>; Wed, 05 May 2021 09:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=+Z0lyW66zxOZsOevWcsCwL84e2yGgP0OYBfGnI/uA/g=;
        b=oLFI6khFTjiKL0g4NmVUXGT4j5ezutBdCS3NzCcJ/m0KONr5mhkjXzymoSsalrdirk
         /E3q1LnikFBuinZ/dgVUnZYF4c6y1wOxGY2kQdkX6Czi0pwg77BBCVSOlnn2ixxrIPMv
         Q+EsJChaXlhCXBedlYs/TNicuyJIq0sIE7YUD7UnAsMPCzZ+qq3p8JcFboPyMaNMATWV
         yCFijZMDG9i5UKFlB7e4KWx6zRb8e8b+My187j7VzyVZPftUckQy343xRd0JwuaY3Qx3
         7er5JcK+MVyY2PS4oh1UE5kIPzDT9ocIRiImz4ybTT916NRBPf9Ggot6IIEJuldogIyP
         lV7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=+Z0lyW66zxOZsOevWcsCwL84e2yGgP0OYBfGnI/uA/g=;
        b=sIATctsLU2HRyCFNHWijTgMvCsMDl7BT0HaPrnelOUf2MhKH9UIE0yLmHUyrk4Lk9M
         ZrCzi2Kf2s2r6SXhLjeQGhc6DjFyYnZK+OU6KbnsmMetf12aavRjORjyl4E7sYJpQveL
         PUwb+zB5dJP00mBtfS4XsScPwVb2+8VfZyyrV6EXv/G8avkHV84uXEGHTOJCCSQCGtPQ
         4eZZGUjnZ0CmeBUuLwvg/jD7piV9bhnxbXjhcWzh1PWf/6x5bY6IMMP2ZC9k2b5ivsvG
         oWfGaoYA4I05ZRFSPmZqnQqUo+WhRCoNhY3MchT+H7xUTpbsOn7XU7EZnfJIsnIRoLX+
         P5Ug==
X-Gm-Message-State: AOAM530SKIbG88+ZjgvDRxDYKMbBYkNNUWVtIuzn7nbT02/S3XZ165uC
        0xmBrQNXJPcGNQGjHE0wc0Tm8X4pEQrG2Qg=
X-Google-Smtp-Source: ABdhPJzc8P2c54WxtApx/JET5+qWZUdHWQzzSYlWMrFTIGUgljzpejnTiZgPN1mojmPFZ1z2xpEoO+T8uoId2to=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:7dba:15b:e3fd:a2e5])
 (user=saravanak job=sendgmr) by 2002:a05:6214:a8b:: with SMTP id
 ev11mr24864780qvb.42.1620233262036; Wed, 05 May 2021 09:47:42 -0700 (PDT)
Date:   Wed,  5 May 2021 09:47:34 -0700
Message-Id: <20210505164734.175546-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.527.g47e6f16901-goog
Subject: [PATCH v2] spi: Don't have controller clean up spi device before
 driver unbind
From:   Saravana Kannan <saravanak@google.com>
To:     Mark Brown <broonie@kernel.org>,
        Saravana Kannan <saravanak@google.com>
Cc:     Lukas Wunner <lukas@wunner.de>, kernel-team@android.com,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

When a spi device is unregistered and triggers a driver unbind, the
driver might need to access the spi device. So, don't have the
controller clean up the spi device before the driver is unbound. Clean
up the spi device after the driver is unbound.

Fixes: c7299fea6769 ("spi: Fix spi device unregister flow")
Reported-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Saravana Kannan <saravanak@google.com>
---

v1->v2:
- Made the clean up more symmetric. 

Lukas,

Can you test this one your end to make sure you don't have issues
anymore?

Thanks,
Saravana

 drivers/spi/spi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 2350d131871b..f23e288e6498 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -714,8 +714,6 @@ void spi_unregister_device(struct spi_device *spi)
 	if (!spi)
 		return;
 
-	spi_cleanup(spi);
-
 	if (spi->dev.of_node) {
 		of_node_clear_flag(spi->dev.of_node, OF_POPULATED);
 		of_node_put(spi->dev.of_node);
@@ -723,7 +721,9 @@ void spi_unregister_device(struct spi_device *spi)
 	if (ACPI_COMPANION(&spi->dev))
 		acpi_device_clear_enumerated(ACPI_COMPANION(&spi->dev));
 	device_remove_software_node(&spi->dev);
-	device_unregister(&spi->dev);
+	device_del(&spi->dev);
+	spi_cleanup(spi);
+	put_device(&spi->dev);
 }
 EXPORT_SYMBOL_GPL(spi_unregister_device);
 
-- 
2.31.1.527.g47e6f16901-goog

