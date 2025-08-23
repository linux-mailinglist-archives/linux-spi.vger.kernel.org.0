Return-Path: <linux-spi+bounces-9641-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B28EB32A57
	for <lists+linux-spi@lfdr.de>; Sat, 23 Aug 2025 18:06:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26BD5179A69
	for <lists+linux-spi@lfdr.de>; Sat, 23 Aug 2025 16:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B4B2EDD41;
	Sat, 23 Aug 2025 16:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="kr4sSuTk"
X-Original-To: linux-spi@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021097.outbound.protection.outlook.com [52.101.65.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29E12EA165;
	Sat, 23 Aug 2025 16:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755964899; cv=fail; b=NNgcHs2BbevgB2VDB2BIb507kVsgvZQTGErDtM/8Az8Xml/67Cj0xtSZwGAQqLoagz3/PWstgrUZYDeK3l52RPerpa8GG6pBIO9mDjMnCedVxb6/aaZTRUozzlKa6iKEtGg5l5c9MIYfes+5iPPVQ2eEM3zJ9xpXrYUAhsbvJPk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755964899; c=relaxed/simple;
	bh=pqsJ2cJPh84+64h7KzB8n4SLnMgQ59A3QgJg9eFXFiw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F/D64yDd+9EWEoCTxj97c4LqO9UTbIu0JFYexqLDljGfc5+A42A49ad+K5ip4sOH0lTGogcK7E4S9hwFwDjKEGFkdxDxKUwGpdWAIuQjvIkW7+4xpgbqwWJWWo7oZW8A6fPmuHcjimZuQ7GcAkwITYEE2YO1E6V0DmV0e2tQJVg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=kr4sSuTk; arc=fail smtp.client-ip=52.101.65.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EAKfzKt22GHbXUtuqU8T6V/ROWVi5D/q8N13DS/jqZXTZIF0groJzmp1jwNDQ4lsEzSrARn9bDErEplgveYWnQv7OpBrkhyzxJeIHJ4Ya3gAheSS32kqIYsGDThDKKY/XWVZkmLrsFV9yjTDGfSKnSftRMJSuPir4DNXauHUNtw/JTxt2fIOjaUw7ql6BLCqSiRtAP3ElaJa/4C8up3RFiFsauRlL+AjJnVuanjbstm7rzKnoHXhUmJGQ00wkJY71fc9eVnCU4BRisMhssd3kmjuI5UTdd+QXdXVBJmS225UZWLtSzyS+eq2UrAA1IOifRA/AAIdbs3QNiA46Pk5Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bW1yhK8B6z5onyJWCdzz1MdADZW8et6P9G498R7//Vw=;
 b=FJAfifk35EB0ELjCUKYtD6Rt43ZB4tHheKF36ktK2ACQmjGHiECH3ss/diY/6Y0jPWk7O1zj9jAh3SnCIA2qJcIy0oB0+AnHWsNJk3zUOPgZAiK47PdHqtWQjY4L2PFeyQdnzoS2efWyXck1bcld6sqRLzOtT7+wGpc9idDqGugKYeFpZCBRGD2IqtZq0iJ2soAMGPTXUfZUyguj7ZbdcXvnFDowdniBscUzyTsxn5XwLGHZ4FMTFdXjvurrm8Z94oMfOxxquBjpLr5yQ6NbGiU5PxTU5R6yQGY2LoIpbfdiQFtdbTs0J9mPD0bWUG54cmB0PLPKQcJQkvbj/J9aoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bW1yhK8B6z5onyJWCdzz1MdADZW8et6P9G498R7//Vw=;
 b=kr4sSuTkzdkL+tATImWIM35GtXyY22bOy0cfJY7oEghy5D950pbdWe6pSiQ+8FN2tQKNBnZ8c4AKV8CjKBI/ifRk3xPxd4mnYLeT9EzPNHg/L3tUTvTLZjG4T7LkcFR2vG38pjYQmqGThUzr/ejsoDjaSfWJTbR/IQMguh/9+V36TzI4P9Rmhqdg8LmZeGv51UcvmBDRM47hGFt8x427JOL4Mn2XqLYymSIEY0zZ1MrerpYfN7sOysX3qxq8hrbGpSjMy0tzVtUHID8FfVCf0rWX8hLPszsXMIUOuVB9m2fbmUnGGVgeq58V7N9l542rUUTK2FuVLupC4oVuM+xP7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DU0PR08MB7519.eurprd08.prod.outlook.com (2603:10a6:10:321::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Sat, 23 Aug
 2025 16:01:30 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9031.018; Sat, 23 Aug 2025
 16:01:30 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Ray Liu <ray.liu@airoha.com>,
	Mark Brown <broonie@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v5 06/13] spi: airoha: fix reading/writing of flashes with more than one plane per lun
Date: Sat, 23 Aug 2025 19:01:09 +0300
Message-ID: <20250823160116.3762730-7-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250823160116.3762730-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250823001626.3641935-1-mikhail.kshevetskiy@iopsys.eu>
 <20250823160116.3762730-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV2PEPF00007568.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::3e6) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DU0PR08MB7519:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e2fc709-edc6-45bd-ba4d-08dde25e52fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uY+ageI9mucOt1joNHq+mJKW9FGpL54BJXHkpruCj3LZv+ezJHWi9w1pXk4p?=
 =?us-ascii?Q?tWSXz6/YvQXZyk5EQir7ut+/n0ZY1atP6ZlHDhs0KxLM2plDxkx53OVKWm/Y?=
 =?us-ascii?Q?pwwgURcIH3HkIKvLtAlAf8zNW75VIXcH9mMHSSgHs5/T3yke+jC8zSHlqEe3?=
 =?us-ascii?Q?6YwsEcmKEh08/fkY20BXGi3hbvN982DsxaijVwnD3UPQq1kNG4t/KUSgeL8U?=
 =?us-ascii?Q?VFiovb+0TR9tFGERcZ1hOfldfbMz0a13wDyYE3J2zFvDjkwvhuWGGgYhe4jx?=
 =?us-ascii?Q?TODh3auuxl/JmxdP9lhb1umoRAWiqWwXuwW4R6l+UfMa3oN5khg0HWNGiSnq?=
 =?us-ascii?Q?xtbkj4odHElseLA1ro3oDi+8+NQXN6SfTGIXBIQpIdn7UVUbWfQ1/A0N98Ll?=
 =?us-ascii?Q?bDOwioItC/wZ6ajThmdweYZoh2PmFUlBRTxRhdTMjCfRMxg1aUdC54SbbrqY?=
 =?us-ascii?Q?Jqeg+rT+eU/N5FgQn9RHSlL9QggORd519AXIz0Ukq7joIfd9lZsjNxG5n1QS?=
 =?us-ascii?Q?7nHAi2WPsI2MyUw0Bh8oqeNQp0087BxFwRc82mes5SgidOJ0o+3TtBdibkf6?=
 =?us-ascii?Q?+h8jLl9JoG29gGBaFv5/J7RjT+BAVQTL7o5Gx7MyYyKS3jy97qYNu/Fn633b?=
 =?us-ascii?Q?P7IiV2RbhnxbUJRDa4OHYut46JI3cjmjIZLKJaGnKeidkI1zeyp3UlflNIdP?=
 =?us-ascii?Q?lvruUIxDsLkmGlHMZ+sYZ42FqYElibI7eoIADm5kKXjgBcF+EHoSre7q/N8W?=
 =?us-ascii?Q?ERsuR8pLiVFoYjJvRQKVzOzHFkcs8pZV1nu8dDloJVtctGUEeNKDyjeVi8R8?=
 =?us-ascii?Q?VuqxzGLlD56anCF8sgCv48QCxE1zrasC4g9loFGaLJbNocQ48HcBXZEkEWAt?=
 =?us-ascii?Q?ur1DY9hza9qPLSTKAoVR2IvLbhWXj3+GeXRw7o44URA7AZOM0/3Rq02la6hg?=
 =?us-ascii?Q?/QYgPFiVH+Jpkmtai3fDCCGCzE5fu8goKf2zYlysQq6TNJs/CYEmJgrMhxvn?=
 =?us-ascii?Q?LPJfHsNBDxu4AxEzRo4y1JbC9pQllmOz/7GStGAJVvxmV1Ihf72MLdRVPxFy?=
 =?us-ascii?Q?YEdAbuKN/ZQk7Nyc/+xqANcTqXxsyf5sXGkSrJECye17iiT6+elBVN2IW7Cx?=
 =?us-ascii?Q?L+bK7mkZncdqF7Od36brJAn/KHw2EulRq+zPwHkXw5m17hd9Y5PWt6QGlX5d?=
 =?us-ascii?Q?WHWo8bd7R+5Z6KpISwE8vCa6a4tmRkiZ59Ostr5B7oF3X666HQG2idoOayy9?=
 =?us-ascii?Q?ptwMRciJIDykc0XW1Wrq8w0exBViUX3Iw0MB0WwMUnKj+COtAnD2XNvBzMLl?=
 =?us-ascii?Q?CHN4zgtpZ58/WVcUemOht3Rq7wJegYUtCkOVCqbgebvnpRJQOa6YZSB6pv96?=
 =?us-ascii?Q?02hxdyCdVgZ7Ej6eNPJVXq1vOMvwb5pRY9VDuAYaSQlfBm5hiA29SRFtKssA?=
 =?us-ascii?Q?D/32ycc82EIEoTwdr3aw4wDgfxn3YVShhjDBa1LMdk6ba2sQFk6bEQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?g878Plsxs1lzduUCHA3eS6ZKFCvKiYm5oig53toyaXST8h8YCyonprUruIp+?=
 =?us-ascii?Q?uoIoKxSkODIbgs1zkJveYbNn0KJay4Va1ug3NIPjczBKNhACV6kPu2QY5OUX?=
 =?us-ascii?Q?o5JrgSUL+D4y71ggULlknAVOew4LBuwJ05vQqG3SXbL2E/C9Gdcfbq+oURpf?=
 =?us-ascii?Q?VwoXR0BL4+xLx9rSmZjV2QQvZQd5bq5bFKJ7lCyckd09Hhg7Epb5wBI/rB1R?=
 =?us-ascii?Q?KM1UVjt1APyR4lmWj5siYHCQVQ1t/+qbnprFJFaBDPu1EXBdcfS59OAXIgDv?=
 =?us-ascii?Q?8wY5Alk5yCLYuC79EKX1V0eJgkhxnff03O9czwaFlTaOSy68Vcv0UetZqAeo?=
 =?us-ascii?Q?5HM70Lz1jAQeDSfpvJ283aYbF+Ks5TBSG22T/jsFEEXsdsHGkFRc7fFz/L2c?=
 =?us-ascii?Q?GZzzVNeG/Puu1IrXs01F0q2135ypLKnpA2aC0TMa/VlmhOMt+5WKgIM6jBpA?=
 =?us-ascii?Q?U2PpqG0PpmbMM76CvF98/T9+HQzRlt203iytFH8gIFSktLAr2owBRC8aOw2o?=
 =?us-ascii?Q?YsRCjkQLwJx9K1yNhilBbqdN30ZZC8eMeQ0DS7yGdwLdTilhlMv9NUBaB7sB?=
 =?us-ascii?Q?nXAvDLuVXZZgn2RhOIoLI/enxvdUH0Stb82x8Ts4p8ov8cg/IbOsozf4v+ul?=
 =?us-ascii?Q?fb5bzmg+sqQCzEvuMgAe+oKhiQWnk8od0ftWrr0u6m4+P+SaW3eVMPtiosUA?=
 =?us-ascii?Q?cSbG0ZBK38ppz7MUbEvId04Ef0wzxlTdqpRkPoP5qYkGg174T1CyKcHcq4Iu?=
 =?us-ascii?Q?h8mN8o1WWdqSP7WZrd6Y54EC/rTpeCqulb++qVTjdQ6OPtpqhpx/Vtj+uB3R?=
 =?us-ascii?Q?1Vy6xbNzkNkRspUH0lkgus7QSWO+7bsjX2DUEjhUaGdw2a4HXPmQrEocFBLM?=
 =?us-ascii?Q?QuwK+12y12gs5tbGbYZ4fCCxJwkZ2yjVDLDEh3jo4XUql8VLvfh8RA5x9M74?=
 =?us-ascii?Q?Sdh6auUFV7c/lvxA9c+P1CI6pTEaUU3F75d87ewRB9lh/tbkO7HQ4o/TdJHq?=
 =?us-ascii?Q?J0kzCeNMCfBhCQ8yP0llg1ItU82HFxV4qBZBDupseHescQS8oo7GyQwmq1uz?=
 =?us-ascii?Q?rAVtquTX0sODAp/CI0Gt7BDL2OX14a42ND4uU/brIpnqxf3RwG44IYMnLDSt?=
 =?us-ascii?Q?0ATR8qKu13AIdoLe6vGizBp5E/4JP+6tulcwveloeczLiLEfWKcmHiaV/VHz?=
 =?us-ascii?Q?cyVQdDzVfHszWgdIPtID79/L4ilg+c6KzxA/tpRM/VPSy18Q53ZrSB3ZtJrB?=
 =?us-ascii?Q?h9EM7DNE4bihSLVHJs+IigOKfAOeAJreiD1e5QPPa1oLNVQhD8eeZnp7IzeN?=
 =?us-ascii?Q?0/+oPCzv/8ryYAvnKSgxcznnJFhfgBdtttvj/mtHISkbnwK9ZeilXF/PmVX+?=
 =?us-ascii?Q?SR/fj4KjtDbwQiWqOtXg/eiEQUxzo+7O7TrZ3VL8MPJt4LUoEHbtdkG3wW31?=
 =?us-ascii?Q?oNI89ZA+JOl2OLVQ1RCTEAzZXvy8tIyLxN8iw78EpeNJlZsouP1JJTPUu1Oh?=
 =?us-ascii?Q?363X7nXxvkqMVtny2D76cM93mVDtnCNziYv3zZiTmNnyNaBXSd3/FheMkB6F?=
 =?us-ascii?Q?n0HD9zHu/2tSko4NzIdPfdhEeb8fIdEocwU9qLs9ugBoHHZ9HTw99l8cbV8O?=
 =?us-ascii?Q?RlEpU0fRhVoolqlfTITnMQc=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e2fc709-edc6-45bd-ba4d-08dde25e52fb
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2025 16:01:30.5165
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qQU7AAsOrpUuhMmhmSaktm+0QdxuRxPjNTWGTPoJxRvPqAerT+JsIQ3QgMJVVkMUGvp1C51f6Dy09kn+uVDrNQ5ZWn458T8CuK6PxzscLS4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB7519

Attaching UBI on the flash with more than one plane per lun will lead to
the following error:

[    2.980989] spi-nand spi0.0: Micron SPI NAND was found.
[    2.986309] spi-nand spi0.0: 256 MiB, block size: 128 KiB, page size: 2048, OOB size: 128
[    2.994978] 2 fixed-partitions partitions found on MTD device spi0.0
[    3.001350] Creating 2 MTD partitions on "spi0.0":
[    3.006159] 0x000000000000-0x000000020000 : "bl2"
[    3.011663] 0x000000020000-0x000010000000 : "ubi"
...
[    6.391748] ubi0: attaching mtd1
[    6.412545] ubi0 error: ubi_attach: PEB 0 contains corrupted VID header, and the data does not contain all 0xFF
[    6.422677] ubi0 error: ubi_attach: this may be a non-UBI PEB or a severe VID header corruption which requires manual inspection
[    6.434249] Volume identifier header dump:
[    6.438349]     magic     55424923
[    6.441482]     version   1
[    6.444007]     vol_type  0
[    6.446539]     copy_flag 0
[    6.449068]     compat    0
[    6.451594]     vol_id    0
[    6.454120]     lnum      1
[    6.456651]     data_size 4096
[    6.459442]     used_ebs  1061644134
[    6.462748]     data_pad  0
[    6.465274]     sqnum     0
[    6.467805]     hdr_crc   61169820
[    6.470943] Volume identifier header hexdump:
[    6.475308] hexdump of PEB 0 offset 4096, length 126976
[    6.507391] ubi0 warning: ubi_attach: valid VID header but corrupted EC header at PEB 4
[    6.515415] ubi0 error: ubi_compare_lebs: unsupported on-flash UBI format
[    6.522222] ubi0 error: ubi_attach_mtd_dev: failed to attach mtd1, error -22
[    6.529294] UBI error: cannot attach mtd1

Non dirmap reading works good. Looking to spi_mem_no_dirmap_read() code we'll see:

	static ssize_t spi_mem_no_dirmap_read(struct spi_mem_dirmap_desc *desc,
					      u64 offs, size_t len, void *buf)
	{
		struct spi_mem_op op = desc->info.op_tmpl;
		int ret;

// --- see here ---
		op.addr.val = desc->info.offset + offs;
//-----------------
		op.data.buf.in = buf;
		op.data.nbytes = len;
		ret = spi_mem_adjust_op_size(desc->mem, &op);
		if (ret)
		return ret;

		ret = spi_mem_exec_op(desc->mem, &op);
		if (ret)
			return ret;

		return op.data.nbytes;
	}

The similar happens for spi_mem_no_dirmap_write(). Thus the address
passed to the flash should take in the account the value of
desc->info.offset.

This patch fix dirmap reading/writing of flashes with more than one
plane per lun.

Fixes: a403997c12019 ("spi: airoha: add SPI-NAND Flash controller driver")
Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/spi/spi-airoha-snfi.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
index a39c3ab4af5c..5ad3180ac6da 100644
--- a/drivers/spi/spi-airoha-snfi.c
+++ b/drivers/spi/spi-airoha-snfi.c
@@ -726,8 +726,9 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 	if (err)
 		goto error_dma_unmap;
 
-	/* set read addr */
-	err = regmap_write(as_ctrl->regmap_nfi, REG_SPI_NFI_RD_CTL3, 0x0);
+	/* set read addr: zero page offset + descriptor read offset */
+	err = regmap_write(as_ctrl->regmap_nfi, REG_SPI_NFI_RD_CTL3,
+			   desc->info.offset);
 	if (err)
 		goto error_dma_unmap;
 
@@ -860,7 +861,9 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 	if (err)
 		goto error_dma_unmap;
 
-	err = regmap_write(as_ctrl->regmap_nfi, REG_SPI_NFI_PG_CTL2, 0x0);
+	/* set write addr: zero page offset + descriptor write offset */
+	err = regmap_write(as_ctrl->regmap_nfi, REG_SPI_NFI_PG_CTL2,
+			   desc->info.offset);
 	if (err)
 		goto error_dma_unmap;
 
-- 
2.50.1


