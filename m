Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11B98FA1C7
	for <lists+linux-spi@lfdr.de>; Wed, 13 Nov 2019 03:00:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbfKMB7W (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 12 Nov 2019 20:59:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:53784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730255AbfKMB7U (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 12 Nov 2019 20:59:20 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D5E722470;
        Wed, 13 Nov 2019 01:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573610360;
        bh=mHyJix8TS0iTdx7zM4Zt5aMG7j8CE7oo13sYuj57jpA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X0GBtaj6VmbJC7djbiQjuuPbCS0E+IGRRotLEwrYqxHS2HWNT0e9YmR51veSTTsiK
         kV4lyftXvKXjKuH8fW6zJ5vbSw/fG1A699QjSqBbKaS50IBkJe1TWmvGXwS8yrtidA
         Z/2uXqUzCzThBWOy0ytHmIZ+9U99zOqKJz0AzZDo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Huibin Hong <huibin.hong@rock-chips.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-spi@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH AUTOSEL 4.14 110/115] spi: rockchip: initialize dma_slave_config properly
Date:   Tue, 12 Nov 2019 20:56:17 -0500
Message-Id: <20191113015622.11592-110-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113015622.11592-1-sashal@kernel.org>
References: <20191113015622.11592-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Huibin Hong <huibin.hong@rock-chips.com>

[ Upstream commit dd8fd2cbc73f8650f651da71fc61a6e4f30c1566 ]

The rxconf and txconf structs are allocated on the
stack, so make sure we zero them before filling out
the relevant fields.

Signed-off-by: Huibin Hong <huibin.hong@rock-chips.com>
Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-rockchip.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index fdcf3076681b5..185bbdce62b14 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -445,6 +445,9 @@ static int rockchip_spi_prepare_dma(struct rockchip_spi *rs)
 	struct dma_slave_config rxconf, txconf;
 	struct dma_async_tx_descriptor *rxdesc, *txdesc;
 
+	memset(&rxconf, 0, sizeof(rxconf));
+	memset(&txconf, 0, sizeof(txconf));
+
 	spin_lock_irqsave(&rs->lock, flags);
 	rs->state &= ~RXBUSY;
 	rs->state &= ~TXBUSY;
-- 
2.20.1

