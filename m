Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53F452E7A1C
	for <lists+linux-spi@lfdr.de>; Wed, 30 Dec 2020 15:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbgL3O6j (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 30 Dec 2020 09:58:39 -0500
Received: from relmlor2.renesas.com ([210.160.252.172]:2560 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726161AbgL3O6j (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 30 Dec 2020 09:58:39 -0500
X-IronPort-AV: E=Sophos;i="5.78,461,1599490800"; 
   d="scan'208";a="67272482"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 30 Dec 2020 23:57:48 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 5AA4740065C6;
        Wed, 30 Dec 2020 23:57:46 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Mark Brown <broonie@kernel.org>, Jiri Kosina <trivial@kernel.org>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        Pavel Machek <pavel@denx.de>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 1/2] spi: rpc-if: Avoid use of C++ style comments
Date:   Wed, 30 Dec 2020 14:57:07 +0000
Message-Id: <20201230145708.28544-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201230145708.28544-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20201230145708.28544-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Replace C++ style comment with C style.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/spi/spi-rpc-if.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-rpc-if.c b/drivers/spi/spi-rpc-if.c
index 3579675485a5..bf64da322e67 100644
--- a/drivers/spi/spi-rpc-if.c
+++ b/drivers/spi/spi-rpc-if.c
@@ -1,11 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0
-//
-// RPC-IF SPI/QSPI/Octa driver
-//
-// Copyright (C) 2018 ~ 2019 Renesas Solutions Corp.
-// Copyright (C) 2019 Macronix International Co., Ltd.
-// Copyright (C) 2019 - 2020 Cogent Embedded, Inc.
-//
+/*
+ * RPC-IF SPI/QSPI/Octa driver
+ *
+ * Copyright (C) 2018 ~ 2019 Renesas Solutions Corp.
+ * Copyright (C) 2019 Macronix International Co., Ltd.
+ * Copyright (C) 2019 - 2020 Cogent Embedded, Inc.
+ */
 
 #include <linux/module.h>
 #include <linux/platform_device.h>
-- 
2.17.1

