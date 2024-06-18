Return-Path: <linux-spi+bounces-3431-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D027E90D2D9
	for <lists+linux-spi@lfdr.de>; Tue, 18 Jun 2024 15:54:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 042C01C23F99
	for <lists+linux-spi@lfdr.de>; Tue, 18 Jun 2024 13:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3C115B126;
	Tue, 18 Jun 2024 13:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="783wEJQ0"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D3B15B116;
	Tue, 18 Jun 2024 13:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718717444; cv=none; b=mmpfE7a/cbApgT90n/8EGiCimvqwijeICVlD/iaZrKWKkU8peinDfGBUYuypeOVQqzHGN+UPsqljDAxBcyRkvJmzcpVNYJp2Ihe5nqpYiweehzCc79W+UVjZd6kxm3MMZ7N6sblxWnvfsPWuaMukHRxqtmEHNLWg56RzixEFj40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718717444; c=relaxed/simple;
	bh=3Ku7tt0x0btNh8Wd88wUPxBrwTQbJyMIjIf/cX2NEwo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VyYPsij+qVN4pIoqLyMmtg6YZ7n25akhEmNJ8Kb1Rmu9A0SnCcjjm2krYG+0rs3MsTUU2ng59NsGdemP+q8aOjsuQ+gnwkK5PRpB68ZWJn1wWIn/pDXdmnXVna3atucWxqULp2BkLX8auUs5483L7fuxnQoDHwEgiq1/l3pqRh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=783wEJQ0; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45IAQ9b4022142;
	Tue, 18 Jun 2024 15:30:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=selector1; bh=11DwoO2SWX8eyBwLh+xLeu
	RA7wZ4nhz85Dd9E+yYocs=; b=783wEJQ0aDuSD566NOC+elkNLZSaRBKE+g+HWr
	3fZ3QtqkAZlac6oCfEq/pKh/VyCPMQv5XeMYdbn6CEMxL7dQ709Mhh6rKjvnpS5/
	SmVepiMBuD5ScHT/AM4NoTbFOzAcydfoi9rDSs9d+FImL88fKAZbckcF/lrpWBAj
	1zIfx/p3i64+3brjUUWonY6z+bIpdqSqFfcLyrbgIMA1E8hcCoGriQqwDohusSeR
	JGJgHywLADt2CSWMH+XbhwIC+Qj/5/co9HLbmCNj/j79j9OWj4prfqO7vAiTwjdj
	4TvqPJcMM7SndjnjzSFOMbz1r2q6+I/8wodYYeh1xhqnn5dA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ys1ucueju-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 15:30:22 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 416A240044;
	Tue, 18 Jun 2024 15:30:16 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5EFF7218624;
	Tue, 18 Jun 2024 15:29:55 +0200 (CEST)
Received: from localhost (10.48.87.62) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 18 Jun
 2024 15:29:55 +0200
From: <patrice.chotard@foss.st.com>
To: Mark Brown <broonie@kernel.org>
CC: <linux-spi@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <christophe.kerello@foss.st.com>, <patrice.chotard@foss.st.com>
Subject: [PATCH 0/3] spi: OCTAL mode fixes
Date: Tue, 18 Jun 2024 15:29:48 +0200
Message-ID: <20240618132951.2743935-1-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SAFCAS1NODE2.st.com (10.75.90.13) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_02,2024-06-17_01,2024-05-17_01

From: Patrice Chotard <patrice.chotard@foss.st.com>

During tests performed using spidev_test in OCTAL mode with spi-stm32-qspi.c,
several issues has been found :
  _ OCTAL mode wasn't supported in spi.c
  _ CCR register wasn't set correctly when OCTAL mode is set in spi-stm32-qspi.c.
  _ Fix dual flash mode sanity test in spi-stm32-qspi.c

Patrice Chotard (3):
  spi: stm32: qspi: Fix dual flash mode sanity test in
    stm32_qspi_setup()
  spi: stm32: qspi: Clamp stm32_qspi_get_mode() output to CCR_BUSWIDTH_4
  spi: add OCTAL mode support

 drivers/spi/spi-stm32-qspi.c | 12 +++++-------
 drivers/spi/spi.c            |  6 ++++--
 include/linux/spi/spi.h      |  5 +++--
 3 files changed, 12 insertions(+), 11 deletions(-)

-- 
2.25.1


