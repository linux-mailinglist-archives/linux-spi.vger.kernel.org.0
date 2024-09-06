Return-Path: <linux-spi+bounces-4702-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C3D96E7F9
	for <lists+linux-spi@lfdr.de>; Fri,  6 Sep 2024 05:05:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8520C1C2279C
	for <lists+linux-spi@lfdr.de>; Fri,  6 Sep 2024 03:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B862018E0E;
	Fri,  6 Sep 2024 03:05:27 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FDC1805A;
	Fri,  6 Sep 2024 03:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725591927; cv=none; b=ZBxL/lOyjmtrpVVjlWdgvFVikvK/GQ3OqyQs0SjGB+VfTFwHBAfvLNFuRERXii9aarqoHjWLmZ4XZYiB5XmMK5gNxHX8eGBIXKbthy56Li4gQkJMdOxcKceAUuLF4l6eq8h5d/QwSrVt6fhCkRCk/Ou46shRgnVSyxbOOx5cULg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725591927; c=relaxed/simple;
	bh=08MN1t4JwNVF3KyyiAFvv1HKZsNkDkDR0aHWV5WGGbs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DJAij8+nhkuqZxhcOhOHOryeGsIELYAWlmFK4uor845TwVlg0ErsHIVJgmRlsWsv6EVMdddgO2pZCylNy3RtSlhdWDlBVjMSVmiUNCamwe5TE4DxBYKPv29MZEHUiu89KKz6+04w4QQnSMAhj5VymSIlh7XN2i03MkyBHj+hBNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4X0LdV02KyzpVVT;
	Fri,  6 Sep 2024 11:03:10 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 2045118006C;
	Fri,  6 Sep 2024 11:05:05 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 6 Sep
 2024 11:05:04 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <broonie@kernel.org>, <vkoul@kernel.org>, <akashast@codeaurora.org>,
	<dianders@chromium.org>, <linux-arm-msm@vger.kernel.org>,
	<linux-spi@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v2 0/2] spi: geni-qcom: Fix incorrect free_irq() sequence
Date: Fri, 6 Sep 2024 11:13:43 +0800
Message-ID: <20240906031345.1052241-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
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

Fix two bugs for geni-qcom.

Changes in v2:
- Split out the device managed cleanup patch.
- PATCH -next -> PATCH
- Also fix the incorrect free_irq() sequence.

Jinjie Ruan (2):
  spi: geni-qcom: Fix incorrect free_irq() sequence
  spi: spi-geni-qcom: Fix missing undo runtime PM changes at driver exit
    time

 drivers/spi/spi-geni-qcom.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

-- 
2.34.1


