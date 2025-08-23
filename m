Return-Path: <linux-spi+bounces-9620-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21737B325A9
	for <lists+linux-spi@lfdr.de>; Sat, 23 Aug 2025 02:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D19E2AC72C7
	for <lists+linux-spi@lfdr.de>; Sat, 23 Aug 2025 00:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A60191F9C;
	Sat, 23 Aug 2025 00:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="E38xapNG"
X-Original-To: linux-spi@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020080.outbound.protection.outlook.com [52.101.84.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5EA156CA;
	Sat, 23 Aug 2025 00:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755908210; cv=fail; b=DKT3m5qcxTDp/ycEsXybSYpFRePQFmlxaQ4WSNIHc7dHQgsykkkP2F5rXypQEJqTge+xyBZgl7/Hc8meHa3qtThDtCh3WIDfJWm9j26b2cy+W3LOrxh2i/XdHEcCMMiLDvMFRLjwx9ngldpU/73uNjzCJjkBivMD7MPeGAc1YiA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755908210; c=relaxed/simple;
	bh=sTxm4XZXhMLHq0ZM+KYxR2WE1R+ia79q8kYaAWx/k0A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CxXHkZZ5WdmzTIK2iQmMAbGIAyNu1XukU4itljZmW/sZkNbAdmxDnpc7u05uYON5QCWYX/bOdH1bLQzGuql9EIeALpfYRg2TPO0wchOdbBdtNLLCoG5Fz/GeSjdUi5LOF2DUyQ8vB2od2vcuG/mGCK727yMvpAcD/0t6lxTgpsM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=E38xapNG; arc=fail smtp.client-ip=52.101.84.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fv+nFjEGxk9ws2eiUQf4opP4fsfLyE5K4GTJKSXzqD4rZHWhL7Ae+h4UkAMzZ/VnOMgQiV+/jIbaOvz/52r5WUeZsss6Om3BDo8jRBBFi3UiawNiMs9xVOQTM1CG0Jm5uaVgXGuYw7LUUOudmCLDlEcyMO7I8Q20vkhdlLsrVCeyZVSGZG+7hWGSSxTukKEU8EL8/DVTPe63NepvqQJ13/OtcH/s94dhmSEBHnoBIcvvhMwKtHT/KjZfI8VUiNCLixXz1v62xQ4lzfV3x4oqRzpXTlMPdowU7Y8KBR7jOylSA1IVvWi7Xwu2A2Q8kDx0y94ZfaRmikq5Co2naJQXwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c3c/TgdmkaaN9doSTnln4bmCmnSu+DX/UItnM4deJPs=;
 b=NNHCjSrRrsDWoxl5lzB6u/q91uQ/BJeaYS5FqUhmdULyWl4VnsJyjn+qsdCVxmz3NFkN63YiQjass12Ln6Ev6UIuEPIX0CEwSUpjQLtqijsn9Ge1N2tXuQ5ofJtNJ2PYSukpyo9upirUqCOV1PCDrUHIezQXwZ1zMqkDiUVWiKYZQTuDl/tf+P3K+7jvPIHpe2LIHvZHCH9Gsqe3u3020NGcYIbqW3dXkJHuWsjew3vvCdA+I522bg0lWM2omBidfxTDgbUCcRedXVFPjsmq/nleOK5qJUyXWyfJ/njBfr/qwCSCmp3PHWHmV2QqtlPIpPw/+xUOgSx06dXGIiWqPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c3c/TgdmkaaN9doSTnln4bmCmnSu+DX/UItnM4deJPs=;
 b=E38xapNGeRVM1fso0OOXbg2w5kl0DRY+GsXCoRMcpIEZIXBLdNGUhQGIiE9Cpk/9zg1FayUjcemni3+TBjXsE73WmxQjgAPL+C2OKGOEnPr3eWrqYFOZgQABLw59eniv3relAazBfB3RzqzY5R3wU3DF9u7Npa7HGHg+H7Hi9fDkq2Q4Qze2gdFUoEG83tWMnINxTdkK5V6OYJq+ezRXhDmRIlU8UxU/kZ/AfotnXotePrhUlZ6FAIjr2GoJgzOWzEpNxZ6RzZaSP3o3tgstsX3NEiYHudnfxvKUt/eW19zA46l1NaF2AOyzcoBkNPvrsyZ+YzQ7MQMKUI81k90kEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PAXPR08MB6398.eurprd08.prod.outlook.com (2603:10a6:102:12d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.17; Sat, 23 Aug
 2025 00:16:40 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9031.018; Sat, 23 Aug 2025
 00:16:40 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Ray Liu <ray.liu@airoha.com>,
	Mark Brown <broonie@kernel.org>,
	Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v4 07/13] spi: airoha: fix reading/writing of flashes with more than one plane per lun
Date: Sat, 23 Aug 2025 03:16:19 +0300
Message-ID: <20250823001626.3641935-8-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250823001626.3641935-1-mikhail.kshevetskiy@iopsys.eu>
References: <aKgSY7bOrC8-qZE3@lore-rh-laptop>
 <20250823001626.3641935-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVZP280CA0047.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:273::8) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PAXPR08MB6398:EE_
X-MS-Office365-Filtering-Correlation-Id: 234bcef3-7971-400c-83ef-08dde1da551c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bio/XYC7KtQyE/ucte/vFQb3mTZLmknr/m03NcdnG24pIV+InU3hdM7TJPXr?=
 =?us-ascii?Q?gUanTBoLVZ9laJBarP7pNEL+Y+Cl0lJIlWRUvL5nyKNzXnCbWTA3SMtEVrge?=
 =?us-ascii?Q?pdRfaojQrvIxAvv/8SR84FG8c/DUPqhRPQ/D4biMkuS2ZvHue8nHLJ1EP9Et?=
 =?us-ascii?Q?+qVn0wikXx7UoENZmlXpEnD5yKKC4qP+TIE2j8eZEJmL0KZ/YGPbTNVJqQNT?=
 =?us-ascii?Q?MjyQCpdRTfqrD2WFvwI10zG5JNC9SVtA300UGepWCqTW86W0V7MG1innKSlu?=
 =?us-ascii?Q?lNGckYxk92K/wd6hPEsRR/ZmwlzFi88kEFyZHFx0g/8dI+yf1oNGUuNIWcGM?=
 =?us-ascii?Q?E6plJXuHr6mbPNym2ArPY9vKSG6gmcG3/35RAeTLBkHMiuA7zMsMx7fV8esS?=
 =?us-ascii?Q?pbrFDB/mSyuAPqnA1yCvpNjdnrUzKZ4r09lCVSB2olwLs51zFbYIt8mLF0gh?=
 =?us-ascii?Q?Cm0IsYljdJ/xqH4svMeZSAu6sLBwpXoo1RWK6p+Z+golrod17N+O7ge3QAVn?=
 =?us-ascii?Q?Oal3Fb/R559+eSJsPbuVTxZDUF5f6VerrEaZHMqBxbuEoT8+dnkPk7c/7WTy?=
 =?us-ascii?Q?gHfEIkXWY6yrNG68X4SI0T7ayaeKk2HyI9NzNTlBJIDAU5arlzAMkx7DezSB?=
 =?us-ascii?Q?NsZLwpQbHeqU4Sc7gRf0vLLsbOXDeXZUhgRaBzvtlfQMzkGujPJF9sjjtR/6?=
 =?us-ascii?Q?OgYOfFttKF4gqMt2Ocz1FeCZaCB5RvPnZTiA/Bek86bS82WDEnqB2GVkuIIl?=
 =?us-ascii?Q?PCHpIE6cre1k/57bTAchpMu/oF669pESCnxbkKM1j/CDlsJVa+GTZag1tRrr?=
 =?us-ascii?Q?ErVXEd+8tRuWlBGKh15h8eGsgcqS1mYs3t61Dxh0y4THRWYLCCWATRXOTCtt?=
 =?us-ascii?Q?zIXS+7JzQWOEyIdvaEgbopGHkEBGXGPJkYemM0tYnUh6sdcXcS/pEKSycyLU?=
 =?us-ascii?Q?fq8irkPR6JTFgsAPYEB90epFINA/J4sahnXDZHNKdK0TsIEOpkRPjm6kwVBU?=
 =?us-ascii?Q?a3DgX/ilPwEL1ERBbBlPfKcKJK3aP3I8k7zxd74y9OGr8I4vrU0cjtUiaM4E?=
 =?us-ascii?Q?cW0M8hkxAZCNsk9RO3emvPdGPzsrSFoib7GoVeWM6WDVgXE7zKy0HDQHHzTj?=
 =?us-ascii?Q?KMLLjszVqZUgztKiJELqtRAl66YDBBM/3aBr0nBP4aEMgHwGaUO8VIAyDNoC?=
 =?us-ascii?Q?QibuvKgEkgF7XkLn5X6twJVqlFsWr0dW+SRq140daF/ytYPXacyQiNbhKm62?=
 =?us-ascii?Q?gVhBiAWHaBlHHLUost7cx22P/3s771Z/00IrDvnLN1qSz/lNNEovbMAyAEcf?=
 =?us-ascii?Q?Tkp3NDsY/dvUZ9mtRBfqdQjHP87mQfgeV+/h3p3NjfSoiAXIJYsfmMw+NCOe?=
 =?us-ascii?Q?elKU3PWl8XtiN/ZCBOndoaWqnkOtlT5y1YbpmMMpqiis9jPaBl+WI/gDZ/iZ?=
 =?us-ascii?Q?e3DmIf0pNpEGRYP137HmsPaXNrBwSVItANTsT6LrzcwKmpEX3PX26A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8OOZaXBCZjVtFPlHtMjTcFcyVA+3Zt8hTtJRNb2tz0lgZCOC8/yH8P6CXpn8?=
 =?us-ascii?Q?Oh1SkcRgEgcLKj/3NXs8TamEF67YG1E0XplA+irQqGJiI+jQpSvO4tWH6Q7t?=
 =?us-ascii?Q?teorDv3lpOA84qUPqIV7u5p+cWfD29m9fKi/KBLHjKG+E94b6N7U9zXnvhDj?=
 =?us-ascii?Q?UW7fKq4p6kZ3VDs9CfQHZz23DQS1mw2Fb628Tl6A0ckGaPbEGRIsyVt4wbsb?=
 =?us-ascii?Q?65fsonmCMf8qGhIwa4noycuiJeD96QNu4ZNO613ISmPapBpyLJs9SH88i9eD?=
 =?us-ascii?Q?F4ucnyaSXLdA9tCkpkv2QCkdKlrsLNlhgOgUD+tYXiAvrjDbdsuS5+YBl1ne?=
 =?us-ascii?Q?OR3WDX2r7qXIB2HSD8x8sKXo/NOn0UP6dS9TYm4zTj/uijXi6ULTAozC3HWs?=
 =?us-ascii?Q?Y9GuzKNjnUeYBWjY/AJA3WjDfMrQ3eggaXLIyta4NDvn/o3xhdOgaXr/sICP?=
 =?us-ascii?Q?c74KrSGUYnPN0B+2HMpZcrZPtIazh2wp9+t/XT6S2RjCaJtY9t0Gp4Kvn0K7?=
 =?us-ascii?Q?RXKmYQ9sNvGVJP0UwBOPyIisgJ+hbX6aRbtJ4SfkrtHG+DpmLwtEo3maDzbW?=
 =?us-ascii?Q?sG0gNGIIAulSLqVx6FXatCIneibWCxJDQHP5tcvFV5YGczi0GBhaV4+HrOcm?=
 =?us-ascii?Q?xYFYu3BjXVf+PiNJz0hKRt0KLmtd9UFzSGqzpDMAwfSgM0QvKye/9vzJmocD?=
 =?us-ascii?Q?AMQ5PNNOBhTTSe7MVVeCz0aDe0u6g1mMNx/E7qNqBLFC9nDDgLryF6zXKCjQ?=
 =?us-ascii?Q?dPwlHvImlYe8bgSDIya7omPoa1o6n1gU8cao/iZWGNJ2+sUh/c2gQ5GTyll2?=
 =?us-ascii?Q?VDuv7MvqPhAimfh37zSJCJBGz3W8nceVxwzK4fAEkuVjEYAvDnd3KMzsFtb4?=
 =?us-ascii?Q?LYiAiv2pbN4ojLi14q18RrsFV5mS3AEIuIgS7JPu+o/59iOok03AkNSKN3DD?=
 =?us-ascii?Q?iePG/YhWZU//+xkOovhXPpum2Xf2DEqwK4DwFd+r3/bfeL2aneozohZjpexw?=
 =?us-ascii?Q?FOoTeBmTiMLAMlDrXIA27UJ1Z+pFsbwD3qGWREkb6BzM2AU9Nwr3FN/ZFFvF?=
 =?us-ascii?Q?jn2jpQTd1WnN75an5CKxrDikpFH9I9Dcz3eYIPR3sm0QdclgQ2WtD5p30nQ4?=
 =?us-ascii?Q?7SRm0vQ9LuVVol9TP26vwGRCvFIv4FNXUrCYs+MB7FlE1OY5mCsmc+AMIxgD?=
 =?us-ascii?Q?xtNeIW/G+u4915ejbudLTdA7IzkXItir1VhowSI1USfoWZgzxX/S0hzxYp7t?=
 =?us-ascii?Q?LdjUMcWeWH+91RCLuf8ejkgraiQneVE5lpljzYotQj1Iur+nTMPm/QV+p5yP?=
 =?us-ascii?Q?QuYNohF4N94mUp4c20zZ2tHw+JVGikJFr2ljLuXlly0X+jXDq1yh+8PUs+N4?=
 =?us-ascii?Q?6db5i61atYh4WeR/yoTWrwaDxG/XA3LgkWEOPMX3aWJALaAzX8aFUppAAhiB?=
 =?us-ascii?Q?JsPFtPC6KP4G2lPvsbMzAXFMonPm7d7NLzszqIH8p4u8oXSl904ec/+TE60A?=
 =?us-ascii?Q?hiNTucBJjbwHaWBcSgE/5EFm2Fujq4c88qSkA/9KV85Z8g58vfLDWxLtvLkw?=
 =?us-ascii?Q?1xCFVlbG9qclUyKMzDuYKUtBtdCOa5ht3zzXfF81wSAbmPb1ZeHxYmAoMPKv?=
 =?us-ascii?Q?K9UopJQuELhZc9su12gTbTc=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 234bcef3-7971-400c-83ef-08dde1da551c
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2025 00:16:40.5175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IXY+eIeJXEOP9sk59uncweCFpskDFVgbzb3JauMLiqQPlPY2YWG2BRlSl8F2aLj37uPFmGuxcMyRpVu264Nt4i1QrYcSp3HVMBKmF+cxifk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6398

Reading UBI on the flash with more than one plane per lun will lead to
the following error:

ubi0: default fastmap WL pool size: 50
ubi0: attaching mtd2
ubi0 error: ubi_add_to_av: two LEBs with same sequence number 403
eraseblock attaching information dump:
        ec       1
        pnum     538
        lnum     0
        scrub    0
        sqnum    403
Volume identifier header dump:
        magic     55424921
        version   1
        vol_type  1
        copy_flag 0
        compat    0
        vol_id    1
        lnum      0
        data_size 0
        used_ebs  0
        data_pad  0
        sqnum     403
        hdr_crc   c8418a31
Volume identifier header hexdump:
00000000: 55 42 49 21 01 01 00 00 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  UBI!............................
00000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01 93 00 00 00 00 00 00 00 00 00 00 00 00 c8 41 8a 31  .............................A.1
ubi0 error: ubi_attach_mtd_dev: failed to attach mtd2, error -22
UBI error: cannot attach mtd2
UBI error: cannot initialize UBI, error -22
UBI init error 22

looking to spi_mem_no_dirmap_read() code we'll see:

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

The similar happens for spi_mem_no_dirmap_write(). Thus spi read address should
take in the account the desc->info.offset.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/spi/spi-airoha-snfi.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
index 3431a9c84679..df2d3d717c00 100644
--- a/drivers/spi/spi-airoha-snfi.c
+++ b/drivers/spi/spi-airoha-snfi.c
@@ -727,8 +727,9 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 	if (err)
 		goto error_dma_unmap;
 
-	/* set read addr */
-	err = regmap_write(as_ctrl->regmap_nfi, REG_SPI_NFI_RD_CTL3, 0x0);
+	/* set read addr: zero page offset + descriptor read offset */
+	err = regmap_write(as_ctrl->regmap_nfi, REG_SPI_NFI_RD_CTL3,
+			   desc->info.offset);
 	if (err)
 		goto error_dma_unmap;
 
@@ -872,7 +873,9 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
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


