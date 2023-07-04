Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA9A6746D15
	for <lists+linux-spi@lfdr.de>; Tue,  4 Jul 2023 11:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231924AbjGDJUA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Tue, 4 Jul 2023 05:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231896AbjGDJT6 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 4 Jul 2023 05:19:58 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B62D127;
        Tue,  4 Jul 2023 02:19:55 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id C4B3424E2B5;
        Tue,  4 Jul 2023 17:19:52 +0800 (CST)
Received: from EXMBX068.cuchost.com (172.16.6.68) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 4 Jul
 2023 17:19:52 +0800
Received: from williamqiu-virtual-machine.starfivetech.com (171.223.208.138)
 by EXMBX068.cuchost.com (172.16.6.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.42; Tue, 4 Jul 2023 17:19:51 +0800
From:   William Qiu <william.qiu@starfivetech.com>
To:     <devicetree@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
CC:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Linus Walleij <linus.walleij@linaro.org>,
        William Qiu <william.qiu@starfivetech.com>
Subject: [PATCH v4 0/3] Add initialization of clock for StarFive JH7110 SoC
Date:   Tue, 4 Jul 2023 17:19:45 +0800
Message-ID: <20230704091948.85247-4-william.qiu@starfivetech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230704091948.85247-1-william.qiu@starfivetech.com>
References: <20230704091948.85247-1-william.qiu@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [171.223.208.138]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX068.cuchost.com
 (172.16.6.68)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

This patchset adds initial rudimentary support for the StarFive
Quad SPI controller driver. And this driver will be used in
StarFive's VisionFive 2 board. In 6.4, the QSPI_AHB and QSPI_APB
clocks changed from the default ON state to the default OFF state,
so these clocks need to be enabled in the driver.At the same time,
dts patch is added to this series.

Changes v3->v4:
- Added minItems for clocks.
- Added clock names property.
- Fixed formatting issues.

Changes v2->v3:
- Rebaed to v6.4rc6.
- Renamed the clock names.
- Changed the variable definition type.

Changes v1->v2:
- Renamed the clock names.
- Specified a different array of clocks.
- Used clk_bulk_ APIs.

The patch series is based on v6.4rc6.

William Qiu (3):
  dt-bindings: qspi: cdns,qspi-nor: Add clocks for StarFive JH7110 SoC
  spi: cadence-quadspi: Add clock configuration for StarFive JH7110 QSPI
  riscv: dts: starfive: Add QSPI controller node for StarFive JH7110 SoC

 .../bindings/spi/cdns,qspi-nor.yaml           | 12 ++++++-
 .../jh7110-starfive-visionfive-2.dtsi         | 32 +++++++++++++++++++
 arch/riscv/boot/dts/starfive/jh7110.dtsi      | 18 +++++++++++
 drivers/spi/spi-cadence-quadspi.c             | 20 ++++++++++++
 4 files changed, 81 insertions(+), 1 deletion(-)

--
2.34.1

