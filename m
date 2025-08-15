Return-Path: <linux-spi+bounces-9472-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 126F0B27EF8
	for <lists+linux-spi@lfdr.de>; Fri, 15 Aug 2025 13:16:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50C841C218FB
	for <lists+linux-spi@lfdr.de>; Fri, 15 Aug 2025 11:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D52286D50;
	Fri, 15 Aug 2025 11:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="zGohtn+5"
X-Original-To: linux-spi@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021137.outbound.protection.outlook.com [52.101.65.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15690284679;
	Fri, 15 Aug 2025 11:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755256596; cv=fail; b=S8nweZp8Pu2tnDHa4gwcg0RevpsOl1kyiS6r0PlNi+Xem0YEO5ufSMQ/qKUGOa2gf2ucEa+oxxg58NL/8prweb4p++34oDrqNpFxbzDxnIq+QJBTgJAEfjI2OCERc1CaCOzyKZy9kJmib+LrkdOGZE6pxrrzjJSm72xI042jArA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755256596; c=relaxed/simple;
	bh=YhljvTU8sOsbfe7cVpGZsxhGRVCeAwZB3Lt4U3yEJVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mZyLr/FdleIun9xfVoZdTglLzdV4dA9gfLRFf5HhnzuEUN1lwKcID1ZO2HGZqDCbJUu9t3ewvb2b+Qr3oaX6fNpCq12qUExeOG1eOLyFPEVQzjur5njQscoPO0+XCC/IlFURq5dwaChoUfFNJkP9dhNwpIWoonUNPi5gqiU6xkQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=zGohtn+5; arc=fail smtp.client-ip=52.101.65.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jzRQRrrIKO3IMaxpfUuvmKTP46IEVX9YcMFNAoc713FvxunnZpSt391IfJkhE8X5KJFc+rFPgoq7+X1eiyFGMY0wQRsTO4aRqpQnQlAvHz3q2psinWe1GPPrPKhBMxbxssk3Lg9HtRBlf9y4XGzZcaEOFkbRwFl+JX4ypxslGSQIqV75n0fu6AGCiAAAC61Ujq6IPs5PC7/NT5pWsGWw+yX3QZ789aZQ8/R+WevL4nU/mW2M9teXjgOSwRfhVeN4maal9scYxO3bfZPC3TO1kA3YCv7uBRHDPxe48TeuVPrxfL30fxyhXk5OLexxBtwge9LeSRGIS3MMe+mlC54Ueg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dDgwGYeWXfizYdM9X3UyKp0MK6264/KDeaFHyW3IA9c=;
 b=DJqo34ZWHvAKhlnip9b19LiuGaqcvJ3ix1EUBZgQIeNPD2FQT4qTviN8luh6jhkjItMpBgO9zw1zwBOAa2svImlEqYywWtUKgtu4eVxipXNi3Fjk7O04EYkhw69tSMS9Wk4Vu4fKTRtQTyQEJed7BtnoO0B6kAI5YAMefdh0Foo6IjGPiSLkIPDYMDSblCM8ABLr+M/x7OBCDTQn/ZpNn9Nb/iN/vzMW8T4jUt8C88BGotLYh05FCwzbuFzHfBGtZFt9FaPzYhYE/K5m7FGf1EAlxzSwCf6Qce69IuvHA7voK9+73SB7ae3rqU4maPsKsjdciuKJ3/8ZvLd3CCyXtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dDgwGYeWXfizYdM9X3UyKp0MK6264/KDeaFHyW3IA9c=;
 b=zGohtn+5uA0hEVhQw8AOOkR53bfBTnxC5tw5KqjYkuxvGFniYot7juxkCx/OMDAXBTyIU+SEk8kagUE2dHERDXVVN6qiemK0ktI4PJQbQtFDSL/2RBSm2yopvX4OnPy0+Zb5IttjKDKvQSjzzwy8o38orGHv7b6y2RMVoEcTu5yzggSFCsORKH/IFN2pT4QxoY3aJdSygAjuV9LbR1NVjrrqY/AL5tAmrSkWc7PqvZqprEEi+vPLXgoj/u3cxX7rvz53y3Sp2S6tvixY6nKIAObh9gEroGsyvJA1GjbsyKgr6TpZ9pgEu061t1VluGDHqbVyFVuWdo5HGLUA4TjSiA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DBBPR08MB6268.eurprd08.prod.outlook.com (2603:10a6:10:202::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.18; Fri, 15 Aug
 2025 11:16:30 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8989.018; Fri, 15 Aug 2025
 11:16:30 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Ray Liu <ray.liu@airoha.com>,
	Mark Brown <broonie@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v2 03/13] spi: airoha: remove unnecessary switch to non-dma mode
Date: Fri, 15 Aug 2025 14:16:09 +0300
Message-ID: <20250815111619.45001-4-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250815111619.45001-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250815111619.45001-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HE1P189CA0020.EURP189.PROD.OUTLOOK.COM (2603:10a6:7:53::33)
 To GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DBBPR08MB6268:EE_
X-MS-Office365-Filtering-Correlation-Id: ba2c2302-649b-4cd2-b8ac-08dddbed2f33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MYaov9lw0hNXlT6sHjOtNwulcPAbxK2GXFFmeGqkxTKF3JNMtQ+30FmUqQMU?=
 =?us-ascii?Q?LMJGKRxaMAvC82iT5u//YmEo/0JgQ9mNFO9C6o5jp7f/jl6xIEp3bWmjPTTL?=
 =?us-ascii?Q?E0VLQLlC4zMG4n5RVIuY65cznNkZpmZrs3Jon6qHwvMmGGjgU9x8CDcvPfrp?=
 =?us-ascii?Q?dUOYxFdzgcbp7lx4oJCGEdCk8TZ+c0gvudcLjvs/Ga9H33lBF1KrNrEt+xKb?=
 =?us-ascii?Q?L9WhhQ0z9Xog4hX0+wZM1nBsDT9d7iFHhYAHaziJMwm7pGJAuDpBTLIyNrGA?=
 =?us-ascii?Q?1yrYQnii3aKiwbDSmY+SK/fle9ou7S9E+yPKXGkkWQujbykf8rvx9YUOEZa6?=
 =?us-ascii?Q?MVDu2eqWyitr3gL6vhdMAMgKJZ5kvCQl8hbglHdHElH01bkJucyNGtzvGD3c?=
 =?us-ascii?Q?GYUlKD2rr4uBfl3jqb2vP+rnqz05UXbjMi+pxI09pf3n0MShReFja8j2MIY2?=
 =?us-ascii?Q?uND7q7422lhcU4UFKwZns+T0HOSUynCAGMbUMOy11MISTIHWuFXLmI32Gupo?=
 =?us-ascii?Q?so9fz83PtcP1xnLKkQm6NuLIuJHeppR1l9zaj0WQCI1Xhdg/My53q41WPoC8?=
 =?us-ascii?Q?NqUhUWSCy+/+SKWDfGuKxWQxcXSyxe1Xr8UJ6tBinSQfVr+Mpy2N6JNC2MRX?=
 =?us-ascii?Q?KZZS5k23k6BAL51XljiixClUQF8jRk011g/4yAcu6135NJuyxCcEIVWV+xlF?=
 =?us-ascii?Q?mdN2ihLx9stKkPBA8YLI6haQjvoy8pVki4eGG345jMY3xvBcE6J1mZg/KVPY?=
 =?us-ascii?Q?opg26Yi7GF9+0tO6tXlu2TfL1px0/1cfIhSMOr4lz9vzN92bFPB5fceLxgG9?=
 =?us-ascii?Q?UNDAj2q0MyuxtUGLk0fAHF8zeMHifxTw/IsFBUMYsIhsw+wLslwk2JcglMB+?=
 =?us-ascii?Q?LB7RYmcyijwAMfcbZsnxgrdUM8svI4dqqVZbqFJkU0abG+If+a4H6w9sCCVM?=
 =?us-ascii?Q?CHRfq/cm4qW14fcz+1ODFqkGkclMbayFBAs+If8SDej478PhsmqS+fYM0Eef?=
 =?us-ascii?Q?kUEz8jM3fRBkzo4ar9wbhUgRuYlSF3v3D1XoWyvkIwtLY2DqPYHwKVnFLx+2?=
 =?us-ascii?Q?/fVM0MfWthGEMUgmlxm0X0lWLrwJnm4U7ZK/HR/qbcsbHh3+e+n1mRmpOi6T?=
 =?us-ascii?Q?RZXUieG60L3o7Z/24t51pKzFo2qxpCBoU6LUGzfLnS35skurklu8d0SrKlsb?=
 =?us-ascii?Q?nFKPnMNrN6zQPBxiRAm5R6atzxwHbH26NySvMvbmmwquB6hTDxkUu9OKFl+a?=
 =?us-ascii?Q?aDJPHXgnY4elrso+G0inoQMfxetuzuH96NUM5SUssmaP421MmFuNMnlknCpc?=
 =?us-ascii?Q?8vI1LmhLnvAxK+NCHxwpT16RCN9k6xgguIrAsl0l6pHFRtUVzZ5uaALvu2bZ?=
 =?us-ascii?Q?MHnOdP38U91xPSn5F+4HUOrR+FEzDHdxAiKJzuFPDZlBEI71wq+0c9/XZNak?=
 =?us-ascii?Q?escY4pQhKltxRVMHnkXrPE/LR4LOcia6JFYgjbmfFibJ6AAjAh65og=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?t85x5V55LnRzVPiNrjpeT8JSq0jpW0nE/sSLMEs8UIG+Smld7tdXadOubb4d?=
 =?us-ascii?Q?rPlRu//Vu3pfFJfSCakdGipYQKiZZFF/cyK+BzgNTsCoXLQdcVusqodqSmbd?=
 =?us-ascii?Q?Bj4+rBO6/ul+MhQhSkjlZbGZ37xl8EyQHQXr+CwwJmC9eX1Eu7GgBfg1w/nB?=
 =?us-ascii?Q?JrNlHDJ7eJt2FGqMOXMQ41ZFYdvx+P3fwFy38WbFlm5zvaJw65XAfrbtU6yP?=
 =?us-ascii?Q?b6Kx5igJUxsHzNm5CK1fmUoda+7gXeNJfSg+JQBZ1j1OC+eqQFRgH3jLDmb5?=
 =?us-ascii?Q?VhV3GOxScVyKAYrxUD07VdKgoXubsg5wU0+c3shV+1+WOgPshvXhW+KKhFS9?=
 =?us-ascii?Q?v5mAqTOwloHE2+JHJM4ucsurAAy1Q9Mqgxqnd7QcZlJTKXC56idbrabjknkT?=
 =?us-ascii?Q?Nqf5IPwLAamKm4bMYayL/1zkpSg1epAyVCDWUAYR0Y/j04xjkyjprphFG5f7?=
 =?us-ascii?Q?fP76RCkuiUdWbqjPsHOZTpyFSlXCv2yjGZtbc8CLz/eZx941gnKM/4rHrQ8s?=
 =?us-ascii?Q?eeiY6peEKUqxu3WcqK7i2LimW07rrs+SLLaqspKgfkT+ZcYTGi8w/en7l4KP?=
 =?us-ascii?Q?IuMJfo43yWcibaWTVclJg2Don2x3dt1Y/gmJsu76f6M88Nul+0S33DDgbspG?=
 =?us-ascii?Q?T8rWabPA6HeVX8ESkpIE8Yf0e38+OMXRsW/Pxke6VAPRW/2ywtOlO21+uQ28?=
 =?us-ascii?Q?3cHDMYObrHBPX1y+shgK1JPbty7BVo7aK1oHet+71iLWUUiQ6l3TVrA8Obs+?=
 =?us-ascii?Q?h+J8OwgzMrPHpQjf05WAuami9pKWJGOApPpUA40uI9XTKya4b1Q7RSnbuLWn?=
 =?us-ascii?Q?R50LvIObzgr9PHNEqz6ytlN0uWuia8xWp1BNTGr0nF5ljbNayH8oqX0QpNOb?=
 =?us-ascii?Q?P1XIVug9lJrGRrm+dgVDC1HOoETCdTkQFi4I4QuE0Auyrki1/WnHtSFkhfeO?=
 =?us-ascii?Q?lJST559ewRTYi/oFA4YIx1xt5p5H2VfNDxjKK+dMXPwm5HefW8Fn90ghtUpi?=
 =?us-ascii?Q?WnTQFyAu27H0IY2tqLt4WJBgClva5/d52YRt7hW1UVrgyCOE9tPCIstWCTHR?=
 =?us-ascii?Q?W1rKH0u+Xb/T05lT3O6/tcyiXHsKQm7EDHp3+oXZnIZygjwuOPVToEPfmGGs?=
 =?us-ascii?Q?5WOY2AgMBMeHlkthkAR/eZyPkVsqmddh+tmQdOKehCrOrf2ZDV9FnBwtXo2Q?=
 =?us-ascii?Q?YMRtqvlJsSdu5Hb5dV3bFDGiLdoAQB4QliU8tUs/7IT3xxQKGb+4Gakn4cQ0?=
 =?us-ascii?Q?/U0G8RYL7iBuxk9hL0Gjarz0R/0imeoWncM3hoTS1z1327ksDOf3jssxmfmq?=
 =?us-ascii?Q?Pha5lYMXg56WPH0lcXMewOVbAJAh7sU3f1nMueq/MqKPv3o2XZYWkNYYfVgC?=
 =?us-ascii?Q?FWygFGOjWl9ydK8R+c9yHdAoqqs7ynPGShJX+15DABtZruahCyM/1ON4hDol?=
 =?us-ascii?Q?jjdZIXIghPJ8fTOkgdSiLMaHGD5SzTPknA8Ptvi5Igqd17qLa0et6BmmUhky?=
 =?us-ascii?Q?FKw1BV7sMDiARK7PXYGVOYCq1MiMbrRdyx3EPde4zcCdzElwCvdjwVym71wt?=
 =?us-ascii?Q?IGPwfXbzNqwYSg8siLWN5j92Y/6m6uIiMu2MqtEvSRC1jS7dQ9dF6eXOb4Wk?=
 =?us-ascii?Q?mA=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: ba2c2302-649b-4cd2-b8ac-08dddbed2f33
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 11:16:30.3746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4dr7qD5X8gX6FY69BtshqF3TaFTycSp9Cyb59EnI8ZZMbzgSpQR1UrI1vroxzWdqSKpZ1997qjoeFWjtZg7B2Q7aa9hDKINKDRXb2TAkeGQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB6268

The code switches to dma at the start of dirmap operation and returns
to non-dma at the end of dirmap operation, so an additional switch to
non-dma at the start of dirmap write is not required.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/spi/spi-airoha-snfi.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
index d9ce1d67975d..a7adced583c4 100644
--- a/drivers/spi/spi-airoha-snfi.c
+++ b/drivers/spi/spi-airoha-snfi.c
@@ -806,9 +806,6 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 	int err;
 
 	as_ctrl = spi_controller_get_devdata(spi->controller);
-	err = airoha_snand_set_mode(as_ctrl, SPI_MODE_MANUAL);
-	if (err < 0)
-		return err;
 
 	memcpy(txrx_buf + offs, buf, len);
 	dma_addr = dma_map_single(as_ctrl->dev, txrx_buf, SPI_NAND_CACHE_SIZE,
-- 
2.50.1


