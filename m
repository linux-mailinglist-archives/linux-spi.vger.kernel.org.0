Return-Path: <linux-spi+bounces-11779-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B376FCA6D13
	for <lists+linux-spi@lfdr.de>; Fri, 05 Dec 2025 10:06:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D4DC3304A98F
	for <lists+linux-spi@lfdr.de>; Fri,  5 Dec 2025 09:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96FB3168EB;
	Fri,  5 Dec 2025 09:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="kURNmpe6"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6573176E3;
	Fri,  5 Dec 2025 09:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=91.207.212.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764925542; cv=fail; b=XGNGbZlbSTBn+p0fgs589NkAPMaAil6rRFL+6Fn2q7GAsONyc2Pkkf6ofKNxbP1QV2PhfUiRDEDcPsnhXJf9MzuESqDFNc14QeA46U82udUSYLS+z7rd1/Ioq/zZibNBHmhkb/LusCbWSJy8WzoCeCcY5WaalCgpj/1un1kyq70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764925542; c=relaxed/simple;
	bh=JTHC4Vw2LcFWfwD6Uki0JMnmf+zbeWhCAfnk2DPaeZc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=YXAS+w8788Ijrt1/SuwwYCOxMiKnTSQs6GLBemANYo2M/sXBLqntfJWGvUK5ZYTVEyScNd0xucpU0gTY7SjGDTAntZIZwQ6KOyVU6IyWsjIEMd1A/ujJkC1I2I+GIbYP2ZG7VPn2/fPuDIqFtJaWPLFkE+UaVhAKvckIxs2J/jU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=kURNmpe6; arc=fail smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B58o2Ds2026658;
	Fri, 5 Dec 2025 10:05:14 +0100
Received: from osppr02cu001.outbound.protection.outlook.com (mail-norwayeastazon11013026.outbound.protection.outlook.com [40.107.159.26])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4aub8nb5ab-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 05 Dec 2025 10:05:14 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BWKRoZSs6UYy4gXZyBdzYozmRuBJhQRw3qvfK4ilvw0Y9KqGM/4mJdResOXt9lAziZmGzuMk79V7ImKV21olNkJFMxs8FqAW/9RJfZ1c13EihRiW9xllyZsNGk+/dVl81AWKQvFaUeg4bfWPkrUU8i8N44NWNmyAn0mR+16M1GNPg5N/sYXQfDd1UkXFqy8pvKlx4gChCzCTtCnP0wsx052d2V/rrOt+uvAh33bW8IO0TLJdj63/y9bANNC1/UUbPBbRo4/zl+4dsfKKma1cC8djV93cIvnheWQ7sKD3LckddNHMrprBefgoSw4gFz2DI85CSQVyZAZsu0vGuVnQkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RdhBenL80j2dBguqTXmCc8UJoMc6CxAzHvkJU7sqDx4=;
 b=dkFdLuKcWU0/NmXpXR/fZ57jB0cKoWB1NDPG9XDAy10GgxUZ4R5nzJfl8YBjM5CywSVU9Xe6Vdm2Vc11Et09ObVbQzvIVWwSQACwsbVWBlQZqZhObdZ5COyo6Y4fGq80KCUcAwwBDrs3lK0lnp/Zj5fxP+y8l9gwvcAL+i4zG9M75PavBQ7d6ZhOYD4treH8Kp2SHFzSu2saXO4zS643BesStPEgNTpS9SSl5pP037mIa3cLbsp73O1GmhyAFKyP8QLzt8NBC8UJrk8PdJ5yLlIif/22421vAK6R9gbhVcsusCXp1Yn9nDhock0xoGwBq/ahUEdxKKtBZ8m+NEpZFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RdhBenL80j2dBguqTXmCc8UJoMc6CxAzHvkJU7sqDx4=;
 b=kURNmpe6TPfv7IkBBQ4ngtG9/C5Pvia6HCYCJQ8x2dMbuNc1/Dr+XjpCBbj7G0ZE56zS6tbjpQsViY7nPrKbS3lw8ltUd+jI1bTc7NKJKrWDawMfY5MECU9DV4QLnlemHZ3UMWKGsOmQF0Yls0j3RrulimYQnCwrZBuBlE5UTpgEeXo224diSM3d1gaRc33UxKW5437Pa6HdjRoptcKDy2fKcyN5sppJBHcMpdywb7K9zNRK521Djcc1W1F+o/iHJDmx7WxZb/9zV/NCcEQwjBGIaPEGVBQ1vYeZ3yI+cz6QgnhSqJ9AL7FhzObLZ2+AmHKL6X1IcNeqTiaa2gQIdw==
Received: from AS9PR05CA0032.eurprd05.prod.outlook.com (2603:10a6:20b:489::30)
 by AM7PR10MB3828.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:17c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.11; Fri, 5 Dec
 2025 09:05:11 +0000
Received: from AMS1EPF00000042.eurprd04.prod.outlook.com
 (2603:10a6:20b:489:cafe::cc) by AS9PR05CA0032.outlook.office365.com
 (2603:10a6:20b:489::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.11 via Frontend Transport; Fri,
 5 Dec 2025 09:05:11 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 AMS1EPF00000042.mail.protection.outlook.com (10.167.16.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Fri, 5 Dec 2025 09:05:11 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 5 Dec
 2025 10:05:51 +0100
Received: from localhost (10.252.31.202) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 5 Dec
 2025 10:05:10 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Fri, 5 Dec 2025 10:04:56 +0100
Subject: [PATCH 6/8] spi: stm32-qspi: Optimize FIFO accesses using u16 or
 u32
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251205-upstream_qspi_ospi_updates-v1-6-7e6c8b9f5141@foss.st.com>
References: <20251205-upstream_qspi_ospi_updates-v1-0-7e6c8b9f5141@foss.st.com>
In-Reply-To: <20251205-upstream_qspi_ospi_updates-v1-0-7e6c8b9f5141@foss.st.com>
To: Mark Brown <broonie@kernel.org>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC: <linux-spi@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF00000042:EE_|AM7PR10MB3828:EE_
X-MS-Office365-Filtering-Correlation-Id: 04a42ec9-a43c-48b8-df7e-08de33dd6566
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WE1rRStQc1hmaU5QVHp1dHYvT2V1VjlOUkFWN3dUZWdQUmIvK2d3SmF4Mzc4?=
 =?utf-8?B?d1RQNU9la2RXZ1ZZNzgxck8wdUZFZk0rMVJac2tmT0Jxa0krRXRpSDZVVFQ3?=
 =?utf-8?B?OVZNTy9ZcFZCUWdnelVNTDQyOVhVK1R2UmdGakRRYnNzZnhCU013eElKcmhz?=
 =?utf-8?B?bUFLaDY3blg2bUQyZnVxY3hKaGlKQXcwaXdjTVU5bERsQjJZUDRwRDZKNWVR?=
 =?utf-8?B?R3E5ZHJGVUF0T2lhb1RuVThUWDlFVFFLUlg3dkZNK05HN0M3aEcyWmRkWVdr?=
 =?utf-8?B?OVgvTGo2OHl0eDZpNFVid1JFdm01eldEZlRTclc0L3hPQk1qZHlWRGxrS1dS?=
 =?utf-8?B?eEtDUmpGZ1NJUTlldlhEWkFWL2orVmlPUnJUVlc4VzRma2kxWGZuM2F1czdO?=
 =?utf-8?B?VEVjRUhNWTBEZU12aFlnakNNc2ZYbU1FQkNKTHppblVsNGNzOHJTQjY4ekgy?=
 =?utf-8?B?L2RnZ3hwNkhWZE84K0JhUkJWbUhHaUZLRFFCZ1RsTm9jd3ZBQUxsWEd2bXpB?=
 =?utf-8?B?QUVOYU5YVDVwK3krZUJPcjFwWXJrMDA1Qlk0TGxJQ096UXROeVJuMG9Ka09u?=
 =?utf-8?B?clYxUmJaWm1PUmNTcElzbTJiS05zaUdocW9vRVpFOWJEU1BLUllSZjg0emhy?=
 =?utf-8?B?T0c4dUV3TTNUdEVKNW4yZjA2RXZua3hvRXVQc2ZUd0g5OW42cjZVYmdxcmZD?=
 =?utf-8?B?cDA2eWRDKzVIUUdMUnpVUUpOMDM0eUx1QStTWHFGSjJHUHZJTHYyMDRGQTJH?=
 =?utf-8?B?cFB2TFdibE80Mkc3THFCaW1nQlR3bzBqQUFZTXg0QWZqamkwWU9zSUd3elBl?=
 =?utf-8?B?aTI0Q0dwQUt5UEY1ZDhsU3NMaWxkSUN5UHRHNjJ2M3Z5cTZ2amY0K0VZMTVI?=
 =?utf-8?B?Ym5LT3EwNU01YkIyZ0FIbEp5bmNkWitzRXVBc3BIcUUxS0JEUy9pTUd2eXFF?=
 =?utf-8?B?K3ZOYmd2aUhyN2pqVUpUUTZxQnpYaVNRV2JxRnRSWFdTU3BUVys1VTNtVHZv?=
 =?utf-8?B?WnRSQVBEY2FTOXRQNDRSWU1TMzB2MDByZkUza2FvTTZObFJVV3NwakszemUw?=
 =?utf-8?B?eHhZN2tLbWwySVBFa0J5QkFDdTFJZ0MwLzRqMXkyTWtvKzk0Qm9HWG5kSW82?=
 =?utf-8?B?VmRncjZwKzlkWDFiYUFwNXQwNFVDZUJRQVAvckdoUTFMUGZzcFZNL1QrV0E3?=
 =?utf-8?B?WDZYNnNmZ2xTcWxGMGJXT0NHTG00MXVCQW50VVIvUWFlaWF2YzU5YlZRWEt5?=
 =?utf-8?B?NUZtNzRmT2lQaVJPc2l5QWp3NThKd21DaHR0M0l3b1lGUW8xV2hyQ1E1Z0pU?=
 =?utf-8?B?VkdKUjhOZGtPSEZUaDR5QkdTd0VONi80eUJxVW41SjlrSTk0RXhNaEhXN084?=
 =?utf-8?B?TjhFQlVEVHU0aUVCOWdycFkzWFhMOUlZbysxZWhxQ3pQRWlxOGRWRzdzbzgx?=
 =?utf-8?B?S2hlM2pSZ1kzRERJVUhyMTM2ZHpDazNLS2lBNGgySXA3VEFWMkx3MS9aYnFL?=
 =?utf-8?B?YXhuRjlRQjY3YjBGWG81M1N2eUNveDRNRXdWbW4xR205cHp6ZXZtRkhuUGgy?=
 =?utf-8?B?ckdEa2NZR1FYQUgwU0Q0L3ZsbVU3aXFRTDlSSGt1VmdjUkVDc2wvMUhObEJy?=
 =?utf-8?B?TEppU3BSeVRRdy9QOGNNK1hINnR2cFllSFZLSTVWZ0hjVGEySEpqUWppTkFi?=
 =?utf-8?B?R3dVcDM4dDJweU82Ykc5RVpud1UzYThOS2ZWOUNTTUpJemZuUk1tbmVOVEM2?=
 =?utf-8?B?VXV3eXFtZFRiRnVmaG05ejZyMTUxZVE5U3lJbUNWeHJVVTA1enpVL0hpcU01?=
 =?utf-8?B?a2xNYzBSVkltK0VHQ1VFd2ZZWVpvOG00d0trb3FkaERZcGZ5MWJqdzVFOVFj?=
 =?utf-8?B?T0lKNFJPNzNzMXRVM3I0SGZvZHp1bzBuNnFWL0FLSjM3RllCbHMrYWtwVFlD?=
 =?utf-8?B?TWZnR0o2Kys5U2lHRHVpSTU5QnBNWDBMUDYyZVQ5QjNsWU0xajZYOG1FdTVB?=
 =?utf-8?B?cWhIazgvcStTMEFXOEpKRjZKZjhzaWozcE5yMERJZjFHUGFldFFFNzU3Q1dD?=
 =?utf-8?B?YjdReXpOa2JnRGUxV1hjbVp2QXZDY1RJdm93RXV1S0Y0ZVE3eGdra3VEaEsx?=
 =?utf-8?Q?XcRU=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 09:05:11.4352
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04a42ec9-a43c-48b8-df7e-08de33dd6566
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000042.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3828
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA1MDA2NCBTYWx0ZWRfXzWpGgwBUYMY/
 ZG8ezPiMyJ/WdH2eH+2RleU8QQi/duuWkLW5hnmQxS3gzhZRdKh6wfaDHlmcYdX831toBHWnEz3
 bfwHlMLTl2hUsa9wmfQcvR63772pyOzSeRYjIusl0Zo+XDhEOlQ8XGcf8/Pk6EaCMjqN71vbAX0
 h+Lo6QtSGJxzBgArRJGd2XuF8/U5hQbADOw2QVekTugeZnrjIyPnT2MkjytUv/MEIShQBJikyhQ
 S9z6jQ8X0/6jX4zFVvscRgkkIXJyPk8OL1VQ/b/r8yS/hlaXi2R7STGjOBkhl/NF85Ou88ziCSv
 t3EcywMS8t/G6vFI1Rr8H49Xmeh+rFXGm+kP3K9q3hDW8bIE0LJiNJX1YBpwl/Qom/Nl3pCDhGC
 YI+eTpV0AFjE+SP6U7DCnJBCtPteLQ==
X-Proofpoint-GUID: OMwyM47jobvnKVghnr_ZPQsJlWBNgMwe
X-Authority-Analysis: v=2.4 cv=X99f6WTe c=1 sm=1 tr=0 ts=6932a04a cx=c_pps
 a=lo7lgCOeVt8OyxGStfpnzA==:117 a=d6reE3nDawwanmLcZTMRXA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=Uo5EeBN78AAA:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8b9GpE9nAAAA:8 a=H034yFGYOyrU3Mls5rUA:9
 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22
X-Proofpoint-ORIG-GUID: OMwyM47jobvnKVghnr_ZPQsJlWBNgMwe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-05_03,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 clxscore=1011 bulkscore=0
 spamscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512050064

FIFO accesses uses u8 only for read/write.
In order to optimize throughput, add u16 or u32 read/write
accesses when possible.

Running mtd_speedtest on a 4MB sNOR partition using a
stm32mp257f-ev1 board gives the following results:

           before        after   gain
Read :  5773 KiB/s  22170 KiB/s   384%
Write:   796 KiB/s    890 KiB/s    12%

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 drivers/spi/spi-stm32-qspi.c | 51 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 40 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-stm32-qspi.c b/drivers/spi/spi-stm32-qspi.c
index c131441e4dd4..c7f2b435d5ee 100644
--- a/drivers/spi/spi-stm32-qspi.c
+++ b/drivers/spi/spi-stm32-qspi.c
@@ -153,34 +153,53 @@ static irqreturn_t stm32_qspi_irq(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static void stm32_qspi_read_fifo(u8 *val, void __iomem *addr)
+static void stm32_qspi_read_fifo(void *val, void __iomem *addr, u8 len)
 {
-	*val = readb_relaxed(addr);
+	switch (len) {
+	case sizeof(u32):
+		*((u32 *)val) = readl_relaxed(addr);
+		break;
+	case sizeof(u16):
+		*((u16 *)val) = readw_relaxed(addr);
+		break;
+	case sizeof(u8):
+		*((u8 *)val) = readb_relaxed(addr);
+	};
 }
 
-static void stm32_qspi_write_fifo(u8 *val, void __iomem *addr)
+static void stm32_qspi_write_fifo(void *val, void __iomem *addr, u8 len)
 {
-	writeb_relaxed(*val, addr);
+	switch (len) {
+	case sizeof(u32):
+		writel_relaxed(*((u32 *)val), addr);
+		break;
+	case sizeof(u16):
+		writew_relaxed(*((u16 *)val), addr);
+		break;
+	case sizeof(u8):
+		writeb_relaxed(*((u8 *)val), addr);
+	};
 }
 
 static int stm32_qspi_tx_poll(struct stm32_qspi *qspi,
 			      const struct spi_mem_op *op)
 {
-	void (*tx_fifo)(u8 *val, void __iomem *addr);
+	void (*fifo)(void *val, void __iomem *addr, u8 len);
 	u32 len = op->data.nbytes, sr;
-	u8 *buf;
+	void *buf;
 	int ret;
+	u8 step;
 
 	if (op->data.dir == SPI_MEM_DATA_IN) {
-		tx_fifo = stm32_qspi_read_fifo;
+		fifo = stm32_qspi_read_fifo;
 		buf = op->data.buf.in;
 
 	} else {
-		tx_fifo = stm32_qspi_write_fifo;
-		buf = (u8 *)op->data.buf.out;
+		fifo = stm32_qspi_write_fifo;
+		buf = (void *)op->data.buf.out;
 	}
 
-	while (len--) {
+	while (len) {
 		ret = readl_relaxed_poll_timeout_atomic(qspi->io_base + QSPI_SR,
 							sr, (sr & SR_FTF), 1,
 							STM32_FIFO_TIMEOUT_US);
@@ -189,7 +208,17 @@ static int stm32_qspi_tx_poll(struct stm32_qspi *qspi,
 				len, sr);
 			return ret;
 		}
-		tx_fifo(buf++, qspi->io_base + QSPI_DR);
+
+		if (len >= sizeof(u32))
+			step = sizeof(u32);
+		else if (len >= sizeof(u16))
+			step = sizeof(u16);
+		else
+			step = sizeof(u8);
+
+		fifo(buf, qspi->io_base + QSPI_DR, step);
+		len -= step;
+		buf += step;
 	}
 
 	return 0;

-- 
2.43.0


