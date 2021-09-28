Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C24841AFA2
	for <lists+linux-spi@lfdr.de>; Tue, 28 Sep 2021 15:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240754AbhI1NIy (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 28 Sep 2021 09:08:54 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:56344
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235776AbhI1NIx (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 28 Sep 2021 09:08:53 -0400
Received: from localhost (1.general.cking.uk.vpn [10.172.193.212])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 28D7C4061B;
        Tue, 28 Sep 2021 13:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632834433;
        bh=sGY7Qk4KcbrHyazPvJZjW+y6B7rLp37BeJ+kWs3fZ8M=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=jcqI0MW/i6xhUVMiDhXqY8Betc1Q9w4wBhqzoXVN6b3Tz+YmdOa45FgIHhjPYi4Pe
         XwlHkLZ8jhv5Ib0QpCqb4n1zaXWfwRGrxl6WS0qUD89CNyna1DIvZlc9SlCUduO9xp
         z+kORrBH1ZH9dGhF6ScXQ88C0QyRKpTEbr2yAVhlh7oKtHB70Zd3Yx//BstaREMj11
         h2wA8TEjMnql0JaKlbF6cfkrQ5h7OxiPyb3UQ54poNk8bbq+REFiM/xIAwMzpEQ43v
         RcQY9eZJTKyj2KswVfyDpfnvbHELdjhjh66xf6BECH+Hh6SePhpmh05nVIxeGsT0OA
         5+U8Vy3ONAt5g==
From:   Colin King <colin.king@canonical.com>
To:     Parshuram Thombare <pthombar@cadence.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] spi: cadence: Fix spelling mistake "nunber" -> "number"
Date:   Tue, 28 Sep 2021 14:07:12 +0100
Message-Id: <20210928130712.990474-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in a dev_err error message. Fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/spi/spi-cadence-xspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-cadence-xspi.c b/drivers/spi/spi-cadence-xspi.c
index a2a94675292d..3401fcf49f4a 100644
--- a/drivers/spi/spi-cadence-xspi.c
+++ b/drivers/spi/spi-cadence-xspi.c
@@ -308,7 +308,7 @@ static int cdns_xspi_controller_init(struct cdns_xspi_dev *cdns_xspi)
 	hw_magic_num = FIELD_GET(CDNS_XSPI_MAGIC_NUM, ctrl_ver);
 	if (hw_magic_num != CDNS_XSPI_MAGIC_NUM_VALUE) {
 		dev_err(cdns_xspi->dev,
-			"Incorrect XSPI magic nunber: %x, expected: %x\n",
+			"Incorrect XSPI magic number: %x, expected: %x\n",
 			hw_magic_num, CDNS_XSPI_MAGIC_NUM_VALUE);
 		return -EIO;
 	}
-- 
2.32.0

