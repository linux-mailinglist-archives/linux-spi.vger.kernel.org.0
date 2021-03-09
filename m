Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F06A331EAF
	for <lists+linux-spi@lfdr.de>; Tue,  9 Mar 2021 06:32:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbhCIFcR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 9 Mar 2021 00:32:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbhCIFb7 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 9 Mar 2021 00:31:59 -0500
Received: from mail-out.m-online.net (mail-out.m-online.net [IPv6:2001:a60:0:28:0:1:25:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50C8EC06174A
        for <linux-spi@vger.kernel.org>; Mon,  8 Mar 2021 21:31:59 -0800 (PST)
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4DvkNW715yz1ryWv
        for <linux-spi@vger.kernel.org>; Tue,  9 Mar 2021 06:31:55 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4DvkNW6tlBz1qql9
        for <linux-spi@vger.kernel.org>; Tue,  9 Mar 2021 06:31:55 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id sTWuhseyENNp for <linux-spi@vger.kernel.org>;
        Tue,  9 Mar 2021 06:31:55 +0100 (CET)
X-Auth-Info: Ju5zsO85IWjr7sMeOVEojiS0il0VMBlpv/YuYBNwKdU=
Received: from mail-internal.denx.de (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA
        for <linux-spi@vger.kernel.org>; Tue,  9 Mar 2021 06:31:55 +0100 (CET)
Received: from pollux.denx.de (pollux [192.168.1.1])
        by mail-internal.denx.de (Postfix) with ESMTP id 9E58A181BA1;
        Tue,  9 Mar 2021 06:31:18 +0100 (CET)
Received: by pollux.denx.de (Postfix, from userid 515)
        id 775871A0092; Tue,  9 Mar 2021 06:31:18 +0100 (CET)
From:   Heiko Schocher <hs@denx.de>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Heiko Schocher <hs@denx.de>, Alice Guo <alice.guo@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Ashish Kumar <ashish.kumar@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>, Li Jun <jun.li@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Teresa Remmet <t.remmet@phytec.de>,
        Yogesh Gaur <yogeshgaur.83@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: [PATCH v2 0/4] enable flexspi support on imx8mp
Date:   Tue,  9 Mar 2021 06:31:12 +0100
Message-Id: <20210309053116.1486347-1-hs@denx.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


This series enables support for the SPI NOR on the
imx8mp based phyboard-pollux-rdk board.

Patches new in v2:
"spi: fspi: enable fspi driver for on imx8mp"
which adds own compatible entry for imx8mp

and seperate in own patch the documentation entry in
patch "dt-bindings: spi: add compatible entry for imx8mp in FlexSPI controller"
as checkpatch says:

warning: DT binding docs and includes should be a separate patch. See: Documentation/devicetree/bindings/submitting-patches.rst


Changes in v2:
- work in comments from Marco
  add own compatible entry for imx8mp
- work in comments from Marco
  - add own compatible entry "nxp,imx8mp-fspi"
  - reworked order of properties as Marco mentioned
- work in comments from Marco and Teresa
  - rename node into "'som_flash: flash@0 { }"
  - compatible is now first entry
  - removed #size-cells and #address-cells
    as no child node. If bootloader adds them bootloader
    can add them too.

Heiko Schocher (4):
  spi: fspi: enable fspi driver for on imx8mp
  dt-bindings: spi: add compatible entry for imx8mp in FlexSPI
    controller
  arm64: dts: imx8mp: add flexspi node
  arm64: imx8mp: imx8mp-phycore-som enable spi nor

 .../devicetree/bindings/spi/spi-nxp-fspi.txt  |  1 +
 .../dts/freescale/imx8mp-phycore-som.dtsi     | 25 +++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8mp.dtsi     | 16 ++++++++++++
 drivers/spi/spi-nxp-fspi.c                    |  1 +
 4 files changed, 43 insertions(+)

-- 
2.29.2

