Return-Path: <linux-spi+bounces-7908-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D6CAAADF2
	for <lists+linux-spi@lfdr.de>; Tue,  6 May 2025 04:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 950111BC020A
	for <lists+linux-spi@lfdr.de>; Tue,  6 May 2025 02:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C3FB29CB34;
	Mon,  5 May 2025 22:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iSVn8joi"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1F7359E00;
	Mon,  5 May 2025 22:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484978; cv=none; b=Ho8dAstlMz5HRnoFJesWarukPOY+eDCkSMJ2czD0UN15fTFbMwFUah2117y4BZw7ObQk0dDae4TAQvrbMbTtvB5ocRENhJenCwU2svH8EwTkvJ7OKrtVOcdaAr9CVsgkSydqvGggg1NC+CPjAzbQPE/4ZVJpLenEucdYqDQcoCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484978; c=relaxed/simple;
	bh=kjAsViGtHjStfVoskh40kOGVqPEkltRf6p3137feQjU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aUqxxMS9/9HTebUsOZdlSMs5/UZiGHW6crZ2aES+kU9X+HbhtmsQmvJapSVYZoY47x6I0nNyaPyaWwt+lK4/CNss/qTfRpdjbUZLJFKMj8VlgtUQ1wyCkRmfpNNbcOF7gpCpF5gOpGxOG7pC3grL81wk+MIk5P30XeF12LZ9DnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iSVn8joi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01DFEC4CEE4;
	Mon,  5 May 2025 22:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484978;
	bh=kjAsViGtHjStfVoskh40kOGVqPEkltRf6p3137feQjU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iSVn8joiEkDsoF2EXGVJpdGNfzOh4cIf07pPYv5yZFU8/c9bA4e4Quac5jTMDXUpV
	 dQAB8gC8irpkNFYeREESyfbDrqvt/QK2jhlwwQ7SWd/WFlgqcd3MI4eM84dwiXfnDH
	 vOP5RlhGowkyO/r+B1j4AVa42fxpuJHQ/IZtqB7q7NQ6UGfiOVtM7wD/Wiggl3BMB+
	 ZSc1QopTQY+qlSiwPlapm9RRpfS1W5arhtYiCuOdMUmhhrwQ0Uc+LePw3oxYqfXAcD
	 iaH+bELdS5qIVZGCV92pPTZyw8H3NPuyygFWfWu7RZZKtn6nie7zvI6C/k+3OJps50
	 zGttlCnRBgngQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sergio Perez Gonzalez <sperezglz@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-spi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 108/486] spi: spi-mux: Fix coverity issue, unchecked return value
Date: Mon,  5 May 2025 18:33:04 -0400
Message-Id: <20250505223922.2682012-108-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit

From: Sergio Perez Gonzalez <sperezglz@gmail.com>

[ Upstream commit 5a5fc308418aca275a898d638bc38c093d101855 ]

The return value of spi_setup() is not captured within
spi_mux_select() and it is assumed to be always success.

CID: 1638374

Signed-off-by: Sergio Perez Gonzalez <sperezglz@gmail.com>
Link: https://patch.msgid.link/20250316054651.13242-1-sperezglz@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-mux.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/spi/spi-mux.c b/drivers/spi/spi-mux.c
index c02c4204442f5..0eb35c4e3987e 100644
--- a/drivers/spi/spi-mux.c
+++ b/drivers/spi/spi-mux.c
@@ -68,9 +68,7 @@ static int spi_mux_select(struct spi_device *spi)
 
 	priv->current_cs = spi_get_chipselect(spi, 0);
 
-	spi_setup(priv->spi);
-
-	return 0;
+	return spi_setup(priv->spi);
 }
 
 static int spi_mux_setup(struct spi_device *spi)
-- 
2.39.5


