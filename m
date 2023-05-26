Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD3D37127EF
	for <lists+linux-spi@lfdr.de>; Fri, 26 May 2023 16:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237161AbjEZODl (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 26 May 2023 10:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbjEZODl (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 26 May 2023 10:03:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3DEB187
        for <linux-spi@vger.kernel.org>; Fri, 26 May 2023 07:03:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D14365020
        for <linux-spi@vger.kernel.org>; Fri, 26 May 2023 14:03:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1E46C433EF;
        Fri, 26 May 2023 14:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685109818;
        bh=Fy9yAjp/4JgYaosaDGKaLZmL8FOEKKEALySXuAbmXEg=;
        h=From:Date:Subject:To:Cc:From;
        b=uG+7TFWrw7VClgpSHzCS1X4WtQEqTS+4zANhRaIvqvV2KHs/gC4XcoN1OcU7DZuOP
         /spAxMhbCAlAWMB8cOWUYVdyT6xHrVMUQQPcNWFHfzFeDmtKs9wl9mPBd3CbraVziT
         3o1q2TtrJY8TyzXnNP36xuYihmjrUqciZDDXT+k+DfLaJ8VhrBU5PfIXT75itzeU5N
         dd58A2i8iA7B/2ZLjQcSBHydPxCQI9Zm2zJr4WSUKkTYjsKWE4JfUdY1TL3S0wbLD5
         i8i2nUavjSQU6wERalVSulrAGgkhYBSIZn2lJFuYTkm7vxIGuc4xJJL/zNTeagWS9F
         r8gWv6xQDOJYw==
From:   Simon Horman <horms@kernel.org>
Date:   Fri, 26 May 2023 16:03:31 +0200
Subject: [PATCH] spi: imx: correct handling of MXC_CSPIRXDATA value
 endianness
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230526-spi-imx-endian-v1-1-98d4d4ef4afc@kernel.org>
X-B4-Tracking: v=1; b=H4sIADK8cGQC/x2N0QqDMAwAf0XybKBraQf7FdlDa7MZcFEaFEH8d
 8Me7+C4E5Qak8KrO6HRzsqLGDz6DsYpy5eQqzF454OLPqGujPw7kKRyFqzp6aILlGLxYFHJSlh
 alnGyTLZ5Nrk2+vDxvwzv67oBm8ipr3UAAAA=
To:     Mark Brown <broonie@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        jiada wang <jiada_wang@mentor.com>, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Simon Horman <horms@kernel.org>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The existing code seems be intended to handle MXC_CSPIRXDATA values
which are in big endian. However, it seems that this is only
handled correctly in the case where the host is little endian.

First, consider the read case.

	u32 val = be32_to_cpu(readl(...))

readl() will read a 32bit value and return it after applying le32_to_cpu().
On a little endian host le32_to_cpu() is a noop. So the raw value is
returned. This is then converted from big endian to host byte-order -
the value is byte-swapped - using be32_to_cpu(). Assuming the raw value
is big endian a host byte-order value is obtained. This seems correct.

However, on a big endian system, le32_to_cpu() will perform a byte-swap,
while be32_to_cpu() is a noop. Assuming the underlying value is big
endian this is incorrect, because it should not be byte-swapped to
obtain the value in host byte-order - big endian.

Surveying other kernel code it seems that a correct approach is:

	 be32_to_cpu((__force __be32)__raw_readl(...))

Here __raw_readl() does returns the raw value, without any calls
that can alter the byte-order. And be32_to_cpu() is called to correctly
either a) swaps the byte-order on a little endian host or b) does not
swap the byte-order on a big endian host.

Second, let us consider the write case:

	val = cpu_to_be32(val);
	...
	writel(val, ...);

writel() will write the 32bit value, passed as big endian, after applying
cpu_to_le32(). On a little endian system cpu_to_le32() is a noop and
thus the big endian value is stored. This seems correct.

However, on a big endian system cpu_to_le32() will byte-swap the value.
That is, converting it from big endian to little endian. The little
endian value is then stored. This seems incorrect.

Surveying other kernel code it seems that a correct approach is:

	__raw_writel((__force u32)cpu_to_be32(val), ...);

__raw_writel() will write the value with out applying any endian
conversion functions. Thus the big endian value is written.
This seems correct for the case at hand.

This patch adopts the __raw_readl() and __raw_writel() approaches described
above. It also avoids the following, which stores a big endian value in
a host byte-order variable.

	u32 val;
	...
	val = cpu_to_be32(val);

Reported by Sparse as:

  .../spi-imx.c:410:19: warning: cast to restricted __be32
  .../spi-imx.c:439:21: warning: incorrect type in assignment (different base types)
  .../spi-imx.c:439:21:    expected unsigned int [addressable] [usertype] val
  .../spi-imx.c:439:21:    got restricted __be32 [usertype]

Compile tested only.

Fixes: 71abd29057cb ("spi: imx: Add support for SPI Slave mode")
Signed-off-by: Simon Horman <horms@kernel.org>
---
 drivers/spi/spi-imx.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index bd6ddb142b13..99c1f76e073d 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -406,7 +406,10 @@ static void spi_imx_buf_tx_swap(struct spi_imx_data *spi_imx)
 
 static void mx53_ecspi_rx_slave(struct spi_imx_data *spi_imx)
 {
-	u32 val = be32_to_cpu(readl(spi_imx->base + MXC_CSPIRXDATA));
+	u32 val;
+
+	val = be32_to_cpu((__force __be32)__raw_readl(spi_imx->base +
+						      MXC_CSPIRXDATA));
 
 	if (spi_imx->rx_buf) {
 		int n_bytes = spi_imx->slave_burst % sizeof(val);
@@ -435,13 +438,13 @@ static void mx53_ecspi_tx_slave(struct spi_imx_data *spi_imx)
 	if (spi_imx->tx_buf) {
 		memcpy(((u8 *)&val) + sizeof(val) - n_bytes,
 		       spi_imx->tx_buf, n_bytes);
-		val = cpu_to_be32(val);
 		spi_imx->tx_buf += n_bytes;
 	}
 
 	spi_imx->count -= n_bytes;
 
-	writel(val, spi_imx->base + MXC_CSPITXDATA);
+	__raw_writel((__force u32)cpu_to_be32(val),
+		     spi_imx->base + MXC_CSPITXDATA);
 }
 
 /* MX51 eCSPI */

