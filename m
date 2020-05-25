Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74B4E1E0F83
	for <lists+linux-spi@lfdr.de>; Mon, 25 May 2020 15:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388794AbgEYNbf (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 25 May 2020 09:31:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:44966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388737AbgEYNbf (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 25 May 2020 09:31:35 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB5A42078B;
        Mon, 25 May 2020 13:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590413495;
        bh=UkqhXu9EJmYN2x4IC2FaMn2Jq7MbeHmdM2N/fexFtsU=;
        h=From:To:Cc:Subject:Date:From;
        b=CInfonX+apQkbkDvlMkDLF+H+i5aylFK0t/knONKfJi8bgWOAGy2g5KkHG1lxwQCM
         O9ZTVElrKyTfvacyhhHdt4hmoYZCkU5x4klcQMKpr68iVPfuP5JUGYKaitVXrSguls
         Jnb2GlY516TsQ/fFPAxxW14LcqvUw5ZcMJHj/cdo=
From:   Mark Brown <broonie@kernel.org>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH] spi: Remove note about transfer limit for spi_write_then_read()
Date:   Mon, 25 May 2020 14:31:20 +0100
Message-Id: <20200525133120.57273-1-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Originally spi_write_then_read() used a fixed statically allocated
buffer which limited the maximum message size it could handle.  This
restriction was removed a while ago so that we could dynamically
allocate a buffer if required but the kerneldoc was not updated to
reflect this, do so.

Reported-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index c69d23379e08..a6f3f1ae72d7 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -3869,8 +3869,7 @@ static u8	*buf;
  * is zero for success, else a negative errno status code.
  * This call may only be used from a context that may sleep.
  *
- * Parameters to this routine are always copied using a small buffer;
- * portable code should never use this for more than 32 bytes.
+ * Parameters to this routine are always copied using a small buffer.
  * Performance-sensitive or bulk transfer code should instead use
  * spi_{async,sync}() calls with dma-safe buffers.
  *
-- 
2.20.1

