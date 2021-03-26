Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69A5034A7B9
	for <lists+linux-spi@lfdr.de>; Fri, 26 Mar 2021 14:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbhCZNBJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 26 Mar 2021 09:01:09 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:57764 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbhCZNAv (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 26 Mar 2021 09:00:51 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12QD0jAX096899;
        Fri, 26 Mar 2021 08:00:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1616763645;
        bh=D3XDULHevkagv30TGYRp4FBqTHmE6ZkYvahDbNozgOo=;
        h=From:To:CC:Subject:Date;
        b=ZQHzVkfmBHDtQZXrbEoGEPKNhj0pzIw9Mwr+eoZ97TgnElhJzNStjU4o9vgSau+vn
         KIGm6OJboRkls5etoHAF43AYxfYoWRTWaQicVX2fSwy9hqVyEHMzIVfbgy6F1u0Mkt
         nxSLBKMbwvr2i9HFNeTD++kA7NbH1BXnz3Tu6K1Y=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12QD0j4d000722
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 26 Mar 2021 08:00:45 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 26
 Mar 2021 08:00:38 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Fri, 26 Mar 2021 08:00:38 -0500
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12QD0Zvq029283;
        Fri, 26 Mar 2021 08:00:35 -0500
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Pratyush Yadav <p.yadav@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH 0/4] Convert Cadence QSPI bindings to yaml
Date:   Fri, 26 Mar 2021 18:30:30 +0530
Message-ID: <20210326130034.15231-1-p.yadav@ti.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

This series picks up Ramuthevar's effort on converting the Cadence QSPI
bindings to yaml [0]. During the conversion process, I discovered that
some TI device tree files were not using the compatible correctly. Those
are fixed in patches 1-3.

[0] https://patchwork.kernel.org/project/spi-devel-general/patch/20201116031003.19062-6-vadivel.muruganx.ramuthevar@linux.intel.com/

Pratyush Yadav (3):
  arm64: dts: ti: k3-j721e-mcu: Fix ospi compatible
  arm64: dts: ti: k3-j7200-mcu: Fix ospi compatible
  arm64: dts: ti: k3-am64-main: Fix ospi compatible

Ramuthevar Vadivel Murugan (1):
  dt-bindings: spi: Convert cadence-quadspi.txt to cadence-quadspi.yaml

 .../bindings/spi/cadence-quadspi.txt          |  68 ---------
 .../bindings/spi/cdns,qspi-nor.yaml           | 143 ++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi      |   2 +-
 .../boot/dts/ti/k3-j7200-mcu-wakeup.dtsi      |   2 +-
 .../boot/dts/ti/k3-j721e-mcu-wakeup.dtsi      |   4 +-
 5 files changed, 147 insertions(+), 72 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/spi/cadence-quadspi.txt
 create mode 100644 Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml

--
2.30.0

