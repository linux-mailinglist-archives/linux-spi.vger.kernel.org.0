Return-Path: <linux-spi+bounces-3429-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C9F290D2DA
	for <lists+linux-spi@lfdr.de>; Tue, 18 Jun 2024 15:54:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEF84282210
	for <lists+linux-spi@lfdr.de>; Tue, 18 Jun 2024 13:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D331153561;
	Tue, 18 Jun 2024 13:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="8TeIvVgh"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D9515B119;
	Tue, 18 Jun 2024 13:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718717443; cv=none; b=Ct1Ac7sCABlnGmrBKRmTb7L41L1gPUKl9W0Kpsrm2YJoS/YH8iK2NwyQdBAHd9Xn7nP983uLJSUC1OF6uiPiMsVXmGzktkUUnPjw7gya3HN8NiuYckyZusH1mP+D8hgdGyYGFsR3zNqEqTyXtkYPSkfQBY7kkssihbvFKfszjoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718717443; c=relaxed/simple;
	bh=I1uR7bFT74dm1I0GAHYXffDIHqO3EuykCypmGOZlOnI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dBCa9iwA6GiPYLdyfNud48kiaKkyeIPJdcyziuqhXctc1/LHh/8DUDIg/gL0K1kf9gipTQ7QZ6k4EtXGnuAgzOSTIR+zMBB3TcIpWm84BaI+BKALF3xuoJjsSXy22eAp5jmSXGJkbqzMdFpPxwyNHSQQpRwE1hZGz7UEYMRUA3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=8TeIvVgh; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45IAH8wh004229;
	Tue, 18 Jun 2024 15:30:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	IBFo4NrFdnbxxz+8CwZSbwc83Ry8OyJ9RuDGb1//7a8=; b=8TeIvVghPTAok+Ix
	1t9upPJRrMhlDfab1gqCWCS8p1Xmi1GJR7i2mr5PKk78otLrbNF3oGc9Eme8T7lo
	SAi6TxqHRQbAnKYvPbkjGT11M5f/mv8FRQc9B4dS61TbkRZ/5Ffrt1MKpQDLZYFt
	2NWPE/SujbugQ1GJPrF+RGpiMBwEZVpCFEu4GlC9NBkIrXa8EC944RJPPTvEsP+N
	kfx6f9/eneMss64pa2AOcKMTivA2Xkh3/5qixL231fWp0pfD1D74Vnu+Dxw+t0OQ
	O0a51Mx6CGy1GVc3AMhOTAKWwY7mhAoF75AgmpPeWxS5uuz6dlHiLo0pxYOsDqgK
	m1oVQw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ys1ucuekb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 15:30:25 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 3087D40047;
	Tue, 18 Jun 2024 15:30:22 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id CCAF721862B;
	Tue, 18 Jun 2024 15:29:56 +0200 (CEST)
Received: from localhost (10.48.87.62) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 18 Jun
 2024 15:29:56 +0200
From: <patrice.chotard@foss.st.com>
To: Mark Brown <broonie@kernel.org>
CC: <linux-spi@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <christophe.kerello@foss.st.com>, <patrice.chotard@foss.st.com>,
        <stable@vger.kernel.org>
Subject: [PATCH 2/3] spi: stm32: qspi: Clamp stm32_qspi_get_mode() output to CCR_BUSWIDTH_4
Date: Tue, 18 Jun 2024 15:29:50 +0200
Message-ID: <20240618132951.2743935-3-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240618132951.2743935-1-patrice.chotard@foss.st.com>
References: <20240618132951.2743935-1-patrice.chotard@foss.st.com>
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

In case usage of OCTAL mode, buswidth parameter can take the value 8.
As return value of stm32_qspi_get_mode() is used to configure fields
of CCR registers that are 2 bits only (fields IMODE, ADMODE, ADSIZE,
 DMODE), clamp return value of stm32_qspi_get_mode() to 4.

Fixes: a557fca630cc ("spi: stm32_qspi: Add transfer_one_message() spi callback")
Cc: stable@vger.kernel.org
Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 drivers/spi/spi-stm32-qspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-stm32-qspi.c b/drivers/spi/spi-stm32-qspi.c
index 6944e85d8367..955c920c4b63 100644
--- a/drivers/spi/spi-stm32-qspi.c
+++ b/drivers/spi/spi-stm32-qspi.c
@@ -349,7 +349,7 @@ static int stm32_qspi_wait_poll_status(struct stm32_qspi *qspi)
 
 static int stm32_qspi_get_mode(u8 buswidth)
 {
-	if (buswidth == 4)
+	if (buswidth >= 4)
 		return CCR_BUSWIDTH_4;
 
 	return buswidth;
-- 
2.25.1


