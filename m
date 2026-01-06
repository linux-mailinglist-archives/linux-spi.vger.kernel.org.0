Return-Path: <linux-spi+bounces-12185-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 89395CF848B
	for <lists+linux-spi@lfdr.de>; Tue, 06 Jan 2026 13:21:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9472D30486AE
	for <lists+linux-spi@lfdr.de>; Tue,  6 Jan 2026 12:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E6C3314D1;
	Tue,  6 Jan 2026 12:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="WGn1FW/r"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5593314A1;
	Tue,  6 Jan 2026 12:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.182.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767701707; cv=fail; b=mAPQFd/8D1gZBkqtji1PhBldzlLGzQ/BzpBcBTvbcIkyDXfs1bsiOZBMPdOdXbwNv2H5N7oophM1FhbjF9DQA1uMbXdNgYao13zGD2PBU2SdEJtpVgV7Bizy8N+0UJuvM0mfb4RXqs+HxdZD146KSOxDt0j5EH0SkCKHIUTlbK8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767701707; c=relaxed/simple;
	bh=zjKkMayL8REqMaGzJ54IX7YohTbTVffhH58uE3Q1zUA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Qon1RMqIrk6wVToCQ+cmhZkV+dEmOqYlQKiXVVHcl08HGzDLsfx/y9lPZUjlHcnvb2z2gwM3h5RACz16Ba1AuKWFDYCRVJNFslYIgmyDnLO5B7cZH+Hw+rLwkdo1S3sO5kwfNqOWtjO1NshfeRYn1dLzGz1QLNm+11nAgdXSl40=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=WGn1FW/r; arc=fail smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 606C1NMj4151963;
	Tue, 6 Jan 2026 13:14:55 +0100
Received: from am0pr02cu008.outbound.protection.outlook.com (mail-westeuropeazon11013029.outbound.protection.outlook.com [52.101.72.29])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4bfdj5fjfk-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 06 Jan 2026 13:14:55 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YeP/HIuO0+Bt7RXUFpi2xpn2E3AkUtKw51Nm0tCT++qqYdSnkTj5iw/qOLrcTCyqhhV898aqwPzhKl/X6mTz6wMDMdZcX5Xp1aIKYyU66d3zP+vugb9op9bPJhpS3uyUps7xfmno2RaxXJ6tI7cXyR6ijA/fYyWvmN6cjlAMoWVtnOVHLKa9F6v7vj9QQkqxEiDFQQAQBC5KCtxGwAQzO+gqqwr8+LWjuuo6HBH8jhYyiFh3uGYpqjPMuxjuRIehM2QoGSbhat+DMKuWdrj5XuMF9EhtXbZZb1TGBmjp+uRcMoDiCjl/4VsmTu0BfZzOJMOeE9B1EYDtVr6fknMQuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kw6NvRB5jjzzBXCF1clqFiUoayd9qIS0WlpWmPPnldo=;
 b=mPhBjzTXmwBbgw+RNdL/Swj6qfmZ+3ZjoE7OWvONQDVgOu2TETi15di2gF5IBQR4pv8Lv9Gqi3myckgJWwQFhpJn0Hh3zn7L7lWlvOA5wLkWhCIWLrtRHNePJNLaCF0vD4kjUKg06D+xLDnAp7hjU2i+iBDyTBSXLMO+wNpYYUZ93hgyZG+F64hd6MCJzT9+1dYpcwBQAbKUzZFO6uyxNP4hbRnwL5rokao1anupPYxW/D9MQpnOtIbqdCodNq79R0SYbQTh8xSJtPSUZj+w4QxmnvQev40Uw2/R0ORP2DZha8/MFeWiFf9OTQPXzjXTDBilzAtbPk42coDixHHLIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kw6NvRB5jjzzBXCF1clqFiUoayd9qIS0WlpWmPPnldo=;
 b=WGn1FW/rn12q4/K9l4J5QVxiAa0aoxmsbI1v+CGMCHCXCxrWzt4EqyHNhRKY9+dmJA9AChWShaa1W/K7TPdcxSuPM4uptesQjqGdiZE/AxleXhuXYhcRxpSG3LsMxSOS0YQERHit7l6Rcp23572u+xtHG4CT81XFHcHpugTEqewORs0wLJAGXxrZhPkWkoqm12hooT+9Xnm5NByWxIJazbmTeU5713nNc2cgyGK4R/zVDMlwFOHJfe58Pb6szaTsN29LleDbgQmbjS2EgUzzqNyQhNGMOUpv2wPjDUrjag4mJz4DHuY3nlrz15re66jkTwcSp5FzJJ+d8NMdvw3NzQ==
Received: from DB9PR01CA0022.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::27) by AS4PR10MB5418.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:4bc::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Tue, 6 Jan
 2026 12:14:51 +0000
Received: from DU6PEPF0000A7DD.eurprd02.prod.outlook.com
 (2603:10a6:10:1d8:cafe::7c) by DB9PR01CA0022.outlook.office365.com
 (2603:10a6:10:1d8::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4 via Frontend Transport; Tue, 6
 Jan 2026 12:14:25 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DU6PEPF0000A7DD.mail.protection.outlook.com (10.167.8.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Tue, 6 Jan 2026 12:14:51 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 6 Jan
 2026 13:16:06 +0100
Received: from localhost (10.130.74.193) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 6 Jan
 2026 13:14:50 +0100
From: Alain Volmat <alain.volmat@foss.st.com>
Date: Tue, 6 Jan 2026 13:14:20 +0100
Subject: [PATCH 4/4] drivers: spi: stm32: avoid __maybe_unused and use
 pm_ptr
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260106-spi_st_maybe_unused_removal-v1-4-8f5ca7136e96@foss.st.com>
References: <20260106-spi_st_maybe_unused_removal-v1-0-8f5ca7136e96@foss.st.com>
In-Reply-To: <20260106-spi_st_maybe_unused_removal-v1-0-8f5ca7136e96@foss.st.com>
To: Mark Brown <broonie@kernel.org>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Alain Volmat
	<alain.volmat@foss.st.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000A7DD:EE_|AS4PR10MB5418:EE_
X-MS-Office365-Filtering-Correlation-Id: 20bd8fd0-e19a-4827-e6b6-08de4d1d31be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Sjh2NlNscmx3T1pCRHRxdVdXL0RyQjNxL2tBM3NhNzZWcFhhSE9LclJSbUEv?=
 =?utf-8?B?WlhPQ0JUMU14Q0hXSkZGUE5PWHF0ZUlvanZsSi9QM2pNZHVSTWd2SkU3bThV?=
 =?utf-8?B?eVY5Vk0yenVVZmNaNS9KaFV2eGIxWlBESnZIVEp3ampsZ1BvOTI0YzlvdzlW?=
 =?utf-8?B?NFJhSUw0b0ViTU9VNGk1OTlmK0FZRWxJTlRxOU90OXFkeXdlWFA3TnZlT2Jv?=
 =?utf-8?B?MzZGVkVYOUFwU1FWOEhCNUQ2aTlwU0FsY0NZdWw4elBIbHZsd1ltaXYvQXBj?=
 =?utf-8?B?bzBpWnJrbmtNNzlkSWxDS2IvOWMrdFhYUmgvWnU1d3orQmNIYnZjVTVLTlBo?=
 =?utf-8?B?MmNMejJwRzdCVHlvSWtZTUpFZ1Yvb1N4YVdpa25zY3BHMUdzUjVjaFVPWTBD?=
 =?utf-8?B?YVFDU2syVkZObHZCMzNGWEpTOEZFOGRFNzZnaVQveGp4SlBPbXVSWHNPLzFp?=
 =?utf-8?B?YkI1OVhoa0loUkl4NmhmeFVCcEtqOWxEbmd0UGd1dXp6ZmRiYmlrYk9LZG9r?=
 =?utf-8?B?MFYzQzZWV2Q5aXZWRUoyUUpIR1Rza2NEUEp4KzI2NzdmcnVMT1VBV3JYaDlX?=
 =?utf-8?B?YTFaTm5MWndDMFNNZExEbnFFVHZDa1ZZY1FNU0NiSVNDNDJPQTYxak14N2sw?=
 =?utf-8?B?ZWhwbXFRNXNkb1Fkb1dwaUJITTRyeUkxVkhFQ1EvMjVjdjJSYzZsMWdLYkM0?=
 =?utf-8?B?U2EyNHNJSk5pNHUzanBBQ1lPS2I5YnppQjZ4cTAvYVRIeUJISW5vdXZKTEM4?=
 =?utf-8?B?dlBYTnY1WXdmSmh1eVlvYlhqRU81VlJ1b2hXK1E1b1haN0VzQnFNeVhFM3lS?=
 =?utf-8?B?dVYvQlJyOHZMaTFPRUJVclVqNis1Q2ZuKzVKOEUvdGp4OVFlL01QYytHYXdY?=
 =?utf-8?B?c01iM0NmSTVhVVNqQ0pROE45QmhhMndXNTRWS1NkK2paT1d5L3ZIWjR0WitG?=
 =?utf-8?B?Z01BcnB1UTVJdGp1MkNvSk1jU0IrcTl2cWMvMnRnRWVuOTZNOHFSdkRlZ21P?=
 =?utf-8?B?Zk43cUJDRGoxNDBEa3ZLeVdQWHJMdWxTYlltdmdQcEE4ZFE4YithS0hidXJ6?=
 =?utf-8?B?THB5KzBSM2F2OUFKbGE2a1NGYlJrU2tEdnJ2cU00UmtZQVl4alRjVmV1dnFv?=
 =?utf-8?B?bzN5TVQwZ0tmZXVDeFg4dWhJQ1NIMjhyQ2NQMHkydHZqbW1CUmRCcDBWTGdU?=
 =?utf-8?B?Ukk1ZDdhWjdPQWN0MWR3QjM2V1lzN0l2ZTZxM05vWldFR0gyeEM4c09Tbk9K?=
 =?utf-8?B?UTZiVGg0bXJVWGxuaDNKeUNVM2pTV3VXU1JneDJzUFU4emppblVrQXAwMVY0?=
 =?utf-8?B?VzBVdGZidU9BbGtZWWladWk1d1hjVGgxM1d2MWtiYlZxN0xWeDU4Z21FQ0F6?=
 =?utf-8?B?Zi9IbUlyMk1TcElZM2pPWG5QcTRsVnNqU3VEUHE2WmVsQTl2ZkIvcFFSSU1X?=
 =?utf-8?B?K3pJQkJjM2lDT05WRFFSVjlZQkh5WkpyelB2bCsvZmlERUhhUm9GOXlGUnlS?=
 =?utf-8?B?cHY1YnEwVFlSdHBtSG9KQ3lrNllpc1FQNXI0N1RacmgyRmxJZmttbWNYQTNS?=
 =?utf-8?B?Q1FMWTUxR2hDWnA3SlpwNy8rL0I1cmVSSnVEYk05dGh3YkJRS2kvdjB2RmRw?=
 =?utf-8?B?dTlNb3lJd2xnU1pwaS9IRWVDYUNFM3pya0luekd4eDVTeUN5Snpqei9NRXg5?=
 =?utf-8?B?TjdRQm1JWGxmWU9XaHg5bDhoNG9WYjZYMWdBOTllOFlsZFhNY01NMzdZNFNj?=
 =?utf-8?B?ZkIwMjRqcTdkT0hwSm92NGdiaTVreW1XWFAyc2h5V0c0Snh6MmxQcFByMTRS?=
 =?utf-8?B?VnRWaDhlTnpBVTl6MGYrWlJqRHV2THgxYXNZc085R21peU14REpFZllDNTFs?=
 =?utf-8?B?SlhQQUpzSTV0NUdLL2FiMTlncVNuNm1jWEZaM3Z1aUszaWhwVjhpTlVrUmt0?=
 =?utf-8?B?aFZ6YStma2JEWEhtYWkxRkRuK2I2dW13SlRGM3UwS3BEL2tWWnJQcFQ2Y1M4?=
 =?utf-8?B?bkNKaVQ2M2tOZTA2MGxtVEVKVERZMlhLeUJPODNHMXYvQmpTc0hVUEltWTNk?=
 =?utf-8?B?QzdsdGVYSGRDZlFxTHgxQ2wzb0g4RDJlelphSGNqNlpKelVIbXY0WHNsSXVr?=
 =?utf-8?Q?5UNs=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 12:14:51.5973
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20bd8fd0-e19a-4827-e6b6-08de4d1d31be
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000A7DD.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5418
X-Proofpoint-ORIG-GUID: 5xsDi5dT7DvX1NaDMzqnW2h2l6fzXo9Q
X-Proofpoint-GUID: 5xsDi5dT7DvX1NaDMzqnW2h2l6fzXo9Q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDEwNiBTYWx0ZWRfX+IsF8/5ME2DB
 ohTqfqpyXECbe2yj+NFBfnPiJpVTN38z9V1QVG//L6V4LB7ZZpOE9yiobwovfAQr0zoBvK1zWm3
 2xzO8i8rkjaVuAQ4G2XGnpMjKQYVXcgyAeHdNgy1/h+x6qRgVBv8zc6Oh31QOY2iaks7PBOJyvd
 ebYfe8J/ZJqbd0+RALeF7k6TqAYarisEA8r/jRrHY3dOKrIJriyBeUabPZYECg4SalSBNKeaaVx
 HO5WDkskAGNjDOlcBiQnut3XXnspHgHn37ZU0wvAPVZeB2amyRP4hpgBjLNuap8EZzf4wN311ak
 YsuI+Iin/1/ZpLQWRySXenMNrpG/IM46pHwtVL41ILR2cFrnuetfbm6RhOnznBOlAQs27nRgFFX
 qtaNFq45iICCuLDblyY4JChSu6W8t7wKrGPCFgdQg3PrmiwFBerbmPwxEO4GEw6RHNOFYAvTKNB
 ULMaBgLTr7jWZAYLeCg==
X-Authority-Analysis: v=2.4 cv=SMBPlevH c=1 sm=1 tr=0 ts=695cfcbf cx=c_pps
 a=JuLilwxa4atMZRuDtqj8ZQ==:117 a=d6reE3nDawwanmLcZTMRXA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=wL9PcE0S0AMA:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8b9GpE9nAAAA:8 a=7wyQpQe0EkofVtEA0L4A:9
 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-06_01,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 malwarescore=0 spamscore=0 priorityscore=1501 bulkscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601060106

Switch to usage of pm_ptr / SYSTEM_SLEEP_PM_OPS / RUNTIME_PM_OPS
in order to avoid having to mark the pm related functions as
__maybe_unused.

Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
---
 drivers/spi/spi-stm32.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index 8f8968383ad0..5c1e685a65d9 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -2614,7 +2614,7 @@ static void stm32_spi_remove(struct platform_device *pdev)
 	pinctrl_pm_select_sleep_state(&pdev->dev);
 }
 
-static int __maybe_unused stm32_spi_runtime_suspend(struct device *dev)
+static int stm32_spi_runtime_suspend(struct device *dev)
 {
 	struct spi_controller *ctrl = dev_get_drvdata(dev);
 	struct stm32_spi *spi = spi_controller_get_devdata(ctrl);
@@ -2624,7 +2624,7 @@ static int __maybe_unused stm32_spi_runtime_suspend(struct device *dev)
 	return pinctrl_pm_select_sleep_state(dev);
 }
 
-static int __maybe_unused stm32_spi_runtime_resume(struct device *dev)
+static int stm32_spi_runtime_resume(struct device *dev)
 {
 	struct spi_controller *ctrl = dev_get_drvdata(dev);
 	struct stm32_spi *spi = spi_controller_get_devdata(ctrl);
@@ -2637,7 +2637,7 @@ static int __maybe_unused stm32_spi_runtime_resume(struct device *dev)
 	return clk_prepare_enable(spi->clk);
 }
 
-static int __maybe_unused stm32_spi_suspend(struct device *dev)
+static int stm32_spi_suspend(struct device *dev)
 {
 	struct spi_controller *ctrl = dev_get_drvdata(dev);
 	int ret;
@@ -2649,7 +2649,7 @@ static int __maybe_unused stm32_spi_suspend(struct device *dev)
 	return pm_runtime_force_suspend(dev);
 }
 
-static int __maybe_unused stm32_spi_resume(struct device *dev)
+static int stm32_spi_resume(struct device *dev)
 {
 	struct spi_controller *ctrl = dev_get_drvdata(dev);
 	struct stm32_spi *spi = spi_controller_get_devdata(ctrl);
@@ -2679,9 +2679,8 @@ static int __maybe_unused stm32_spi_resume(struct device *dev)
 }
 
 static const struct dev_pm_ops stm32_spi_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(stm32_spi_suspend, stm32_spi_resume)
-	SET_RUNTIME_PM_OPS(stm32_spi_runtime_suspend,
-			   stm32_spi_runtime_resume, NULL)
+	SYSTEM_SLEEP_PM_OPS(stm32_spi_suspend, stm32_spi_resume)
+	RUNTIME_PM_OPS(stm32_spi_runtime_suspend, stm32_spi_runtime_resume, NULL)
 };
 
 static struct platform_driver stm32_spi_driver = {
@@ -2689,7 +2688,7 @@ static struct platform_driver stm32_spi_driver = {
 	.remove = stm32_spi_remove,
 	.driver = {
 		.name = DRIVER_NAME,
-		.pm = &stm32_spi_pm_ops,
+		.pm = pm_ptr(&stm32_spi_pm_ops),
 		.of_match_table = stm32_spi_of_match,
 	},
 };

-- 
2.34.1


