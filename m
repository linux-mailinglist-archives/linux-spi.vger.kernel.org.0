Return-Path: <linux-spi+bounces-11813-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F97CAC560
	for <lists+linux-spi@lfdr.de>; Mon, 08 Dec 2025 08:30:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 43907300440E
	for <lists+linux-spi@lfdr.de>; Mon,  8 Dec 2025 07:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A2A26CE34;
	Mon,  8 Dec 2025 07:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="KQUbg2rU"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591C31E2606;
	Mon,  8 Dec 2025 07:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=91.207.212.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765178999; cv=fail; b=cZMzihvSw9Nm90jzIEjkkLI/QZlg3ffdlxaXGqeuX9Q2BYAvT+AeCBNX4OwfJw3H1eHZdlrF/Ep3XJ5Rj0WRK0SIvrg1T/r5eCmXSZXT9IRHy4vuwBHsXPmyB8xF5WE5obIvQOZEiUEcGxpVWC52kmy3uOZMLRt/0E2LbS0Kun4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765178999; c=relaxed/simple;
	bh=wzCkZzPbWhj39oG9eKu97XakUMXNooBsQoajHNemf1c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=N2iwzXSgm91ky/OGEzQ0M3EZSWOXbnBIsCwzIdr81689DjaJQ1ce2b+wqV5HP7dJDM+djZaS9h9u9HFTyNMo5y4cU6Bn5sQhv5Kwykakg2V6EHsjOTn9BwP1WGevrt/DrwMBsmPkFHdqzETRfTDUO20XyNwKn+SRhu/Eesh7hos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=KQUbg2rU; arc=fail smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B87A03G1096628;
	Mon, 8 Dec 2025 08:29:25 +0100
Received: from am0pr02cu008.outbound.protection.outlook.com (mail-westeuropeazon11013053.outbound.protection.outlook.com [52.101.72.53])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4avagaw3dq-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 08 Dec 2025 08:29:25 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WtrPUsmOYbIvO/gznJgJewzPz9MNnOoM2qtzZSrIsQy8Q1PEkn0++gzMAsSNELnHg6mNvYbW1xvvE3dWDWHVh29AA+uUaSKQ6L3DxGA3JlhBhVzorb2PQ3OD1Qyt0iDaRCPWX5/wfe4R8kxhRdh7/NDZU/iUPuy2qLtpRVlwUL8lGJZAw/yZusg+P5ZaG5Sxk9fPn8e6/OjoYlnMCZOrttJjY8afEBEmXSPDBo3aItBHLAaeJlWot/MYkiOempZQPchK+tguxbCBKWrXVrz75qj53itOVZgviNnh2o4QeD4tWhpz1Hw/yVEHX822OZMqxy9fDgCMlenHJrkAoRlLZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sFifFDVVPlmakVLPtIWQFBDHLcEXcpKDiqB76TIJ8pg=;
 b=Cf/MmlBxA+yNKst+qcjjDPRuM//qCWtqT4fO+5+SbPpMy3P9bglZJGS0GqlCv0TvdfPY8mm6OJiOpQnMc4wVedZ8htK2c6c2nWe2vvsDIUlVMIkW2wDGOfnlKbzvqqs3EcFTR6DnR0n7TEjNGwtJ1Jdpr3sfArS+PKov8+X1h0kCk8m1QYSBjc6tTWSNnERPjueOSPmwkhD+fqCHAqexc/LldQpDGKRXu9joKakGJ/ejOYrhLS5zNM80SlFPXwqLDbtzaJwoaKilJOxIZmB1RJ2/GG+DYSnH8mIkUIPVORxTrmTm83bhNjToLo/YxlrCiEZLK+PjRos352EE4n4Sjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=st-md-mailman.stormreply.com
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sFifFDVVPlmakVLPtIWQFBDHLcEXcpKDiqB76TIJ8pg=;
 b=KQUbg2rUxj+mjb9F1zcKTfeRz4+balunzGu/htP73qN7r8CrXVr4H4c1hz+hTBWguBywzSp+z5HhOYo4XbQo94iF17xrZtSs+qiznKzFjMuPVVwGl4JjEcbSej+xKrgxQV5gF9614ACvB0VpjpnaUzsu5OEYdMgn14By7k71JWz76K3uW1SPHAJOnt44XsUV/szDtHpVCrGH8x27aWo9cFbk3FnUMlaaKZ3PKGh+VJ9Bj0ajYKWgncYEjRm5DuZwnE/TVAVuVZvZGHqhvaL4A8/Y2DAhrUEVHlnb18hl6v9zEpPWwz7nTeLgtuDLvDbEXUIoLTNj71oergLi8B1nYw==
Received: from AS4P189CA0019.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:5db::10)
 by AS2PR10MB6925.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:57b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 07:29:22 +0000
Received: from AMS1EPF00000046.eurprd04.prod.outlook.com
 (2603:10a6:20b:5db:cafe::41) by AS4P189CA0019.outlook.office365.com
 (2603:10a6:20b:5db::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.14 via Frontend Transport; Mon,
 8 Dec 2025 07:29:15 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 AMS1EPF00000046.mail.protection.outlook.com (10.167.16.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Mon, 8 Dec 2025 07:29:21 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 8 Dec
 2025 08:30:00 +0100
Received: from localhost (10.48.87.93) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 8 Dec
 2025 08:29:20 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Mon, 8 Dec 2025 08:29:08 +0100
Subject: [PATCH v2 1/8] spi: stm32-ospi: Set DMA maxburst dynamically
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251208-upstream_qspi_ospi_updates-v2-1-62526c9467dc@foss.st.com>
References: <20251208-upstream_qspi_ospi_updates-v2-0-62526c9467dc@foss.st.com>
In-Reply-To: <20251208-upstream_qspi_ospi_updates-v2-0-62526c9467dc@foss.st.com>
To: Mark Brown <broonie@kernel.org>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC: <linux-spi@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF00000046:EE_|AS2PR10MB6925:EE_
X-MS-Office365-Filtering-Correlation-Id: e0c560b1-8527-4c37-e383-08de362b816d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UlNWbkZZOHpRb1lDNk54K1lvNVZoTHRhQ1FsYnd6Y1hLMDB5aDhudCsvZm1K?=
 =?utf-8?B?NUloUkVSZW14M3pBcDZtM3EzbTlkU2lnaDFpRnI4UjQ0WGU2VGlMdGNhbGNJ?=
 =?utf-8?B?YTRmbms0U3dqZGlvYjhCUEh4NDVMeldwamlPSjlmU3lRN0F1MWhYMTNsK2pW?=
 =?utf-8?B?emtsZUtKMnE1M0dqMy95SjQ3NFMwNTNnZUdWWHdiSWt4Zy9LRGxHa1krbS9O?=
 =?utf-8?B?S3dOTEkzMzYvSkl4Rzc2NmJjYjlJdWFrTFhvMzU1Q3pqUGFmYVlQY0M3VUJN?=
 =?utf-8?B?enpQRm1POUZZYkRqb2E1bmcrQlZ0cEZGVHJkeDRpRmVTcU5vaU9QdzRYa2Ey?=
 =?utf-8?B?c2lvWGg5RTZkQVVSc3pQUmQ1UFZGTEdlSDBaZXFzb2lHNmNqdCt6QmwyNVR3?=
 =?utf-8?B?YnZobjVoL0h0eUFZWHhzVENBU3NIS2xhSXZENEd3bzFUazBUUWhlSVpqa2U1?=
 =?utf-8?B?OXB1R0VxbHM0L1oySVdIeERIbzRFV2lGZ0w2d0Y1cVJIWFFpVmNFYmIzVVJo?=
 =?utf-8?B?K2tpZ2RTYUhEV3FWKzZhZFZ6a0lPd1Z5bUU4RTJDK0NkNjUvLy9PN3dEZHli?=
 =?utf-8?B?ekp0dnAxeFhZTkp0VVlqUUU5K3JNV2oxUkl6RG8zMGFMV2JKSnYveWFKd1Ja?=
 =?utf-8?B?aXNOc25HNXQxd0FDSUJJWmZLVFZTRGptVFk1VC9Gem5pRXRNNlYzdUFjUXhv?=
 =?utf-8?B?ZCtqaXFGckpLVlg0aGVhRWduWnRaL3dubnhyREE4NnBNUy9sM3Nua2VlUXY4?=
 =?utf-8?B?R3lKTEFwcDd6em5zc3BLaXRwN2wrSDhEUWVGdG5WMGh4NGVUbXZOR1R2N1lZ?=
 =?utf-8?B?MFBaN1Zzei9XZklOakd2c3h5aFl4RWE3M3VRcUFYZGdUY3c2QTZhTGMyc2Z0?=
 =?utf-8?B?bXR3TFFYbGZnazl2SE0zbmw0TVdDeC82Z0hnSkc2MlRRZmpuSWg5RklveXRP?=
 =?utf-8?B?SmE2WGxseEZ1cWhPM3NtYytvY09mME1uV0wwWW1FRFdSY2RRakV3dmVnRm5K?=
 =?utf-8?B?cGtyc0trVUEyRzBwWXd6SmFRakZXWFVXd2pPQjBlRmFXdkUvR0ttd000aGRo?=
 =?utf-8?B?TVMxbHhnL0FjSzNGcFBCQTBiTTlqcTc5T0l5OUxNZ05WSjZJd1ZFVU9IR3lF?=
 =?utf-8?B?dXV3UXlESGJYQ21pSGZWQ3g4bXBvN3d2WXhWYlNDekJVOGprRnM3TU9KNVdm?=
 =?utf-8?B?L2dCMUJhSGZDdE1JRy9sUjJyVGFQeTVPSEVFSFYyejBDL25uNTFEaEprTTNa?=
 =?utf-8?B?L3I1NGNxZ08wWDA4UTV1anJpaWNtYmFOcm1ZK2tnSnpOanRMYjZFK0M1WnM3?=
 =?utf-8?B?RXpMNlg5VHJxaFFidW5IUlRNTWhtekF5VkJWTGIrRStaV3Q5VlVqVjl5dGpK?=
 =?utf-8?B?cW1hcFh0T09OK3BrNjFaMnZpakFMc3RhZlVyWVRsZU5ibnRSZW55dG14YlhN?=
 =?utf-8?B?bDdLeWZxYmMwOGN4OERJcnVGbFkwR3Uwd0pubGtrUWdJa2JLc29jZGZUeS9I?=
 =?utf-8?B?OWNKRmFjTndsa3Q3YWNjMSswMVgrYmJhYTk3RFZvQVJHQnJGQnJ1QnkzbE5L?=
 =?utf-8?B?KzBLV0JyeHN5OUFLTzYxR1BPTFFzYitZcWZOT0ZHd1M5SFlkUEZNWldOK0RN?=
 =?utf-8?B?cWtnak85bnhZN0NFOS92R0pCeUpocWFXZTA2NXFvS2MrRXZPR1BrbTVGcDE2?=
 =?utf-8?B?VkVhdmFEcFJhUzZaN2JYeGI0NlRkZUdoZURBY05Za2xYOXRyMGJuN1kxcWZS?=
 =?utf-8?B?UVBFR2tlV24rYlg1S3ZseldjNFpwalhiRFlRK004QkMvK1Z0S2dQK09DTVhN?=
 =?utf-8?B?enNKeUJDU0Y0Z0VZcjkxSVd2bXdUK0wvb0FRVDNKRlhIWU9tL2M5M0RZYnh0?=
 =?utf-8?B?UTMvRHhwY2k4NGFPeHJxbmhWUjdvUkpqc3V3dUdBekpHWmdKK3hlSjAraWFw?=
 =?utf-8?B?aXZVSmEycUk0TG93RG5vZC82NFVZY1dYbEJzbVZjanhOL0NBVnhQQnJUOU1h?=
 =?utf-8?B?Z2N4eHd1am9ybkJDcWxNTE03ZFNJOXNlU0dGbDRmZlJtMXU1T3k1YlU5aEt1?=
 =?utf-8?B?MFVJMjdvLzdpc2xCTkczMkhXY1JHRVQrcW8yUS9WTUxFa3o0RmtyaGtPeENZ?=
 =?utf-8?Q?InRw=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 07:29:21.5373
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0c560b1-8527-4c37-e383-08de362b816d
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6925
X-Proofpoint-GUID: 9A4Q2i41YPmhqrVMr2CCd4-aB4G8TN42
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA4MDA2MiBTYWx0ZWRfX3TJMKH9HTzBE
 i2DsOHN6YZfPKN+GSugmcCVdjyJYMWP73c8yIcx3g5dSvc8wgXnAH1u9B213o5/nY8itllXmwW2
 su5rXMeJia9mGjE85T7LJZ1wGqobFYni6ftEepuX6dzSFsIMnvsWHOl8R0gM5O5RhBE3XaR7PTg
 wJWbULnLU77qSq8Dpohj1YLVBL/uIIUmqjK739RLE1Dce3DfWDEaamzw+FIOYH9Re0VPhxV72FC
 ZC7tqmBIBsuS1MIv1AcnDxNA0+5bdNGM/J8jtDinoAP+Gk1IZZ2f5sqKNxjY3V2pn8Xwcvsxrgf
 GJ7rJR//Pq36xUIh+BA6IW/arQFxU4MLVxWk3VVbOy7CjLY7R1V4B/MsGDuvjml6d0F279QWsNi
 /p5bxBEVMeyEkFHPwUP4JWJoqE34MA==
X-Authority-Analysis: v=2.4 cv=D4BK6/Rj c=1 sm=1 tr=0 ts=69367e55 cx=c_pps
 a=YWN1z1+lYnpGIt36WFtaVw==:117 a=uCuRqK4WZKO1kjFMGfU4lQ==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=XWp4PHTOCikA:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8b9GpE9nAAAA:8 a=WbBYHnI1PNLwm2dNkN4A:9
 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22
X-Proofpoint-ORIG-GUID: 9A4Q2i41YPmhqrVMr2CCd4-aB4G8TN42
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-06_02,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 priorityscore=1501 suspectscore=0 impostorscore=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 clxscore=1015 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512080062

Set src_maxburst and dst_maxburst dynamically from DMA
capabilities.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 drivers/spi/spi-stm32-ospi.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-stm32-ospi.c b/drivers/spi/spi-stm32-ospi.c
index f36fd36da269..d733e37f0435 100644
--- a/drivers/spi/spi-stm32-ospi.c
+++ b/drivers/spi/spi-stm32-ospi.c
@@ -278,10 +278,19 @@ static irqreturn_t stm32_ospi_irq(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static void stm32_ospi_dma_setup(struct stm32_ospi *ospi,
-			 struct dma_slave_config *dma_cfg)
+static int stm32_ospi_dma_setup(struct stm32_ospi *ospi,
+				struct dma_slave_config *dma_cfg)
 {
+	struct dma_slave_caps caps;
+	int ret = 0;
+
 	if (dma_cfg && ospi->dma_chrx) {
+		ret = dma_get_slave_caps(ospi->dma_chrx, &caps);
+		if (ret)
+			return ret;
+
+		dma_cfg->src_maxburst = caps.max_burst / dma_cfg->src_addr_width;
+
 		if (dmaengine_slave_config(ospi->dma_chrx, dma_cfg)) {
 			dev_err(ospi->dev, "dma rx config failed\n");
 			dma_release_channel(ospi->dma_chrx);
@@ -290,6 +299,12 @@ static void stm32_ospi_dma_setup(struct stm32_ospi *ospi,
 	}
 
 	if (dma_cfg && ospi->dma_chtx) {
+		ret = dma_get_slave_caps(ospi->dma_chtx, &caps);
+		if (ret)
+			return ret;
+
+		dma_cfg->dst_maxburst = caps.max_burst / dma_cfg->dst_addr_width;
+
 		if (dmaengine_slave_config(ospi->dma_chtx, dma_cfg)) {
 			dev_err(ospi->dev, "dma tx config failed\n");
 			dma_release_channel(ospi->dma_chtx);
@@ -298,6 +313,8 @@ static void stm32_ospi_dma_setup(struct stm32_ospi *ospi,
 	}
 
 	init_completion(&ospi->dma_completion);
+
+	return ret;
 }
 
 static int stm32_ospi_tx_mm(struct stm32_ospi *ospi,
@@ -899,9 +916,9 @@ static int stm32_ospi_probe(struct platform_device *pdev)
 	dma_cfg.dst_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
 	dma_cfg.src_addr = ospi->regs_phys_base + OSPI_DR;
 	dma_cfg.dst_addr = ospi->regs_phys_base + OSPI_DR;
-	dma_cfg.src_maxburst = 4;
-	dma_cfg.dst_maxburst = 4;
-	stm32_ospi_dma_setup(ospi, &dma_cfg);
+	ret = stm32_ospi_dma_setup(ospi, &dma_cfg);
+	if (ret)
+		return ret;
 
 	mutex_init(&ospi->lock);
 

-- 
2.43.0


