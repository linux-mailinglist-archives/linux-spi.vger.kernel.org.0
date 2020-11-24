Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5DB12C1CA6
	for <lists+linux-spi@lfdr.de>; Tue, 24 Nov 2020 05:19:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728664AbgKXETD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 23 Nov 2020 23:19:03 -0500
Received: from mga11.intel.com ([192.55.52.93]:8580 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726158AbgKXETC (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 23 Nov 2020 23:19:02 -0500
IronPort-SDR: CYW0wzwj6+lVrqfgb9oZZIGYnz88q+7s+0DWhzv/xNEag2C9a8yQhyjElW1bdAAM3rzkT/+sDh
 rTRNgnP7dQTg==
X-IronPort-AV: E=McAfee;i="6000,8403,9814"; a="168378678"
X-IronPort-AV: E=Sophos;i="5.78,365,1599548400"; 
   d="scan'208";a="168378678"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2020 20:19:02 -0800
IronPort-SDR: ++OmqnLsI5AT3NOOm1uzbLZ4Im9mQ8lCfJJ8VzVgvpi2wmVXRSLQg78F+dUSlLlpiIaV+xJ9fp
 clxf0yuD6Ryw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,365,1599548400"; 
   d="scan'208";a="343029884"
Received: from sgsxdev004.isng.phoenix.local (HELO localhost) ([10.226.81.179])
  by orsmga002.jf.intel.com with ESMTP; 23 Nov 2020 20:19:00 -0800
From:   "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
To:     broonie@kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Cc:     linux-mtd@lists.infradead.org, vigneshr@ti.com, p.yadav@ti.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        Ramuthevar Vadivel Murugan 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Subject: [PATCH v9 4/5] spi: Move cadence-quadspi.txt to Documentation/devicetree/bindings/spi
Date:   Tue, 24 Nov 2020 12:18:39 +0800
Message-Id: <20201124041840.31066-5-vadivel.muruganx.ramuthevar@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201124041840.31066-1-vadivel.muruganx.ramuthevar@linux.intel.com>
References: <20201124041840.31066-1-vadivel.muruganx.ramuthevar@linux.intel.com>
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

