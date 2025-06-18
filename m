Return-Path: <linux-spi+bounces-8655-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E751FADF06E
	for <lists+linux-spi@lfdr.de>; Wed, 18 Jun 2025 16:57:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EC071895BA6
	for <lists+linux-spi@lfdr.de>; Wed, 18 Jun 2025 14:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00C312F0C50;
	Wed, 18 Jun 2025 14:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="SI+zWV4s"
X-Original-To: linux-spi@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazolkn19010015.outbound.protection.outlook.com [52.103.66.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCAC2F005F;
	Wed, 18 Jun 2025 14:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750258484; cv=fail; b=p8kOJVRRupv4bN0cMXYbapGAlpfEpOSG9aK/gM/Rw88bX3cbZnKB5YbHQJ0Bpgns18Y7vSpCILrFtwz0XOEHVWNwlbLqqn+cfklyIG+6YpMLO2bJ2tW8H42YSQIiWd5NLtb1+HYzAhhWP2wtwFk8SlDW7J12K7nCcwCVYvlB4E4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750258484; c=relaxed/simple;
	bh=3T1B6cUNIUSzwlm+OuxeRXOQkuY6ZUKCn5bvcB9jtkc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LFXbbYiQvaWbeA8yJ0heiqjKxxuq6nbWPmlrvZoK4Di2Cd7PYF5rX5chqzW1pOYeYp7bSQUXdzSXoes4Ul+sMhSl1/mHy/pN7EnYMGlvPZ5HyFpGInwqjJdAO6WUuMR/F0G4V8yV9exS+VVz/zoZZbwPBBDDOVGvqICbhrgctSk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=SI+zWV4s; arc=fail smtp.client-ip=52.103.66.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kQzTMu/nqFofJYRlE1YhUOZ7k5tR/42OaedJa3sPpFbWHjRV5TSVOtPdwankMEWZsgEdPQfyXzgw59wS68gEwVgC9gzdcQ897uFOdG39uePCT6cNh6FQyscFe3DgSbUb4pOLzVVgYZqBJfHs5Auhx2qXSGWReC6+Va7CpWGvcx768fRi83YlHdX9n1ZtXJZevPrwdn+6Sc9PDzTKkgqH/YNMb62OPFmv34ELQ1bcdqHTOwoK2m0baaCvhPCVDXOaRP0d9ALwAzMPkGF7opS7GbBmyqf8q/bvEY0F3HhkKGmVpHjI3lZFuCfM5YgV1JWe3W/NZkHobqelh/qsiCHWyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EHX6ZWly1Hp7YuHYD716VUvACgTyqR8sPavjNEizNqo=;
 b=KA2enzq3AuEKG+OH+k0TYg4yBupcTH5kgrjzu4KQOQvXwrFSai4N8p45grRacYTIJP/CJCq4lut0agRco7ry7mOobtRW9ROP9fkh+SHjIsERDqgIiitYy6gSU7aVNPeHoRYyn57IXDzyBRJhjnzpHZBHEtatHgJZC8XgIKysxe2AscfGuiAS5CY2+tqgxtTJm17qGC4IenbC34kjYg62Z789eQqe2S+F8MCtq88hZxRDBtSCACfQeSSayBfQ/0LgKFKRwhoA0mdN5zOJAzibfz3ovf1ZF7r0DlGeJ4YvXIXOZnyqun3LpUWG+cAtML0wOSzX3M5KQr1VbKKh+2aR3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EHX6ZWly1Hp7YuHYD716VUvACgTyqR8sPavjNEizNqo=;
 b=SI+zWV4s+fYV+tr5R2jkn1s5wdFswHo3T5Me6EeSDJrkmdxfn5+UEU3G5YkuivXALBGRpWDBWTYPSnMsjMROmM2G9RklsieVTESwGICqUXyxZhi/45KoDCDDCKW2u2xWMJ95Qehe9LnlHBS66PHyMQTasSptyITfunp6Vy+cravcB5pxP5/1XDVVhbt7T1jzCS+45wHlyuW3xwrEGZ3SFznM3RWSoNeS1Q/wnNYSTM0I1qsfDRZHrUwgyR5t3obbykqN6JUjE4pz4+j8K4vH1i/PBSiJAi5Ykt/fp1qofcObSTyzxL0G4Ixa6C7EVF860K6FAWg3taB48fkkzWZl0Q==
Received: from OSBPR01MB1670.jpnprd01.prod.outlook.com (2603:1096:603:2::18)
 by TYYPR01MB10545.jpnprd01.prod.outlook.com (2603:1096:400:30e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.30; Wed, 18 Jun
 2025 14:54:39 +0000
Received: from OSBPR01MB1670.jpnprd01.prod.outlook.com
 ([fe80::c00:ec4e:ee7e:9b7f]) by OSBPR01MB1670.jpnprd01.prod.outlook.com
 ([fe80::c00:ec4e:ee7e:9b7f%7]) with mapi id 15.20.8857.016; Wed, 18 Jun 2025
 14:54:39 +0000
From: Shiji Yang <yangshiji66@outlook.com>
To: linux-mips@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-spi@vger.kernel.org
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	John Crispin <john@phrozen.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Mark Brown <broonie@kernel.org>,
	linux-kernel@vger.kernel.org,
	Shiji Yang <yangshiji66@outlook.com>
Subject: [PATCH 12/16] MIPS: vpe-mt: mark vpe_free() and vpe_stop() as static
Date: Wed, 18 Jun 2025 22:53:25 +0800
Message-ID:
 <OSBPR01MB1670546C9A13C18720FECE1BBC72A@OSBPR01MB1670.jpnprd01.prod.outlook.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <OSBPR01MB1670163BDCA60924B3671D45BC72A@OSBPR01MB1670.jpnprd01.prod.outlook.com>
References: <OSBPR01MB1670163BDCA60924B3671D45BC72A@OSBPR01MB1670.jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0054.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::22) To OSBPR01MB1670.jpnprd01.prod.outlook.com
 (2603:1096:603:2::18)
X-Microsoft-Original-Message-ID:
 <20250618145329.25517-13-yangshiji66@outlook.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSBPR01MB1670:EE_|TYYPR01MB10545:EE_
X-MS-Office365-Filtering-Correlation-Id: 35fa54d0-3ab5-435d-2795-08ddae780cd8
X-MS-Exchange-SLBlob-MailProps:
	9IecXKUgicBBERLAmk5UFwj7bM5Q2MTgIOVbyslTlXlOFL3D3OOVMrBF2NFSEvxNaDU/4Vhzm5TqThDVTtivo4XajOKd80s211JB9NYevv0YcytcV36iwQ9snm8i4Xzz83af1KhrdIwcrYgsaLlVPB+7JxfqYFrosMbSKOH9k2DKOyzESUUxNJQoElSftqf/YRm/qzjVzJOx4klbDrYhnV6Iqwa9mdRQKyLQ2lDpeVwXWdQpFAtjTsNatF9Krr81biP1tN/DIIzOZnvllxnXMcUfDplxCE6SXYatjzrIc+6geHiCw7T1CpTa1+rov9DNnD0964I6aY7ZRqtEVXzOgstnWCDsRg3iJ9RoXVKxuFqgAHW+K/B7z5kC4yV75oGhfM0yyo5I9Ipfou9KDYvv/IZne8/D2r9oNLF4fBNgpo7nqlENXw8KU7xFz/GjkCJ1u4+csj7DOiWE6xEdKkBGWmh8jfks5A17oJWK9z7k8PXR2T8feR2vpnCYzQ/Z5gT26Cm8X9OWKoxcm7G6EXkliwZEweThW7j0mPUvGT1BALDKN/Z8cu4rEHPy4lwiMuoHLfvUWLicmiEXeOfRKB6c4ADcwu9HUPhHypUVRA3/7fJPw9qNaXjcD8tyk87G65aSjgZd81u4vQyaf+4W91USaKxtYsZAKDdtlpZDkemnNWTpp25PoNP5zeshMk48EOPQ1H1kEKqZsqG92Xnr5QNIO/MB00mNTf3vdoe6rTNZxo7+ZzEerLKelA==
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|7092599006|8060799009|19110799006|15080799009|5072599009|461199028|41001999006|3412199025|440099028|40105399003|51005399003|12091999003|11031999003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dvlqklpwJhJqPvFLkCuYaTYoQszgWK9Jkn7hth9AQd6U1iRoMAPtqdXjxIN4?=
 =?us-ascii?Q?Bv+jo1rmkMxTHfK97tjCPLbTICFZpKBkde9TkW/wQI0k5J/Tv15++1ohj+Aw?=
 =?us-ascii?Q?QB/3YWaiUpLLO4QaWrAFfrXZZNkfPp5L7Xj+bCxJFCUlsMQkMZJX3ZI6xxdT?=
 =?us-ascii?Q?oM6hdOW8Qy2Ds9NSxaTCVOHBTadpEALbaVJIcwDf2XCQbUdha0MG0lOzwTuq?=
 =?us-ascii?Q?+qDyMkY6ciAxeIWQe2+9wMYdcRTfVNY8eb04nJlD2ViD2wsORgamRu+Aoum5?=
 =?us-ascii?Q?wlQe77Mvcj3D/Mnf3fDzmbXFBOmFAgdRPu7r9S0YzpQKSrc19NbkBjDExUar?=
 =?us-ascii?Q?QI1JqLjD+/W6GGdIy8u+z9k+ExBQEE8qGDutevGLHaqJtzqcKuc83b1H4NWN?=
 =?us-ascii?Q?MQCxiiUJUgyhxYLCyLX0TKhfhPWkaYD7JTEYaTGxHClH2BzCIu8R7ahlW98p?=
 =?us-ascii?Q?IBVv3zyPfqX+lBFG6P2nHVfL6Aag5kIxRALf8uE89St8xTkA3Pun1F7K9Irp?=
 =?us-ascii?Q?rMrq8srq/0Ti7M5aO8ptlu1pS5pp9BOIWHao7Ex+d7cvKAG4DK7z1y5DV2qq?=
 =?us-ascii?Q?Dk3J7cK608ykfZYZJP2AiwMQNA1vfmJnEU/yGaprzxpJRpgNH4hZnhbQCIuW?=
 =?us-ascii?Q?Xat3EawHdpPtRu/03olJJf57LfPGMKpA4zOPOkJgQc9yE8LJb6EwLyADDxYk?=
 =?us-ascii?Q?bp6w2veeAihVGcnDHeg6nxJMpq7bjxoHXlbMRVH67c0X++x5t10u/aY5D2dC?=
 =?us-ascii?Q?7BumJBdFqGqkDF86pN0hgLwMGC6wkIJS4UnKGDnmdb6QsfHsw9DQaxvjrFrD?=
 =?us-ascii?Q?XeLE7dt/mNUgZjdwSSbr7efSGr0DbO+qYs4GnXeprP+4bWJsE36ixhzNCofA?=
 =?us-ascii?Q?IDtZhr8rabbBLdu/My5itFkqxm6RTMZ/whgARZu4AbEKzNSyBsTFPwprIRPD?=
 =?us-ascii?Q?za3DQvLjygF+372kp5Iam7vJ+akFeiDrVo4rio8LPc+fZS/ujR0n9W5IGZlZ?=
 =?us-ascii?Q?+mg8uSSmACxG9wVlDcw0xvJ4JOIRRfVq/pYg5TWZ6Tu0fFJzv9c08wH9FaFn?=
 =?us-ascii?Q?IlHUI0A00+8HLbkn1Ra2njJpEY4ZQNkMxfE4KLieH7S0VcbZnwkejXxiVI+8?=
 =?us-ascii?Q?7kO4jAmeVtt9JH3/G4ZJhW6rzSo8KcrJUBHM2FShuQc2nmbdAPShDqJUSKOB?=
 =?us-ascii?Q?T8Zd4N/to3/DfGmYFsOtrj3qKyyRSp/pwSxq4LmTnXo0rxygfKgM9rFasfqR?=
 =?us-ascii?Q?ybyKaWCpCmx46Ez6IlUr/DbBddEpIRy4waDkXzFziClMYzH2lfosdsE2bS4y?=
 =?us-ascii?Q?4Z4=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qroEPQteatmoSeBEA/xxOFFXX8Gjw5YJ4ddvAz4RBXsbu3zUOdG2lX6BQ9Ny?=
 =?us-ascii?Q?QqdvcNmQNT53vkaufAGtNmyn2PEpzpMYVFIrpo9rUCUKHV8m6z4rmHlpai1K?=
 =?us-ascii?Q?YqVq0mdV4l7aYwU3kVL5U4EDHdyFl35/JTpw/fhVtX24rKgK3CrXCcAHjdu1?=
 =?us-ascii?Q?cr/v8lBUi5YyQP22tMKgBMqDhWq/9o6arWKbKOBGk2mTKed9HQ3cccqg6TLD?=
 =?us-ascii?Q?llPTDihIW8iVEJqHXFDBN1Nt1IfL5UAFqkpikGqXz8O+B0A/y2KJHLwsAt80?=
 =?us-ascii?Q?FDqtbzJ5BuJ5+Bl1oAVR7Jzg8RajwpaO//y52McqOFhaw2boiBw8dd6d4qSz?=
 =?us-ascii?Q?J4DSpjM+rhS0vYQGwgoCcGc7wzcgurJcFUbDBAh2/q3fKcnbQBpYJJI/n69Z?=
 =?us-ascii?Q?o5DNOPQfELdbFv18FYJ7+5d2eOdSyeD1ko/cb4pX7I6GBTRQumKvsUexS18p?=
 =?us-ascii?Q?CLPgiKaysBD2M1jcssUX3Ch1iVwu9zsCMwRFR2emSpgG31+MxI/ktfI6Y7t7?=
 =?us-ascii?Q?bpdRItogbIsjYsh6YFrA7ecyrSF+3XIznZdQqaYuN/PIG/5vlzsmChXizyxj?=
 =?us-ascii?Q?tUJ5Ag5bwmt3PjDkjT/bOUFQFELpHHCRp/FSwY6qZrnVQGUD4/Z+kmBjrIwl?=
 =?us-ascii?Q?cb3yxG7HA93HRpiRcgB6DCLKU5ubsKw3CkSyxz9wMhuIGISMnL5CIe7gZmjZ?=
 =?us-ascii?Q?89maSWJg3j7eLUteX1OC0p9E66qDtn6MJ+UrTtYkYoNQGXJ6iOAtK7UvU1XS?=
 =?us-ascii?Q?766rITr9o2hOiff+2CgQNKVais7AgT3NSRqkUJVwLM4zlNj3tE1VK4TXqPCi?=
 =?us-ascii?Q?XdKNN7mOVWn7R9F6OWL1mZQIHMzjTiIAQSvKxvCJCLFEkKlB5Bz/oe+WzVOL?=
 =?us-ascii?Q?u42TctZiX+zdDLYVv12KA4SOkkA9ojQc5xIAddqbuHtqggBmHVPprucM7r6Y?=
 =?us-ascii?Q?dfJxy7A1mBjv5BN6US3fZ1jXY65Guew7OX1LrbNRJ19q7/poXTI4L9V72wZx?=
 =?us-ascii?Q?x2yQK/uGUpajZWsckY835HBn3l6+lOrGXK5cQy+F8vuoLfzddY/UkozwIrOK?=
 =?us-ascii?Q?pjEDpNPzt+/QQLx709MaqU4WuHzAEoVzpZy1x6nzP3pEyoMn8tra2POtnGZt?=
 =?us-ascii?Q?AuTu3k8C+JL/XEZfkg+9dDShtJahx6pQhpjQ3UMZh4s0M6nksQwcTI+4DvNV?=
 =?us-ascii?Q?nn+lf3gd1ScdNduWigl5ixI7gukH5pL/dyoAwTiGg0O/iEu1WTEX5g47K0r1?=
 =?us-ascii?Q?Jyp+gUgslUcnYRF7rs6T?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35fa54d0-3ab5-435d-2795-08ddae780cd8
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB1670.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 14:54:39.6144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB10545

These functions are only used in the current source file "vpe-mt.c".
Do not export them and mark them as static to silence the missing
prototypes warnings:

arch/mips/kernel/vpe-mt.c:208:5: error: no previous prototype for 'vpe_stop' [-Werror=missing-prototypes]
  208 | int vpe_stop(void *vpe)
      |     ^~~~~~~~
arch/mips/kernel/vpe-mt.c:229:5: error: no previous prototype for 'vpe_free' [-Werror=missing-prototypes]
  229 | int vpe_free(void *vpe)
      |     ^~~~~~~~

Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
---
 arch/mips/kernel/vpe-mt.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/mips/kernel/vpe-mt.c b/arch/mips/kernel/vpe-mt.c
index 84124ac2d..694b3bfc1 100644
--- a/arch/mips/kernel/vpe-mt.c
+++ b/arch/mips/kernel/vpe-mt.c
@@ -202,7 +202,7 @@ int vpe_start(void *vpe, unsigned long start)
 EXPORT_SYMBOL(vpe_start);
 
 /* halt it for now */
-int vpe_stop(void *vpe)
+static int vpe_stop(void *vpe)
 {
 	struct vpe *v = vpe;
 	struct tc *t;
@@ -220,10 +220,9 @@ int vpe_stop(void *vpe)
 
 	return 0;
 }
-EXPORT_SYMBOL(vpe_stop);
 
 /* I've done with it thank you */
-int vpe_free(void *vpe)
+static int vpe_free(void *vpe)
 {
 	struct vpe *v = vpe;
 	struct tc *t;
@@ -255,7 +254,6 @@ int vpe_free(void *vpe)
 
 	return 0;
 }
-EXPORT_SYMBOL(vpe_free);
 
 static ssize_t store_kill(struct device *dev, struct device_attribute *attr,
 			  const char *buf, size_t len)
-- 
2.50.0


