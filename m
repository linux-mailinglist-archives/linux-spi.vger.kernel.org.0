Return-Path: <linux-spi+bounces-4774-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E4E197400D
	for <lists+linux-spi@lfdr.de>; Tue, 10 Sep 2024 19:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 490EC1F25F72
	for <lists+linux-spi@lfdr.de>; Tue, 10 Sep 2024 17:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1C91C2300;
	Tue, 10 Sep 2024 17:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vONwk5Sa"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A481C1ADB;
	Tue, 10 Sep 2024 17:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725989056; cv=none; b=i81I06BFuvfJVVBsxetq85M6KLDCN1S60MVu8/+oExoeFtTgHw7rYqhjxcXTDnJGhI8je9Dg9lRksXaR1TXgK3wl1A9uJzuHhNcM8HAovsSmkN4s3YnLL0ZHy9ySJc11b4W/0OqDD5BD7+eyzmhbcVkUaCEwzm/RFvr9iXagHxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725989056; c=relaxed/simple;
	bh=/DqDpxTha+8BlyJBOqeC6olLVRpboGcQ2cc7Iep2Y6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dHsOzccG9ICADWmUUNDi8fT3Zoq1ZQHZZjmzLPpN3yZKQD6xRoUJahvhjR4XBSxABBkjbZD/4hgj+Ht05CJ5r88kBIy3ZWCj+5cVvGOeuZBpU7E/8vV86ANmma/4cac3OOsSEJSqAuRSjsrCPk3dz5jRK2uJ+GVgLgg78BFQEs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vONwk5Sa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CA82C4CEC3;
	Tue, 10 Sep 2024 17:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725989055;
	bh=/DqDpxTha+8BlyJBOqeC6olLVRpboGcQ2cc7Iep2Y6Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vONwk5Sauho1X7m2MNE99lhuzix6+hY1IAxKsmEir+lkx8ATtDOisxGNDOA3LWfCO
	 umUbCwKBS2mfrYB0JPDb7uX5chRvuLtzGciv+85+GFXMXYBoPVge4HWNh+SNbk5o94
	 pDDIqF8eHrG9tdP/u56Tf/8sTWX7EfQgagW+SYYz39IUW2Q7RFx2LreH36OxugTKlm
	 1S8UxhGJb/Y7OY4FlxGAKa2mja7yZ4K1f+K0MaeJqYIrWMONXejKd0kCo2wDRvHF7i
	 6vcB7HcERrfHCivqTAxZ6G2LEEmN0jj0tbrHygrL8HqKPXVSEAbvTOlYwt4H16X7xz
	 HPPVrRbz4tBAg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Liao Chen <liaochen4@huawei.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	jonas.gorski@gmail.com,
	linux-spi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 4/4] spi: bcm63xx: Enable module autoloading
Date: Tue, 10 Sep 2024 13:24:03 -0400
Message-ID: <20240910172406.2416588-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240910172406.2416588-1-sashal@kernel.org>
References: <20240910172406.2416588-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.225
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
index d36384fef0d7..5f7eb0e613cd 100644
--- a/drivers/spi/spi-bcm63xx.c
+++ b/drivers/spi/spi-bcm63xx.c
@@ -482,6 +482,7 @@ static const struct of_device_id bcm63xx_spi_of_match[] = {
 	{ .compatible = "brcm,bcm6358-spi", .data = &bcm6358_spi_reg_offsets },
 	{ },
 };
+MODULE_DEVICE_TABLE(of, bcm63xx_spi_of_match);
 
 static int bcm63xx_spi_probe(struct platform_device *pdev)
 {
-- 
2.43.0


