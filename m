Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6E9B3989A2
	for <lists+linux-spi@lfdr.de>; Wed,  2 Jun 2021 14:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbhFBMgZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 2 Jun 2021 08:36:25 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:38712 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbhFBMgZ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 2 Jun 2021 08:36:25 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 152CYUxV025744;
        Wed, 2 Jun 2021 07:34:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1622637270;
        bh=opVrt73ymfv/6uhSjsguTvxs1Rmlw38Uf1yErC4nMCg=;
        h=From:To:CC:Subject:Date;
        b=qMgSMUCqnyvwU2emGXEJn9CFlPAANBZ6E5krfPrXpaqjLFp38MY6yp1xFPZaE9CZ1
         DVct/cUHsK9ozxEZ3VPoPahJ6sJGd/Qsrc3GQPe5wJEULiw+EF6ybrzfWaK7iX72ps
         HqLjMQhxoF+lGu1mYQ4DozIgtYbEaKFeOx+7gU2w=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 152CYUX4013459
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 2 Jun 2021 07:34:30 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 2 Jun
 2021 07:34:30 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 2 Jun 2021 07:34:29 -0500
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 152CYKN3023646;
        Wed, 2 Jun 2021 07:34:22 -0500
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     Lokesh Vutla <lokeshvutla@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>,
        Tero Kristo <kristo@kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 0/5] dt-bindings: spi: omap-spi: Convert to json-schema
Date:   Wed, 2 Jun 2021 18:04:10 +0530
Message-ID: <20210602123416.20378-1-a-govindraju@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Convert the omap-spi device tree binding documentation to json-schema.
The property ti,pindir-d0-out-d1-in is expected to be of type boolean.

All ti,pindir-d0-out-d1-in occurences are fixed before changing the
binding to avoid dtbs_check warnings.

Aswath Govindraju (5):
  ARM: dts: am335x: align ti,pindir-d0-out-d1-in property with dt-shema
  ARM: dts: am437x: align ti,pindir-d0-out-d1-in property with dt-shema
  arm64: dts: ti: am65: align ti,pindir-d0-out-d1-in property with
    dt-shema
  arm64: dts: ti: k3-am642-evm: align ti,pindir-d0-out-d1-in property
    with dt-shema
  dt-bindings: spi: omap-spi: Convert to json-schema

 .../devicetree/bindings/spi/omap-spi.txt      |  48 -------
 .../devicetree/bindings/spi/omap-spi.yaml     | 126 ++++++++++++++++++
 arch/arm/boot/dts/am335x-cm-t335.dts          |   2 +-
 arch/arm/boot/dts/am43x-epos-evm.dts          |   4 +-
 arch/arm64/boot/dts/ti/k3-am642-evm.dts       |   2 +-
 .../boot/dts/ti/k3-am65-iot2050-common.dtsi   |   2 +-
 .../arm64/boot/dts/ti/k3-am654-base-board.dts |   2 +-
 7 files changed, 132 insertions(+), 54 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/spi/omap-spi.txt
 create mode 100644 Documentation/devicetree/bindings/spi/omap-spi.yaml

-- 
2.17.1

