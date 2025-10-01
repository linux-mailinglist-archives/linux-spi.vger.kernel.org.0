Return-Path: <linux-spi+bounces-10407-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB089BB1F6E
	for <lists+linux-spi@lfdr.de>; Thu, 02 Oct 2025 00:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85E231684D4
	for <lists+linux-spi@lfdr.de>; Wed,  1 Oct 2025 22:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2117226F2BF;
	Wed,  1 Oct 2025 22:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="skt/8yi7"
X-Original-To: linux-spi@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020102.outbound.protection.outlook.com [52.101.69.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC1C1EA65;
	Wed,  1 Oct 2025 22:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759357441; cv=fail; b=gZ9etqMm8IKqCNrgZjaFw90sJfUsbH5JpeKDyyespdc6e0nY8hQcrlmbgv2QeGCgjrmQbBjEg/7I8Y3uostjgoBJSqA4Mxr2COoyc2VM/uFWha9VPLUlkucVnw86axUmA/XHEFn66NVhFVPrOArvdvzCI5gbyjlS+rf+GEmsbz0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759357441; c=relaxed/simple;
	bh=zKuaIVl+dFYMgC5wGe37yvyZUhUYtucbZojvr88bNc0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=PFt3djadyu4qbfoO9P22TORhmqFTXcg7Qwbvqk0fNGzAA8o+d4NKabN05HO5IxCXmRxnWCjcH3uupL6w2nn3Aob88w+xoC2lYmAkL6U1dx1vFdoK2hPL0EueGkekoxohkP6ZWXtNCm4K2Bvibak6eSzyJ6H5teLlMy63YqyxOBU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=skt/8yi7; arc=fail smtp.client-ip=52.101.69.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LptklT6m5UqU3jNDJil76ajcAAcoMAycMmVqBmqtuPnkjJgGI7WISeN4u0yVzWYSPnhIkgTcecr3yx/WGDoRuB8c2i5Nkvb+1jQ86oQ6g8H3ZdsuJu2I/CC2huywglYwV5k0lqFw9/CA/1BzcnrDkeK4T0NCfW73ciwrNrPFTyv8JqNJGEn++vGDT1zqvDTZj42sN9nj4zP0CcL5hK6VMqRyK5oH5lRFDLLiZJ7OpIu16Lmfb1ohaUWNNobKpTyijcJuUpFdudS+Ph3sJOuxjUBOLTfIrp+yM7KGevySkUEnhQ77kLUEwi5byPQMYy5UkHVAZjT7SqT02KvNFjON9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h+pEd78DegUA2FrIw6U2SDhIJPkBIlBQ2reQQ8mTLUQ=;
 b=HTTn2OfzWeuPTChc+AhqI72coMLdS3ujl76riYG7Rzpp93cgfwqv4AoEG2SnA8FhAdODuYO5mzaouUOzS+Lp79jWk+Yn+dqox20NCdfWqamjvw1kh1AZeM4dapcTcDpKo6Jnwm1VBtDTCBo4LLx+joUH+nlB8y9R8czGYNe+09vk2HZHUshn6V+5zF1HN79aqcJthtBApmDMCXtw2prXVKVze8/l52/P6hYm3e1gV6sqlRalLjvQ+45+mCLxMJuqIjCBOuCIcUvBoW0iJdIy1XmRchyf8HfAPTp4JFSf/AmZbdS1caPbglgNbUSooCJ3CM4tAJA+0GrnS+fJEKTb6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h+pEd78DegUA2FrIw6U2SDhIJPkBIlBQ2reQQ8mTLUQ=;
 b=skt/8yi7/7Er1Vu1Em38CgTCHsbIwfZiFq6JGMbhBDcvFgMUvIu5cBLnIVP+It700UzcvKTO8W4NFwlgpXTZRAc8SoXITQlqvIZntXCN1d3A2cnfEdWYzWnZiMW21J/5pA3S/fccD/H/PBDyQo2XmdWMbCw1W8H++ver9bce78eVKtAlrMndthUlO10lZXwqhpR6vliIVgFKnpbINW3tR4X4yFx2a9u/7ZFlJ1UpLBvvwhrVlUDjTSwFIb9XNtUgYnsGzBDCa1EVSn0KB249ctx2Xd0OkS4atdlshK8Er6SvCLuKRz4Rw07Lxnh6TSJ1cAjFe4p0I83bGHRcU1/mkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PA4PR08MB6302.eurprd08.prod.outlook.com (2603:10a6:102:ed::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Wed, 1 Oct
 2025 22:23:54 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9160.017; Wed, 1 Oct 2025
 22:23:54 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Ray Liu <ray.liu@airoha.com>,
	Mark Brown <broonie@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
	Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH v6 00/13] spi: airoha: driver fixes & improvements
Date: Thu,  2 Oct 2025 01:23:33 +0300
Message-ID: <20251001222347.3386506-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0447.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::13) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PA4PR08MB6302:EE_
X-MS-Office365-Filtering-Correlation-Id: 2edee2f6-d7d8-4d65-7bf3-08de013934ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IJsiAI47GZCiyW4exqQ+wYMiKaHbe/kLuSOyOICaHmLkFQUTRjg9OS0iXnX6?=
 =?us-ascii?Q?GhVysaQZZ0BD4scbJnIDyLTG2SKADfLf6bI9d7GwlEPxpmXqllGDhAPch3V7?=
 =?us-ascii?Q?tCCmqgHojk2DBzZcLm1oDPFHfne0pE0+D/sGPj9nyTe5u4oOPYz/QqXuCABx?=
 =?us-ascii?Q?oo99pwxWoVYOFdA412UhGiRhDvifPtEFlKIgAQONJ0vvxyUEI/Hb45qSKMQ4?=
 =?us-ascii?Q?GvI361hVSilHOpjMULL8Lwcg6DMcp/7xDoskeJB4ZnuIrx5pSUOHmCtun1Tz?=
 =?us-ascii?Q?g5PazykwfajuyzMxXOpseyVj/OVN4E+KIOGPGh1g0fe658eMNQiO9GlVWNDt?=
 =?us-ascii?Q?OykOlVA57dLV1nAHKo/KCs8dpL4wysonutGgAmGnSSsIox5c07FKM3u62WNO?=
 =?us-ascii?Q?vpEY3Rc8uC4DMBpJuzoSz721Czm/ANv7lBPny6DOzojgh2PCmsFOo0DRQjVy?=
 =?us-ascii?Q?idSoVFvl7OWxYkWPQGzYeXZ1T+EmVV1GPrAgIjC01g94f+AtcS7X3AUy9s9b?=
 =?us-ascii?Q?c8ccXhIJutCFkpdpkmI+0PHIJw890uCKDGKuFhRTPvBx2ciNTwRbPCLYv0Uw?=
 =?us-ascii?Q?pTi7y5xuVP8WjihjWKDyAr/U+29M2twmfoRW58fczn1SP4LF2YOZw7xz9U5d?=
 =?us-ascii?Q?sTzejI2ILRjwsFTX62Yjd6SavZpVHmH5Te1edzdT93xbvT8cxaICCrNVc7gl?=
 =?us-ascii?Q?Vsq2E5JPy7Qgc0f5KGsHksUAUisNSpf2yUgv3jvRPqrNR4HqmWCkLzxdgKjX?=
 =?us-ascii?Q?po8RQUb2s3ySL8L7D1N9NDMGmyrFxSAgx2ofu7JqvV6262zmYw4VZu6liz8m?=
 =?us-ascii?Q?TthD0CRTXgqsKhOgqqXUe9ovuifgwI4aZF9t2h/5qTAIO1lF8Cah/H+79pil?=
 =?us-ascii?Q?r8h3xJKPdToI78mjctdgXIwRxcSquQnYCIXN/iRhYnPvGuMGb3P8VXTtb4f3?=
 =?us-ascii?Q?VBQx/apN1whAkHaV1X6bS1SYOUUac9LPwxCzdt9hvTzZ4pjMWS0tog74hDv5?=
 =?us-ascii?Q?0V2efUDUh4msFliT4cnd94s4PJ2ekhJ7STs4qorJ+zVzGPOT+iAPpQznZtGl?=
 =?us-ascii?Q?unKPmH5ZkwcVwUVViGcEL8Ukw8LH5ElpYqlajjY88NTbWc/yeftDbU0NJv4V?=
 =?us-ascii?Q?EyzeFv6yX/TIIpM9doDMRGZa9GgaYexlcX1rH58jfXA0CIuFQa3cxROpiO8B?=
 =?us-ascii?Q?dKOVzwNWCsUDLsp06lkwAa0knrECmV0KI0/Ktm3i/fBH1d8a/CwID/pNGXTI?=
 =?us-ascii?Q?+BTkVSTHvRqefvbjSJEKKBiQPF+uSQaJqRAEF4CrROfvIngbzhqMkhKOoDis?=
 =?us-ascii?Q?DKZmDX3wGLtxb94WJ3a+0j/XC76MRZCwGxFbKHbP/X0bAPR6PWWVIk7pi4bn?=
 =?us-ascii?Q?du+Kd8KLnx7bnb8loNgHATIgu+FsHah8LTbs0wLUxUIdDdwQOrqnWm7ouzrZ?=
 =?us-ascii?Q?W20OuQDEV+T4irlNpJk+8Zr0XFwBb8eunr2hD/tjYKPtNYANurmAt6cPm3LI?=
 =?us-ascii?Q?S22r+z5fXQHbHuruVmlX6uPQ7fADccUReAHK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?C7d/ckxClODRsTA8hRYr8IquHxtAeHQ1arKy+2EFNx63shzz+b8oAJIkl8GS?=
 =?us-ascii?Q?TdsTf7zZWY/bJivN7WUQShdflGCRiqif/basUiBOm1kueZyd3+p3Q1bxSAvh?=
 =?us-ascii?Q?PI3xt446502r6pIjBDmg+4yb8xNam0UxVWhhkn40og7hcJykv3FFVi0DjzQ4?=
 =?us-ascii?Q?YJsGCKwv0I8xD1SM8KTwRgiwt9eonpUq1UxhrXlQDqEICtamAYEipCuPjQp4?=
 =?us-ascii?Q?n1f15mR8doZ6bNAQZ0ZahOL6vOV0ZlvTEtakzJqG6ZZVIqgzadhYG2iwqoSG?=
 =?us-ascii?Q?BEtRRuxrTdvtzGu4pn8PEsa/hDuDNoXuLcGoJy8XpdxZ8tzSduPY/Q5GwbcT?=
 =?us-ascii?Q?aUGbTlgpL+O3LskF77KGGIIHUp9ZcPbGa7+226wfjflEtenB/LRSUq+bO2z6?=
 =?us-ascii?Q?icpN8dpbHg7yiMcAGGleOdx2G3vloDjSSqBntiPO77CGaWrTIewe33dGy8ov?=
 =?us-ascii?Q?H43QAHxo5RGwvbpFCXUh1XRCAScQzqS/cnS9r2si4t7NI9RuUHCcMHvRqkkB?=
 =?us-ascii?Q?uKbFX3ACuN7gZlxaLpY9Bxi5oMOWd9UhaXIV/aZGC3VqDDAe7yvPHU9bxH5g?=
 =?us-ascii?Q?gWbVDTVxmFEjtKtbwAmbaKwdZwDGpBttUyb2AQfQY+lpeseu3O1OJiuJ2t6s?=
 =?us-ascii?Q?BaVXeu1MOFFHWHTZ8gQcwsTcJQ1m1DSICQCUi/Q7i62BTgG32lk1RRCZM10e?=
 =?us-ascii?Q?63bXEj13e3QVwpAlZwblBmB8137JgQ0PV44E/n2Rr9IHkcc3ZHCDGBG5WpMJ?=
 =?us-ascii?Q?PwLMjobnImraM8pvOexG4VG+o6psMh28fWuAxfrwFqRwRSXhRNHLjxcULPLE?=
 =?us-ascii?Q?61hLZ+FQt4mFNkzpxlNXnPzBZE1lRggZMXU2DhBQFzQuQaXm3QnBZubf2hQo?=
 =?us-ascii?Q?delbfwxXnQy5/jq0OPtk5L8LDSs/bUcQ/bWzWR7wdt6+qMHOc2R6T0uqHdA9?=
 =?us-ascii?Q?PXPmTj5ulYb4Rct6qnJ8poqv/oM6Ny5XkckGeTXaLyPvFO1I0r6ItlbnCpWf?=
 =?us-ascii?Q?MYKZI2GjdfNcKdsRhcQHoVSG441CZCxsBSpx2f32pqnkUS4pJWuKQJEgv1Zq?=
 =?us-ascii?Q?omjHrTb3s2zJLXZs1HMJq0BvWye0NopYPS39+J6JFPh6ryWxAz2oVS+Qcf0o?=
 =?us-ascii?Q?RnzWrRMfme0pbE4Aw1qU5IPoIGqLnctBa6SmfWvdGQcKPcj168PgVwsV2PWE?=
 =?us-ascii?Q?BTLwF9O+be+WmJqcsm6uVMQnQIIJLRSVEupP5Nk06Xtwgj5K6F7kXNA/5XSD?=
 =?us-ascii?Q?bkNRwnDMNxevF+HW3Kdlc/C1Tqu+YJ8PDZERvG6GU9ClTRKCBNEZQ8q6nU5S?=
 =?us-ascii?Q?7EFJU3waRKYnYGSVkYRWFIjzaCYFlOCNsh3dNq6xvkHbNkOLreVHInzW2/rh?=
 =?us-ascii?Q?SgQedfNt2tH8Yuy8bUbzGOHLis5Amr0/KAf7bNnUuFPnwHVWYIQwviituRQK?=
 =?us-ascii?Q?gPAT62ckaKcBYLGfF+zEk8h1Purs7maNy4FZlaWM5/cxkAz6YzQKNXF7H+yq?=
 =?us-ascii?Q?cnzBr33jl/3GztYXfUaDm2PsEzeOFS+RKMnflXztAGAnYF/vO9UhrJgo5hyO?=
 =?us-ascii?Q?GEtaM1jcsHQdq5+hs1zsF7gzfAGJW4qWggbS0R/rPj47jXr6WeUO+pApZGUK?=
 =?us-ascii?Q?OVfTqXDhCOnpJCAB/xgUGQ4=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 2edee2f6-d7d8-4d65-7bf3-08de013934ef
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 22:23:54.7963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ABPxKPWHIt2BtXksjcPMaO2+nSUqkK5cpZ1XP+0a9XSVD+uJp10ywLf6q2khaDzgPmZ+OqYiDAYrh1wNe/cwGHoeOA+MMiNrNAd+BHZNawM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6302

The were no any reply in almost 2 week, so resend patch series.

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

Changes v6:
 * do not fill with 0xff the whole write buffer, only areas not covered
   by user provided data are filled now.

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

 drivers/spi/spi-airoha-snfi.c | 513 ++++++++++++++++++----------------
 1 file changed, 266 insertions(+), 247 deletions(-)

-- 
2.51.0


