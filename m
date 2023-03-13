Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D87166B713C
	for <lists+linux-spi@lfdr.de>; Mon, 13 Mar 2023 09:36:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbjCMIg1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 13 Mar 2023 04:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbjCMIg1 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 13 Mar 2023 04:36:27 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 578D434F73
        for <linux-spi@vger.kernel.org>; Mon, 13 Mar 2023 01:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1678696585; x=1710232585;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=oWYIpVHHEfm+SpwZqUwvAnHp4G93jr7Yp499pIwnfmw=;
  b=eQ53znX9emzJ8Y/zji4RGWZ/8e3aGXBQd98GlnB0PWcXiWxWrKcop5jk
   H4kSMVDKYsQGA73P3Rlc95cLu1QZoB6oxI8tofxZE1fXmgpAD6X49Wtf5
   IlsTTOkGClbke4oWhSIcgN+TIW4aR6m7vI7TKaw95DgWG4pK6ymjYapNu
   YZObT1pa+D42arBbOO3ba7fow6FrGGjT1QZdkpi7rYdOa6xAkteF+CHrN
   o/c25ecSrS+h1EpM3tZzHL66cRsLFiR9mernCoEh04FDeUrGyGxMS4fmj
   +WiF1YoJ7BJG2uXzvwTr1b3HMTVjmMSSyFMbPUL3hJXv8+5jOKD/BVcRn
   w==;
X-IronPort-AV: E=Sophos;i="5.98,256,1673910000"; 
   d="scan'208";a="29637222"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 13 Mar 2023 09:36:23 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Mon, 13 Mar 2023 09:36:23 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Mon, 13 Mar 2023 09:36:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1678696583; x=1710232583;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=oWYIpVHHEfm+SpwZqUwvAnHp4G93jr7Yp499pIwnfmw=;
  b=YYXlG01KKXk3DtCNfP0EwxmZ4ergy9ZHZQwsfB52cg+UxxPCWKwiLWK6
   JQbugeIupTtvCWl91sqnWO7xRoJ1+WD7CFDo9fnKj3Oc+LPWpZMy2um4g
   KSQW9sUDZVIXj3SQV1dzj2IyyL3zf1fJ+iqdOSsFMu+iZP4uHiVgEy1A4
   pzg2PnFexR3qVlq3ee8uBNp6dJCmGOi73YEYf4HE5VUZb4IKP/66KbtAY
   lgpDGb/iFHX1mX7NHKIWyfQarO7lDdurkl2lh6zOiabFhju0XIdWZmn+u
   //JDRKdtJPjwkCm1t5oZEKB06qorULJ1kHGCZiEA6BynxAZtJZxebJldq
   w==;
X-IronPort-AV: E=Sophos;i="5.98,256,1673910000"; 
   d="scan'208";a="29637221"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 13 Mar 2023 09:36:23 +0100
Received: from steina-w.tq-net.de (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 5F14E280056;
        Mon, 13 Mar 2023 09:36:23 +0100 (CET)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-spi@vger.kernel.org
Subject: [PATCH 1/1] spi: nxp-flexspi: Add i.MX platform dependency
Date:   Mon, 13 Mar 2023 09:36:21 +0100
Message-Id: <20230313083621.154729-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This driver also supports various i.MX8 platforms. Add ARCH_MXC for
selecting this driver without Layerscape support.

Fixes: c6b15b2437a10 ("spi: nxp-flexspi: Fix ARCH_LAYERSCAPE dependency")
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
While technically c6b15b2437a10 did nothing wrong, it was not possible
to select this driver on i.MX and non-Layerscape kernel configs.

 drivers/spi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 36a18c215163f..0a8bbafde2c69 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -406,7 +406,7 @@ config SPI_HISI_SFC_V3XX
 
 config SPI_NXP_FLEXSPI
 	tristate "NXP Flex SPI controller"
-	depends on ARCH_LAYERSCAPE || COMPILE_TEST
+	depends on ARCH_LAYERSCAPE || ARCH_MXC || COMPILE_TEST
 	depends on HAS_IOMEM
 	help
 	  This enables support for the Flex SPI controller in master mode.
-- 
2.34.1

