Return-Path: <linux-spi+bounces-4776-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F1E974021
	for <lists+linux-spi@lfdr.de>; Tue, 10 Sep 2024 19:37:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 731841C255F1
	for <lists+linux-spi@lfdr.de>; Tue, 10 Sep 2024 17:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01B391C245C;
	Tue, 10 Sep 2024 17:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Se9lb/OH"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF501A7057;
	Tue, 10 Sep 2024 17:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725989072; cv=none; b=In+/BT5NCOF9lv8g5tRsN1ZYwHOO8kwqMJg9Y7+mN5SW5t90u67PFGv5hKAPhTlwbyIOdtROlX/sQQoeu3lsHCNU4IRFhYv0pxGAhsMrpoVMOMnm0ihgBXURHwmvd8RBqnxUe1pO85L2bUPg72XpQVkno+WusEOOWKEDC9G89L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725989072; c=relaxed/simple;
	bh=3NvaHKb9WogLwvnmAoyAcdDRv3uRbIMWWexXQwncPJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YqDyER/3n14E+XoFM8Jh8N2wgF+t8B5d9bmAPxK2y/2VhoT44zOl8jO7qrFhuaGAn/slPpLae9+pVarXveAMWWOCuQ3+x6i5W28p3nPf+jW2ORtef2umQpek4CZJhd2c3PDJyeo1m+urryGA68TAbp4QUL0zXaAzZ5IN05+AKtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Se9lb/OH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60490C4CECC;
	Tue, 10 Sep 2024 17:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725989070;
	bh=3NvaHKb9WogLwvnmAoyAcdDRv3uRbIMWWexXQwncPJ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Se9lb/OHeYOoh3Y0fiujcZYk9Q7jfwv7dt8YNm7y3odZ6lopv6x8+l5hHIzx5rVpt
	 yXRpCd6xZVndT8rrVwVB3dZzyPQu7V6a2Z3QY5i7u0ax2CGxwkQlTyC1kHyM3aI+Cp
	 LYZ/e8sxmTImRlu/Iq8OL9juyiQoaxZKgwWlKMAl9tqpzErgvnW2T7ScHxpOVn1Aod
	 7Ax7s2eqisRekBPOU93dp9ZY9P60LZ4FvpC3T+984tW5JlHrMWQcUB11cY4pziaTYw
	 aZfQpBPy4+sg2Ly5efOSLVjSvFdLptTR7DwT4nabxsMTgKsz/gxLBMJu8Ys8U5lpiM
	 1zftecCODwn8A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Liao Chen <liaochen4@huawei.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	jonas.gorski@gmail.com,
	linux-spi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 2/2] spi: bcm63xx: Enable module autoloading
Date: Tue, 10 Sep 2024 13:24:24 -0400
Message-ID: <20240910172426.2416764-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240910172426.2416764-1-sashal@kernel.org>
References: <20240910172426.2416764-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.321
Content-Transfer-Encoding: 8bit

From: Liao Chen <liaochen4@huawei.com>

[ Upstream commit 709df70a20e990d262c473ad9899314039e8ec82 ]

Add MODULE_DEVICE_TABLE(), so modules could be properly autoloaded based
on the alias from of_device_id table.

Signed-off-by: Liao Chen <liaochen4@huawei.com>
Link: https://patch.msgid.link/20240831094231.795024-1-liaochen4@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-bcm63xx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-bcm63xx.c b/drivers/spi/spi-bcm63xx.c
index cc6ec3fb5bfd..d57a75a5ab37 100644
--- a/drivers/spi/spi-bcm63xx.c
+++ b/drivers/spi/spi-bcm63xx.c
@@ -490,6 +490,7 @@ static const struct of_device_id bcm63xx_spi_of_match[] = {
 	{ .compatible = "brcm,bcm6358-spi", .data = &bcm6358_spi_reg_offsets },
 	{ },
 };
+MODULE_DEVICE_TABLE(of, bcm63xx_spi_of_match);
 
 static int bcm63xx_spi_probe(struct platform_device *pdev)
 {
-- 
2.43.0


