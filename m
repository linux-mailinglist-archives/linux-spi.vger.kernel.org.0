Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55E522E0E4F
	for <lists+linux-spi@lfdr.de>; Tue, 22 Dec 2020 19:45:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725913AbgLVSpL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 22 Dec 2020 13:45:11 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:54336 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbgLVSpK (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 22 Dec 2020 13:45:10 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0BMIiSKE015027;
        Tue, 22 Dec 2020 12:44:28 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1608662668;
        bh=nIeu68XbENAxLALuN59XaMZObxogV3FSs/9yg4UBJ/k=;
        h=From:To:CC:Subject:Date;
        b=htqxS2UlVYUnb1mv27k4xXuLYX/HMhxPztNN1xyiZbTiZ62+EEOO7dMZ5w6fZcITh
         qy9pVvt5xbYTwX0H8Df33KIaYO4fLhn+hs9C1MTPV44jMPQk311AzCvsXdJupnVyd8
         /aofKE7+G/VAu3RO/ZVlngTZL3G0V4dCAK/kN0aw=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0BMIiSCq122898
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 22 Dec 2020 12:44:28 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 22
 Dec 2020 12:44:28 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 22 Dec 2020 12:44:28 -0600
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0BMIiQbY003761;
        Tue, 22 Dec 2020 12:44:26 -0600
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Mark Brown <broonie@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC:     Pratyush Yadav <p.yadav@ti.com>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/7] spi: cadence-quadspi: Add Octal DTR support
Date:   Wed, 23 Dec 2020 00:14:18 +0530
Message-ID: <20201222184425.7028-1-p.yadav@ti.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

This series adds support for Octal DTR mode now that SPI NOR supports
these flashes. Patches 1/7 to 4/7 and 6/7 fix some minor bugs and issues.
Patche 5/7 lays some groundwork by implementing the supports_op() hook.
Patch 7/7 adds the Octal DTR mode support.

While the main aim of this series is to support 8D-8D-8D mode, other
modes like 4D-4D-4D or 2S-2S-2S should also now be supported, though
they have not been tested.

Tested on J721E with Micron MT35XU512ABA and on J7200 with Cypress
S28HS512T. Tested on J721E with Micron MT25QU512A (1S-1S-4S) for
regressions.

Pratyush Yadav (7):
  spi: cadence-quadspi: Set master max_speed_hz
  spi: cadence-quadspi: Abort read if dummy cycles required are too many
  spi: cadence-quadspi: Set dummy cycles from STIG commands
  spi: cadence-quadspi: Fix dummy cycle calculation when buswidth > 1
  spi: cadence-quadspi: Implement a simple supports_op hook
  spi: cadence-quadspi: Wait at least 500 ms for direct reads
  spi: cadence-quadspi: Add DTR support

 drivers/spi/spi-cadence-quadspi.c | 364 ++++++++++++++++++++++++++----
 1 file changed, 325 insertions(+), 39 deletions(-)

--
2.28.0

