Return-Path: <linux-spi+bounces-11781-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A00FBCA6D0D
	for <lists+linux-spi@lfdr.de>; Fri, 05 Dec 2025 10:06:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C8EB83047D3A
	for <lists+linux-spi@lfdr.de>; Fri,  5 Dec 2025 09:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA823168F5;
	Fri,  5 Dec 2025 09:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="YVXZ+6An"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906593164C1;
	Fri,  5 Dec 2025 09:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=91.207.212.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764925543; cv=fail; b=Vj4s6aOgd2XRA7gA3+yYrvd/VQAyvFcZL4gXfpZYFnIAIe/rX/nWs/d4XuHWzzOELvJpiI8/NB8rtzJ5h8GQj/6QAexeqUlZimfiHGGOImrpjyDPdgbKQEr86ns8fj5O+YpTb3NfJQa3frDIU0N+PUcHkiZVdLAq3shyoyRmCdU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764925543; c=relaxed/simple;
	bh=ymo8xZYUg77rVc0sLjSrp8og0ZhoLhT433KHxEFF9F4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=AaGJ28BcB8qsKewDG+4YsDiG04n/Zawwksr80SheUCuu1fH0UE0fA6kHFgcSSuOFV8w0V0gjV2JXItIwAE+IYubJkbtfMIiFNNJXU3HKB2m0bLTIYk8OOBCLZjFJswRjjXIrZ8nuIWs8t58ly9XQieHLU2QrGInY/dzfTRj3yTE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=YVXZ+6An; arc=fail smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B593u8w2161975;
	Fri, 5 Dec 2025 10:05:16 +0100
Received: from osppr02cu001.outbound.protection.outlook.com (mail-norwayeastazon11013006.outbound.protection.outlook.com [40.107.159.6])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4autdg0m1w-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 05 Dec 2025 10:05:16 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dcxmt4tfDhFHpS926pjTtgVome7le854qoda3GYN2quF3iVhKK0GaTrPRM/eLHG+ERpLYqXhfnJcfu1jVkip19hQABUQLmDHKo4HMntmKPvYvPSq/nB7OOnXBBqUzSQ/mZrw/BW2dANDbVS6BB+mjJbD5kUc66nIBhjezt9gK+PbNbEqML1GQ3Pn9O6O1ZTI+9yN0gVlvomANApTl+RrJXeSyc//YHzkIh87Q9McIwwG6/nnJrEbgnqlU16mAmabYGc8+nHnn57YbiHILRZkYhiBOw6x0NqQM9zeEeLbf3KJ9nTd2W88+YXaPITJ2J9i5LI3QCfUl3Qnm4FT0jVF4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pIPsugvH6/2RuNayya6SvcHqgg3UV2mz+DTzLtRGsVE=;
 b=WHI+cHJnLfwODnhXFHDtattcAbQeIfbA7wtClU+8S6+KPt20vA9X5GI1D8TS8liSkdOOtYEufPtIbQcwCdGtCj9+cN3z9Bsj8bGJiXH6YT3GwyU9F7ImyE1+jylXNYoa+POGfuq7T9zagoIBakrMnxIZSrsNxPyKyEV1eacs07h3egt7LUacLdfK+UdrE1sCqdtoUOMfuTqpWiaZf8kBCCwEUvdgDtQGzCYRFD38rgWvwVII4Sr9XvpZGVH0WwU8mSpctLGA0tlqMk3hFfdckIicxgS/8we385ApJWl5fITPaeobUkWzw0j3FstOQJ55j4bZAq8vJS5dr+qcTB7pAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pIPsugvH6/2RuNayya6SvcHqgg3UV2mz+DTzLtRGsVE=;
 b=YVXZ+6AnnxpWjnNtrDknnd0MZ5Q0AKTNuDbZMcp13VqOVDLkCdYBDJfYoQg7GGpoAN2EblAfyHQ6GTk/SggY6vge9n9KXvly7iI1UsWOszmjGonXIQ+LuCGL3RLEDEpiYmgecSQBZuka1+CLkZmtXFTlXF/OSREDJNF6Q+2lkHj7xDZ5IhIWx0wZAZUIudU6A7Y9SrNzFwYuNFhaWQjF/Ae/fK3Hw3y7yaj/+mtlykXWa7BOL+whXbzCtKpMFQ3Q7pKl/ltBvkqDJSiNBqGhHwDosbGhRlEfG26vPuJ42z7hjEmNkCEp9fVIg8FohmIcHpvy4JM2A1jK/RHzkx4n4g==
Received: from AS4P192CA0045.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:658::25)
 by GVXPR10MB9106.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1e1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.12; Fri, 5 Dec
 2025 09:05:11 +0000
Received: from AMS1EPF0000004D.eurprd04.prod.outlook.com
 (2603:10a6:20b:658:cafe::38) by AS4P192CA0045.outlook.office365.com
 (2603:10a6:20b:658::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.12 via Frontend Transport; Fri,
 5 Dec 2025 09:05:11 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 AMS1EPF0000004D.mail.protection.outlook.com (10.167.16.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Fri, 5 Dec 2025 09:05:10 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 5 Dec
 2025 10:05:47 +0100
Received: from localhost (10.252.31.202) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 5 Dec
 2025 10:05:09 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Fri, 5 Dec 2025 10:04:55 +0100
Subject: [PATCH 5/8] spi: stm32-qspi: Set DMA maxburst dynamically
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251205-upstream_qspi_ospi_updates-v1-5-7e6c8b9f5141@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: AMS1EPF0000004D:EE_|GVXPR10MB9106:EE_
X-MS-Office365-Filtering-Correlation-Id: a44cacc7-9934-409f-dfcc-08de33dd6519
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MWNnUHllTXdYRTU2RHNJZEVmaVZISlg4alJIMTUxM0I4YSt0MHFwY2xFQUdy?=
 =?utf-8?B?N25DSC9EaDZKNnlTSHhrK0JEYWJMSnYzejgvdWRSNDhlYWZXNzNsMUxNdng3?=
 =?utf-8?B?UzdQWTh4UnF2ZUVyNnkrcXJ2em5mbW5FOU1qZTlBWVg1UktoNW5Qb3gwQ05J?=
 =?utf-8?B?cVdUaWNOa0dyS2ZaY2Z4aWtSVmdnTkgzdStDc1owOXZ0U0dzREZFNmhNQjYw?=
 =?utf-8?B?ZXQ0a2ZWTXd4RWtSVFEwekkrd0NKdG1FS1l5cmxRUVlzbkVxV1pEV0prZ2lt?=
 =?utf-8?B?Y0JJK2NiNjFsbGZGT1JCWVhKckhHdm95RXZBb2txOUV1MkVsU1pyYUxoTitm?=
 =?utf-8?B?Z3lVRWpTRC9MK0w5ZElFK3l1eUdaNVdPK0p0Q3FzNzU1YVV4QlVVeTVtUlpE?=
 =?utf-8?B?bVd6NEllM3FwK2JFQ2VJc3ZTbFhWeElxT05KMFhNaEdOOHMzU2F1SThxekpp?=
 =?utf-8?B?L3RJekdpVldxcVh2QmxncXgwTGt1MERlZTJibUFhdnpZeVE0cU5VSmZUQmN6?=
 =?utf-8?B?WVZ4dFJkUG15ckk3OEcrNnpHbkgyUW1LWmZWeHRhSnpiQjkveE1uWVNpU2U3?=
 =?utf-8?B?QjVhYitSUGFRZ0Nzbms2T3VYaWR3NjdNRWxERXpBa3pSU1UyTVJOSFRISlYx?=
 =?utf-8?B?VWhQUW1QeFQ4ek1nWnNnaFh2Z3RHNkZ6Qm9oQU9keWxlWXBlazM2VStuODk2?=
 =?utf-8?B?d0lxb2xmYlBpMy9yQ0dNMUlnYkF5cDN4b0dqMVIxTk0rdDBtZk1SWldYcjVS?=
 =?utf-8?B?dmd0Ny8zUWpJS2hTalEyU1lMRUdUdW5YQ3FlbjNjQVBKRmsxQXY2WDdvcHl6?=
 =?utf-8?B?MForTjdqbnlzeXlGYkpmZGZaNi8ydGJOdXhzVHhWYjBJaGNlS1FjS0dSdElh?=
 =?utf-8?B?emlGRGVVSDNySldEd2FIcU1OTjQrcU0xTWd3bUFvZUNWcFRkcnBXc0p1cjRv?=
 =?utf-8?B?UVlwZ1crN3V2ZUQ1aFdVUXZoWGlBazFGcFgxS2xxOFJOck5QSmN1a2xtRXBM?=
 =?utf-8?B?ZUFuR1FyZlV0WHdmWXBraVVoUlVER0pkc0tueFZCUlRia3B5TlNqSzBaU2Iw?=
 =?utf-8?B?N09KZjB5d2NJaDA4bS9PemEyVWxXYmlaQjlTc1Q5c1FoUk5QTE5hMnlpSW0v?=
 =?utf-8?B?UXJ0anVzY3hrQWwrS2h0ZENUaDJTOC9Odk40UFhwd0pYejR1YWZtUTVWK1hv?=
 =?utf-8?B?RFRNWTIxWmQ3ZWU1dTcxOGl5bTUzVVVJTXNOMDNHYmtWbTl6ZE5mT3lNVVht?=
 =?utf-8?B?VVF0M1VKd2RCa1kySTFDQXM3aGlTRWZTOVRPc253YWpNSUhMZjdmeHozaXA2?=
 =?utf-8?B?bGgyZFpVTVF5Tm5abGVWdFd2YXc0Q1FkOHVXNnpoRnVjVzRIL3JnMXlvOHp6?=
 =?utf-8?B?MFM3WUprVk1wcTVPMUZyNi8zMmNMUy9xcVBXUlhLRmhxNTlTM0trS2dmaE1E?=
 =?utf-8?B?MmlDOUE3RU9oWEh1bisveDF1SlUra2hkWDlWeURyalpvMHRPTjFSNm9hbE5m?=
 =?utf-8?B?azU3L3pWYkZIbzk4amxBbnEreG5pSjlBclErbXh3Wmg4MFlpUU5OY01ETStr?=
 =?utf-8?B?NXlxb0xUL2xkaFo4QUpENHFwNzZwRVBhS2pqbjNRNzdTd2pQNzA3eVNGY0Fu?=
 =?utf-8?B?ZnA4RHA1aU12Tk5sbytWZHJVOExlMHNqSU9BaFhDMkFjS0Y3TFliRWJnaGVr?=
 =?utf-8?B?Q0VvOHVITGZYYWV0U25GMWtVcS9NamRpS3A4RjVSSTI5Mm5GdzFCSzQzb1RE?=
 =?utf-8?B?YVpSejgrQVBicE1EdE42VElUcDRDQzdrNFQ2QUxlQ1pLR09lUEN1Q1MzN0F2?=
 =?utf-8?B?QWI1YU41QVdvK1RRWTI2MTBETWRqYkdQQ0E0UTFKWmtxa3lnTDhUdzZDZERm?=
 =?utf-8?B?VCtEMDlEUVBFVmpDVkxJNmtGVlpRSlhLM2Q5dTR5cXV6d3A4UE93dVpoMG9O?=
 =?utf-8?B?LzlEZ09sVHgwTEFxc2tlZElYOHlQcnVhWFNVemVjaDFTSGpIM1hTQjZ4ZVMz?=
 =?utf-8?B?RmhCVDNhYlRnYkxsZ09pdUk4c2xGOXI1Y0F6cmUyZFFJSHlNZ0dNb3VsMkIr?=
 =?utf-8?B?Q1pVTUY2ejFsWElNUjNDRjJwMHNxZWRYWlRBdkQzcHlLY3h4eHhINmRGZW9r?=
 =?utf-8?Q?N9JI=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 09:05:10.9392
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a44cacc7-9934-409f-dfcc-08de33dd6519
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF0000004D.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB9106
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA1MDA2NCBTYWx0ZWRfX4JUPiNmrHH9b
 2K35vGzn+4QX5KcXDm/+/rw9CWMVDBZpY6sX1RcdjzUuFRE3J1wc2GsFp3phRC1z73ORj6jXBDu
 +IkwOGEeiKnVhGFLblzjRht5bcRr/9/JMCdK3Qkotkw922CSn5Q8om55/4EcQ0SC2GQ8bkkoNXI
 Hrk4NAXn6185GGfzU/5jYcJ4gJIoEf2ny+TzbUE8k4BFKVlr5Cb718lmkfeHH5LYs1YJhuYNjJX
 ONUzMGyGQxPXnAXmBkMHW66IKfuy6IIHE34mRTqqQZL7GZS9LCXWDWs/+7keKl3qkuUDElFuYOa
 A4NYo1/HerpY73Dxyh5/kvZGg/wuIoX1sx9gFFURL1wF9Fob1frSLbHMiUvA1CZgxycOekzc6BM
 rKhSvUjI++IwYk68ZJ/corw7DNKHAw==
X-Proofpoint-GUID: bLOwz3FsOvfnGgJvobAgaAzsC2U-Nl-C
X-Proofpoint-ORIG-GUID: bLOwz3FsOvfnGgJvobAgaAzsC2U-Nl-C
X-Authority-Analysis: v=2.4 cv=YrEChoYX c=1 sm=1 tr=0 ts=6932a04c cx=c_pps
 a=V7bJpFG2U8+55D0nNporPg==:117 a=uCuRqK4WZKO1kjFMGfU4lQ==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=Uo5EeBN78AAA:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8b9GpE9nAAAA:8 a=kdm6LiA3lqeN45Uv8g0A:9
 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-05_03,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 adultscore=0 malwarescore=0 suspectscore=0 spamscore=0 clxscore=1015
 bulkscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512050064

Set src_maxburst and dst_maxburst dynamically from DMA
capabilities.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 drivers/spi/spi-stm32-qspi.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-stm32-qspi.c b/drivers/spi/spi-stm32-qspi.c
index f2d19f1c5ab1..c131441e4dd4 100644
--- a/drivers/spi/spi-stm32-qspi.c
+++ b/drivers/spi/spi-stm32-qspi.c
@@ -689,6 +689,7 @@ static int stm32_qspi_dma_setup(struct stm32_qspi *qspi)
 {
 	struct dma_slave_config dma_cfg;
 	struct device *dev = qspi->dev;
+	struct dma_slave_caps caps;
 	int ret = 0;
 
 	memset(&dma_cfg, 0, sizeof(dma_cfg));
@@ -697,8 +698,6 @@ static int stm32_qspi_dma_setup(struct stm32_qspi *qspi)
 	dma_cfg.dst_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
 	dma_cfg.src_addr = qspi->phys_base + QSPI_DR;
 	dma_cfg.dst_addr = qspi->phys_base + QSPI_DR;
-	dma_cfg.src_maxburst = 4;
-	dma_cfg.dst_maxburst = 4;
 
 	qspi->dma_chrx = dma_request_chan(dev, "rx");
 	if (IS_ERR(qspi->dma_chrx)) {
@@ -707,6 +706,11 @@ static int stm32_qspi_dma_setup(struct stm32_qspi *qspi)
 		if (ret == -EPROBE_DEFER)
 			goto out;
 	} else {
+		ret = dma_get_slave_caps(qspi->dma_chrx, &caps);
+		if (ret)
+			return ret;
+
+		dma_cfg.src_maxburst = caps.max_burst / dma_cfg.src_addr_width;
 		if (dmaengine_slave_config(qspi->dma_chrx, &dma_cfg)) {
 			dev_err(dev, "dma rx config failed\n");
 			dma_release_channel(qspi->dma_chrx);
@@ -719,6 +723,11 @@ static int stm32_qspi_dma_setup(struct stm32_qspi *qspi)
 		ret = PTR_ERR(qspi->dma_chtx);
 		qspi->dma_chtx = NULL;
 	} else {
+		ret = dma_get_slave_caps(qspi->dma_chtx, &caps);
+		if (ret)
+			return ret;
+
+		dma_cfg.dst_maxburst = caps.max_burst / dma_cfg.dst_addr_width;
 		if (dmaengine_slave_config(qspi->dma_chtx, &dma_cfg)) {
 			dev_err(dev, "dma tx config failed\n");
 			dma_release_channel(qspi->dma_chtx);

-- 
2.43.0


