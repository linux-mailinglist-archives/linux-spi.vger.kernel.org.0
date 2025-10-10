Return-Path: <linux-spi+bounces-10514-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3715BCB8BE
	for <lists+linux-spi@lfdr.de>; Fri, 10 Oct 2025 05:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 401224228CC
	for <lists+linux-spi@lfdr.de>; Fri, 10 Oct 2025 03:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 515F5285411;
	Fri, 10 Oct 2025 03:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="XZuvPB5q"
X-Original-To: linux-spi@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11022141.outbound.protection.outlook.com [52.101.66.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3D62836A0;
	Fri, 10 Oct 2025 03:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760067138; cv=fail; b=WMvu1spkZYldHp9Dpi6Moqs43JX0+i586SJazoeHoCcjiUVm8/sjqVKTDhP2G5B8ItGMrRm84aPxFENBq/0nm4h8sfZXEyqNKTpJKxa17FeKoCJ4K/atnjPB8bkP03EmTXHnz5wWi/2FiDugyEBvGo8PbnkjeH0/nMShhkecLVk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760067138; c=relaxed/simple;
	bh=QErj+DEUrA4g9jLYzolmQIgvMp4P4PEivIqRfPJCOVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MYYzv52LLt6PL/0uR+r8tCSZfm++XCvL2tgAETsOm1MbIxP0jmCzhP595KztwdF1tzAoPVbWMskJECm02ABq9Nu2teHLv1NmjmMwsY2Q0YbBEnuJTDUoqjxQ0P1AkVN8Cj+HoSuQ+fbmSvvoruedlwtVFqErqxitp0idDKq3QYI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=XZuvPB5q; arc=fail smtp.client-ip=52.101.66.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pVoZZo/O9TiozxONIuUzDspM/ftpjMXxCQSdokKvyEiLwDbreLFahboNEqEdKUu6A9q+XwujWcpT+nnDQ9dsGjiNO8bNRIzmG+/oF5lFb3wE4WZQzJc7yXEjQwnDe1OLHN3kRBrKuB+72H7ASXN2IuvYv0Ow81GRnSEyAAWRx1YCyDy4wm2LWn+7i4qJ1XHWyqpRuNTulltboHHskvkXsRM7q7VSruuzO7m32L6mSHEF2pLUkkhGb2nMO5ayMA50ZfOmKI5QmI+L5hTVR2mf2A1kae0r81Ab1OoeOqWtYQCEHGjo90YAUbmnHev6GbHZTGodqmrLW1aO/7TH7RSF6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SKKyUn+WzKi4EbqWLfsvHtG4EG76seS8+1cIgJ7XRNA=;
 b=pdYxG/xE4YpTF8JHLPQEEnTJWzD+y3bj7ICf/tRYyGoysS5qhWdLp5uZj1WSKyuIqwBV264fzSSi/FgcWqb8tgR6d2XSkizUT2dHajP8kOfXGVm/u6N1eaizgIAMoHpDEjBts1djPbJvjr8YC6ftJZtziOjdxOI+YDtyRb9ToIhVXnVsFgtz4uDrKXvhrCccL2ZonbW9kYsMrrfOF/I7O2VA27gXuQ0+lZJMYIdccRF+m4LcgTrAb0RfaFa8EIKCskPGbD7v2CGRWF0gIiyfAsBwyolIfKptjZCjAkyd60bNrEmQPpUNOTjVCJXnCZ2o9N4Bpqap07MZjKWH/VAf6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SKKyUn+WzKi4EbqWLfsvHtG4EG76seS8+1cIgJ7XRNA=;
 b=XZuvPB5qvAvH4XXQzz2ByaY/rQBbvynYSTGgoh59yBLW+Cy3VcRoF1VOKRv/IyJgFfewO7U6BuZK/6/n7Z/95P5Y+tLXTJKh8z1OkxjbLgG54+XEf9m9rzoPeLVseUpR8mJdfLs8awt4mQKTFNLaJrKiu1PhEVNbnRHJbIyMF8rVEvjR4fsQRo+3QWm/7q7b+jCaC1b6b5HspCxtdFLoIWJ6UbcwNuDrs5TfhVyqhytGrzs3c6VpOHdEKvSd3SDSQk3D8eUQvzdgboZ2gwg4XrtulyOMEpdDhh63YPQOgYRjlCbE/XF9qOC+m60A4U+QAhLP0pH/Xt+j6YyX3V08Yw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DB9PR08MB8359.eurprd08.prod.outlook.com (2603:10a6:10:3d9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Fri, 10 Oct
 2025 03:32:07 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 03:32:07 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Ray Liu <ray.liu@airoha.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
	Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH v7 14/17] spi: airoha-snfi: make compatible with EN7523 SoC
Date: Fri, 10 Oct 2025 06:31:33 +0300
Message-ID: <20251010033136.1475673-15-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010033136.1475673-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251010033136.1475673-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVYP280CA0035.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:f9::28) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DB9PR08MB8359:EE_
X-MS-Office365-Filtering-Correlation-Id: fe013248-f850-44e0-caf2-08de07ad96a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qq+DzyODgoxDZvGz0Zds312gLW/84BeQKwdI4P/f6M4gbgSLusBlXjSNxujJ?=
 =?us-ascii?Q?AhzJ2oD+J5QQwAffXJCcOgMA+3B74w0ecz200jKL9uMonEykTJ9UVN5LkdDz?=
 =?us-ascii?Q?dlH3JZ+n1w1Ez4a7pxcuBCUYJbH1Zu+M5N4G4ncvNtTWH+eAT13StluLS/YH?=
 =?us-ascii?Q?5/zr680m2DtBvZwpZXqACXqiR6LIM1IQKs6tBFKVNH6WOaXsiE2M7Nxxa05s?=
 =?us-ascii?Q?SLiCdnv5r76mW+M1sBPwMYZzNHIfgFN7QYx3nCdc8PEEbAmUTvCCsZaZ6rmb?=
 =?us-ascii?Q?fKQlefhbiilEVRTmHc2TRwJnnuO87HVqOyq+PkPerljV9v+V0kpEm7dIm5A/?=
 =?us-ascii?Q?UYc0dkeQgN+g9Z8DJBBLcEO6TTbk3uxXr6KhWAcAERYltH2dsf6dkJmwiWXV?=
 =?us-ascii?Q?OOSr/oawlleUT9KqagBVcb/pxrbqVhVVHfU1jAtqlaMnh8oXMq+AoNI934JI?=
 =?us-ascii?Q?lcvd7PfUG9InDLW7zr0/k8xtnIidwZLhOBwnCp4+k4Jpa3Nqh4zzb+QSnDsW?=
 =?us-ascii?Q?YekelTdNBmeohTDAQ72xwKG7r7HMeSuPVcndHk2hsXF/cqSLms1B3xCtU/Ba?=
 =?us-ascii?Q?xbCMHZZQbCs42BH9SwLDicj2YDNfYdM8FAUE9spArq1ZBFmEytQOt+srvpR9?=
 =?us-ascii?Q?AYsHk+H0a74Pf5dNlqd2wckcJE4Wx6ixssAj5+/lE4Sae8TZTzjp9sZIs8FJ?=
 =?us-ascii?Q?jxkWSP3VrbIxSYN0SpIAF471VGSZjlHeAgnZLxjS8Wp70F7Nth1leTvXcc3j?=
 =?us-ascii?Q?wIJ7ChKd8ep+ZG80ike1wbSs+dsARXpxMUWXq+0WSJKaE504BZ79BGHlru5E?=
 =?us-ascii?Q?bW2fytgCjd6ZEI9aAGOe2uB47ppD1qeTZptItyjfTNDsHWudnwOH+EidQv/z?=
 =?us-ascii?Q?9Djn8i+2LwjE5cUp7fFfNoUgq1sXqlaz60c3bXYz9wmdJx4NmbarkCXZVcS2?=
 =?us-ascii?Q?+9jaGPvXBuGlDZRWRFaG6PVfd2bM8LGeKxpkqg9QItYLSfFe8Kb2aWmwg7yZ?=
 =?us-ascii?Q?UKI9J9Mb9JZBU4vnwP/Ch/S+JaG1ImdNBnCHB2unK4saTYejuZ/vn0utd1TZ?=
 =?us-ascii?Q?9z9li0LZVIH6nCCTxptaMVnGRgxY8Q9qgmonFyzKNsbPg1dsH3jo6KEX01EW?=
 =?us-ascii?Q?R1eTdIZjDmC8bRC6cHxPK1AWlXQpnvu8oCtaaTNc3qM9SI7XQskxTCPBYH8c?=
 =?us-ascii?Q?n9zssi0TAndGhIB8YVMen3TNghndKF3LgdyT0g9UuREPI7iFfL3z605hEf5O?=
 =?us-ascii?Q?gp8jb9jByA26+fNP/c2ZZzx5+66nf1k5eR/y2ClQHOogws5lBQ4ft3sZcPdw?=
 =?us-ascii?Q?6ha3KOMAocXZMwUp1stCylA0XS2suqP2cC6Jtm3dpRO6S+TbGke5GBLRLeK3?=
 =?us-ascii?Q?5ZedIWn/4reygX6rOXi/69fAP7Pl+60xxqUniaJaBHax23/OwE4LPwsxZNlz?=
 =?us-ascii?Q?fkjromP2sZ1vF6Ky7iZ4uTxljIDbxqC86ZfEBesJ3x+7q7dtilrIfnL9HM75?=
 =?us-ascii?Q?U55oiBeBPRY35drPsBoDYGMZbK2H9q5/3bOyOiCZWQRP+2mtg+Ot28tnxA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?u9EKPHolGQcbg636UX9fYXU7S/drGFc+4ZjCIlzUNWV6NZ9zZiappAl1jqcY?=
 =?us-ascii?Q?Rg4mXkKYVX1pFwGIHTaBqXHfqo522RBhLvj8j+LmslDyV7Vhfj88g/vaNlZB?=
 =?us-ascii?Q?1O4c3ZSprvB/fEKefY4Ihl3WBUhONc3fd77DknJ96WDWajsRTxK8ENZ7iizW?=
 =?us-ascii?Q?yo56vJ9xPTZiumDpTNrvvXWbciwHJpsQpVn0gDMHTYUoNGjUifeMWPgqwK2D?=
 =?us-ascii?Q?09IT6U3D9i/U5+QoilDne73jAHOu92+PPHzw9IWlS97ZQmcLfhowTM2rVnPP?=
 =?us-ascii?Q?wkA1o9vJ3mgpgQqRB3x4UMyZocDOTZnr4aPa9hWAWSp4FakP3pu0sEPgbVQI?=
 =?us-ascii?Q?joiMagUYC7QK0Yf8Tha2yc7+1dA+47a+XoCGknmBpexme25C2YdmCPewMo4L?=
 =?us-ascii?Q?s13RaPTHeNSk9iCChJn/lY5ZJ7MkP9/RxvcM488/kEM1T3gPjPOjN2a0kJys?=
 =?us-ascii?Q?UoLPAa3IeZEOY6MbZVVfna6Vehkvb6zbKrNBt5ayafq4xynbyzrIw//WEelM?=
 =?us-ascii?Q?l5ADkcqfI13hdUjqB0RZDSJLCxGpnU+NYUUbcABcSGIUm1r9yuGEPyI8rl5Y?=
 =?us-ascii?Q?t+9q6guBRPcdRzq3dyYlcxIbuXeg0DSkwXPMDpMkANDh3hju3Nsz9QvX0QRH?=
 =?us-ascii?Q?T6QRYCThDpGby5Dmriw56eNInbft5Hr+Uxq90Ee8d4uux5qjNMrl2ugFXvZP?=
 =?us-ascii?Q?DhmB6o9dNIFhVE8AzG0kPOSgL1d2GkjzI23BfNRSR0aEFUorrzT/mzLuOusg?=
 =?us-ascii?Q?uS1fJjnp26YhtahG9J6o3Et0L7/qDW7r8newCYVJaKZl0QGUSyzvCLxnVv6X?=
 =?us-ascii?Q?dy+F+2AF6WHweeZZMJu6plKogoSO/KYoEvVOf4n2N+I5/a5NTA4/YDlvncDA?=
 =?us-ascii?Q?8O68tCbynkSkT9AqmJ9d9ls7RFnxAHeLJKg2JYwzcydTbn6S8eiGzbImO/od?=
 =?us-ascii?Q?XJqMS6h8MHeFKfyqUtoI7vQIYiqvTIuh5qk4+AP41w6P0vCvLPpx+cWlY6xa?=
 =?us-ascii?Q?JxX43XWbwPmS9VucAMki7mItZ7ttUNFVx1Wg+jyAbnJ7fqurQW3exmj02/MA?=
 =?us-ascii?Q?5Y9E4Nd/v4MEeBOTQ8FvDR6/TNqOdF8UyGjeRf5IEIrcCONsAWapqxevVCor?=
 =?us-ascii?Q?q/mmZmvUlKJtJOwIQP0oRK0GJzl/ZhcA7/6aaeBklFVhG9KQXwGWJe7Z4RAa?=
 =?us-ascii?Q?T4p8ll4oUjTVFcqrdYuU3yuImxvrMfOHzRv19nyDBgY1Uve9ANoonXDoUKBi?=
 =?us-ascii?Q?CiZK8eQIu5r2Qud6Zld5/d9Cr7m1N1c4GQco4SI3Y2fSwJQ/fxQV4/RTQMBO?=
 =?us-ascii?Q?lAmgXCV/eJQs0R9TzDcJSk2L4baPB68XOYk1qO2Uezm76xH/rogauugC3oBe?=
 =?us-ascii?Q?mMBNz/YCtSeik40c1qcos3c58RsytK3aG6Gpt1Re8YhoUwDhIlfWEz/k3aVx?=
 =?us-ascii?Q?hxoh09H0skWFlWUOkrM8TQ5cQ4OAEKW+olS4IKZfo6aTmiA5qkANXPSFoUeH?=
 =?us-ascii?Q?5jyjLef5GWsFQpL06/o7VGCDAmb0XDjJ+KhHxqO981YR810zb+Y279JUhfw5?=
 =?us-ascii?Q?K6K+HgfzWID8DS9vMbN0FlEujp+ja1d+RXf//CAp9/Cbc+t9QyC3G4Yv8c+/?=
 =?us-ascii?Q?BBbKVSf65EGdnLY1+kmr+x8=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: fe013248-f850-44e0-caf2-08de07ad96a4
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 03:32:07.3455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lLvStw7ekcMclzyGH3MpMG0if1NSDcnIWRcdHs4JFZuZJ5w38GacNw9XE1pDXd7FOi+y3T5PjOYa9uz1j9RG5I5HZ3R5gDH7/bkRXxuVMHY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB8359

The driver is fully compatible with EN7523 based SoCs, so add
corresponding compatible string.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/spi/spi-airoha-snfi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
index 8408aee9c06e..058e08811210 100644
--- a/drivers/spi/spi-airoha-snfi.c
+++ b/drivers/spi/spi-airoha-snfi.c
@@ -1047,6 +1047,7 @@ static const struct regmap_config spi_nfi_regmap_config = {
 };
 
 static const struct of_device_id airoha_snand_ids[] = {
+	{ .compatible	= "airoha,en7523-snand" },
 	{ .compatible	= "airoha,en7581-snand" },
 	{ /* sentinel */ }
 };
-- 
2.51.0


