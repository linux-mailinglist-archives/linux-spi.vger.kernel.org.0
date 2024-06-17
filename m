Return-Path: <linux-spi+bounces-3420-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D8290B53E
	for <lists+linux-spi@lfdr.de>; Mon, 17 Jun 2024 17:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0414B284B4A
	for <lists+linux-spi@lfdr.de>; Mon, 17 Jun 2024 15:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8501E335C0;
	Mon, 17 Jun 2024 15:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rYWsx3O0"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB1A10958;
	Mon, 17 Jun 2024 15:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718638264; cv=fail; b=eK+W7d45538ihN1pLsN8YTRQL+xbtrHdSp1ryLLOgSpSJZHYc5cUt05nSIYdhBAiWFtc1KgY8wbkCJ5pRPru8kDitUGjIXm6M3UxpB2m32fBUkw2bzUqkQXXRAHqC+3Ll1T8oSlOQvIMN2lEb8JCnwJnnZ8mRC4rWPEXFWIc9xA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718638264; c=relaxed/simple;
	bh=JwkUhd5/sbNUK9KTzgVNEXUMJRK2PwBjJ9R8YDgE+Dw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RclcGKxNpDdbC4bkeJBhTs7Rdik6teuWp8beyWUBqiho5ybO/qEya5SEoXtH+DS5B/1u/lvifaUg0Sz0SzhgV5KcpCTsn3KqaGKKilJkWeK1mA8hCYreMyAgRMLeAq75OBkxnKgatNOLmNf7s403oXNOHv2wjP5i18n5F00LnFw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rYWsx3O0; arc=fail smtp.client-ip=40.107.244.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bje7VcFH0Glg9OIiD5li+A4TYX4L4LJ7bcyfYFA/SY5DjKrYcTQG2ZdNKpXglFrqp/TpJmFhjNnrZwXgn5nGvi6edMTj33e+zqL2OO4MFifpKDXkczZzs/vtG2QlqSmT6ObkDpZ7Nm0H93QcYpbVKZA4jTEuokMKP9pqxJgNzj8een2rOAFCqjQiIHWlMbltiY8pmNvkjfCA/CVdZm+ZZ/K3mhwUzQbf5620IUdM2k9B9UFOeRPohwOQHJAm27ziMbXjWCYHdNENA/Q8mWj3qNyqI3iuojPfQK6Su3/uW3TBZ/f3sH6MHHlVE7TufGg1Hcy21AnxTNTDcqaQQt3d9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9yR7Dx3icZplT1FPYTD3fkQh1mWl2tpuswyyIloR43Y=;
 b=L+dIugh/GtP1SlNKGyqYUHNx+GJJlIwDriC5tYBdRS1Kllb9q49A8uKhiyARlkyYXYxBrbN5HqELA5NLUyN5uV+Wu9Z4yKAp3B6RHest+O2e+UPE4g2E40DSFDjMeCI/R9mCOAc/xgyWrget4KSErY8aDC+JBt6JkP9p2eiLu/ML/vlignf9fs9p+Msv8TPR2Ytm5ha/rkJCqUBS9WqRbEssJtbjIfW6f3ZHetZlCPPpPqx4haeDUeLeGYxqVUCpxFOd80ALFkBC/G7KBxhRqDzY0lFGLRkrTcXTaUWy7E8gOKi06gdjMeMWZkHVQB/3A2zAjqOdX3DxXoTbT1q5yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9yR7Dx3icZplT1FPYTD3fkQh1mWl2tpuswyyIloR43Y=;
 b=rYWsx3O0Naoe14uUPGiWeKqN7NcZNnbk7WleTb/nKy8e9TuW8KAxT/I9d7kuyy/S818CrWC0kqGTXS8TI75OJsxtM4bnHZJdsuXlzh6zuZGiQsx3cEV7lo9jt/bV9/RYvpB2AEVHn6QhuUiGjxxa959At+Os/Rij/M99I3+5ju4=
Received: from BN8PR16CA0008.namprd16.prod.outlook.com (2603:10b6:408:4c::21)
 by PH7PR12MB6419.namprd12.prod.outlook.com (2603:10b6:510:1fd::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 15:30:58 +0000
Received: from BN1PEPF0000468B.namprd05.prod.outlook.com
 (2603:10b6:408:4c:cafe::5f) by BN8PR16CA0008.outlook.office365.com
 (2603:10b6:408:4c::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31 via Frontend
 Transport; Mon, 17 Jun 2024 15:30:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN1PEPF0000468B.mail.protection.outlook.com (10.167.243.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Mon, 17 Jun 2024 15:30:57 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 17 Jun
 2024 10:30:56 -0500
Received: from xhdakumarma40u.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Mon, 17 Jun 2024 10:30:54 -0500
From: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
To: <broonie@kernel.org>
CC: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<git@amd.com>, <amitrkcian2002@gmail.com>, Amit Kumar Mahapatra
	<amit.kumar-mahapatra@amd.com>
Subject: [PATCH 1/1] spi: Fix SPI slave probe failure
Date: Mon, 17 Jun 2024 21:00:52 +0530
Message-ID: <20240617153052.26636-1-amit.kumar-mahapatra@amd.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: amit.kumar-mahapatra@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468B:EE_|PH7PR12MB6419:EE_
X-MS-Office365-Filtering-Correlation-Id: 90fd30e2-a8ec-4a09-af0a-08dc8ee27c44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|376011|82310400023|36860700010|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?J1/ikJjfv4U5huCdDHVQIQe4GsMSyy+Ks5xkBBNMgWbl1J//l7UyuZBv05/s?=
 =?us-ascii?Q?KixHJlnFzawzVAufePbaN6YH6wAFYJM9qfTDuFcGMqWuGtzVZTHIUBLt0Kv4?=
 =?us-ascii?Q?Wm9vFdQzXP+kBeHdzJu022MC0wVXfILVu3O7MLnHH7Fvtm9O+htQXD6Jj8Pq?=
 =?us-ascii?Q?+BopgZ0xGulYRAuPodNRocBqJkQqvMLgoOGlFFGUv2W5fbdnjEt370UVKZUt?=
 =?us-ascii?Q?wD9duGauZV4rwCKzkI3nnI0svNw5FsjoGLyvg/n1yP4bgKI42ZhEQKN8gl7G?=
 =?us-ascii?Q?2Da8XBlR9/HEKegAMdrbtVtkBwPR0gUy/hI/lp+YYL137fLUDU20kEIup4Ws?=
 =?us-ascii?Q?rojPctQCfAeQkcrBdZ412mV6QSKeOkEGMJr785Anw16AiVV3u8hvvq2lDG8w?=
 =?us-ascii?Q?OtpCumQrGsajR3Wjd7SYXrW5cppXZZhvI9PwUJy3VLfpuKh0fum53dIQCftx?=
 =?us-ascii?Q?M2lEuy+gKXrU0dgNTdoz+EY5xhIaHUfpq3Z5I2l09GonKxPxPCGfmsdXRhjy?=
 =?us-ascii?Q?ntSxmaqbWZ+AN4qHS2XPFe89VWhxpgVaUTBD9qtikP3pHaHyREeDeG/zRJ3M?=
 =?us-ascii?Q?frpiG4KnOr+/Q0E++oo5J9oOd40LHvgRQkcR4jm8kJB4oJ/8u6qERAq5E4yw?=
 =?us-ascii?Q?lKikhUOuGXAsZ9DLpIVhoxCUpk15Xi9vtkFOTqM/qPGJlptJtgSlt74BDfL9?=
 =?us-ascii?Q?bN/gbtLe0mVsRhgIf1AhwYht1/jftvb/X/wM7i7gALiVuz1pDAnOwcLzqZLK?=
 =?us-ascii?Q?d8OvssvrNqPb+c2mPjHxdIc0ja+v3HaPpPypw5LSw19H5KI28SUd4IOrPI0u?=
 =?us-ascii?Q?QTQP4nfkW6wv1N0pYLTwUtCKkD7EWdM3MYiXR1bCCdkP2tX4EoqHKbK66E2c?=
 =?us-ascii?Q?b7bYBOFqM1TiWXIuo3hdOiWZi8b0fy3z9YjL36MKL54weHtR0aiDLK7FowpT?=
 =?us-ascii?Q?/Vn9L5qZZFrknjfbzXRGtbBr18wM6dOfCcwZ7T1qdEah7ySYZkarqocyXPRc?=
 =?us-ascii?Q?Py2GYrCij7BfYS/DY5XeHmfQsuztLdXsjGCN5mBABY8wp7OnVePgcQ7GJiGk?=
 =?us-ascii?Q?lpf43JPtci1M3kPlZSY88FmgCto3tT+r+H4yKoFzErn2HIxLiI2zxF3/V+5l?=
 =?us-ascii?Q?wpUEF2AAxqEwHTeANb8w0bbwQtYuL/syf+OwImMnQ6Gos5O32nZcNhZrnlgx?=
 =?us-ascii?Q?iUIF/TDEJeB3XD3WE3UNHbESEZiG+9FGLrytuepQiqxOmvJ5U1pz5jOJTNsd?=
 =?us-ascii?Q?1rEwbPxtnElg+tkyhZNQXMpQ7hO7wF8/suRXFxrqPCixxXKs1hEptMCHm75C?=
 =?us-ascii?Q?N9aFPkeaUnBPG5mmkTdUYIeqtdUHBdaQphyfL55TBplqkp9Xdus7Wqh++atw?=
 =?us-ascii?Q?S5MY43JKUrwO3CZPWbYXPk+rNSWEfxpzabOCDSSg7A0EBWVyNg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(376011)(82310400023)(36860700010)(1800799021);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 15:30:57.6209
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90fd30e2-a8ec-4a09-af0a-08dc8ee27c44
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6419

While adding a SPI device, the SPI core ensures that multiple logical CS
doesn't map to the same physical CS. For example, spi->chip_select[0] !=
spi->chip_select[1] and so forth. However, unlike the SPI master, the SPI
slave doesn't have the list of chip selects, this leads to probe failure
when the SPI controller is configured as slave. Update the
__spi_add_device() function to perform this check only if the SPI
controller is configured as master.

Fixes: 4d8ff6b0991d ("spi: Add multi-cs memories support in SPI core")
Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
---
BRANCH: for-next
---
 drivers/spi/spi.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 9721adf048b5..e7e4201e93b5 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -689,10 +689,12 @@ static int __spi_add_device(struct spi_device *spi)
 	 * Make sure that multiple logical CS doesn't map to the same physical CS.
 	 * For example, spi->chip_select[0] != spi->chip_select[1] and so on.
 	 */
-	for (idx = 0; idx < SPI_CS_CNT_MAX; idx++) {
-		status = spi_dev_check_cs(dev, spi, idx, spi, idx + 1);
-		if (status)
-			return status;
+	if (!spi_controller_is_target(ctlr)) {
+		for (idx = 0; idx < SPI_CS_CNT_MAX; idx++) {
+			status = spi_dev_check_cs(dev, spi, idx, spi, idx + 1);
+			if (status)
+				return status;
+		}
 	}
 
 	/* Set the bus ID string */
-- 
2.17.1


