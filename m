Return-Path: <linux-spi+bounces-7664-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91644A92E4C
	for <lists+linux-spi@lfdr.de>; Fri, 18 Apr 2025 01:23:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D0121735FA
	for <lists+linux-spi@lfdr.de>; Thu, 17 Apr 2025 23:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E2D2222D3;
	Thu, 17 Apr 2025 23:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="a+47Z9xB"
X-Original-To: linux-spi@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010005.outbound.protection.outlook.com [52.101.229.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B010C22171B;
	Thu, 17 Apr 2025 23:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744932229; cv=fail; b=hR47TCZhQ4FqMhVRZyjaDeyNV71GksXvwoWk0NHaQy4hXtCWe0wdymuopTKjHQ3PzVpnQPOSfTSZVv42hnQ1aCqpbxBYNYmWdmJEIHBADYCUjXhYvB4MoGlbWapqFsN8+UeHVa89I2cWUu9KEjoAiDHPOINVn9+1ATjzOYK9rMw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744932229; c=relaxed/simple;
	bh=guV3j+Y0mhwa+yN5uNQLRdU6Lv/A/4hXkhIoXv6ml3o=;
	h=Message-ID:To:From:Subject:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=u0qtAOYaKQg1ihXDRlyKn0ernkZp37JeO7uUH7P0BOPbTYWNfCMBn07UlWPcqNHEO/917oZD2W6TE6MOwz8GNnGinlVz405g69PERC4gloup8ni0GU2bc8dZ9cxVo/ZJcMXND8K90q3T+i7SYkDcRPfuA4eoddchhRpfvHMLIBA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=a+47Z9xB; arc=fail smtp.client-ip=52.101.229.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qgtJ2dtR+BSedxU7RSOYFw1DiFPjYsIsg7iszuIOe9d8lcQM73/JKp02R2LR0arx+FleH3TBtevG93XUChvGwPknAefWABy2zU3wBzkwX/MtLvmLNL5tKtdeUJIeBfiVs3/3PaomtdOu92Oq5NmECNJsDqwE2Ul9SknsivFK/N249XsHX3qc8jpNP2lhB5dJB3/zdRzttIa1TP8rK1Ft2bP9uSbBpp9Ukl+JE2VSNbzN9YZ9HAek84aqy3qoxs7G9wfebFwaXIR6QnteGpljkBLaxIBIGGUJyN4EsGhbAPv9tFE1iN9N5BYpkrOZk/jUa3hfZxRlYt9fvuKy5ibw/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4p73e0vJq1wenZvszoAo/F4Ykc5+2LQEVMhi9fljCkc=;
 b=OTpN99ak+f6atjMdMfgAVH09P8eN8QtD673J2Bd5fgaILtjY0EQmeVRS0cnBBBEbnW2Y5M+eCC13yuBX8TWzHxmOX2e9L5zV3CkkxIZydgEli3J4wegzkEzm5o+x/rSIhN8m4iyKKGdxNuKj2UfnIPkd6oNvh+Gm1Yqp4XEoSWgDQuhkkRf/YaHHpFagLr5i+x/y25r3M3Gxi0ZIJS0pFqZCsmA6g59Y0DKJfHGOV5K1KCPE/mI295hypk6XC8XjZHG+STMEl7qpa9/x9dHKCPBw0BHnfjOOsh9u0EiOGc8MIJSJadl9jvTx4+DeWf7dvpyhXrNI9TGnLyy8fFK+lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4p73e0vJq1wenZvszoAo/F4Ykc5+2LQEVMhi9fljCkc=;
 b=a+47Z9xBaSooNnXMbyJgc3E9vOMmrB+b2lVI0e+7zn3tzuCJBTnxrmVonN+DfePmBgZBC1UmC2XxQq44DXbdrSHaQJozf+wxTTOXeJJn6NXOrWQKoeTPawbZniXfvfzRCqqukiQfkZw0jP+iTEJz3llAwZEGZDoq/Bpcwg9H6EM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by TY3PR01MB9998.jpnprd01.prod.outlook.com
 (2603:1096:400:1dd::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.32; Thu, 17 Apr
 2025 23:23:41 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%5]) with mapi id 15.20.8632.036; Thu, 17 Apr 2025
 23:23:41 +0000
Message-ID: <87o6wu2wzm.wl-kuninori.morimoto.gx@renesas.com>
To: Catalin Marinas <catalin.marinas@arm.com>, Conor Dooley <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Jaroslav Kysela <perex@perex.cz>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Takashi Iwai <tiwai@suse.com>, Will Deacon <will@kernel.org>, devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-sound@vger.kernel.org, linux-spi@vger.kernel.org
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH v4 9/9] arm64: defconfig: add Renesas MSIOF sound support
In-Reply-To: <871ptq4blr.wl-kuninori.morimoto.gx@renesas.com>
References: <871ptq4blr.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset=US-ASCII
Date: Thu, 17 Apr 2025 23:23:41 +0000
X-ClientProxiedBy: TYCPR01CA0191.jpnprd01.prod.outlook.com
 (2603:1096:400:2b0::16) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|TY3PR01MB9998:EE_
X-MS-Office365-Filtering-Correlation-Id: 0765ae0e-9497-4b03-22de-08dd7e06e3e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|52116014|376014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nY9KZabrLks8CVukpnqoCSNpD6lOLKFIfEVAnw3nmcO6fFzbN33J4FpbRfVi?=
 =?us-ascii?Q?ry52RAPsLeV8LKNwTMszHWt+301TFaP7vVs2V5esVfEZJcIFvYHdWqFaeuyS?=
 =?us-ascii?Q?hxrWdB0M7NOQtbjlAmmyP1T7vlUGgsDSyDuHO7UFFJEk6bJU0Fndpnl9dh/T?=
 =?us-ascii?Q?vK95qy9/tXlFLryLkCiVdBpG2Wc4V81xMtWyDw8K/uL3JTj/z+hBFIyYjEuy?=
 =?us-ascii?Q?buY7FwqxGo9orgjfq3E0uRw+qbGiBOwV9ISfPS8t7uVB0yfNCeFK0HMo7+l+?=
 =?us-ascii?Q?ElyuiG7FBXYH2FIHN43+s7BZCEZq1CwwzPXfmndu9v5KJXdaHFUqe3Jdk6Sj?=
 =?us-ascii?Q?wZIn4rjSqkpwa9Whw2od7dd7Y5+zLJmcAP1sAe87IbLBm+NTeUXYhNp/A4ff?=
 =?us-ascii?Q?Ow9+jF39XcIuUedUwCb2ph2BuMHV5Q/WYbV9LRzZKe5hJNIrSvpIollW1VTz?=
 =?us-ascii?Q?VRIBRJ1ML0sQhrN86QSyIsOUNGaAExa+2o0WYOwCPb/IJLu92nIe4eomWVYQ?=
 =?us-ascii?Q?crL1SNcodB1LxzFRDm4Mrme99FO4AXBrPvEi/OFov+caa8TVbdoI12Abu6Zt?=
 =?us-ascii?Q?mjkXbtAocOZo+pBxu51PmmSJpWVxnKMNkbe6jyejnygriVuqKKqh4Q8ZNzn/?=
 =?us-ascii?Q?FBMxF/U4QLoyhUfoFWgsxs8ZpkZ6/uSHJcQeNu/mwWAA94xx7n3HupSO1Z79?=
 =?us-ascii?Q?srs0n5d7BYXudL0/PGrjwIxnp8QIox14kARu4gUeo/BJmCcYBGs0S+tQ9G/F?=
 =?us-ascii?Q?Pjk53YEXP5UGToOBORazCdjbUoXSk1nfHw8YTEwsRNlezK8zmrgcsvPi5Jtf?=
 =?us-ascii?Q?kZxFwXXHUqOVMrF3XIR2MKIkpEnFwDq58Gnl0hX1s+VJsda4oCQfLl+uRlSZ?=
 =?us-ascii?Q?3PZMCNpzEO4GHINS6LodfPCBParnv2oMQ8u921JDthsotFxAk9vvNeyUcQIs?=
 =?us-ascii?Q?qGW3gU4CW6rwGynpPlHTj0lPDEK3AitbQ69cTMePCbuc8YEBx005FieoCZex?=
 =?us-ascii?Q?i9n7HSiJGmUQU/sjJC6/rhYL7f/HyfpB7fGQZOspHoUFEDY7RFCOHjMfZro5?=
 =?us-ascii?Q?riMPR264Awwxp76JoEGNdUo4IUM3S5elcu5gtslPcW4OyDF7k7W++Pdw7sNE?=
 =?us-ascii?Q?O+a5YTID6rCiyipYW9PgN6PVilYK1KU1jxES055Th6TDkaahaWoMGHS7Zwh8?=
 =?us-ascii?Q?Pp4sUp0ib5KgXAx4dxOePCiwbwa/nIs/+Kc4gYV3H02QyjJLVt27nIXmDfqB?=
 =?us-ascii?Q?C47kTKVnNRAD/EFTw+2swwCJ8jb2nOyzZdM/hXX6L+KAHjzd8WkHIG5Y/N8p?=
 =?us-ascii?Q?Oy6Ptt3V/nipf8K9FtQyqNIFYZFgpRvTCPqfWqtTCF/POWPip2e2o1Aq2Ghz?=
 =?us-ascii?Q?WbZt6iMXbBHF/xk8AS7C6GDAlNuFJEcSxGHBjeamHzKD9Pm2PiaF8Jffpj9s?=
 =?us-ascii?Q?lfeldc9RJfDqn8PlR4sRxOZXpDxrkNzl2hscU5Sn0IiH19BcW9Vfuaes82Sf?=
 =?us-ascii?Q?ugbcRPFB2xv6ihk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(52116014)(376014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dU4TsF3XINR2U5q6rxmcR+JMx3w7nVPxslv1aB3yrQDZgo8Rntlxn59Hxpdy?=
 =?us-ascii?Q?pssXdvey9iH32H4+UPX57KQL+TOB4w9Xw1KI0gGA8nMgS43ZwIW8IH6fp7kk?=
 =?us-ascii?Q?AzL9yMDXb5jFBNO9oImwLxHIxrXRWU6BUObN59yNpNCqgCxW0gS02tnhvW1o?=
 =?us-ascii?Q?9+SYMtG+Vzbawe0x1W9YfoLPFh5QUXPyPoNP4xAu6sF20F3l7xDm1Nz9596V?=
 =?us-ascii?Q?ep/5flMveuZfSQIIVYLr3dVNou6duzU+zjRGkwoiVDDBTFonXPkL8xH78x4V?=
 =?us-ascii?Q?pNdgLCewqE919gL7WhaIwhHCDJ7hzx1Y/8coD+ueK64ER9G//edPTQqbWUaE?=
 =?us-ascii?Q?2ha8/crKQ4bs/RWluI+bs9xlqbiTh5q2uVSAiu+6KKGApJve2r+Vn/CkBA3/?=
 =?us-ascii?Q?uB4ztrE0ma0+SIcih4q9Rjp5FDrAi2+Ku/cB4jNFWFBDuBtCji13RCQL2LvG?=
 =?us-ascii?Q?T/63DB7BEUD/wk36j1+NOJ9BETrFEIvV/Rux5yjL94MQy8JOorYn9LFi4Uxo?=
 =?us-ascii?Q?WXAmop/5cwZQEiYxYZU+d1Zd8JybhC+7CgfIaMU5wivAElfwbi67YAkISpph?=
 =?us-ascii?Q?WIJmEdtm8H8Vdu1axPmcAgY4sEenKBDOtNYioszbz327v5ls0hUDZPFCH1IZ?=
 =?us-ascii?Q?hrH2lsqcpraGp8MjknHewBSaAdKMKy2I+fsJYJdim9c4w01kbjePQTKrQL8F?=
 =?us-ascii?Q?+qK0xJrOr0Bdpn4SvLK7/ZgTyIBChngKGdbhB8UMKpPG1LXov4VT0jfPLnpq?=
 =?us-ascii?Q?OFEnGnf59hEo3mfVKIJ3Xrxb+ZAANeDZN64I2qppQO4S8YNu1N3pw+zVmwsk?=
 =?us-ascii?Q?4R+MOfhN17ArAbOYcUOx9eeaI/YNf8RGh9GYQb3K5+TdtL/bcpmV1D/FbalW?=
 =?us-ascii?Q?fPMxwrB48SbY7WhRFx2WsviucGw32Ams90CsDi3bLJ+IpwLKR3XVsPVUCbzu?=
 =?us-ascii?Q?ezGSxf5exk3pTLQ9wRi3UmGs1EN8IuQxMhoFzb1jGMlZbF+waBQY76ujhxhZ?=
 =?us-ascii?Q?3Va/Hl85kDunEao4UXNWLj1Phxu6hWX6mq+SL0mA7wBHCslHhfYskgPxwOvC?=
 =?us-ascii?Q?czh1/Bb7jHyThTuoAlp8rKb04uHlyD7GLU5zMKch0x/6XDSKabN9R0lw68g4?=
 =?us-ascii?Q?EcXJl0gLupCEOhqRfz9Br6aFjOhYCT554lE0qNJS53r7Fd6Q4OiRhQwguz/j?=
 =?us-ascii?Q?/qccC598BHdjkkF49FmZ80HBOVg4OYeeMwMAvQvtqbZji429zuhmWNGqRhMx?=
 =?us-ascii?Q?w5om0YGq7509ragrFlmBAIc7VWjkAcxhiX2eEI0QjIUq4otFLyHGoHbuZQmb?=
 =?us-ascii?Q?OLbp5N3kY/mIyegNjbJsesGs/dAU5GP+iVQe6P4ZLRl/iI9gryByou6r5NJV?=
 =?us-ascii?Q?8ae+CXkE/Wx80dvy8yiKYvXvWmAsdJVMM/XcnevlVtbb2rsMbgK2vqnHpzBG?=
 =?us-ascii?Q?FrgnLqTDxxb412vHzMMJ6Bdqsfer42PzyIEW/HoKrGDdNQmd/GJSI2h4RRHI?=
 =?us-ascii?Q?pjm49duVwmWlh2KUEIXohsNeuL1GAsm/+hXJlHfvJ4Yosfia19NXpjgPmDqh?=
 =?us-ascii?Q?W3gFD61SHdnER5ujzH1qFOFnCabmI2CuKggQiZ2OjuYeHqTdXWELXbf0Bsd+?=
 =?us-ascii?Q?IwPbum2gEZZlWfD+E/yyqKU=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0765ae0e-9497-4b03-22de-08dd7e06e3e1
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 23:23:41.6343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 93fmPyY3eLLts4XgnQPWP2PjsYS2D8kRjxXC4WMEsZtHP+jW+ilTR4IlyfVmvcCrVhWhOZjjZnx34Btqlzb3+EzvyR45ZhFOKPm22+Kqnb3ijsidAE5SgB64blvCyoN2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB9998

Renesas V4H Sparrow Hawk board needs MSIOF Sound driver.
Support it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 5bb8f09422a22..b74f5810e0e68 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1010,6 +1010,7 @@ CONFIG_SND_SOC_ROCKCHIP_RT5645=m
 CONFIG_SND_SOC_RK3399_GRU_SOUND=m
 CONFIG_SND_SOC_SAMSUNG=y
 CONFIG_SND_SOC_RCAR=m
+CONFIG_SND_SOC_MSIOF=m
 CONFIG_SND_SOC_RZ=m
 CONFIG_SND_SOC_SOF_TOPLEVEL=y
 CONFIG_SND_SOC_SOF_OF=y
-- 
2.43.0


