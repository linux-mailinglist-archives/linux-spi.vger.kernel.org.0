Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95B5F2D12F8
	for <lists+linux-spi@lfdr.de>; Mon,  7 Dec 2020 15:02:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbgLGOBn (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 7 Dec 2020 09:01:43 -0500
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:64961 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbgLGOBm (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 7 Dec 2020 09:01:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1607349702; x=1638885702;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Ms+4paR+HDAhOiISnEPDdfUAZJphPvdvvNfaStExDY8=;
  b=ICb1zrHM5xQLaEGBfclkOFNLhwfAn9zD++OM3aelZI8cO9jaKOx3Se36
   gXpQBxXHgRoC7/vPT6uutU+8N9SXZVP8m8lxmFY47rSZRjYYLJVupH6As
   D9ZMsd2Ans9XExONJrFtQPf3Gnij7Bx2psvzG9wJr0EdXlYu0VomPMMI9
   0rAYNANhoG8KWbyDWsz02mYoYcmY3Lgb+eO2JOtRyC5Cpbg69YgnmkS9x
   79U2xnVU9NG284+yeC5YiPz6We6KC7bLs6xn7BNEtlm167tbdgQBAk5iS
   Qx49/ac5oTO3qPN4wwmc77xciUTJZj4Y3uLmiNTejLwfWVdS2Gd76sSjt
   Q==;
IronPort-SDR: dE9nllveeeY16U5gkycSZri5cdfZOA00uFfI3Fk/oVdaoEvtQbjjiigi6gUzmBY9vUL9DfWW7V
 7eoHQjtVAnyR05qOXVQu00lWP+7EB79yLDlSPAN+4Y2j5pa/OjumGDyw0RzrMm7EAw+8yRa5Wg
 4IJVXOFqNzuCKPBRCpO1dNDyIXG3F7XScfxGQEb9N2b9vEyMRejOHASo+B252A7nNbiEdAjrGQ
 RYEj5xcUZKEA7XemCyTAaa/umw5DVpSYwhbjT7vmDy+3OwK1FETjnqFAmDrGxny6At13Jhrycz
 Ffk=
X-IronPort-AV: E=Sophos;i="5.78,399,1599548400"; 
   d="scan'208";a="96128931"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Dec 2020 07:00:36 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 7 Dec 2020 07:00:36 -0700
Received: from atudor-ThinkPad-T470p.amer.actel.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Mon, 7 Dec 2020 07:00:33 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <broonie@kernel.org>, <linux-spi@vger.kernel.org>
CC:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <bugalski.piotr@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        "Tudor Ambarus" <tudor.ambarus@microchip.com>
Subject: [PATCH 0/4] spi: atmel-quadspi: Fix AHB memory accesses
Date:   Mon, 7 Dec 2020 15:59:55 +0200
Message-ID: <20201207135959.154124-1-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Starting with the move of the atmel-quadspi driver under SPI,
the following error could be seen when mounting a 16MByte ubifs:
UBIFS error (ubi0:0 pid 1893): check_lpt_type.constprop.6: invalid type (15) in LPT node type

1/4 fixes AHB accesses. The rest of the patches are small optimizations.
Tested on both sama5d2 and sam9x60.

Tudor Ambarus (4):
  spi: atmel-quadspi: Fix AHB memory accesses
  spi: atmel-quadspi: Drop superfluous set of QSPI_IFR_APBTFRTYP_READ
  spi: atmel-quadspi: Write QSPI_IAR only when needed
  spi: atmel-quadspi: Move common code outside of if else

 drivers/spi/atmel-quadspi.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

-- 
2.25.1

