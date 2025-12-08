Return-Path: <linux-spi+bounces-11812-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD5BCAC584
	for <lists+linux-spi@lfdr.de>; Mon, 08 Dec 2025 08:31:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA96C302CF6F
	for <lists+linux-spi@lfdr.de>; Mon,  8 Dec 2025 07:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45D9226CE2F;
	Mon,  8 Dec 2025 07:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="Ym6vjvAH"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5924223373D;
	Mon,  8 Dec 2025 07:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=91.207.212.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765178999; cv=fail; b=oXZjjo+VXaQLhIZWkxhZSRqA5H7bMJ5kEjgn19PJfpi8zWIqVFfAFxYm4zx693Nvy3VRfn2ZdVgCsJJGGD1b1BGJZRRCRgS9wHH9Ar++7H3dxo8rUmodfjcHyRyhYquxbfvndEY7zjjsIXZs3RVHlDuNDU4C6JgZ+lJmUDkFW88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765178999; c=relaxed/simple;
	bh=NlHkUdEyW4V34WpHwzzyCkAxXn11iQRYwRFpB8NVhDs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=m3rjLgHQHY+7q0okmao9JieCLPhk1TLGRc8RO7ZYzlX9b5w+fJD760paoY5qesMHhVbe78ZOKxM0e+2X9n1QrsrapDi5/p8IyA5Qwnumko7VDNuJsh2k6V74vUmoLGcDLDAPFA9Wf3SkvaRerlYtL0z2wXxMiDCSp3jbtI+wnlk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=Ym6vjvAH; arc=fail smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B87MbUR891586;
	Mon, 8 Dec 2025 08:29:26 +0100
Received: from am0pr83cu005.outbound.protection.outlook.com (mail-westeuropeazon11010011.outbound.protection.outlook.com [52.101.69.11])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4aw0aqapnq-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 08 Dec 2025 08:29:26 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sPkxO3DMsydwIGBuopTCUEmn69ygVBrPomazImqsPEMxtIECTwWg8V49LSUxNgyMIJlHymKC32/e2/ukGeH6Lr+KeryGJHGjlSQZeY/RddKpdAQzAO5Vy8hEpza/j/OAgOOWqc8ZN7JgYfHKS+HZL3vBgt5doMNyUTi0vjpY3mtGMpayTprgZ1uNFH2/e2HJqxfohDVSt49uGH1HCTxtWFU58QVb8i7Y9B88Z021TGKIyijh4DLmlyyT6PuvNOUz2ils2DK9cslwPhD+wMKmMCRsf+rokHnWa2cIAyic2kcx7NAHLoBfGPGfF1JZbQQ3RtOeQRzOTvXPRgigjKqo9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m+MOtcmdw7mXYh2wwEOynwkAwFmeDCfRdG8vrF/NyeQ=;
 b=sbAJY8SZ9+k9pYGRdfFOrQitW6VXR1VDbA/BiJXCukl2PUMxX5l9ifTvjudZpF63nGxytJTK23BK8Z5+Bv7TwLMvl8aihPLBphqC6NOCrKd5ms5xbr9e7OHsGzJHg2XpVZrwgxI6DEvynsVn2qM47bXPdjugEr1W/r+jUHiKMOZ/5/O48T9sy2a6IiK1im1lXa6uYF24gV366vgg/w12WfFz36mlWV1Zo5ch+Z1KZa6kNMGhfrQuvGIdRWF0wEHAZ8eM4tOL8iRgP3INdEqANf4UZEyMwsk5mVELh4+Z3BJw/FMc6v1jd8T7vS59Xc2qzAFGz5YLubZdEBXa4g6Ltw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=st-md-mailman.stormreply.com
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m+MOtcmdw7mXYh2wwEOynwkAwFmeDCfRdG8vrF/NyeQ=;
 b=Ym6vjvAHIZXHap3Jwab/ynXMX8n6LP2U1jUuKwYfWYEETgPN8PtfF1z0eJ2oxjA5M/MM5/qMJ3vY79v/3U1KxKVJumXuGlc7fo+6kJ8YOZJtB9hq3ra+/N7XpS/Add4F1zWocVIhGZnr8Xoej49eSOfYN8BijLI+zlCKqyZSkXWhsCwf1ScEnw19+ZPPeZaN8xsnRg74s7jBahNi+kO9qbSpe8cyHCuMPpGt1KFhB8GkHXfw8prnwS8iZseobrcW+y5sCAOk6sxtCZ6wj5lXb12C57vPz19PEkAbImcMCxAzXK2CNuwiHsKULwv+QRGSI6lca/unNQDxPdNECOsDew==
Received: from AM8P190CA0023.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:219::28)
 by DU0PR10MB7360.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:444::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 07:29:24 +0000
Received: from AM3PEPF0000A79C.eurprd04.prod.outlook.com
 (2603:10a6:20b:219:cafe::90) by AM8P190CA0023.outlook.office365.com
 (2603:10a6:20b:219::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.14 via Frontend Transport; Mon,
 8 Dec 2025 07:28:48 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 AM3PEPF0000A79C.mail.protection.outlook.com (10.167.16.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Mon, 8 Dec 2025 07:29:23 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 8 Dec
 2025 08:30:05 +0100
Received: from localhost (10.48.87.93) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 8 Dec
 2025 08:29:22 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Mon, 8 Dec 2025 08:29:11 +0100
Subject: [PATCH v2 4/8] spi: stm32-ospi: Simplify SMIE interrupt test
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251208-upstream_qspi_ospi_updates-v2-4-62526c9467dc@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A79C:EE_|DU0PR10MB7360:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cea5549-0b12-43b7-f989-08de362b82a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ek8xelhqRW9rc1BEU2d4aGRFWDVaRlZiQW1nYnlTR3ZTR2JFcFc5WkEwTmZz?=
 =?utf-8?B?SkU4MFZpVk9vbWRYd3dUMlVDaWs3cXUyTGg3WEpwV28xVmluR2RlZTZPNDB6?=
 =?utf-8?B?bEZPa1haYUNkOWNxL2Y0TEVhcGZFaTl6RUNqODB1RGQxZUNubFdRSWxWQUFi?=
 =?utf-8?B?VTNEZGhGaVB6cTVIbDZYZlNNUXo4K0RINFQybXdaYzB4aEY0ZlcwOEdCY0Ft?=
 =?utf-8?B?QUdDby9JWnRURHJhcms5aENoanZlQmIyNDhjY3liS05xRHRFdVJEc1lQUVRG?=
 =?utf-8?B?azA4MDZ5QjRSU29LaFNHall6WmFOM05ndFk4eDk0WVVPdWo4T2RXV21ob1ZP?=
 =?utf-8?B?Z3lTcU5hVTFSN0pKQU1SM3dHTlJiZVlqNnl4Y0lJVzNSTEhrYmlvaTJXbzJx?=
 =?utf-8?B?RU9lc2ZsT2FLUDdVVG9Qejc4bEdtWnRuTXJBajBiRVlKOFZDTTlpVkp3MWF1?=
 =?utf-8?B?U2N4TVMvY0hmS2hXM1RNSlRGZGgwVWhacXl5RkM1c3BVRVBROVdRWTBhUzlS?=
 =?utf-8?B?U1h0WTBpcG5uajZCSXZpQUhQQkVyazhUUnRnZlh5QzZYV3IvbCs1ZmtyVEZI?=
 =?utf-8?B?T0ljWnRUUm1wZmRwSjM4NGtndDlUaFJ0WHdBQXlHOUowd0JXTjcrUVJ5amZK?=
 =?utf-8?B?Y240MzlpMnJQazJCd0VlRlhEODh4Z0l4U1pJbEFJVmo5dmt0eU1Ja2hjVGRZ?=
 =?utf-8?B?akYzK0JaTjJrQ3VFakF3VFJtS2pMREowT2RvMFpEcW5UN2VtOFdCcm1EUUJH?=
 =?utf-8?B?QzIxU1RoNkE4dTVUOHdzRmwwSXZlZzRGN0tjdHQwZ0craUdlclM5TXpqYWND?=
 =?utf-8?B?MEcxZzVnVGdYMnVWcHhrdzBmNjROZDdmZVMvS3ozQUdkRnlFSTdnbkUxNXVa?=
 =?utf-8?B?R3I3WG5nUldrc25aY0dKT1AzcmdxOE1IcnUxdmRnOERFZkNQMkNyeU9Dcm1W?=
 =?utf-8?B?Nm5ydWtobitXVjlYdStlcUphK25yWUg1YXVsazMrbE1zbER3L3IreStrRVBY?=
 =?utf-8?B?WHAxNEZNR043OUpNOFhyRW5WMlhUZ3JOWFJNakVKTEFnYy9FVjVKZmlISHFH?=
 =?utf-8?B?QWNmSTJFWmtldEw5V1YwNmh6bzg4YTYyOGNyMmdTbXBTdndqcjdyQTJCTVY5?=
 =?utf-8?B?aHZOcWZEcEU2MEVSUlMwMWhub3YwVlJwZWNzd1d6dHd3SHFHUlphZVdObkR2?=
 =?utf-8?B?andFS1JRWFFQZXlTbk12Mk9EMHpxamw5OHU2TGRPekg3VXB3MVF1NmNqWHBQ?=
 =?utf-8?B?TTVNUFBqcmVtNkVBVXBuUGthcHhZNnlHTUI2R2VBbnJvODliaHYvblAxbHEy?=
 =?utf-8?B?ZU5scU9vWlhZaTZmbnZPdmtMcE8wS00rcmhSemxrRzVkckNTWTRLeE5vaFkx?=
 =?utf-8?B?QS90Q3VnWVRFdlhmNlc0TThkb2k0ajdabnJIVms2ZEtYQUlWVks2dlJvdGJ6?=
 =?utf-8?B?L1RqSERycTI5cFI3dE1qVkhqbjJQejA1c05IS1hvbnRzZldlMVkwdGFsbURN?=
 =?utf-8?B?VGh3YVUrbWt1bGtvekNOYnFCQjdPdDhRY3Q4bmozSHBNZVJRckdCMFNOdFd6?=
 =?utf-8?B?MGI1cnQyNWdSa0pGb2p1WndScWZhbnlmbjRnTGJuRUF6WU13d0I0WnVPUEpN?=
 =?utf-8?B?V0VJNUZGQXB6MFlralZzL1FINGU2S0lkMC9LTEtvdkgzT1NpYlhCdGRkYyt3?=
 =?utf-8?B?NE9NNlB0c0U4aGlxN2RiQ1htVENTSnVmWEFianREa2JqejVOdWZCeWNRNHFs?=
 =?utf-8?B?Tko1azh2VHNFL0VlcWV5YkR6a1hod01meGQ1eTlFT3lrWCtqN0loWWc2U1o0?=
 =?utf-8?B?aFFHeVZCcyt6RG92MFlSWjZHSk5MQ2o3Wm85b3JXT3I2Tzl6ZUtLdHIxeWd4?=
 =?utf-8?B?KytqNDFzN2I2bnNldUs3TlZGMXNJaU1pZEpiZlBCOUgxeHhCMFNYSmhocHZM?=
 =?utf-8?B?Z3BBNmw5RFptTlJMNTkvdENQR1dXUGZkTmJBRnFxSkhjejNwOFAwTG4wUndQ?=
 =?utf-8?B?K2NDMWN6RlFqcTNsOGhRYkw2cllTV3ZKOVVLbmlCa3NnUE9DL2xJYTJzalNr?=
 =?utf-8?B?cmQrc2w0eWpBSVhXQU9GRHkzbUtzSzZKTGU1SFRuSDdESWZMMysralBGbHcw?=
 =?utf-8?Q?hwKk=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 07:29:23.5998
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cea5549-0b12-43b7-f989-08de362b82a8
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF0000A79C.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7360
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA4MDA2MiBTYWx0ZWRfX8mnwSOBFrNbZ
 OnCXctjNT/aCnOZfkEZdAAtET1TfFCb9TbioVv9rqsHmkj7rbc0aDZp5G9SSHeTA6krJ3P0aUQk
 m02tWGNAVSSPonD6Wbp3kNQgSX6H5F0bpvAkEB9tk0N7xZMeSDurkmXkRsLcao+unj+/qyEboMt
 zNiNnNxCZqe/ENdVdfz5npK9s5kAd22ZZCUWebFz5h5x8BdblG1G6QLl2UwbKvCXkoBHMD+thPD
 lReaB6xaScUVBV6ArLEfDswy1zAWRy6Tp/3aS3dI/wZDu/CovWVg/Zr4HiYKZOMZ7TJesqjpycw
 QqYOcy/qNybKQY3Q+C9vGIZODG/vWb+taVZuWB4nHQpI9+EBaC1sAv+se61GII5h3F4xJMKMOig
 U2i+0NxzKErqwp2YAhHVnRohCKKoOQ==
X-Proofpoint-GUID: _pQxZNRF75LhDlhiYn5w8UnZikD60jfp
X-Proofpoint-ORIG-GUID: _pQxZNRF75LhDlhiYn5w8UnZikD60jfp
X-Authority-Analysis: v=2.4 cv=R/oO2NRX c=1 sm=1 tr=0 ts=69367e56 cx=c_pps
 a=47WbqJ5M7RG3CIq0ooiKZA==:117 a=d6reE3nDawwanmLcZTMRXA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=XWp4PHTOCikA:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8b9GpE9nAAAA:8 a=y85xp1xkQ9wiHhBLIzMA:9
 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-06_02,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 impostorscore=0
 bulkscore=0 priorityscore=1501 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512080062

SR_SMF status bit can only be set if CR_SMIE was previously set,
keep status bit check only.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 drivers/spi/spi-stm32-ospi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-stm32-ospi.c b/drivers/spi/spi-stm32-ospi.c
index 06632cdd1630..c36df8d3f5cb 100644
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


