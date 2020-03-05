Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C85917A8C3
	for <lists+linux-spi@lfdr.de>; Thu,  5 Mar 2020 16:22:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbgCEPWw (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 5 Mar 2020 10:22:52 -0500
Received: from smtprelay0034.hostedemail.com ([216.40.44.34]:36813 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726413AbgCEPWw (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 5 Mar 2020 10:22:52 -0500
X-Greylist: delayed 323 seconds by postgrey-1.27 at vger.kernel.org; Thu, 05 Mar 2020 10:22:52 EST
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave01.hostedemail.com (Postfix) with ESMTP id 8F1B41802B4A2
        for <linux-spi@vger.kernel.org>; Thu,  5 Mar 2020 15:17:30 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 2F716182CF66B;
        Thu,  5 Mar 2020 15:17:29 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:800:960:968:973:988:989:1260:1277:1311:1313:1314:1345:1437:1515:1516:1518:1534:1539:1568:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3865:3870:5007:6691:8957:10004:10400:10848:11026:11473:11658:11914:12296:12297:12555:12760:13069:13311:13357:13439:14096:14097:14181:14394:14659:14721:21080:21627:30054,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: hour30_413e0a59f4f56
X-Filterd-Recvd-Size: 1485
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Thu,  5 Mar 2020 15:17:28 +0000 (UTC)
Message-ID: <f8ac6b32a29b9a05b58a7e58ffe8b780642abbf1.camel@perches.com>
Subject: [PATCH] spi: Remove CONFIG_ prefix from Kconfig select
From:   Joe Perches <joe@perches.com>
To:     John Garry <john.garry@huawei.com>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Thu, 05 Mar 2020 07:15:53 -0800
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

commit a2ca53b52e00 ("spi: Add HiSilicon v3xx SPI NOR flash
controller driver") likely inadvertently used a select statement
with a CONFIG_ prefix, remove the prefix.

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/spi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 82177d..2dc7bd 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -292,7 +292,7 @@ config SPI_HISI_SFC_V3XX
 	tristate "HiSilicon SPI-NOR Flash Controller for Hi16XX chipsets"
 	depends on (ARM64 && ACPI) || COMPILE_TEST
 	depends on HAS_IOMEM
-	select CONFIG_MTD_SPI_NOR
+	select MTD_SPI_NOR
 	help
 	  This enables support for HiSilicon v3xx SPI-NOR flash controller
 	  found in hi16xx chipsets.


