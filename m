Return-Path: <linux-spi+bounces-252-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E50810A53
	for <lists+linux-spi@lfdr.de>; Wed, 13 Dec 2023 07:31:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7137F1C20BB6
	for <lists+linux-spi@lfdr.de>; Wed, 13 Dec 2023 06:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2843FBF3;
	Wed, 13 Dec 2023 06:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f3eJqOC/"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30673E4;
	Tue, 12 Dec 2023 22:31:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702449104; x=1733985104;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=cYOq7AZDrqOem5EFBS27D9w2EDbODgEUDb6Vlfdk2EM=;
  b=f3eJqOC/bDbmO3zWUeOgov91fD3ZQM9Ratix29Q5JuNoHjTeixzNwqOE
   qECF5M79adV3YXr+i+7Y2sh2tDke1RyR7kMq0LWWUi/GW8MImpsrfVtUV
   o/8rwY5HA08n30dCGmn8xUEFcl+tUei0Thag6Jb+tkN481Vor+jr3hyVJ
   eYNojx5QazuAnGmr0fONvJHeGkBVzoHXdVWEpkxfSJaDH/6TTsVxqrokw
   dU8MNw0y3P6P4cUOYNKlHwGWtz/sQ0E1uhXW4q4PYFHgSiYb7JpWC/ZgH
   qGZclvEtsCjtO/hQvDDdQvWl40aQsM7tmdVsc9pcnWaa1SFCOQlrxpvNP
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="8281310"
X-IronPort-AV: E=Sophos;i="6.04,272,1695711600"; 
   d="scan'208";a="8281310"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 22:31:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="947065772"
X-IronPort-AV: E=Sophos;i="6.04,272,1695711600"; 
   d="scan'208";a="947065772"
Received: from srikandan-ilbpg12.png.intel.com ([10.88.229.69])
  by orsmga005.jf.intel.com with ESMTP; 12 Dec 2023 22:31:40 -0800
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
Subject: [PATCH v1 2/2] spi: dw: Remove Intel Thunder Bay SOC support
Date: Wed, 13 Dec 2023 14:08:36 +0800
Message-Id: <20231213060836.29203-3-nandhini.srikandan@intel.com>
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
---
 Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
index 6348a387a21c..fde3776a558b 100644
--- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
+++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
@@ -72,8 +72,6 @@ properties:
           - const: snps,dw-apb-ssi
       - description: Intel Keem Bay SPI Controller
         const: intel,keembay-ssi
-      - description: Intel Thunder Bay SPI Controller
-        const: intel,thunderbay-ssi
       - description: Intel Mount Evans Integrated Management Complex SPI Controller
         const: intel,mountevans-imc-ssi
       - description: AMD Pensando Elba SoC SPI Controller
-- 
2.17.1


