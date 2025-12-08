Return-Path: <linux-spi+bounces-11820-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A48CAC5AB
	for <lists+linux-spi@lfdr.de>; Mon, 08 Dec 2025 08:33:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 54EF5305223A
	for <lists+linux-spi@lfdr.de>; Mon,  8 Dec 2025 07:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F7B7257855;
	Mon,  8 Dec 2025 07:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="G8EAm6A3"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5916D1DD9AD;
	Mon,  8 Dec 2025 07:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=91.207.212.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765179001; cv=fail; b=MgTrNwI8rMEkuz47e+ZOqfwtSmimUFsd+pybVhq/JHPTQGLq89NSQbRTyxM1xqUPu5t7qCftwMaXQtKtVKbjnzc6YmdMawXa9lORS9HlkARAhQoXqdpYZsfawozcoJ4LL1IM1C6Oo1DJH61BrOVEo0UU4TJDVPi1P2tB5mqaB1A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765179001; c=relaxed/simple;
	bh=OHkYNYen9RPXchyTEhR7wD+4A3GE7157el6Gigpq/Yo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=BgjOynXltyS7iwifofdDpWAcoWAMUWebf514iwFGz2BSyyOdaUkv9picAh5N7eHDgTGCTwIspDsIZHVrxPxK9fzV9V0MzMmiia1TUyYSWTyXCnKmzKihJ5TWjVbOMRUGtDa8AC13GAP5AJDw6r79u8skUzWsFeumqXlAR+Gi/Ws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=G8EAm6A3; arc=fail smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B87O0WF771933;
	Mon, 8 Dec 2025 08:29:28 +0100
Received: from am0pr02cu008.outbound.protection.outlook.com (mail-westeuropeazon11013008.outbound.protection.outlook.com [52.101.72.8])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4avc8h4u38-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 08 Dec 2025 08:29:27 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hYFj37/c3xyC9IFjJ72QlYYXyegtO8mV6dDkT4jvuUdPTOY3hedP2vkxelbFW7H9c7TRC3z1q8ZYyivU/4bZ/zcXvqw562q4Fkc2UXxJbxOxkOynIDIHRlkjqpV/MA2U4j2fRSzB6FAxGhvNxqTZqgevOnt4mzW2VKcbrbodt8G6eb/qxK3hK92dffg5axtk/YWX0m8K3JSVu01yLZfD5em1AYq4f1pe2YavPmPk/O75N0yDtmC5v6tXVWfVegONxXBfGjCrFUC9cwxNa7pdpwBdUdQ965ncQY/axITUNA3ZfJbVEDmuAHJvWbXoSuksfeXUET+VxL6Wz5ja0zygmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v0vTwNjiY8bhTPslFOoMV6CyHWS6wLmqOceYoiEQltM=;
 b=uFGcgH8QII6r5Xfo6zT5FWqvD/sx0Asgwnigq3W+FC2hukhKoddDxy+4CybwW0zrPbeGGAdfnXUuvqLKSYDrgm1fUkk3iIEA/VFBSVtQKC3XLVZtL3/gR/GQ3CZzgFSE7N3xdGnQeSQCs04hmnImRn6WWNL3P8N4nKmXKLHJIMaBpWAiOEivPcRYzfgkZ4zKwOYd694rhOGJW63BvYjwRJYFAzz6YjzDBZZl26T1o7H+eBb49dJ6qg+jchb8u77EXh23NcOlGE1/ILnOiZeAJEmKUw/f8QPgKcuQhfGwY//KQLbQvtywfIqa7Y0xpW5djs/2QFcIpFFMDRdCVYk8xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=st-md-mailman.stormreply.com
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v0vTwNjiY8bhTPslFOoMV6CyHWS6wLmqOceYoiEQltM=;
 b=G8EAm6A3WpmDrmG0/Z3JPRFar9HeAlMvwKPVYtAQJIT6sw5ib7/ApsJw2bj3SHwKFWZd+FiTWbE/dsY0ZSIvqlGNnyWEESYMyoD6sxv+RLRynp5dUC9ijMMd2gblSZAelj8EnslfDQhCPIlO9YtadHg2U/fZG3YqNc1BRJsOekQvV7Q814LIxTI42d8LqdA1P3Oa0j1sLyM5vUQTb0GzBDnMoYRkRofzBRTSq5AVZXXa4XL/Zg5QGXrNYxscQS1ZrXoQyORyLzmYc90fSLotcSOsUi7L5AwL1IrJ1zsQXMAKMz5PW/2onquPtfgfzr2e7O/h6fG7Jh9UPwY56VL5kA==
Received: from AS4P189CA0027.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:5db::16)
 by VI1PR10MB3327.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:12e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 07:29:23 +0000
Received: from AMS1EPF00000046.eurprd04.prod.outlook.com
 (2603:10a6:20b:5db:cafe::a2) by AS4P189CA0027.outlook.office365.com
 (2603:10a6:20b:5db::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.14 via Frontend Transport; Mon,
 8 Dec 2025 07:29:22 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 AMS1EPF00000046.mail.protection.outlook.com (10.167.16.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Mon, 8 Dec 2025 07:29:22 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 8 Dec
 2025 08:30:02 +0100
Received: from localhost (10.48.87.93) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 8 Dec
 2025 08:29:22 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Mon, 8 Dec 2025 08:29:10 +0100
Subject: [PATCH v2 3/8] spi: stm32-ospi: Remove CR_TCIE and CR_TEIE irq
 usage
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251208-upstream_qspi_ospi_updates-v2-3-62526c9467dc@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: AMS1EPF00000046:EE_|VI1PR10MB3327:EE_
X-MS-Office365-Filtering-Correlation-Id: 4310b7e1-a271-49d1-6c13-08de362b8231
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M1N6OHpNSnNoQ3BLLzJXRzFTT2JBd3RKb0JoSjlNZ0ZaVkxheU1QS1B2M1JW?=
 =?utf-8?B?MkdRUEZoTE50TzJhZXpGNEw0d1hLMHBBR3Yza01Tem9COHRLRnNvMUZHWVlX?=
 =?utf-8?B?NEdLQmNPUmo3T3NiRzlyOGt3bHBSWUJnVnJtazc2bGxxbGsycUY4azBFb3lT?=
 =?utf-8?B?akUwekFWMld4M2NaMmd3LzIxMXp6clc3QXZMUXE3cStpVW84NnN6Mk80U0hK?=
 =?utf-8?B?WWhOZFhGK1h2OC9LRnBLRFpGOExleXJKTlpXRE1QUlErZVdMd093bmVTdE1Q?=
 =?utf-8?B?S3lEY01yNk83WncvYmZoaEJxa2Z5My95b21kSE41Z1cwYzhCYzNYdTlhN2Q4?=
 =?utf-8?B?VEtmVXVyMk1tNTJLMEQyUHJYQi9PSnlxbVptaWZsRE5PTUxRZW9BZDQ2YWpr?=
 =?utf-8?B?ODFLeUQzZXlORVVhT0l1Tzl3bmdrVlVjWjExM1pFUGhXdXA5R2NUSjVYclFS?=
 =?utf-8?B?VmVlV2ZMazROKzE3YjdHT2Y5dHNidGZtZS9SYWRrYWZiL05VNzJkLzV4Z1BD?=
 =?utf-8?B?bjZLaGRIbi9DRUU2MGkydjVTaHFKYXQ3eTlwZEU3WDRlRWdzL0prVFp4UDZ0?=
 =?utf-8?B?MFZaL1M4ZExDbkNwcU5QSyswS042dFdOa2ZzUkgraG5Lell3VllKNFJCUjM2?=
 =?utf-8?B?b1hKMlEyUkJHc1l2VjMyVEdnZ1E2MjJLVzBNZzQwc1V5b2I0bmN4bEl2KzBs?=
 =?utf-8?B?Rk13anpLQ2pEbnhaTWM3UEN5NWVVVmRGYW1ibXplTnJvQmMwK2FWTkRxbVJH?=
 =?utf-8?B?aisrL0pOSVNxSGtsWHRPbFFXMWtZeEZZTlNKVHN4dG1YNUUwQmxnRWlyTHlw?=
 =?utf-8?B?UElSMjViTHdNNFhZRmc0b3dJMm5WY3QzUXdRYS91UzdiWStYbi9ScmxUT0Er?=
 =?utf-8?B?ZmN0L2xraTZiRVhOeHNYSmI5VnB3bmJialR1U0c2M09odW1QR2FqcytXTGN6?=
 =?utf-8?B?SUJCUHlLVEN4cmxJRmZhSUJUdDdxLzNFaGJjR2pPVEc4MW9zZHBhb2NZZ2VI?=
 =?utf-8?B?NkZmMlJmcUtQMUhYWGxYYjZLNEx0ZmRROER1RU8wWFZhcXNqSXlpcFlKeFJ5?=
 =?utf-8?B?aTBmUXdxbzJhNnVXMkd6ZHdpMUpZTUMxd0FnNFl2QVMzYzRvekgvV1Q1anh5?=
 =?utf-8?B?YUo0d0djcm85dWhEOFJoUkQxY2FlaC9iN21wTzNMOFA0VGNoWUZNN2dlenhz?=
 =?utf-8?B?bEttR1JMTVowMFBOaHJ5WmdLMi95WC9IU3cza1lJU2YxNk5sNldMRi91dXYz?=
 =?utf-8?B?N3k1YXovaEg1ZDdtV3ZGSEpJTzdYLzNqaEhTYlVUTEJOWU13THVOSlQyK2Nz?=
 =?utf-8?B?M3pZb2N0M2FsTEgycloydEdJdE44RkdZV2kxZG5rNVNtRGQySGpEd21lR2Rv?=
 =?utf-8?B?Y051aCt6SVd1UVcvVmtab1Fvb1IwS04wN2FPVDFqMm1hblZhQzJPRWhoY2pa?=
 =?utf-8?B?NFVUcTlPNjE5VTBNaldDaWtoakxhd2hlRllkZmhuRDFiYVFHVGZBNUY1UFVI?=
 =?utf-8?B?bW5haDRCeXJnd0tXdWRkdTVLZ1JqMTFOcFg0eElwRGR2SDJIOHk5eEYwaGNp?=
 =?utf-8?B?VEdmVDgrREcybnRtTUduMDJsVEwwVUVCV3VRbkoxOGtIZXYxZnJUU0N4cmJq?=
 =?utf-8?B?ZGlKc1ljRkxVSmFVUHEzb0tXRXZEWldiSk1kNDVnMHhnMXZSeEkyWWdUbkt0?=
 =?utf-8?B?a2g2UVpRQmdLOTZZcldQaVNEVjlyNlJJTzd2RjNQSTllclo4UG1DNDZoRGpE?=
 =?utf-8?B?Q0NrWWk3N2NCN2M0R3Qvc3UwTmtDNmJ4cmtOVFVnSVNUcHZWSVlkd0tUdUg0?=
 =?utf-8?B?d1NLSzZEbGNPZGJvaGlvd0grY0wyZ3JPREloZHo5OTlsTmpXN1R0OEw0dGZV?=
 =?utf-8?B?Q29tK0piaEtIVEIzaG16NXR4em5HdnZ5Zll5RnNxU1R2NWVCeEpXc3dUaVhD?=
 =?utf-8?B?azBJdjF5VGZDRkcvU0tHT2R2dC85V2R3dGpoSGVWYWpGUFJpSExFNTZBNEU0?=
 =?utf-8?B?Q094NVY2RlBSZW12Smp3YTVYcDk1SmZjUlNxNE5kUE1OTCtuT2tRWWNlalBI?=
 =?utf-8?B?clVMOUNGTzAwajJ0bmppVXZtcElWOUZRdSs5ZzNVOVZUcnllQjdtaDMrYmdo?=
 =?utf-8?Q?dZGM=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 07:29:22.8071
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4310b7e1-a271-49d1-6c13-08de362b8231
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3327
X-Proofpoint-ORIG-GUID: gyQg6iM8V09FYDdBX0QiwZQYROIPbLfV
X-Authority-Analysis: v=2.4 cv=JKk2csKb c=1 sm=1 tr=0 ts=69367e57 cx=c_pps
 a=6Kf4RVHJovTFG9veQ3L6kA==:117 a=uCuRqK4WZKO1kjFMGfU4lQ==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=XWp4PHTOCikA:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8b9GpE9nAAAA:8 a=4C2JBV8IMr3zZ6XvoZwA:9
 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA4MDA2MiBTYWx0ZWRfX9iIEmpa9LPQ8
 +PVdxFIJaMgT/x9OdiayxXRUqpyqXr19rTOgWrSzn4wMnpe0r/NbMCDzc5CAz/8zwKjjtzIhbMO
 gN8S9GNwZoWLS0FUvQ6Sz65ZbSmFvagTDtVQJOhpagGCPEd5UnUpCQP7aKNITnFraC5N4vrkDea
 P6b053S8BDJw39cv76pqphGr6AtKKHi7VP4KYlMOzYRd7WYlfbI67QZUDLKwZBdxpUCwyqnobtU
 krd6rZRzriPpMNKQWD3gFfs7BOPvatHA+QYH4t/BEiPVr1gZQ+LXYcRz5Ey8cn/tyKoexoOia3U
 sgSaPweebHj9cVVDFgnDl3SRDt7vgnQsIyy/W5YPJSt3y8D7IWgxdIUjcyuOg4n5z6Qd4Vs9NzS
 1Wowie1wRLKRu3K/JOwyojXW1+DAIQ==
X-Proofpoint-GUID: gyQg6iM8V09FYDdBX0QiwZQYROIPbLfV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-06_02,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 adultscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512080062

Replace CR_TCIE and CR_TEIE irq usage by a read_poll_timeout_atomic() in
stm32_ospi_wait_cmd(). It will reduce the time waiting for TCF or TEF flags
to optimize throughput.

                                           before     after
average time spent in stm32_omi_wait_cmd:  5685 ns    923 ns

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 drivers/spi/spi-stm32-ospi.c | 31 ++++++-------------------------
 1 file changed, 6 insertions(+), 25 deletions(-)

diff --git a/drivers/spi/spi-stm32-ospi.c b/drivers/spi/spi-stm32-ospi.c
index a6f53f06200e..06632cdd1630 100644
--- a/drivers/spi/spi-stm32-ospi.c
+++ b/drivers/spi/spi-stm32-ospi.c
@@ -34,8 +34,6 @@
 #define CR_ABORT		BIT(1)
 #define CR_DMAEN		BIT(2)
 #define CR_FTHRES_SHIFT		8
-#define CR_TEIE			BIT(16)
-#define CR_TCIE			BIT(17)
 #define CR_SMIE			BIT(19)
 #define CR_APMS			BIT(22)
 #define CR_CSSEL		BIT(24)
@@ -106,7 +104,7 @@
 #define STM32_ABT_TIMEOUT_US		100000
 #define STM32_COMP_TIMEOUT_MS		5000
 #define STM32_BUSY_TIMEOUT_US		100000
-
+#define STM32_WAIT_CMD_TIMEOUT_US	5000
 
 #define STM32_AUTOSUSPEND_DELAY -1
 
@@ -116,7 +114,6 @@ struct stm32_ospi {
 	struct clk *clk;
 	struct reset_control *rstc;
 
-	struct completion data_completion;
 	struct completion match_completion;
 
 	struct dma_chan *dma_chtx;
@@ -240,22 +237,16 @@ static int stm32_ospi_wait_nobusy(struct stm32_ospi *ospi)
 static int stm32_ospi_wait_cmd(struct stm32_ospi *ospi)
 {
 	void __iomem *regs_base = ospi->regs_base;
-	u32 cr, sr;
+	u32 sr;
 	int err = 0;
 
-	if ((readl_relaxed(regs_base + OSPI_SR) & SR_TCF) ||
-	    ospi->fmode == CR_FMODE_APM)
+	if (ospi->fmode == CR_FMODE_APM)
 		goto out;
 
-	reinit_completion(&ospi->data_completion);
-	cr = readl_relaxed(regs_base + OSPI_CR);
-	writel_relaxed(cr | CR_TCIE | CR_TEIE, regs_base + OSPI_CR);
-
-	if (!wait_for_completion_timeout(&ospi->data_completion,
-				msecs_to_jiffies(STM32_COMP_TIMEOUT_MS)))
-		err = -ETIMEDOUT;
+	err = readl_relaxed_poll_timeout_atomic(ospi->regs_base + OSPI_SR, sr,
+						(sr & (SR_TEF | SR_TCF)), 1,
+						STM32_WAIT_CMD_TIMEOUT_US);
 
-	sr = readl_relaxed(regs_base + OSPI_SR);
 	if (sr & SR_TCF)
 		/* avoid false timeout */
 		err = 0;
@@ -293,15 +284,6 @@ static irqreturn_t stm32_ospi_irq(int irq, void *dev_id)
 		cr &= ~CR_SMIE;
 		writel_relaxed(cr, regs_base + OSPI_CR);
 		complete(&ospi->match_completion);
-
-		return IRQ_HANDLED;
-	}
-
-	if (sr & (SR_TEF | SR_TCF)) {
-		/* disable irq */
-		cr &= ~CR_TCIE & ~CR_TEIE;
-		writel_relaxed(cr, regs_base + OSPI_CR);
-		complete(&ospi->data_completion);
 	}
 
 	return IRQ_HANDLED;
@@ -884,7 +866,6 @@ static int stm32_ospi_get_resources(struct platform_device *pdev)
 		dev_info(dev, "No memory-map region found\n");
 	}
 
-	init_completion(&ospi->data_completion);
 	init_completion(&ospi->match_completion);
 
 	return 0;

-- 
2.43.0


