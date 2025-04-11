Return-Path: <linux-spi+bounces-7542-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08314A850DB
	for <lists+linux-spi@lfdr.de>; Fri, 11 Apr 2025 03:03:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B247819E6992
	for <lists+linux-spi@lfdr.de>; Fri, 11 Apr 2025 01:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 077F926FA4F;
	Fri, 11 Apr 2025 01:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="YW6BXNDU"
X-Original-To: linux-spi@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011022.outbound.protection.outlook.com [52.101.125.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A41B652;
	Fri, 11 Apr 2025 01:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744333431; cv=fail; b=ec29hzVsPzgF8F4CM8QytWpzfy5XIiIV3AyPz3EY97G66fREGVuwlcdgwWMANE4Aq7xSJJfS5MDnoV3gMWWHL10mL1CNZ0vr0fjHf0bC10SVAWAzixH0VFroN4xetAcpZe3dFiTc2+HQh/MNuxBIHkOH+SO4/GtaC5rcorJ5JPA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744333431; c=relaxed/simple;
	bh=5qHCs+kC1BP6WfYYckz1els1K38Ju97D8PqvI5k+rn4=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=EqvhNRSyj4ck4q3WK33tz2JNg+Lp0KcJX+0nEj7PKkBE7V+WkL7AGVfsNy65aFGFWAyRxK1JHKUJ7JUctqor91jexulc0rt1KfeBBqc9Fl9uq52Oyu3ei4hQhuYKJ0Cy+b8zHbFYGyM+56ou3Je+n37vto/NBdZZtINpqkS/EUI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=YW6BXNDU; arc=fail smtp.client-ip=52.101.125.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QfK1B4HCK6iTYr8V6vmBy3Zq2vmd+6J1v/QCrfOVOWupueZb+aFmjwRFIv9uNzDTwAXx1fxdkDnPm4G+GZd6u88JN5euZmn5UXv+Lp/NBz7aFn3mY0wx8Fi+yKACeHQfTjjrW89ywtOuSrelolytEMZIaWNlO4qjvGGcI2BOEjHKMXwypQYDPxW4ZoS9eXDTW04hQsuYwRJAsKkbPbIPwye5oiIvsDJn41ks1hhILqccIRvEiYvoKzzXvDFq5+yVLH92acaKVUIIleahHKX0ytBSW/6+CZyhjVj+///YT7TSPqp28bsVNh1XU77wS9kOhbw5JutGhwf57GQFEzZoFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dkmnnvlSbeHRtnkmJw581bR7rWnD9X/S/sxUARVzG6A=;
 b=QP7mb+rq30M8Enj+XwdadkbtAv+mOL8to4R4DNZbrJd3DVhnFiQL63KjZMuNYvhrI78n40hF9wzqFOvUQ9cJ/tqRS1evV2hb+TtKA+fzl2/Nlx6K89g8KwXIrUmmPbTSv+iiLSCOzzhnIK1WrXH69YijKAh6DAjmNgYBreAiytnnsgY8KBggiX0dbzvRT0+XGNxl6sjURNClJ//JRugvK8lUEP2wvE5qxoRVuRGMPqYYOeLx7EFil9kR2xlBwi6na/xDwRXjHeorK82InJdKXfSlrQugxUZHnlnNg65YVSPAzye50vqYpGdfEUiVGphmP58hB3C73XuLWha7ArQ9tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dkmnnvlSbeHRtnkmJw581bR7rWnD9X/S/sxUARVzG6A=;
 b=YW6BXNDUg+Laby/9/cBnE+RPjxJ06Cs/svYj0fkgHeyXW9lAXb8viM5MVWjHAcq3YdA89IfOJyaAkY3rbyQBRkB1sQGC8guvSPnw5iWHkCP6OpFEjC+UwvSztkgFB7NJjRqS2jqPJvE4+X8MUFUdLH6ZooleQzd042Sd4lxm/lw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by TY7PR01MB13579.jpnprd01.prod.outlook.com
 (2603:1096:405:1ec::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Fri, 11 Apr
 2025 01:03:43 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%5]) with mapi id 15.20.8606.033; Fri, 11 Apr 2025
 01:03:43 +0000
Message-ID: <87bjt3h5lc.wl-kuninori.morimoto.gx@renesas.com>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH v2 4/9] ASoC: renesas: rsnd: allow to use ADG only
User-Agent: Wanderlust/2.15.9 Emacs/29.3 Mule/6.0
To: Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Jaroslav Kysela <perex@perex.cz>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Takashi Iwai <tiwai@suse.com>,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-spi@vger.kernel.org
In-Reply-To: <87h62vh5mj.wl-kuninori.morimoto.gx@renesas.com>
References: <87h62vh5mj.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset=US-ASCII
Date: Fri, 11 Apr 2025 01:03:43 +0000
X-ClientProxiedBy: TYCPR01CA0194.jpnprd01.prod.outlook.com
 (2603:1096:400:2b0::18) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|TY7PR01MB13579:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c5ec566-8231-45b2-ea4b-08dd7894b49a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|366016|376014|7416014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DJVQG3IgmLxJeufxP2klc0qH3oVOQ5ACIyLt781oh/FAb0wqhJcUXTQ4ToHi?=
 =?us-ascii?Q?X1vM0+GEJD0J6sD4RwB6+H+L4akqpHKICKKXnir0LejUW5jG3SSZFlBbT3DC?=
 =?us-ascii?Q?i3mfw+K/4uMv2EzXzSzPdC/Z95ltSFzXvuKkUsggz9BHE8T2iFVXtoc7y43H?=
 =?us-ascii?Q?yvZEVWajnun0/rFF/Lk3uRQPMEVyrqIZphhf09srTb8Zxz+ZEe3peaGyL9NN?=
 =?us-ascii?Q?ScW6dKATlEN6qmPtq/XGfgTuE8swwmpjSXtU+XF7PidTdsRlhPNVI4l6qYAt?=
 =?us-ascii?Q?RDzH40DxHItofwrlifyW8HOgNlsteW1WY9RRaLDBBUgk/H6mrx4/AfZJ5mZy?=
 =?us-ascii?Q?UqTnGAWxMXYdA7Ft5M5aP44xp3LznS/QC0GCiAyyORGi+oIQ7LsTT/Hw3C/H?=
 =?us-ascii?Q?bwXgTQUVYzN9Nh6w0UWfRcDSOPCH5FjPivG5lkTDUqIDPQ3/bC3cjHQENsqL?=
 =?us-ascii?Q?WbSHixi37rV5jroYoVHuGXFjWQ/qltKndP1mgyEwaT+oYhST34B5DstykV+g?=
 =?us-ascii?Q?ALlZi8b+XDh+OYXca65JM6uJt7qrinRGOttew6QX8XQm9NDb9VSpPjg2zg+a?=
 =?us-ascii?Q?/ThJ+ZTTBbftteO8LIe12IFRTMPZj5I3eJelJBraTNlca3yKkHB2dl48hfcA?=
 =?us-ascii?Q?oqI7QcHZWntc3URJUYCCYUYYQnGck3BrlauF5zWctzn2XTr9QxSuUVADha5l?=
 =?us-ascii?Q?EyPdd2BLkylwY0AEidqKBgfH82tQ3zdF7vIIy8DXFt85tJ7JqXRFG//YTi5/?=
 =?us-ascii?Q?7SQDK8vh4TkCrtUHBMnkbbIc0MFaXoPsNpGGsYPAv+LykAWbpP/LKlxq1sYe?=
 =?us-ascii?Q?w+/0vTK59cyXcQDuWdCEFl2JTxAJ/8vKZb/UGVhrA70phiN68XaIoYCnS39a?=
 =?us-ascii?Q?YuG2PT+Bh5NJhGsz2TLBL01koO7P1nDUcT3Yvbk4x0gmbIm7tov8GEEKq+6l?=
 =?us-ascii?Q?q8b0R/xNJeI43V7gfRMhbVxn5jRJabmFIs2mNLlEjar8v/uuSPwHIFj0ajcP?=
 =?us-ascii?Q?h0jxmiIkoh4GkMucZYlNi8Uk+apQ2yeZwSRYMdhlehYY8jC2toKzzL26ZPnD?=
 =?us-ascii?Q?6mOP8+RtFECkK9oABVXnhHPK0o5mSIdC+ruergicRfMZnLWueN5QZIWgN4Ic?=
 =?us-ascii?Q?1C6vzyNl5G/1X1CwMdxh6QPFXxE9g5btTqrCynOZPsHveQ6kErhhLU/23dLH?=
 =?us-ascii?Q?MM+hPjwu6eMBZVArSV2hWt0JcxMjIDc7XNNpyKBlT7GrLdDMxmcfQDEW1jjO?=
 =?us-ascii?Q?MuCdGyXWFt1zmfjzR9GfpQfilTnHyDOr8AKGVkMYF1j/WbU/cUVWU50XvP+Q?=
 =?us-ascii?Q?SNurlxO8yH4NjcQSgxu/l/09Q/sTVQP4UUjzJikrDKXFhSVSfbilrJD+0/io?=
 =?us-ascii?Q?nT5cGnS8Tl7HMn3GVttwFm7cuv4lN/aHxkrMnPErd4/FtQo7AUfOeBBsbSfz?=
 =?us-ascii?Q?Nq1QZWN/nCn1kUCtRBZ//5D4soIsdkHhQIqIdhg7W5mPmGA9ni6aSujOr2Ve?=
 =?us-ascii?Q?z7lu75dmpJcnTpU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(366016)(376014)(7416014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?arOMe0WnygpGvfUjonup6T09yhOwrXFvLCHvvYowgT8VkHepFIjD8omeAWdg?=
 =?us-ascii?Q?XmJ1ak6fRARTPRQbtGCAVfaMJL72qXxexyMcPaCoMy863vr2lOz8WG95Q9VD?=
 =?us-ascii?Q?35dspMP2h07+B/4TwkAWAZDvbG3o4ww1ue4pE7ahDovFtHH64bDVf5w/2Ukq?=
 =?us-ascii?Q?tbHSc8po6kyhkNuZsrm1nrc7AQIvSPH8tzZUNAABpKxIRa8lg5Y9SBZMPI1I?=
 =?us-ascii?Q?4tFqZka9+YWh83VFT/D3hlAwBBqbpodZp0XHOoGFG0eX4xATRvRTH2a6VKlt?=
 =?us-ascii?Q?5UZC78kLh89pzwlXTZ88451BzGB1Q5YG9sBiv2VfX9vNK2IVpaAdR6eTbdAy?=
 =?us-ascii?Q?F2ei2whX1uqcfU6vlPyglTC9+6q5NJrv6RkLU4vn3XLS9UsDFPq4y5Qz1/up?=
 =?us-ascii?Q?X7N4DwVftAur/x005k/qyAFDUsWn2wwod7+eklcalFGAMEiVC18F5U7V29cg?=
 =?us-ascii?Q?4qnspxqUcYI8GeZcYj4mRcEoiieAZdNHDUwzsvubxHmhu+kz+c85o79BYpel?=
 =?us-ascii?Q?CuHPf8ILYY7lVfzKTsqJLQb7ozew20osSzUX6POoxn0NVV5pK7qKoZ/JKEb/?=
 =?us-ascii?Q?cd0dqENAjf15mxiV7mhik2dWLZb+xDNWaOb0CJ7MZgOjC7FcmdrFKUTskXKc?=
 =?us-ascii?Q?t6LQSUBaxFDMr0hz7KY4QbqNMECy+ErDOvJtvRufVpIQ0eXVR8XHskJi27QY?=
 =?us-ascii?Q?zrDx9/STFXu9GtWPQdTA3A6ssNeWQn/baLTRRr66mfKk+GlzpmK3Osp0BigJ?=
 =?us-ascii?Q?8JfUaQuujAa3m07uBtLH08aB8Zl7xnpdIM59bSEa3oQkhTIGy5Taf3VMJmHJ?=
 =?us-ascii?Q?rRG+h7PE4LZCcrSa1b6caYCyhirBwPnQf29Ex/xDcZuukOiE1ew9+1BUoX0v?=
 =?us-ascii?Q?U8tANpki9amh6mTOY72cCdytJgwKDTAwE9UnhEwgX5dqSjEvXqEAE+vtft9V?=
 =?us-ascii?Q?N/3P2+ge7iFNxTNO74OAiPCHvRuj9PS/0TlrcGG84qFJUt/hrNwP2fGK+X7N?=
 =?us-ascii?Q?T+H0Lsh3Qyk9htUAw+s84Xgpq9pCWZpMhIOGCXiZnLnA0eJ2F7+Riro+Q+w9?=
 =?us-ascii?Q?nH5kz6OtpttcO+SE1uB9vc7R5EumonxSjx8DGeqQyMpZPA+q//Ho61RE0eh2?=
 =?us-ascii?Q?BbHX8fUBdjrBWSMRt6wvvBfsTZ/5L2DRJBQkj3J2EuJCxhNNSQcje8CwxdmU?=
 =?us-ascii?Q?Zcuh8k3ncShta6xgh9efGFLkMKXg+aXClcETSveApL+feSD5LUWbjGVOgdpc?=
 =?us-ascii?Q?OI9EwG6ryhcPAP/YRUUhABLhBlWuKYYF9MNgJ+KdXDzPgcDp+Ngoh6it+b3X?=
 =?us-ascii?Q?t15uzUb4HYWEWXe/jwRoDJGx65XfowMOZfyyy+Pd0b0TW69haorYKao6Rao6?=
 =?us-ascii?Q?UbGxHYNgH8j/PmkoBelLPmF9P/bu2JpQcbWVE+V6nnl8Z0d6Pp7ha7Ioc5vc?=
 =?us-ascii?Q?2l6XfIndqIgXTNjsTPgHSr4q4+DbCDJp34s7nQqz++rZjJgdLyJ54/YyHLxF?=
 =?us-ascii?Q?er1kn1BAIuVHhCZ0ipDFQkjzrqC+BEsXE2LKUIwee9MdS2chmH4UK9TOll9l?=
 =?us-ascii?Q?KiKV53oLgGeqAgkgJrUis3nYHy/t9SpZxHt4gm43lbImOQGWcvW/+FvTFAMv?=
 =?us-ascii?Q?9nOlWbKzuod+qQNf/FeV5rM=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c5ec566-8231-45b2-ea4b-08dd7894b49a
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 01:03:43.8398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qze6RQWxSVgOhfMK/X8QOdhi5ookCCVqOStRteYw/dt0b/YEqYvz0hoYvOmYsZ8cq3VhGrbLKeWzozXjxRRsBZVQhdrD4a6hJbd6hKegOlRnZgi9wQFZid++IgyU17dA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB13579

Audio clock generator (= ADG) can be used standalone, but current driver
will be error in such use case. Makes it as not error.
And, current driver registers it as fixed rate clock, but actual clkout
was handled when SSI start works. Setup clkout setting when it was probed.
Otherwise it can't be used ADG only.

Because of this fixup, current rsnd_adg_get_clkout() function name will be
strange. Rename get -> init.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 sound/soc/renesas/rcar/adg.c  | 28 ++++++++++++++++------------
 sound/soc/renesas/rcar/core.c |  7 ++++++-
 2 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/sound/soc/renesas/rcar/adg.c b/sound/soc/renesas/rcar/adg.c
index 191f212d338c..db980e4642b8 100644
--- a/sound/soc/renesas/rcar/adg.c
+++ b/sound/soc/renesas/rcar/adg.c
@@ -377,16 +377,9 @@ int rsnd_adg_ssi_clk_try_start(struct rsnd_mod *ssi_mod, unsigned int rate)
 int rsnd_adg_clk_control(struct rsnd_priv *priv, int enable)
 {
 	struct rsnd_adg *adg = rsnd_priv_to_adg(priv);
-	struct rsnd_mod *adg_mod = rsnd_mod_get(adg);
 	struct clk *clk;
 	int ret = 0, i;
 
-	if (enable) {
-		rsnd_mod_bset(adg_mod, BRGCKR, 0x80770000, adg->ckr);
-		rsnd_mod_write(adg_mod, BRRA,  adg->brga);
-		rsnd_mod_write(adg_mod, BRRB,  adg->brgb);
-	}
-
 	for_each_rsnd_clkin(clk, adg, i) {
 		if (enable) {
 			ret = clk_prepare_enable(clk);
@@ -504,13 +497,14 @@ static void rsnd_adg_unregister_clkout(struct rsnd_priv *priv)
 		clk_unregister_fixed_rate(clk);
 }
 
-static int rsnd_adg_get_clkout(struct rsnd_priv *priv)
+static int rsnd_adg_init_clkout(struct rsnd_priv *priv)
 {
 	struct rsnd_adg *adg = priv->adg;
 	struct clk *clk;
 	struct device *dev = rsnd_priv_to_dev(priv);
 	struct device_node *np = dev->of_node;
 	struct property *prop;
+	struct rsnd_mod *adg_mod = rsnd_mod_get(adg);
 	u32 ckr, brgx, brga, brgb;
 	u32 req_rate[ADG_HZ_SIZE] = {};
 	uint32_t count = 0;
@@ -537,7 +531,7 @@ static int rsnd_adg_get_clkout(struct rsnd_priv *priv)
 	 */
 	prop = of_find_property(np, "clock-frequency", NULL);
 	if (!prop)
-		goto rsnd_adg_get_clkout_end;
+		goto rsnd_adg_init_clkout_end;
 
 	req_size = prop->length / sizeof(u32);
 	if (req_size > ADG_HZ_SIZE) {
@@ -633,7 +627,7 @@ static int rsnd_adg_get_clkout(struct rsnd_priv *priv)
 
 	if (!(adg->brg_rate[ADG_HZ_48]  && req_Hz[ADG_HZ_48]) &&
 	    !(adg->brg_rate[ADG_HZ_441] && req_Hz[ADG_HZ_441]))
-		goto rsnd_adg_get_clkout_end;
+		goto rsnd_adg_init_clkout_end;
 
 	if (approximate)
 		dev_info(dev, "It uses CLK_I as approximate rate");
@@ -682,11 +676,21 @@ static int rsnd_adg_get_clkout(struct rsnd_priv *priv)
 				    &adg->onecell);
 	}
 
-rsnd_adg_get_clkout_end:
+rsnd_adg_init_clkout_end:
 	adg->ckr = ckr;
 	adg->brga = brga;
 	adg->brgb = brgb;
 
+	/*
+	 * setup default clkout
+	 */
+	if (0 == (req_rate[0] % 8000))
+		ckr = 0x80000000; /* use BRGB output */
+
+	rsnd_mod_bset(adg_mod, BRGCKR, 0x80770000, adg->ckr | ckr);
+	rsnd_mod_write(adg_mod, BRRA,  adg->brga);
+	rsnd_mod_write(adg_mod, BRRB,  adg->brgb);
+
 	return 0;
 
 err:
@@ -764,7 +768,7 @@ int rsnd_adg_probe(struct rsnd_priv *priv)
 	if (ret)
 		return ret;
 
-	ret = rsnd_adg_get_clkout(priv);
+	ret = rsnd_adg_init_clkout(priv);
 	if (ret)
 		return ret;
 
diff --git a/sound/soc/renesas/rcar/core.c b/sound/soc/renesas/rcar/core.c
index 30afc942d381..4f4ed24cb361 100644
--- a/sound/soc/renesas/rcar/core.c
+++ b/sound/soc/renesas/rcar/core.c
@@ -1482,8 +1482,13 @@ static int rsnd_dai_probe(struct rsnd_priv *priv)
 	int dai_i;
 
 	nr = rsnd_dai_of_node(priv, &is_graph);
+
+	/*
+	 * There is a case that it is used only for ADG (Sound Clock).
+	 * No DAI is not error
+	 */
 	if (!nr)
-		return -EINVAL;
+		return 0;
 
 	rdrv = devm_kcalloc(dev, nr, sizeof(*rdrv), GFP_KERNEL);
 	rdai = devm_kcalloc(dev, nr, sizeof(*rdai), GFP_KERNEL);
-- 
2.43.0


