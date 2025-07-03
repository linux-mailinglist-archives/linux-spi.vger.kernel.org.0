Return-Path: <linux-spi+bounces-9033-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FCBEAF8053
	for <lists+linux-spi@lfdr.de>; Thu,  3 Jul 2025 20:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FBAD1CA2E97
	for <lists+linux-spi@lfdr.de>; Thu,  3 Jul 2025 18:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83282F4324;
	Thu,  3 Jul 2025 18:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PheJp7dW"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09352F85DA;
	Thu,  3 Jul 2025 18:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751567742; cv=none; b=LubXzN5WgZBqBBqcGtmvuxY0vnZRRPb63UOkKREejgIyKm9cmVl2Uou78V4vnWywtFmhvFv+HSNZt6GggnbEJjuQjLa4awaNEjnU2fD2+q4CE13RlNlMGoHsmTis0vNAD5mR3qdj61f5tY3zFB7zlQ2BhJ+tWEeD2P0+O5n3yaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751567742; c=relaxed/simple;
	bh=IC0AaW5NceEW8wxtKNxGomplDZEXFb+Zwef0eWisnmM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BJUeEvbzZiNPAsXRPP3UcwU3hnlvfPAE7m2TKV4yVgEnldrPmVrJ2AIu/J5IRsHSuLRDIdxaDPnhXVb/+pH9/X2ivxCDHwRFH03ffrtE9v4W0wT5JHdPxU2GfYmRrTkktVUtikaFMg4nxWVHqBS56V6jbAAMDeFVPiy5NC1DqRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PheJp7dW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F4F4C4CEE3;
	Thu,  3 Jul 2025 18:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751567742;
	bh=IC0AaW5NceEW8wxtKNxGomplDZEXFb+Zwef0eWisnmM=;
	h=From:To:Cc:Subject:Date:From;
	b=PheJp7dWH1mp9+0iIi+SIENaoI39JddxSfVd9oADxS2XX9TvHBmG8aVj5XsY99dtU
	 8GAh+dffJIKsFZ87UQTsXNggJL2zVcssdldw1A/BPNtjcUGxZyfkO19lnr+vK3Ranr
	 nVI1qh0IZZ5HuI7yfcgdZeHuio9qskwZ7ooRvlHSgai/C6+YjSFCPthc8wDkg2p19s
	 smvV/H1emWZbk3ie33DnFEt5FzUk2naSynnrHwRE0iNQ20RArlo+bL8Avz5McfVqaJ
	 lzQDY2QlYjYs2khC6a74BnjN/pY7fzWFIhwOD65jbP652AkmRX03pqBcST9M8yjwDc
	 Ub8ed2A0aHHWA==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Mark Brown <broonie@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-spi@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] spi: stm32-ospi: Use of_reserved_mem_region_to_resource() for "memory-region"
Date: Thu,  3 Jul 2025 13:35:37 -0500
Message-ID: <20250703183537.2075746-1-robh@kernel.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the newly added of_reserved_mem_region_to_resource() function to
handle "memory-region" properties.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 drivers/spi/spi-stm32-ospi.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-stm32-ospi.c b/drivers/spi/spi-stm32-ospi.c
index 7c1fa55fbc47..fbf00909b6c5 100644
--- a/drivers/spi/spi-stm32-ospi.c
+++ b/drivers/spi/spi-stm32-ospi.c
@@ -771,7 +771,7 @@ static int stm32_ospi_get_resources(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct stm32_ospi *ospi = platform_get_drvdata(pdev);
-	struct resource *res;
+	struct resource *res, _res;
 	struct reserved_mem *rmem = NULL;
 	struct device_node *node;
 	int ret;
@@ -825,17 +825,13 @@ static int stm32_ospi_get_resources(struct platform_device *pdev)
 			goto err_dma;
 	}
 
-	node = of_parse_phandle(dev->of_node, "memory-region", 0);
-	if (node)
-		rmem = of_reserved_mem_lookup(node);
-	of_node_put(node);
-
-	if (rmem) {
-		ospi->mm_size = rmem->size;
-		ospi->mm_base = devm_ioremap(dev, rmem->base, rmem->size);
+	res = &_res;
+	ret = of_reserved_mem_region_to_resource(dev->of_node, 0, res);
+	if (!ret) {
+		ospi->mm_size = resource_size(res);
+		ospi->mm_base = devm_ioremap_resource(dev, res);
 		if (!ospi->mm_base) {
-			dev_err(dev, "unable to map memory region: %pa+%pa\n",
-				&rmem->base, &rmem->size);
+			dev_err(dev, "unable to map memory region: %pR\n", res);
 			ret = -ENOMEM;
 			goto err_dma;
 		}
-- 
2.47.2


