Return-Path: <linux-spi+bounces-11818-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD4FCAC593
	for <lists+linux-spi@lfdr.de>; Mon, 08 Dec 2025 08:32:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF6B3304ACBA
	for <lists+linux-spi@lfdr.de>; Mon,  8 Dec 2025 07:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE232848A8;
	Mon,  8 Dec 2025 07:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="nuf6qmb/"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8491F2566E9;
	Mon,  8 Dec 2025 07:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=91.207.212.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765179000; cv=fail; b=o9L/9/QEfBmtLMSNt3vyIpKT6XpuQgkpeHR24wKnvLveAkab+VQllh0IHEfyRBtijF06TycRDTB2BKtFl6yiZqLIRsWkdqgVxmmjzrnFNC255gPDQOdWLhsla5hQuJBGcUr9BQdBSxzqe3XBr/G6MRFBT7cARWjL+Z+7Cr2TwmA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765179000; c=relaxed/simple;
	bh=ymo8xZYUg77rVc0sLjSrp8og0ZhoLhT433KHxEFF9F4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=NvIglBmDxqjITuFi4YZ+mj+2uNgDhgO1ASTQNrutKKc9XzuH84IEiW/S+vP34A9Fc1RlY7OCwyQVOPupedQDZG65lR4vqQFTfwXFkar2rgiYtoDFC8Bpry6vX8ex3APYNyf7uuib+DtAX0QddhwoGZeUn9NuZHkatpcSrlH4j5Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=nuf6qmb/; arc=fail smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B87MbUU891586;
	Mon, 8 Dec 2025 08:29:40 +0100
Received: from gvxpr05cu001.outbound.protection.outlook.com (mail-swedencentralazon11013058.outbound.protection.outlook.com [52.101.83.58])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4aw0aqapp5-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 08 Dec 2025 08:29:40 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q5JrABIqwNJcULcNkTrDYRqDbI6+5Kdur4bocOOkTiDem/O0lfDbzaCmB00YWHFeAXCmgrAw5z+caALlSkQMpd1GJc4emx3toVKHW/CV+K3PI66goUEISrq7PSSq8U0FCIFZIgA0UXkiPBsd8wu6Q0Mw4FM5BzUlUHS8cJ3hbDFp5Ka2nqCsHakdJyX33OpNLru9ViW+KvMrPMfpyGwP+gpTUe5DsRiAWWJWosEpvpYUkmSyY0Y/Lgp19gOCITEtpPJIG7WWAG38GSnSNr3sEF9+oED7x8Y3hRtpFbJhvQFu01vc6HGAKsddxdYdNVOWyT6n0FYfbFvN3gSyAqkzXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pIPsugvH6/2RuNayya6SvcHqgg3UV2mz+DTzLtRGsVE=;
 b=bqqbmW9fcG+h3fPfQwjusIoEQDW5JuDsTKnAp/ceTC/+hxsEV+elAaerr+I9fb5VPSX4VVySZt4CDstEFc/eTXg9jo65wk8YG/dQoX8g/9qWJDbfhyBKI6AhOPJATKuVjhQPJsxozkOdKSgzxNu5P4Zm4hLLaiQdtcjJtDXI5x0u7172PVAGWn5ZeXVO/XXj8KIh7c2SsLBHWpKj19+oa9OlMNGT4eVIycWZVbwHBhDkJluQUXNhzBMD6t5WPXj/gQSL4xVIR7YtoWFM9squ1a6mDTNSharGLyWSIaYrTnaWkybi/K8RLjpVdc6Sos0NTssk5Wg6kN9szRm+sk36gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=st-md-mailman.stormreply.com
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pIPsugvH6/2RuNayya6SvcHqgg3UV2mz+DTzLtRGsVE=;
 b=nuf6qmb/1DlRQjM/oiuoUTuo8dlTaMxaXJvVXQrt4/o9kmsSL8j+4QwIejrOr0Jr1Xs768luhSUU0pYzWf6Ko0bgSU/Vm6xZW+BIKoW31uOP0UXqm35sJ5MBUaR4DEjvSQVtrTnpSOEJaWnLBUNafngCWko9sMZmk7+HLI/7UnkDI960KOt0qa6ntbDIqY35RQNjTTFLwxjsvXGnfXkIMhWan7iYIr7wJp/iMx0t6CwgIanPazXLQLqIezzG7+j/BbnX2Vk/G3GxYgByyl/ezO0Dq+pfEbb0tkqlJ1hyhebejC0m1SUiOS+nCwpe4NrSLJ2ge5OwyRbA3hwsIwmFjg==
Received: from AS4P189CA0005.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:5d7::20)
 by DU0PR10MB5606.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:318::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 07:29:24 +0000
Received: from AMS1EPF0000003F.eurprd04.prod.outlook.com
 (2603:10a6:20b:5d7:cafe::6b) by AS4P189CA0005.outlook.office365.com
 (2603:10a6:20b:5d7::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.14 via Frontend Transport; Mon,
 8 Dec 2025 07:29:21 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 AMS1EPF0000003F.mail.protection.outlook.com (10.167.16.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Mon, 8 Dec 2025 07:29:24 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 8 Dec
 2025 08:30:03 +0100
Received: from localhost (10.48.87.93) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 8 Dec
 2025 08:29:23 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Mon, 8 Dec 2025 08:29:12 +0100
Subject: [PATCH v2 5/8] spi: stm32-qspi: Set DMA maxburst dynamically
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251208-upstream_qspi_ospi_updates-v2-5-62526c9467dc@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: AMS1EPF0000003F:EE_|DU0PR10MB5606:EE_
X-MS-Office365-Filtering-Correlation-Id: 492ff047-38f3-4ce2-d6c9-08de362b8315
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T0NiM1BWeGxPRTFxUmRvbjM3ZktpV0xMNitxSnkyOG16VnhtWWhJeTMxWGEv?=
 =?utf-8?B?SXpKL1ZFcmR4UEU0MzNPWEhzTTBBK0dlZGd6N25vMXhSaVJHSDFjQWtua3Ix?=
 =?utf-8?B?bFltV1hxamZXZVlwZzlTN1VRUmdKbjVzVS9oYmFVb296QWVaNWlPNDRvNFhB?=
 =?utf-8?B?Ky9DdHk1REtSUWdCa3lQMHJzTnB0NGVWd2IyUGNWQlJwaXErcnJkbzV4MUNV?=
 =?utf-8?B?NXNkdXpQeUE4bjg3Z2ZFLzRRT2dyTWhBM3ZSQ1F1ZjRDb3dvdE8xaWFGejh3?=
 =?utf-8?B?YVBhWmdaK1lodHd1L0s5cG1rcFNOSE1Nc1FnaXBjU0RlUU1UZTlrZTlXeUZi?=
 =?utf-8?B?OE1KaGd1Y1VkRkRNcFBpY3Q3NGxKZ21EeEo1R2U4dGdsS3F0bTJaUE43V2Jx?=
 =?utf-8?B?YytXVVljZHZFd3ZiOWdDcE9EOWFnNW1nM2hkeWZ0bEtyUkV0MENWRzdoaG55?=
 =?utf-8?B?cHNmRmhpN0liWHEzZDBWSlpLOS9mWU1SM3lMK2ZrZFFIWm1LYTI5b3BxaTdP?=
 =?utf-8?B?N3owV0xwT2Y4WmszQmc1cTNqSDVmNHVFMEJCcE0xeU1ibGdMbWcvYnJnZ1dl?=
 =?utf-8?B?YTdHZElFM0p2Q0ZhSElLZjFUdHJqd2daSnFqNzhXM0M1REI2eEVXSmNRckgr?=
 =?utf-8?B?WlUzRnUxeUFMN1h6VE9tUmRLNjlydTZPYm0waXpYbE5oaWtQOXArOUIxVTZU?=
 =?utf-8?B?YzZINGZpTGp4bklLNndSelJnVjR4dXdiSFVBUm53TktacU1mSklZQ3FGcU5q?=
 =?utf-8?B?SmE5dnNLS2dXd1VudDYrbWp1STVrV2hYRWdNNWNDN0F5WGdRNVB2K0NEaXV3?=
 =?utf-8?B?Q0J1dTkzaFFvQW5TeHpYZWVWbXdWZTRlL3R0ajMwcWxwUGFNRzZsK3dSZWdF?=
 =?utf-8?B?QU14a09GNmZ2eEZNRkNvMERBWTdUWmlhSk1ZSGZoTEp4dnk2dmdJdUNyWUx6?=
 =?utf-8?B?UGVQNnBSRVYvWDVQRk9FbmtOdyt6ZHpVcm5OdHJVY04vNDk3akVnUjBiYzBZ?=
 =?utf-8?B?clMwMndHalQraFV4SEFVUm1qWWErMk0vNzIxT3ByTHp1Q2NTajlLTktpbGJP?=
 =?utf-8?B?ME4rSnY4SWwvcWZOVHpPVjFId0ErWmd2dzJpQUgxRFNtMVMwR2Y0Rk1hODBt?=
 =?utf-8?B?MDlrTzY3dWxWVHBhQ3V4Y1F3RVFhTjViNDhHUUM0YmM0UTVWaGxsM1ZoMldN?=
 =?utf-8?B?K25QbVZCYmxWeWRNSVMwZUROMCtjWHVUK2RhR01wVE1VYk9wdVZQVTFybzdP?=
 =?utf-8?B?WlVKaThQeUp0d2phN3FrVGFwL0JxOWJUT2lGeVNFc1ExRVlnYmtuSDZSMG1W?=
 =?utf-8?B?S3RzVG1BbmtGWTZCMWh2VDkzWVZYeG54RHk3Ylc3RFc3L1FrQlZNdEJZd2xq?=
 =?utf-8?B?aXBSbk9UYnVkN0ZwM3RmNFd4YngyRUFLT1dkT283SEFScCs0NGZUQmlFZjRH?=
 =?utf-8?B?U2Jrd0dqRTM3N0VBaVgzbm9KbWJzKzRWVFYrN3hlZ1Z2WmJkemp0QW00YXR1?=
 =?utf-8?B?V2I4OXRqS0YrNERqSmxENU4zMWNhUmMvZlQ3d3JLc0szUTN5cnAvd2VaTU5Q?=
 =?utf-8?B?aVNybXljMlJwYnQyL3REeW5ZZThBbncwWDRpd2ZPT2tVRFNQQ1Bnei9sUHYr?=
 =?utf-8?B?Z2c3dDB1elZKWWdtY2dhZUhUckJTcVZ4Q1h1L0JWVEliQlUzZUlRWG5JaDAx?=
 =?utf-8?B?bTMxMW5yYk9MZ0xSdnc3djhucWs0U0V5MzNvR0FLTThqNyt2OWNScjhHU0dm?=
 =?utf-8?B?SFIzeEdET08wUzVsS0hJU2xWOTZWVGdKN1U0TGh4UXcvOVVwR2R4ZkRyd2dK?=
 =?utf-8?B?bVFkS3JvVmRTZ0pzMWdydWxsd3E5Qm9BdFdHZDJMV2p0TVdUa2laUWZzKzg1?=
 =?utf-8?B?QjJhRmxqVlZSWjk1d3lCbU4rd09MaEM0TkYycEdkM1kzQVdWOThKTmUrdDlD?=
 =?utf-8?B?dDJxVmo3SkpkVDl0am9JTHpSMWhYUkJEd3RVOE5kZitxLzlyNmhGaTVZMUF3?=
 =?utf-8?B?VUY5SHBwTmZDeEVGcnB4NU1KQTFocDMrZjZiT1pFcnJzUTEzM3pkK1dhYzBr?=
 =?utf-8?B?cTV3enhYK3pxM3VGV20xTzdZMmZzai83Z1FBRTBvQXVubUtJTXIxK3grbFpi?=
 =?utf-8?Q?6Qxk=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 07:29:24.3182
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 492ff047-38f3-4ce2-d6c9-08de362b8315
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF0000003F.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5606
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA4MDA2MiBTYWx0ZWRfX74+Wtgqj2Q7Y
 7R1o+NAMg3NwstfZ36ntKm47LArTEgEm0wdHPW+ZE5K4HrsQF5ELeqTuHM8d0sECFuhwGXxFmBw
 wp/rKLePDuo30M3oAHAMu3GwjWrfvivLFkAXoDlrVG8ftDb57jjYdpSutXB0v7wiobd0aaTdti+
 3nfV1LrnyvLibmyeXA5tsBA2pwARmzQ9gN9eEKfAAz8I5npw1bbbXEwyi71xT0ns2PiEI65aIC5
 h4hVOKhMs3KfsD0MaOoFN+GVkMuZ/6CG4bJuPslJV8uGPFTfyp9PPhw1ilxTGyB2i1vkEANe+6U
 yDivZtra9sGXcrlaI6i1MuM/zK62miufL3W1tuHEJHxx27sGzA30ouURX68BNiubWvJPgN1++5J
 vSzqShd1iivJDOkQdHBJ/czRuFpuPA==
X-Proofpoint-GUID: o1yhZQZuJZnLNuitvWLToWRRQAzoSASb
X-Proofpoint-ORIG-GUID: o1yhZQZuJZnLNuitvWLToWRRQAzoSASb
X-Authority-Analysis: v=2.4 cv=R/oO2NRX c=1 sm=1 tr=0 ts=69367e64 cx=c_pps
 a=xFT3qlHD+1xS+TaMy1FbcQ==:117 a=uCuRqK4WZKO1kjFMGfU4lQ==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=XWp4PHTOCikA:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8b9GpE9nAAAA:8 a=kdm6LiA3lqeN45Uv8g0A:9
 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-06_02,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 impostorscore=0
 bulkscore=0 priorityscore=1501 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512080062

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


