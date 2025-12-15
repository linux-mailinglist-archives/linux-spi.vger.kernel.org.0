Return-Path: <linux-spi+bounces-11883-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6534ACBDC8F
	for <lists+linux-spi@lfdr.de>; Mon, 15 Dec 2025 13:27:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7C5BB301B394
	for <lists+linux-spi@lfdr.de>; Mon, 15 Dec 2025 12:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A4CF2D1936;
	Mon, 15 Dec 2025 12:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="oQzmFTRj"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7350A2D24BC;
	Mon, 15 Dec 2025 12:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.182.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765801621; cv=fail; b=M1zFIN3QKxm2tcbH9Bpc2HyYvTWwt4YkGSnE3q2ntp0EuMfZUUxQ2F3lil6GFsu88zOJUYcoz1XJMiVe5S0emHZlw60FUqUVeTN0RfZomeQcQVLiI91QvqQznvO+0rXwWCtBCGuiT+NnXKq5zsJvz0aufwMA1F1uz2lQSolmLIM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765801621; c=relaxed/simple;
	bh=fX5RfxY+UzykLXPYFvnRXQXxHGAnP93rdQupsdHdmlA=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=sXxjEptD5BLyXp+rhOpBID/O5aGA72yjLBWnFidDQmF7MW90HS9a/w2zKpoysec0cYxcU3LzzPdDMaQcnd0dldjMAqvi1peQsyakohib8EjM4KEGDjCsryD5m1ZJdS5NY5McuJ3vRq7+v8PDSp+KcLshxv2aQ9prDlOArpUfPm8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=oQzmFTRj; arc=fail smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BFCJbfe2987407;
	Mon, 15 Dec 2025 13:26:47 +0100
Received: from mrwpr03cu001.outbound.protection.outlook.com (mail-francesouthazon11011021.outbound.protection.outlook.com [40.107.130.21])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4b11dx624s-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 15 Dec 2025 13:26:47 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ErgHyF8ZHw9D/6OAEVUi7a52BY/nsSIKo5ESGClYud2zu00xNI+/homgGPB1KNzLciO7FDHLaTqDJR37ocggaH/9Q2XXpvKQecK94HnzUe9188NHNy+orUA64DgeBR377D9fiY6Myf7j8zXhwqK55F/RKo2VRf+e8hwowECVtOw3PzS42nywArCtXTJ3giGQNc9Pq4txZ9KufdBwIXbNAcA8qn9SyVmx+GLZZUC2jxFXJF/t2J/39N1ApO56UOq6xhIJ+3VQ1RgYERwA9CWeVe6YGB6zhoLx3pjiiZfH2dBMsV3lEd7AywuHwP1xRXWLY+yYx0QNxk7qlrED3kbvow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z1WTRbIICfLoP/9VCmeExHWEY2LW/lIETSjEGdlS7QQ=;
 b=vU8GNLQ2OuLfAiOAZZKDmVTMacDV5Fky2kkt0uF9eUn6geWzOyqeQ9LFucfUVt8NxjV7zNgXqrMbAw8joulng7XnQtJwq1CMWpdfl1tK1xUl/zj6z0FBm6cx7mlJQZR5u0fmOcURfnDOfAS3DkTcibefSE8uWf9J6V9s6wlJKvscg7J77M5HTSV/ssBqw7aBWv47u1jOCpZ5GR4aKpvsDTLQMo+OpSZROF9G6473bth//48F+iFJrm+qhxRnDJkEwlnGTlTN6PuVosI27Des7Onw3u2o56bvPL+3FT16pXZBlQuQuY4be3Lpa1Qv5OSvIVNTExA6bNKltBsw6tYwKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z1WTRbIICfLoP/9VCmeExHWEY2LW/lIETSjEGdlS7QQ=;
 b=oQzmFTRj1D2zMCXv6IJG4v33EP3a1whLKm5DSxaImFIpOa9n046kcWd97RAV96B3LQaDKBNw+4+aC4MgJBO+ZGBVUuP10NRWOAVup2/eRF7+qZWfK06WISqrWA6FCuEQFYBct9c9rEdQCTmUdphztMfPt5yR10xjXLypuazte0wXfa1qLY7sFK4+xRSG6eLcLq3qMKrZl4lRARY0GS0UnpLM210Omi3zC9BpdU+yTJltGpxYm89VALbrhYBKYNMs+7qkOBYMp9lpuEHNJCd928/hd0Zjl3HRB8b4FEKeBSnBJhom5tGjo2sXLAjrHzH+u0XsYN1GUzseSxQZHAt3IA==
Received: from DU7P251CA0010.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:551::27)
 by DU0PR10MB6154.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3e6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 12:26:43 +0000
Received: from DB3PEPF0000885A.eurprd02.prod.outlook.com
 (2603:10a6:10:551:cafe::64) by DU7P251CA0010.outlook.office365.com
 (2603:10a6:10:551::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.13 via Frontend Transport; Mon,
 15 Dec 2025 12:26:39 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DB3PEPF0000885A.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Mon, 15 Dec 2025 12:26:42 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 15 Dec
 2025 13:27:29 +0100
Received: from localhost (10.130.74.193) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 15 Dec
 2025 13:26:42 +0100
From: Alain Volmat <alain.volmat@foss.st.com>
Subject: [PATCH 0/3] spi: st: add power-domains on stm32mp2x
Date: Mon, 15 Dec 2025 13:26:19 +0100
Message-ID: <20251215-stm32-spi-mp2x-dt-updates-v1-0-464a5fd20f13@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGz+P2kC/x3MSwqFMAxA0a1Ixi/Qxi9u5eFAbdQM1NJUEcS9W
 xyewb03KAdhhTa7IfApKvuWYH8ZjEu/zYzikoEMlZZsgRrXnFC94OrpQhfx8K6PrGiKxlTNUE+
 mZEi9DzzJ9b3/3fO8rv9cJmsAAAA=
X-Change-ID: 20251214-stm32-spi-mp2x-dt-updates-048068b7f05e
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Maxime
 Coquelin" <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>,
        Erwan Leray <erwan.leray@foss.st.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        "Alain Volmat" <alain.volmat@foss.st.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB3PEPF0000885A:EE_|DU0PR10MB6154:EE_
X-MS-Office365-Filtering-Correlation-Id: e8571a52-6dbf-42f9-04d6-08de3bd53497
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eFhKTDBhZldnSFA0NkZackMzaWEwUGdIZkdVMytkWkRqSTRFL2p2VWZDTVZy?=
 =?utf-8?B?L1dENW90Z2NqbjQxTlFZRzlxWk1PeG1IczZMR2VFM090cmp3cnlGKzNCWGF0?=
 =?utf-8?B?ZkpqRDRxcDdpNUtsQU5yVjYzQ3B5YTR4Qlg0V0lTZU8rUnJtZmhXT0t2ZmZG?=
 =?utf-8?B?UUdQcTlIRXJKQlMzSGVQckxocHNSSktRTlZVYVMxVHFaUjRlcVl0QUFiQUFk?=
 =?utf-8?B?b0NuVEZ6Q01nbExuOVBsUVFqekJFRmdXbzVCU2wwa0hzS2tjaTdzRUt6SWZU?=
 =?utf-8?B?UEN5NVVCeis1bFByZUJGVnArY0RaOCthZkN2TWJ4cUNZc3FxTTBBUHhuVHhK?=
 =?utf-8?B?SWY3NXlOcFJvekM0UlZhVjR4dzZwZjBHUXlvN0Y2RloxdlpCT0V4SUdkdjJy?=
 =?utf-8?B?Mzk0RGJOY1NOQmZIaVpGRDlpdGYrTXNsdko1ODJDWnlwS2NvL01teXlKNFUy?=
 =?utf-8?B?OGlIT3RPS3FCa3VDNGRZNmEwcFdJZzR2SVBTN1A5ekVpa3pQaVVQUEgybmt3?=
 =?utf-8?B?T1FwU3JCSXRXclVpRjBPL0RzVE1EUk5hODhpc1ZTNnE1TmZOKzZSejhkTEhV?=
 =?utf-8?B?d1dPYmhNbDZGU3NjZXZwVWNSWnRHNFkydW9oR0VzQ0VMd055VTM3NGlUTkov?=
 =?utf-8?B?Z3UxZ1hUL2pBSncxK2xyNi9YdFE1UGNYNThWN1ljQUFxQUxvS1VFaGIrTEpG?=
 =?utf-8?B?QStQS0VDa1VpS0ZrV0R0VEtJY2cvT1lOYUQ0UkFSSzkvUVBlUzVlUVU1b1pi?=
 =?utf-8?B?NWtHYXI2WTBQcVdkTjFLVk4wZG9LSzRvMkFBZzZ1b1A5WWtZbythRk5GZEZO?=
 =?utf-8?B?dXZCOXRDaXJIcVpmcmZuQTNjMHI1Y3djM3FRaGV3aU9WMzB0MU5RN0w0QXVu?=
 =?utf-8?B?a3ZMcHJrd1k0SE5vSE82WU5UY05mSzRTeEY0L1RPNFE0bktsWUNaN2NpZWlM?=
 =?utf-8?B?RTdyVFgvR2Z4cnRsTEYvejlUWmZ0RHhvU1NVR1Q2UWFWT283TWF3ZktjOW1E?=
 =?utf-8?B?K2tsYXZidTNLRTlTZ25vcEF6R0d0em9Nb3oyTlMycGRCMEpaeEl2dWNFRnBw?=
 =?utf-8?B?dmpuR1UvcFdCVVVmeHdrRlQ4cG14MWlKTTNXWGNBanB0a0hZUTM5dTVkVnQy?=
 =?utf-8?B?YWNWNkRUUFc0MkNiK2F6Y0dwU3ZBNmVWMU14dUNBaVJJUjVObnMzdTRZMmpR?=
 =?utf-8?B?Y3dBUUhUdk9xNmxhM1Uyd0EvOS9nbEV5ZU5ZQXZ4aGRtcUFQa3NPVDZwSTQ5?=
 =?utf-8?B?TlQvNXlaU0ZqVTVwNlRzUXF4dVJPaUtZNENhWHJLVy91ZU1sVEt2cEVpOW9n?=
 =?utf-8?B?d1VkUmF3QkFTM2NSUGRMWnNqWGZEYXBHdGc4clk1MndEMjZCZWJ1MUw1b1Mv?=
 =?utf-8?B?d3hFWmtEVHkwTkU1Wngva0tZQTFjZm8zNmFDMUJXYTFDaEtYOXphVUtOaDhn?=
 =?utf-8?B?OVVOL2FYYTRoTi8zcTM3c1NmZHl2V1FzVEtLMm5jVW1oQmJqTVNQYWI2akY0?=
 =?utf-8?B?RmIzTTdZVTBPMzBzMzlQbFd2WThSODBTeEFzSFA2M0NwZ05NaGJXK3p2bU9X?=
 =?utf-8?B?ME5ZR2JXOGthQmY2ZjBRWHlYcGNWWjkzSXFiZHhSYUs0eE50OVprZHF5TE5M?=
 =?utf-8?B?UHliOHF3R1pLNGRMQlZzUWhWZ3ZYSXcwQkp4bzFCMHc4UWRXRmNIaUF6U0pv?=
 =?utf-8?B?ZDAwbDJrQ2xZNFV5RC9KMmIzYUpVaEovU2lRc0ZBd2lXQW9Mek5DUTF5R2Fn?=
 =?utf-8?B?T1Mra0dVOTJreER4LzIxUGxrVGl3VGtsWWFKWHRUeTh5U1JIb3M0SlpxWXFL?=
 =?utf-8?B?L0tKMUlWZmNHTXBVa09RbHBjMDhIZHprdC9UTkRhWStoQklPd2ZBMzdNUDEz?=
 =?utf-8?B?WnpSdjB6Vlk4bzBsc1BhZHZ0SGVBWVE2Zno2cGNkcE1ET3dtOG5sMDFLd0xD?=
 =?utf-8?B?L0VnRUlPMTBhUGx2cG5qcFg5U0tGS0M2WkE2S1c1ZlFSWXVvRk1HKzEzZWw4?=
 =?utf-8?B?L0pJbHhlNnl6VVZaK0NncUdZWVphOURyc3JUNFJUeERuY1FuMXBSK3dlMU5S?=
 =?utf-8?B?VDB1aDNtZjA3QS8zODZubFBySUVnZm5uMkhHSFkvNytibXMvR28zOG5GUDIv?=
 =?utf-8?Q?CHrk=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 12:26:42.8407
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8571a52-6dbf-42f9-04d6-08de3bd53497
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB3PEPF0000885A.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6154
X-Authority-Analysis: v=2.4 cv=PLsCOPqC c=1 sm=1 tr=0 ts=693ffe87 cx=c_pps
 a=ufeuPVXaArrw0WPMXmQESQ==:117 a=d6reE3nDawwanmLcZTMRXA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=wL9PcE0S0AMA:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8b9GpE9nAAAA:8 a=_yLm9UPoPh-myaD0egUA:9
 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22
X-Proofpoint-GUID: SPS2J9n7GYpq_jYg7jJZugMUKthyTJrK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE1MDEwNyBTYWx0ZWRfX7ZboeZKef837
 2X0DWhFy0JE1UxSqWioKyjb8orGpT9XSj3JgMZqUsUi5m2t4nqVuieONOM/XET8BUYB0ksRe+1L
 IIUGOXCiPaLLZQofXy/LQyjClor2a+MynAS1hV1VoNsI3emIa/Spe3Iu3R784HIibNoTHJ3Sioi
 M9SUolVmm7dyW0MALQbL3Cn1wWiyLEb/MThB2N7a+NMPaQLdy3wbjjFnQdpB1xQe3P/9li5welG
 3OmZGt8l4GMVKzgLUO9kCISJ/Nuwi2QKDgnjYIrwVKY6AJqwlQ3TScZG8MkbxmOgogA9WbqwPyK
 eLy4+ajYpMOn74rLzVsmzkYv++JReodVDnB3ueUNBZqdfogZaxwP66llbKLznxxuwsXoRioyIHR
 yD3W6d1ZCEbFX6SRhDEYjr+fFblonA==
X-Proofpoint-ORIG-GUID: SPS2J9n7GYpq_jYg7jJZugMUKthyTJrK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-15_02,2025-12-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0 malwarescore=0 impostorscore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1011 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512150107

This series add the possibility to indicate a power-domains for an spi
instance and set the related property for all spi instances on
stm32mp2x.

Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
---
Alain Volmat (3):
      dt-bindings: spi: st,stm32-spi: add 'power-domains' property
      arm64: dts: st: add power-domains in all spi of stm32mp251.dtsi
      arm64: dts: st: add power-domains in all spi of stm32mp231.dtsi

 Documentation/devicetree/bindings/spi/st,stm32-spi.yaml | 3 +++
 arch/arm64/boot/dts/st/stm32mp231.dtsi                  | 5 +++++
 arch/arm64/boot/dts/st/stm32mp251.dtsi                  | 8 ++++++++
 3 files changed, 16 insertions(+)
---
base-commit: a6961e2ced5190c68acd78a7e372de07f565fcd6
change-id: 20251214-stm32-spi-mp2x-dt-updates-048068b7f05e

Best regards,
-- 
Alain Volmat <alain.volmat@foss.st.com>


