Return-Path: <linux-spi+bounces-8651-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC53ADF060
	for <lists+linux-spi@lfdr.de>; Wed, 18 Jun 2025 16:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EC10189DB78
	for <lists+linux-spi@lfdr.de>; Wed, 18 Jun 2025 14:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 688C72EFDAF;
	Wed, 18 Jun 2025 14:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="FW0ol1fk"
X-Original-To: linux-spi@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazolkn19011030.outbound.protection.outlook.com [52.103.66.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09822EFDAA;
	Wed, 18 Jun 2025 14:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750258470; cv=fail; b=HjeYWc1NLborQM+sPUPgWCafftO+nJC3vI7cU/ndwuacpnePkgeLefvswH9PjK6FB/4RnL/21JMZDlqLaOXCuRCMOLVJFmEiCWFwKVqIDDEtmoPlk/FbvbO6TB2hJne2jFUFFCzSMwgc/8hBcbf54pWeY3u4Ax5I29LkFMwdYNA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750258470; c=relaxed/simple;
	bh=EtBQetKbVcctCPa94k795vvW30SjUFZvKnXgNz56xw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=haDOrmReTkCRlSNdyLSYQAFPc6hBUTK1nZ+b/UKUbS3trs69ohhUdCS/3rPTVgA70rxqXX3srvViZEk+pDRuxvytwB2TKgg/S82LF5AslN3ZBoDFGTQIYX7okye6I/f8VZDsCeO0UwT80/F+Er85XHPLE949eshSmqNjcjhyZHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=FW0ol1fk; arc=fail smtp.client-ip=52.103.66.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vr/hX4JcCgcmq4uFxcJLjiLcGVYPcV0N7hcXWOmqo4rJMLbtpFxpDNy2NbMG7Y1nOq/Nj16ZhKYaVm+3kyaBVwNq3W4NEC4nLbqt6LHcI3b/f76cGNqXTdtY8AkAX5ByZllApKyAVulg5IVzHcPqUAx8FHoItJ/HLPiAC517s90I+XyNQpvmyDGsryfK7+KqeM17LXvgXPJ5ZyLoujY4uz6SCe6/D+SbBM+3RFv6vPDW/zT8bLRZTsSPfwiRG5Mo4UrGWHPJ/dlnOP2VjJlW6Bzt08xpU2F4rAEsL/3BfH3eGzJiMGnNcxr3j0tn0pcvTuUTDt7bstgLspzR4KGqSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7n7fvm390KQo7q46ELiEXb6bb0ISGRq0VP2z+a+23GE=;
 b=R+cYKOx/HEhIcoRlfg3OJ883rZl5CABz2eWjq4p7/4YLbB40k+jH/VJw2u0xgQ728PoIwowRF45pqG0tROy2FhALxP1teSLhPIKMRm8pURLBKpFzGHjvSy2STfg57D+8YX5w4epISupaB2/ZhyWoO3coX9vIUdvxo9q/Rw+zt3xKhwSyTeW4NIiXTr8Ma/Yg+n6MA+JYNT3MTlgdj6JeEAiIvCLXTUwO49jWNV48MKP+HndwagSfBLX6PmVX6Jnk9gYxwY4M5C15qbbahGNUZkHgp6PSxG0Mptk395jQkL7pJlpohWBsyLtpQRuBhl4UkdFvzmJfFHQ4nqDyvVJVog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7n7fvm390KQo7q46ELiEXb6bb0ISGRq0VP2z+a+23GE=;
 b=FW0ol1fk09FSuRjbzfQPKl5169KTvADyHsCfIn8Yf4f8paZExUkmvnkqOQrl/KszZcyw5PCPFm7jQUy+S8efTqX32J5zpmObXDQDqPnbP+UI+X7l1+zcI+2AZx2Dcix3zUexBckUM88jzUzauGT1EunGRzPD7wnJ9C9zrlVhZW80/hAVD8ibRUfQ0F7IFindgZg7sPpenP74X7femY0TlEn8NilOEDCkTF2s82Dni4XdZPhwAaiZedctg8Uv0tLAARn2x6m+7cfvqSHqS7qLfUdfwvGRfJMdRd7TM0YXlOiTWaRzZObg+PcqSjo8AMddx9tepy3rqJzuwkepOPUUeQ==
Received: from OSBPR01MB1670.jpnprd01.prod.outlook.com (2603:1096:603:2::18)
 by TYYPR01MB10545.jpnprd01.prod.outlook.com (2603:1096:400:30e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.30; Wed, 18 Jun
 2025 14:54:25 +0000
Received: from OSBPR01MB1670.jpnprd01.prod.outlook.com
 ([fe80::c00:ec4e:ee7e:9b7f]) by OSBPR01MB1670.jpnprd01.prod.outlook.com
 ([fe80::c00:ec4e:ee7e:9b7f%7]) with mapi id 15.20.8857.016; Wed, 18 Jun 2025
 14:54:25 +0000
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
Subject: [PATCH 08/16] MIPS: lantiq: falcon: sysctrl: remove unused falcon_trigger_hrst()
Date: Wed, 18 Jun 2025 22:53:21 +0800
Message-ID:
 <OSBPR01MB1670DF07F99C2AD77374DA98BC72A@OSBPR01MB1670.jpnprd01.prod.outlook.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <OSBPR01MB1670163BDCA60924B3671D45BC72A@OSBPR01MB1670.jpnprd01.prod.outlook.com>
References: <OSBPR01MB1670163BDCA60924B3671D45BC72A@OSBPR01MB1670.jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0054.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::22) To OSBPR01MB1670.jpnprd01.prod.outlook.com
 (2603:1096:603:2::18)
X-Microsoft-Original-Message-ID:
 <20250618145329.25517-9-yangshiji66@outlook.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSBPR01MB1670:EE_|TYYPR01MB10545:EE_
X-MS-Office365-Filtering-Correlation-Id: 9842ef42-ff7a-4c39-75d0-08ddae780469
X-MS-Exchange-SLBlob-MailProps:
	Cq7lScuPrnodj9mcbuBOlkXQjsuE+OXdYKyAEtJ3cmZn6lwGvKZfznIT7AQWJxk3TCSy2WiVlOMOor90TDtOVHX3G+U+NaMZOZz/UkOGLKDoqvzGOlM0Szl4HkEp3LUtSXqTnBaCUjEMa4VQS/acFwXhWN5KRRimh/HzeybU2WyxsmDIpZHkfBTtEPyw2TYlR1tOIr4/CP2EBYADyfikHQuNtEWis3tT9m62FdqKqCVaHHDEZ0c3ByGBwqfImxMxkx02uwaTHHbwiqBXeXTeOSY69PBdXz+S32EpS8WbiErEMA/fH37x9P5CnseivKGLLl0QqO3vgE3oHThXSdBjOthGSZlT2PhXpL78GqVggkv8oT9dw4pGFdP83oZXJGleDn1Z1Cn3EqqKVu7wZemWx7/gq+Z1/SIysXrlp/oQCv1Y2MqYIDuG1l1hhKdVN5B9bvi7If49Pr/NhU7PqF1HS26cMvC1rIkD8fi2F1xXbwwGuwNVuv9MALk+7JEJTeOKJnZiX3+sdP5F+UWo0mnq0KnS+IC8bG3n2UbfEJPOgZATii/g43eCFXmi3NT+dlSIbVNy86soFBXmM2ymeoys4aShlsvBIkOwoaIfBeVO4QiQ9pe1ICSM9pCRWkH4FNUJV3UpquFRZlsm4i+7BF7UmeJneILy2DQyNK07SQqb9nEEGZHA6CQf9/zpfGj7Ndcq+OPcOzn6Md9f3jSLRafo3IImuLxsOZ5jXtiuXuAl4+QpMGpmLsoky3u8eqJ7NixjEQRQIHzXmEg=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|7092599006|8060799009|19110799006|15080799009|5072599009|461199028|3412199025|440099028|40105399003|51005399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QhKzBJwuRtgIPvhkNtDh5UMEuNo4iPFmj6m1qcMa+ZjNdM2pgt8Rjiwq4jQG?=
 =?us-ascii?Q?zhmSYjm0em+U3mgc7vTqzAINySJvK2RNWuDp4Q+LFIgGlE+gY2rzBrpoHeYs?=
 =?us-ascii?Q?XnbNRbQOYfmp4Heu8Gxvee1r9GYus3x5pyp6h8ZMIu15xXxsYT8oGovjekg9?=
 =?us-ascii?Q?qQRc3xrvdC+2nXFjmMgHDZKCGAoxlngbtOG0IeQrRAXxD1rRcIjRU6hRnF1V?=
 =?us-ascii?Q?hDueYCDz8JhRXOta/Qgaj5e8c8cH2Z+Rw0oW5ZNtk8na7WOJmItU0ZUG63xz?=
 =?us-ascii?Q?gneys8QDDgelmtgbev63IEksTrYW53wX5jgJTOx0YCpi2ERegvKzFl8bISuM?=
 =?us-ascii?Q?SeMK4oqjgGrgEguV1gT02tpyUH5JALyoQOb0E5xHCAh5F/TXU3XaDeiTzqcD?=
 =?us-ascii?Q?KZC8pW6G7/NswBesziuRhN91a5usAilyhcQHGK4/7+bQQwg9gS4YA8rmwTR7?=
 =?us-ascii?Q?cd+fgWKsUsApFSvC18M7wvw8FgC9YOOaq+rmXZz5kKFDnzDo20XcIHicQzRo?=
 =?us-ascii?Q?BUja6WCInqMUb+IyzRG4NbRbYOHblR7KjgeQGYL126CIiFTMkfxTOVPL7Ex8?=
 =?us-ascii?Q?7EvyiKWPxUg2z11wohMQ0hAO7OcCcCcGa+Z0Folge3aZEYSB5uZai0xPAcGD?=
 =?us-ascii?Q?igs8M6t6s2IdNaBXo2MNd3eqJzdewoWEme1VOZaHKjivo5uVuMrtGAUBk3pV?=
 =?us-ascii?Q?836TeNut3xEG9FYz1kmLjKhyCsLt8Jh3nwYWyDpBn2785MfoBzqpHYl1pSzW?=
 =?us-ascii?Q?XZ4tAMf+CCwu5VC2MHyl5z57ozsZjHlTW4hm4vrt3UehognHSnulrRA/Otqd?=
 =?us-ascii?Q?X2cG5Rm23il9fG6uHlCgO4jFAeJdecK8wWMmV/KEQh8rmmsXFFQbPFQq2EPt?=
 =?us-ascii?Q?GKoxMNybE/+VVkIP6E3eo2dUFjJgowYPoNKkt3cqWqPFjguyeHIkcSnjS6l0?=
 =?us-ascii?Q?KGM6HEtmb0nmeLjsfaQiyQUgtZuRvtn9Z1zRZLnRNWbh0h8EbvIs4kiwWcJg?=
 =?us-ascii?Q?tDcbFG2AU2opfV1/o1NVbtULddqJmzZRe8z2qo4flCI8uVZ1/PnqZS1CwBCS?=
 =?us-ascii?Q?Gz9/fti5FKR1pHJ/KugvcZwUrZjLWTlyImBJe9skeSd/7EDPsThrusNukDic?=
 =?us-ascii?Q?D4uT2baV6TvM2aW8NVPyXFIKCq0SK2iqoNLUiuyYoMm6/W5sL8I5tX/jAyyP?=
 =?us-ascii?Q?Zd8WsmIn12hnmIPW5oXWKd5ahyKnr9yi0WUQ/Q=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7Hf++G0ZrYd/JZpL5jtOCKWpb4qEzRTrLrZtwjJ/JeRU+ZCgjyiBJXHki4q8?=
 =?us-ascii?Q?SuVBSKLTY3rSQbMhVOPTwI3957dX29ss9GCls82n+0Nq6l8feshM+96CHojv?=
 =?us-ascii?Q?zrH2MfDTnUUxrLE+ZzCZlIK+CfrvMOuTsBhqR9Kt6K3DxuQGw89OjvEMgHmK?=
 =?us-ascii?Q?+4Hgrfhk2Gn6FtvCKnLV2+08k2ouwtFjPRlxQIsi6EZkHoSXs4VVTQnUG2gy?=
 =?us-ascii?Q?fbpXi3CU61/nqF6XJeCSC0s5yNfTrs37ETQ9T/Nqi2hXCIDPRfLepxndbVFe?=
 =?us-ascii?Q?ZcjVNgldYHTSC+mxv9ozFIol/f/v/sVolkhZH4ECKwBRJ77CG4ND93P/D/qG?=
 =?us-ascii?Q?uFKXl240b0D3DazlGQpLzueNQ0BD1RYEubJ4rbQAjfAjJscXNES3XOyMmTSQ?=
 =?us-ascii?Q?QQXAZeG/xnzrILrwX2DgcyjxpIOSnMaWabh7ifFWJ0oE/l0ZJaZbFZMXi7Wr?=
 =?us-ascii?Q?BnYaZQCFWBFyWjH+VMZvHf+8/2kaDJOOXrtdBTYidTRbEWwTacoU5uvObkxA?=
 =?us-ascii?Q?d+DoK2Kf/3662xm3WI25NdIENs9ra/tmvJWLDirVbGF7fFvYmdT0TWnrBp/f?=
 =?us-ascii?Q?waN3Lp8m+ocJv8RdMfngk0XrJHcnqbV96RLxwbq9RkWOHw5jIi08gJRk/M4O?=
 =?us-ascii?Q?JsW8ssRhfNLVJaygUNvSXIjuvbTBgXgCPHDZUnSNB+zwnK3IhOZV+4S2sIGn?=
 =?us-ascii?Q?uVnndy5TLAnntdgwPDgs9tRuZ6gcVsdlVTgcaarDl5JsVTqBKUg3HpClP5et?=
 =?us-ascii?Q?ek0mNj940IO184pdBIJIX6hxerUlIyFM3iXFIXcM2BjuDyFGz02rZRhj3ufZ?=
 =?us-ascii?Q?Fpj7nJipRfNB/P7zj/zsaxxXeLD1rhKq+GrNQjqcxHaQlcDYaS/QcYYoEPfK?=
 =?us-ascii?Q?3jFk102fiLngbtDI5G2Ve3bvzgxPbexn82cCWGQ8FmewMmfJnFTfew/fdtDG?=
 =?us-ascii?Q?lOVAUo1dfLe8ZEvwROLLpHjSCGm5m9BX6PgiPgZ8clMUXPooj0SiOCrMq2Vd?=
 =?us-ascii?Q?H/Fvqa4VMkG2y7lsIr2bfmp7mozkJDbaMjcDNUnxvx7lttREGDv8BUPiNW6H?=
 =?us-ascii?Q?POZXnmDvVEOz7l01u5ux0JpiKaVYRx4eDBqTT6/UrxVSyzfoT4fdzgiPB/EM?=
 =?us-ascii?Q?ERMvsOBWPcPyxwwhOvM9jiJRCT2DxE/qZQnqxF0j6dOFHciW8VNUt8LU9HBC?=
 =?us-ascii?Q?+LPrUptitAXopUQrJarTEsgs0OCWwgXuc+UjdqcPMYo8PMK2MllVtWfIvXbm?=
 =?us-ascii?Q?VEIb4bIyyfY9bR5e0mxb?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9842ef42-ff7a-4c39-75d0-08ddae780469
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB1670.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 14:54:25.4403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB10545

This is a defined but unused function. Fix warning:

arch/mips/lantiq/falcon/sysctrl.c:75:6: error: no previous prototype for 'falcon_trigger_hrst' [-Werror=missing-prototypes]
   75 | void falcon_trigger_hrst(int level)
      |      ^~~~~~~~~~~~~~~~~~~

Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
---
 arch/mips/lantiq/falcon/sysctrl.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/mips/lantiq/falcon/sysctrl.c b/arch/mips/lantiq/falcon/sysctrl.c
index 1187729d8..c65f05115 100644
--- a/arch/mips/lantiq/falcon/sysctrl.c
+++ b/arch/mips/lantiq/falcon/sysctrl.c
@@ -72,11 +72,6 @@
 static void __iomem *sysctl_membase[3], *status_membase;
 void __iomem *ltq_sys1_membase, *ltq_ebu_membase;
 
-void falcon_trigger_hrst(int level)
-{
-	sysctl_w32(SYSCTL_SYS1, level & 1, SYS1_HRSTOUTC);
-}
-
 static inline void sysctl_wait(struct clk *clk,
 		unsigned int test, unsigned int reg)
 {
-- 
2.50.0


