Return-Path: <linux-spi+bounces-3004-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D618CC392
	for <lists+linux-spi@lfdr.de>; Wed, 22 May 2024 16:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DE42281BAD
	for <lists+linux-spi@lfdr.de>; Wed, 22 May 2024 14:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6083D1C683;
	Wed, 22 May 2024 14:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VFi3MRDk"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2271C6A8
	for <linux-spi@vger.kernel.org>; Wed, 22 May 2024 14:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716389588; cv=none; b=OC032NXpIdZJGEttkXuyEBAd++cUMWylfWTwALbt1LPNNUemQHsLesLV777bmIj2V8vrVGp3c+Y9S8UXjIIc7iDaFhzHOxb+L6DFn+HgPj35DSMARyROpY2UhXkyM014rk4r4qrbSCKB946kHg2UV3cAwSdSEzARUII5+ZJ3WbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716389588; c=relaxed/simple;
	bh=AgUSMnmGCua8oGCi0zoty5SNG3aQYMN/dZBvaLMxVgM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nMyWkJxu8esXxfO/qvZByvdEPqGGvO+/U6J4dOoT0AvXemBfTZmrUN9TQ41GPe7FhkCJWQ2x16tAoTrg3Z7kEuPDmIjCHZU2yw6IoBvVdpSvokfdf7CmIpeBYzRwaFsEdMpgtgE92AZTUQ1uwfOOxCHFkZ5rzah7GaOB+Pyefjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VFi3MRDk; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7FE1B6000C;
	Wed, 22 May 2024 14:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1716389578;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SJS15LpTyO/Mn6MuShtlvqeOX+2BEpSp812b1sn4VxQ=;
	b=VFi3MRDkJkFQen464eqe54iZRppSMPUB9ZxU+WjE4aob924s9BQkPqwjLCWfuGzVCPkZA8
	aafySvnd4tcpPkIWoUiHwC0QLbBBhg1czNJ2+JGZ37ezTEZ2T2SfQ3S2BsjY4ol/PJ4F5M
	DcHznmcBsZD05+mNOpf+8WbxdW4RES91uxTJgKtWbdUg8gJwcwus0veC85ZuXo0D/3P43b
	Hs6oeX3yC4z+SvjI25Be6eiyap1oi+91iFo46tt8+tJpzYilEL/R/nae9ZPIy5Cq+5aYnG
	29rdtLzpiOTQKzbHNYKVFtlbPciFjt//cIOSzqrmWRy+GIROgTFVHhn9hg9Abw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Mark Brown <broonie@kernel.org>,
	<linux-spi@vger.kernel.org>
Cc: Serge Semin <fancer.lancer@gmail.com>,
	j.neuschaefer@gmx.net,
	Julien Su <juliensu@mxic.com.tw>,
	Alvin Zhou <alvinzhou@mxic.com.tw>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 4/4] spi: wpcm-fiu: differentiate between unsupported and invalid requests
Date: Wed, 22 May 2024 16:52:55 +0200
Message-Id: <20240522145255.995778-5-miquel.raynal@bootlin.com>
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

When the requested dirmap accesses are outside of the window, it is
probably more sensible to return -EINVAL rather than an "unsupported"
error code. If however the operation in itself is not supported, then
-EOPNOTSUP is likely going to be preferred as it is a standard error
code.

From a caller (and reviewer) point of view, distinguising between the
two may be helpful because somehow one can be "fixed" while the other
will always be refused no matter how hard we try.

As part of a wider work to bring spi-nand continuous reads, it was
useful to easily catch the upper limit direct mapping boundaries for
each controller, with the idea of enlarging this area from a page to an
eraseblock, without risking too many regressions.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/spi/spi-wpcm-fiu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-wpcm-fiu.c b/drivers/spi/spi-wpcm-fiu.c
index 6b16a22cc3a4..886d6d7771d4 100644
--- a/drivers/spi/spi-wpcm-fiu.c
+++ b/drivers/spi/spi-wpcm-fiu.c
@@ -378,7 +378,7 @@ static int wpcm_fiu_dirmap_create(struct spi_mem_dirmap_desc *desc)
 	int cs = spi_get_chipselect(desc->mem->spi, 0);
 
 	if (desc->info.op_tmpl.data.dir != SPI_MEM_DATA_IN)
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 
 	/*
 	 * Unfortunately, FIU only supports a 16 MiB direct mapping window (per
@@ -387,11 +387,11 @@ static int wpcm_fiu_dirmap_create(struct spi_mem_dirmap_desc *desc)
 	 * flashes that are bigger than 16 MiB.
 	 */
 	if (desc->info.offset + desc->info.length > MAX_MEMORY_SIZE_PER_CS)
-		return -ENOTSUPP;
+		return -EINVAL;
 
 	/* Don't read past the memory window */
 	if (cs * MAX_MEMORY_SIZE_PER_CS + desc->info.offset + desc->info.length > fiu->memory_size)
-		return -ENOTSUPP;
+		return -EINVAL;
 
 	return 0;
 }
-- 
2.40.1


