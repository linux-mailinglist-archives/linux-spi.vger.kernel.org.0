Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0728D4BD4CA
	for <lists+linux-spi@lfdr.de>; Mon, 21 Feb 2022 05:36:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbiBUEd0 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 20 Feb 2022 23:33:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241006AbiBUEdY (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 20 Feb 2022 23:33:24 -0500
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC1041CFDF
        for <linux-spi@vger.kernel.org>; Sun, 20 Feb 2022 20:33:01 -0800 (PST)
Received: from tr.lan (ip-89-176-112-137.net.upcbroadband.cz [89.176.112.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id EEA3B82F5E;
        Mon, 21 Feb 2022 05:32:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1645417979;
        bh=r1QBjT3wGnh9NYJ917En+5d+6QOyFYnCH35Ft4gba1o=;
        h=From:To:Cc:Subject:Date:From;
        b=fwYg6RmmM25gnDqdtDuvCpR1sZ9eZ9MJLUOj50exAj/cpf8yAEFiNTK0FrkS0vx5q
         2FzUf4FyhjZ3tZXbXJZ84P9rJ6lF3kOgx2/7WdP0RxMitFtwQy5/gIVPAez8jlH5AE
         RnXnX9yV4OHPAGlvz67KrrxSJBlC8O5nckoXw+qttG8bqjqcHCUAQ53QNNaqQ5EXiT
         zsNsFbjFxPHy+qoYG721zeFgIy0noLbAOfBTWcdj/Ka4w6MM+O3pmPS+KoQu6A+eEA
         QzwbWSgXT4zTcncrqOUlTTSDA+1sR70IXhZiMRsa989KSyYuiQQohLZDYO3yX3kYNv
         TukTpbLpfwK0Q==
From:   Marek Vasut <marex@denx.de>
To:     linux-spi@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>, Dinh Nguyen <dinguyen@kernel.org>,
        Pratyush Yadav <p.yadav@ti.com>
Subject: [PATCH] [RFC] spi: cadence-quadspi: Disable DAC on SoCFPGA
Date:   Mon, 21 Feb 2022 05:32:38 +0100
Message-Id: <20220221043238.295369-1-marex@denx.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.5 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On SoCFPGA Gen5, DAC memcpy_fromio() in cqspi_direct_read_execute()
leads to data abort, disable DAC to avoid triggering it:

Unhandled fault: imprecise external abort (0x1406) at 0x0400d3e9
[0400d3e9] *pgd=00000000

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Dinh Nguyen <dinguyen@kernel.org>
Cc: Pratyush Yadav <p.yadav@ti.com>
---
 drivers/spi/spi-cadence-quadspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index b808c94641fa6..65f2c2449be09 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1870,7 +1870,7 @@ static const struct cqspi_driver_platdata intel_lgm_qspi = {
 };
 
 static const struct cqspi_driver_platdata socfpga_qspi = {
-	.quirks = CQSPI_NO_SUPPORT_WR_COMPLETION,
+	.quirks = CQSPI_DISABLE_DAC_MODE | CQSPI_NO_SUPPORT_WR_COMPLETION,
 };
 
 static const struct cqspi_driver_platdata versal_ospi = {
-- 
2.34.1

