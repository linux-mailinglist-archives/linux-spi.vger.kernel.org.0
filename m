Return-Path: <linux-spi+bounces-3000-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A008CC38E
	for <lists+linux-spi@lfdr.de>; Wed, 22 May 2024 16:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6442C1C20B81
	for <lists+linux-spi@lfdr.de>; Wed, 22 May 2024 14:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991C81CAA6;
	Wed, 22 May 2024 14:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kkHEfkgR"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC01A18645
	for <linux-spi@vger.kernel.org>; Wed, 22 May 2024 14:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716389586; cv=none; b=t6NQl+1nDr2m9ImgqWEK3lYo0DR0m2NsdAi4m9whM3VKNm0nRbG+BiNUb50iSOHsrodZf/ynyqT4QNOJHOYw4TtB5+UaDD5Xk4kKY3CF3Nbt9KI5eSa1La9pQzCR7FtoKfoyAJxb27P3i78DNLo+2CgOvXGp18IAPesIO+0+vqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716389586; c=relaxed/simple;
	bh=cHsLDnIFM6cGXLl/mTrYK0SMWcluyeiGdD9kJN8/Tys=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SYzMpRIaHeMxwJwn482FNtz7yq7gNZyKJj9vyFZTp9RN/xiBTmqew8GsMnpa56UFM8EHMPRz68sW+msnyZCWkbBr+z2ZJaDIYshrTlP+8ZO2pGI1rBNR0xwjoMhdtJH2Kia2/AYbxAeDypwPGp8fUA6TpR+MGBDBrLQF5FpZEgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kkHEfkgR; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 14A9B60007;
	Wed, 22 May 2024 14:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1716389577;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yiJ8+52qzPzJhiZXAoVRGuwroXBLtuhBrnUsdkuLofI=;
	b=kkHEfkgRcSejbG46aRF34vUmzBfcI79bApNfNfQhGhIh15giaJsOa+Fssmypvhve+SJ+kv
	g8OmNBmChkqqjQQffgZ4UVICfuddVM4TW5r3TXK2EVmajXopGhuaECRj05hne77XGieskp
	U6iyIshtZ3v442IX/14mfVj2BgkyqsYcFqz6AjPh8xqmzG3wbGjRstR/BKufO7Xu64/kzX
	wXJRj8NggpUPyT2fqKYK97fing8wppcU/5XcsmeKA64SJMl7iLhbPH1JFwI2+BPZaTiOnh
	U0BwlB2QQzI7BcAfcC/gmm8yNBdz7D8woZilhI9zVvUDk/Q5F6bNOrjS03A+bA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Mark Brown <broonie@kernel.org>,
	<linux-spi@vger.kernel.org>
Cc: Serge Semin <fancer.lancer@gmail.com>,
	j.neuschaefer@gmx.net,
	Julien Su <juliensu@mxic.com.tw>,
	Alvin Zhou <alvinzhou@mxic.com.tw>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 1/4] spi: dw: differentiate between unsupported and invalid requests
Date: Wed, 22 May 2024 16:52:52 +0200
Message-Id: <20240522145255.995778-2-miquel.raynal@bootlin.com>
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

The driver does not support dirmap write operations, return -EOPTNOTSUPP
in this case.

Most controllers have a maximum linear mapping area. Requests beyond
this limit can be considered invalid, rather than unsupported.

From a caller (and reviewer) point of view, distinguising between the
two may be helpful because somehow one can be "fixed" while the other
will always be refused no matter how hard we try.

As part of a wider work to bring spi-nand continuous reads, it was
useful to easily catch the upper limit direct mapping boundaries for
each controller, with the idea of enlarging this area from a page to an
eraseblock, without risking too many regressions.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/spi/spi-dw-bt1.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-dw-bt1.c b/drivers/spi/spi-dw-bt1.c
index 5391bcac305c..4577e8096cd9 100644
--- a/drivers/spi/spi-dw-bt1.c
+++ b/drivers/spi/spi-dw-bt1.c
@@ -55,13 +55,15 @@ static int dw_spi_bt1_dirmap_create(struct spi_mem_dirmap_desc *desc)
 	    !dwsbt1->dws.mem_ops.supports_op(desc->mem, &desc->info.op_tmpl))
 		return -EOPNOTSUPP;
 
+	if (desc->info.op_tmpl.data.dir != SPI_MEM_DATA_IN)
+		return -EOPNOTSUPP;
+
 	/*
 	 * Make sure the requested region doesn't go out of the physically
-	 * mapped flash memory bounds and the operation is read-only.
+	 * mapped flash memory bounds.
 	 */
-	if (desc->info.offset + desc->info.length > dwsbt1->map_len ||
-	    desc->info.op_tmpl.data.dir != SPI_MEM_DATA_IN)
-		return -EOPNOTSUPP;
+	if (desc->info.offset + desc->info.length > dwsbt1->map_len)
+		return -EINVAL;
 
 	return 0;
 }
-- 
2.40.1


