Return-Path: <linux-spi+bounces-3361-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D0C290187C
	for <lists+linux-spi@lfdr.de>; Mon, 10 Jun 2024 00:19:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 052241F211D0
	for <lists+linux-spi@lfdr.de>; Sun,  9 Jun 2024 22:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C761CFAF;
	Sun,  9 Jun 2024 22:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UcG/T8D2"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F81EAF9;
	Sun,  9 Jun 2024 22:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717971545; cv=none; b=fjgDBd8aNzhPESFUu2QFsu9GHpmHfEt34hCX5L8iKZndoDenerMa63uQxNwMMmdKVUK7Q2ThdOdEw+FMmjqGgs+s7dFw1vugmSRbwCfS9yOEQo8yZO0XMxcKgHucC86l/Q2esmnw8Sz1xD2RtLYlCl/CaE5GKkgp92srdsmzUFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717971545; c=relaxed/simple;
	bh=ySuyf8UbF0zWjzvwoGYc+ew5iXeHZUMDNjl7NU6DiCc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=k05XrsWKwwXHCXereFqBb+aiNd3nXCx2G7hZnNqfVzhYDjdL9LP3COtFRm8Kvcy4HCWiZdL4einEDW5gVBb+l2nIdenUKdfzFbAfMlOdjWdtyr9PSfxY1RATHWiTLnY6+0GkknYuMQatcypIyIK+/qRfwO2cDUZkkhHKuvW9wdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UcG/T8D2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 459KrZO1025542;
	Sun, 9 Jun 2024 22:19:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=N5eQqMFkP57lxHjn9HDz4v
	EB4SJwMNThRpvnJhhQHpw=; b=UcG/T8D211BCdRfNuk8HKiQOqHIZxskACmAEVr
	lyFv1zz86XpAEDMi6OYEywDEjWf7cQP6RJtFPQeq1hjG7SFs1/i3WePbjHs0ADuV
	Pw++JbP4fwlXHAueLZQOWk/3hts65pJi7yYGnPiksNTlPu3tnHOlAGaod9kIbUIs
	/6rRdnobjSZwqZ6NjXX3ts8whHm0uwKPnqPmU0tW45Gnxs2yei4/k3cyYz3Y9FAj
	3EiWAVu9hRx6wL9PggQOeYOwE89uWstW5zyJG/BW0FTTXp0PL6uYZN4I50bNezB6
	s8yF/XWrlnXRP0Zzxw1mbwW5GD5ey0Wzn1OhSj7p4WxVXeWg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ymfp7a3dg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 09 Jun 2024 22:19:00 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 459MIwr8002475
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 9 Jun 2024 22:18:59 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 9 Jun 2024
 15:18:58 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Sun, 9 Jun 2024 15:18:58 -0700
Subject: [PATCH] spi: add missing MODULE_DESCRIPTION() macros
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240609-md-drivers-spi-v1-1-1c7444f53cde@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAFEqZmYC/x3MQQqDQAxG4atI1g2kIoq9SulixvlbA3UqSSuCe
 PeOLr/Fexs5TOF0qzYyLOr6yQXXS0XDGPILrKmYaqkbaaXnKXEyXWDOPiv3XdcEoE0ShUo0G56
 6nsP7ozgGB0cLeRiPzVvzb+Up+BdG+/4HTCSgnX8AAAA=
To: Mark Brown <broonie@kernel.org>
CC: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        "Jeff
 Johnson" <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 35kC_feu8IiuVCZfmxFCPlL9L7wanhBE
X-Proofpoint-ORIG-GUID: 35kC_feu8IiuVCZfmxFCPlL9L7wanhBE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-09_17,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 priorityscore=1501 clxscore=1011 bulkscore=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406090175

make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/spi/spi-altera-core.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/spi/spi-fsl-lib.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/spi/spi-omap2-mcspi.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/spi/spi-qup.o

Add the missing invocations of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/spi/spi-altera-core.c | 1 +
 drivers/spi/spi-fsl-cpm.c     | 1 +
 drivers/spi/spi-fsl-lib.c     | 1 +
 drivers/spi/spi-omap-uwire.c  | 1 +
 drivers/spi/spi-omap2-mcspi.c | 1 +
 drivers/spi/spi-qup.c         | 1 +
 6 files changed, 6 insertions(+)

diff --git a/drivers/spi/spi-altera-core.c b/drivers/spi/spi-altera-core.c
index 87e37f48f196..7af097929116 100644
--- a/drivers/spi/spi-altera-core.c
+++ b/drivers/spi/spi-altera-core.c
@@ -219,4 +219,5 @@ void altera_spi_init_host(struct spi_controller *host)
 }
 EXPORT_SYMBOL_GPL(altera_spi_init_host);
 
+MODULE_DESCRIPTION("Altera SPI Controller driver core");
 MODULE_LICENSE("GPL");
diff --git a/drivers/spi/spi-fsl-cpm.c b/drivers/spi/spi-fsl-cpm.c
index e335132080bf..23ad1249f121 100644
--- a/drivers/spi/spi-fsl-cpm.c
+++ b/drivers/spi/spi-fsl-cpm.c
@@ -415,4 +415,5 @@ void fsl_spi_cpm_free(struct mpc8xxx_spi *mspi)
 }
 EXPORT_SYMBOL_GPL(fsl_spi_cpm_free);
 
+MODULE_DESCRIPTION("Freescale SPI controller driver CPM functions");
 MODULE_LICENSE("GPL");
diff --git a/drivers/spi/spi-fsl-lib.c b/drivers/spi/spi-fsl-lib.c
index 4fc2c56555b5..bb7a625db5b0 100644
--- a/drivers/spi/spi-fsl-lib.c
+++ b/drivers/spi/spi-fsl-lib.c
@@ -158,4 +158,5 @@ int of_mpc8xxx_spi_probe(struct platform_device *ofdev)
 }
 EXPORT_SYMBOL_GPL(of_mpc8xxx_spi_probe);
 
+MODULE_DESCRIPTION("Freescale SPI/eSPI controller driver library");
 MODULE_LICENSE("GPL");
diff --git a/drivers/spi/spi-omap-uwire.c b/drivers/spi/spi-omap-uwire.c
index 210a98d903fa..03b820e85651 100644
--- a/drivers/spi/spi-omap-uwire.c
+++ b/drivers/spi/spi-omap-uwire.c
@@ -541,5 +541,6 @@ static void __exit omap_uwire_exit(void)
 subsys_initcall(omap_uwire_init);
 module_exit(omap_uwire_exit);
 
+MODULE_DESCRIPTION("MicroWire interface driver for OMAP");
 MODULE_LICENSE("GPL");
 
diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index 7e3083b83534..b428990f6931 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -1671,4 +1671,5 @@ static struct platform_driver omap2_mcspi_driver = {
 };
 
 module_platform_driver(omap2_mcspi_driver);
+MODULE_DESCRIPTION("OMAP2 McSPI controller driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/spi/spi-qup.c b/drivers/spi/spi-qup.c
index 2af63040ac6e..1e335cd961a4 100644
--- a/drivers/spi/spi-qup.c
+++ b/drivers/spi/spi-qup.c
@@ -1369,5 +1369,6 @@ static struct platform_driver spi_qup_driver = {
 };
 module_platform_driver(spi_qup_driver);
 
+MODULE_DESCRIPTION("Qualcomm SPI controller with QUP interface");
 MODULE_LICENSE("GPL v2");
 MODULE_ALIAS("platform:spi_qup");

---
base-commit: 19ca0d8a433ff37018f9429f7e7739e9f3d3d2b4
change-id: 20240609-md-drivers-spi-9774aee6d0b0


