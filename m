Return-Path: <linux-spi+bounces-11782-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 86FC0CA6D10
	for <lists+linux-spi@lfdr.de>; Fri, 05 Dec 2025 10:06:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DEFD63048F88
	for <lists+linux-spi@lfdr.de>; Fri,  5 Dec 2025 09:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2E631771B;
	Fri,  5 Dec 2025 09:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="SLBLarON"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50A02FD1AE;
	Fri,  5 Dec 2025 09:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=91.207.212.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764925543; cv=fail; b=JjhumZiJ4X1CCvjvf4GVQjDwdYeqlVRTCQn4vTpasL7mqixSk2ixyr0cEiHJ8ntJmfdd6QOyiQ20cxpR049Kx4vil/MmhVSbVy1jPvs+Wvy/AkXSgSOERv/TZuuHK+RvnN5wfXxRKOeuHBCNdH3bc7QfOJbO5/vI18nkjW/G1ss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764925543; c=relaxed/simple;
	bh=KyuJVyemZVrEHX7JOqhlg47dhunWk1UfGwz4fr0NHPg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=mMU4abhD4OHXbMmapAUBIQHpn2BuB3aLWlJDm8bmOFO2Y/7VJ84eKcjc9wy8RLDG4zY0Z6Ocs3PRgTb3/o/rV7FaewjI+wOB4RNmPDAemryuSyv5KH/P4UEp96KfUcBpZIdaWvEMhRphmWQXQKKxtWOnaqHPNHKfHYnl7rlM+Fw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=SLBLarON; arc=fail smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B58p11F2028714;
	Fri, 5 Dec 2025 10:05:11 +0100
Received: from am0pr83cu005.outbound.protection.outlook.com (mail-westeuropeazon11010051.outbound.protection.outlook.com [52.101.69.51])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4aub8nb5a4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 05 Dec 2025 10:05:11 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mjCvGJYFUJ+Gary1OC4VoEyndE0SqcprN2z9C5mp45cEgxNbv2z3SfLA0jSzLy83Lj0X9mF41fCOW0F2qbcfyCvt9uszCZOGenA1dTIqPNEhjozXClzrOLNsFCoU52f4j3a2fc7QrI/4lF4cTQR0B/05QbUJ+KgWjkuHakGi0PZz+BH/Ipgwc+HWIbPkjL0D7gGhH/12eBCiEtWwXRS1/pyCrci3ZWpVjUE2Zj3MkjwS0kHK52GQEySgg1QHlaFpHBoxM+8A4JrVzPXU7ns9FihdX3RrswwwfVOiWfYd4PiDpasdgOx7nNAW2ri0g0KVTdqdio91g8oJjAwtUiv0Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W7Adm03ZmolD+QGZ9Jra6lR7ymFqBARLsD1zWwfnScM=;
 b=aIMxRfKIYBQahUaXeqKJCRtNF9FnCLB1Je7DeGOb5MdbyVqKfxyQ79EY1UFECXorQrMebJkeofxHfd8MD2udNDWAT0UrsqJAsGZHezMmOfkKFCQYuz6SYK7LP6VSoJwo9BqIDS8rVgoXI0dXQlqscPgR4izETRwfsYyBAOy2o9z0avnkp+s+Pvbe+S9CqmilddG7m3Nhuy1Nr3ljbaOLd2OEpXOhNinILotfNx1rZ4HMloxeIhX18h4W4OqnWh7ZV9GaCgKJ1eP91j/lTdSisxtyiUTRYtgXJTXYsn0bYuiLbhgfJ3TG1NW1ieqYOI3DCi0RBFqhLRPPxiIJZPpMTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W7Adm03ZmolD+QGZ9Jra6lR7ymFqBARLsD1zWwfnScM=;
 b=SLBLarONya4im4AcHRhkINp9C/6yGONlLiDqfNHMunX1KUOTcpnAhMuGia9GKsgjnBiS/z4HwJXk0c8p9JYRd5lPwfKkDXpDw9PqVrfhBC5rweoKsxCzUb2Rp0E7hoPrFxx7Je7a/4qq8ndva7+ycKdiKI+xSK9sy+o3UmhQA8pvtgzSSgVVM5CFJBVqkIfiAhcVZVUwnodeg5yqUFUpRPoN3n1R78pzFGqffiiWGkShty4bQFQbdf8pj4Pc50zbYmgQHpTOyvefIYvoB+sUo5FJFg+mFRuR3RgRQZbSs8fJ2i6W935rnHRttGxBcw/sg2aQ+c+yu18NVb9BO3itdA==
Received: from CWLP123CA0270.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:1d5::17)
 by AS8PR10MB7499.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5ae::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Fri, 5 Dec
 2025 09:05:09 +0000
Received: from AMS1EPF00000045.eurprd04.prod.outlook.com
 (2603:10a6:400:1d5:cafe::2f) by CWLP123CA0270.outlook.office365.com
 (2603:10a6:400:1d5::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.12 via Frontend Transport; Fri,
 5 Dec 2025 09:05:09 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 AMS1EPF00000045.mail.protection.outlook.com (10.167.16.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Fri, 5 Dec 2025 09:05:09 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 5 Dec
 2025 10:05:49 +0100
Received: from localhost (10.252.31.202) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 5 Dec
 2025 10:05:08 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Fri, 5 Dec 2025 10:04:54 +0100
Subject: [PATCH 4/8] spi: stm32-ospi: Simplify SMIE interrupt test
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251205-upstream_qspi_ospi_updates-v1-4-7e6c8b9f5141@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: AMS1EPF00000045:EE_|AS8PR10MB7499:EE_
X-MS-Office365-Filtering-Correlation-Id: 73961098-46de-40d0-c972-08de33dd6448
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QytkTU1EdDJaSFFwQjlTUXQ3MGRXb0ZkKzNpd1dUeEVTZXVMcU5MUGxLY1dq?=
 =?utf-8?B?N0ZoSkFtWW5ES3N6dlRMc2NuR05KTHJOak96OHBFdllGTTltbzJtMnpJVUJG?=
 =?utf-8?B?Nm00dWhoYjJJZW5BNU9oTldhTFJWaFh3ZFo5Z2pBTGJYQVlUOWZuSzJac1ls?=
 =?utf-8?B?SVhOSkZ1UjNMeUpaOGExaDVpVGJxYm9uQXFnZWFOYnc3UXpRT0FGOFpiUlJ3?=
 =?utf-8?B?ZGZ6NFVrb0Q1UTFkYm1rY1VzU1QwanVxazYxdnNTcmV5TTRZSFdqQkFPOWZh?=
 =?utf-8?B?S05HY2EwaUR6c2R3UnNicEJ6aFV6bjJETi9ualhXYlNDNGJmM2VOb3grWWp5?=
 =?utf-8?B?bjJ4SmhHTkovTVh0NjljbzRiMStzYlRzOXBDMlpoMHlaeXZNT0VmMlBXWkNW?=
 =?utf-8?B?VklwcnpFdDAxRjQvU2xFSFdsdU5BZUpDazBoQy9WMCsyMEZLWWFjd1JtOS9T?=
 =?utf-8?B?RFNnU2tiN2ZHMHNNb3JqMjhFaG9kaEhMcWpPallxVlJhOGRtMm5QbjhtRUV6?=
 =?utf-8?B?QmI1SmJhNmVLWlFTeENiakRiMEpONTloVytqRHlmYmZjM1V2anFqUHQ0Zmpt?=
 =?utf-8?B?YzZnR2xRRzREY0FyRThtT1JEWVBwOFNtdXhSL3lCVit0dlAyQUoybmUwbEsr?=
 =?utf-8?B?RmZkVGtaUHo5YkVuSXArQ3MrSW9jZlJuc09QakxsbGxDbnNCUU5mMWtUK2RU?=
 =?utf-8?B?YVBrWnlUODRTbjUzd1dIWng5ZWtFUlhlekEzMnkxK1VsQVVVRTJFaVdvS3gw?=
 =?utf-8?B?RlYvVWd6cDVBcVhKOXhSbGVvUmZwbEF5WE9HQ0d0SzNVeVNIVnVIY3JSQW9w?=
 =?utf-8?B?SE1xUmx3ZFhtMjF3V0pJWGc2eDRRbXRIaXZoNUtVSEpzZWwyM2lyUk1NRXFk?=
 =?utf-8?B?WUhrc1BYZnI2MHBxanRuY1I2QXZxekhiZzMzYmU4ME1YcmdqdWdJdUg0Z0lD?=
 =?utf-8?B?SldQQSsxVzJSQTVZM3B3N3UrK1MzSzdPUDRTbmtxbWQ3dVcvaFVodmpiZUNa?=
 =?utf-8?B?QjdJK2JFY0FEYVlLREV6M21YbmdSK1c0SXQ5N1p3TlQ1SzBQcVhzNlErUUdq?=
 =?utf-8?B?VFYyQ1ZWQ0IvdFh3WU1XUXVibW1kZzk5WE5PVXpkbWRScXpqZWxhRTZ0K08x?=
 =?utf-8?B?Z1ZIUXhva0lHckJZU1ZIOU1odk85ZmRia2tCWVc1em4vVVFuaTdZQ0Irb3FU?=
 =?utf-8?B?eDRZMzZnMWdTa05OYUdDbXRGandUMDBtb2lLUGJ4QUgyVE1KZXUya2ZJZWxv?=
 =?utf-8?B?ZFAyS3I5MkFVTG0wVERUa3l0c1BFYkpnYWF0R2ZueHJ1NzhZYi9xSEw2U0ZI?=
 =?utf-8?B?bHdzR2ZjeXZHMUxuTjkweDBGMHd2L2tQbHZKSzJFeENpSENQWXFNUmFzR1JK?=
 =?utf-8?B?QjZxdWRVL1pwL2NwazVEVWRQMWhtZk9MTWhjcVFXenZycHA5S0krOUhMRkJ3?=
 =?utf-8?B?TERVNngwQWlBY3V2bUlqbVdDUGd6MU9LczVVN011RmpKblFLQi9nUENqakZI?=
 =?utf-8?B?eHZQVFZkck9KRUxXWFlaNm1SZUc1b0tHQU41dTNIQTJMUmRsdXpyb3lKQjZC?=
 =?utf-8?B?MHZIWjU3YVVaL05TWXpwUnVGazBIRUZTNVBYSk92QzhWSEVsTDc3dnJkaVR4?=
 =?utf-8?B?M3NXWXl5eU9iNmtzUEtMQXNDcGlVbXRaN2pVd0VLNnlzZ1JrM3VISlVNMUtF?=
 =?utf-8?B?ZmVNa2xaRzllNjBBRzV0Qmk2NFRhUkxRUytMYk5LM1ZrUmpvWlRaM3FBMGNx?=
 =?utf-8?B?eEp1ek1MUjl5MEJmOEJuMUsxMnVXTUpJM0NzZ3g5WlBRVGl1TlhsY0FJWWhS?=
 =?utf-8?B?NlpSRTlUUlgzUGJFaHBKWGMxZURXb05Wd1ptL05ZMjhodDI4ZDgyY2F5R0JR?=
 =?utf-8?B?V0Nua3lsQzVaQjAzcnR5SjIzMTArZzNVY1ByQk0ybkc0QU1IVDh2QVhNL0lK?=
 =?utf-8?B?VWVraUlnbldvM1R1V0ozcmdwVmxuRVNnVXBhaTByejAyZC80K3JOLzVDNkU5?=
 =?utf-8?B?VEc4Z0xYSG9lWm1hcDRZVTVVUmRqTWJVS0FpZHg0S2gwNEhQTUUxb0dvMmRF?=
 =?utf-8?B?ckovWXdOSWlHVVRNWlRvaTFxS0JNNDY0WFNDOGtCZXlValJpM3B6amFHMGZH?=
 =?utf-8?Q?/rH4=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 09:05:09.5691
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73961098-46de-40d0-c972-08de33dd6448
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000045.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7499
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA1MDA2NCBTYWx0ZWRfX8PPqrrS0Nhqw
 +iPFMweJCfaco3HkxG/CgA4Qczl7gb3c5ROgnqozo3azW8+f34kP1E9VolYiEeiF3gUspV/xoDw
 AWZgii2x4z1vMFV2QeKng1MNqsaXRcUIkhznXdcwqEAL83285h4RU20CxDjKLcOEQLEhjmBjsAE
 Ad1hjxvFq3NpLsqhOm6nj4pvtAqCFtc+OZtkOEemQnWXjtbyGRqqZUbyQZ9kcSs3mHuI2ZCe1y+
 IE2H07g2nkGJb71Kk9eTnUeijz1/Am5WgC78yuRANk7UjtaqGETvlGTaDKNqafoLewi6RYGEe2c
 YJRzTfP6cwn9yW9xSBdGF6A6KihSW8MNqqrTGR/oozq8eqPZ/GEv24DoRo1v5rsDj7pgVT4T4dG
 L5MBNyhjIQVn4GHUyAvuoDdH9nd40g==
X-Proofpoint-GUID: fi9edONVHQTIuB6RIZYSNk4OinXSFjFe
X-Authority-Analysis: v=2.4 cv=X99f6WTe c=1 sm=1 tr=0 ts=6932a047 cx=c_pps
 a=QfNz7WxyfdFdmo+E+Fz36w==:117 a=d6reE3nDawwanmLcZTMRXA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=Uo5EeBN78AAA:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8b9GpE9nAAAA:8 a=y85xp1xkQ9wiHhBLIzMA:9
 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22
X-Proofpoint-ORIG-GUID: fi9edONVHQTIuB6RIZYSNk4OinXSFjFe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-05_03,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 clxscore=1011 bulkscore=0
 spamscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512050064

SR_SMF status bit can only be set if CR_SMIE was previously set,
keep status bit check only.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 drivers/spi/spi-stm32-ospi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-stm32-ospi.c b/drivers/spi/spi-stm32-ospi.c
index d8d72e2fb4bd..8f7bf6c582c9 100644
--- a/drivers/spi/spi-stm32-ospi.c
+++ b/drivers/spi/spi-stm32-ospi.c
@@ -279,7 +279,7 @@ static irqreturn_t stm32_ospi_irq(int irq, void *dev_id)
 	cr = readl_relaxed(regs_base + OSPI_CR);
 	sr = readl_relaxed(regs_base + OSPI_SR);
 
-	if (cr & CR_SMIE && sr & SR_SMF) {
+	if (sr & SR_SMF) {
 		/* disable irq */
 		cr &= ~CR_SMIE;
 		writel_relaxed(cr, regs_base + OSPI_CR);

-- 
2.43.0


