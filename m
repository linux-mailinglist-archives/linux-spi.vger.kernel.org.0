Return-Path: <linux-spi+bounces-250-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A82810A52
	for <lists+linux-spi@lfdr.de>; Wed, 13 Dec 2023 07:31:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8C0DB20D70
	for <lists+linux-spi@lfdr.de>; Wed, 13 Dec 2023 06:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2015DFBF3;
	Wed, 13 Dec 2023 06:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fVLg6Dg4"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5417BE4;
	Tue, 12 Dec 2023 22:31:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702449097; x=1733985097;
  h=from:to:cc:subject:date:message-id;
  bh=OQ7WzdvD05NPItZLW1pLFQ5aeAJVE0IdbApen3gJr6c=;
  b=fVLg6Dg4/RDm4b2Q1wkVYwNQ/aKDMH3GKoMPdgosnw+chUDbVK948pHy
   Ziw2Y8FlzeaiJMuvs5+bH3rs/466EiQJc035NTQry614Vpl1IUaoACpfm
   FNwWJIGSiU6uj3OTc74AxW1PWB1RGlxBOEU2egniO5dKFbNB0eRnRixr4
   C4oMZuiOW3gXD5uYZjb6XzLqedszMCQjy/tS/mJELsEGaL10xkWo0QWl4
   Y2YJGWuYCqO963gkVZOTBaQSox9fhb3OoNRy82o2gZy4JRny5D2EHVwBZ
   IWOq/fKz9YE6BgJGiWGXKTBqXmmngT+Aoeaf+8gV6wrKqZ7f7qc/qnlQX
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="8281303"
X-IronPort-AV: E=Sophos;i="6.04,272,1695711600"; 
   d="scan'208";a="8281303"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 22:31:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="947065763"
X-IronPort-AV: E=Sophos;i="6.04,272,1695711600"; 
   d="scan'208";a="947065763"
Received: from srikandan-ilbpg12.png.intel.com ([10.88.229.69])
  by orsmga005.jf.intel.com with ESMTP; 12 Dec 2023 22:31:32 -0800
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
Subject: [PATCH v1 0/2] Remove Intel Thunder Bay SOC support                       
Date: Wed, 13 Dec 2023 14:08:34 +0800
Message-Id: <20231213060836.29203-1-nandhini.srikandan@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

From: Nandhini Srikandan <nandhini.srikandan@intel.com>

This patch set removes Intel Thunder Bay specific code as the product              
got cancelled and there are no end customers.                                      
                                                                                   
Patch 1: Remove Intel Thunder Bay spi dw binding specific code.                    
Patch 2: Remove Intel Thunder Bay spi dw binding Documentation.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Nandhini Srikandan (2):
  spi: dw: Remove Intel Thunder Bay SOC support
  spi: dw: Remove Intel Thunder Bay SOC support

 Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml | 2 --
 drivers/spi/spi-dw-mmio.c                                  | 1 -
 2 files changed, 3 deletions(-)

-- 
2.17.1


