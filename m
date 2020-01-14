Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7FF13ADF5
	for <lists+linux-spi@lfdr.de>; Tue, 14 Jan 2020 16:46:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbgANPq1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 14 Jan 2020 10:46:27 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:36367 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbgANPq0 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 14 Jan 2020 10:46:26 -0500
Received: from mwalle01.sab.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id F0EF622F54;
        Tue, 14 Jan 2020 16:46:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1579016784;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=L/5pDwGZbj6GR9oEQi1uXOUKGfs66wphp2lm7VKi6uE=;
        b=BWLoroo8D/Gz43X6laSOsgvYokIjzevwp5IpfXZW62ged+4AnURg+2ofM/saYcVKGgHofb
        2AepK1rBvBXug8qT0wZAwpLz/Ps8uVWnCyPOCsYPVMZkL9ZG/YrXeYSwOuiccBUDeIwehU
        C+uCE34dHzPqV1KWrb62yot2YdChUE4=
From:   Michael Walle <michael@walle.cc>
To:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Cc:     Han Xu <han.xu@nxp.com>, Mark Brown <broonie@kernel.org>,
        Yogesh Gaur <yogeshnarayan.gaur@nxp.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH] spi: spi-fsl-qspi: Ensure width is respected in spi-mem operations
Date:   Tue, 14 Jan 2020 16:46:13 +0100
Message-Id: <20200114154613.8195-1-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ++++
X-Spam-Level: ****
X-Rspamd-Server: web
X-Spam-Status: No, score=4.90
X-Spam-Score: 4.90
X-Rspamd-Queue-Id: F0EF622F54
X-Spamd-Result: default: False [4.90 / 15.00];
         ARC_NA(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         BROKEN_CONTENT_TYPE(1.50)[];
         DKIM_SIGNED(0.00)[];
         RCPT_COUNT_SEVEN(0.00)[8];
         MID_CONTAINS_FROM(1.00)[];
         NEURAL_HAM(-0.00)[-0.903];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:12941, ipnet:213.135.0.0/19, country:DE]
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Make use of a core helper to ensure the desired width is respected
when calling spi-mem operators.

Otherwise only the SPI controller will be matched with the flash chip,
which might lead to wrong widths. Also consider the width specified by
the user in the device tree.

Fixes: 84d043185dbe ("spi: Add a driver for the Freescale/NXP QuadSPI controller")
Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/spi/spi-fsl-qspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-qspi.c b/drivers/spi/spi-fsl-qspi.c
index 79b1558b74b8..e8a499cd1f13 100644
--- a/drivers/spi/spi-fsl-qspi.c
+++ b/drivers/spi/spi-fsl-qspi.c
@@ -410,7 +410,7 @@ static bool fsl_qspi_supports_op(struct spi_mem *mem,
 	    op->data.nbytes > q->devtype_data->txfifo)
 		return false;
 
-	return true;
+	return spi_mem_default_supports_op(mem, op);
 }
 
 static void fsl_qspi_prepare_lut(struct fsl_qspi *q,
-- 
2.20.1

