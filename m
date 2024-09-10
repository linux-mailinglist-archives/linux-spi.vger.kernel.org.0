Return-Path: <linux-spi+bounces-4767-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9D44973F70
	for <lists+linux-spi@lfdr.de>; Tue, 10 Sep 2024 19:27:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E34428E72F
	for <lists+linux-spi@lfdr.de>; Tue, 10 Sep 2024 17:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D3EE1B1411;
	Tue, 10 Sep 2024 17:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OtPTB1PR"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D676F1AED2C;
	Tue, 10 Sep 2024 17:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725988966; cv=none; b=TfijeMV+4jMaO5iGdqWrSTSlw6Ygjx95Uq6T7reLAAV6bqcqCz7dsvnrqsXBCmVpv6rsq74hFe3BXRNIQ+dZ294flKDTJr/EBIqESEYtOW/SssaS/5g/k/mnF1jwmbdzu/VLsOcFcgrUZMIZco1+Nz4MyZF2irkwClTee/7l1Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725988966; c=relaxed/simple;
	bh=e2tc6dMsibvZBEjNYuaCibjzo2V5qPZvSbfwtJr5LfI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sCx1ASxHCRKoVoyLXDb1DgIOvS6gNt6+YDEhKw4dtHlrtWyz5+f8hFzLIgYinLCG5QrSvR+No2Yk0vEaz5jMeW5rReDnan27+rNILl3V0ALzRFUJXGzZ3zn1YLNLBAxx48IvXRPzI3XEZ5TRItPMIIfDmH6BooU5mQV9zyrn6Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OtPTB1PR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7566C4CED4;
	Tue, 10 Sep 2024 17:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725988966;
	bh=e2tc6dMsibvZBEjNYuaCibjzo2V5qPZvSbfwtJr5LfI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OtPTB1PR9pEvqknl9PFBQHivt3YH8sDgx9BE/w4bs96pCSpU4h7gZDIO7QB9v1vQa
	 V84Ftbow8+AuXsI0PJtjvZVGmjZ09RTT8wY8SboKIfrni4P6XAbZvCOGGPt4UNrAKw
	 LHmWDxjC6mBgEQO+AlT9ZTDz6XkT64bN5UY4TGBAxjSbhIwEgpaVbCRkHCWplfPkIB
	 J4p+exsECmuf2iQl1K2jXKS0T/pOITItUFDIC/upGacsa2s9tv289I9nbKwchZ3HV6
	 7QtThA/qHnW8tzARo3YAxblMmwtHSL7KN0ReGtH9Ao3blMtJOL4R7ypW04t2c5q8AH
	 9QWlgwEsnPlkw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Liao Chen <liaochen4@huawei.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	jonas.gorski@gmail.com,
	linux-spi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 14/18] spi: bcm63xx: Enable module autoloading
Date: Tue, 10 Sep 2024 13:21:59 -0400
Message-ID: <20240910172214.2415568-14-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240910172214.2415568-1-sashal@kernel.org>
References: <20240910172214.2415568-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.9
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
index aac41bd05f98..2fb8d4e55c77 100644
--- a/drivers/spi/spi-bcm63xx.c
+++ b/drivers/spi/spi-bcm63xx.c
@@ -472,6 +472,7 @@ static const struct of_device_id bcm63xx_spi_of_match[] = {
 	{ .compatible = "brcm,bcm6358-spi", .data = &bcm6358_spi_reg_offsets },
 	{ },
 };
+MODULE_DEVICE_TABLE(of, bcm63xx_spi_of_match);
 
 static int bcm63xx_spi_probe(struct platform_device *pdev)
 {
-- 
2.43.0


