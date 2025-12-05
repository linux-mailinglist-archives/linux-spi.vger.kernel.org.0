Return-Path: <linux-spi+bounces-11784-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B9ADCCA6D1F
	for <lists+linux-spi@lfdr.de>; Fri, 05 Dec 2025 10:06:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A2860304FE23
	for <lists+linux-spi@lfdr.de>; Fri,  5 Dec 2025 09:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5922D3195F3;
	Fri,  5 Dec 2025 09:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="Ac8tNcS2"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B883164D9;
	Fri,  5 Dec 2025 09:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=91.207.212.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764925551; cv=fail; b=qrqQ4wmIf/EkUwYGQFD0SxHNSYAjJnvihh8MeHlBF5Kgn8b2/pf671P4SXkr1YSc0dnwxS0mFsxCBmFijdttElfivFEqqTCu26t/9CE49hUStLcB4cLA+mPUzzZRHTDRVsnSARtZV/UaSvy95b3q7HnL5Zcxrt59HtYM5Fe8pgk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764925551; c=relaxed/simple;
	bh=pWArF7Rl6DABaLrLmNIRTns3uzgvldlqMLrrGoV5CbA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=K6ytLi33msbmuN+z0IunNlVXhSFrp5n6fjCjwt7QaP2Hu0afmDZz/wcAbH6UMsYOp5mQW6zmdwl1R3vUPsCLhrfC8xMFaSLWHmJC5hXfCNKSH0cUBOj4opqevdDvpISNVRccx2K3qhLn6NIYYlpdHtK00Tr8zcGy7+OEsjZ/wZU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=Ac8tNcS2; arc=fail smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B5913M02047817;
	Fri, 5 Dec 2025 10:05:14 +0100
Received: from duzpr83cu001.outbound.protection.outlook.com (mail-northeuropeazon11012031.outbound.protection.outlook.com [52.101.66.31])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4aub8nb5ad-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 05 Dec 2025 10:05:14 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sWi+0hJzGNRlIxgklKsQhaK1/Ajjvti2wPEgHo4/wP+bF1m8kctGp3IhyR4d/w3WbwqTBYVx15Xdp06tu8hQIOblbFJIiO/Sl/eEGW4PGoRHWehYtld7wzIqBfEGVZ5uOTQGUBNHbCJ/ZmVwZFl6iZ9Nfmo9O36cLJ8eDUqg8XwYXNsT7ImmrytYogcSe1nn8CkX6TjlqnkecVMjdXCDiM/nko4lH9xYSWAo1j/Lne4EWgEfbTcZ5zZH4GJMstgb9n5p/FQPohmQkzxJ11YT0olEH89wUphZNoGv12D6wRZfCrPdIvogbHUPtX5B6Q5/0WMR5aBK43uWaW93kHcyFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u35wuCE7vol6K/ekR+LGiXYA9EvNk8QvRyP5wyyfImM=;
 b=s21RBljKDiS1Hesa/LUBS2k+rn8BP2Uo7ZwuOV4KkY7fty8DY2/tGJMJnVJjO8CFJvRxwo+J2mfyBlA6QQV9Jdtb3tsx6mjU/sw6w+vrO09npE475WQZmOsW+xuD2gXjubQHVuHH+0jO8j80KeDV9pM9UrPDHwzCXfCO9zEzugEMoWnCuNDplxnqAjql6VgvOUXGFs7V9AIhnUHpBO9k8JK9sIsNP+JAbjHUhj7+xRQhDoFHPFehGi5/cJeXrg10pHM6WO8FLDlagPvTpEiuC//Csb49lzb3WBNLJhLKGV2mcJvtkbEtJxL2juTGHNAdU3i8HdYKYNzSU4Hv3LwTEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u35wuCE7vol6K/ekR+LGiXYA9EvNk8QvRyP5wyyfImM=;
 b=Ac8tNcS209lW+X07NA79e0xRKIfj7OoQCVFF9F2QD8D321XujgnWOlH4wvszpnqbmhUsADklJwgfL1tu03fH5N5OgweamMmEZ5/96cFShahce8cg5LIgDlCVu5Uo2/yPPf6UbEeQlGBfvdWFqL4ly/XAZ0JVhd3FRwou/iZYj88JDaj1rLuMmgfAiJqL1lC1kpqCGrzFdW44JKvJbP6Q1kHM839iHW9QBhncYpYTPoup5lJ8plekTKXbZROP/jLgo3AKbSkvZBSdSd9E7ZfarIPCVAxEtuHogYkOvFBkBssk3FHbd/LzEmTOuJHfGWzXdHrpOVxA95Z+OMc8Bm1BFg==
Received: from AS4PR10CA0024.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5d8::16)
 by AS8PR10MB7087.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5ed::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.12; Fri, 5 Dec
 2025 09:05:13 +0000
Received: from AMS1EPF0000003F.eurprd04.prod.outlook.com
 (2603:10a6:20b:5d8:cafe::44) by AS4PR10CA0024.outlook.office365.com
 (2603:10a6:20b:5d8::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.11 via Frontend Transport; Fri,
 5 Dec 2025 09:05:13 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 AMS1EPF0000003F.mail.protection.outlook.com (10.167.16.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Fri, 5 Dec 2025 09:05:13 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 5 Dec
 2025 10:05:53 +0100
Received: from localhost (10.252.31.202) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 5 Dec
 2025 10:05:12 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Fri, 5 Dec 2025 10:04:58 +0100
Subject: [PATCH 8/8] spi: stm32-qspi: Simplify SMIE interrupt test
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251205-upstream_qspi_ospi_updates-v1-8-7e6c8b9f5141@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: AMS1EPF0000003F:EE_|AS8PR10MB7087:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ec59b93-9f9e-49fd-198a-08de33dd6668
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TTE2QW5hR0N2Rk9Zb2QveVo2Q2huTmNybVJ6N2duZnpHSkt2dWd2cENDTUZv?=
 =?utf-8?B?ejBST3FxWmJycUhQZHJsbFErek5uUk5PMmpwV3RCbnhjZ0RWc3JnMmw3RXZE?=
 =?utf-8?B?aXc5RzVPSjN3bzNqcjVPN3B3VDYyL2d4WjI2YXBEbjhXOHVlcHo1RktYSHZ6?=
 =?utf-8?B?S2NGRDV4MTA2QWJGYWZCNk1TOE1yMWV5TXpaT3N3OTZyWkcwdzJ4Wk5MY2s5?=
 =?utf-8?B?V0Jrd01DWWE4UllHSUdCY1NoTjRPNHhNWWxxblcxUEF2dFFsNnhMQ05CQ01J?=
 =?utf-8?B?YVJlYnpwMXZCVFZnRFRqcHo2NHBkRTB1T01pVEFyU0VOY0NtaS9mU0ZDckFp?=
 =?utf-8?B?NnJHdVgvWWdKK29TNk4rU29lREx4V0xxWDNyZGtja09JS052ZWNEbHF1bUZF?=
 =?utf-8?B?cHo0NjF3aWtDU0h2Q0lzVzhheXM3TzQyVjFMRWlxUFV1SnlhYUNPMEViYnB4?=
 =?utf-8?B?ZTdKQ1lSdjgxMURtUXRFSlpOb2lxN2dTaTFpMmhsS1ZESnhwYnRHZE1aTGp6?=
 =?utf-8?B?eThubDRtdFVkcVphdmRIelpncTA2aVQ3bkN0aldYZ3F4Ty8xOVBTTGpqMlBO?=
 =?utf-8?B?bG9zMXgvQjJrWCtJSWM2VXFLTlFKQXMrQjYxZUtpd0VKMG9tcGpoR0V3eitG?=
 =?utf-8?B?bXoxUFJEeG51ZXMzLzU2NU8wU09SU3IvOWcycG5Md0I1R3JqWXF4YlRVYzJ5?=
 =?utf-8?B?ZjZQb1lZMU9Rb2hrOUxSWHN3bGZmcUdjVndHS2pSRWxVYWJ0OEwyOXVoNVZL?=
 =?utf-8?B?eVJVcjNkV2dGQ2x5a3dBRkh6allCU2N6U2ZhWGErczBHbXdERW1WMXBVcWdE?=
 =?utf-8?B?ZnZLOG94K01UUUZoUm0zZHNGS3g4V3A2eG9LRlhVcWFXZXA0YjdBUWd0TnF4?=
 =?utf-8?B?S0xabHVjNmpsd2lSWFhENTZ6eXFCSjdVOVU1aTZuQ3NVMCs1UW94VWMzbWRY?=
 =?utf-8?B?czlxUmNiVnFRYUpUM1kvQ3Q4NGdsdTF0N2U2UWc2cElvU3BqaVBJakM5WjBu?=
 =?utf-8?B?OTRmVHdLS29LeVAxbndiWi8zalMxVDQxblpIOTFja1VncFRtMDAxS0ZZZ2sv?=
 =?utf-8?B?NU9Eb1hsRUdjemxSc2Rqdmo2V1FHRmhycUtJTDhGeElXeklsdzU5RGFFZXB3?=
 =?utf-8?B?clplRXJvUUlKTVlrQXhCcHJndm9ReXZ1MndnM1B2Yk9WbGp6Y0JIUGhZV1VZ?=
 =?utf-8?B?ZXRhcm9XZmpObGo1Sm1XSkJuMFZvZzZYVW16VFl0RjJUaDVYcFJWeG9pNnhT?=
 =?utf-8?B?UXYva2EwWGNKUUdtdUtybmo4TFpKM3ZVTksrTmhkUzd1K3BDR2EzcnJuUW9X?=
 =?utf-8?B?blpPMEthemd3K1kweTBxMzByZDJ5aSthcU1PcExxZUtDck5YbmNHcU0rK29i?=
 =?utf-8?B?ems0b1ZaNTdxRUtSbnBJdXUwOU11R2RpQUx5anQvQU80cEcvTUxpTW96REY4?=
 =?utf-8?B?Q1d4L25RL3pVbm0yNlBWTElRUVJsNDRueUc1a1lJZytqSzk2SU90Vkp2eTJp?=
 =?utf-8?B?VUFFbWNyenc0Wm5OTXZkNmExVFY4ZzhCTVlDOGZ3aEhnNGMxVnp4ZWlTTHM4?=
 =?utf-8?B?Y2lsM2tBcnk4M3lrdEJQWndLK3FMQ1RJaWVCRFdZWGRxRlhpemlxbW1ndkFC?=
 =?utf-8?B?WjFsaEI2QU9MYnhzaG1ZNmNidTNUTnVFcDhpcGN3aWZxdmVoMXZFL2JOcWg5?=
 =?utf-8?B?WWxGeGhuSWFHVkZuYVlTU0lUalpKUm0rSXM2YnJ5ZlNPNmxGZi9sSS9yN1NP?=
 =?utf-8?B?U2tLTjV6QXE3WC82eWlYdHNLbjBMYzhOY0JLL0NqbGE4Rm1hMnAwVlR3bzZw?=
 =?utf-8?B?cERVTHVFdUdFNUNxdHA2N3RoQWdKemMwZzlMOFI4OHRTWG5rcDU4MjlkbGYv?=
 =?utf-8?B?NkhvQ01JOGNRWEpnamZiWDliNlhwc2p2KythN1ZINk80ODBwaXN3NFg3N3BK?=
 =?utf-8?B?VkhtVGNJZ1dXc29ORnJNU2dzY1RGU3JsRG51N2VuYXROWW5McHhXVnY5eTZB?=
 =?utf-8?B?d1Q2UnF6VndBYXRkVFJ1dk02U0VOQ1hTcjUwbDF4OWdib3c5UUphUG92bm9o?=
 =?utf-8?B?VUxyNzdNcDdEblJ3aUFkZnlxSUF4WkdGaDhNWHRtekluYUc3Vm1MQjRudHdh?=
 =?utf-8?Q?nddM=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 09:05:13.1246
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ec59b93-9f9e-49fd-198a-08de33dd6668
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF0000003F.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7087
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA1MDA2NCBTYWx0ZWRfXwuC1DKXyVu46
 pyA8yDY5H92Fvsx2MwXFKNqi5DvX4uiewfnY+JGd8DAeaQRwTo/weCip/Ep55r6blPja5fQxcXN
 evQsSRe0K0B8HnBYAxSGewsfvtrudFYW4Gzxkql2GGMNoL16UsU+WhAbEQycA+12zwyATyfl//a
 Mrdz/eN7F35ASCFpxAVe8yH+qdVVnw3/V8h+BC7ZRaqyOcU7cw9QcOg/ayUhxLn9E21CAj5D5RB
 3GL1yMdkSoUFXjAE3WGSvJvapRMY0iUSwgnuvU3rUL+2P8lO/2RpxbGOMK9hv0HG+n2bg6nOwCj
 Ue6xxnvPADUCR0x06Ano9UCNEl5xDaPWcBMeYQJNRiV0BN4M+hzRAhda4iNnOYPRwJc5pFQP3yv
 WuriOJPlWIIoS9dNhuxHOoV4UP+UKg==
X-Proofpoint-GUID: TqeSy2WlAzOjxvEJhP9sKZE8iv9uPtSg
X-Authority-Analysis: v=2.4 cv=X99f6WTe c=1 sm=1 tr=0 ts=6932a04a cx=c_pps
 a=0tZRaOFwq0BxzmvfxNdFUA==:117 a=d6reE3nDawwanmLcZTMRXA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=Uo5EeBN78AAA:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8b9GpE9nAAAA:8 a=F6HTmrlUwN8psNLP8S8A:9
 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22
X-Proofpoint-ORIG-GUID: TqeSy2WlAzOjxvEJhP9sKZE8iv9uPtSg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-05_03,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 clxscore=1015 bulkscore=0
 spamscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512050064

SR_SMF status bit can only be set if CR_SMIE was previously set,
keep status bit check only.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 drivers/spi/spi-stm32-qspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-stm32-qspi.c b/drivers/spi/spi-stm32-qspi.c
index d6f6f9d4e5be..2a0ee96786fa 100644
--- a/drivers/spi/spi-stm32-qspi.c
+++ b/drivers/spi/spi-stm32-qspi.c
@@ -132,7 +132,7 @@ static irqreturn_t stm32_qspi_irq(int irq, void *dev_id)
 	cr = readl_relaxed(qspi->io_base + QSPI_CR);
 	sr = readl_relaxed(qspi->io_base + QSPI_SR);
 
-	if (cr & CR_SMIE && sr & SR_SMF) {
+	if (sr & SR_SMF) {
 		/* disable irq */
 		cr &= ~CR_SMIE;
 		writel_relaxed(cr, qspi->io_base + QSPI_CR);

-- 
2.43.0


