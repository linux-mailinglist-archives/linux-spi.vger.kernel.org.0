Return-Path: <linux-spi+bounces-251-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65016810A50
	for <lists+linux-spi@lfdr.de>; Wed, 13 Dec 2023 07:31:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 962C71C20A1E
	for <lists+linux-spi@lfdr.de>; Wed, 13 Dec 2023 06:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B05DEFC09;
	Wed, 13 Dec 2023 06:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TfaRUKvc"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AA53E3;
	Tue, 12 Dec 2023 22:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702449100; x=1733985100;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=l3TjH75+hXlfjJbv2Ipt3RlwWLEFcBhbY5irxqi+Fzk=;
  b=TfaRUKvctv31cHFebtXGsrUoBVrSHx5R+FDt/EX1JpK7vRO1lxZeC2y2
   F+0LSsktU3A6OB/ufiJD/y/AM8+vC2oxlvbsbUQ3He6pRPoTuzuWJsOuW
   2YDTY8Lbgq+7/xIUdNUxm8C5Kn1Oi4YeVhfoo5GZSfy57mwbUljTNUeXW
   0dVxZFcHELGe3jnUrNyh/wfyOkD5y4UCkL3gRNUDPSQhRnHHwQgzYC7Ld
   POV/Mtw4ZUoE1slXwhEFT6hi6Q7gEpgz8NF5+C4oUwX5Lct3a7A43qMCt
   PBWk6WyZj1d5+2JKS+QwYPyJZfA2A2atqykFNKkPYiVYSV+Ds//EiIGrH
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="8281307"
X-IronPort-AV: E=Sophos;i="6.04,272,1695711600"; 
   d="scan'208";a="8281307"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 22:31:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="947065766"
X-IronPort-AV: E=Sophos;i="6.04,272,1695711600"; 
   d="scan'208";a="947065766"
Received: from srikandan-ilbpg12.png.intel.com ([10.88.229.69])
  by orsmga005.jf.intel.com with ESMTP; 12 Dec 2023 22:31:36 -0800
From: nandhini.srikandan@intel.com
To: fancer.lancer@gmail.com,
	broonie@kernel.org,
	robh+dt@kernel.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: devicetree@vger.kernel.org,
	mgross@linux.intel.com,
	kris.pan@intel.com,
	kenchappa.demakkanavar@intel.com,
	furong.zhou@intel.com,
	mallikarjunappa.sangannavar@intel.com,
	mahesh.r.vaidya@intel.com,
	nandhini.srikandan@intel.com
Subject: [PATCH v1 1/2] spi: dw: Remove Intel Thunder Bay SOC support
Date: Wed, 13 Dec 2023 14:08:35 +0800
Message-Id: <20231213060836.29203-2-nandhini.srikandan@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231213060836.29203-1-nandhini.srikandan@intel.com>
References: <20231213060836.29203-1-nandhini.srikandan@intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

From: Nandhini Srikandan <nandhini.srikandan@intel.com>

Remove Intel Thunder Bay specific code as the product got cancelled and
there are no end customers or users.

Signed-off-by: Nandhini Srikandan <nandhini.srikandan@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-dw-mmio.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
index 46801189a651..cc74cbe03431 100644
--- a/drivers/spi/spi-dw-mmio.c
+++ b/drivers/spi/spi-dw-mmio.c
@@ -411,7 +411,6 @@ static const struct of_device_id dw_spi_mmio_of_match[] = {
 	{ .compatible = "renesas,rzn1-spi", .data = dw_spi_pssi_init},
 	{ .compatible = "snps,dwc-ssi-1.01a", .data = dw_spi_hssi_init},
 	{ .compatible = "intel,keembay-ssi", .data = dw_spi_intel_init},
-	{ .compatible = "intel,thunderbay-ssi", .data = dw_spi_intel_init},
 	{
 		.compatible = "intel,mountevans-imc-ssi",
 		.data = dw_spi_mountevans_imc_init,
-- 
2.17.1


