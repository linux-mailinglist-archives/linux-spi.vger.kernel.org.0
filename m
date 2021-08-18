Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E26153F05D3
	for <lists+linux-spi@lfdr.de>; Wed, 18 Aug 2021 16:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238487AbhHROLg (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 18 Aug 2021 10:11:36 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:49676
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237685AbhHROLf (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 18 Aug 2021 10:11:35 -0400
Received: from localhost (1.general.cking.uk.vpn [10.172.193.212])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id A8DCE40CCD;
        Wed, 18 Aug 2021 14:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1629295851;
        bh=G/MIHNvD6MdN21TmI/GGdS5FVLKTw1VFGnxzch1O72o=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=hS5KjdpwPEmHj9ge/Yxw8bSV9FJs4NIIHk3VGgwrMATFRFM/xpT/bZEVvEPhUoWmt
         JBeKekHTZy/XajcJckInkK8FwpJDL6k7Qi+dFLAv0VQbiM65XDhhTkiGtpkDUXqfwy
         /fpni7Q7J/UBCnCdL9sBGMIYUleC4ioG7CxDOOUxrN9Jav+nU37bShHtQeRxI4v1H8
         MIcaeMniTPTBJjVA+r82SGGDSizfoJlm8YF99eVmVLuswWXaXg6T9XkAVe7ZNy/8on
         uUHnlBHSU96rndoYoFsSyNPfngxkvvXxvpVV7xG35TJvkIS2FkJidCRvuPEseZJXU6
         v2zFXU6OfyJfQ==
From:   Colin King <colin.king@canonical.com>
To:     Mark Brown <broonie@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Chris Morgan <macromorgan@hotmail.com>,
        Jon Lin <jon.lin@rock-chips.com>, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] spi: rockchip-sfc: Fix assigned but never used return error codes
Date:   Wed, 18 Aug 2021 15:10:51 +0100
Message-Id: <20210818141051.36320-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently there are two places where the error return variable ret is
being assigned -ETIMEDOUT on timeout errors and this value is not
being returned. Fix this by returning -ETIMEDOUT rather than redundantly
assiging it to ret.

Addresses-Coverity: ("Unused value")
Fixes: 0b89fc0a367e ("spi: rockchip-sfc: add rockchip serial flash controller")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/spi/spi-rockchip-sfc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-rockchip-sfc.c b/drivers/spi/spi-rockchip-sfc.c
index 7c4d47fe80c2..827e205c5340 100644
--- a/drivers/spi/spi-rockchip-sfc.c
+++ b/drivers/spi/spi-rockchip-sfc.c
@@ -257,7 +257,7 @@ static int rockchip_sfc_wait_txfifo_ready(struct rockchip_sfc *sfc, u32 timeout_
 	if (ret) {
 		dev_dbg(sfc->dev, "sfc wait tx fifo timeout\n");
 
-		ret = -ETIMEDOUT;
+		return -ETIMEDOUT;
 	}
 
 	return (status & SFC_FSR_TXLV_MASK) >> SFC_FSR_TXLV_SHIFT;
@@ -274,7 +274,7 @@ static int rockchip_sfc_wait_rxfifo_ready(struct rockchip_sfc *sfc, u32 timeout_
 	if (ret) {
 		dev_dbg(sfc->dev, "sfc wait rx fifo timeout\n");
 
-		ret = -ETIMEDOUT;
+		return -ETIMEDOUT;
 	}
 
 	return (status & SFC_FSR_RXLV_MASK) >> SFC_FSR_RXLV_SHIFT;
-- 
2.32.0

