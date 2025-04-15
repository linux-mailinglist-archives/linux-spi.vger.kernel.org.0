Return-Path: <linux-spi+bounces-7584-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82E74A8915E
	for <lists+linux-spi@lfdr.de>; Tue, 15 Apr 2025 03:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F59A178CC4
	for <lists+linux-spi@lfdr.de>; Tue, 15 Apr 2025 01:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8AE15C15F;
	Tue, 15 Apr 2025 01:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="GW0qdbbc"
X-Original-To: linux-spi@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011014.outbound.protection.outlook.com [40.107.74.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2C460DCF;
	Tue, 15 Apr 2025 01:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744680871; cv=fail; b=L7RZjRoZiF1MIL3U7bEJFaugLKb1ApxSGNW5NIos3oc83iHJ6B5IY6oafnfOoKxTaLsAIoTKM+rsGuml0fW92Lu3kJFBqo7KY36fr7JnfLeszyhWsrSmnwyHJBrIXsb/eQ4gEWXlFSYgVLaGCyq9giP249iVpe+6Vp6SxNrNj+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744680871; c=relaxed/simple;
	bh=mDvsYIMTvOtVS7R6IKeEi0pgPP+mJh+fCgpGMRej3pY=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=c5OOUCwfuQXN82n72cviJ7+dtB1BhVUQHHl+/ku63sHpdX9/1QtIhsNye3c9iLKmDVtWuXFu0ea9u45kssIZAbesaPJHg8/DoUAKb9+ng0c0gair1rGtU1KRvwWsqCCHgxjMe4XN9EoRnUBVzSUGHui3x5KjpQNEObpyGs2+g7k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=GW0qdbbc; arc=fail smtp.client-ip=40.107.74.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DJh5Gm9FPa5wMV4F4rD2U77yZHeG65LLhFcV8LSYHAEHdScB5pV1kjuYldR93zlrFpBIbaeQvwhV111wKpgaJB0ByIK/3ZiZbiWXFNnXEj5EXCZrdq9QAg++fyfswPm0/rHfg0bLdaNSUUGSxIYA+oEtiVRwChp4Z8I08ZhLfOC0AKlPmHpv8AZqpf4CyMJGToGl3RA8wEahlkxmMtLD2bwc/ZrCoRvR4CmyKSCECL4oKjRchDi51t6uMKSDpMAv5iIBHLM+jQK4GZ4Hq97jCFAI99LNJYnQowYc4YC6I0o/APUR16H0vpY5P0Yw2uxUVO9hWXIRPguxrS1NnwneIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ok2ZO0z/yHOaFe1WKU6qMasK2gRBah1QDpxwEjEfV38=;
 b=AR6piuIxeFEspq2DM1WaakUlt2HRecDiOphwA7c1VTZmqK9ILbBQjCZWDiNbZ1rUWrRGTcj+zX0tnmnV6in/8lGbvAON7ZoAs6XATh5gKz80noIdArpgefIGnqdSzbsPUTBz7JCDzSi9w8F8x+XsVUtdM7CV7ll9O6JrlUOv1nxtphZt7nbl5mMjR5PS30q2FHZq1J6VUXzuXkXttplJy/N1vlzV7lvdBA3YGlaVxh2aK67+kujs99onW2aJAqDVgRA00w2WyoVeluxZxhJPEsgbZcGmJXk5OYLfUai7b9V2q/094K9J/f6d2sMs4NjvsTs8S8yOpY/yYPdd3GbCPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ok2ZO0z/yHOaFe1WKU6qMasK2gRBah1QDpxwEjEfV38=;
 b=GW0qdbbcItOzRfkYfsz9ApJHWvDB+mxeQTLobVHWKJJKUomFFmExW/cdt4pnnjrQPKeJAF8/Zx3cZ0hMZ1HWqlQzQPMrkWMiMk8Am5hDVJGi4i1xPItPh/gmSXMRoqzFS3fpBy3XbN06wHnj2Gz8gAx4hpnEJHpSFLkDbZQUkbc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TY3PR01MB10906.jpnprd01.prod.outlook.com
 (2603:1096:400:3af::14) by TYCPR01MB9536.jpnprd01.prod.outlook.com
 (2603:1096:400:193::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.36; Tue, 15 Apr
 2025 01:34:23 +0000
Received: from TY3PR01MB10906.jpnprd01.prod.outlook.com
 ([fe80::592:9b7b:ef57:2dd8]) by TY3PR01MB10906.jpnprd01.prod.outlook.com
 ([fe80::592:9b7b:ef57:2dd8%6]) with mapi id 15.20.8632.030; Tue, 15 Apr 2025
 01:34:23 +0000
Message-ID: <87r01u1a3l.wl-kuninori.morimoto.gx@renesas.com>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH v3 06/10] ASoC: renesas: rsnd: enable to use "adg" clock
User-Agent: Wanderlust/2.15.9 Emacs/29.3 Mule/6.0
To: Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Jaroslav Kysela <perex@perex.cz>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Takashi Iwai <tiwai@suse.com>,
	Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>,
	ALOK TIWARI <alok.a.tiwari@oracle.com>
Cc: devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-spi@vger.kernel.org
In-Reply-To: <87zfgi1a5a.wl-kuninori.morimoto.gx@renesas.com>
References: <87zfgi1a5a.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset=US-ASCII
Date: Tue, 15 Apr 2025 01:34:22 +0000
X-ClientProxiedBy: TYCP286CA0207.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:385::20) To TY3PR01MB10906.jpnprd01.prod.outlook.com
 (2603:1096:400:3af::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3PR01MB10906:EE_|TYCPR01MB9536:EE_
X-MS-Office365-Filtering-Correlation-Id: ba543485-d5c7-41db-a642-08dd7bbda68c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|1800799024|376014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EjxXRNltpy35ax2tIRXg5OC8SJr+dovKaB275cJU8xlo3eYZIYFu+hYJJqpP?=
 =?us-ascii?Q?pe5Mw+r7Gj3Ji2zj8Yql3jDdFf5RGO57TI+ksu7prdakKVTO+mCqDZ5T1noz?=
 =?us-ascii?Q?2PGn2MSIh8cFwyhPrgCC4NpCfWaWrS1a9K9WAuTPlHLOhjkFl5LWIt52jdPl?=
 =?us-ascii?Q?/nwjPqT5VJUQD6tXrhFllRBydM3N3kBWOaaHXSmqV1Ypri2JniRJIBgj3d6O?=
 =?us-ascii?Q?wOQXp5mvEnl7t+agl+IBdCHIV58DkTv20c6/xb+ol7Fe31HWtnPwcowaVgdX?=
 =?us-ascii?Q?wgCaF83XsyaHLx0REEuXuWqVEipHepCBr7AU2r4d16e3n7sMDfbXGSv87B1V?=
 =?us-ascii?Q?MEMQT/HHTemfqsxsFPlJ1HECP1eLYUcb2lM1qfw1pXzeFK6h6TQagdr8Ijll?=
 =?us-ascii?Q?3HCgwHxPjjmYQF5CLG0eTNgeLlCkAb172rQ924zpms0d+SPnkBwGOzyUR31i?=
 =?us-ascii?Q?xn43OsP4qYrPmtBaiObu8MqWFDvdWUeqvNmYqdiFJiY9JpVa8YOMFtt5fuEj?=
 =?us-ascii?Q?BHecgCAH+Qat5sIckBOFNG+/HnQFd59j/PnyMkc6Dh2E0OtFgEpfoUYSF2MH?=
 =?us-ascii?Q?203ug5vl6ck6nUdm1tj3tqNxOqr+nWA7WuKTVse0nnaCqH1WsWiYxZ+/k7VT?=
 =?us-ascii?Q?sPUenpDIDhuYE7QCw6BEmP3CArxJ4Dzyw6bvlugZHFkMFLBOeLAiWsA/uxld?=
 =?us-ascii?Q?RJXiyHZwOi16o19chNhGm7MNCnUQfZuPE0pFnV1IH6HUAcI34bap9qfLUr+k?=
 =?us-ascii?Q?1YBRsHenlCLMMGVfk1D+gKQIRLWR8uD5HB+i71i5Bc5sSuFY6lZEwsS4K6HN?=
 =?us-ascii?Q?qrDMS15Xvz9+f6relqeZFDWWNSJsIc8u6qvnLiv88cA3JCzOmseHcYZ5DOPJ?=
 =?us-ascii?Q?KAoxCbyQmnOGM0kKwtsApHVSjZ1PV8V/NmscD7bpHncbJ14DXCpZ/BokbjHU?=
 =?us-ascii?Q?uLTf7A7grPRB3yQLBaRQn+Oq/Xopp+IbH+B/6mO9v26XsWh1e91YPbsl4wM/?=
 =?us-ascii?Q?BHNRm7sf9aVXTLlHEbsZS1H8mS64UZ+bk/NcMVSry+rWZU3eg+/tVwCizYT8?=
 =?us-ascii?Q?GtNZmHTVhKLGpBaJ8KiGFRHgLBPeYUCj2+Uk/MvZTOX+kzAcC6H8hEB9Wz3T?=
 =?us-ascii?Q?EA88BhgMS/f5kk/6DWX2UzKxu2fYFQZkswBnO1dBPj6hwPKzxkiRO+hQMzK4?=
 =?us-ascii?Q?Vlxr6BV7LFTAuIqNfF3dTJ2ySJwjbVhNSXcfRl+SJE1zg6hJhKsd+qSbZmGS?=
 =?us-ascii?Q?uaZmQQgLUJPNc9Cvr+/269+qZdWtHLr8RjIjBbaa2gTj0dHaTVSPGSWxcZ1i?=
 =?us-ascii?Q?r6mePb5TLRUmX8rwKhU1xTY9weGjS7wzP2HBKUi1hsYxMbei2VnjBmwOh6nE?=
 =?us-ascii?Q?tZ/Kisy+Xc9nB1pHB+WtENyycSHSrLaMylbDxgXVNdd5fcQWVVVRhrbO36n2?=
 =?us-ascii?Q?p8pi2OJ0wPxdS1w+V/D5m6UUCpaTVsyE0vVD2Uck+6GXKIaOvXjAR4f3OAaB?=
 =?us-ascii?Q?4kYqNbmuAc5GI0o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB10906.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(1800799024)(376014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?T+LJqtRWZRLJ6N+MS9gl9OXtOFGTur/eXH07N4Mm8FEY2PVUYc3xLBx9KIQZ?=
 =?us-ascii?Q?CRlLA63w0CTVwhsOZLEiQhiGfQm3O9r87Npgh0bHcZmf0r6RR2Lw4mJlDDES?=
 =?us-ascii?Q?zyzIsiJHVt4l507cFrH3ggkd4XtDgEiDYGN1SMHqonf4N3cP/ZrE7kOUOX2t?=
 =?us-ascii?Q?L4/dxd/uS9pbo6s9im/RPEEfwNR3waEq14H0S1g2Q2Tny3k2BWGYjbyC9UZg?=
 =?us-ascii?Q?gWD9wEgDxYHlp/jz0pHOQ9Xx/LTN0uEtiwqS58nKmCOLKoA/Y+V9M1Ns+iU6?=
 =?us-ascii?Q?etzqUAzAzsbwFJafXCfG44e0SV5hSGpV4rjPhFZLfSyO8ba5ie7sypvV9yfD?=
 =?us-ascii?Q?SYy8C2B/PYxTw7wUHJOk7H7ohvWzfJljDWBuQGPIhouDsgekmbTN805/isBx?=
 =?us-ascii?Q?E54V4B5UKgLJWoefvP0yORJRw/RCrH4N1u/PC5aVlry2IoS8gOD8F6PnvnwJ?=
 =?us-ascii?Q?z5qC61+RO3DdVd8R0YkeGOzj5EweCk1SrgAgt4kcMxgII7Cm1tDhfB3+NFHM?=
 =?us-ascii?Q?qsm8R4EOTT2nkzyUKLuaDmw1KkHOzc41njOSQkVu1Wc+SJaBEfH/1of+Okyc?=
 =?us-ascii?Q?vmU9jTU7RAFx3p3NYpqpgBFEez9xB9/QCVs2IaT0Y8FMH5A7orAwja5x48YC?=
 =?us-ascii?Q?5mN2F15G5xAEvn60VtOIIK5XWK62qnmuVzZmejWvlWzFf6xrA3X7yug3duhV?=
 =?us-ascii?Q?q3vZhR8w8LDZ7eHidSZsy/CtkzuFJPJ4Y/wzBsBjU+i/she0wiT/E3XtQFkH?=
 =?us-ascii?Q?i2WjCWz4ojLxUMrSQ8j66ohnf7kvtATg2dx1LWMixiTVBHkCUEDhCy8eU7hA?=
 =?us-ascii?Q?rrFb1FqhuCi0sTr01+ECNj/+1C9HFtxeA2DYzkeDHM3BADFJB++wYIJ6BXlL?=
 =?us-ascii?Q?wVWiugO/ozU+9iKqYbqhvgVnxxuVWQNYS99ppzFVpBa4gFXxI3frHRFaicOg?=
 =?us-ascii?Q?9yFnyTPw2+ITMmmm3absPcjdDlfs6fK0KGsiI4GZ0A+0VnBz/ylWHtplMzD4?=
 =?us-ascii?Q?n5Sy7G8rPh5kKAmgtQeQJRMc+TXXRPPVvEfAqfYWc8//444zD0Fr+mKjSCVZ?=
 =?us-ascii?Q?NqIgp9FWBtcd3zkWvGI22AwuVZYBVbgL3Hkn7OI+YHtEM2ADpc5g2WKakpMJ?=
 =?us-ascii?Q?ZBM6LuLxEoHqxT9tm0+jcYge0Fj6a0V2DhN+N8eGRQ1T4r9GL9tcjplwKbVK?=
 =?us-ascii?Q?Oaagdzzro57XiGUu185pFlGCfagu/moP/pVqRht+6jXHwSbxFVI/OO5vGNPF?=
 =?us-ascii?Q?kLQR8uoe5Cg/e/Z9i3O8LFgfJXwgwgwP0H/erdb7mYBP1ikGClolgfOK8Uk3?=
 =?us-ascii?Q?ulZV0JBLykFVTSJZIo+6XQG9vmzocUBokFWdyDBCwRMXRFijABAM1NbTFrPT?=
 =?us-ascii?Q?4bqOgCay5KPQDlzoir+dzG1YREutaLyKJyXBa+kLL7vZOKsUHSTNrMgXOznw?=
 =?us-ascii?Q?qdVbJpqLCtSXgM0JInuM6p9Y8/PvfWqZzsRGEBsmZzURMl6hPA74jUkhoWl9?=
 =?us-ascii?Q?j0QrxIrwalEywVGBzwhLZjBO9WrRVaPBzAZUe3pgJ4t+DjhCoMPA82yC90lG?=
 =?us-ascii?Q?B3SMq+Dfho3JOQhOAhBXpX5ZJsId3C4VJMIfPnlD+JsosBQIMCoEUHd+UvLU?=
 =?us-ascii?Q?vxUbgRBORXBpJ0lCtg4MdyE=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba543485-d5c7-41db-a642-08dd7bbda68c
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB10906.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 01:34:23.0935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ziFMNNd8IL822TzHrxJcPjYDCtouj2i/1D7WLvynAluGbQiip/uq9CEHYPzxbJMw7eKCagUtbnBssRWzEG1rst0e2wO56m51HbwdEUC6ZC1fwGR0b5+5Gy14y2uXQwVx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9536

ADG needs its MSTP to use it, and it was handled as "clk_i" before.
R-Car Gen2/Gen3 are using it, but Gen4 doesn't have it.
"clk_i" is not intuitive for ADG MSTP.
Let's enable to use "adg" clock. It can keep compatible with R-Car
Gen2/Gen3 and Gen4.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 sound/soc/renesas/rcar/adg.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/sound/soc/renesas/rcar/adg.c b/sound/soc/renesas/rcar/adg.c
index e6b7273b27ad..8641b73d1f77 100644
--- a/sound/soc/renesas/rcar/adg.c
+++ b/sound/soc/renesas/rcar/adg.c
@@ -31,6 +31,7 @@ static struct rsnd_mod_ops adg_ops = {
 #define ADG_HZ_SIZE	2
 
 struct rsnd_adg {
+	struct clk *adg;
 	struct clk *clkin[CLKINMAX];
 	struct clk *clkout[CLKOUTMAX];
 	struct clk *null_clk;
@@ -386,6 +387,10 @@ int rsnd_adg_clk_control(struct rsnd_priv *priv, int enable)
 	int ret = 0, i;
 
 	if (enable) {
+		ret = clk_prepare_enable(adg->adg);
+		if (ret < 0)
+			return ret;
+
 		rsnd_mod_bset(adg_mod, BRGCKR, 0x80770000, adg->ckr);
 		rsnd_mod_write(adg_mod, BRRA,  adg->brga);
 		rsnd_mod_write(adg_mod, BRRB,  adg->brgb);
@@ -419,6 +424,10 @@ int rsnd_adg_clk_control(struct rsnd_priv *priv, int enable)
 	if (ret < 0)
 		rsnd_adg_clk_disable(priv);
 
+	/* disable adg */
+	if (!enable)
+		clk_disable_unprepare(adg->adg);
+
 	return ret;
 }
 
@@ -475,6 +484,16 @@ static int rsnd_adg_get_clkin(struct rsnd_priv *priv)
 		clkin_size = ARRAY_SIZE(clkin_name_gen4);
 	}
 
+	/*
+	 * get adg
+	 * No "adg" is not error
+	 */
+	clk = devm_clk_get(dev, "adg");
+	if (IS_ERR_OR_NULL(clk))
+		clk = rsnd_adg_null_clk_get(priv);
+	adg->adg = clk;
+
+	/* get clkin */
 	for (i = 0; i < clkin_size; i++) {
 		clk = devm_clk_get(dev, clkin_name[i]);
 
-- 
2.43.0


