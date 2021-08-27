Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54D123F93F3
	for <lists+linux-spi@lfdr.de>; Fri, 27 Aug 2021 07:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbhH0FMu (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 27 Aug 2021 01:12:50 -0400
Received: from mail.manjaro.org ([116.203.91.91]:58616 "EHLO mail.manjaro.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229645AbhH0FMt (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 27 Aug 2021 01:12:49 -0400
X-Greylist: delayed 455 seconds by postgrey-1.27 at vger.kernel.org; Fri, 27 Aug 2021 01:12:49 EDT
From:   Tobias Schramm <t.schramm@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
        t=1630040663;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=CCGe3l7vX7fN0xeU/nOfzM7VX7yQ/ff/as6wuEAK9KE=;
        b=LjpDAzCiCaVwFIh4DfutFmxf9GqvTbwqKiyGitq+ye1tCOhDH8F9LPEGW0zDNbCvM07E9z
        eyRekW34kHW87+7Nt6LDGMn12tDeIYrVYd81jt9swNaHFBKgA/56hIJ3uiDDO5n0oZ+OIB
        F4riSGuyThtwOGfIFVKyOgKhA6UHtr3q0ZmjEeOjnZoKYUEnU3F7vK//V6UAwGGDprdv/f
        gIsukLETAWJNgwTx8rZcJuwCCa2mA7Jhm46pBPvqkeArOvMFmdX+Dib2l/dDm4qbpSwsNl
        maIlDaZjL2Yejpn1YVV68XA5HsE9hEwIAbOe/2IoyO/rFOBYyIfUbRm1ofFpUA==
To:     linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Tobias Schramm <t.schramm@manjaro.org>
Subject: [PATCH] spi: rockchip: handle zero length transfers without timing out
Date:   Fri, 27 Aug 2021 07:03:57 +0200
Message-Id: <20210827050357.165409-1-t.schramm@manjaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=t.schramm@manjaro.org smtp.mailfrom=t.schramm@manjaro.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Previously zero length transfers submitted to the Rokchip SPI driver would
time out in the SPI layer. This happens because the SPI peripheral does
not trigger a transfer completion interrupt for zero length transfers.

Fix that by completing zero length transfers immediately at start of
transfer.

Signed-off-by: Tobias Schramm <t.schramm@manjaro.org>
---
 drivers/spi/spi-rockchip.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 540861ca2ba3..553b6b9d0222 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -600,6 +600,12 @@ static int rockchip_spi_transfer_one(
 	int ret;
 	bool use_dma;
 
+	/* Zero length transfers won't trigger an interrupt on completion */
+	if (!xfer->len) {
+		spi_finalize_current_transfer(ctlr);
+		return 1;
+	}
+
 	WARN_ON(readl_relaxed(rs->regs + ROCKCHIP_SPI_SSIENR) &&
 		(readl_relaxed(rs->regs + ROCKCHIP_SPI_SR) & SR_BUSY));
 
-- 
2.33.0

