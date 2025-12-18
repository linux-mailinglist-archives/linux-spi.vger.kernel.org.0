Return-Path: <linux-spi+bounces-12015-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC5CCCB7FE
	for <lists+linux-spi@lfdr.de>; Thu, 18 Dec 2025 11:53:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA3D3305EC1C
	for <lists+linux-spi@lfdr.de>; Thu, 18 Dec 2025 10:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF84314A9F;
	Thu, 18 Dec 2025 10:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="OjLMMmtK"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5162F9D82;
	Thu, 18 Dec 2025 10:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.182.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766054940; cv=fail; b=GSgislSYN5GQ5acUaZ6b27uT6mnMaaNnFyEn4hLfogHd9a/BfnQ7a3a/OoUPy71h9zC3nXweSxqWQHJNQCLpd5vex0g7McEsGdIuWL2in4tYwN651xWH3IP5B7y8QMXDe/tt0ZtbTqQUo2Eofse7A9fuDxy3epPYQw/ZXyyzaD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766054940; c=relaxed/simple;
	bh=f0x7DPkGqNpzo1WmRkb3Nb2KyjN2FRNIE/+ER7PnMtU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=AGcrTz8ePGOVTcDSoPrPFNWVAFi9QxvqTMIBYczrMn8klczhHRs4FDyNEO4GY1i/lLSGXfaoJkY2+mlxaqnGYicGpLjCFWTL/syBd6K0/3MJlV8T1U1Wof3lOZnsDBLb8jJbFqsRjJUK7rJANdSohABsg94Pq24R0zc2zJe+gjA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=OjLMMmtK; arc=fail smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BIAifY42126923;
	Thu, 18 Dec 2025 11:48:49 +0100
Received: from du2pr03cu002.outbound.protection.outlook.com (mail-northeuropeazon11011023.outbound.protection.outlook.com [52.101.65.23])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4b3xb73yek-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 18 Dec 2025 11:48:49 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qnEGfvtkvQyuehZudOUYOryAH+KuvAJw/tNcb2HJoCLr3wclPfe47XmfGGYNSny7Ooy2VxIK09OIIm2xvlGpROyjacWqsbw9zxNcbo78mqN+6MUprYblx8L/dag7chJjihdL0SJDqAoVEc+K2rt5LKp85MMfQxuzAVMuV/E+Q9dJBI1PUwcZ890zg7C147RFTx22YWLVNmYWNdd/eb596XJKzmycsZiVi2gT7s7wsdRM7M7xooOtA/7DE7Y3yA5c8b7ark3m86YWs9xUQDYTzu3276Ac4WFVwwSk1XKBKkV8o3ta4k+huvUALkbXSJV4qE9aWHCTnBc3RGP1HTHlAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WUq+Jfo0QzEfu1gER0lMLAuxZqEBLqiZE3Uf9sWGhQo=;
 b=QimQSyi0sjm3NoMrayhKI0P8ajdPN5SV3oQOC3VmXekrSAzdcGYI4XHKtKxsEjt8NCizlEL85fPnL5+wtCJvqcPxYSzRnPeGkLDlxxW7x3+MNNKrd1GrYWBN4h0eilxyktp1z36uCHYkqFFrhL5Jtn4TvYePYvjcH1h3xlsKo4F3KDbSR1f1kX49sV+k98jKva6i1Zd6Ue1mDzX/Se3SbVO7qXooi2QGXwkrKlR2TorTeyXVjt8kR+TjQ6W9+1il9Y4Z6usGxXoVM48NJVca6VFrnuWhgHRsYNJRSHtZIOb/qRMrfrYeR5PPG6GkBrbd1AnwWWgv0sXnPR/e+uKkRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=gmail.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WUq+Jfo0QzEfu1gER0lMLAuxZqEBLqiZE3Uf9sWGhQo=;
 b=OjLMMmtKgKhRZfXBX/g3p0tlI00MVxlbiAc1M+q+U+f5xPzUU73K7eJ3eH1kzqwWcOXHjC/IylYCbQEAdI1iZ54Pwy5OmVvVqZpxzdncL+zWWhpM90E4O0NmkEmoaKQoJCf3+/D4NRLPAsJVKeXCdQyBVKcLa4+YxJpSidd/dYlcnBX/dXUusdEpIGuLws3fTC1XQybLtduVCZsZ/wfEpAJwf26PAUXMtFPRTdJLEjv09Do+G/3+HBHjzi9ZTJkbhJCy4qXLX9uI/DOTWpP4bR6tx1fKeDzB3sVzGOK/w9jhjwSw9T/9koAFRNJ11KVHa6I4fxFFkEewMjIrPcp3eA==
Received: from DB8P191CA0023.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:130::33)
 by AS2PR10MB7021.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:59b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Thu, 18 Dec
 2025 10:48:44 +0000
Received: from DB1PEPF000509F7.eurprd02.prod.outlook.com
 (2603:10a6:10:130:cafe::e0) by DB8P191CA0023.outlook.office365.com
 (2603:10a6:10:130::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.13 via Frontend Transport; Thu,
 18 Dec 2025 10:48:44 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DB1PEPF000509F7.mail.protection.outlook.com (10.167.242.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Thu, 18 Dec 2025 10:48:44 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 18 Dec
 2025 11:49:32 +0100
Received: from localhost (10.252.25.7) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 18 Dec
 2025 11:48:43 +0100
From: Alain Volmat <alain.volmat@foss.st.com>
Date: Thu, 18 Dec 2025 11:48:27 +0100
Subject: [PATCH v2 1/4] spi: stm32: properly fail on dma_request_chan error
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251218-stm32-spi-enhancements-v2-1-3b69901ca9fe@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F7:EE_|AS2PR10MB7021:EE_
X-MS-Office365-Filtering-Correlation-Id: d687aed2-846a-408c-df4e-08de3e2303ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T1pFWTNxUTVlamJEL1Bzb3lLYXZmZkFiNWZ6OTR0MXJKblRLV2pueDZSenBu?=
 =?utf-8?B?OWFwWitxaHRNaFY4Ymk0WDV4NFUybjZGdm1Qc0ErQWVwSVVVb0lSd2E2TWtJ?=
 =?utf-8?B?OHo2RUNxek1qcGpXTllINVRBd29CTEcvOE9mMzFodnBTeHNXM3JlckRud2kz?=
 =?utf-8?B?OGZUMk5YLzN5clAxcGNtZ2dKYXJjcndPbjJ1dFpkVHVNT2hWaHllRUJmU0N1?=
 =?utf-8?B?TnVqTXBuM2tCalJJVnJSd1BOQlA1cEdscGdYVW40MVF5clVPbCtIR1pRWDVN?=
 =?utf-8?B?RStEQ0xLSE05V09Iam9oWXZpUUdQd0RsNVBmbEhFVTJqRHJiMzZRbEU4VW9D?=
 =?utf-8?B?Q1NTTU9NS0NjWGszMWRjK3g0SWhUQXF5cU5NdGNvOGVpNm9lT1FSU3lzSVhL?=
 =?utf-8?B?czZLWlBRN25yUmdnNXZ2eVlOQTdmMUFjNnQ5cEdybTI4NEFCakdwdlRPLy9t?=
 =?utf-8?B?dHEwVTJSRzVCcE0zblNlVWZHYVc2OU5DTEpPOXNrUmxVZkhWQTU4L09SS011?=
 =?utf-8?B?OXliejkxVU1MTFE3UDNrVmgwb1Z5eGxwNFZoN0JRU25Ybk02WVo4TGQ4N28v?=
 =?utf-8?B?UWswYW9zenNXWkRFeXZySUUrV3ZqaXNYaTlYS3ZRK0FuMlFhQTZUR0x6QTV5?=
 =?utf-8?B?RXJTZHpwVU1tQlZKa3h4QkpqeHVBUHpJaHhINkxHTUErVVN4cnF5S1RhYmNJ?=
 =?utf-8?B?VDVtMnk3SE5wL1d3QU1xSGl4TEZVVS90NFlkTHFldGdwdzd3Y0JucXJsQTJw?=
 =?utf-8?B?ZkhTVEgycXlrenQxNldnNkNzdm40RDJmZk9IRzJ0b285OGRONHhEd3VheFlo?=
 =?utf-8?B?QStES3V4am5rNEc2QWFMWlRidVhhQmg1NnRwQ0dVTWU3Z0doYjdURVVNUHRp?=
 =?utf-8?B?K054dHR0WWdlQzVoZ2RBK01iR1NqSUNXZDg5Nm15K0sxYzJyblk1Y3J4dGY0?=
 =?utf-8?B?eXhQVWd4Q2YxTUtzQWFoUU1XSkFSdFBTdWpjc1doNmgrbDZWTkgycG1Rak1D?=
 =?utf-8?B?WXB0TldNbUgzeW9WUnNQVUgxSFJ1NlVVbUtpMVR6YVMwa0RyVUtTb1h2U3dp?=
 =?utf-8?B?RysybUpLUjNnY3Fia2RISHd6L2ZmcWtuZ3FhNStiempTT3loUlFpcnI0aW1W?=
 =?utf-8?B?czhlby9mRnV5TzJTN0RWNkpnam5QdURqVjlZQkMrOEE4emx6L011djhWUXdF?=
 =?utf-8?B?QkR5alkvNWpFVUtKN0U1c09QR2kwV00vUXBzYmJjV0tndkswVVhYZERveWJW?=
 =?utf-8?B?QU05SmN4WUJXZmdzRjZ5eE53WDFjTXljeFpHMFFkVFFqZG4rV1ZqV2FFQ2VU?=
 =?utf-8?B?bWp1NHpqVmh3Q0JJY1ZZMXdQTGpjSXppamk4UmJRSTltbkV0QlhCUkUydHh2?=
 =?utf-8?B?cmRCeDRpTVBvVW1Mdk1YTTVTVVFVQlJpdEZtc2tmWE1rcTV5bDJZUnYxaG41?=
 =?utf-8?B?SXQ2V3FyYXQ0VWhNbS96dUYxRFZGRy92MDV4c2lxWGJCZGRJYlZoNnNSbVRO?=
 =?utf-8?B?cTdjNGhqazdIUURJcWRMdTRBcXcrTTVXRlFNOFJPNFU0RDdKdU1DZ212akQx?=
 =?utf-8?B?SThTZndML1poQ2hMUVF1L3NaQkk2NlYzTFozQWNFNjNFRytxM1lMV0NSUlZC?=
 =?utf-8?B?dVlXeFVybGhYMWJEOGxKaXVZRGxLei95bmtRWmZUemFFWEJXbjdVQXViOGdH?=
 =?utf-8?B?SGFuWURFZURDRUIySEd1S3djMmJiUi9NTG5nTjAxYUN0MU5yL0VOTkRvSmJs?=
 =?utf-8?B?dXI4ZTVsS1FvOFhOU2V4UHhOMUhzWGF2NkNCRmNuNE8rSVViMk4zVmVPQ212?=
 =?utf-8?B?YW1hdWlUaUhSNnBHc1VzUEk5eVU3b2poWHNqbjY3aWR3eFdxdFM4a3V6TXVq?=
 =?utf-8?B?d3hrTVRwcDV4L1JmVkcwMkVDK0NQR1AvZnFyVzFEQUVKbkxKUU14SzlvVGNK?=
 =?utf-8?B?YmcrUHAwS2pXZmh2NmFLWGFyS1FtcFRtaFM2SVhuaXFTWTVQeUExUmVGV2wz?=
 =?utf-8?B?RUs2ME9ndGZzU1IxM2I2c0JYZ3J2Zm9haDcyRkhWTnQ1dHNVUFR2cXp2dS9V?=
 =?utf-8?B?K1lpMW9uVkV6elFBeUFmcnhIeUQwaUxmM1dJanJEelZIR0UycS8xQXlNZEp3?=
 =?utf-8?Q?uojc=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2025 10:48:44.2957
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d687aed2-846a-408c-df4e-08de3e2303ef
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F7.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7021
X-Proofpoint-GUID: c5mLoDQuMvdipsQRcQ1zjZIPCqSw0I34
X-Proofpoint-ORIG-GUID: c5mLoDQuMvdipsQRcQ1zjZIPCqSw0I34
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE4MDA4OCBTYWx0ZWRfX53Ph3XqOoab6
 oVIh+yJMIiZI43WcZeWGQ+eR6kUsK5w4qcoqe3xGlTu5aBQc8ayKfHtsMCLjasrOCXBslgq0U2R
 x/swVMQwjH48tEMScoE7aLwtH6Pr1YcmzUl5Sqw7mKESdQO8K4wUsrbhTBHK94ADSbyovIssq2p
 f5eNYhkgCasG2A2jvsj0DK8WQWTV1LLiS61JrK55d45ocU6yoOdu5spT3jNGBAp8xcBCbNil7tG
 ja9lm9XRK03xt0wNVo/DgIcp++Y14m7N8uMSzD4nfSCbMS8n8kDqc9EZV4LdetU+cKUQUTajzNu
 bVAjqrY4CcbszOge2SZLm1eVzSW7Mpp4P2cTz6Gqs0iLNWYlX6cMyRKEkgzXrkVz71/xzlJVKGm
 EOW0VcY6wSfaTNJFFGOjLKN7s0M5ZQ==
X-Authority-Analysis: v=2.4 cv=NZfrFmD4 c=1 sm=1 tr=0 ts=6943dc11 cx=c_pps
 a=GWnjdLoi7hWW8E7zIUJB4w==:117 a=d6reE3nDawwanmLcZTMRXA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=HjypFGx7bZcA:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8b9GpE9nAAAA:8 a=-H3e6ytJN_w0sB34kfkA:9
 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-18_01,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 bulkscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1015 spamscore=0 phishscore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2510240001 definitions=main-2512180088

Correct handling of the dma_request_chan call in order to avoid
misleading warn message if no DMA is provided within the device-tree
and moreover fail if dma_request_chan has returned a valid error.

Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
---
 drivers/spi/spi-stm32.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index 2c804c1aef98..40651b6050f6 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -2406,11 +2406,13 @@ static int stm32_spi_probe(struct platform_device *pdev)
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
@@ -2418,11 +2420,13 @@ static int stm32_spi_probe(struct platform_device *pdev)
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


