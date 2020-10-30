Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C17E29FD4E
	for <lists+linux-spi@lfdr.de>; Fri, 30 Oct 2020 06:32:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725852AbgJ3FcS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 30 Oct 2020 01:32:18 -0400
Received: from mga01.intel.com ([192.55.52.88]:21918 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725770AbgJ3FcR (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 30 Oct 2020 01:32:17 -0400
IronPort-SDR: dacPLHBxmffpQxh5ubcSEA3Dm1jquGX8/63mKK302mBnUVZ6viGCqmEG0FMsEI3LmsE2U3Jzfk
 lyb/GPnInr4Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9789"; a="186364246"
X-IronPort-AV: E=Sophos;i="5.77,432,1596524400"; 
   d="scan'208";a="186364246"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2020 22:32:17 -0700
IronPort-SDR: 71m9rRnT3TNx4L1wpIVgyEFWEM9Kc/Ls1Xk2XdzhE2YqBU+PRsMIZZ/mm0+YnTz3vtlXFm5H52
 wuH+dEh5fHDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,432,1596524400"; 
   d="scan'208";a="323963538"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by orsmga006.jf.intel.com with ESMTP; 29 Oct 2020 22:32:13 -0700
From:   "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
To:     broonie@kernel.org, vigneshr@ti.com, tudor.ambarus@microchip.com,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, miquel.raynal@bootlin.com,
        simon.k.r.goldschmidt@gmail.com, dinguyen@kernel.org,
        richard@nod.at, cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        Ramuthevar Vadivel Murugan 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Subject: [PATCH v6 4/6] spi: Move cadence-quadspi.txt to Documentation/devicetree/bindings/spi
Date:   Fri, 30 Oct 2020 13:31:51 +0800
Message-Id: <20201030053153.5319-5-vadivel.muruganx.ramuthevar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20201030053153.5319-1-vadivel.muruganx.ramuthevar@linux.intel.com>
References: <20201030053153.5319-1-vadivel.muruganx.ramuthevar@linux.intel.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>

Move the Documentation/devicetree/bindings/mtd/cadence-quadspi.txt to
Documentation/devicetree/bindings/spi/

Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
Acked-by: Rob Herring <robh@kernel.org>
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

