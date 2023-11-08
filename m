Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A29CB7E5C06
	for <lists+linux-spi@lfdr.de>; Wed,  8 Nov 2023 18:12:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232462AbjKHRL7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 8 Nov 2023 12:11:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232467AbjKHRL6 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 8 Nov 2023 12:11:58 -0500
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 58D721BC3;
        Wed,  8 Nov 2023 09:11:56 -0800 (PST)
X-IronPort-AV: E=Sophos;i="6.03,286,1694703600"; 
   d="scan'208";a="182203703"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 09 Nov 2023 02:11:55 +0900
Received: from localhost.localdomain (unknown [10.226.92.247])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 23204402E572;
        Thu,  9 Nov 2023 02:11:51 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Mark Brown <broonie@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Michael Walle <michael@walle.cc>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>, linux-spi@vger.kernel.org,
        linux-mtd@lists.infradead.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Biju Das <biju.das.au@gmail.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH RFC 0/4] Add set_iofv() callback
Date:   Wed,  8 Nov 2023 17:11:45 +0000
Message-Id: <20231108171149.258656-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

As per section 8.14 on the AT25QL128A hardware manual[1],
IO0..IO3 must be set to Hi-Z state for this flash for fast read quad IO.
Snippet from HW manual section 8.14:
The upper nibble of the Mode(M7-4) controls the length of the next FAST
Read Quad IO instruction through the inclusion or exclusion of the first
byte instruction code. The lower nibble bits of the Mode(M3-0) are don't
care. However, the IO pins must be high-impedance before the falling edge
of the first data out clock.

Add set_iofv() callback for configuring IO fixed values to control the
pin state.

[1]
https://www.renesas.com/eu/en/document/dst/at25ql128a-datasheet?r=1608586

Ref:
 https://patchwork.kernel.org/project/linux-renesas-soc/patch/20230830145835.296690-1-biju.das.jz@bp.renesas.com/

Biju Das (4):
  spi: spi-mem: Add set_iofv() callback
  mtd: spi-nor: Add post_sfdp() callback
  memory: renesas-rpc-if: Add support for overriding IO fixed values
  spi: rpc-if: Add set_iofv() callback

 drivers/memory/renesas-rpc-if.c | 20 ++++++++++++++++++++
 drivers/mtd/spi-nor/core.c      | 20 ++++++++++++++++++++
 drivers/spi/spi-mem.c           | 20 ++++++++++++++++++++
 drivers/spi/spi-rpc-if.c        |  9 +++++++++
 include/linux/spi/spi-mem.h     |  4 ++++
 include/memory/renesas-rpc-if.h |  1 +
 6 files changed, 74 insertions(+)

-- 
2.25.1

