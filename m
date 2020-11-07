Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7E02AA376
	for <lists+linux-spi@lfdr.de>; Sat,  7 Nov 2020 09:14:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728058AbgKGIOy (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 7 Nov 2020 03:14:54 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:57208 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727801AbgKGIOy (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 7 Nov 2020 03:14:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1604736893; x=1636272893;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LAnvTxuCrxiYwbhYLblxFRB980/m85EFlvtWJ9EMVlc=;
  b=AvNRiFUi/g0J+eQMYJhslS3zYVtEWLyGrjIbPYtF1ifpqUII//WJxMWa
   q/CTnJmaJ2miZ3fbNvcBGP9ARxsq9BOmjnuRdy3b1YZsMsLk3rRiclXyn
   F8qTPfF+O8qdKcfXJlT6vMtRrDhB1D3kRafVvQUV+MOqBMSZ5I/GwPwIN
   nv1i/EhWZLXdbn4dzcTVkCAEI2Z/FDOuhYW/Vf4LDX5caRx3YCxNf9q/V
   A+1uiQjZ8kthqaN3lEqSAsAA/f8o7k3vHFsfUOMD5V5b70p2JehrRGCUv
   WaeB4z+GFE2amBr/E50qc9kAbKVXI1vXA197npyovMtaFSKI6gywpUEe7
   g==;
IronPort-SDR: iQHLhyxSnAQ6UbZTXVbbCWX5CmobaHM5YT2+wrEwPygC6wjBqCqXtDzAu59U0WTH0GgI1pgaEA
 Kdjo7MH7FNhIJ4EVsjenaJTC1XCsF85FXFcpCd50JG80afHUPGaRwSdS7L7y3jjFiGuc/cJQzt
 YjcQM01k8c6J13dgaE626H1n4s+z3ix44Yx97uMgKF0npRb2aoMvVRzZs6154Pew2hbmd0f27f
 vAlSjGdMZePq2G54YJh4HEiCB52gb2iUrCRBmiEpw4PfRAG6xE9r21+3rcoJmN8qTk84XyxsM5
 ISA=
X-IronPort-AV: E=Sophos;i="5.77,459,1596470400"; 
   d="scan'208";a="156564380"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Nov 2020 16:14:53 +0800
IronPort-SDR: DlrFS8IZ00iaxHHXk2zhRAyNoaJnndD2Yq+UKdGOWZuQ6boj3VYnXnhQv+pNawar+QnGe+pvQ6
 XD0yiK3wCFTwK4e64mXcGy+ewY2ThGnqsPCxGFpk/HCn8YkGBuBsGbwbah4O5ErTCUlBzw/7R/
 aBYmSuvXNOD0zGZuim9LJOB00uEhJ9iLwwgoSqjIr964gIFAttGzdO97DP3SfM7MM+z4xnH2x9
 ylpve1luyKkS0ACZYO5OvSfw/Wz53tAk4CH2+Jt2GvuK8WrIOlchwND8493tYvXLBD1P3AwL5O
 X1NQ44MUmh5wBcTGEJBw3drj
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2020 23:59:44 -0800
IronPort-SDR: fT23JgunU722jRduFvljIERP725lvkEaBUxXqos8amCUHUNMsIduVaQQXwkSxtHAaC+rJkBUv8
 IvTev3D8aeVnB4NxdarvBXucISWuB6ZyoMelBOI2ZIojCbT8rhZKjGN7NqrhDY08NzgXuj1dZD
 BfR5vSeXRdYSz4gjqPEL39VpTt4d3XqZT2b6fs4l9qpgWZna7a0KhuWToPbyg9xfVGxKP4wwS6
 IqL+0nQc6LEjj7EJY7/K0WPS4cmWaTD7UVxP2dOVC1SbZZb0hVOVPGcXAUU1iB90e3fxudnB3D
 vtg=
WDCIronportException: Internal
Received: from hdrdzf2.ad.shared (HELO twashi.fujisawa.hgst.com) ([10.84.71.85])
  by uls-op-cesaip01.wdc.com with ESMTP; 07 Nov 2020 00:14:51 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Sean Anderson <seanga2@gmail.com>
Subject: [PATCH 11/32] riscv: Enable interrupts during syscalls with M-Mode
Date:   Sat,  7 Nov 2020 17:13:59 +0900
Message-Id: <20201107081420.60325-12-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201107081420.60325-1-damien.lemoal@wdc.com>
References: <20201107081420.60325-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

When running is M-Mode (no MMU config), MPIE does not get set. This
results in all syscalls being executed with interrupts disabled as
handle_exception never sets SR_IE as it always sees SR_PIE being
cleared. Fix this by always force enabling interrupts in
handle_syscall when CONFIG_RISCV_M_MODE is enabled.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 arch/riscv/kernel/entry.S | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index 524d918f3601..080eb8d78589 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -155,6 +155,15 @@ skip_context_tracking:
 	tail do_trap_unknown
 
 handle_syscall:
+#ifdef CONFIG_RISCV_M_MODE
+	/*
+	 * When running is M-Mode (no MMU config), MPIE does not get set.
+	 * As a result, we need to force enable interrupts here because
+	 * handle_exception did not do set SR_IE as it always sees SR_PIE
+	 * being cleared.
+	 */
+	csrs CSR_STATUS, SR_IE
+#endif
 #if defined(CONFIG_TRACE_IRQFLAGS) || defined(CONFIG_CONTEXT_TRACKING)
 	/* Recover a0 - a7 for system calls */
 	REG_L a0, PT_A0(sp)
-- 
2.28.0

