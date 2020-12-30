Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 013EB2E7A19
	for <lists+linux-spi@lfdr.de>; Wed, 30 Dec 2020 15:59:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726221AbgL3O6S (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 30 Dec 2020 09:58:18 -0500
Received: from relmlor2.renesas.com ([210.160.252.172]:2560 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725853AbgL3O6S (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 30 Dec 2020 09:58:18 -0500
X-IronPort-AV: E=Sophos;i="5.78,461,1599490800"; 
   d="scan'208";a="67272465"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 30 Dec 2020 23:57:26 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id E9791400CA1D;
        Wed, 30 Dec 2020 23:57:24 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Mark Brown <broonie@kernel.org>, Jiri Kosina <trivial@kernel.org>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        Pavel Machek <pavel@denx.de>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 0/2] spi: rpc-if: Trivial fixes
Date:   Wed, 30 Dec 2020 14:57:06 +0000
Message-Id: <20201230145708.28544-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi All,

These patches are trivial fixes for rpc-if SPI driver.

Cheers,
Prabhakar

Lad Prabhakar (2):
  spi: rpc-if: Avoid use of C++ style comments
  spi: rpc-if: Remove CONFIG_PM_SLEEP ifdefery

 drivers/spi/spi-rpc-if.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

-- 
2.17.1

