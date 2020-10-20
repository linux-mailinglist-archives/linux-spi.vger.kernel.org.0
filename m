Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB0329332D
	for <lists+linux-spi@lfdr.de>; Tue, 20 Oct 2020 04:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390669AbgJTCc6 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 19 Oct 2020 22:32:58 -0400
Received: from mga01.intel.com ([192.55.52.88]:36308 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390670AbgJTCc4 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 19 Oct 2020 22:32:56 -0400
IronPort-SDR: 3fp72u5ehUzkJxtLTxzF07Y6Vb+DL8gD08aRbGnO85Iot+2uppMfsGbBKGIb3b1YDcd+3Ib0F6
 I/XQxseEODPg==
X-IronPort-AV: E=McAfee;i="6000,8403,9779"; a="184762957"
X-IronPort-AV: E=Sophos;i="5.77,395,1596524400"; 
   d="scan'208";a="184762957"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2020 19:32:56 -0700
IronPort-SDR: 1MDZIi+CsULIkQQRbYYY5gKpk+3IvC0FWVOLPUyn0Av+iRAHfCZnTwX5do5+WL++2e7jySPHAt
 aFSJLSrZNLhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,395,1596524400"; 
   d="scan'208";a="301592722"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by fmsmga007.fm.intel.com with ESMTP; 19 Oct 2020 19:32:52 -0700
From:   "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
To:     vigneshr@ti.com, tudor.ambarus@microchip.com, broonie@kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, miquel.raynal@bootlin.com,
        simon.k.r.goldschmidt@gmail.com, dinguyen@kernel.org,
        richard@nod.at, cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        Ramuthevar Vadivel Murugan 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Subject: [RESENDPATCH v1 4/6] spi: Move cadence-quadspi.txt to Documentation/devicetree/bindings/spi
Date:   Tue, 20 Oct 2020 10:32:24 +0800
Message-Id: <20201020023226.33559-5-vadivel.muruganx.ramuthevar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20201020023226.33559-1-vadivel.muruganx.ramuthevar@linux.intel.com>
References: <20201020023226.33559-1-vadivel.muruganx.ramuthevar@linux.intel.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>

Move the Documentation/devicetree/bindings/mtd/cadence-quadspi.txt to
Documentation/devicetree/bindings/spi/

Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
---
 Documentation/devicetree/bindings/{mtd => spi}/cadence-quadspi.txt | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename Documentation/devicetree/bindings/{mtd => spi}/cadence-quadspi.txt (100%)

diff --git a/Documentation/devicetree/bindings/mtd/cadence-quadspi.txt b/Documentation/devicetree/bindings/spi/cadence-quadspi.txt
similarity index 100%
rename from Documentation/devicetree/bindings/mtd/cadence-quadspi.txt
rename to Documentation/devicetree/bindings/spi/cadence-quadspi.txt
-- 
2.11.0

