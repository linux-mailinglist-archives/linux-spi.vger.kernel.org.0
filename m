Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF1462C4D04
	for <lists+linux-spi@lfdr.de>; Thu, 26 Nov 2020 03:01:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732069AbgKZCAw (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 25 Nov 2020 21:00:52 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:17440 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730060AbgKZCAw (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 25 Nov 2020 21:00:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1606356051; x=1637892051;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=w7YOEIhMI8v6tTPl07pNEdytAyVq1hpIKUHf0meZHhM=;
  b=mYvhpocWqf/4qtGwInC5FZvEuxWaxV1Ix7eTo/ZzALIJZgzTpPGPjvhy
   7Fc36TnoXy2DdEZ00N8OZfOQgNOeNoswHJWD/WTEFAZxoKmnIdpMXXxbu
   hHbzeEMn0xdT63d3i3kk6ITaOzu2UAgIpIFJllwAPTn4wu9mdtkB5v30o
   8uLlcx286HxQbxM4z2jPBCCPifZLD+LYp1Yta+YJfAn68uH0f+i77WoOW
   md3063pNQoRSIBXt684EpvQhmX05EEi3MrAYbIfH9Lmsd+l5tRC5p2kj+
   EQbbg7L6kX5g5bReAkFGKhZIjKBmPjpJZM2AN/6XRaP0QTNEKS+DeecfF
   w==;
IronPort-SDR: t5kYSW6cPUw2E9ia5RbBCXs+he914Bqrvkg/kS3+Q0297rrMHtigj4uR+KpXz/blN7/3H3e1V0
 J3gVCZJQT7Lf9lJfT2q6g56OYwWmJoVNzBw21dTYFHAiUYFW+KmbfJ7O1SJ9N6zcNVdLF2NnG8
 EeOnLMyROOvcjawyi/v93Bl5I6gksW2ytinmMs19RO8htQwGr5sXxgqj0pjcGiING+CCLLbwHx
 Tf/JgPumH20L+CGIO+ropf1rS1bAreQzbPXyfMgfHYu5tuGuf7UL8jWUvnu7G3PTcweULjjKzw
 Qy8=
X-IronPort-AV: E=Sophos;i="5.78,370,1599494400"; 
   d="scan'208";a="157980294"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Nov 2020 10:00:51 +0800
IronPort-SDR: N/frh/D5Ab3oTITuhLI9JJgkYGjqfeVLBdrBFGKE5IfrNIj99JlWm2jNgNVpda1F20GkHFltQz
 052l23R/ujAMDnaMioYkAvtsVRQ9sN654=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2020 17:46:34 -0800
IronPort-SDR: DuKwAXsKXXIP0xpxYo0xQE7Th1Zk+L/Kbyq0zxOpz/Y1TawYkcKej9+ej4eFYKcBJy+yhX/mJF
 LbMwo54Rftzw==
WDCIronportException: Internal
Received: from 57m2vf2.ad.shared (HELO twashi.fujisawa.hgst.com) ([10.84.71.135])
  by uls-op-cesaip01.wdc.com with ESMTP; 25 Nov 2020 18:00:50 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Cc:     Sean Anderson <seanga2@gmail.com>
Subject: [PATCH v2 0/3] DW apb_ssi V4 support for Kendryte K210 RISC-V SoC
Date:   Thu, 26 Nov 2020 11:00:46 +0900
Message-Id: <20201126020049.35712-1-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The Canaan Kendryte K210 RISC-V SoC includes a DesignWare apb_ssi V4
SPI controller implemented with a maximum data frame size of 32-bits
(SSI_MAX_XFER_SIZE=32 synthesis parameter).

This series of patches adds support for this SoC by implementing support
for the 32-bits xfer size configuration. This is done in patch 1.

Patch 2 introduces a workaround for a HW bug on this SoC which triggers
RX FIFO overrun errors when the RX FIFO fills up to its maximum detected
depth of 32. The patch manually reduces the fifo depth to 31.

Patch 3 documents the new compatible string "canaan,k210-spi" used to
identify this SoC.

Changes from v1:
* Fixed patch 1 as suggested by Serge: change capability flag name to
  DW_SPI_CAP_DFS32 and fixed the capability detection to use the regular
  position of the dfs filed rather than the new position with DFS32.
  Also enable DW_SPI_CAP_DFS32 for SPI slaves.
* Added Serge's Acked-by tag to patch 2 and 3.

Damien Le Moal (3):
  spi: dw: Add support for 32-bits max xfer size
  spi: dw: Add support for the Canaan K210 SoC SPI
  dt-bindings: spi: dw-apb-ssi: Add Canaan K210 SPI controller

 .../bindings/spi/snps,dw-apb-ssi.yaml         |  2 +
 drivers/spi/spi-dw-core.c                     | 44 ++++++++++++++++---
 drivers/spi/spi-dw-mmio.c                     | 16 +++++++
 drivers/spi/spi-dw.h                          |  5 +++
 4 files changed, 60 insertions(+), 7 deletions(-)

-- 
2.28.0

