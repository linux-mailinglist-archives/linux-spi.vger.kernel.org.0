Return-Path: <linux-spi+bounces-11993-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F6C1CC9A45
	for <lists+linux-spi@lfdr.de>; Wed, 17 Dec 2025 22:53:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A9FB530389B9
	for <lists+linux-spi@lfdr.de>; Wed, 17 Dec 2025 21:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F33C3101BD;
	Wed, 17 Dec 2025 21:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="aD9So6u4"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C88330FC3B;
	Wed, 17 Dec 2025 21:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.182.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766008377; cv=fail; b=FZpWtCA94QHPDNaavi/XnkSLmtKLj97nV1ho8F4IeI4Ninw/CbG6HLA2fZIWbvjzBjeVDmtS0ewLLBBDmaAJ3ZOxEU+Xk4Eo0sUI2Ot90Pq1USq6Pu1JoNcTaEBUXrDvlFkuIRRjTezZ2cSauLxPxG5WDTdhViRKJSdFM/v0q/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766008377; c=relaxed/simple;
	bh=fot0V+Hy2Wn8od9OpJOxEk7+tR8wuWl+PSLy9adtVAw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=QJWlIpDnqu/+V3A25I9a5hojch2bK0tjfkUgqtVKS4iQGCs44hyb0d3Dej8u0YtEbkvAhoBipWMxhZpCyCfZmNxBaSl9caNX27KSNM5h8SFdQ13QbikPtvOE9CzAHua9dX+WTo00DzGotNhQAn+HhAAJ4Bc8op4zkh7CpMrX75U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=aD9So6u4; arc=fail smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BHLRYsu704927;
	Wed, 17 Dec 2025 22:52:43 +0100
Received: from am0pr02cu008.outbound.protection.outlook.com (mail-westeuropeazon11013015.outbound.protection.outlook.com [52.101.72.15])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4b3xb71kfe-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 17 Dec 2025 22:52:43 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RFB1YmZH+XCrfSjIT/hNd5SRhoDlp4Ncu8G7CYJUBvtoY+qspg7I+Xbd25T704YpvC3iZ5y97WnmMgFaDrTKSoPZ6FCem5pbq+nVmKBqA2V1zj8u7zQoO2kvkRhzHj06EuXPJGzvuxEB9HwFv7THz157hMllOYjqehptU2P6cqjFmCTBbCni/x+KCjKPgk2n+kMGO6shrBSl/E/anRsKF76NSC+V0onH2vb3ojulbC41nfE4qfGOHlQwfewBxr8HCh9+PkprS7oesaxmIUtwuxj5rge7Md3GErG24RNMjxhYn8eWK7OhSZ2gT1nye7JB4D06js2nTat9NoPsUcWScw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l6sBscYzo6SF3yveg9SMhkC92zlzcwkWbT6RB8DHq2A=;
 b=KzJ4/I3lQIw/4ln0luck1UNPp+7c5nTo6k2Ity0wRYtRn2cT++3tBCnNRZSuyFA4txwllYYSDUWx6EEy8BWkd/0x+vlg4u5xQVVuIqCgY6yItqEJOq0gMwwwpcq8A3Ny4RxoyHqh21C6Q7p8i0nu0L3SmuV7hKngD5JdM8lXuHdjGTVQL4+BGlpyQfDrrNIYxBdXOMAkVzf0GqHYGOjyLEucjifKS0clRLFk0y64kaxRZBZoR4l5P4b76R+UgXhXpVf7fp4zfABrE8cyCSSQFkrMr5TZVz+NtIQz5/xGKmKWA9ntl4nkeErbIlupcHiOBdr7IV/Jz9Cln4WkUvurDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l6sBscYzo6SF3yveg9SMhkC92zlzcwkWbT6RB8DHq2A=;
 b=aD9So6u4sHFrD9gnS/WJYF+nPN+lumAv5TlRQDSagTmifgCA8kFF7TKrBUeOqBUt7K+dApSkVfOrG0vQDgp92C4L7wCr8x3bfUSmcgr0Hs1fAWPFF/eQKZoweHZZoSRJERkIhaBIMIUqTWFHhovr7zqfFmayCbHD7pCg7zrntCJdUXXEttIOiqHVg87FCqgrtZgd8F1tak1EUG3jOBHpsX04RJ5t+HSbDk/f4ryJYUOOyC+OPnV65ucpeJETfep+i0Pp85XV81rllbZ8Ce+ViAWL+p+S8+tCwsbFYZOYFzu5Q6qKEfcWIsnZNUYrFuZy4AAnDzDZZ98RqS+mT9bTmQ==
Received: from DUZPR01CA0166.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b3::9) by DB9PR10MB8120.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:4c2::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 21:52:41 +0000
Received: from DB1PEPF0003922F.eurprd03.prod.outlook.com
 (2603:10a6:10:4b3:cafe::b5) by DUZPR01CA0166.outlook.office365.com
 (2603:10a6:10:4b3::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.7 via Frontend Transport; Wed,
 17 Dec 2025 21:52:52 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DB1PEPF0003922F.mail.protection.outlook.com (10.167.8.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Wed, 17 Dec 2025 21:52:40 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Dec
 2025 22:53:29 +0100
Received: from localhost (10.252.10.67) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Dec
 2025 22:52:40 +0100
From: Alain Volmat <alain.volmat@foss.st.com>
Date: Wed, 17 Dec 2025 22:51:33 +0100
Subject: [PATCH 3/4] spi: stm32: properly fail on dma_request_chan error
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251217-stm32-spi-enhancements-v1-3-943348b8ff66@foss.st.com>
References: <20251217-stm32-spi-enhancements-v1-0-943348b8ff66@foss.st.com>
In-Reply-To: <20251217-stm32-spi-enhancements-v1-0-943348b8ff66@foss.st.com>
To: Mark Brown <broonie@kernel.org>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <linux-spi@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Alain Volmat <alain.volmat@foss.st.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF0003922F:EE_|DB9PR10MB8120:EE_
X-MS-Office365-Filtering-Correlation-Id: da48c637-5a82-4735-de94-08de3db69a0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OUdXT1FGdHRtbU16ZFFJRU9RQjkvcnMrTXltQ0x3dlFiVThqUkxaSlRGVEFN?=
 =?utf-8?B?L3dRZ2EwbzBEY1Q0UEZuMXZJTHJndFY0cENpR1E1a01NYWVmYlk4SnRiNVR3?=
 =?utf-8?B?alJYT3hqZEJBY2hURWVKeFNrbDRFY0dMVXYxL1p0dm9ZQ2lSSTBmSEpBVWE5?=
 =?utf-8?B?MXpNbXgySEpZMHJRZmFZeXJYd01FYlBoSXhTeVVUMkdud21yWnBERmU2c05h?=
 =?utf-8?B?K3JBeVlXRWYzOGlGRmlzaEZQQllKeU43QlZra2tCN21VS2NNS2lUSjc5Y2tV?=
 =?utf-8?B?Z2c0alo3eHBYZCt1SjdXWnNjN3FRODhiY3JHbWpaK0lPQ2I2OGpiQnZ3cHJC?=
 =?utf-8?B?K21sRzRmWGRyTVk3OGVWSVR0OXFLTS9wMEw5a0E2UExaK0tRb1QrOTdndDl2?=
 =?utf-8?B?VWlYM01leWxtWkMwcTc0cWRnWXhBdGNUYjBKWDZWbHlaRVovWXJqSFBYakRo?=
 =?utf-8?B?bXBZQUJaRXQ0U2lXWW5qTzhNWjNzT2VlVDhiaWl2eG9mZktCVVpTeG5VQzNG?=
 =?utf-8?B?OEo1Z3g1TlVNZ1ZTcGxoTk1rNnQ0QkFzSnRDUjU1U1ZTZGh5bVFZTGEyck45?=
 =?utf-8?B?NUNJR20wcjdNa3NOZjhmQnk2S1J0UEdvRUx3Q1lOUk9QVXpnL0JCc0M1RXdD?=
 =?utf-8?B?cjVVMW1PMWVIakNPV2pIcjFzWU1SVUZaVm13bTh5TnJrY1Nwdmt2b3BOdm5q?=
 =?utf-8?B?WHl1dHpoSDU1cnJPUklCT1Yxempuam9qejN3SUx1ZVhhOEVpREEwaE5tTFRr?=
 =?utf-8?B?Y0Jpdm5ydlJRVzhDYVEzeklhaElNVTl3SXdVd0JvblBUYmIzb3lic0lJZHpR?=
 =?utf-8?B?NUVOQmVSSXFYbXNFYUNySFVSQXptZjkrbjVJR3R1ak9ieFVsc1cvd3dWRCtJ?=
 =?utf-8?B?UzB3VU1TYjBBcVRXK0h6T0F2VFJsbFUzMkZialVJR1pIQ1BxbVJnRGVVb3pM?=
 =?utf-8?B?c3FLRnFINnplN1JCRjBGWTlOQ3hnQ0FKVzdnS3FyMUFDUlBPV29hVDNZYjg0?=
 =?utf-8?B?N0cveVpxS3FtdXQwdmlITTRYZDdnaTcyMmxvdUdGbktDdTdham9hUkN5ZGdj?=
 =?utf-8?B?MWdkYmd6dFU4dlBESUNHL0RVa1FmVGNnOVBCM0N3a09iaWNDMHNWdXBhOU1x?=
 =?utf-8?B?R1UzTUJSdVpiZWJCTWQ4b2QyOWhLZmZDM2RxOHRpZDVEd0F2RG9iNThYaUdO?=
 =?utf-8?B?ak5OZUNtMlFZYU1LeVpjUFNURkltTmc1WnUzSC9mZHZoQWJPbWhRRmZoaUUr?=
 =?utf-8?B?TWNubDJKK1Q1MUEvOUhDM0Z4eFZlNk9SV0UyN3dMclp2Zml0ZUdDRFptQUFI?=
 =?utf-8?B?cTV2NEZvbnAvTWprM0ZadWkvdzY2eGtkUldxZDNreDF4NHpPMzJSTXl0Mk5i?=
 =?utf-8?B?cDZhN3VBb1haYVpUMTBEc1hLZHdGMjc5QmxLc0IxOHJKeDVCK3ZUQ3VYNGdL?=
 =?utf-8?B?VHBSNzJMZlJRMkxYZzFMUXRLdXJVS2I1c2xMVkpOd0RtL0p3MWpldkNUNTZQ?=
 =?utf-8?B?aytlVm9QUFVlTnNkUElYRmdWd1N5aGhtMDIyUkRNakF1UnFEbklVMFBqZ1Nh?=
 =?utf-8?B?c1pYeW5OYW15ZmNOcDkwQkMyUmh2b2RkUkV2aU1ZeW0vdXl5dUM1bENLTytN?=
 =?utf-8?B?LzIvYUtUOFdkKzB6UDRhanM5S0hkbmRUVlUzQ0p2ajM1dHA3a0tFMklFSllv?=
 =?utf-8?B?Vjk4ZnNjR2V0RU50NSthNzNwR0wvd2pNeXkyWjh5NmRoMGV0cE9ENzE1ckkx?=
 =?utf-8?B?Q29FZDFoY0RtTzg3TVJZaU94UHJzaEtvN2ZpdkcyYUM0WEhkSFNGczBEMUFD?=
 =?utf-8?B?a3VWVmxGdk5Ba29sYW9CNzdqQk54cFIzY2taSGJnRWZOenFtSE1PZzdpY1RT?=
 =?utf-8?B?OVkvU2RIL3JjTDJ2VG1JN3MxSjdSa1JHRmRkZWlKZVg1dVNEVjdFVWRhVlgy?=
 =?utf-8?B?aEpOcHkrSlFOT3VvSW81cUZmcGlydFp1b2wreVBDN0pqV2lkdWd6SG1mZGR0?=
 =?utf-8?B?eXRhMk1IekZNeEZMclRNVjdaYmRvdmpQQ2UxVU9XNlhQRmpEeGZXVmdxVm9V?=
 =?utf-8?B?djFIMWtpbzVNcHRiOFh5M0MxV0haYTV4cURCUFVzUDYyQ0J1NDJkTG45L2hV?=
 =?utf-8?Q?DKJY=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 21:52:40.9904
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da48c637-5a82-4735-de94-08de3db69a0b
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF0003922F.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB8120
X-Proofpoint-GUID: fG8ByLAPY6yBcqCiNWqkWma77LUEAmp4
X-Proofpoint-ORIG-GUID: fG8ByLAPY6yBcqCiNWqkWma77LUEAmp4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE3MDE3NSBTYWx0ZWRfXzDNAuleyebRQ
 Tngqa+KuqWCSXHYRR2NHvfwIWpBPu2A78bkTB8n2xvQBFcQgarJguh6b8vrIj/zSKvAAKjaplfG
 8cloJXu6kndp7HmZLJxjgHRmXEAcQV2z+QiT4JJs0xtewyZEZyatPCuCIj74sar4IcokHOiRHuq
 xZ+iJELg+ZWmvjATwm5pClD78XukS8tVXgUj0Wvc58A/8yT/tkt9dfzolh6taZJRyh5vxN1Kp5K
 xaUlBkxoH6Igk1rHy98rJOXYgXTvt/pm8Jx4M1o3UaegC93W+HovqeUhaVTCLk2aCqLqdVJDHaC
 n4+DOgD1itMg5+5IarPUQM7mYvO8XBsgR2vdWjsA+olTVAckEanXPyrUdoVnMUAClcZASNnhmQm
 HVkJs2ZCiBzbObVyjSY++Y6JogaKKw==
X-Authority-Analysis: v=2.4 cv=NZfrFmD4 c=1 sm=1 tr=0 ts=6943262b cx=c_pps
 a=Q/FndMtKwbRzRApk2AKv9A==:117 a=d6reE3nDawwanmLcZTMRXA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=tougUffuSCAA:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8b9GpE9nAAAA:8 a=1dThCIPtdYaSHmSm3WoA:9
 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-17_03,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 bulkscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1015 spamscore=0 phishscore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2510240001 definitions=main-2512170175

Correct handling of the dma_request_chan call in order to avoid
misleading warn message if no DMA is provided within the device-tree
and moreover fail if dma_request_chan has returned a valid error.

Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
---
 drivers/spi/spi-stm32.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index 353ea5b93e0a..8f8968383ad0 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -2484,11 +2484,13 @@ static int stm32_spi_probe(struct platform_device *pdev)
 	spi->dma_tx = dma_request_chan(spi->dev, "tx");
 	if (IS_ERR(spi->dma_tx)) {
 		ret = PTR_ERR(spi->dma_tx);
-		spi->dma_tx = NULL;
-		if (ret == -EPROBE_DEFER)
+		if (ret == -ENODEV) {
+			dev_info(&pdev->dev, "tx dma disabled\n");
+			spi->dma_tx = NULL;
+		} else {
+			dev_err_probe(&pdev->dev, ret, "failed to request tx dma channel\n");
 			goto err_clk_disable;
-
-		dev_warn(&pdev->dev, "failed to request tx dma channel\n");
+		}
 	} else {
 		ctrl->dma_tx = spi->dma_tx;
 	}
@@ -2496,11 +2498,13 @@ static int stm32_spi_probe(struct platform_device *pdev)
 	spi->dma_rx = dma_request_chan(spi->dev, "rx");
 	if (IS_ERR(spi->dma_rx)) {
 		ret = PTR_ERR(spi->dma_rx);
-		spi->dma_rx = NULL;
-		if (ret == -EPROBE_DEFER)
+		if (ret == -ENODEV) {
+			dev_info(&pdev->dev, "rx dma disabled\n");
+			spi->dma_rx = NULL;
+		} else {
+			dev_err_probe(&pdev->dev, ret, "failed to request rx dma channel\n");
 			goto err_dma_release;
-
-		dev_warn(&pdev->dev, "failed to request rx dma channel\n");
+		}
 	} else {
 		ctrl->dma_rx = spi->dma_rx;
 	}

-- 
2.34.1


