Return-Path: <linux-spi+bounces-9468-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38577B27AD9
	for <lists+linux-spi@lfdr.de>; Fri, 15 Aug 2025 10:22:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17F84620B93
	for <lists+linux-spi@lfdr.de>; Fri, 15 Aug 2025 08:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228452C0F9E;
	Fri, 15 Aug 2025 08:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="fjqz3vaW"
X-Original-To: linux-spi@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012002.outbound.protection.outlook.com [52.101.126.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E59222562;
	Fri, 15 Aug 2025 08:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755246104; cv=fail; b=YWmFGN/sXgbl9VETX7nzowFP5YNmGZJMq06dNywXX7fr4SAQ39qa+misfjSbMvIyyOxhlG+rCQIQH5BvdzTG+tHMrr6U01tCFBUB316s1LGTnWZTcssrvD8Nt01Guo8hfH2mMqzW01AeEHPwWWvinDgJPJSwieMEoEI4u8R3pYE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755246104; c=relaxed/simple;
	bh=5eBf6Os3PK9iZFcsX6RkfH5U7+HbkPh6XL67XT3Q5Qw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pABx3+UU2dGDlrgScnmqXu3QhcWXpYgYFpq+Fm2wtctL6WTCui1jWUClX+YtBWPPWTTraaw/HaekhqXfV1cNI+xuUPqCwCNIk267ni17wYr+ioMSv3H9K0Di1uxpwVsDlqLipksiDKHbCMfn3HNxHiHU87xd5lNq3Y7VT647puE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=fjqz3vaW; arc=fail smtp.client-ip=52.101.126.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KEiZtXRt13ljHTluKXFcgw0aEntKTjdOdDcnWc5EmYQEfJGJIWziCn3hetLY10ozLpojbwAVdbIG1U3qYe9Jkf8DlJNNp3UuO2YYs1oR/76zJRDrsjzXfvG2+7f4e1e/tIg9pDHKAb6eYeQ063YgN6O3+NOzeOWjTXOh+6NBN+vsWfifirdoxn8UVq8Zhfk58kVIBfn3uI3ZEvpdBBOCRN2261B6k6+EOsdybtvfeQVM/Ue/Tj+aHsVg9UYDehAYZFUtHyoOfs+sp9gp7Qo7e4liNzMl5DsoL/F/nqKlf2Lk+YEpfLGMZvgxCKLliCkno0XNXpYMBRKxmmyU+lCXQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J8oH+vDuMZUEDE4yTcjO3WKzGaB6Qf3QPIQgPgmiMfw=;
 b=ihEtpZQiURKO6oNMb644u183+vcoBmKFO3sqG/QQBn7VWluu2JOW9M27cDjNp+9qcwuieVE85eEVoYSZXHLnZWbjCW+BaYsnA5sowJhry1iYy2mx3ZLIsolzi0sXtE7PRJMy45EfSuI6nMtUeh5VHuHKjZHYNKkOIKrrjK1LApTFJmnG6W33n59hNoGwn/P/V20feeBU/nHR5zRewAZzPwEVIz0S+pcCeS/PjvOUmZuY+Ek7krXOJ6cj9PBnvCIRVEwvfaQBLdkluySm1a4IKGIH8uzpC06/Ntffek3B0tVbOEHuAYTjsAbUpvho8LCr1bJI7nGqcKcW57j1zHd6YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J8oH+vDuMZUEDE4yTcjO3WKzGaB6Qf3QPIQgPgmiMfw=;
 b=fjqz3vaWJlY1BdSeFeUSEpFlOKfiR+Ko/kBDurA0NTjiP0nwweH6/o2E5mw6e2Oy1kU1zkK6S7L8IV7XUftd2bxbcT4YPPNRUnQtw0OrNGQiqR+LTQ8RSKem7q74Te+GCwP9+SvvrtqMxELHolli4gWaHj4HG6gEgphz+HjM8upxMhlJoZris4szMGRNAjnBXYUaDh9yTva8Ux0z1LO79vql2ohvIHHouDzXkvp9mh2Qk9+9s9hj32swcHoIOSzOjDyHjGjMizw3LdNWLaxVlGs3yOwrGqT3esmi1/k2H9WstzA3DwomI2gpHvzrR5GiMaronxP8bw1JBphx6PFsRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 TYZPR06MB7169.apcprd06.prod.outlook.com (2603:1096:405:b7::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.15; Fri, 15 Aug 2025 08:21:37 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%5]) with mapi id 15.20.9031.014; Fri, 15 Aug 2025
 08:21:37 +0000
From: Qianfeng Rong <rongqianfeng@vivo.com>
To: Linus Walleij <linus.walleij@linaro.org>,
	Mark Brown <broonie@kernel.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM PRIMECELL SSP PL022 SPI DRIVER),
	linux-spi@vger.kernel.org (open list:SPI SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Cc: Qianfeng Rong <rongqianfeng@vivo.com>
Subject: [PATCH 3/3] spi: spl022: use min_t() to improve code
Date: Fri, 15 Aug 2025 16:21:17 +0800
Message-Id: <20250815082118.586422-4-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250815082118.586422-1-rongqianfeng@vivo.com>
References: <20250815082118.586422-1-rongqianfeng@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0017.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::29)
 To SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|TYZPR06MB7169:EE_
X-MS-Office365-Filtering-Correlation-Id: 98628931-2ec3-4aea-2c8c-08dddbd4c0b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ithrR/Y/iDjhrt068oHMr6UanD6cbFZbzJYrpP58VAH90G+z4UPZOSCdgecV?=
 =?us-ascii?Q?nvrYl2397q5oftC4m4d8AQLLOp2FY3tqnpheQQ7sFNdB131jrvPQnO4rAxh1?=
 =?us-ascii?Q?glJNt4tPniJUQv0n6n3mv7NLST8NctQBhG5R4ofV6XSOoGjBnN8KKVTxqf7n?=
 =?us-ascii?Q?cT5lGT//uwC8a6Tn2iYwWEjyBo/qHhr4Sl03oRzzP5pxjQPYWcLkOVx09nuu?=
 =?us-ascii?Q?dkrL02ErW/n2P8GauJgW+nnfzI3dUQdqjqspPvx7xJUNnCuggQGMKK+laEDO?=
 =?us-ascii?Q?mDzM7GxwaYawmdbwItBRye1rV30/PFgNcgGttEAsXE7NA9o9E6N2bEs+lN07?=
 =?us-ascii?Q?/UMf5ks/+TfmtyGNM2VeyTK32z0L8N3QweK7dyljqRrAzixSqsUMNmsgnVPg?=
 =?us-ascii?Q?qT2qbH9n9W3mIKw1TKm14jz3hisD4cjPr2XffBQnaLT6+5t+63io+6GYM0iE?=
 =?us-ascii?Q?nICwcm+POXgtXkHIxRTyTr02ZJitVcSGJrqOZDbhfDJ198QEVopK1I3pDO/i?=
 =?us-ascii?Q?smNIYudN9J9PexkSB7T93zken1e1iooYp1uHjkeUbG+1LW+jBYsVyq/DjWCT?=
 =?us-ascii?Q?2dx9NfE/dKjmrEjVKysRWEdyMPVtIpu4uA0gbGzgjt1WPCvkshIA3Sl/n6/n?=
 =?us-ascii?Q?Hf/pjfK5cGcRU+/H/i3SKEY9UjngPed1RWPhvUnxpsAAzz+p+24E3LNoILhh?=
 =?us-ascii?Q?nlbn5EHG1oAWAc+N4UaJ2z1mSDc6PIz57OavH0qnZoWGbgPV4yyNqXAodXng?=
 =?us-ascii?Q?POAA8evZQtE7i3IHm3TbvmdcKEftvTpMTaS6nx77gql7gsHoXDOZUeg/TT5r?=
 =?us-ascii?Q?S4WUG4jJ+NEHGG2MgQPocRSw/C5mcToDVTVKy4Q/wLTAoKXWIYhb0QtvJB9p?=
 =?us-ascii?Q?JoTGjjJ0AAkTeY7P6oDIQK9obDcqMmM18MWC7crfX3klPQM9NJs2XYEv95W8?=
 =?us-ascii?Q?Pi7WZ7DYOFRtyU33OviUWU0nW9E/JV9kfyMnBtjBxmUCJ9QdbhPj1t/QYQtR?=
 =?us-ascii?Q?BOxzOhO6AQrb6ya4VVFwuHIMRq8knI1iPS68q/t7+hpwS33tr6oKF7/UE5el?=
 =?us-ascii?Q?PeDkXc1vRNuw8OshJlZ0G72WLtocdGPr55sBfKXQZteEsbh7m6036jEPk8AA?=
 =?us-ascii?Q?f8YtWL3y0DpTwc3SaLMP4bSCGkmhdh5VxwlPd30lLq1jneVtpkCwNrCddkqM?=
 =?us-ascii?Q?D2CvTGBqO3+rcTfnowJX4wCIn76mT31Ot9Iv3Eb5WQuZ+kUW9CZI+CBu+hFQ?=
 =?us-ascii?Q?n+/o5xxrdN8bxnmFNkP5QVTQRsdhKPCEqjtGa6e8s+oQVspCW0qxTKtykRw0?=
 =?us-ascii?Q?REWj17MuDL52vvY6PGqnMCEP4mKtzBxiTHR5XZ2sL/LYBj3SpwTBaXjNGRqY?=
 =?us-ascii?Q?UvI6gT9Hebez8Wlv9hsWIU1r+cCzab6zvR8KmGhNMceJyfS83ZQkc7QniI0y?=
 =?us-ascii?Q?UzTM58RWQBie/O7UL5x7VImEpCU1URDY2I5U/YbGlMOu+J8L3fVIHQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QNPjDDiaQqJu2c+BzMs8sJ6pS5mBVqT3s7D6u9ERttuYuvakA362aovooFo5?=
 =?us-ascii?Q?TIAIp49n7jM9z5AMx8tYtCQOuTRRIB+B1wndYPox0SbGZBYaPj6cFbxYrx8g?=
 =?us-ascii?Q?XApvVVKOCWbx9NW3K98XwqGGAHK2J0dmOW9Q5klSG4N9dY6BKEONidDclMHx?=
 =?us-ascii?Q?l8bg81oHcbfxS9qXveayKY1DbVbsMbt2/zobhpuhZcd71IBzq5xAdK6IipS1?=
 =?us-ascii?Q?Lkrv2lClJBIgmCAs1gyRBDbErNR4/SGwx9jDAeWKdvk2WXZzvj+88PWzMdcB?=
 =?us-ascii?Q?uglcYL0R+Q0mLdSkj+41kKOwBByvxau1+1F1Wv5HQbz9AGl/s+Koatv3Simc?=
 =?us-ascii?Q?3GV3BMjLjHQ1jO2OyKv1n71H1D/6nyf9x8dGMKNRPf8v3bfLMe2gIZL3pMMG?=
 =?us-ascii?Q?JcxwK+3x8/QsvXHjNm4UMUVwFIBhhQttgo7ozyNHFJJyFhcRiHgdMDYKcZPO?=
 =?us-ascii?Q?HZtxApnuDojwlaZ+jIRLFaUJcGloqkWR5D6fuFeAha+PfAng1lieAseLf415?=
 =?us-ascii?Q?b25v67vRy/1/BeRzruF9BPVxp764pfuaJqNq2QIG5hPg3uTYe28QJvIFbb71?=
 =?us-ascii?Q?FWzrlFz33WhhGy31wIx3UZ/MS79Mdd5JF6x4my41LUt3aTp82g//C5S07401?=
 =?us-ascii?Q?Uy0SPvFu+n3XwhUPub9h3gLJg6EiORtkifLp1kccNDrdE/xadhcFXmt+WM1q?=
 =?us-ascii?Q?B4E95HSbnbH6sBKer6hpBgxHgMyzzn+XhFRF4HqPVVU8sZ7ppkqWN0OcKKZR?=
 =?us-ascii?Q?AKDAbFcWJOXBispfMeRDj8X0WgY6ewFs3o9A1XYlglKtPkBWmb424UfMFLNn?=
 =?us-ascii?Q?Ux+76uO2XeUNxm/WbUzRJ8uWJ/ljF6AsOij1lo6S/PRZIxZgx8sX5wS2pNtt?=
 =?us-ascii?Q?NpngI5i6aLZ3/xFcFNekME3UYR7pVKUrbEY/l5+lE6eWy9dcj02NnE6OK34q?=
 =?us-ascii?Q?GJ1E1RfoMU7ycNcQs16DbekBeZL3coY/XxSRA7KxWj2Yp4Hj/sVaLxUxCUBh?=
 =?us-ascii?Q?H7GYNKIuCJITdJItSAud85TEOdiXFDEW2s/vx6UzqhnpW/U0aG8K+f6Qtcqr?=
 =?us-ascii?Q?fh8KrxKDRYyco4uM34gjTK39WM4m9h9k++3mTf2H9cBZUdcuaHhljQEniGfu?=
 =?us-ascii?Q?0ycdiH6Xeon7Cd6R/zkS42NyPpiUAs0dv1lvYZPTejPRZ6mXj6Y2Q0Mb1O4S?=
 =?us-ascii?Q?4bj0XCz7nXjBt43Nwi3v5uZdlv7jtoRI3BuE6mqqpHpW78ZQfMrGeKXx4ZDL?=
 =?us-ascii?Q?zRpZP9WzlUXwznbotCO73L6+dJ3hJj1wf65VP2JOIuw4C8wW/+spEHvSuQFD?=
 =?us-ascii?Q?ogRpYTp+E2Wl15R2W/yQtDHxgOHrz/LCh0TIfP2kvAr912gkU45qtI5gjYJI?=
 =?us-ascii?Q?t51XoSIqAepWA6fo1QJtLxN37Qq3UI+M/U7pQ5THaUidRqSqYO1xOGyctX8Y?=
 =?us-ascii?Q?4duC1yq2qlQTWPLrXvQzwMfJrxSbWq/uLOjlGJucz6iul4rWf/U+9uQ2UFhB?=
 =?us-ascii?Q?C417yUDD8CcE/RAS142EG5frE0Sjy3n0B+E3ZSH3eRhheKC7MJZTKUQfmfNK?=
 =?us-ascii?Q?X0/GQ/WlLojH7c1INBD7mtBTqHtWen0HVwQ9yAgK?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98628931-2ec3-4aea-2c8c-08dddbd4c0b5
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 08:21:37.0591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EbtpUGURBZ0/fxtSOHnTzVXcYDnHM21GVB15H/dwpF0qMiMmKtOY64Dxb7RtYF2zKXHxWnNPAJRUjfWUp41bKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB7169

Use min_t() to reduce the code in setup_dma_scatter() and improve its
readability.

Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
---
 drivers/spi/spi-pl022.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
index dd87cf4f70dd..9e56e8774614 100644
--- a/drivers/spi/spi-pl022.c
+++ b/drivers/spi/spi-pl022.c
@@ -33,6 +33,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/of.h>
 #include <linux/pinctrl/consumer.h>
+#include <linux/minmax.h>
 
 /*
  * This macro is used to define some register default values.
@@ -760,10 +761,9 @@ static void setup_dma_scatter(struct pl022 *pl022,
 			 * we just feed in this, else we stuff in as much
 			 * as we can.
 			 */
-			if (bytesleft < (PAGE_SIZE - offset_in_page(bufp)))
-				mapbytes = bytesleft;
-			else
-				mapbytes = PAGE_SIZE - offset_in_page(bufp);
+			mapbytes = min_t(int, bytesleft,
+					 PAGE_SIZE - offset_in_page(bufp));
+
 			sg_set_page(sg, virt_to_page(bufp),
 				    mapbytes, offset_in_page(bufp));
 			bufp += mapbytes;
@@ -775,10 +775,7 @@ static void setup_dma_scatter(struct pl022 *pl022,
 	} else {
 		/* Map the dummy buffer on every page */
 		for_each_sg(sgtab->sgl, sg, sgtab->nents, i) {
-			if (bytesleft < PAGE_SIZE)
-				mapbytes = bytesleft;
-			else
-				mapbytes = PAGE_SIZE;
+			mapbytes = min_t(int, bytesleft, PAGE_SIZE);
 			sg_set_page(sg, virt_to_page(pl022->dummypage),
 				    mapbytes, 0);
 			bytesleft -= mapbytes;
-- 
2.34.1


