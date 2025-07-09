Return-Path: <linux-spi+bounces-9074-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC69DAFDD4F
	for <lists+linux-spi@lfdr.de>; Wed,  9 Jul 2025 04:16:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9274F7B57CA
	for <lists+linux-spi@lfdr.de>; Wed,  9 Jul 2025 02:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209B8208CA;
	Wed,  9 Jul 2025 02:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NYuBtwUR"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2AB7FD;
	Wed,  9 Jul 2025 02:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752027405; cv=none; b=NrknK7qUXs8q9KedfdC6Hw5euEv4oaDOnSeswks+25soNR+V2ieaMHvYpUg8dFG3QSepeiyVXn64lp0Nze9gBQ4PQW2SassYZQRjlgLHosif4Xyo83FuJiTdWVJ/TKOfYH+7zIvOjnwssEx+yvT5g9u6bfoEDscA0gri9sY0Jt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752027405; c=relaxed/simple;
	bh=W34gJZJ0Sfv42p0qrt0l9Q2E2RvLRp6jugQiTNTywbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KS88aDEFcyGMmXjf2qbgBrGn8jciT13M8nqJTdU6O0AJ7knFsXiBouoitufFD+hgNHvcwymJ0Ky1MvyMIQ9IqLAivm12riXpeAbu/QViBjAZ0/WEzOKLJ9gnKGBe87sl2K99l2etq+pFxVfBmFR4QsSSHfeErTxvjeDac0HPCfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NYuBtwUR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73F00C4CEED;
	Wed,  9 Jul 2025 02:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752027404;
	bh=W34gJZJ0Sfv42p0qrt0l9Q2E2RvLRp6jugQiTNTywbQ=;
	h=From:To:Cc:Subject:Date:From;
	b=NYuBtwURYidvFrxE2AGzKqfUZEwQg0sXZHw9tBkUQqrEGAg5kj/AB3C8AlscQh32C
	 Gg53ryOb/isxZK9bck+A3vH+ri0b6mZWiroR5GCMknrmp9Ejnge7Cq7iW1rOsaj8TM
	 3vIvhYp6t0TEMpwfhq22KtJmK1xOA1Bo3VUFiQkCSUUBmjUlwBTRJEWtEX46peQHoe
	 As7yzZWmW24q4FB5mE7Lm0QvRCGAce5DJwHDMyEm1pqXeUHEwsIZSdxShKj1RKfA1U
	 3o7GLzCue1reKRq2PTYr1wl4zfIpZ53k1Y1kqOvFR6f0dvkgnlMlx6rsXoYxsJ+pag
	 +GMqZeG2WrOyw==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Mark Brown <broonie@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-spi@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] spi: stm32-ospi: Use of_reserved_mem_region_to_resource() for "memory-region"
Date: Tue,  8 Jul 2025 21:16:37 -0500
Message-ID: <20250709021638.2047365-1-robh@kernel.org>
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
v2:
 - Fix unused variable warnings
---
 drivers/spi/spi-stm32-ospi.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/spi/spi-stm32-ospi.c b/drivers/spi/spi-stm32-ospi.c
index 7c1fa55fbc47..4753e02a7d2f 100644
--- a/drivers/spi/spi-stm32-ospi.c
+++ b/drivers/spi/spi-stm32-ospi.c
@@ -771,9 +771,7 @@ static int stm32_ospi_get_resources(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct stm32_ospi *ospi = platform_get_drvdata(pdev);
-	struct resource *res;
-	struct reserved_mem *rmem = NULL;
-	struct device_node *node;
+	struct resource *res, _res;
 	int ret;
 
 	ospi->regs_base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
@@ -825,17 +823,13 @@ static int stm32_ospi_get_resources(struct platform_device *pdev)
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


