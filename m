Return-Path: <linux-spi+bounces-11785-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A74ACA6F30
	for <lists+linux-spi@lfdr.de>; Fri, 05 Dec 2025 10:37:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 49F0F31F1430
	for <lists+linux-spi@lfdr.de>; Fri,  5 Dec 2025 09:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3133101B5;
	Fri,  5 Dec 2025 09:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="OADnc09p"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C902B31D370;
	Fri,  5 Dec 2025 09:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.182.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764927269; cv=fail; b=aJdz/GUkb6BgehQWM6vC3SMINSJu/se52WrfBtvPh9FyfxxxCOQB4hj0+IetZP/36swrahomhg6LMwbsZZCz1nTiq63RM09GUk6R88P3pIsmlLWay6VXiEK1WwB2j8Rln0p4ZA/ACb4JE/E5RwDao1go9fwn+i3KE2uIluiMpWA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764927269; c=relaxed/simple;
	bh=Z8I5NHfA46KiAi2iWvYQ3q5AOTmYVtoSiJXWakWNt8w=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=SjPj0eMlaNaICu3oiRdBWRSE7XB5hVGzZHKK5UKD6Ts5bWuyf8xysySHoogn9qD40GsGnLcTOsS3ZvYIHfu6cnJYMzU3lWQJ4+PdrJ7OiRukr94BNGLP6rZjI4+TAqJuiiJpEKlzEfhK26y9o1lBOqaMryYT2m+/j14DjATwopo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=OADnc09p; arc=fail smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B58r5CY1816566;
	Fri, 5 Dec 2025 10:05:08 +0100
Received: from am0pr02cu008.outbound.protection.outlook.com (mail-westeuropeazon11013063.outbound.protection.outlook.com [52.101.72.63])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4au1yk6gk4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 05 Dec 2025 10:05:08 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xkz1oFTmpk85d7Jzt0nFmTZ1mEK3aNYNijanR/loHXfFFDZ/fjPexINdhvqMN2RybN2CTvBijIA9GcjWG633PtHpCa6zfiZCoA6kxc9YM3G1V6FORCdGum+CRu1M8qpDXNGek/g20yUBNWOR4Jh7eokqmUavlPbUTO2+o00NDySJdvfwRVmR/g9hadHrFOcUiTtsPshLWYOkRHCpJmOkjvJqmu0KJxQGI1vzAVaLHvP04hN/sYH5iLwPiVG7LZicDVZz8DkJPkyWFc2hAdOycPCId5uh5JqpomJlLwmucEc+tRGj4a7OXf8NrtrQERxNEq2xDx2oEdsKktWqC6bbCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5AGXbXmwCjd+5iWrWjKAqi0rAeW5yjYHi7s5Ex5KS2Q=;
 b=ZbHsygQeZIXGihQ7j4wsUCpOhM/y5/MgBri+0EQZ6/PIhoAmNFKDdB6F1H9X+faqzxAHb7kzetB9gXKpJIBRqu4w2jC9r9TlD3pthLm62k1HuwO/9xeiHJyKsX3N4A1w/9gupwvfJBchgVhA1OTnfoD8gF9GqqbHLseSZm8VOtWJecvplWFc8f3ePe29wY1d7mkpwS6HbliNq50bntdvkSTGgOlCED5nPeg2zDHKzNHx6z3UGnxM1Vy4VMyxlUs09QE6HBOGln33LpbrlhTTUZEbjifKr3BGbNBlQBQijapqY/ssfAFbpvj0sqqOKKejsfnruKlg8sNr+b6SkPocLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5AGXbXmwCjd+5iWrWjKAqi0rAeW5yjYHi7s5Ex5KS2Q=;
 b=OADnc09paSjUS/WXosHSrFW/encZLUi9LYOtBjuhBZZNbGLvR1jFbhU8G3CrQsxaF+3aRsEyGwVqH/xEXgbv59i2mwI2GlIGniCUisT4ejIbLPTOr2Fos1Ky+eckCDs0rr+/4XiPmNJ+kblt5nNTL8bDFD0++eQWq/F2MnzeoYGbljdMw6XwlsNHGICf7cEsOuwCMvfWMAHDPAaVLWe2JSWO5RxygK07rhjJ1oeNEGE/G3HnXtfxofK4bwz4DsXmiohgMiFcd0TcIn/YfYQt5ZGP35qMqi/ABYregl6URuw8GGOCP7/cgCxC+ZnMQbKp7f6WbecdLHXlk3t1MdDJWw==
Received: from CWLP123CA0269.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:1d5::12)
 by FRWPR10MB9278.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:d10:187::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.12; Fri, 5 Dec
 2025 09:05:07 +0000
Received: from AMS1EPF00000045.eurprd04.prod.outlook.com
 (2603:10a6:400:1d5:cafe::8f) by CWLP123CA0269.outlook.office365.com
 (2603:10a6:400:1d5::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.12 via Frontend Transport; Fri,
 5 Dec 2025 09:05:06 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 AMS1EPF00000045.mail.protection.outlook.com (10.167.16.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Fri, 5 Dec 2025 09:05:06 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 5 Dec
 2025 10:05:46 +0100
Received: from localhost (10.252.31.202) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 5 Dec
 2025 10:05:05 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Subject: [PATCH 0/8] spi: stm32: Update for OSPI and QSPI drivers
Date: Fri, 5 Dec 2025 10:04:50 +0100
Message-ID: <20251205-upstream_qspi_ospi_updates-v1-0-7e6c8b9f5141@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADOgMmkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDIwNT3dKC4pKi1MTc+MLigsz4fBBRWpCSWJJarGuSlphmnmicZGBpkaw
 ENKCgKDUtswJseHRsbS0AjCy/u2wAAAA=
X-Change-ID: 20251205-upstream_qspi_ospi_updates-4faf7a3b098c
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
X-MS-TrafficTypeDiagnostic: AMS1EPF00000045:EE_|FRWPR10MB9278:EE_
X-MS-Office365-Filtering-Correlation-Id: 170805f9-6c96-411b-537d-08de33dd6230
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TklZTVVhSE5yeHhELzRPSkFXTW15OUo1QlU3SEV2OGpqNVhnWjlZNi9xdGJN?=
 =?utf-8?B?cEg2Q3J4dFFJWWlJNVppMmRGbkNhVDZRSFNFeGo3UEI3TmJ2aGNsR1VQdDNK?=
 =?utf-8?B?ZVFzUEt4am9QSDUvd0dtY25VcEJKTHZ2VmFOV3VlWk1COFYvN3UydHM5L3dL?=
 =?utf-8?B?VnVrZnhMRGxwSDVXY1NMYmxVZWhWdlFBbXFhWnRRamZVS2svVU12SVp0dUYr?=
 =?utf-8?B?MmRKL0Z0SkxnWVh4VHB1b1dJNzIrOTFHdGJNN0JwRGxTT1pVcisyaFhZQmV6?=
 =?utf-8?B?VUZkeW9rVnVuYlFhNUxDVHBNUUFoaUJJQW1STFk2NmNVZEtBRWJJZXNiVC9t?=
 =?utf-8?B?cHUzOGt4MUZrNkJTNit4aGY3aFpqWVZPMy9JNk5RR3VJOEFaMGQwc2I2MDNX?=
 =?utf-8?B?RW4xWVYxL2N0NFJuT0tHMUdKa0lFUURTMENLRWdOR3QxRzlXZDNnLzltRlN0?=
 =?utf-8?B?LzVJWHI1SnFxclBVekxMM1BCL0dyRjk1VGlqYm54L1JOelROa0FLd0JQMGtr?=
 =?utf-8?B?S1JNcWdLdlJwZUhYa25HNnJkWSt4S2F1T2JUTkQwOVFqYWY2SnNIeVZoekVp?=
 =?utf-8?B?R1N1VFhHWkhHd1N5U3pGczhmK094eUtZK2Y4T2xETlQ1MTdheW14UEp0clNG?=
 =?utf-8?B?NmdnaFVMSTkxYU43aHRzMUxvRnVOcHJGT3RMUVdUYUZybEVKVUdhWTkySS9l?=
 =?utf-8?B?aWpBRC80VmdLVGRiUzQ4d3BscFloYXp4bUpxeW9zUFRTRkhVYzBKUWdzdTRo?=
 =?utf-8?B?L1ZQZC92V3VDbkJlcGpiV0x5ZjVvY05lWGhnOFJ5M2NoSGl2eTFteXZkOXdR?=
 =?utf-8?B?QnBQZ2RPdFVoTWcyOVFhc3cvck9nZDNmL2g4dmlpdCtxUHhPQmFocGxEejBk?=
 =?utf-8?B?N29FMEhoclhjMmVKdG15bnI2QTlreUkxbnlUY3NLVjNEVzNqM2FtSG1HV1g2?=
 =?utf-8?B?TEg3T1lCQnNqeEVmYmwwdU9xak5FNWFZTWQyc2FaVlk4M2pwRWVZdE85T0JN?=
 =?utf-8?B?bDNYZjZ0dGJKUlpoRERLWU1XVjZhU0w0amRqc2xUSEVSR1Y2UEE5SWIyRnBx?=
 =?utf-8?B?dlNPZGNFc1lqSlhDZzdLeTliSDF1aU9wRnBPRW5TaENpVHVLMlJRN01vTWdF?=
 =?utf-8?B?dFVHNXd4MWtmelBsZHlCL0Qxckx6bHFKcWdwNGFTUE9RcTdkR0FrQjlIOUlw?=
 =?utf-8?B?YXZNb1JFMHhhWGZzemRUWDNDcndHT0lhSXZkS2xzMWx2NC9SeW5DRkdwTm9n?=
 =?utf-8?B?alNaL0tBNStueC9CN29yUlJ6UkEzNTF6Wm5nR2tybDY3cm9TTHA1ckxaV2Qz?=
 =?utf-8?B?ZCsxZ1Z1NDQwakMvUGtaQVR1a1lpbDlZV1dXa0ltS0xQRysxTStueXc0Zy9N?=
 =?utf-8?B?RVdOZ1gwM2lnMWJrVFJ2YjBER1c5R3BNOUMzelMyV0ViTFVFRTRKMXVnRnBn?=
 =?utf-8?B?TE84RUYrdTQySWc1OXBQejZHYXY0WXZYazV0LytlNkNJOS9yQldGdzNzUHJy?=
 =?utf-8?B?YWY3Um5xQmhibDJwSWZhWlFIaUhQMzJnaldUWEdGajBTM2dYTE1IOTdsRU0x?=
 =?utf-8?B?enk0WHNTT0xwVGxHZ0cyNTd6S1RTajFjYTI2b3FUZGczNkJqa2IzeFBZYmtM?=
 =?utf-8?B?dEJ2eFJ6dlJJV2FiYTJQWFpHeDJNRURSSENMdUdvRmozN0h0c09TRXBrclUx?=
 =?utf-8?B?ekdBTXhmSXozY0hZYWdVODNXdUt4RGg0K1d3Sm9xQnp4QWEvdkJ2STdvaGtT?=
 =?utf-8?B?eGVYZGg4L2U2cHNMbmxHN01UeFlORlNNMDMycWtjM1g1MmF3U2UwVVdNTGVu?=
 =?utf-8?B?OXozb3NSejV4c3ljdUppNmI0eW0yQnlqMzlsM2pIc2JPNU40ZWl5MCsvUjFV?=
 =?utf-8?B?QTAzUGVaUDc3bEpVOGlOeEJyUDZiQ253eW9YNlNWQUM3MlYwT3loczFGUjZP?=
 =?utf-8?B?WXBiMjhjWHpFSEtLUmtIZ2dlVjZHOHQzZ25tdkZBYWhBQURZM2tST3ZCb0ZI?=
 =?utf-8?B?N3NQSWlaZ1RLaUE4ZExrbmdBSk5KTE96b1VhRGQwc3oycGhWV1JHQXBDeXJz?=
 =?utf-8?B?UTNpUXRSMjlFKzdLMlhFWUFheUxJU2tHREE0R3lGTDhsdHU0S2NTVUlxbVZS?=
 =?utf-8?Q?SemU=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 09:05:06.0552
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 170805f9-6c96-411b-537d-08de33dd6230
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000045.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWPR10MB9278
X-Proofpoint-GUID: rP6wMOgn7R_QaoW8xaI5jP7FDSDk_YOw
X-Proofpoint-ORIG-GUID: rP6wMOgn7R_QaoW8xaI5jP7FDSDk_YOw
X-Authority-Analysis: v=2.4 cv=eobSD4pX c=1 sm=1 tr=0 ts=6932a044 cx=c_pps
 a=NFb+XA0cqGrCirhha3CpiQ==:117 a=d6reE3nDawwanmLcZTMRXA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=Uo5EeBN78AAA:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8b9GpE9nAAAA:8 a=A9BJ_P7MhkSIbhnakx4A:9
 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA1MDA2NCBTYWx0ZWRfXx0MaI99Ff9Dg
 X9VyoNqWBZw9umLsHbMq+0NL40JhtGtyplPi8p8bwQD4dLdZNr16YTXqEjUT4F1Uw4FY5juoWPj
 i/Kg5MPjYwdeim9SUzmHjTQ90pvC74R2UALpB6T1wdrVYOaQm4hw+rwRo+mxKCe9LO0puiN2RYg
 4eRucWG1WovDzH2LSrjbtClVlrpiB4w1XhtA5t/8eUBV+Hb/7Bat3DKX+Mq4kR3DutGlY4cgNde
 tvgIu3l9XPjS1sWYYhbPGsTHp/LhvaToKMlcwLcsf4aqTPqKxc8QapIgx6J94y8oFwoGMqODrSd
 y0cJVtJWpOExqvC42QmUh2epGry4u78Zho35Cz22+oEC8GfclI1LFHdEHtUuDDrinU1YJAs82cq
 2T4OkajVYrXijEbGvkA7CXRjk7aA2A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-05_03,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 clxscore=1011
 impostorscore=0 adultscore=0 spamscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512050064

This serie applies the following updates on the spi-stm32-ospi and
spi-stm32-qspi dirvers :

  _ Update FIFO accesses using u16 and u32 when possible instead of u8
    only to optimize throughput.
  _ Replace Transmit Complete and Transmit Error interrupt management by
    usage of read_poll_timeout_atomic() to optimize throughtput.
  _ Simplify Status Match interrupt check.
  _ Set DMA burst configuration dynamically.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
Patrice Chotard (8):
      spi: stm32-ospi: Set DMA maxburst dynamically
      spi: stm32-ospi: Optimize FIFO accesses using u16 or u32
      spi: stm32-ospi: Remove CR_TCIE and CR_TEIE irq usage
      spi: stm32-ospi: Simplify SMIE interrupt test
      spi: stm32-qspi: Set DMA maxburst dynamically
      spi: stm32-qspi: Optimize FIFO accesses using u16 or u32
      spi: stm32-qspi: Remove CR_TCIE and CR_TEIE irq usage
      spi: stm32-qspi: Simplify SMIE interrupt test

 drivers/spi/spi-stm32-ospi.c | 107 +++++++++++++++++++++++++----------------
 drivers/spi/spi-stm32-qspi.c | 111 +++++++++++++++++++++++++------------------
 2 files changed, 132 insertions(+), 86 deletions(-)
---
base-commit: 7d0a66e4bb9081d75c82ec4957c50034cb0ea449
change-id: 20251205-upstream_qspi_ospi_updates-4faf7a3b098c

Best regards,
-- 
Patrice Chotard <patrice.chotard@foss.st.com>


