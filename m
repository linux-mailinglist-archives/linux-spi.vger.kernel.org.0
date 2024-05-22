Return-Path: <linux-spi+bounces-3002-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 161118CC390
	for <lists+linux-spi@lfdr.de>; Wed, 22 May 2024 16:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C014F28195E
	for <lists+linux-spi@lfdr.de>; Wed, 22 May 2024 14:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3408118645;
	Wed, 22 May 2024 14:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="GNx5SFn0"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867A91C694
	for <linux-spi@vger.kernel.org>; Wed, 22 May 2024 14:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716389587; cv=none; b=VKvNpBfboQ8W3EfQaqeSB1d0NuYKYiiPo/QL4ZyAh+VzN/y8q5GcP95UfT1C5z6Ikz5sLK+uA0XDq08RcfY4IJURHJIjJh/+okNV13wXLfybUIJEGsv2WSN/ZQhUj8X73z1fNaKr2G4tnAer5QC9e5OpkCdEVzSERt6hMyEp8vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716389587; c=relaxed/simple;
	bh=mEnTvtAtNzZxsg2CVtceiOZ1xONw8v+MdMWLL5+Pmg0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C0s67QOfYD+WKgQA2PGwrUXJW0wT/2clo+kgP+rbcoJJDGtmVNGnF6/0+l8ajGVdc3BMNGajkpmVELj8YSiBo+mx5Zo44xzGI3vy99hqO+IzfucQTFKBOQBindXSiwr/EZf/IS14BxTM9KiwRdEvF5Hyq7fVQcFUbybBfPlJfJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=GNx5SFn0; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8046260009;
	Wed, 22 May 2024 14:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1716389577;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IRQfo211pDzLhnjQrRk/5xMC5CrZJdpHPQsiNLKisI0=;
	b=GNx5SFn0dzrqKTH2GadTmU1XS/hDzQNPapcf87tP2+Qe+d3mpb0jhaFwZL9boDq2n/IZLz
	taQteEWYP2hPm3X021W4kbAfLB78A1nwLVf8EvQQW3TO5sIiN9iF7EOH2bb1DeqXv0znLX
	ZWG5X8/9XxENQPQi4BChfCrV/h1YLMYHwzFShKuKQRYxZzP32ORVP6opwnmUw2Hu8Roq4+
	UAx1gAmvzIUqZTQmvJ4i2KJ7XNZTpfkz6FRzIVfFl1g7fJoAxXlBb2ekt90PYkJ6tvfUa8
	fGKsRGs8sKQfsQxkU9ZufgD7RDwVzCM5Bx7eRNZbO26qlAeaYzwrAYebxnifNw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Mark Brown <broonie@kernel.org>,
	<linux-spi@vger.kernel.org>
Cc: Serge Semin <fancer.lancer@gmail.com>,
	j.neuschaefer@gmx.net,
	Julien Su <juliensu@mxic.com.tw>,
	Alvin Zhou <alvinzhou@mxic.com.tw>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 2/4] spi: mxic: differentiate between unsupported and invalid requests
Date: Wed, 22 May 2024 16:52:53 +0200
Message-Id: <20240522145255.995778-3-miquel.raynal@bootlin.com>
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

If the request is out of range, returning -EINVAL seems
sensible. However if there is no direct mapping available (which is a
possible case), no direct mapping will ever be allowed, hence -EOPNOTSUP
is probably more relevant in this case.

From a caller (and reviewer) point of view, distinguising between the
two may be helpful because somehow one can be "fixed" while the other
will always be refused no matter how hard we try.

As part of a wider work to bring spi-nand continuous reads, it was
useful to easily catch the upper limit direct mapping boundaries for
each controller, with the idea of enlarging this area from a page to an
eraseblock, without risking too many regressions.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/spi/spi-mxic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mxic.c b/drivers/spi/spi-mxic.c
index 60c9f3048ac9..6156d691630a 100644
--- a/drivers/spi/spi-mxic.c
+++ b/drivers/spi/spi-mxic.c
@@ -496,7 +496,7 @@ static int mxic_spi_mem_dirmap_create(struct spi_mem_dirmap_desc *desc)
 	struct mxic_spi *mxic = spi_controller_get_devdata(desc->mem->spi->controller);
 
 	if (!mxic->linear.map)
-		return -EINVAL;
+		return -EOPNOTSUPP;
 
 	if (desc->info.offset + desc->info.length > U32_MAX)
 		return -EINVAL;
-- 
2.40.1


