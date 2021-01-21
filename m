Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8069B2FF8B1
	for <lists+linux-spi@lfdr.de>; Fri, 22 Jan 2021 00:24:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbhAUXXe (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 21 Jan 2021 18:23:34 -0500
Received: from alln-iport-6.cisco.com ([173.37.142.93]:10245 "EHLO
        alln-iport-6.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbhAUXXC (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 21 Jan 2021 18:23:02 -0500
X-Greylist: delayed 576 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 Jan 2021 18:23:00 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=678; q=dns/txt; s=iport;
  t=1611271382; x=1612480982;
  h=from:to:cc:subject:date:message-id;
  bh=j380aoXZJEivOdde/Uk2ne3Qfwo96RvvIQjTxbYW+g4=;
  b=IDEVKYvsF9RfCCmAXN61iTJGGMFsUdizZPjLWMA+Nk9qi855ru7tYbfl
   d7XOJMnDkpEnsTN0aDsv+CaqLnAhM30M3FB/cKulXPsesBE3MThBm1mMt
   4P2vgWfiPOWmNmCqBrUS4Gif4q6sRZlaYMczwwXWy1IWmnrS7+ddMtaba
   A=;
X-IPAS-Result: =?us-ascii?q?A0DFAQAGCQpgmJtdJa1iHgEBCxIMhgcBMi+yWQsBAQEPL?=
 =?us-ascii?q?wQBAYRKgXkCJTgTAgMBAQEDAgMBAQEBBQEBAQIBBgQUAQEBAQEBAQGGQoZzK?=
 =?us-ascii?q?YEVE4MmgwexPoIohVmDRIFDFIEkiFWFCxuBQT+EaIo3BIJFgQ6faJtagwGBH?=
 =?us-ascii?q?Jo9DyKDGJ9XhiavcYFtIYFZMxoIGxWDJFAZDY47jlAgAzA3AgYKAQEDCYwTA?=
 =?us-ascii?q?QE?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.79,365,1602547200"; 
   d="scan'208";a="672208610"
Received: from rcdn-core-4.cisco.com ([173.37.93.155])
  by alln-iport-6.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 21 Jan 2021 23:12:39 +0000
Received: from zorba.cisco.com ([10.24.5.176])
        by rcdn-core-4.cisco.com (8.15.2/8.15.2) with ESMTP id 10LNCbRM024470;
        Thu, 21 Jan 2021 23:12:39 GMT
From:   Daniel Walker <danielwa@cisco.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     xe-linux-external@cisco.com, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] spidev: Add cisco device compatible
Date:   Thu, 21 Jan 2021 15:12:36 -0800
Message-Id: <20210121231237.30664-2-danielwa@cisco.com>
X-Mailer: git-send-email 2.17.1
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Outbound-SMTP-Client: 10.24.5.176, [10.24.5.176]
X-Outbound-Node: rcdn-core-4.cisco.com
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add compatible string for Cisco device present on the Cisco Petra
platform.

Signed-off-by: Daniel Walker <danielwa@cisco.com>
Cc: xe-linux-external@cisco.com
---
 drivers/spi/spidev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 859910ec8d9f..8cb4d923aeaa 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -682,6 +682,7 @@ static const struct of_device_id spidev_dt_ids[] = {
 	{ .compatible = "lwn,bk4" },
 	{ .compatible = "dh,dhcom-board" },
 	{ .compatible = "menlo,m53cpld" },
+	{ .compatible = "cisco,spi-petra" },
 	{},
 };
 MODULE_DEVICE_TABLE(of, spidev_dt_ids);
-- 
2.17.1

