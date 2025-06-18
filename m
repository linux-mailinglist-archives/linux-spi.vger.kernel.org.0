Return-Path: <linux-spi+bounces-8656-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A744ADF074
	for <lists+linux-spi@lfdr.de>; Wed, 18 Jun 2025 16:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3E1C4A3F8E
	for <lists+linux-spi@lfdr.de>; Wed, 18 Jun 2025 14:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC53E2EF29F;
	Wed, 18 Jun 2025 14:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="eyNWBs4t"
X-Original-To: linux-spi@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazolkn19011030.outbound.protection.outlook.com [52.103.66.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D0A2EE5FA;
	Wed, 18 Jun 2025 14:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750258491; cv=fail; b=MQPan0zu/cjWAjkWM/lTUWpRbdtVCZ5TfMCyjobCj7HcavaxPFSl3j8j5f9M2qJqqiMedel2wiBLmuFoFEQEmFXyH9zmCEe9NxQlVm54iDVukclwGYeCz34emQ3lJ6Xw3ix6lRVmoXK2AmJHK0d5ui9r68Q6NloUc8U1g9/G2Ts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750258491; c=relaxed/simple;
	bh=3uF4iHRlfv4JMVr2rJ8qpGb9KE8C70hOqN20bebHeAU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YvBbqirWLo3LeDgH2WbuU8eAN0G0xhfeIGPIOTLvTkDt1CfS+UEDgNancmdHY0P8V3AVnBHds6PF42Su+PiVpzdHv/Wpcblr8H/i5+P2IByw+p+qegcdMp/VOfG2X2n6Pz8gjU8yo3KgMs/0luMq/fVkLbG6VONFz0BRd9bKHpk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=eyNWBs4t; arc=fail smtp.client-ip=52.103.66.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D0s8EN1kch1AsMREHPk7Bz16bYSeoKN40KJtnkvyHN9h5E4tC3kzwiadSz0UIC9Ik5EfkIR0YO6fNPzP6+WAGaDlwlcIxAwPi1MNUACE2i0aCtCjJBcPFszy99ctLYT+2TJBuIFbOYIJWLfrMKhMHXqskNAFjOrO853dnfWpEzYsw86TsheHxMturtUs2zmEA+7xCiNUDD+hFUHCpjw+JPLmH1hOKP1aTXdqaTMmEf2jaIkudvZ9F5riroE2Nz+Fzk4n03v/TYm/g5yteyg+lW+SzWwedvPqMH5YlBfmHrpiTx/cmd2NZ7Hzx4cgSaec/lCUSqS7bWNQeGF8PQkNcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7NWmYFa3EeHeBMV+JOhAudRHn4ptPaXw8LgToMu0QeY=;
 b=VEKX4mOQ20A49BmoXE+wtO1Xw1xPQT+0exeKVjdOrfwFGrD1AA482nFgz0jLI84MyQbhlVqpSNutDYlF0ZV7mlpLC70QdIt+570l71SCFnhDV5uDSeT7M1Paw5l+NBUB25uGYf9Tu8e0hPSacroNWMXirigsBtAv/RN2UbsvlznwJ+CWakdfiuVFu6i2MNwKIEJjORNamLkzXk/BR2LXjxK7jPpAt+ica9nUYcKVvN52+xupMz8AoRridM5y7B81FAP4KPfUAngIkrudS1TKsVhjaDldATivT7Tr6qp2Prnz1lekMIaAPLtMI6YhUfYTS7O2/xfPmMji7LSAo7easA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7NWmYFa3EeHeBMV+JOhAudRHn4ptPaXw8LgToMu0QeY=;
 b=eyNWBs4ti1we226+88FNCiEzchXG31vKOflzwiO5zPOXGMP2mSIYOzlkM8gKKQbQ99fhvpbrD2H87ybx9ZC0rKGQvbJYgWEWUpTqa1GS1won9D1SVB9WmT11D925kunC0Ak+QxGEh12NqlnyaqeMf7Ed5Yy6a7OBDyVsWJXR1HmBklCjIFOqFVIhYOkan5ajWSZAZrT9+VhtL+ofpxMUU6riNBt0kTqWOOuYjvBh+/DmV5jTaTpvgMmMAFG3WejW9WFLTgwSg3rVKDtTLjuO5FSiFg+6sLTvqund0SqbiBJH4hJ/RiSF0p1XxfftlGib1K7QVrpuzAWWkkt7jU2t/Q==
Received: from OSBPR01MB1670.jpnprd01.prod.outlook.com (2603:1096:603:2::18)
 by TYYPR01MB10545.jpnprd01.prod.outlook.com (2603:1096:400:30e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.30; Wed, 18 Jun
 2025 14:54:43 +0000
Received: from OSBPR01MB1670.jpnprd01.prod.outlook.com
 ([fe80::c00:ec4e:ee7e:9b7f]) by OSBPR01MB1670.jpnprd01.prod.outlook.com
 ([fe80::c00:ec4e:ee7e:9b7f%7]) with mapi id 15.20.8857.016; Wed, 18 Jun 2025
 14:54:43 +0000
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
Subject: [PATCH 13/16] MIPS: vpe-mt: drop unused functions vpe_alloc() and vpe_start()
Date: Wed, 18 Jun 2025 22:53:26 +0800
Message-ID:
 <OSBPR01MB1670B2637AF066C7811F557CBC72A@OSBPR01MB1670.jpnprd01.prod.outlook.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <OSBPR01MB1670163BDCA60924B3671D45BC72A@OSBPR01MB1670.jpnprd01.prod.outlook.com>
References: <OSBPR01MB1670163BDCA60924B3671D45BC72A@OSBPR01MB1670.jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0054.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::22) To OSBPR01MB1670.jpnprd01.prod.outlook.com
 (2603:1096:603:2::18)
X-Microsoft-Original-Message-ID:
 <20250618145329.25517-14-yangshiji66@outlook.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSBPR01MB1670:EE_|TYYPR01MB10545:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b1f80d9-2898-4dee-a6e2-08ddae780f4f
X-MS-Exchange-SLBlob-MailProps:
	Cq7lScuPrnodj9mcbuBOlkXQjsuE+OXdzdYiTPyiuogWnoDg3+Yb0dlRx7jD2MA3qRCTyfQ6KKZxfCqYeEL4rfiAW8BsXQhk6K7YNb7wVipJYbV5ZstmLg0rHS6zh/HGr2SAn8uICY0rCT1sRhS4QCB9A1dZoWPxiXU7KrksqqMhHvVggG6neUH+4ZIjWKi1pdlVwJBJ9QDiTsQRKW7gHJG0GjIK07Y46JhPA9XvTNYqmSuC7cSHJYshB00+laepTQeBKzvQZgsBoRF6xrBN7D5HQO2r33ZLIh0ndM7NBx/R3KD3a2gEw/RYxJecTsJfEDwHlJPcTD4kYBVgizZvPhxoc8yB/TO6L7a0ysSicqV9fvk1fj8KRGJZvjPs8VHOhXkg6rdltjzagzBn/bk2rYnVgd1Ssmompy7KksftlMu1LprH8NF5Tzv0XNPLsxRKnEthXsizS0R3QUpHZZQPE6yMShF4eK/M3yTj/ipnpgtRzdvbwststCA02UBqaVc2knLQG2cJVM5qyFpWG14UgNn6oXsgkDVTsdy2xCS+6esfoRAu67s1IG62MWGCye4LOhK68lM8BPZiAGM41hiefwMPAYAecZkLM2X1SGkh76+mItmLqFkCamWiC3z/bvry9IlNlT9ipyE7Nj9C07RnuRNLXzmaXGTlNzyyNcG2MeFS4e8jdpnl6zNcB+oG1Y29kIb9ZqHZWxY+UmeyN3v8CqdJ5gYOOCxvPwTB/CVQ+neVhHd4MFmwH4v4Xgs6IDzIGmx0PA6Nnwo=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|7092599006|8060799009|19110799006|15080799009|5072599009|461199028|41001999006|3412199025|440099028|40105399003|51005399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4gwDYYmi8qfiIdsPhJY61M+pvCRX9tJyl8eqXFYhDYwRMTxmOVv9FNLv2WBf?=
 =?us-ascii?Q?UOBggWn1QS53yySnLRouERv7h0dgDUA0fOqpcRXQCGyfllsJgbByq4Ki/0Sr?=
 =?us-ascii?Q?10NFhriSXf7zAkUdFsVX7EP3rBpMDn2xukEH5DrfEyBbUgPh71XG0Pc31sK6?=
 =?us-ascii?Q?2toRUzEMp+m/cY2V5BdbOHZpaNxhQAAHiO3q5PD2yrgS9UsiX7nBYIvjNVza?=
 =?us-ascii?Q?rjN0hEPkYDa3EQJgwdxM4oz0cy1xmut18GDLH+PfCQESfHFwbBdugTap4b7W?=
 =?us-ascii?Q?IUKJaILwvuJUFSV32j53t8UbnYUiaW2urb3DmeubIpXUuCWV+96CnonN9hma?=
 =?us-ascii?Q?OKNG9ABhwvEXChjKBwU7W9dIb+fxWq4jvsVogTMLAxUwD13PlZO6oDxv5dbP?=
 =?us-ascii?Q?qTsiBObpsCglk9iQkuLKno5ubc8/O9U5a+zWFerf+M1asZmLFcjNncIVIC2s?=
 =?us-ascii?Q?fs11zEsBYl9lNqjag2LTX41AY9eQADLwpjTZ0jYw13Z2kuC6zmfqu6AXwHDE?=
 =?us-ascii?Q?pPWALm6HcSMhNsAPcEJxMmPlij+1x6/ruONzQI0lP52YrSjZMXSoDADABi5U?=
 =?us-ascii?Q?YdtqWzkFaYZOzyBbrjlzN/Y0G+MqP/JMt2Hv0PFDD6z+1e1LQ6IsOSfMV5gZ?=
 =?us-ascii?Q?Ff8PRDB3ZcU+ZUFHwu9i/lWqmu+lETjcCYzTFFNkSh0cYXpdhvE375ilnnGx?=
 =?us-ascii?Q?mxuCGnx6+iGV6LCz/FiaanycnpJVmlgNLr713qaOVTgXK4AbTRxNSakOuUGg?=
 =?us-ascii?Q?2UMcHCXh9R0yHSLXVPdPEVm0i/gJ1/msBqtMAjT4wluz495lfBdKESvM9aQr?=
 =?us-ascii?Q?vChn3PCpNwg2wL79Xn86eRXIV5+F7Uq9PvY0/N6ongNCBcerWp6la1Mq/7is?=
 =?us-ascii?Q?itBdfsspQeo9kTUfe8TZ5heuh4NyjetKI+skxpBeSFS7V4tqow6vRUMQBXer?=
 =?us-ascii?Q?rCMbk77o4Um0kJXMaxQ2eLj+4vpJR7YwQeby0gleDLxKw/VOZT6URCyRAQ2e?=
 =?us-ascii?Q?G3PGKRbc+9XeYb1AOw0+ohzAy7VVvANqh7Tcg9xbDxs9ERL1GM50MDgkGj6+?=
 =?us-ascii?Q?ygfElHKIwanFqHgfL9oqHbgw8DVYvuFupZ5uCh6sY/xb5KAfkseMyqz/Z356?=
 =?us-ascii?Q?ApiLcMqYOwBh1wZXsdMeRaDroh623F9MtDKIrmzlP8Q+xhIEG/OBHRSGM05F?=
 =?us-ascii?Q?iRzALyCnzVzbDnPVXcO06+K78veVauSSiwshzYyCXc3OcrNjWSfCUz8WDjs?=
 =?us-ascii?Q?=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RBaPRK6M/MZsCUpSIRfLc8UalhRfbJRngWYdBO9LvI7i8MU3CExTUVuKo9Gu?=
 =?us-ascii?Q?KQH2zA6sCZD6a1WAvVpFNZXuYPWgVluOooFi3sW4tNZhfEp4IwWpbSL8WVBG?=
 =?us-ascii?Q?Hs58VcOV83HxFqHghTQe3OCoiQrwpUXH9gbatcOQKPCQ5y6qgz77mmX4/M+x?=
 =?us-ascii?Q?25UleitdDxLELQyEcWW9S6QQ3CtWzJWG0UmhbyZubDoSRciH4xCiKh7rC5O1?=
 =?us-ascii?Q?v+rl2tN+FZ3aqRP/hN2ALg3bp37uPf6glDGxMe5NzZgHSaeIheUezj8Ext5U?=
 =?us-ascii?Q?AI79mpbEMBogh6JY48uzuwcGvZknGmAG9b/8IqRT2qG6PlRMG9VGmBhoLpIV?=
 =?us-ascii?Q?nRycHHVFaB00/o7sdY+Yg1YjsFIymC2k4n9dtV9FiVDUeCG4x0bw0FOxhsUk?=
 =?us-ascii?Q?c1d7QfP+A7lF3WumDTrHtd2K2ewSQeMJydW/gIy44Esb+hTSzxBDXqGGzbgB?=
 =?us-ascii?Q?WqhT4zxlDDY7V+CobXW2eLEU1K/7Vnpk1WQU/1RyIT5RsKNHM4+KzWyLvKHN?=
 =?us-ascii?Q?K2XrE2s8Xcm785xLOv0YQMmNyNR2hCibGsaXIngGpa7FculE6Bdp83ZxyJOB?=
 =?us-ascii?Q?K5wnknq4YJ0S2L8cNH7E2Zfa9tnMqHCSfF0nQHQYoDogCsvIAgOCXy7WuJGQ?=
 =?us-ascii?Q?DKpUm59YL1oiFs1/rD/R6hLCjFyITbIBmGzQS7QB1n7MGpA7RYWiPcoftsZ7?=
 =?us-ascii?Q?9s5gcAxlwYQwUGPC12zjtWOugPRfrnVF7DTd9HymXRtXigHno8JnhcNvAwff?=
 =?us-ascii?Q?pHfCL3uUrImsA2jveyD/Xl7XYvOyQXlpNdtUk9CpBHawaLkB7GKgk5RfOGjd?=
 =?us-ascii?Q?spLZrR0oKdpMuGFFwgJa45CmuDKZowXBsFNz9587Qpe2xK1B/Kv+Ci7zgPGd?=
 =?us-ascii?Q?atNQ5C3rwRGFEb2J5/KxjXRM5RiKcQgVHuZO78TXAhLy3hxK5Fyd7644bVqA?=
 =?us-ascii?Q?ViX3dtv34CcqTFKhhsN/+Unj2im1pNnznu0nlXwifX/K7TCpHelMeOtzZbgq?=
 =?us-ascii?Q?fLERCPB6yKQ8tPnJhIAopm/IVXOKOxNbxu+PI3vGK6dj8Bcbtw+w6Lwdpxg8?=
 =?us-ascii?Q?l1RK6xmqIS2LV6HY1CqSmTc3XhwCo93PL7gD2saZd+NjDaK0qClgW0XX7xHx?=
 =?us-ascii?Q?nVmxjhww8ouQZi9HIQlyGXdXtxvvY/vtQHYzdVXOZWqEwG9egjWb1OrL1KJ+?=
 =?us-ascii?Q?kovOzHlC4LSOuZmIEbhz071UPTOiLYZemjKtDdcwvS+G0zIijWpAlJo3bTrK?=
 =?us-ascii?Q?8v63Yv0HK9dKpyU4eKSv?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b1f80d9-2898-4dee-a6e2-08ddae780f4f
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB1670.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 14:54:43.6502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB10545

These two functions are defined but unused. Removing them to silence
the missing prototypes warnings:

arch/mips/kernel/vpe-mt.c:180:7: error: no previous prototype for 'vpe_alloc' [-Werror=missing-prototypes]
  180 | void *vpe_alloc(void)
      |       ^~~~~~~~~
arch/mips/kernel/vpe-mt.c:198:5: error: no previous prototype for 'vpe_start' [-Werror=missing-prototypes]
  198 | int vpe_start(void *vpe, unsigned long start)
      |     ^~~~~~~~~

Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
---
 arch/mips/kernel/vpe-mt.c | 29 -----------------------------
 1 file changed, 29 deletions(-)

diff --git a/arch/mips/kernel/vpe-mt.c b/arch/mips/kernel/vpe-mt.c
index 694b3bfc1..a6dd358bc 100644
--- a/arch/mips/kernel/vpe-mt.c
+++ b/arch/mips/kernel/vpe-mt.c
@@ -172,35 +172,6 @@ void cleanup_tc(struct tc *tc)
 	local_irq_restore(flags);
 }
 
-/* module wrapper entry points */
-/* give me a vpe */
-void *vpe_alloc(void)
-{
-	int i;
-	struct vpe *v;
-
-	/* find a vpe */
-	for (i = 1; i < MAX_VPES; i++) {
-		v = get_vpe(i);
-		if (v != NULL) {
-			v->state = VPE_STATE_INUSE;
-			return v;
-		}
-	}
-	return NULL;
-}
-EXPORT_SYMBOL(vpe_alloc);
-
-/* start running from here */
-int vpe_start(void *vpe, unsigned long start)
-{
-	struct vpe *v = vpe;
-
-	v->__start = start;
-	return vpe_run(v);
-}
-EXPORT_SYMBOL(vpe_start);
-
 /* halt it for now */
 static int vpe_stop(void *vpe)
 {
-- 
2.50.0


