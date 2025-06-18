Return-Path: <linux-spi+bounces-8643-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5281EADF03D
	for <lists+linux-spi@lfdr.de>; Wed, 18 Jun 2025 16:54:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15FE63B7758
	for <lists+linux-spi@lfdr.de>; Wed, 18 Jun 2025 14:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AADB02EE5E8;
	Wed, 18 Jun 2025 14:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="vCaB4zbT"
X-Original-To: linux-spi@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazolkn19010011.outbound.protection.outlook.com [52.103.43.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3BB3B1AB;
	Wed, 18 Jun 2025 14:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750258442; cv=fail; b=fW2RgKbkQWyg/o8QoaW/y8oQU6pWiQGGpMTmOChl5tNJWccAeS2H5nXabZtfaEbq0AYguZdshHDpiqDsaxu5fX2cN3R80rZaYoTOkX40a2Kp4hBboMDGMsOQOKojzUSiZzQtqRtvQSEh/HIVA0GQJ9NgDOTitCTswdM6AqQfYT4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750258442; c=relaxed/simple;
	bh=bp5vYSvuDWn5fKWYSI9sJ8Ompgf1feBYHqweFaKmFZw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=nYGwkHFjOGH6U2hY1XlJHa20+BHvwDyannuUlFyDfyp08aeSTuON6vIsVklUEd/1OcaDl1NVvcZ6dwh0eeVG9i/mmGRrkD0YOFfoF8Gx64VjbCRzXmwWnEDA0pi5FXe5K00FDFEpGtMxOxvPdxf45nCZgqw77V5G3H2KPhrgVtE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=vCaB4zbT; arc=fail smtp.client-ip=52.103.43.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O462cSq80YLreBmshXiLDzfUgByMyNAAl0DkJdIl8mOrJ7Hsl9UDvv6/Up2/s95ippTTX69/+CNozdgF2UFzKEwdoxcjpZ70oDfsgUgI5H3b2XOcFvTDbKMoe52od5LS72OGphvJLf7EWBF8Kos7dfc9ZblIAtRYYWCPX2kF6enbvaMEcrBsTBiVcQ+TOuRFSQyESrZL2Enof9gRW70KpoXaa44y6DfdocIORfYPak8oIUKwHEeI6ksfIbcdbc9zJccgY86NwcoDvXcBNREd62DPq5x6+aylprfkeOFad6pHKBRYISp6zG+xD2YO/4Cw2Vdoosj8u7NcPOcpcmvb0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N91sa5eiQeI4AGnCvPU9o1rP748hBiHE7kHr8btmKJQ=;
 b=IUh8gjzy1rhB/yXUKayFARLCP7y9a3Vp1UlEU1NR+nBbrmYzfAITDC+v5bT3oc3Bb7hZhatQYGSAtzVx8eTK3jEKYr/GE955lZTFhrCX0tBLIiW1XprIfv3yVUQzJzdidFASCjHAgwsK8jX0hGh8cmr9sy8SqrPsOBFi1mHLkHza1mvJZ0R5Ll0Jiiy/y0O6uaGuJGZmyOr8XI4Gptaf7VF9/8abj2ynbbjtz+Zzw9KNoO3fNqGte02qXGmXWWq6rFXZzKRTDpMxRtzr1QKq60fGjy55nGG6RyOLr8wTFmbqkuKyl+jlzgbIXIIdmiO0IV9Y5LWPKielj3Po/HDPsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N91sa5eiQeI4AGnCvPU9o1rP748hBiHE7kHr8btmKJQ=;
 b=vCaB4zbTxHxuV9AdnhMjH1M2i0vMk5fMXUEdNWgPUfiWube0/tRht9K+2w5/RWQ55jyOKjKkCGJEjXhVTF1CohPa92kOLzaia4m2MG5E9dEApZ6aP26BxQgMDvfFhvbnoPe0uctjdnIT+nAGdp/RBibKUWVO8VMJ7VSWmZwX22XgKr0oIGqZI6R4Q3iA/hfRmphm053SpvTcBRKApWJoTkfyts2/u6Gfc/Hp42X/PXXdJAsNi7jsQYQ1vXVsmlp3sZLr9qC9HqEcADbsc3BnD4ZOIM7o4h2OjaNKlifEYb325+rKcTO3cEojrMhBjQcfZsb4supD5m/izyj8UXADZg==
Received: from OSBPR01MB1670.jpnprd01.prod.outlook.com (2603:1096:603:2::18)
 by TYYPR01MB10545.jpnprd01.prod.outlook.com (2603:1096:400:30e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.30; Wed, 18 Jun
 2025 14:53:57 +0000
Received: from OSBPR01MB1670.jpnprd01.prod.outlook.com
 ([fe80::c00:ec4e:ee7e:9b7f]) by OSBPR01MB1670.jpnprd01.prod.outlook.com
 ([fe80::c00:ec4e:ee7e:9b7f%7]) with mapi id 15.20.8857.016; Wed, 18 Jun 2025
 14:53:56 +0000
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
Subject: [PATCH 00/16] MIPS: some compilation fixes for the Lantiq platform
Date: Wed, 18 Jun 2025 22:53:13 +0800
Message-ID:
 <OSBPR01MB1670163BDCA60924B3671D45BC72A@OSBPR01MB1670.jpnprd01.prod.outlook.com>
X-Mailer: git-send-email 2.50.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0054.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::22) To OSBPR01MB1670.jpnprd01.prod.outlook.com
 (2603:1096:603:2::18)
X-Microsoft-Original-Message-ID:
 <20250618145329.25517-1-yangshiji66@outlook.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSBPR01MB1670:EE_|TYYPR01MB10545:EE_
X-MS-Office365-Filtering-Correlation-Id: 3aea34fe-af07-4784-09d0-08ddae77f2bc
X-MS-Exchange-SLBlob-MailProps:
	Cq7lScuPrnodj9mcbuBOlkXQjsuE+OXdCmvDk8U2Wh299Qc43Cv9xd/upbv0tDihjyMFJP1PaLj76NFBMF5lEXpyZHZttv/+TiSV0vF+3A//NXDyoVVXmAAgySEuXXaezVTFSwCgxG4PChYwHObLA1eU8E+BnsC/BbrzykXGFfuJHui7BPTHx8WeF5raZnwcKgi/tdyoyjVFyNwyclNHHS3yZNGiXjKhDJjVcC01q5jhFcF7BK4YD21Zn0jddr1ql+s69619jNMapl4DjOFYNd5WLQca6Zt5Jq209tJxxOmBmGTw9KXXTK6YJoynziYu2AeL2ehO4AgbvxW7kZn1AfjofOO8qwwluoe7Dg61dWrOpJp8dxzeF2FJEz6clbj0QafVwYemcHBFScy5mW3tVLTQ/u+jcNDXn7HlSkaw7p59alwnenyGjuwwYI2s2U5K3e9RmdsGF0YPnsl7wr496wm/wm+YQDfYT+JHZZY11J4MnSXw6FDXDWm4bvbix1klya110La6ILH5JtKodDX/Dsykt//0aRL/SSxB5s6rtoUnVoQAaCEiUNo7/qP67YsgsLAfme35s9XYGFoRu0wMEFIzop++2riZdPVQ21WAbE1XI6AeqPGk1lg0sL7F2PYueHUXJBFNNBLZAZe0frxNfpxWL7LM+9Kj7FPuWX1ioyz40TkqBeCpLlmOu925/TY8v8FrgZr80m0R/TMr77lPokfOOArH/9FUQTSCOilE69D1KgVPMmG4rUKc6ONdgrg3GcoYiWnuMf0=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|7092599006|8060799009|19110799006|15080799009|5072599009|461199028|3412199025|440099028|40105399003|39105399003|12091999003|10035399007|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Vt9/M3CepYedCl4UKjSd20lRkcJm2wzir+aH12nmkV2R7IduUvdwSQ9EbT+1?=
 =?us-ascii?Q?EJf3gYWy47qECTtWbTkM3Vhin0IT+N5QYMAzMiJ2d9012AKmjen/FDnLQ70K?=
 =?us-ascii?Q?CjUtMl9Nl5k14dEQC+OH1lHnQ86dRqY3E7Y2rsYgQ3qo4N//NrnmeZzrgoYm?=
 =?us-ascii?Q?zqUOfs6h1bBbEv+YaDWoDLr8EDRd6UR3JlabSsgFYD22o4RRFJ8G2srBDyjX?=
 =?us-ascii?Q?TtsZyIzPJ+oQvN5LYur28ouvEF3wq+pbxwVBCx+jehcaH6jH2qV8CZpWJsOa?=
 =?us-ascii?Q?m7ubbHtt0eO5n69xcK9AuC9q8rw7oORWCrmzlTrCQDJpH9apggZuroTrk2m7?=
 =?us-ascii?Q?Ng+xrhU9Lp0h6dmgjq+8OHph+lHbm8qPNqvyAqCxOVV+sQbYkPhncEGNoHSF?=
 =?us-ascii?Q?IVdjbmZW+mq6LQx2TiZ62E0FtyLCPivaNi2aOTo+zam4+xR3Xf7aM6MV/CCH?=
 =?us-ascii?Q?fNorOxnCM+/Liqd40lvc/Oz6kx0DbKzTRfoyryvU6vtGcd41VMD8TVd3Cr6f?=
 =?us-ascii?Q?Cj+597zfeT7O5S1FMvoZirZ9ASmCR9ojepoz8Effbs4yIT43Zs1/LIewS+5i?=
 =?us-ascii?Q?/ggMSZBzZqI0X1S8DIt77DHp/OcW/eNCCnfYPL0CuCw/yMbxm6auOfixV7Do?=
 =?us-ascii?Q?RTtMCxq/PBXNZ4LvQSJjgtyVO7xvDGHuolwzsDsg1PwK8O3Z9n8wOnzmys+c?=
 =?us-ascii?Q?r1Vdy3gazvybV3/Jt+UGwtwAksZGQhW87EAq8boIJZNxpkB1g7dSTwYJ9UKk?=
 =?us-ascii?Q?IoDse9ec21PSZA5e4UoqF5iBu38NWzre5fQxYYwGdYsC01O7xgFQQ9zzkkhz?=
 =?us-ascii?Q?ZM0cRdLoVDHeldC1m2ewvjTcfmaUuhR2hP2ulF0WfNdBWrz4bw/5wplNjWHv?=
 =?us-ascii?Q?OTFWNLiKxedg4HqT86GORR8tYDAs5Sa3j+yetuqY1RwBcLP72oN6evKWFOlX?=
 =?us-ascii?Q?ny+xpnwDNT7YbGxtqWCTrXSOwiUtriRuIghY34KBJZH437IoZpwEOnQBBCrU?=
 =?us-ascii?Q?/bfa4qDAvAxLUvDstfIRVZNxelA1V5zU9h+WX0auYzdGcARHHUTgpd2P6WDs?=
 =?us-ascii?Q?TtyN4ov055mYuGzRM/4X38ihNWKDcdPecLLHrPD7Q6tB1O7RH0Z73oCjwJmw?=
 =?us-ascii?Q?2rsi9r5XOoy/gJZvbkFL5wXkQHCXktOtkryzZH92vOY0jFHYK8pML3ucFo0X?=
 =?us-ascii?Q?8cRaR0mYyiCTrKA+DhEk0vymumJUYH24SfZt9rqli0nasWVyASkEeEhTXH1A?=
 =?us-ascii?Q?f9y+p1TWakir6APkW8eQkzN2FaIr9PM3hpS6ltfpRrXTFCGL7Bbz9A9tXH+z?=
 =?us-ascii?Q?/WdM1v/IyePMDsA+94Mi/GSlwGjjZCoZn+1NDXuDCX+inA=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oPu7OtTico74cEgir3LYN6+SvNQRQbSi/mr9SRTQBKfMQpDhUBau7kumq7ZR?=
 =?us-ascii?Q?thPhxiIzJi7PTco/BAoKMMZxIiSkywdBNm/LTL2zzAh+NmTrVMPUbLzcBm2I?=
 =?us-ascii?Q?nZQ166wtqZbnUHs7cIP1/xjmcyRuAYKVj3h3MtzgzZsEpzooKdIncW5YYhLf?=
 =?us-ascii?Q?cZVUnabm7FZhTpdvad0sAF8daanxQRaTzdJ4bKUt7gKPS7PbZZ7JG7laQAst?=
 =?us-ascii?Q?SvNmahVzY6LvJwE1ch9RzqWGYDOo98mfdEn3WqvHOUbaP/gqDRAQKQGujDIG?=
 =?us-ascii?Q?C5nbQ1/psGS/JiC9SoqDAqV1G4F9LbVC07ea/iurA2sKW9poBb2N8IQrc1H+?=
 =?us-ascii?Q?b6gSGCykD+oFClRhKEbEdI4drSq7VzmO1yLno9mMTPX+eDXD9R5FhNuNBkvM?=
 =?us-ascii?Q?r9zY7WRkPF7D/48ltqNNcQnlT29gLdOOFh533LmbRVyJnUHJv29Pj+kwcKe9?=
 =?us-ascii?Q?xy+Scx5Dmo6Ya4JBfu35sWWMs+KLCuduj/q+/yp5dm6T4KUV7RDctaPx+W3b?=
 =?us-ascii?Q?9R+cVtlSHn9M8b4zIaRsOuMF8/0VK0fYEaVGogoOiR+mK59RhUNPOwD5y4G0?=
 =?us-ascii?Q?V3CyLZ7teE9v8W38lW6Ogjxv7lqPCZIvrm5AGwSewzr0JFsJCUgFgcryjuHp?=
 =?us-ascii?Q?1OkFd2H3HR8Kn2NXXBhjoY7QUAWo0InvAabtCUJ4WCNjtuC6ZmB0u72AqoiD?=
 =?us-ascii?Q?PKwhLBFol8OXNhCn+T6OFWfMxOuVTVS2fXxgV/lxZeZAlsqIKU1ZU301yvox?=
 =?us-ascii?Q?/72P6WGfjqekoq9EEtKIwImUEiLiKI50M0641PayfkQuqIUbghGv3Jv/LsTG?=
 =?us-ascii?Q?AIwzRWHJmwTMi3i42eRxWjtZciKzDpeTLONRtD3nRhZieD4sTczBjug4V/RY?=
 =?us-ascii?Q?/sMiaigRzlZvBxfPqjzWOzNX+ySLbFcucnltyPX1p7kt+wGQlYNPjt+fTzQ4?=
 =?us-ascii?Q?lNXgEkQLlPV2vrttlm7Bxi2LrIKPMuCTGF4Ul1J+vcobjS1DvKlKElLU9xjT?=
 =?us-ascii?Q?hl72htdMTl2Jlv1Bevp7M0ayJt+x0ePdU7ejxd1Pp38nSBJJ/C+f4egticum?=
 =?us-ascii?Q?s1LYc1VwwINKUDOn9QKKOs1eJi79wkWC2SvKGopF2rkPBwoexrbTSq8slyQV?=
 =?us-ascii?Q?XHaIxu44hiztjTAjjpXx+p/g1odmrJ87HPgQPa46KrJxAbajOdU/7qProJge?=
 =?us-ascii?Q?iKpP2mh/O2iY+n0eVV/cJbIOOJWJwDdpiHqtWzuE+o4CpOO/jfJCUmI1eqVG?=
 =?us-ascii?Q?2sBhFhSk5iy5E86vH28h?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aea34fe-af07-4784-09d0-08ddae77f2bc
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB1670.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 14:53:56.5700
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB10545

This patch series fixes some MIPS Lantiq platform compilation issues
found on the 6.12 kernel[1].

[1] https://github.com/openwrt/openwrt/pull/18751

Shiji Yang (16):
  MIPS: lantiq: xway: mark ltq_ar9_sys_hz() as static
  MIPS: lantiq: xway: mark dma_init() as static
  MIPS: lantiq: xway: mark dcdc_init() as static
  MIPS: lantiq: irq: fix misc missing-prototypes warnings
  MIPS: lantiq: xway: add prototype for ltq_get_cp1_base()
  MIPS: pci: lantiq: marks pcibios_init() as static
  MIPS: lantiq: falcon: fix misc missing-prototypes warnings
  MIPS: lantiq: falcon: sysctrl: remove unused falcon_trigger_hrst()
  MIPS: lantiq: falcon: sysctrl: add missing header prom.h
  MIPS: lantiq: falcon: sysctrl: fix request memory check logic
  MIPS: lantiq: xway: gptu: mark gptu_init() as static
  MIPS: vpe-mt: mark vpe_free() and vpe_stop() as static
  MIPS: vpe-mt: drop unused functions vpe_alloc() and vpe_start()
  pinctrl: xway: mark xway_pinconf_group_set() as static
  pinctrl: falcon: mark pinctrl_falcon_init() as static
  spi: falcon: mark falcon_sflash_xfer() as static

 .../include/asm/mach-lantiq/xway/lantiq_soc.h |  3 ++
 arch/mips/kernel/vpe-mt.c                     | 35 ++-----------------
 arch/mips/lantiq/falcon/prom.c                |  4 +--
 arch/mips/lantiq/falcon/sysctrl.c             | 29 ++++++---------
 arch/mips/lantiq/irq.c                        |  3 +-
 arch/mips/lantiq/xway/clk.c                   |  2 +-
 arch/mips/lantiq/xway/dcdc.c                  |  2 +-
 arch/mips/lantiq/xway/dma.c                   |  2 +-
 arch/mips/lantiq/xway/gptu.c                  |  2 +-
 arch/mips/pci/pci-lantiq.c                    |  2 +-
 drivers/pinctrl/pinctrl-falcon.c              |  2 +-
 drivers/pinctrl/pinctrl-xway.c                |  2 +-
 drivers/spi/spi-falcon.c                      |  2 +-
 13 files changed, 28 insertions(+), 62 deletions(-)

-- 
2.50.0


