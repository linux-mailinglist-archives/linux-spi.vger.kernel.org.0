Return-Path: <linux-spi+bounces-9895-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B7DB43E96
	for <lists+linux-spi@lfdr.de>; Thu,  4 Sep 2025 16:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBA7B1C860F1
	for <lists+linux-spi@lfdr.de>; Thu,  4 Sep 2025 14:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178CC1DE894;
	Thu,  4 Sep 2025 14:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="nCzL2IcW"
X-Original-To: linux-spi@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021104.outbound.protection.outlook.com [40.107.130.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538E24A3C;
	Thu,  4 Sep 2025 14:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756995836; cv=fail; b=N68NTReCUrfbyRpP9YdH9VGjMYdYT6quPSEppNl3gw2sNZn/5QNFJCNp3iUtdQn93P5YYqDeF3euluB7nv5bgzt6uR+MqAGiqbep9FuMNf3F4RAuZLdyh2bREw2fG0xO631NRBLZG59+BqBnTsBYw3IdLHSphOfr2H3cs5oY+88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756995836; c=relaxed/simple;
	bh=Qq+gYlqtzz6CG7mtJNSCF0aVK0FXEIKbLY663RXT/8o=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=dNs8lnpS0K8BGLycJgdduuSc2gpQVyUT9oIGizK9ALrpNay0HYya/AyjWcuktI/qj/9l6pe3KYkk3nbb5ozRU+koO9HHlWWRPt9l2S9AHi00yMRKTXGk55tvY0W01ZE5TFRIUn6QHDSwFoYH128q0ON1fcFYxKy4kZEoIZUEFdw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=nCzL2IcW; arc=fail smtp.client-ip=40.107.130.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YkGxoi8KmeTWIP+Dj5F5FGlovCUuvVey5P5ltNZ3NoSd2K6I2+ojiI9DLf8hBhbLfKG6JoFin3t75TSnUQgh+jMhVmbpWJCFpIf5aXHeMYAPQlZ6WXPKK+LyrLZaEtQuFC78o0Ox91CfE5NpfBk42TpavFZfsNRZDm6O4EWG51AFnRu6zlHzT8UJThfeg0cD4i49fgIOyqdru+Ot9vZILIcW73VoNsbrrKh3oQJqO8hzox7GJ/0OXmPwDUps+soM8vo2oQPN3+PIE//sWxiKHebJIU08kgDLBEvPbAmKLbuxBDFlLR1f4Xii3k17uCsgjtl7pkAY0igVoY791DvCkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HRR6j2O2EeJr4QICLyLkDSC0CZxVoX4BMUNYPfD06RY=;
 b=iyZyP4TW5o/Z98J/LKJk3FzGWC9jWDss8ZFMO3rlghvirfEg4/pP/PIDiBmGOgcY+0njYEP/ulyKgxCLz4XxfNpE7nwAzLMunrPlkxnQASdDtFRVKmFviGHRdjec6vkiNr/OtqmulrkKn6dVG+EsD4pzYqwa6/KYvmwjsMFjkEM/6mcWtOHJzMnJd6/kfT4ksjJLm0YF8MN1IdtT59Y15i3ZB5ZufyvnIC2jQ2P/2a/CwFEyFqlQ9yNCPmI0xZ+Tm/99QagkutDtD4VWP19LmsUhZETWFL8WBFMm6OCkvbzcwnvHhdbPzn91IjJwkZ51LBUUuoWFE7IJkZ2dd72XOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HRR6j2O2EeJr4QICLyLkDSC0CZxVoX4BMUNYPfD06RY=;
 b=nCzL2IcW4qfaqbt7BugPk0qjaZA8RDxjW62Fl72RBMh4C+t2GbbPnAot0dIln+ZyE2KUR5IPeN8+ORWxEsY+OUMWlWn7+VfjNkQkaWKOl03b4n/AjTWF9rP5S8CUxaUKbbhwHpckdCBk1oRMfDLUCcmCL3Xfvp9kIv6Er9QSoR4CPBJ2H+xRO0Xtnt142Vef4DzgRGgl2nsMLrpZghLBVkdsdPuYDgkuxO6xGTimLK53ynwX+oyySu0uNb0AWMRjbgVTotmg5F8yXc9/AMSiNFWoCKYE8n9A+lZTQs9jnMp2IYsnKgWlYnZt/3hrmy3Zv1mFP+w9yV7l9vyIvBMEWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PAVPR08MB8992.eurprd08.prod.outlook.com (2603:10a6:102:325::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Thu, 4 Sep
 2025 14:23:47 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9094.017; Thu, 4 Sep 2025
 14:23:47 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Ray Liu <ray.liu@airoha.com>,
	Mark Brown <broonie@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andreas Gnau <andreas.gnau@iopsys.eu>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH RESEND v5 00/13] spi: airoha: driver fixes & improvements
Date: Thu,  4 Sep 2025 17:23:26 +0300
Message-ID: <20250904142339.656346-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3P280CA0047.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:9::15) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PAVPR08MB8992:EE_
X-MS-Office365-Filtering-Correlation-Id: 273f755c-c0f6-4e5c-abee-08ddebbea91f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jsJ1wBI2gXhp8zYnyJbir3GZeQB1JCKsnMnR7afeyXa/zd2tW/zNePAxVHAN?=
 =?us-ascii?Q?UZ30efq6Bzh4425ponzD/N7UIJ/Sd87uYlJqJ08044vEdXvdK/cwYtBk4wJo?=
 =?us-ascii?Q?WpI7DtRweaRdm9RGUJyFpnAPOwQwrrZTuCGn1GdQ96N4yGq7B4ZPSDpla+Hc?=
 =?us-ascii?Q?QpdyMKZbHb3PNjE0zhNuEDOgGSTEk6zDU2XjiCNQRrnhtQ6YwGGFQJ7ucY2D?=
 =?us-ascii?Q?Ldj+qI4beRfqW5g70YPo0m4I+PeAGjvIfwRorhGitJskBMnqbEuQaeoMkLbM?=
 =?us-ascii?Q?H5dwD9jfGVXJL6syOL7VkKJHJpYqFuilwGXoluNOFaDtv7zbLhvTaXP33x/i?=
 =?us-ascii?Q?9QENu0Fr94YSz2LvVyKiXvmLybyIzjdpwOOo9ukBl3Fyog26GMQcZnQlj6Kl?=
 =?us-ascii?Q?ncBegQMejPWhoxbtdQmogZmYNDHcwCWDNA1ZeSjcUFsMs7roVvw4LMoilY4t?=
 =?us-ascii?Q?ZcuA6pTKTeQZ7mo1SL2Js/I6kGDPh0EF8E2Via4U8gBQkG4NoLL6E7NzNoDl?=
 =?us-ascii?Q?kn/h4KdGUI/YntPSbA6jcn/u6rLHF0/YQU7Cxidpzv6yNX2Q214gXDoQSLR/?=
 =?us-ascii?Q?VJvupaV7JAYJ13PersCkN0ujB0uwes3uGZ6pL6Zm0JSkmRugupiApRjqFPYV?=
 =?us-ascii?Q?IJV/0X1sDgewTjtOsxxp/mkim1GhYQ9erqhPpT+Ig/BuWCx9EJYY7cz7FxM8?=
 =?us-ascii?Q?KYqYepCTcmLCk9kKbZOQ45IHCj6HlPZtx6Nu07yVVuCEjbFW5/o1J53Ac7Sm?=
 =?us-ascii?Q?kmR0eAk2CmZRpmqe7F9aQ3IY/YWEFW/e23yU7svQY8NgU2CG8F0e//+soCO5?=
 =?us-ascii?Q?dH1881q3uqXrI45sKH4E1Zbia2EZ4BC3q8JwoV/vlvwQqXpx0/MpLoBIuM4O?=
 =?us-ascii?Q?bUcj4Og6Pgkf3Irz899vogQS2XmkIQ/TgYjYOanJPqDW8LSjcEKY5sRTF7Dv?=
 =?us-ascii?Q?oZrgrTTi7/9n104VWdwhisYTkH5G/vxvDgR5hsguJPQYOIezEy8NziSxZabr?=
 =?us-ascii?Q?iICybDeHkRcv55925lxTMoGXq0UhTvBa5kfWBaJdxOk3wL/UBUHQdJzQ/EF/?=
 =?us-ascii?Q?eVBZtYXtUVNKcw5urFIDDTBp8Xy9y5SwmcCHe7F04qyWaDMkdcP55dJxzvK/?=
 =?us-ascii?Q?SYso3nGZ8MA4N0pDX02iovaFRc5FPB+7DXXUn8eqUVSJnIftmCkThjAzVpFP?=
 =?us-ascii?Q?PLirtV9H8XZj6GUxuJ+SheEJuFD5m/jbWYZzl2lagIaMG7izXK1gqxeMArxR?=
 =?us-ascii?Q?0pGs84lSh3rqZgcsGZLBceU0ap8aXFZDyz3n8pJtlaCZEOAWNLPaNMdf1pYF?=
 =?us-ascii?Q?1SIejnTsa2JDKw2BmdP7m+kffODE3gUInE4SiuiSIyDGgvKIHU3QUR8Y4Zbj?=
 =?us-ascii?Q?7a019gs9kIf/31WF3Uoqo6E1STjKxU/uil+1aI30NRtyaZPF46dt+0RP7eXO?=
 =?us-ascii?Q?ka/0e7cYcSZ3IcpLt+dqPL86fGM2mSfDYFPTyVQcH0XyA2SxoGTTKw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nY03dpEu2FORJttihhVv//h83sFVYwglgtM4amqbh968Q8trY5C+WgAowB5E?=
 =?us-ascii?Q?WlsBK2ib8KKvAkooSiDFUw+R6SzdP4h5+KcRmHcdnAGjZBHF4yBjo10NpukL?=
 =?us-ascii?Q?WE5dhLyw74/hhZIZ6lTlT7fSlRkI67akdj3Q4yVu9I1YLnXRej17Xfmc4qTK?=
 =?us-ascii?Q?reVfVRZwgB2ybKcVupZad2U+4BlFhfyb2L+R6c1H5riXdBx2Yy/Fk3lJ415C?=
 =?us-ascii?Q?UYc39pGnabUHBVYVWI+LaamzhwwD4RJdbfoR4hVbXYQvzpOob6zdlJDqUFCk?=
 =?us-ascii?Q?oc7a3mcGSWiYFznVmrHmd4seDrNMCXkJ0bguEBWoWLg0+zrjavTN2C/3ZhPq?=
 =?us-ascii?Q?RCY7QJLk+lS+mkeuwSAphMXu4dAQSYwlqcRPeeBFw9UKMNqra6eMFyHrCDJP?=
 =?us-ascii?Q?Ri3nvPc9sGLqU+d29xjRVe7pcsX1feuigBk9t+JLEIcyCGi78JWH8jEoFcKi?=
 =?us-ascii?Q?RVW56ZG/FTrkj5jGvfzA/x2C2zxg+mOGOB6VqoEENQAIUuKqDl8IBdYcP/cK?=
 =?us-ascii?Q?uVdNqiIdgrTMhsnafwipvC43hg009Y8xvlYuDWgVhBDxemlPBPc3Jr9Bk01O?=
 =?us-ascii?Q?WeRyjrCDaTYu0r4rf9p60355zBuzUYV1X2MnzbMK7I2nqkOj1QK+N6TErGlv?=
 =?us-ascii?Q?FYdoRJU+n74fH3ad4Ct0bzP6No4xobsu3i04pBv/Aiz6Tp2Q/Bn7KsKWid0H?=
 =?us-ascii?Q?QVLalU+6nMKoksBofY+chX12QsEzoB7VAjglEE74+IG/cGKlzvHjtEaAXZpR?=
 =?us-ascii?Q?SHSdBmbdqTfxKDTif/vJyE0j2HhKK/RV29QdZ2rsx2Iqkhsl9BihiLDhl/IZ?=
 =?us-ascii?Q?v/l+jqtLeLrJqMCQwFuczkGzTCwJVqpXrm3Mf5AHwfpguod7+/+N6G0289TC?=
 =?us-ascii?Q?ZGo6qicRkhJurWeYieO21+RYdObGYe9so91PCXImBRSauwh547viNYVPAo0J?=
 =?us-ascii?Q?VqcvyIJKZp1ASGSrY3W3O1o0mF7yYhrzcuJ+J6wIidjXtVGDqwZZjPVP6xil?=
 =?us-ascii?Q?fQbnjBrsKuS/FTKxy/JULZMvhNAkjMQDSF9mEEs1jL72B2b1zJIinLT91gaJ?=
 =?us-ascii?Q?wKszuaRHqNn8/S9AGA2Q/UkB3vY1q07EHyBDCo5JtMBnb67fyszKYJg1sqIA?=
 =?us-ascii?Q?CTB2pp4lWrgPk4Wr7IVP3gwmQQ+c3wtmpvoz+0KWSVj3rKmhySUiTg+qm+Tk?=
 =?us-ascii?Q?/obZj0cPP4SD8KkSNe1ecTJn/yzv/C6Sp/Z+VLcuID2lCy9bnj9yQfYMUA5K?=
 =?us-ascii?Q?meH7+ywZzPrShPOzIuwtsQMxEJZmB2DD0pdmJoKGPRfv5DouwAcDsnURN2En?=
 =?us-ascii?Q?K5wxwJrPJS+HNojGIom6soEA02GnGchbo3nWajEJi12s3CJVdXPP1u/HEAiY?=
 =?us-ascii?Q?0UbJueLBPF4DMggohSVCHTn4Ry/cW+9hmxK7DSZO7pim8QxlJT6O1JfgiWR+?=
 =?us-ascii?Q?ENBV91hylpfdGGxlZ5/i67z0YEchO6ssbTAXzgFI0be3rNDkMjpINPq3MrnX?=
 =?us-ascii?Q?pDj1FZMlvSnkD4+D2pC8zXGRrYYXFfpOzaOK0DHsiwnse256R+f/byAGwDYc?=
 =?us-ascii?Q?lIyp7WluORi2LvpHJHGenQH0G/q4nzQAZmgTRYaS3vtXduPuAorNe36BvI8q?=
 =?us-ascii?Q?lzSk5XnkXYwY1OEcaLtWwLM=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 273f755c-c0f6-4e5c-abee-08ddebbea91f
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 14:23:47.3862
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fRvIBcDN+xRqgQygkQOjrrD5cqamqYdLeHJgoNug3Pa7iTxk9ZlVoflMudT+xxf79sBPFh0Itap0+XsqtjzymWkmhMBsaHn244IoeqdxrV8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB8992

This patch series greatly improve airoha snfi driver and fix a
number of serious bugs.

Fixed bugs:
 * Fix reading/writing of flashes with more than one plane per lun
 * Fill the buffer with 0xff before writing
 * Fix reading of flashes supporting continuous reading mode
 * Fix error paths

Improvements:
 * Add support of dual/quad wires spi modes in exec_op(). This also
   fix flash reading/writing if dirmap can't be created.
 * Support of dualio/quadio flash reading commands
 * Remove dirty hack that reads flash page settings from SNFI registers
   during driver startup

Patched kernel tests:

    root@OpenWrt:/lib/modules/6.6.79# insmod mtd_oobtest.ko dev=1
    [  263.191711] 
    [  263.193218] =================================================
    [  263.199014] mtd_oobtest: MTD device: 1
    [  263.202768] mtd_oobtest: MTD device size 268304384, eraseblock size 131072, page size 2048, count of eraseblocks 2047, pages per eraseblock 64, OOB size 128
    [  263.216791] mtd_test: scanning for bad eraseblocks
    [  263.221956] mtd_test: scanned 2047 eraseblocks, 0 are bad
    [  263.227361] mtd_oobtest: test 1 of 5
    [  265.077216] mtd_oobtest: writing OOBs of whole device
    [  265.121767] mtd_oobtest: written up to eraseblock 0
    [  275.174147] mtd_oobtest: written up to eraseblock 256
    [  285.210279] mtd_oobtest: written up to eraseblock 512
    [  295.241724] mtd_oobtest: written up to eraseblock 768
    [  305.280167] mtd_oobtest: written up to eraseblock 1024
    [  315.326883] mtd_oobtest: written up to eraseblock 1280
    [  325.364049] mtd_oobtest: written up to eraseblock 1536
    [  335.398609] mtd_oobtest: written up to eraseblock 1792
    [  345.358981] mtd_oobtest: written 2047 eraseblocks
    [  345.363694] mtd_oobtest: verifying all eraseblocks
    [  345.386088] mtd_oobtest: verified up to eraseblock 0
    [  349.830833] mtd_oobtest: verified up to eraseblock 256
    [  354.276245] mtd_oobtest: verified up to eraseblock 512
    [  358.721496] mtd_oobtest: verified up to eraseblock 768
    [  363.166881] mtd_oobtest: verified up to eraseblock 1024
    [  367.612694] mtd_oobtest: verified up to eraseblock 1280
    [  372.058211] mtd_oobtest: verified up to eraseblock 1536
    [  376.503820] mtd_oobtest: verified up to eraseblock 1792
    [  380.914843] mtd_oobtest: verified 2047 eraseblocks
    [  380.919660] mtd_oobtest: test 2 of 5
    [  384.202620] mtd_oobtest: writing OOBs of whole device
    [  384.247584] mtd_oobtest: written up to eraseblock 0
    [  394.305121] mtd_oobtest: written up to eraseblock 256
    [  404.342199] mtd_oobtest: written up to eraseblock 512
    [  414.374204] mtd_oobtest: written up to eraseblock 768
    [  424.409891] mtd_oobtest: written up to eraseblock 1024
    [  434.453378] mtd_oobtest: written up to eraseblock 1280
    [  444.494321] mtd_oobtest: written up to eraseblock 1536
    [  454.534480] mtd_oobtest: written up to eraseblock 1792
    [  464.490962] mtd_oobtest: written 2047 eraseblocks
    [  464.495681] mtd_oobtest: verifying all eraseblocks
    [  464.518015] mtd_oobtest: verified up to eraseblock 0
    [  468.955635] mtd_oobtest: verified up to eraseblock 256
    [  473.395502] mtd_oobtest: verified up to eraseblock 512
    [  477.834373] mtd_oobtest: verified up to eraseblock 768
    [  482.272717] mtd_oobtest: verified up to eraseblock 1024
    [  486.712148] mtd_oobtest: verified up to eraseblock 1280
    [  491.150704] mtd_oobtest: verified up to eraseblock 1536
    [  495.589439] mtd_oobtest: verified up to eraseblock 1792
    [  499.993138] mtd_oobtest: verified 2047 eraseblocks
    [  499.997951] mtd_oobtest: test 3 of 5
    [  503.404228] mtd_oobtest: writing OOBs of whole device
    [  503.448822] mtd_oobtest: written up to eraseblock 0
    [  513.480773] mtd_oobtest: written up to eraseblock 256
    [  523.489361] mtd_oobtest: written up to eraseblock 512
    [  533.506896] mtd_oobtest: written up to eraseblock 768
    [  543.506268] mtd_oobtest: written up to eraseblock 1024
    [  553.506503] mtd_oobtest: written up to eraseblock 1280
    [  563.511266] mtd_oobtest: written up to eraseblock 1536
    [  573.519567] mtd_oobtest: written up to eraseblock 1792
    [  583.455111] mtd_oobtest: written 2047 eraseblocks
    [  583.459837] mtd_oobtest: verifying all eraseblocks
    [  583.499358] mtd_oobtest: verified up to eraseblock 0
    [  592.382953] mtd_oobtest: verified up to eraseblock 256
    [  601.267297] mtd_oobtest: verified up to eraseblock 512
    [  610.150907] mtd_oobtest: verified up to eraseblock 768
    [  619.034702] mtd_oobtest: verified up to eraseblock 1024
    [  627.919683] mtd_oobtest: verified up to eraseblock 1280
    [  636.821168] mtd_oobtest: verified up to eraseblock 1536
    [  645.705487] mtd_oobtest: verified up to eraseblock 1792
    [  654.520336] mtd_oobtest: verified 2047 eraseblocks
    [  654.525134] mtd_oobtest: test 4 of 5
    [  657.578146] mtd_oobtest: attempting to start write past end of OOB
    [  657.584336] mtd_oobtest: an error is expected...
    [  657.588974] mtd_oobtest: error occurred as expected
    [  657.593848] mtd_oobtest: attempting to start read past end of OOB
    [  657.599953] mtd_oobtest: an error is expected...
    [  657.604569] mtd_oobtest: error occurred as expected
    [  657.609450] mtd_oobtest: attempting to write past end of device
    [  657.615367] mtd_oobtest: an error is expected...
    [  657.619990] mtd_oobtest: error occurred as expected
    [  657.624864] mtd_oobtest: attempting to read past end of device
    [  657.630715] mtd_oobtest: an error is expected...
    [  657.635333] mtd_oobtest: error occurred as expected
    [  657.641043] mtd_oobtest: attempting to write past end of device
    [  657.646966] mtd_oobtest: an error is expected...
    [  657.651574] mtd_oobtest: error occurred as expected
    [  657.656451] mtd_oobtest: attempting to read past end of device
    [  657.662277] mtd_oobtest: an error is expected...
    [  657.666901] mtd_oobtest: error occurred as expected
    [  657.671774] mtd_oobtest: test 5 of 5
    [  659.382333] mtd_oobtest: writing OOBs of whole device
    [  659.388056] mtd_oobtest: written up to eraseblock 0
    [  659.393526] mtd_oobtest: written up to eraseblock 0
    [  659.704525] mtd_oobtest: written up to eraseblock 256
    [  659.710187] mtd_oobtest: written up to eraseblock 256
    [  660.021093] mtd_oobtest: written up to eraseblock 512
    [  660.026752] mtd_oobtest: written up to eraseblock 512
    [  660.338427] mtd_oobtest: written up to eraseblock 768
    [  660.344048] mtd_oobtest: written up to eraseblock 768
    [  660.655718] mtd_oobtest: written up to eraseblock 1024
    [  660.661462] mtd_oobtest: written up to eraseblock 1024
    [  660.970676] mtd_oobtest: written up to eraseblock 1280
    [  660.976386] mtd_oobtest: written up to eraseblock 1280
    [  661.286858] mtd_oobtest: written up to eraseblock 1536
    [  661.292587] mtd_oobtest: written up to eraseblock 1536
    [  661.605397] mtd_oobtest: written up to eraseblock 1792
    [  661.611142] mtd_oobtest: written up to eraseblock 1792
    [  661.918754] mtd_oobtest: written 2046 eraseblocks
    [  661.923458] mtd_oobtest: verifying all eraseblocks
    [  661.928812] mtd_oobtest: verified up to eraseblock 0
    [  662.072499] mtd_oobtest: verified up to eraseblock 256
    [  662.216152] mtd_oobtest: verified up to eraseblock 512
    [  662.359956] mtd_oobtest: verified up to eraseblock 768
    [  662.503238] mtd_oobtest: verified up to eraseblock 1024
    [  662.646847] mtd_oobtest: verified up to eraseblock 1280
    [  662.790603] mtd_oobtest: verified up to eraseblock 1536
    [  662.934269] mtd_oobtest: verified up to eraseblock 1792
    [  663.076329] mtd_oobtest: verified 2046 eraseblocks
    [  663.081114] mtd_oobtest: finished with 0 errors
    [  663.085647] =================================================

    root@OpenWrt:/lib/modules/6.6.79# insmod  mtd_pagetest.ko dev=1
    [ 1142.213082] 
    [ 1142.214590] =================================================
    [ 1142.220433] mtd_pagetest: MTD device: 1
    [ 1142.224278] mtd_pagetest: MTD device size 268304384, eraseblock size 131072, page size 2048, count of eraseblocks 2047, pages per eraseblock 64, OOB size 128
    [ 1142.238388] mtd_test: scanning for bad eraseblocks
    [ 1142.243536] mtd_test: scanned 2047 eraseblocks, 0 are bad
    [ 1142.248935] mtd_pagetest: erasing whole device
    [ 1143.962562] mtd_pagetest: erased 2047 eraseblocks
    [ 1143.967301] mtd_pagetest: writing whole device
    [ 1144.011729] mtd_pagetest: written up to eraseblock 0
    [ 1154.137933] mtd_pagetest: written up to eraseblock 256
    [ 1164.265201] mtd_pagetest: written up to eraseblock 512
    [ 1174.393365] mtd_pagetest: written up to eraseblock 768
    [ 1184.525700] mtd_pagetest: written up to eraseblock 1024
    [ 1194.650920] mtd_pagetest: written up to eraseblock 1280
    [ 1204.773676] mtd_pagetest: written up to eraseblock 1536
    [ 1214.896934] mtd_pagetest: written up to eraseblock 1792
    [ 1224.942600] mtd_pagetest: written 2047 eraseblocks
    [ 1224.947410] mtd_pagetest: verifying all eraseblocks
    [ 1225.053133] mtd_pagetest: verified up to eraseblock 0
    [ 1250.760034] mtd_pagetest: verified up to eraseblock 256
    [ 1276.448242] mtd_pagetest: verified up to eraseblock 512
    [ 1302.138825] mtd_pagetest: verified up to eraseblock 768
    [ 1327.824020] mtd_pagetest: verified up to eraseblock 1024
    [ 1353.532178] mtd_pagetest: verified up to eraseblock 1280
    [ 1379.234385] mtd_pagetest: verified up to eraseblock 1536
    [ 1404.943865] mtd_pagetest: verified up to eraseblock 1792
    [ 1430.468816] mtd_pagetest: verified 2047 eraseblocks
    [ 1430.473702] mtd_pagetest: crosstest
    [ 1430.477717] mtd_pagetest: reading page at 0x0
    [ 1430.482328] mtd_pagetest: reading page at 0xffdf800
    [ 1430.487469] mtd_pagetest: reading page at 0x0
    [ 1430.492084] mtd_pagetest: verifying pages read at 0x0 match
    [ 1430.497668] mtd_pagetest: crosstest ok
    [ 1430.501409] mtd_pagetest: erasecrosstest
    [ 1430.505323] mtd_pagetest: erasing block 0
    [ 1430.511511] mtd_pagetest: writing 1st page of block 0
    [ 1430.517166] mtd_pagetest: reading 1st page of block 0
    [ 1430.522505] mtd_pagetest: verifying 1st page of block 0
    [ 1430.527739] mtd_pagetest: erasing block 0
    [ 1430.532565] mtd_pagetest: writing 1st page of block 0
    [ 1430.538229] mtd_pagetest: erasing block 2046
    [ 1430.544181] mtd_pagetest: reading 1st page of block 0
    [ 1430.549498] mtd_pagetest: verifying 1st page of block 0
    [ 1430.554718] mtd_pagetest: erasecrosstest ok
    [ 1430.558900] mtd_pagetest: erasetest
    [ 1430.562381] mtd_pagetest: erasing block 0
    [ 1430.567208] mtd_pagetest: writing 1st page of block 0
    [ 1430.572858] mtd_pagetest: erasing block 0
    [ 1430.577680] mtd_pagetest: reading 1st page of block 0
    [ 1430.582990] mtd_pagetest: verifying 1st page of block 0 is all 0xff
    [ 1430.589279] mtd_pagetest: erasetest ok
    [ 1430.593023] mtd_pagetest: finished with 0 errors
    [ 1430.597651] =================================================

    root@OpenWrt:/lib/modules/6.6.79# insmod  mtd_readtest.ko dev=1
    [ 1478.691648] 
    [ 1478.693158] =================================================
    [ 1478.698981] mtd_readtest: MTD device: 1
    [ 1478.702829] mtd_readtest: MTD device size 268304384, eraseblock size 131072, page size 2048, count of eraseblocks 2047, pages per eraseblock 64, OOB size 128
    [ 1478.716939] mtd_test: scanning for bad eraseblocks
    [ 1478.722072] mtd_test: scanned 2047 eraseblocks, 0 are bad
    [ 1478.727475] mtd_readtest: testing page read
    [ 1548.352125] mtd_readtest: finished
    [ 1548.355553] =================================================

    root@OpenWrt:/lib/modules/6.6.79# insmod  mtd_speedtest.ko dev=1
    [ 1617.353002] 
    [ 1617.354511] =================================================
    [ 1617.360332] mtd_speedtest: MTD device: 1
    [ 1617.364258] mtd_speedtest: MTD device size 268304384, eraseblock size 131072, page size 2048, count of eraseblocks 2047, pages per eraseblock 64, OOB size 128
    [ 1617.380150] mtd_test: scanning for bad eraseblocks
    [ 1617.385428] mtd_test: scanned 2047 eraseblocks, 0 are bad
    [ 1621.021861] mtd_speedtest: testing eraseblock write speed
    [ 1700.915306] mtd_speedtest: eraseblock write speed is 3279 KiB/s
    [ 1700.921250] mtd_speedtest: testing eraseblock read speed
    [ 1734.931886] mtd_speedtest: eraseblock read speed is 7705 KiB/s
    [ 1738.682742] mtd_speedtest: testing page write speed
    [ 1818.818644] mtd_speedtest: page write speed is 3269 KiB/s
    [ 1818.824058] mtd_speedtest: testing page read speed
    [ 1852.913595] mtd_speedtest: page read speed is 7687 KiB/s
    [ 1856.674492] mtd_speedtest: testing 2 page write speed
    [ 1936.437284] mtd_speedtest: 2 page write speed is 3285 KiB/s
    [ 1936.442869] mtd_speedtest: testing 2 page read speed
    [ 1970.498124] mtd_speedtest: 2 page read speed is 7694 KiB/s
    [ 1970.503624] mtd_speedtest: Testing erase speed
    [ 1974.343389] mtd_speedtest: erase speed is 68316 KiB/s
    [ 1974.348479] mtd_speedtest: Testing 2x multi-block erase speed
    [ 1976.068855] mtd_speedtest: 2x multi-block erase speed is 152811 KiB/s
    [ 1976.075309] mtd_speedtest: Testing 4x multi-block erase speed
    [ 1977.790232] mtd_speedtest: 4x multi-block erase speed is 153301 KiB/s
    [ 1977.796693] mtd_speedtest: Testing 8x multi-block erase speed
    [ 1979.511905] mtd_speedtest: 8x multi-block erase speed is 153273 KiB/s
    [ 1979.518367] mtd_speedtest: Testing 16x multi-block erase speed
    [ 1981.230700] mtd_speedtest: 16x multi-block erase speed is 153539 KiB/s
    [ 1981.237249] mtd_speedtest: Testing 32x multi-block erase speed
    [ 1982.948381] mtd_speedtest: 32x multi-block erase speed is 153648 KiB/s
    [ 1982.954918] mtd_speedtest: Testing 64x multi-block erase speed
    [ 1984.665992] mtd_speedtest: 64x multi-block erase speed is 153655 KiB/s
    [ 1984.672531] mtd_speedtest: finished
    [ 1984.676054] =================================================

    root@OpenWrt:/lib/modules/6.6.79# insmod mtd_stresstest.ko dev=1
    [ 2190.651750] 
    [ 2190.653263] =================================================
    [ 2190.659087] mtd_stresstest: MTD device: 1
    [ 2190.663105] mtd_stresstest: MTD device size 268304384, eraseblock size 131072, page size 2048, count of eraseblocks 2047, pages per eraseblock 64, OOB size 128
    [ 2190.679846] mtd_test: scanning for bad eraseblocks
    [ 2190.684981] mtd_test: scanned 2047 eraseblocks, 0 are bad
    [ 2190.690389] mtd_stresstest: doing operations
    [ 2190.694655] mtd_stresstest: 0 operations done
    [ 2214.262705] mtd_stresstest: 1024 operations done
    [ 2239.019612] mtd_stresstest: 2048 operations done
    [ 2262.820899] mtd_stresstest: 3072 operations done
    [ 2285.061376] mtd_stresstest: 4096 operations done
    [ 2308.297322] mtd_stresstest: 5120 operations done
    [ 2330.530459] mtd_stresstest: 6144 operations done
    [ 2352.651759] mtd_stresstest: 7168 operations done
    [ 2375.188275] mtd_stresstest: 8192 operations done
    [ 2397.738174] mtd_stresstest: 9216 operations done
    [ 2414.792572] mtd_stresstest: finished, 10000 operations done
    [ 2414.798257] =================================================

Speed test of original driver (with patch to fix support of flashes
with more than one plane per lun)

    root@OpenWrt:/lib/modules/6.6.79# insmod  mtd_speedtest.ko dev=1
    [ 2894.142208] 
    [ 2894.143719] =================================================
    [ 2894.149556] mtd_speedtest: MTD device: 1
    [ 2894.153486] mtd_speedtest: MTD device size 268304384, eraseblock size 131072, page size 2048, count of eraseblocks 2047, pages per eraseblock 64, OOB size 128
    [ 2894.168888] mtd_test: scanning for bad eraseblocks
    [ 2894.174023] mtd_test: scanned 2047 eraseblocks, 0 are bad
    [ 2897.500416] mtd_speedtest: testing eraseblock write speed
    [ 2977.807233] mtd_speedtest: eraseblock write speed is 3262 KiB/s
    [ 2977.813171] mtd_speedtest: testing eraseblock read speed
    [ 3013.906597] mtd_speedtest: eraseblock read speed is 7260 KiB/s
    [ 3017.440320] mtd_speedtest: testing page write speed
    [ 3097.833394] mtd_speedtest: page write speed is 3259 KiB/s
    [ 3097.838812] mtd_speedtest: testing page read speed
    [ 3134.004981] mtd_speedtest: page read speed is 7245 KiB/s
    [ 3137.538423] mtd_speedtest: testing 2 page write speed
    [ 3217.906288] mtd_speedtest: 2 page write speed is 3260 KiB/s
    [ 3217.911883] mtd_speedtest: testing 2 page read speed
    [ 3254.049757] mtd_speedtest: 2 page read speed is 7251 KiB/s
    [ 3254.055254] mtd_speedtest: Testing erase speed
    [ 3257.599146] mtd_speedtest: erase speed is 74027 KiB/s
    [ 3257.604213] mtd_speedtest: Testing 2x multi-block erase speed
    [ 3259.320945] mtd_speedtest: 2x multi-block erase speed is 153139 KiB/s
    [ 3259.327413] mtd_speedtest: Testing 4x multi-block erase speed
    [ 3261.044585] mtd_speedtest: 4x multi-block erase speed is 153098 KiB/s
    [ 3261.051047] mtd_speedtest: Testing 8x multi-block erase speed
    [ 3262.786520] mtd_speedtest: 8x multi-block erase speed is 151479 KiB/s
    [ 3262.792979] mtd_speedtest: Testing 16x multi-block erase speed
    [ 3264.509898] mtd_speedtest: 16x multi-block erase speed is 153130 KiB/s
    [ 3264.516454] mtd_speedtest: Testing 32x multi-block erase speed
    [ 3266.233403] mtd_speedtest: 32x multi-block erase speed is 153125 KiB/s
    [ 3266.239961] mtd_speedtest: Testing 64x multi-block erase speed
    [ 3267.957985] mtd_speedtest: 64x multi-block erase speed is 153029 KiB/s
    [ 3267.964525] mtd_speedtest: finished
    [ 3267.968039] =================================================

It looks like a patched driver is a bit faster

write speed: 3260 KiB/s  vs  3277 KiB/s
read speed:  7252 KiB/s  vs  7695 KiB/s

Changes v2:
 * minor fix
 * add comments to code

Changes v3:
 * add patch to prevent continuous reading

Changes v4:
 * removed non-needed patch, other patch was a bit updated
 * treat zero buswidth as single wire buswidth (thanks to Jyothi Kumar Seerapu)
 * changes were tested with linux
 * test results was added

Changes v5:
 * reorder patches a bit
 * improve description of some patches
 * minor fixes & improvements

Mikhail Kshevetskiy (13):
  spi: airoha: return an error for continuous mode dirmap creation cases
  spi: airoha: remove unnecessary restriction length
  spi: airoha: add support of dual/quad wires spi modes to exec_op()
    handler
  spi: airoha: remove unnecessary switch to non-dma mode
  spi: airoha: switch back to non-dma mode in the case of error
  spi: airoha: fix reading/writing of flashes with more than one plane
    per lun
  spi: airoha: unify dirmap read/write code
  spi: airoha: support of dualio/quadio flash reading commands
  spi: airoha: avoid setting of page/oob sizes in REG_SPI_NFI_PAGEFMT
  spi: airoha: reduce the number of modification of REG_SPI_NFI_CNFG and
    REG_SPI_NFI_SECCUS_SIZE registers
  spi: airoha: set custom sector size equal to flash page size
  spi: airoha: avoid reading flash page settings from SNFI registers
    during driver startup
  spi: airoha: buffer must be 0xff-ed before writing

 drivers/spi/spi-airoha-snfi.c | 510 ++++++++++++++++++----------------
 1 file changed, 263 insertions(+), 247 deletions(-)

-- 
2.50.1


