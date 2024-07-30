Return-Path: <linux-spi+bounces-4094-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A70B19412E6
	for <lists+linux-spi@lfdr.de>; Tue, 30 Jul 2024 15:17:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42515B24E7C
	for <lists+linux-spi@lfdr.de>; Tue, 30 Jul 2024 13:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C387719FA77;
	Tue, 30 Jul 2024 13:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="HQAazus6"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A04F19EECA;
	Tue, 30 Jul 2024 13:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722345405; cv=none; b=HBy23JuoZjh0wnCYl9Hud+FAq8goM6GdYTVWIknsXJ24NEVmQ/hgTVK26TvHJBoqwMqueJQ/Sam0F7sjIUk9Ma+rMV39P4jhs9Rf2szNAah6UTDsql2UPlbaPZsRqJvbUbzjurDoV/F0pMwKkFxzJD9JYjMl65xo0wn9yCmCSiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722345405; c=relaxed/simple;
	bh=zj0aIYvulMLaTJ7jE+J2kdKeVFkwwt29ptI8jdT24ac=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ub5NO6ASK2wRtaVgcRBqA3oMCqzRdZMaW2Awe49enxcSPvSn7QxLHjZx2TJxGbAf9Nd/7WQoBLdwzeBJmVy1AIRiapph6JFG40VhDqeJGTVvBrb/vWcevCLDPSvIh3p9Lp6QDBnpPLSz+N+sZZsyTdwBZro8mKvojpIPDG3G9Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=HQAazus6; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46UAeME7001880;
	Tue, 30 Jul 2024 06:16:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=RADa8Ey5n2vTN7vraUqNbAm
	IjccE2rtWUFiiMqI//WQ=; b=HQAazus67isubswKRp/WgN5GrNgGns7wIJ+bn8r
	j+TjLQVtHYYO2UaN84/e1enegjXiWOdo77MBLuaHa6PnFEAglKPZcZSBS5jAPnv2
	9lDBPZviVp7zvyRdBr+LmSHvY1okOJNdPhGIQATj5VyCSUMi0YE22RxoMSgsG/lh
	ZA+AlB7H3uNjcdvR9+1qYOdTtqpD/QSfqapIWzPXHxSP2rml+xOUWgRbSsodmAwE
	1OIt6YROKYAD0g61ihe4v5TzShgoEguSvncL4FR+k4bqjcyb0CkB+Tnr/s4vm0kj
	kfxvjpOvi7JQwm+GqUqltgG5kxezygexsCJSZ1DBCwjWfBg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 40pnp5ja8q-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jul 2024 06:16:38 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 30 Jul 2024 06:16:37 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 30 Jul 2024 06:16:37 -0700
Received: from Dell2s-9.sclab.marvell.com (unknown [10.110.150.250])
	by maili.marvell.com (Postfix) with ESMTP id E99D05B692F;
	Tue, 30 Jul 2024 06:16:36 -0700 (PDT)
From: Witold Sadowski <wsadowski@marvell.com>
To: <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: <broonie@kernel.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <pthombar@cadence.com>, Witold Sadowski <wsadowski@marvell.com>
Subject: [PATCH 1/1] spi: cadence: Add 64BIT Kconfig dependency
Date: Tue, 30 Jul 2024 06:16:26 -0700
Message-ID: <20240730131627.1874257-1-wsadowski@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 5OAndy0DIvkuBJ6ZpACMykqzjd_s7uRy
X-Proofpoint-ORIG-GUID: 5OAndy0DIvkuBJ6ZpACMykqzjd_s7uRy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-30_11,2024-07-30_01,2024-05-17_01

xSPI block requires 64 bit operation for proper Marvell SDMA handling.
Disallow bulding on targets without 64 bit support.

Signed-off-by: Witold Sadowski <wsadowski@marvell.com>
---
 drivers/spi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index a2c99ff33e0a..d7b5c9b5c676 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -267,7 +267,7 @@ config SPI_CADENCE_QUADSPI
 
 config SPI_CADENCE_XSPI
 	tristate "Cadence XSPI controller"
-	depends on OF && HAS_IOMEM
+	depends on OF && HAS_IOMEM && 64BIT
 	depends on SPI_MEM
 	help
 	  Enable support for the Cadence XSPI Flash controller.
-- 
2.43.0


