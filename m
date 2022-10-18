Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D3546035B5
	for <lists+linux-spi@lfdr.de>; Wed, 19 Oct 2022 00:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbiJRWQS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 18 Oct 2022 18:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiJRWQP (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 18 Oct 2022 18:16:15 -0400
X-Greylist: delayed 1087 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 18 Oct 2022 15:16:11 PDT
Received: from smtpcmd02101.aruba.it (smtpcmd02101.aruba.it [62.149.158.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 46BED8E983
        for <linux-spi@vger.kernel.org>; Tue, 18 Oct 2022 15:16:11 -0700 (PDT)
Received: from localhost.localdomain ([146.241.87.206])
        by Aruba Outgoing Smtp  with ESMTPSA
        id kub2omqjesjaWkub4oJ4kc; Tue, 18 Oct 2022 23:58:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1666130282; bh=ZwhxLxF6g1lFuT2l3LTNGqDL0I52Ig9aGdGV08f+w3s=;
        h=From:To:Subject:Date:MIME-Version;
        b=oCQr2GrCqLrPSn7BIL2PUk6aMU0FvWCF7q6OCMNgpGsmEgtYnBfcai5q2R0ySoba8
         Qpu5crxM3dY02lEKLLmx2lH/4/pozFGX37nXXxNe5Wo7pB0MzghKc00NTHPLBYI19S
         wo5ybgypogTbli7ikx4WpTygwulLb2mjtKuSdAjp1xZOybFiH5zmzw2hJJN/SuZcC6
         ffkD0DMiVph2K0vjil8j1a5NOwTnAaQyvbr+0KJA7yZtJWmfHtJaqwaZ/iSRm7lLD+
         hRTtMwhbBoPiVkBezezRWYoJZugA+VGj1arRzJ1opXWFgTAzbp8NAyijsVM5EqzlU2
         8TfC8VH8aef/g==
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
To:     Arnd Bergmann <arnd@arndb.de>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-raid@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Mark Brown <broonie@kernel.org>,
        Song Liu <song@kernel.org>,
        Giulio Benetti <giulio.benetti@benettiengineering.com>
Subject: [PATCH 3/3] raid: substitute empty_zero_page with helper ZERO_PAGE(0)
Date:   Tue, 18 Oct 2022 23:57:55 +0200
Message-Id: <20221018215755.33566-3-giulio.benetti@benettiengineering.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221018215755.33566-1-giulio.benetti@benettiengineering.com>
References: <20221018215755.33566-1-giulio.benetti@benettiengineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfLP2urURZfQFB1yAY55ub1PVpneyUyJ0CHOO3oG9A8j9epcn57H4WVK+0ow2sxVOxI/GMoQzCt3q4X9ONmIe6QPNrjBO+Pu3SC60MP1YHQ0YnsUZpEhs
 kppXUQ/W23tfU8VcLha7d6EfRUCpvKaOHPmyQj4oDi4PHXJfLl/k5083pJzmbwdKc4sab0oP9kM88PqZjhZbsLlb+7af01eviIlOVmxeQgtfNIrA3r9PtuCM
 38tjmV0Rvf8iRqJg3GclatvHMBMastuttgrqZfWIM96yUj/bbZx904Tok7HVi5rbJdmxvhhuXBvEk7pWnsw5AWxBhQRPjCdEQ6cXU1ceWAVoh5EThxOy67mB
 pnnEoIHN8bPt1SahRnxY7XY5/eUQrxsFole9s6cvRinoSVA7CFTdnkRoCdSgP+BLnjunBjUbAYYXy3q/ZeO0JKDgENo5W0HDcs8Dm2KkEHiYJSE5ebUxorax
 jmzqjWu4h8c6iyQlNseXLWIrqT+vHcYeO934LA8PJ2Cc5l7QWNvLtXVfQR+EaO/VH7/VS9dA1FMmQ2yT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Not all zero page implementations use empty_zero_page global pointer so
let's substitute empty_zero_page occurence with helper ZERO_PAGE(0).

Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
---
 include/linux/raid/pq.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/raid/pq.h b/include/linux/raid/pq.h
index d6e5a1feb947..2dd46f4c7318 100644
--- a/include/linux/raid/pq.h
+++ b/include/linux/raid/pq.h
@@ -17,7 +17,7 @@
 /* We need a pre-zeroed page... if we don't want to use the kernel-provided
    one define it here */
 #if RAID6_USE_EMPTY_ZERO_PAGE
-# define raid6_empty_zero_page empty_zero_page
+# define raid6_empty_zero_page ZERO_PAGE(0)
 #else
 extern const char raid6_empty_zero_page[PAGE_SIZE];
 #endif
-- 
2.34.1

