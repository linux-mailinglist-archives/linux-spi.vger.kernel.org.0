Return-Path: <linux-spi+bounces-4701-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 492BA96E7F8
	for <lists+linux-spi@lfdr.de>; Fri,  6 Sep 2024 05:05:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 751651C2336F
	for <lists+linux-spi@lfdr.de>; Fri,  6 Sep 2024 03:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22CF21E521;
	Fri,  6 Sep 2024 03:05:13 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4C41805A;
	Fri,  6 Sep 2024 03:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725591913; cv=none; b=uzJaVGtD+cWjDmyUU9tgbXnVonIQ20hb1AxRPBlmwO++4YE2/0kTh22W4P3mNgRkncOyR5XNeOSVLrHUQQzA3E9vH5M1zwa/dzI/ALtygpea74KiQoWmrtpPno2JH5B/9Rm4LzzFk1je24GiAOs+la7X8rmWmP+3IOmqEqG8W5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725591913; c=relaxed/simple;
	bh=Fdv+w29R/nLYtuDB1xKL+1ml1Pu8ghfL8QFNKu/rYPk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WEr0OZ9qnyKFdoqsbTE1CDhyDsiWLEULh1ftdtZk5152wJKsHA0cOBBoYgCvvUDx/IZHIgJFpVcUSVLClpIXIzjLsOee21IdRgmKMh0bAgauM4oiTbCQwFnFex3mlgbn6dPUUuvzE5OpnhUFvDpPWPQAwSNEzt7Kf5wjE5g7wqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4X0LYy6WYcz20nZt;
	Fri,  6 Sep 2024 11:00:06 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id CCC9C1402CD;
	Fri,  6 Sep 2024 11:05:05 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 6 Sep
 2024 11:05:05 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <broonie@kernel.org>, <vkoul@kernel.org>, <akashast@codeaurora.org>,
	<dianders@chromium.org>, <linux-arm-msm@vger.kernel.org>,
	<linux-spi@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v2 2/2] spi: spi-geni-qcom: Fix missing undo runtime PM changes at driver exit time
Date: Fri, 6 Sep 2024 11:13:45 +0800
Message-ID: <20240906031345.1052241-3-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240906031345.1052241-1-ruanjinjie@huawei.com>
References: <20240906031345.1052241-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemh500013.china.huawei.com (7.202.181.146)

It's important to undo pm_runtime_use_autosuspend() with
pm_runtime_dont_use_autosuspend() at driver exit time unless driver
initially enabled pm_runtime with devm_pm_runtime_enable()
(which handles it for you).

Hence, call pm_runtime_dont_use_autosuspend() at driver exit time
to fix it.

Fixes: cfdab2cd85ec ("spi: spi-geni-qcom: Set an autosuspend delay of 250 ms")
---
v2:
- Fix it directly instead of use devm_pm_runtime_enable().
---
 drivers/spi/spi-geni-qcom.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index fc2819effe2d..38857edbc785 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -1158,6 +1158,7 @@ static int spi_geni_probe(struct platform_device *pdev)
 spi_geni_release_dma:
 	spi_geni_release_dma_chan(mas);
 spi_geni_probe_runtime_disable:
+	pm_runtime_dont_use_autosuspend(dev);
 	pm_runtime_disable(dev);
 	return ret;
 }
@@ -1174,6 +1175,7 @@ static void spi_geni_remove(struct platform_device *pdev)
 
 	spi_geni_release_dma_chan(mas);
 
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 }
 
-- 
2.34.1


