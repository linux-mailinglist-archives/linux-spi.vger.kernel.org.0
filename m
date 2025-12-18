Return-Path: <linux-spi+bounces-12016-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 02472CCB7AD
	for <lists+linux-spi@lfdr.de>; Thu, 18 Dec 2025 11:49:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A1459301A9AC
	for <lists+linux-spi@lfdr.de>; Thu, 18 Dec 2025 10:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7DBF331210;
	Thu, 18 Dec 2025 10:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="ZbOLpyDf"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D04322DC0;
	Thu, 18 Dec 2025 10:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.182.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766054942; cv=fail; b=Jalro6VlW3JwClK1zPyOxA4FzpnAuG9si2U4QD7dfK+2vGPQ64F6ScIkr8y8KD83XJoo5W2fceuUK6/Wqq/QJ/QsPgu6ZH+IG4Mlk+XVaM0NT7P5Lst/RjsZrRrIPy2lqxGyD7C9v+sv7H4Jhzhvfl0JVAAMdhFloIa8pNoT6/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766054942; c=relaxed/simple;
	bh=WLJ4U7X+t2NjoKk7W1/S4D/d3hver4K6CDSK06rDFBs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=bzy4DW5HgguqJyqwEQXVrqFhJLa2UXoQvYCzZQbpraMMVbxo2l/4xJK9j3OdBaVndP/4//Agt1G9dHKFLFtvroeLuDbz7UAYomXdKtKCt45ANsCZcLVk+CxBMYjlKwxCjkJIBtgnGNT2ENLj+V/tFo/e1wN4sY6jC3h0FegdiWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=ZbOLpyDf; arc=fail smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BIAiIPf2694328;
	Thu, 18 Dec 2025 11:48:51 +0100
Received: from am0pr02cu008.outbound.protection.outlook.com (mail-westeuropeazon11013039.outbound.protection.outlook.com [52.101.72.39])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4b4estge6q-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 18 Dec 2025 11:48:51 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rsCBPF/KGOSKdVp3yg+CtLd1R6uevbdI16vyZ9lCE3nLBLfSXwCHS+8UfSS8/RbarjjQ7D6mfSOqanc8dIoE0IknUa1LYfc6wCEYP99BZj7UTU6+AEghy7jIRiaJBr5f0qjUsqT2pZNzPlu8+GTL9WsfFj0ravvfv8XKvLgozkPw22Y8hwaY4vrQEbL1lWq2/vT9EesULhn+xG1z7be0E2tAhc5XtEslwZqYhMPgRAl0Sx7z8Gr8z/rFh1mh8tc/n2aTf9W38DQWJTpKctKCkJyBihcd8T7KgVa/tIhTiqklNwQ60goPEAJ7ApDTnmGK/R9NZD/Kv5DRy9GGMxbxMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GTdOjoUTe+POBvl854/wkgwu/9d7NJKuLPeBBZkOHOc=;
 b=J3JuISq8FZHnVlm+l+E9XmivhzYl5Htjx5TIx771Lt57G5IlxFfcmY77PldMdEeCAxXVFMde5mQUkvbUjKgdBuomZtf3T8RLBTj19SXr41SON2Bh7nZOaU4fcav3P96gkHFn7xhsvJJGtG3vghkiq6CpIBWqSw1KMxVUV81hmPlwP9436n0k5sBSbM0t6LL1nkD9AdLAA7w7VCcgIyHIhWPVNkURe/a6TEm8LjxAlwXY8jgmYub6Y6AdFE6WEEBvDglFlL1RFvQ/BKEuAoWpJjYE+oyI92X9mN5o+YxWePdbmyZ3VSBGcrOLiKr1/BTcd0rwEIrqJ8ciulI7KG9A0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=gmail.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GTdOjoUTe+POBvl854/wkgwu/9d7NJKuLPeBBZkOHOc=;
 b=ZbOLpyDfhWiqaUJDfbScYSRkMOiFOrw3WqZIlzq/x/Ol5POAYPElWNrSPjn7xCv6HJL4iPNMAHCha2Mx+Rz4H0U7/K7Cj5geeYTZnFJiA9FXE00+/gfe2DxbSL8zPv5a/ouoaxmCPdH3rgJUd0fsvEQdt++Be4YI6OJH2qG6ac46jAS/wgi/AFjjcuFd6azIUVQMCxIKDYfaHXis/35k2xp9AsJynu/vH9qXtYEUM7vU79fOAPWf85PrnVREWT/to2j7Ju9iPZZydhvPSE15NSxW+/RFvO5PrSgpyTBV3EI58eYAf1F974Mbt0yxk+H/kXT6OU3IKg+wyS614hbSrA==
Received: from DB8P191CA0013.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:130::23)
 by DU0PR10MB5922.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3b6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Thu, 18 Dec
 2025 10:48:49 +0000
Received: from DB1PEPF000509F7.eurprd02.prod.outlook.com
 (2603:10a6:10:130:cafe::34) by DB8P191CA0013.outlook.office365.com
 (2603:10a6:10:130::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6 via Frontend Transport; Thu,
 18 Dec 2025 10:48:47 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DB1PEPF000509F7.mail.protection.outlook.com (10.167.242.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Thu, 18 Dec 2025 10:48:48 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 18 Dec
 2025 11:49:35 +0100
Received: from localhost (10.252.25.7) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 18 Dec
 2025 11:48:46 +0100
From: Alain Volmat <alain.volmat@foss.st.com>
Date: Thu, 18 Dec 2025 11:48:30 +0100
Subject: [PATCH v2 4/4] ARM: dts: stm32: add spi1 sleep state pinctrl on
 stm32mp157c-ev1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251218-stm32-spi-enhancements-v2-4-3b69901ca9fe@foss.st.com>
References: <20251218-stm32-spi-enhancements-v2-0-3b69901ca9fe@foss.st.com>
In-Reply-To: <20251218-stm32-spi-enhancements-v2-0-3b69901ca9fe@foss.st.com>
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
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F7:EE_|DU0PR10MB5922:EE_
X-MS-Office365-Filtering-Correlation-Id: 25c972f0-4664-4a99-4d80-08de3e2306aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VU9uTXdRUkg4QTd0M1JvU3pydGN2c1NvVjJ5SVhRZHA5c2dNcUVReEFaUnlQ?=
 =?utf-8?B?Qk9ZdUw3RzNmYzRHQW1VNEZoczF0aWxWM3pIc29uOEVnaTFqZzhDQWozUW1w?=
 =?utf-8?B?bXdpcHJZQmRwVXB5OGpweE9MTWVhbGxXVXhMaDZwQkFubmVVbFVKQlZ2anRs?=
 =?utf-8?B?eVdicWt5SUJSUnBubklmUG5US3NvSDM1UFEzUGN4eFlOcGFGSSt5NVBOeit6?=
 =?utf-8?B?cTBNNUNQMEVXYWQxUlErWDV4R3JmQnNxTDArZ0xUaUo4ZnpnWWRlRmNST3ov?=
 =?utf-8?B?TGNlQ1R5VjNvSEM3VEpZWG4weWovdUhLeFdCOWhzclg4SmJ2SnArWm5udFU2?=
 =?utf-8?B?U0tKUHZIN0pIaU9iZU94ajliVlpUeENQVUZVUFRuQXlzeTZRam1oWXRnQUpO?=
 =?utf-8?B?cnMwV0RTNkVmQ05BdllnZzY3aHFsbFJKSlpUQWc0UDFwVzhPL1dFb2ZPbE1k?=
 =?utf-8?B?Y0dTaGtnQitmekIvWXBtQXI0c1FUWFEzVUhGTGFqcWx1YndPa1ErSlFNUEIx?=
 =?utf-8?B?UU5nNWIrZEIwUmhXdjA1TTJIZDRNbTlFUkNOU1hSK0RFZ3ZCT2NZMXJMSXV2?=
 =?utf-8?B?S24rVmtjVmY3YUpheWV3anB5bHFreHMzNy9FNXFmeW1Qci9kUUVaajhQeWNa?=
 =?utf-8?B?eEROZEZHR2E5bzRKU1FCaGRTR0VDTUZBVys0a1RScHJJd3lTazU4bFBtdnRy?=
 =?utf-8?B?SzRsckdMVVM0ZmhncDNTZkE1dnhhZnc1ZGhlckdQYitQZW0zR09ILzVtWTRB?=
 =?utf-8?B?SnZKK2dGeG42d2ppZ3Nsa3BpWllFZjdxQ0ZKNVRVbHIyZ2NKODV2c1IrclBO?=
 =?utf-8?B?ejVqWVhmcFpjWkxvOGljTmhiaXhwUDNJdVo1UnNJNHBkMFU0TFY5U0NGeHhC?=
 =?utf-8?B?ZERiOXcyOHZydmYzQnNDQXVKWCtvZEZyRkdvdnFneHQwOGt4RXJRVE1vcnlr?=
 =?utf-8?B?cmFwallxRHBkYlJBL1VkSDdtbGlaOGhSQ1poSlRnd0czYUI1WWQ4blJzS2tB?=
 =?utf-8?B?elBMMmdlbEhKV3U4QnU4QmhocHdWWHo1NE5xcEhDUGVmWEl2em83S3N1OUk1?=
 =?utf-8?B?cXpEU3JNU2JGZTIzWGw2NHJFMFFNZzVMbnhMamcxMnZSZGdXdUFaWjgzVS9W?=
 =?utf-8?B?RDBxWXBxYmpObDQ1Z0xNL2pvOWhLVHdLb25ydGtuemo2bENWTHN6RzIyY1or?=
 =?utf-8?B?TlJLWkNmWTdMMVZyajhqWFU2TUdRNlZuNkRpUVNJRXd3cWhZY012aXM5eVdu?=
 =?utf-8?B?QWNzcHpBRmVvY09aQk5YTXI3Vy9ZMncyUVREUUtNbU9YV1dYZEJRaW0vV1Ar?=
 =?utf-8?B?dnRmL1VVenFEY2kwL01YeHh4d0lyWUdWRlpoekozMEp0dC9wWE5ST3JYU2Fq?=
 =?utf-8?B?VkJ2aFRlU3JWZWwxMklxTE5wYWVROVpEMGQ3UFdWRkFJVnFrenJwVHpwOW9E?=
 =?utf-8?B?RjNMUnRscHlzWS9HSkQzVUwrdmFJK2Jzc1MxeEJ4ZUpjUWRlM1FzdEYzRFAv?=
 =?utf-8?B?eVJ2YlE3S2hIU1RDNktTUUVZbjdZYy8zR1g3aEtnYm40QUZVamxBUXdRSG5p?=
 =?utf-8?B?N1l6bmNwUkRCMU9lMkdjbnlkSG03OURLWXVKUHJBVXlRd04rbFdLR0dmRTdI?=
 =?utf-8?B?eVBIbUtsOG9sU3hPK1RPMklqb0xCRXZpbGdQSExQelZyamN4VXlXTTRvb2dZ?=
 =?utf-8?B?K3FkRlh1LzU0ODkwSllacC82em02WmN3M1AvVFVFUXBmdFM4R0ZZUG5OWGR1?=
 =?utf-8?B?bVVhYm9QRjZibWFqYkl2QndNTCtJZ2ZVUHNNbDQ1a01WYTFuMWYyNTR1ckto?=
 =?utf-8?B?dmNXWDU0bytDVTNrZE9zVkNTZ3R3bktTYzZ1SkdLaWdxZXlvN1Z1c08zR01O?=
 =?utf-8?B?YTZ5VklNMU1CdmI4N1R3L2ZtSDl2UGhrbk1ueU9WSUpoVGxjanZLWnNpUCtv?=
 =?utf-8?B?VEpZRVorL0RBV29KSDVYdkhiem1oZmdYMzhyVWtHYldiMXNJSzk5NkIvT1ZX?=
 =?utf-8?B?R3Nac280TDdmM21lZDNrT0xCUlNsUEQ0TjJYQkkrY3FoeklVdmtSbG9EZGp1?=
 =?utf-8?B?dEdhRmxtUmk2WkJFcmJvUmM1TE1IVUZTd2hpU3VMSEtNK0Z0Mk1IaWZ1aU9R?=
 =?utf-8?Q?Ec6I=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2025 10:48:48.8617
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25c972f0-4664-4a99-4d80-08de3e2306aa
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F7.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5922
X-Proofpoint-ORIG-GUID: lXlyLj6c_IPUBzccTwIEG8G0aWCst1bc
X-Proofpoint-GUID: lXlyLj6c_IPUBzccTwIEG8G0aWCst1bc
X-Authority-Analysis: v=2.4 cv=Htp72kTS c=1 sm=1 tr=0 ts=6943dc13 cx=c_pps
 a=pv+iSUMxSX8tKyfHAWeKVg==:117 a=d6reE3nDawwanmLcZTMRXA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=HjypFGx7bZcA:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8b9GpE9nAAAA:8 a=LcYmuGOQLzMn2Ft58YMA:9
 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE4MDA4OCBTYWx0ZWRfXzp+U8iDanG0F
 Li/pflYBPoTwITGx66YbQ0ftIp5Bdcu1pfwtHtWG0olk9a2i/kjsKcDFt1oSzDMb+4jrQCLxC9I
 KIcJOFN17m8Vua4KWGf1aq+wo1nZr37MGNY/9ZqHUVBHL3+vQigIuz1nxNN0owHId3WgRsrRFgq
 4BB/kNQiD8f9gOtJzT5hBAMluk507AvNqTkEk5PyFEVTcx9DR79Wb4svwCcBJoSxOATrHC0oR68
 tQRWCCIG+8Cvt7dQLqKlvxkEBRb4sa6l6sCO2xFTjHcOAWfHwA5UmUJRnufhblXw8yEcUZnK+7y
 bSIVjbWmJnsv9yWtnj9eYMfojY/bVnukc76saFJsXEhom3c2PDPQ1Z9Bd+zlXR+iLEPTQuysWWa
 uEf72IbzxIavar7xtnKS7X5FrrE7xw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-18_01,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0 phishscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512180088

Add the sleep state of the spi1 instance on stm32mp157c-ev1.

Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
---
 arch/arm/boot/dts/st/stm32mp157c-ev1.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/st/stm32mp157c-ev1.dts b/arch/arm/boot/dts/st/stm32mp157c-ev1.dts
index 8f99c30f1af1..4e46d58bf61f 100644
--- a/arch/arm/boot/dts/st/stm32mp157c-ev1.dts
+++ b/arch/arm/boot/dts/st/stm32mp157c-ev1.dts
@@ -296,8 +296,9 @@ &sdmmc3 {
 };
 
 &spi1 {
-	pinctrl-names = "default";
+	pinctrl-names = "default", "sleep";
 	pinctrl-0 = <&spi1_pins_a>;
+	pinctrl-1 = <&spi1_sleep_pins_a>;
 	status = "disabled";
 };
 

-- 
2.34.1


