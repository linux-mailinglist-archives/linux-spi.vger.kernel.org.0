Return-Path: <linux-spi+bounces-11530-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 651C6C86C0F
	for <lists+linux-spi@lfdr.de>; Tue, 25 Nov 2025 20:17:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4836635321A
	for <lists+linux-spi@lfdr.de>; Tue, 25 Nov 2025 19:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CDFC2C08CC;
	Tue, 25 Nov 2025 19:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="X8DH91pS"
X-Original-To: linux-spi@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023132.outbound.protection.outlook.com [52.101.72.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE56527990A;
	Tue, 25 Nov 2025 19:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764098213; cv=fail; b=IB9RfG2IsJYBReziANy4CcClKhvEsdbGL158xqgAPa22tEyNcWQyBZ2CZyEvjGi47q3MuEKMRF5t+koRCyHpNlC9d2RGn89o64LdclrUrhR0mVuUgDPJAOq8nE836aTlR2cQ4TWxhS+RBhQrdeAEzhqqI3Crcn1pOWkwN5qNmRA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764098213; c=relaxed/simple;
	bh=oy9Bb4e4gWVg7C2Ur8PRLf1sdVsY2Tbi4uQxi7oH4yY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M8wDzar4l5tpiBj3Ped1MYr7s8ByIwYNrK7KfI2lvoAW2VWWfX819zk/6zOSZErDHH5Qxv5HmkD4SbGzO3J3mnkdiCzCYQAzH3ob67/Thnku2i26Oq2zneM1MbesV2JkqbkSDPfY2G8fvhdU1PUU8w2BagQTguDA5Ym9kV84bbk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=X8DH91pS; arc=fail smtp.client-ip=52.101.72.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sf+sU3JpAz4Wl7DfbGausQNduvpBRxp4IKuRySNecXY1dAja0a6yRYxy75cCF0hAA9wlYvMocB4QcrfwMVAqNOS6iefw9O95Iu9F3Hut5onWZmeVj60g0g/+rQD25f/tpiwxoZz3goOncNuEiLsIPdH2IF85x/U5IFxYpdQQ7UTu/SMEsqs06RVlxDq+DvbisWKI9DPmg8Wniv/pJwC6ux5y28RmuQmLz2/X0BvGUg7XY8uJPIAMEISlITWiqBm/upeo1Z5I+1hiWlbcY3WnlCKZvhOyP3jQSZ9uh/a8Ar3g1n2+DpQPDDOM6y1j1X0SB+5qsl9NEbFmqrhQOUlgQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hdMRAyF9LhN+kVC1yVN+hIEWaLsKkLScNIFPytiIrzM=;
 b=JmMCMSu6nKta4yhRLfX8yuAaiHXGMKYmOKbySyFjAOFOkBZqj8THI849QBDrmyzMEG4ylvyHTgMxyOk6qni97jqu0cqYkAa/twBvPnIBvenG6BjCAPxEdMdevK/7HPFDwfF0eOc+0ALbur9jCTpyHAFR/OMynOOlC3MFV6JI3X61H9/SLRn34oxkLCeN1uymCmA6aDjFWqsiJNU6uILFJFFHoPNTFf8khaYKmeuNfxvAhDolRXBT9rUy4vFICWGiAWo3po1frXiUMO/T0ls3kDVOcXFppnUsY7kugnkQ9evovcT1KXV/0RUq18GEy9odWbvCzPzNojylSPfhCKe71Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hdMRAyF9LhN+kVC1yVN+hIEWaLsKkLScNIFPytiIrzM=;
 b=X8DH91pSJ15wZSlIPhXRsF+N4fEUIQoN59Rrv1HPXtXSaRbuQX77hLAkYVbtNzDvgMHVpr1nZR2Q2siPoYZH9XolhxO1Z0dWKN/ruH7GckpDaEPGnpzrDdMpIY387KnBMQzfIIrThH6tlANCMtl/wvlNCZTeL5hYy5Q5gwsptC6KiJgHzZoZgGr1BGx9y6MaDlCJ913zMugAjvQi2uj7kgJGb1zwQk/0vvLAuhH8mz4NicPLvtJQdbvPl+8Ro1gLNtMvJdyLZcn9+zOFtcqRSrNYEynLB46aHA7ftdRJAGiv6ASnJKCkBtavs1592dAoJ8gO/Yw+MloiYejqQpjohg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DU4PR08MB10958.eurprd08.prod.outlook.com (2603:10a6:10:56e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.18; Tue, 25 Nov
 2025 19:16:44 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9366.009; Tue, 25 Nov 2025
 19:16:44 +0000
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
Subject: [PATCH v5 1/3] spi: airoha-snfi: en7523: workaround flash damaging if UART_TXD was short to GND
Date: Tue, 25 Nov 2025 22:16:33 +0300
Message-ID: <20251125191635.1075027-2-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251125191635.1075027-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251125191635.1075027-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3PEPF00007A84.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::616) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DU4PR08MB10958:EE_
X-MS-Office365-Filtering-Correlation-Id: a28f85a9-ba01-476f-6521-08de2c572bfc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?En4r7BeWNjRTe4LE/TK7IUpl+OyR80YaOs1DCWT2+7zl3zUUKVapwLBolewU?=
 =?us-ascii?Q?TQBxWmk/oTw1tbfxktw95YgF11DQeH35o0limVV2GgN6QL3rd6YjkyXOFfcc?=
 =?us-ascii?Q?yqo48wIc90DAkpKEnYXWIXqvu+U6t03LLeVam+krlELDgQy0Utaldm8bhA0b?=
 =?us-ascii?Q?3Z0cnzFzTnfYs1lp78L8KElEq6AfsgRJ8qv2ggdElQtFKAibE2Rwqeq0fN47?=
 =?us-ascii?Q?cwJWKNX0UzAw7WovxmcNYD71PGu6FzrMNW7vRf1RgQGodV82tP/CFAWhwDio?=
 =?us-ascii?Q?vqvLSwdA6LkOedpmrzEDgsSunTk3zutkCbTl4W/WfzNltXw01993zQ+43FpB?=
 =?us-ascii?Q?dQf+Oaoe3NInCdh7vGp3En/xmEm16EEt0c1x+ny2W9EAx9MGsEI/oxm5UR6d?=
 =?us-ascii?Q?/2n7VVAYJaEnXVS6mpApRJAXUCGxQyXBPnooXxs7bq1G2OkWiLeyBkD7FEp+?=
 =?us-ascii?Q?s4NgohEoyT9aqcQD0MAJHMsg+o6S9mH415sPmKiYNOzpbZkGMJk+SiipJexQ?=
 =?us-ascii?Q?qwfrwRmgdbMkbWHGA7Jo2qqzkO6NKak+NCiQIl/v3/295G4vEage1mL3r5Fg?=
 =?us-ascii?Q?+uGV8gbD2c/sn4WUqUzvGI120ceETsaPCgu2Es7dKw2v0+j1EodUIknTpCDc?=
 =?us-ascii?Q?M73mgJVTblu+tIx0xXT0UsYxZOxNgH5t7XGTirJDqR3STjoDB47r+drl93zs?=
 =?us-ascii?Q?m/jQ4tQOZx/KgiUY5ML0asvdp+W4LvOjPAO07R6lXxmUfgqAqqtueay2dXZc?=
 =?us-ascii?Q?BeigoTQCqA6ESErxYu9G/HZODdAWMTHhJ/VjKfse8QnF0HFOpl0RHo1LakuM?=
 =?us-ascii?Q?zzC73T52iafGmI22qMIvSruqJExit4SQcy9KsJSBRrdvseudAvtEWq00DxUx?=
 =?us-ascii?Q?1RfbqYP/ThGQ+cRI3qRcT6G8BW0agKEDS7IxbwjlQPc4KH6fq1+E1Htlojym?=
 =?us-ascii?Q?25l37/qa+1OLiOnE0hW2lEmcInKmStXCF6YzVTP5sti1Nh5D4VKu+ucvDkqL?=
 =?us-ascii?Q?l9n2AAL6i85rn4HEYP53ZLj6ANrt/w/h1JajNkAUBdxPkiQqnBpqQw+WRaYH?=
 =?us-ascii?Q?uAIv8zGiiko9/gW5U7OAkuhuG5bVZvSlB5JBsTONuEgn7h2nJ3l1Ukm+gtN0?=
 =?us-ascii?Q?iRSvwvHNDRXabl55JqF5H+6xG2s5ApOV5h67s/bLWAyIG8e2h3/Q2fmApLKU?=
 =?us-ascii?Q?ZBNiz6G0aS+23DmrNybqkt4q49yAEliC9JO/6pGIYM5kQhlAv4qXyKtO0QBD?=
 =?us-ascii?Q?7Lo7WaCM8W8lusJmb3EqEjMIUJ/IPzInCuLWXynDwEJpYApGiU03q7SeRzjc?=
 =?us-ascii?Q?1UIPy3udX6VerPCDADQrbruU/0E7I2GwC7UckkoEx7PJDj1Onix5Bwx8ox8z?=
 =?us-ascii?Q?DMd15LZPrToiDVGC6bloKZgoNhqjAddZB9sv+N5bTOAax61tAYXQreug/vfH?=
 =?us-ascii?Q?IQPFavpZCk47zQZaMwMYrRF+bIHYVWHJJYY7XLAhiWsaBS8n2a7z9wrd2ywG?=
 =?us-ascii?Q?dhaQi+mDQC1QVVVnr+UjYdXrj5tPF7pxVU9jwyJLuwSzjS1q/UyMzG+kZA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PfoxCIqDXp2V8w22HqJwsZvDSrdn3qhfNogCZ63aM4P7Jy9yXJ38WZnkg7T0?=
 =?us-ascii?Q?bsJAaum492EfX3UODbwXc6NGhPEoucWNwnbKNcdr8m/SUCNqW8QdJTPz7LID?=
 =?us-ascii?Q?3zZZ32hW0u9gfBn63sBc+u2KcdJF4ZXU0by6x2v5ZPdIoAeKFqXBp3UdvhAF?=
 =?us-ascii?Q?U9uQVPxG//+3b1McgRHgjMJmnCg++a4HAJntkbHPvYyC1BDTvg6NCJVtc0sP?=
 =?us-ascii?Q?4UfReDVjkQy1jdKITtB+YaMB3NNuCt364lBYeno6lXaSPi+aANFZfzpuyZIe?=
 =?us-ascii?Q?TYHue1HPg8NmYHb9CiTM3Dj7m4zwdbR0KwHw03y7+RMbDRkjIZYVNE15EzSc?=
 =?us-ascii?Q?LAIt1LGV5wsopAe2MC1wDLBlpmNzdQ2YN5R7UnYD+WMOZgLeGAfozLpC2ohh?=
 =?us-ascii?Q?mjoNuVD5npT5ja9mo7jCi7tF3Vo5KwxfwoQEfDqTDTZR0q2o7nk2qQ14QWlo?=
 =?us-ascii?Q?Ud3XZyZ6hWP5yfLDrfISyFXhth1hxHJiJ+DKvFaKXWnI72d2uxkf5/VGXymK?=
 =?us-ascii?Q?IiX3DLyTj6TpyiHYj3RDQ9E1Q3oy+gHAnoB370y1MqddOuwDIwoqV5AHVufV?=
 =?us-ascii?Q?sciMXxDpxHTsq++IvfVqmtz0GjhVSE5TTtjtYz0JQVV7QLFqX3TXVvE5sq6j?=
 =?us-ascii?Q?zQJ4hD7iETuu+vT/bMHMQtlMZM5H1I4fT3eT0hgl6L4fa5fxpOnB3Dip44tK?=
 =?us-ascii?Q?OgUQyBwQvfMy6SbpL6pyurunCt8YFb7YQM8DNKxdyVbPciLSHdV7Pq3BSU3N?=
 =?us-ascii?Q?iWh+opbpOar9hDNc6UtGDFx0XCkEoZhmnae4c8/ccQhX0N9V/sW9xSvu8xOP?=
 =?us-ascii?Q?Z0zLr3L2ulQAQwA2HiaMpzyNQSQ9Ru7KvJIlmA6Penki1SG5iQop2Dbeyrxn?=
 =?us-ascii?Q?UCVWY4doyawriI3GJVhJieg3hsUgh4TwrhIxY7jXe2jbG6Sh/Pv89k3MbS9J?=
 =?us-ascii?Q?6zHcrjW1nEHXhYsrIoik2GBbZ+WZzL/2XndK5CpsisrtVINGoUHweflUtzeK?=
 =?us-ascii?Q?Vvuzn1qJhLdmcsaSeQyHywYSbNBKU0yzkpYLnJTxw18UUIF3imt4CuMUbDMX?=
 =?us-ascii?Q?unCUaIdf9i50VqK3L4k0Gcmp3tWm2f2aqiq23NX4EyK44M0i1HEUtuPEzLUQ?=
 =?us-ascii?Q?MvA/D7jYwv801pJo5r7jhz2pjVWQ4bYMdA6lnUH8y5GujZblDQ7LbRuf4wmL?=
 =?us-ascii?Q?sQv+7F9qCKG0DjvQlI07hkxolKZK3iLplkn/M+fdYM264S0+gX5u4y/Wb+//?=
 =?us-ascii?Q?wN5CbKhmimjfvppHwierdWOOzVevQcHGEfo5Zun3UrWm6utli4jmEwCHMUJW?=
 =?us-ascii?Q?kDLi4akw9pjyph+rd3euAk0g6qqgWc5a3b9kv+waEMYu8pFURaOdxNS6C/RH?=
 =?us-ascii?Q?yEbKTwFazAJm3zVS/HYtGuar2qltdqkE5E+D+HG7UFhtkF3h+flxfYnKR5J/?=
 =?us-ascii?Q?dBCLU5qxGG4hD3NYjtkoGHwLFnlmhqHOo6eXVDhlLQkCs/IcrAk7hsHsma5z?=
 =?us-ascii?Q?94wtx5Orv9+X1GMdCBdKdADFyo7w2uCgXAYxXuRkso/B0qaPU017GlYyFbMq?=
 =?us-ascii?Q?4ul+x1jU9N3Q7UIov5GPU/oz5t9vWe+o/ShbtEeYC3qJ4Wml2cmoZ6rEEQRb?=
 =?us-ascii?Q?BWbD9PG9WMRKOCgZ42nDsOU=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: a28f85a9-ba01-476f-6521-08de2c572bfc
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 19:16:44.7006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xi4UpDQ79Q09GbZzMS7dIcFUXFTugOyMv22faYQ92Qz3VGKQK6QuAY3Qwbp4iIOTVwmibygJMowPkIFCJVvHfdS5gLt97i/ATFB+Z14Gyas=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR08MB10958

Airoha EN7523 specific bug
--------------------------
We found that some serial console may pull TX line to GROUND during board
boot time. Airoha uses TX line as one of its bootstrap pins. On the EN7523
SoC this may lead to booting in RESERVED boot mode.

It was found that some flashes operates incorrectly in RESERVED mode.
Micron and Skyhigh flashes are definitely affected by the issue,
Winbond flashes are not affected.

Details:
--------
DMA reading of odd pages on affected flashes operates incorrectly. Page
reading offset (start of the page) on hardware level is replaced by 0x10.
Thus results in incorrect data reading. As result OS loading becomes
impossible.

Usage of UBI make things even worse. On attaching, UBI will detects
corruptions (because of wrong reading of odd pages) and will try to
recover. For recovering UBI will erase and write 'damaged' blocks with
a valid information. This will destroy all UBI data.

Non-DMA reading is OK.

This patch detects booting in reserved mode, turn off DMA and print big
fat warning.

Fixes: a403997c12019 ("spi: airoha: add SPI-NAND Flash controller driver")
Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/spi/spi-airoha-snfi.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
index 8408aee9c06e..1b91ed07d046 100644
--- a/drivers/spi/spi-airoha-snfi.c
+++ b/drivers/spi/spi-airoha-snfi.c
@@ -1013,6 +1013,11 @@ static const struct spi_controller_mem_ops airoha_snand_mem_ops = {
 	.dirmap_write = airoha_snand_dirmap_write,
 };
 
+static const struct spi_controller_mem_ops airoha_snand_nodma_mem_ops = {
+	.supports_op = airoha_snand_supports_op,
+	.exec_op = airoha_snand_exec_op,
+};
+
 static int airoha_snand_setup(struct spi_device *spi)
 {
 	struct airoha_snand_ctrl *as_ctrl;
@@ -1057,7 +1062,9 @@ static int airoha_snand_probe(struct platform_device *pdev)
 	struct airoha_snand_ctrl *as_ctrl;
 	struct device *dev = &pdev->dev;
 	struct spi_controller *ctrl;
+	bool dma_enable = true;
 	void __iomem *base;
+	u32 sfc_strap;
 	int err;
 
 	ctrl = devm_spi_alloc_host(dev, sizeof(*as_ctrl));
@@ -1092,12 +1099,29 @@ static int airoha_snand_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(as_ctrl->spi_clk),
 				     "unable to get spi clk\n");
 
+	if (device_is_compatible(dev, "airoha,en7523-snand")) {
+		err = regmap_read(as_ctrl->regmap_ctrl,
+				  REG_SPI_CTRL_SFC_STRAP, &sfc_strap);
+		if (err)
+			return err;
+
+		if (!(sfc_strap & 0x04)) {
+			dma_enable = false;
+			dev_warn(dev, "Detected booting in RESERVED mode (UART_TXD was short to GND).\n");
+			dev_warn(dev, "This mode is known for incorrect DMA reading of some flashes.\n");
+			dev_warn(dev, "Usage of DMA for flash operations will be disabled to prevent data\n");
+			dev_warn(dev, "damage. Unplug your serial console and power cycle the board\n");
+			dev_warn(dev, "to boot with full performance.\n");
+		}
+	}
+
 	err = dma_set_mask(as_ctrl->dev, DMA_BIT_MASK(32));
 	if (err)
 		return err;
 
 	ctrl->num_chipselect = 2;
-	ctrl->mem_ops = &airoha_snand_mem_ops;
+	ctrl->mem_ops = dma_enable ? &airoha_snand_mem_ops
+				   : &airoha_snand_nodma_mem_ops;
 	ctrl->bits_per_word_mask = SPI_BPW_MASK(8);
 	ctrl->mode_bits = SPI_RX_DUAL;
 	ctrl->setup = airoha_snand_setup;
-- 
2.51.0


