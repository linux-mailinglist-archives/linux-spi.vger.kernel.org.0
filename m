Return-Path: <linux-spi+bounces-3746-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB654927765
	for <lists+linux-spi@lfdr.de>; Thu,  4 Jul 2024 15:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18C121C220D9
	for <lists+linux-spi@lfdr.de>; Thu,  4 Jul 2024 13:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE58D1AE0B9;
	Thu,  4 Jul 2024 13:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="YFvNK1Hc"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8743B1AB8EC
	for <linux-spi@vger.kernel.org>; Thu,  4 Jul 2024 13:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720100742; cv=none; b=rgJKQuyyToPo7xD0Kcy2fQFCokxUphucDvrtz4Z7aAfAryPqv323tJOAueBxWEn3yEtV7OAil0wmR3OeKzK5Nb1Q/pP8ouund6ktLvxrBhAQKB0UJwOJLZcwgfU4CsMPjJ9RvQ9+sIwRAWwwSW5IDMHg9p31CArN4Xd6qsLTaLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720100742; c=relaxed/simple;
	bh=YbhNBs1FAUTf6FdeaePslEmL9N+JT0z5OyIbcZct36I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=oqFIpiHrYzwMFoTkys7gi12NkqqxqNU5KD5p+Q4UTx3w+ACe6GKM6l5iJM63O3e2+MC7ckoAyiwcVzQLKxOzq1W5ZHGd5thYNMhJskEpwzMJX6VQhNS+yMVkdxxkfMGTZLesjqwmV2J4cB0I57ivMagvJaeQewT3Mk3jW/8oQtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=YFvNK1Hc; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 464AxbCt006966;
	Thu, 4 Jul 2024 09:45:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=6jFxA
	GcVE8FDWb34Q0bP7ZGVnZ9f3pQk3AXUldfxcrQ=; b=YFvNK1HcpzNTLWpB/Jw5y
	ZncP6THbibmRz7o/N+79lIsmu1JyV/T3igFsgj2B4Kw50Thepo69R8m6dLK/C4bX
	I/Md+pfY/+qfy0wWv6bIkXtVwcbol6SnKeneX1rk35tg5erZbFqQLcXQfTmJPA9d
	cWAcAVl9g68AjRt+z0EnaCYve4asjdQ5U+trdOMJ0D2l25i1me2ZYcs53PlKQUa9
	+AtYt2J71nw5DMoQVkTh97XZEt0GFb1BxoRASilwFWkPwnzU6oq8Qv1zHrEDDNu1
	vQ+1YUaBGTyjB0OuqCS2SDCiVsu98Z5IKDSv7+3gKOI5M0KI7PcyD1XRT+3EPQ8K
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 405n2p1jyy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jul 2024 09:45:39 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 464DjbOb000919
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 4 Jul 2024 09:45:37 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Thu, 4 Jul 2024
 09:45:36 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 4 Jul 2024 09:45:36 -0400
Received: from [127.0.0.1] ([10.44.3.56])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 464DjPu2032622;
	Thu, 4 Jul 2024 09:45:31 -0400
From: Nuno Sa <nuno.sa@analog.com>
Date: Thu, 4 Jul 2024 15:49:14 +0200
Subject: [PATCH 3/4] spi: xcomm: remove i2c_set_clientdata()
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240704-dev-spi-xcomm-gpiochip-v1-3-653db6fbef36@analog.com>
References: <20240704-dev-spi-xcomm-gpiochip-v1-0-653db6fbef36@analog.com>
In-Reply-To: <20240704-dev-spi-xcomm-gpiochip-v1-0-653db6fbef36@analog.com>
To: <linux-spi@vger.kernel.org>
CC: Mark Brown <broonie@kernel.org>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720100959; l=717;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=YbhNBs1FAUTf6FdeaePslEmL9N+JT0z5OyIbcZct36I=;
 b=MuKb28kAWKixH40qYUYh0905O2z+h3A0DYEpvq08BMt8aabi8aJFQxJ6nBOf30xZLRaYYH1q9
 JS9NBnm4CfuD1AaAhYAPJrUtXGNuhLuWFCSgAxbVwceyMP1KAR/I5Bb
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: dcqCyOLRuiFeuKDf1K7HsH8F2f6BTnRh
X-Proofpoint-GUID: dcqCyOLRuiFeuKDf1K7HsH8F2f6BTnRh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-04_10,2024-07-03_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 spamscore=0 adultscore=0 phishscore=0 malwarescore=0 impostorscore=0
 suspectscore=0 clxscore=1015 mlxlogscore=598 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407040098

i2c_get_clientdata() is not being called anywhere so that we do not need
to set clientdata.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/spi/spi-xcomm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-xcomm.c b/drivers/spi/spi-xcomm.c
index 5a27eaed4183..136d81fb5f56 100644
--- a/drivers/spi/spi-xcomm.c
+++ b/drivers/spi/spi-xcomm.c
@@ -274,7 +274,6 @@ static int spi_xcomm_probe(struct i2c_client *i2c)
 	host->flags = SPI_CONTROLLER_HALF_DUPLEX;
 	host->transfer_one_message = spi_xcomm_transfer_one;
 	host->dev.of_node = i2c->dev.of_node;
-	i2c_set_clientdata(i2c, host);
 
 	ret = devm_spi_register_controller(&i2c->dev, host);
 	if (ret < 0)

-- 
2.45.2


