Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3402B3BBC
	for <lists+linux-spi@lfdr.de>; Mon, 16 Nov 2020 04:10:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbgKPDK0 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 15 Nov 2020 22:10:26 -0500
Received: from mga18.intel.com ([134.134.136.126]:37816 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726751AbgKPDK0 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Sun, 15 Nov 2020 22:10:26 -0500
IronPort-SDR: g0/SC2HFsG62nynBwJM3bxX1rNL0Cf1pIzhgZLO8vB/clAYDhVgVZ1ujP0JI8Ibkr6zVdRTdoY
 NMh4qDGtI6sQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9806"; a="158472685"
X-IronPort-AV: E=Sophos;i="5.77,481,1596524400"; 
   d="scan'208";a="158472685"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2020 19:10:26 -0800
IronPort-SDR: pDnqq2EFW2KmzZ2wu3cJYhwXl1Iw7hrG7sKpqOc6Qxteli6kFAMWGJNMNrqC5rfY+jXtrdC40d
 EwT/Nv8o6W6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,481,1596524400"; 
   d="scan'208";a="475388292"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by orsmga004.jf.intel.com with ESMTP; 15 Nov 2020 19:10:23 -0800
From:   "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
To:     broonie@kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Cc:     linux-mtd@lists.infradead.org, vigneshr@ti.com, p.yadav@ti.com,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        Ramuthevar Vadivel Murugan 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Subject: [PATCH v7 4/6] spi: Move cadence-quadspi.txt to Documentation/devicetree/bindings/spi
Date:   Mon, 16 Nov 2020 11:10:01 +0800
Message-Id: <20201116031003.19062-5-vadivel.muruganx.ramuthevar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20201116031003.19062-1-vadivel.muruganx.ramuthevar@linux.intel.com>
References: <20201116031003.19062-1-vadivel.muruganx.ramuthevar@linux.intel.com>
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

