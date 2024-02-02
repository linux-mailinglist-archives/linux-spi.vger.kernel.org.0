Return-Path: <linux-spi+bounces-985-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D62846F82
	for <lists+linux-spi@lfdr.de>; Fri,  2 Feb 2024 12:53:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E0541F28760
	for <lists+linux-spi@lfdr.de>; Fri,  2 Feb 2024 11:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA6C13D50E;
	Fri,  2 Feb 2024 11:53:42 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from tux.runtux.com (tux.runtux.com [176.9.82.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B292113D4F7;
	Fri,  2 Feb 2024 11:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.82.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706874822; cv=none; b=fcgd2yR3Lrs1/62VcT9ccAuyS3B+JbP8NsRToNlGuroDgK6EJ2jP4nUtGzVAzpKstXw5utAW24wugp9is6zcZDUS20mmxE94cjGKxTVvZsS/KAyjV2yx9qgY9npE4/Ik8ryOakhNu8J9Hd2y6PUi9T6V5QigTuPTXVqIq2YiOkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706874822; c=relaxed/simple;
	bh=jQIfwxFoKOkcBPKJK6tyu/de2q5LnbkqHpinptTj9HA=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=eyatf5t4omJs4fJUlqgImQNWXEG93TY+Lnao5OV7UO0UluhvssjmRlVYGUXSSu5+1G33xCYn9WdM0X4clHv3w1rCSd0aUfiJxFn1qn4LO3hNNKnXZzxhwLo6EDN7HY94OckiUuo5Lbnl9ZxsXWA2aBZxRDKtp/xpMivCS0Pa+Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=runtux.com; spf=pass smtp.mailfrom=runtux.com; arc=none smtp.client-ip=176.9.82.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=runtux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runtux.com
Received: from localhost (localhost [127.0.0.1])
	by tux.runtux.com (Postfix) with ESMTP id 7AC3B6EF56;
	Fri,  2 Feb 2024 12:53:32 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at tux.runtux.com
Received: from tux.runtux.com ([127.0.0.1])
	by localhost (tux2.runtux.com [127.0.0.1]) (amavisd-new, port 10026)
	with LMTP id TqhPD8BT3CxP; Fri,  2 Feb 2024 12:53:31 +0100 (CET)
Received: from bee.priv.zoo (62-99-217-90.static.upcbusiness.at [62.99.217.90])
	(Authenticated sender: postmaster@runtux.com)
	by tux.runtux.com (Postfix) with ESMTPSA id 453346EF4C;
	Fri,  2 Feb 2024 12:53:31 +0100 (CET)
Received: by bee.priv.zoo (Postfix, from userid 1002)
	id BD3AD469; Fri,  2 Feb 2024 12:53:30 +0100 (CET)
Date: Fri, 2 Feb 2024 12:53:30 +0100
From: Ralf Schlatterbeck <rsc@runtux.com>
To: Mark Brown <broonie@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>, linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] spi-mxs: Fix chipselect glitch
Message-ID: <20240202115330.wxkbfmvd76sy3a6a@runtux.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ray: beware
User-Agent: NeoMutt/20180716

There was a change in the mxs-dma engine that uses a new custom flag.
The change was not applied to the mxs spi driver.
This results in chipselect being deasserted too early.
This fixes the chipselect problem by using the new flag in the mxs-spi
driver.

Fixes: ceeeb99cd821 ("dmaengine: mxs: rename custom flag")
Signed-off-by: Ralf Schlatterbeck <rsc@runtux.com>
---
For oscilloscope screenshots and a verbose explanation see my blog post
at https://blog.runtux.com/posts/2024/02/01/
History:
Omit the line break change from patch requested by Marc Kleine-Budde
<mkl@pengutronix.de>

 drivers/spi/spi-mxs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mxs.c b/drivers/spi/spi-mxs.c
index 1bf080339b5a..88cbe4f00cc3 100644
--- a/drivers/spi/spi-mxs.c
+++ b/drivers/spi/spi-mxs.c
@@ -39,6 +39,7 @@
 #include <linux/spi/spi.h>
 #include <linux/spi/mxs-spi.h>
 #include <trace/events/spi.h>
+#include <linux/dma/mxs-dma.h>
 
 #define DRIVER_NAME		"mxs-spi"
 
@@ -252,7 +253,7 @@ static int mxs_spi_txrx_dma(struct mxs_spi *spi,
 		desc = dmaengine_prep_slave_sg(ssp->dmach,
 				&dma_xfer[sg_count].sg, 1,
 				(flags & TXRX_WRITE) ? DMA_MEM_TO_DEV : DMA_DEV_TO_MEM,
-				DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+				DMA_PREP_INTERRUPT | MXS_DMA_CTRL_WAIT4END);
 
 		if (!desc) {
 			dev_err(ssp->dev,
-- 
2.20.1

-- 
Dr. Ralf Schlatterbeck                  Tel:   +43/2243/26465-16
Open Source Consulting                  www:   www.runtux.com
Reichergasse 131, A-3411 Weidling       email: office@runtux.com

