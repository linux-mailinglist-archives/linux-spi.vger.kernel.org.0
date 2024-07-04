Return-Path: <linux-spi+bounces-3742-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF31927761
	for <lists+linux-spi@lfdr.de>; Thu,  4 Jul 2024 15:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0602B1F229E7
	for <lists+linux-spi@lfdr.de>; Thu,  4 Jul 2024 13:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 487A71ACE7F;
	Thu,  4 Jul 2024 13:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="L+KyAy0F"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6B641A81
	for <linux-spi@vger.kernel.org>; Thu,  4 Jul 2024 13:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720100739; cv=none; b=cGh5u502wny9cF+0wFH/FDMG+c8Lzsv0qsqLgcMlmznsyToNJcrSsuXzPeu2DeKsB+wtLeVaP7TZDgXdTGQmc4VAmVhDyGNGkYPLCq8T/coaAy/hfr6W+cxiLLB0J0A597E/Ce6vc+FzGo8sQefIbK9FiaJOR+QjLKoacGqAom8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720100739; c=relaxed/simple;
	bh=4uhZm0HcrBl+iO5ib4/sew9dsPPmIXH2xPkMPv76CuU=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=FtQFlO2O/DdCJcl09TyDwfGo8Hqmmcr6qHUT+kAUVkVBeKuOFFaYpnf2EqRKFahHD/FbiGNNRK1YBJMdpdgFkwZfpBPCiJ6t8FnPjGJv4AWKFLghl9MdtVEUT3PeTUv+KQDMSpLhWS9H+45n33TeYBF1i/7hQlQZZTEPh74M4ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=L+KyAy0F; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 464COJHR013070;
	Thu, 4 Jul 2024 09:45:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=C916zDm8TsSEi7kPrUMgX3pxifM
	g0v20FS4WkSckGu4=; b=L+KyAy0FWLLizQM0+CnBl2qcRA509bD0bHKZz/o0PAm
	Z5LLScp1nW5EgLpPDr9JBQV9Ai/gTwASv79Ub36o6SLC5o2xbHBjDRXlIu+vAYH/
	jTrnI6Ab5MUNJmcP7fbvK4GT2AO+F2iCmIS7+88lg/NtyNgggB85WxF3U2cTRjOl
	R6RE2ETsuzpfjbLlHsHTyAXrtZE7v1veJy/uFEeyqtWu2PfoiPEpQt/6Zr94w9AT
	//X+unw97kh5pxlFCaItWPgM1B7GbYJBCn17+m3Uv3GjP9EZLgBZLHYsoL2TGXSG
	zEhyaoQMwin1AtBMHEuHZfTvWG56dOhN7HjhBsd7Ciw==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 405a7mkkpb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jul 2024 09:45:35 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 464DjYnP000907
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 4 Jul 2024 09:45:34 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Thu, 4 Jul 2024
 09:45:33 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 4 Jul 2024 09:45:33 -0400
Received: from [127.0.0.1] ([10.44.3.56])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 464DjPtx032622;
	Thu, 4 Jul 2024 09:45:27 -0400
From: Nuno Sa <nuno.sa@analog.com>
Subject: [PATCH 0/4] spi: xcomm: support GPO pin
Date: Thu, 4 Jul 2024 15:49:11 +0200
Message-ID: <20240704-dev-spi-xcomm-gpiochip-v1-0-653db6fbef36@analog.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAFeohmYC/x3MQQqAIBBA0avErBvQEMquEi1Cp5pFOiiEIN49a
 fkW/1fIlJgyrEOFRC9njqFDjwO4+wgXIftumNRk1KwMenoxC2Nx8XnwEo7uZsFFa+PsYs2pZui
 xJDq5/ONtb+0DFkiqxWgAAAA=
To: <linux-spi@vger.kernel.org>
CC: Mark Brown <broonie@kernel.org>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720100959; l=691;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=4uhZm0HcrBl+iO5ib4/sew9dsPPmIXH2xPkMPv76CuU=;
 b=jURDnv+W1ZYpbsyRwqqxOefrxOJaSPhYza/Ix6ft3uvLxyjvSK6JjPIT4i+GP9hwlrexakSXQ
 xSNRSOKaZm5BmKa1juY5RxNs9hgQtdi5xl7PnJkjc/rMwhF0haHrTbG
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: EZssvH2m4WAeg9UMAX_WLXLnTXnS7ANt
X-Proofpoint-ORIG-GUID: EZssvH2m4WAeg9UMAX_WLXLnTXnS7ANt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-04_10,2024-07-03_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxlogscore=510
 adultscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 mlxscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407040098

Main purpose of the series is to expose one supported pin as GPO through
a simple gpiochip.

While in here and as the driver is fairly simple add some more straight
forward cleanups. 

---
Michael Hennerich (1):
      spi: xcomm: add gpiochip support

Nuno Sa (3):
      spi: xcomm: make use of devm_spi_alloc_host()
      spi: xcomm: remove i2c_set_clientdata()
      spi: xcomm: fix coding style

 drivers/spi/spi-xcomm.c | 88 +++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 70 insertions(+), 18 deletions(-)
---
base-commit: 5b6cad81d0c1b1c71533f2898a47f3d2fcfc4595
change-id: 20240704-dev-spi-xcomm-gpiochip-8114c9894f07
--

Thanks!
- Nuno Sá


