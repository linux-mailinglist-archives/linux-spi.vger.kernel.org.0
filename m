Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5742D0B9F
	for <lists+linux-spi@lfdr.de>; Mon,  7 Dec 2020 09:18:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbgLGIS5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 7 Dec 2020 03:18:57 -0500
Received: from bmailout3.hostsharing.net ([176.9.242.62]:58985 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbgLGIS4 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 7 Dec 2020 03:18:56 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id C22B0100FBEDB;
        Mon,  7 Dec 2020 09:18:13 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 6E9BBACE0; Mon,  7 Dec 2020 09:18:14 +0100 (CET)
Message-Id: <cover.1607286887.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Mon, 7 Dec 2020 09:17:00 +0100
Subject: [PATCH 00/17] SPI probe/remove sanitization for 5.11
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, Chuanhong Guo <gch981213@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Piotr Bugalski <bugalski.piotr@gmail.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Patches [01/17] to [14/17] are reposts, now based on spi.git/for-5.11
and amended with all collected Acked-by + Reviewed-by tags.

Links to their original submission:
https://lore.kernel.org/linux-spi/dd060534490eca5e946eb9165916542b01a9358d.1604874488.git.lukas@wunner.de/
https://lore.kernel.org/linux-spi/73adc6ba84a4f968f2e1499a776e5c928fbdde56.1605512876.git.lukas@wunner.de/T/#t

Patches [15/17] to [17/17] are new material.

Lukas Wunner (17):
  spi: davinci: Fix use-after-free on unbind
  spi: spi-geni-qcom: Fix use-after-free on unbind
  spi: spi-qcom-qspi: Fix use-after-free on unbind
  spi: spi-sh: Fix use-after-free on unbind
  spi: pxa2xx: Fix use-after-free on unbind
  spi: rpc-if: Fix use-after-free on unbind
  spi: mxic: Don't leak SPI master in probe error path
  spi: spi-mtk-nor: Don't leak SPI master in probe error path
  spi: gpio: Don't leak SPI master in probe error path
  spi: rb4xx: Don't leak SPI master in probe error path
  spi: sc18is602: Don't leak SPI master in probe error path
  media: netup_unidvb: Don't leak SPI master in probe error path
  spi: mt7621: Disable clock in probe error path
  spi: mt7621: Don't leak SPI master in probe error path
  spi: ar934x: Don't leak SPI master in probe error path
  spi: npcm-fiu: Disable clock in probe error path
  spi: atmel-quadspi: Fix use-after-free on unbind

 .../media/pci/netup_unidvb/netup_unidvb_spi.c |  5 ++-
 drivers/spi/atmel-quadspi.c                   | 15 +++----
 drivers/spi/spi-ar934x.c                      | 14 +++++--
 drivers/spi/spi-davinci.c                     |  2 +-
 drivers/spi/spi-geni-qcom.c                   |  3 +-
 drivers/spi/spi-gpio.c                        | 15 +------
 drivers/spi/spi-mt7621.c                      |  9 +++-
 drivers/spi/spi-mtk-nor.c                     |  2 +-
 drivers/spi/spi-mxic.c                        | 10 +----
 drivers/spi/spi-npcm-fiu.c                    |  8 +++-
 drivers/spi/spi-pxa2xx.c                      |  5 +--
 drivers/spi/spi-qcom-qspi.c                   | 42 +++++++------------
 drivers/spi/spi-rb4xx.c                       |  2 +-
 drivers/spi/spi-rpc-if.c                      |  9 +---
 drivers/spi/spi-sc18is602.c                   | 13 +-----
 drivers/spi/spi-sh.c                          | 13 ++----
 16 files changed, 66 insertions(+), 101 deletions(-)

-- 
2.29.2

