Return-Path: <linux-spi+bounces-3003-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB3F8CC391
	for <lists+linux-spi@lfdr.de>; Wed, 22 May 2024 16:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B0461C20D79
	for <lists+linux-spi@lfdr.de>; Wed, 22 May 2024 14:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 340B11AACB;
	Wed, 22 May 2024 14:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="E2ME/nBK"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8676F1C683
	for <linux-spi@vger.kernel.org>; Wed, 22 May 2024 14:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716389587; cv=none; b=mO0PmdQaaT5AvMirixxMjPYH9c+YhmQbRmYDUsd8JiDADHimVGiCm3GtnH0+YJHWchwjoTi4mLBIswrUpVEPuA/DpyiznjjVKNuAkC+eDoRtoLoZhuto6tYiruSn7z/A8WwyxImEPbbrctr8hMXN6GP/31hR2xGCEzBHGMW3QVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716389587; c=relaxed/simple;
	bh=Zrqq3v+gWeA4mFC2n5UPdzePnpObTzWZ1ZYSmifSyYU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pKli0AlGKNLilI7G8gcOT2R1HxkZ/EINVSI9EdbLnVkaH/zl6jDqjChXsG+rIMAIJZcq276fBbi3pjOQV4/4l5EwUkmZlirAC7EfOXXE5zoBKXFR3y5bC38yxMDP3VvDoKEhDwNgvJ7SrIMiMpZVEvmkFwYjlRc7DR8VlciaDOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=E2ME/nBK; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0232E6000B;
	Wed, 22 May 2024 14:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1716389578;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+bST3qn/qVYTYtwFvPSVOnQ/ZhNC2iNknto2WIVA8Qs=;
	b=E2ME/nBKQad0QetS16bfwCcmpGVa37z1yMFCF+8LxPk/pr+OZoqgRNp2AqJQGOYqkhlGS1
	fQiqa9sc5BR+L3ryPWCtI52h9+RBjikmMnslb1EKOR9TeE/N2zX5J+cw9CCA92zmGMNB9G
	4I7rW9DbWGv9FrFFjTuU37BhnDw1SFrlhpISuhHvN8fzhYMuhdZbKel/dp/BGxp8sCqk9N
	Qs0lFC72JmO8lhypgelT25H/4R0odgCW8gGFCPLKGaiATyMFQ1rwvBSsQpQUYUxW9ngVm9
	YvDrDPEMnMQfIh26ew+VinpLvNFtPmkCHRyuUfkG1kldnuYhmlA/tWMJVMWn8w==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Mark Brown <broonie@kernel.org>,
	<linux-spi@vger.kernel.org>
Cc: Serge Semin <fancer.lancer@gmail.com>,
	j.neuschaefer@gmx.net,
	Julien Su <juliensu@mxic.com.tw>,
	Alvin Zhou <alvinzhou@mxic.com.tw>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 3/4] spi: rpc-if: differentiate between unsupported and invalid requests
Date: Wed, 22 May 2024 16:52:54 +0200
Message-Id: <20240522145255.995778-4-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240522145255.995778-1-miquel.raynal@bootlin.com>
References: <20240522145255.995778-1-miquel.raynal@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

If the request is out of range, returning -EINVAL seems a better pick
than -ENOTSUPP.

From a caller (and reviewer) point of view, distinguising between the
two may be helpful because somehow one can be "fixed" while the other
will always be refused no matter how hard we try.

As part of a wider work to bring spi-nand continuous reads, it was
useful to easily catch the upper limit direct mapping boundaries for
each controller, with the idea of enlarging this area from a page to an
eraseblock, without risking too many regressions.

In all other cases, as part of a wider work towards using -EOPNOTSUP
rather than -ENOTSUPP (which is not a SUSV4 code), let's change the
error code to be uniform across spi-mem controller drivers.

Finally, reword a little bit the conditions to clarify what is intended
(ie. checking for the presence of a direct mapping, and also ensuring we
create a dirmap only on DATA_IN flows).

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/spi/spi-rpc-if.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-rpc-if.c b/drivers/spi/spi-rpc-if.c
index e11146932828..d3f07fd719bd 100644
--- a/drivers/spi/spi-rpc-if.c
+++ b/drivers/spi/spi-rpc-if.c
@@ -95,16 +95,16 @@ static int rpcif_spi_mem_dirmap_create(struct spi_mem_dirmap_desc *desc)
 		spi_controller_get_devdata(desc->mem->spi->controller);
 
 	if (desc->info.offset + desc->info.length > U32_MAX)
-		return -ENOTSUPP;
+		return -EINVAL;
 
 	if (!rpcif_spi_mem_supports_op(desc->mem, &desc->info.op_tmpl))
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 
-	if (!rpc->dirmap && desc->info.op_tmpl.data.dir == SPI_MEM_DATA_IN)
-		return -ENOTSUPP;
+	if (!rpc->dirmap)
+		return -EOPNOTSUPP;
 
-	if (desc->info.op_tmpl.data.dir == SPI_MEM_DATA_OUT)
-		return -ENOTSUPP;
+	if (desc->info.op_tmpl.data.dir != SPI_MEM_DATA_IN)
+		return -EOPNOTSUPP;
 
 	return 0;
 }
-- 
2.40.1


