Return-Path: <linux-spi+bounces-11817-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 20691CAC58D
	for <lists+linux-spi@lfdr.de>; Mon, 08 Dec 2025 08:32:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA2403047906
	for <lists+linux-spi@lfdr.de>; Mon,  8 Dec 2025 07:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B59B28135D;
	Mon,  8 Dec 2025 07:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="YRkyKqHc"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFEE2517AA;
	Mon,  8 Dec 2025 07:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=91.207.212.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765179000; cv=fail; b=DV8oC3BKqEdlB2c3loDB5nazsKPaLjqhwjXBkeLCO8f3HhYXTkQFttaXgT45wtuLc2R+pSQ4nMNBVG85jZb5bBTV4C/Eqjqvdh+iY5aNoqusI2f7DstVPeiBtCJGwHzf987EcpjlMqHv9d/H1Mx1ZydWgluICat6h2AhsZSiTCE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765179000; c=relaxed/simple;
	bh=KB8SeaJv9KC2JD4D/BJJoOV3rEmdcNd/02A/f2SpRn4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=WWqvhFgbjvNKws5Zue7nCOaWnmFiFLZuas3tAvjKYk2k2vyd3nNT1oeBBrCmm933M87qtepD/9w1hF9fqTgz8ao2EMYRayj/m6bNWc9J7Ozc+Ui9VjkgoFldqi/rQWGvfv9npGzgkuqR3cSzaGYhZz8cA/RjYkyOm/OR/GNK67g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=YRkyKqHc; arc=fail smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B87LSQn889911;
	Mon, 8 Dec 2025 08:29:29 +0100
Received: from pa4pr04cu001.outbound.protection.outlook.com (mail-francecentralazon11013021.outbound.protection.outlook.com [40.107.162.21])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4aw0aqapnt-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 08 Dec 2025 08:29:29 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r/5g6IoynRzaQcBcb0t4CL/T3OyV9GtkdWSthmV3KP6H6TKp1J0cUmsyqwb8NMfjFgBCXDR2dXuiFvSCVYl+lzNiBMQTKJDYgg+tlCbtpG8oULmch96SGaQZ7AwWnRPYXB3+KQigmjGRKDRidD3byQ1oXDP70VXFqi8ka1SFExDLupJozsG+F/ztON/27RTG/rH7t1cdJVIViqZDec5JtVfcu8dDr51EYQqV+lg1snMv6qoAXOH16Z7fSp8ME9DeAw+kmA8a3PEagLdX7PdCw06JbtGQDfmots6wq/PPcdq6q0Y//AFa9tKjqTFUypsLzyNXYjKxm5dHDyZFytOsRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T/h+ttQocpyxLUgaIlzx3iwhuSNneCP2ewSMetvTTdo=;
 b=HaTOaJEH0fB9jpLgmUMHXws4mUXzNtTXh5Lv/pVERK381UeuIHl/qWpn/kXQ02k6FuLhzMYuymNKdwiSfi6DgqNj2amrCzNfJNvnN31EZ2ym4jGfuvXG7tzu9eU0pYINBDbzvitZ1pxjxl3Lcw7tqLjqIfWp64HSfYnIqB3oUXDBOAe2FV7aY7DKmH0y0wnmN4IBgSDw73lHaEwhEQcFj7Fqi1j00S3PRMpTpQ0uB/QoQ3+H1WUd1LshQ6Tj/T4zhDwSunYYOsprwtN2rarjc2mHh4qHoQjxC19rtVkZIzsyQo9TVtD2aSKElF0dJjVMaFAcga7T1MxxfQziDckWmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=st-md-mailman.stormreply.com
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T/h+ttQocpyxLUgaIlzx3iwhuSNneCP2ewSMetvTTdo=;
 b=YRkyKqHcHdEP/lbS0/jNA4Zelihgq/AP4KcESlERcbfQ3yaUfn4KXuxqqc485+UhH0w1Uw6AN05x7RqhoFhk8DL17laecNVKQV/GAO8r+GfTiowmSKKjbJq3tInnM2471N+oiwmYgPWDu1Wt6oWsN3VUKxfcZXw/rGlrFLE3GLobyd4qgUT03D/38IOFfIqK/sdwNvRNPoDcNzR1Iw9pfnynFJTHES3s0NR4F/COxOhFHiRcGaINkw5Dvg48aViKK1UU56jhOGKuwd58upfD0VFGAmHxWm/7LbEGBvt9nnzxhTsegMm1r69H/AfraZNC6li1EzAfp81SPEml2HmAyw==
Received: from AS4P189CA0003.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:5d7::8)
 by GV1PR10MB8821.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1d5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 07:29:26 +0000
Received: from AMS1EPF0000003F.eurprd04.prod.outlook.com
 (2603:10a6:20b:5d7:cafe::c7) by AS4P189CA0003.outlook.office365.com
 (2603:10a6:20b:5d7::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.14 via Frontend Transport; Mon,
 8 Dec 2025 07:29:24 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 AMS1EPF0000003F.mail.protection.outlook.com (10.167.16.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Mon, 8 Dec 2025 07:29:26 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 8 Dec
 2025 08:30:05 +0100
Received: from localhost (10.48.87.93) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 8 Dec
 2025 08:29:25 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Mon, 8 Dec 2025 08:29:14 +0100
Subject: [PATCH v2 7/8] spi: stm32-qspi: Remove CR_TCIE and CR_TEIE irq
 usage
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251208-upstream_qspi_ospi_updates-v2-7-62526c9467dc@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: AMS1EPF0000003F:EE_|GV1PR10MB8821:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f647643-2cf9-47c1-4879-08de362b8442
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SmcvNXh0ZC9zUk5Ob21NTDBUK1djV25RUS9YSzBOcXRsOUZNMUdlYlVsVHNV?=
 =?utf-8?B?QzJKQVRncXR0UzBDMEM3TW1sODZmRFJzdHFhbVFiYkhmemxlT2xjNkV0L0Vo?=
 =?utf-8?B?SU93aGYyZzgxWXNjQ2tQOXZFWXFKbmlCdG5yL3ZZNG5vQ2Iwc0lxWXJRdzQ5?=
 =?utf-8?B?ZHdoUE52SytFS09IZ3VCbnprWjM2RG1JNHU0eDZ5UVdwK0tnMWNjVkRjZlJC?=
 =?utf-8?B?ZmdjVHRadVBuRFlpOWZScGxlZ1pyOUtHUnBpR1JwSzFiNEtsLzFtWElDRG1n?=
 =?utf-8?B?TDEvTjJ4SHdzcXdVc0xWTWdyS1grUSt4NFJPWHhkQkdIS3JGVFEzOE1nS01y?=
 =?utf-8?B?NzR0VTFqT3ZFOFliZXVHZTBIOThYY2F3OGt1MnRTUWFvVlFuU0xDd0xtSkJ5?=
 =?utf-8?B?REFydktsMzY4UjZzdEw0UzNYQ3hBaU1FSEcvQlI5SUsrL3I2ckRyRnpldDVT?=
 =?utf-8?B?aUM0VE5hTXl4cFlPblVpejFPMmJ3cEVaY0pSN0pJb0FzS1pJeUk0cXdmQjBP?=
 =?utf-8?B?ZUdhMHdYTExGakFKQzkxeURnbG8wTG5ob2tLWUlUZXFFbEhnQlFKZ2EwbDhW?=
 =?utf-8?B?cVFyWFZtNFA5RUlSVXFiOUtyNkxCaEF1WkdtdDhVQ2hCc2M0Vjc5bE53cGJk?=
 =?utf-8?B?Um9tKzY1NC9tMnIvOTJ3dWJ2aUszcUs4eHEyWWdwR1FIVFZYSitveEJpVDJl?=
 =?utf-8?B?UDAvYWZwb1dNVUN6U0RYSU1vcmlreWNaNHRRSkFwUTBNcDVqdVVtTDNkRnp1?=
 =?utf-8?B?bVMrSGpYckN0UEwzSWZkNk1leWpPUzhFakxYVTJYS0dUeWYwL0VGdTNtVXhJ?=
 =?utf-8?B?ZFlYU1JYVFJyMDB0ekI4UHQxTnpGby90Y2tzeWl6dlVvNmhXUlNWbjFpN3ZF?=
 =?utf-8?B?eWhvRnA4aUJRVnA2Zmd0aDJTQUdCREdSc1VFOUpCYTlqNzVtcFNad05GNkRS?=
 =?utf-8?B?RTJ6aGNuMmtDSnQ4anIrYU5YcDJNT3hTeDJsajFRdmFoS2lOTnEwMER6R0l1?=
 =?utf-8?B?c3F0VGtOODU3NHkyYlBadHVOM3NYL2pvQStGdWdIbHJkZGJWZnM2OUVKVFdN?=
 =?utf-8?B?REpvaXRjdWtzWWpPL1YrN0Jhc2hXSFRiUkViRTdFNW5FS0RmWFhOL0FpYmpJ?=
 =?utf-8?B?N1Bwcy9GdXBFbjZNaStKaEhOLzhxWmlkRXhTZ1cxUitrcnZ0V3dHREU3ZFkw?=
 =?utf-8?B?cGdadkZXa1Z3bXR3TXUzTHA5ZVA1UWRIR2hrRWNZYUt0Z2NwOUtnQlB3cysv?=
 =?utf-8?B?b3ZVaUZwS2wrbytuNXNuT0FqT1gwdkw5Y2FMcTVoOThjQVJzZjNLTWRQSmlt?=
 =?utf-8?B?b0dYSEdCV29oRmVrZzhSeTFTQWtOYWx2c2MvNjEvL3lJRXpPcXRnZm95dndm?=
 =?utf-8?B?WUV0c2lxTmR0ODlabHl3TWhOaEdPRG5QaGkrK3VoM1NqZ0hEVFoxZk1kRmVS?=
 =?utf-8?B?RkZEYWRvVERkWnJDN3JJdXF2bWtVbHdzbHROWDFNaEVxVzZrbjVSM1RQUVlI?=
 =?utf-8?B?eW00Y0VHc2xrNHYweTFDenRtaGo1YkZHa0dvclhVK2k5MGlHcmcxbXBhMHRG?=
 =?utf-8?B?bUJyQlZYMSttQTFLOUwxNzBxaXpTdE1zaDZLalVCUkhOMWpSVFNTYWlWM1A2?=
 =?utf-8?B?czdEdE9abCtZYTVkYkFJY1UrbWxKb0hwT2FVQjZ2OFdHS1p6TWRMWWZzOUs4?=
 =?utf-8?B?M3FobFZCY0pXRk1scEtqUVExQ3ZzTmxjZWlGNHBnZDhxZ01vQXB1aVNGVitD?=
 =?utf-8?B?Wkl6MjR5K01lLzNLUjZuaHI5blVBd3FyRkVTZVBYZDM3ZnloQ201WUpLeEJE?=
 =?utf-8?B?S3dySzhTQW9sSk9EbStBSUtFQ3R4LzlzVkllTGxKbW0zZE1XbWZyU01ubnJk?=
 =?utf-8?B?ZndRaTFmOUF5UHJ0bk0wczRidTJCeEpiamdZNUV2K0NCUzlhRXUvRTFpcmt3?=
 =?utf-8?B?TWtLU3dnajJxVFVMUUh5Tms1NzVodWVVQ3ZkYjRZTjdBdDRUaHBsdWxXRVRu?=
 =?utf-8?B?RVBlcFRRMzdMRGk4czJHV2J5bFVyRGN2dSswdGVkRklscGNrVisxTStLT25O?=
 =?utf-8?B?azY2aUZDYmh1NnhWVkJObUVhY3lQNVpYSWMrVEQxR1p3MGllQ3ZqYklYWndM?=
 =?utf-8?Q?88lg=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 07:29:26.2846
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f647643-2cf9-47c1-4879-08de362b8442
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF0000003F.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8821
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA4MDA2MiBTYWx0ZWRfX19odKey+MD1n
 NHQSdDg8Nb3sczd2HLmo3mhIylivQ/3DpFcqUDbJnSE8sBzKfMGzOQxmEnNa7ivoNQSZ25qfx6G
 1V8t60u6ZIdXJcu76GKXZusafrwvc1vKqLeqgettgOen/2GB2ZhElYoo0u4CFiOyey5G+eavB4L
 2QJXioO5eZ8pqz1D6rMIYH9zbCMwJHqLmguuBfdnNEvVb3whbS/Rg/siq2k+ou4//3KvhRBTUIa
 pVZz+j6tr4e14edV5HBYtoqsw4P/jSvW/2XAnMDLIawzCaT3Mv/jztT5lcmXbak/0cmU+rdQDZj
 bMAcS7roW5Qqn+jQfRB8D5qx3tOSPGrx2qgCO+IzrrsVBe69T92eHRrJlA+sJgBQr0XXz7adIdR
 U98k9o0oPOcEwVjaS2IMiYiT6Nr5dg==
X-Proofpoint-GUID: A4m34GgFhEgpQqGbF1ZA4dNBdZY8Wktb
X-Proofpoint-ORIG-GUID: A4m34GgFhEgpQqGbF1ZA4dNBdZY8Wktb
X-Authority-Analysis: v=2.4 cv=R/oO2NRX c=1 sm=1 tr=0 ts=69367e59 cx=c_pps
 a=lY8KjCQ9O7Y0HqcpAT++Bw==:117 a=uCuRqK4WZKO1kjFMGfU4lQ==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=XWp4PHTOCikA:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8b9GpE9nAAAA:8 a=RFtgH8DZu3AqK6r0WhsA:9
 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-06_02,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 impostorscore=0
 bulkscore=0 priorityscore=1501 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512080062

Replace CR_TCIE and CR_TEIE irq usage by a read_poll_timeout_atomic() in
stm32_qspi_wait_cmd(). It will reduce the time waiting for TCF or TEF flags
to optimize throughput.
						before		after
average time spent in stm32_qspi_wait_cmd:	2615 ns		712 ns

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 drivers/spi/spi-stm32-qspi.c | 45 +++++++++++++-------------------------------
 1 file changed, 13 insertions(+), 32 deletions(-)

diff --git a/drivers/spi/spi-stm32-qspi.c b/drivers/spi/spi-stm32-qspi.c
index c7f2b435d5ee..d6f6f9d4e5be 100644
--- a/drivers/spi/spi-stm32-qspi.c
+++ b/drivers/spi/spi-stm32-qspi.c
@@ -31,8 +31,6 @@
 #define CR_DFM			BIT(6)
 #define CR_FSEL			BIT(7)
 #define CR_FTHRES_SHIFT		8
-#define CR_TEIE			BIT(16)
-#define CR_TCIE			BIT(17)
 #define CR_FTIE			BIT(18)
 #define CR_SMIE			BIT(19)
 #define CR_TOIE			BIT(20)
@@ -86,11 +84,12 @@
 #define STM32_QSPI_MAX_MMAP_SZ	SZ_256M
 #define STM32_QSPI_MAX_NORCHIP	2
 
-#define STM32_FIFO_TIMEOUT_US 30000
-#define STM32_BUSY_TIMEOUT_US 100000
-#define STM32_ABT_TIMEOUT_US 100000
-#define STM32_COMP_TIMEOUT_MS 1000
-#define STM32_AUTOSUSPEND_DELAY -1
+#define STM32_FIFO_TIMEOUT_US		30000
+#define STM32_BUSY_TIMEOUT_US		100000
+#define STM32_ABT_TIMEOUT_US		100000
+#define STM32_WAIT_CMD_TIMEOUT_US	5000
+#define STM32_COMP_TIMEOUT_MS		1000
+#define STM32_AUTOSUSPEND_DELAY		-1
 
 struct stm32_qspi_flash {
 	u32 cs;
@@ -107,7 +106,6 @@ struct stm32_qspi {
 	struct clk *clk;
 	u32 clk_rate;
 	struct stm32_qspi_flash flash[STM32_QSPI_MAX_NORCHIP];
-	struct completion data_completion;
 	struct completion match_completion;
 	u32 fmode;
 
@@ -139,15 +137,6 @@ static irqreturn_t stm32_qspi_irq(int irq, void *dev_id)
 		cr &= ~CR_SMIE;
 		writel_relaxed(cr, qspi->io_base + QSPI_CR);
 		complete(&qspi->match_completion);
-
-		return IRQ_HANDLED;
-	}
-
-	if (sr & (SR_TEF | SR_TCF)) {
-		/* disable irq */
-		cr &= ~CR_TCIE & ~CR_TEIE;
-		writel_relaxed(cr, qspi->io_base + QSPI_CR);
-		complete(&qspi->data_completion);
 	}
 
 	return IRQ_HANDLED;
@@ -330,25 +319,18 @@ static int stm32_qspi_wait_nobusy(struct stm32_qspi *qspi)
 
 static int stm32_qspi_wait_cmd(struct stm32_qspi *qspi)
 {
-	u32 cr, sr;
+	u32 sr;
 	int err = 0;
 
-	if ((readl_relaxed(qspi->io_base + QSPI_SR) & SR_TCF) ||
-	    qspi->fmode == CCR_FMODE_APM)
+	if (qspi->fmode == CCR_FMODE_APM)
 		goto out;
 
-	reinit_completion(&qspi->data_completion);
-	cr = readl_relaxed(qspi->io_base + QSPI_CR);
-	writel_relaxed(cr | CR_TCIE | CR_TEIE, qspi->io_base + QSPI_CR);
+	err = readl_relaxed_poll_timeout_atomic(qspi->io_base + QSPI_SR, sr,
+						(sr & (SR_TEF | SR_TCF)), 1,
+						STM32_WAIT_CMD_TIMEOUT_US);
 
-	if (!wait_for_completion_timeout(&qspi->data_completion,
-				msecs_to_jiffies(STM32_COMP_TIMEOUT_MS))) {
-		err = -ETIMEDOUT;
-	} else {
-		sr = readl_relaxed(qspi->io_base + QSPI_SR);
-		if (sr & SR_TEF)
-			err = -EIO;
-	}
+	if (sr & SR_TEF)
+		err = -EIO;
 
 out:
 	/* clear flags */
@@ -835,7 +817,6 @@ static int stm32_qspi_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	init_completion(&qspi->data_completion);
 	init_completion(&qspi->match_completion);
 
 	qspi->clk = devm_clk_get(dev, NULL);

-- 
2.43.0


