Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B649206994
	for <lists+linux-spi@lfdr.de>; Wed, 24 Jun 2020 03:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388502AbgFXBfn (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 23 Jun 2020 21:35:43 -0400
Received: from mga18.intel.com ([134.134.136.126]:59184 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388448AbgFXBfm (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 23 Jun 2020 21:35:42 -0400
IronPort-SDR: GzR4V8bjb/CtnH0HJvCxakcF5sztEtpYSPxjbG22ddU1WINR9T5fHRLxkzV1KmBgeYO4XEj/sX
 GjSyp+pHeFkQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9661"; a="131712149"
X-IronPort-AV: E=Sophos;i="5.75,273,1589266800"; 
   d="scan'208";a="131712149"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2020 18:35:41 -0700
IronPort-SDR: hkR805WW60D4MWqb1W4N7DTGGmvCrTzHKG0lrmxPalIZ2mFlolV784aLk5w76DivwmY2X710dD
 Un+CT7ewq5Jw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,273,1589266800"; 
   d="scan'208";a="452459759"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.141])
  by orsmga005.jf.intel.com with ESMTP; 23 Jun 2020 18:35:39 -0700
From:   Xu Yilun <yilun.xu@intel.com>
To:     broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, hao.wu@intel.com, matthew.gerlach@linux.intel.com,
        russell.h.weight@intel.com, yilun.xu@intel.com
Subject: [PATCH 2/2] spi: altera: fix module autoload
Date:   Wed, 24 Jun 2020 09:31:26 +0800
Message-Id: <1592962286-25752-3-git-send-email-yilun.xu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1592962286-25752-1-git-send-email-yilun.xu@intel.com>
References: <1592962286-25752-1-git-send-email-yilun.xu@intel.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add the MODULE_DEVICE_TABLE macro for the platform_device_id table to
allow proper creation of modalias strings and fix autoloading module for
this driver.

Signed-off-by: Xu Yilun <yilun.xu@intel.com>
Signed-off-by: Russ Weight <russell.h.weight@intel.com>
---
 drivers/spi/spi-altera.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-altera.c b/drivers/spi/spi-altera.c
index e272a04..809bfff 100644
--- a/drivers/spi/spi-altera.c
+++ b/drivers/spi/spi-altera.c
@@ -356,6 +356,7 @@ static const struct platform_device_id altera_spi_ids[] = {
 	{ "subdev_spi_altera",	ALTERA_SPI_TYPE_SUBDEV },
 	{ }
 };
+MODULE_DEVICE_TABLE(platform, altera_spi_ids);
 
 static struct platform_driver altera_spi_driver = {
 	.probe = altera_spi_probe,
-- 
2.7.4

