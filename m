Return-Path: <linux-spi+bounces-7464-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F216DA81A35
	for <lists+linux-spi@lfdr.de>; Wed,  9 Apr 2025 03:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9487463D6B
	for <lists+linux-spi@lfdr.de>; Wed,  9 Apr 2025 01:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 166CE41760;
	Wed,  9 Apr 2025 01:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="bsJ0kTjp"
X-Original-To: linux-spi@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010053.outbound.protection.outlook.com [52.101.229.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4683829A2;
	Wed,  9 Apr 2025 01:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744160685; cv=fail; b=dRK6684j2NuoH5AUm1ZXNUwfR0XgivJ/d43ut0yrSsAakkYiJvABAng6NzJXFeLgO0ORXYCSz/fxyvC1pekGfeFcncXjb9LTtm3j50jWDlj1o8AOyQJLZEoXuuqKtqTSYOtcyIKRF6Q7vYOGpucljsRWEapGEKmGXGGoMy/A+C0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744160685; c=relaxed/simple;
	bh=F3SNhwY1umbJdxRjSHdhmig9YoqSv9hAGfYdIy/C3uk=;
	h=Message-ID:To:From:Subject:Content-Type:Date:MIME-Version; b=q0Kop/1fwYf94NE+gv96fEsQiTpPQVyspWQWTi/V8gU4QUedt+ndurUx2RDRrRlS9LsOYQ1iQZFa5vyfCwj2k3w7SpQ/18zTG2mvuomjSHbuqe+dvh/AbN4d0daRE6wDVl2sd9+UYUdMBqbKPqwCU9EJi3h0xtWiKnzGD3Ff3mI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=bsJ0kTjp; arc=fail smtp.client-ip=52.101.229.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S5O39C6yvwszDcNOUDef1QOFINohYY75iSnPTwMfyU16D7CysO/Akw1CWx5IB2Y7oy0gNgcyBiz287cqJmRpTfKkdZBYoWruIIHCzV0rBu2rNbERJgLZfzs3W1A2p2G+9BgfcTwCjSTwpweztECCFAQLvdmOQGjfteDjo4NPMPBE6jd2Qu3UoIMe+wriwDs6racj0bIo6JDO/Lwt4vWRLWnzPuFQjKZ/pbZ6K9YZq22e68a5G3c6zVAqzdXiDIwduPvmBnWCJxkHI1SNZtD3tNMGfoaorR/Bi5SN+hjQm6zw7WzBWl6BNHR5Y6YHukeQQI+HGA0NT5hUju064GE45g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6M5jUcRd1DgqDfM0Mc8JV2Rh36En6UR/uJ5MskRgKKo=;
 b=mGVtH5cMnQIw9nO1IxTrUO+kNMOfCR30yN49GcdKFcOQN6+jP5MXHFTHq5Wui27ag50llA3bUKYP2hj33lqttbvjsxcPyveuKS9/zHx9015MPkgCHyhgjVxwUIe0r36eE53TSVml/CboX1wYff1BZXvgYZvomRIZ02SM+oF4S78h2+ee4dj9YDPXQO4xXjBUctn6ORbgSwMLDCf5Uf+0jwcg2bLZv3IuS7HnaE95FFvmLa8nlRN726vNauuhlZCdvPgT6V/oNBOeUD7PhdS36IwP7XhVam8ciaw2BxlboAU2dekWrprz0hjXB5cSzb78pydJX6SrPCD5mDvRHgEPBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6M5jUcRd1DgqDfM0Mc8JV2Rh36En6UR/uJ5MskRgKKo=;
 b=bsJ0kTjpz1iigk5mXxCTJ3DBAWPHBA6XSKbpc/aulNs/cuVcgLfTjbpHsz5bHBjxNcG+2HlZd/uRvmgbIetde0zkF2EM31OWfL9w5VuvojP+iC84/Fw3eY1i09QqQZRJQ4juxniSt/uY/gu1Wb8mmaXd06UyPTn8O8V7qh+NRn4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by OS3PR01MB6437.jpnprd01.prod.outlook.com
 (2603:1096:604:100::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Wed, 9 Apr
 2025 01:04:34 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%5]) with mapi id 15.20.8606.033; Wed, 9 Apr 2025
 01:04:34 +0000
Message-ID: <875xjeb0wu.wl-kuninori.morimoto.gx@renesas.com>
To: Conor Dooley <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Jaroslav Kysela <perex@perex.cz>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Takashi Iwai <tiwai@suse.com>, devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-sound@vger.kernel.org, linux-spi@vger.kernel.org
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH 0/7] ASoC: add Renesas MSIOF sound driver
Content-Type: text/plain; charset=US-ASCII
Date: Wed, 9 Apr 2025 01:04:34 +0000
X-ClientProxiedBy: TYWPR01CA0032.jpnprd01.prod.outlook.com
 (2603:1096:400:aa::19) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|OS3PR01MB6437:EE_
X-MS-Office365-Filtering-Correlation-Id: f040e9c2-2b3a-4689-fdbd-08dd77027e10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NmdOxrhts4nw9tlYeJLVlEkYtn+0T0X6FcmnDjuaafLmDS7+pXYS9r4nsiTP?=
 =?us-ascii?Q?TGRIQ72emFP3EvSl1q65sJZQvD+xvlIBVAGgqdOrC1BW7uAloGGeamoE+h/W?=
 =?us-ascii?Q?sbbeqpV1Ef7CMJMWtHAHB9ZDIdqwqYIKNs0TJXPNbf9M7X05etg3vnq4INjv?=
 =?us-ascii?Q?l5oogzxQzIXdWp/WydBAwxz2H8kI0jHKYIa7gD9Xuh64oeImYib9ZWlL/5V3?=
 =?us-ascii?Q?ZfM1ar54XRoG/obAJuGNCpX/ThVa//IUHm9/87aaQpt22WVOsmbXC/dOkVnP?=
 =?us-ascii?Q?hdTlZ8eWmRbHJNPO+h+Z4yWtrbol1rtCBERKFrR4z760DeiQ5Hfgl72fhiiw?=
 =?us-ascii?Q?vw3HlzPBJVKOMuQ57CqWuxjK1olKoyHguswVfN2A8enD6PXp0lCMg7jEELLL?=
 =?us-ascii?Q?5Z+Ng8z14b8Ee+t86NbD524ih2Lo2cPnPzZCp7oX7waMDttrx1oZkGphYvBE?=
 =?us-ascii?Q?iyGjbgnWfBn/4aSW3WhHZFuZ4Rr4NhBIv6G8WT/YYJWGHgd5aRLYac9V3vnY?=
 =?us-ascii?Q?n9YVz3Rs+xz0hU8m/5kJaFtgPbg3AFcK4w4OJU8N/iGmfjMJthKz5XxV5uyn?=
 =?us-ascii?Q?cxrNJcnVXNy0lhRtPpROn+oFHd2n14XyxRHo/lXrm2iWk9cVH6wYH6Z7vNNb?=
 =?us-ascii?Q?Ruwat+WS3WpwVbxqylfGCjxpiq8jZHnic4uRcqOZQK5lmU4k454OCRpIesHG?=
 =?us-ascii?Q?eFA01B0H3QLrzUkELfOCAPmWsRm8qZFk/i6uzLgsYM+1Oh/0NuYzu15n3S7M?=
 =?us-ascii?Q?gvMjAS4Sk+lQWOB4iQTUGp98c/7m1JRvOm261BD50+InSO2vBxOT2FxNL0Bv?=
 =?us-ascii?Q?ef8fHBL2eIkoD6+fgSlO51a8eVjX8bi4v26p35vKQWgV5hCeSoaDJFwNkqeJ?=
 =?us-ascii?Q?Zqgxuj2ulupvVhcaw5vMic5K9pTTMpDLC8AdcRFs7y43Q6NyDjeokWCEaqM1?=
 =?us-ascii?Q?9w/KydDBSALO/29JvNOY9b0nnW8wKUq7CfcemVeNolbcKeB0bHypaoOKJtLH?=
 =?us-ascii?Q?qyV/S02pgc1oFCbvI3UwVqvF8PJE4BD1k8Tz6FW8HW09FpwTI9F+sCYxBS3z?=
 =?us-ascii?Q?vtYKINU2Ub5C5OB8w4GNJ8wPP+6KZCdrDeMBy6QuceYFFd0U4ob6lb4RQwAz?=
 =?us-ascii?Q?GAUJjIorBLXQI/4huDN+6iKQgut99WnhVK+U5wHcI0izy4MACl7Os0xdujUL?=
 =?us-ascii?Q?sXR0p49gEU2Oy2SvjTiAv2dq73MrsaCQAI5M9Mdw14r7VlMq7qDM5LKD7ovr?=
 =?us-ascii?Q?L9LTurlNQ0knw/a/P29AAobOyBl2naiqmXe63Gat0kyJcKhfdZYC8tlLGD5X?=
 =?us-ascii?Q?8DtCDZpR4pqA1m14v8g+j4VNDOEAJBwSYv7zjdmVxHKBVvZlwgZ3dz6rZ8Jy?=
 =?us-ascii?Q?Y8peW6A/Vjxr3NtL7nROu9/LpQiaNRrYu0SdZrUTWj6F/UgsO0bFjJgUboSP?=
 =?us-ascii?Q?scjrTG1Xj3+JrX2z+Tv1q6R8N71jBUg2tRWh6NdFqTG4ba4z0YAITg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zU0Bzwn90olOTl/NB5R1p7ipHrLD15mqKg8paWrPCGLq7G4h4gH9PBJ9UINR?=
 =?us-ascii?Q?9Y9/3lUuk9elgX0DWTsliaE0nDb8tewlbFSa+TebqnUplidnc9JBwxZXGOjX?=
 =?us-ascii?Q?3OTdeOkDWcytYEh4heXcn0Z0J/IKoFqUm0AxSI/dXjC188pJI3sJEIkUp/6b?=
 =?us-ascii?Q?2VhBE/JbMuShm2mOSnDK7PIAZAeNUD3A/sw62EtErU/7kN9RubGJy+6eZIrw?=
 =?us-ascii?Q?TURY7NFvXn7z0UcnS8IFlMGZjXaE4Grx7Gan3+wxmvIIQ3TWP+CsDFGDKwMv?=
 =?us-ascii?Q?oIP/1p79Rk34htdtPU6TuQh5eevNYR1Jc1yhqyFK/Vw31Goz/OoWjNh7txYJ?=
 =?us-ascii?Q?uhlXnNIwX52O+RtMi9rWtOornwdP3EBu/VAuv0XfTNsgSOUJIxFZgxK62J5T?=
 =?us-ascii?Q?toT/PuEGCdD1HAik11CVMR8XAoc1YVD084SiiaZNo8KwVTM0FCGH7IJP2Sof?=
 =?us-ascii?Q?TNbHpE6Gy2WH2Cd+qP8jbEWCFTpIpfS+zuczSzWkQjx3lp9UW3EVrqJFOFF2?=
 =?us-ascii?Q?C1/7urc0iF5B9v0MCgA58dKLmt/nij+ePPT+Vm117aZMB+mCpR5TZVW16FY3?=
 =?us-ascii?Q?v1KNrRH/sirvNtWyI/5PJ9FJfoOLRQ/gGAcE2K8rlb3ufoPtdEOfxLNLpZXd?=
 =?us-ascii?Q?2wBeGC6mjzrHJmmrDufAXbjMr6co0iMgnyxJUxpjPTSzPQzUjCteY5x+qrHX?=
 =?us-ascii?Q?XWr2UQ4tg18sqLb5YB0XhcM73Fqot4xud7LJQXQ9pg/MiBDi8mmxrid59LfC?=
 =?us-ascii?Q?RcZx2Cs5ku5+f6MnHgt2FfFyk6OFUUrbYnF8ZuUXKtE+ws82mJXy1feVYRb9?=
 =?us-ascii?Q?4OdNMdKhdk1mFwQB+GySa4n8ybM3xMWywi+JpPb+xH+iytBNm3FNa1NXhLTp?=
 =?us-ascii?Q?GOadDawBjhUbjg6ubnBwhTI6lGIqei0brP0vzx9F8wClzk/A8m5cLVcBk58Z?=
 =?us-ascii?Q?huJUZegh8JAZdBroBVei3y0rR32sCEv5d9WMByadc93AJ2NpeGAfFAkdErya?=
 =?us-ascii?Q?Ex9brHhDaJ4AdtXsZfxmXySuICcrZuRcDw+6Z5ta9J4+GHL/M7lpSc2ZAeqy?=
 =?us-ascii?Q?3VF9fOwEe+A4f/w1XHjUumWxomiDtnkMYHWXxoeHRiXN3YreS12SoFw/2y3b?=
 =?us-ascii?Q?Df6CtQjgxVOliQwsP0gmIS7dGUFQjVu18xSvBcSYM6TQBXLJzqnDmpm/6JMD?=
 =?us-ascii?Q?v3T2MLxMd8UO3Gy8F/9U4XztideJIM4P9PbOwuIyt9hFqUtPUu3QiPhez82F?=
 =?us-ascii?Q?OL/GZTHzdbLFZ4eI+7MzVyuxNxedeuzU8favbhBhhScvn6MHy+bFyfGmx/Av?=
 =?us-ascii?Q?SIfagqpcbFUoi/sIadPhLe81Rkah9cKEJJzly9BbUiIRLmHRPkyWC9ehzAQJ?=
 =?us-ascii?Q?uIB/smEZJlxPm1gTfsHELi84KWAxcoKe0RsUZeNctwm+NM8uXyn4Z3Zx2oIz?=
 =?us-ascii?Q?IBSRilSWIeWd+tTuQD547Zv5hQk2AyxkQ33HfXV9p7aapEolC00Wzn4fnKT9?=
 =?us-ascii?Q?wO7D8JwmnGVVgQYrvoFCVROeo4d3PM86VRLUGVeU0fY717CbnNXXn76cgbWH?=
 =?us-ascii?Q?tOQLLxKbpR0U7W3i8hFs5Ezbhzg57z5+UxKPngPJtEzgtQBZXjJo4vhpz5CG?=
 =?us-ascii?Q?m8m1fxq96jnSK8J2BFUVD0k=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f040e9c2-2b3a-4689-fdbd-08dd77027e10
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 01:04:34.6423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: naAeMt6aB8g+dNkN5AI2okDaPht6jFSvB1rrmUQeHyJyQ4chsGzOXqmOuPr54NNkUt4GIk0OGK7arLqkQhofU6ghtVBLZ6SQMkywyL5+r7SAUxNxWtu3JLXCuY/7RkKj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6437


Hi Mark, Rob

Renesas MSIOF can work as both SPI and I2S.
Current Linux supports MSIOF-SPI. This patch-set adds new MSIOF-I2S.

One concern is that because it is using same HW-IP, we want to share
same compatible for both MSIOF-SPI/I2S case.
MSIOF-I2S (Sound) will use Audio-Graph-Card/Card2 which uses Of-Graph.
So, this patch-set assumes if DT is using Of-Graph, it is MSIOF-I2S,
otherwise, it is MSIOF-SPI (This assumption will works if SPI *never*
use Of-Graph in the future).

[1/7]-[2/7] are for SPI driver not to detect in I2S case.
[3/7]-[6/7] are for I2S driver.
[7/7] is for DT, but it will be re-posted if [1/7]-[6/7] are accepted.

Kuninori Morimoto (7):
  spi: renesas,sh-msiof: Living separately from MSIOF I2S Sound
  spi: sh-msiof: ignore driver probing if it was MSIOF Sound
  ASoC: rsnd: allow to use ADG only
  ASoC: rsnd: enable to use "adg" clock
  ASoC: renesas: add MSIOF sound Documentation
  ASoC: renesas: add MSIOF sound support
  arm64: dts: renesas: sparrow hawk: Add MSIOF Sound support

 .../bindings/sound/renesas,msiof.yaml         | 112 ++++
 .../bindings/spi/renesas,sh-msiof.yaml        |  12 +
 .../dts/renesas/r8a779g3-sparrow-hawk.dts     |  98 +++
 drivers/spi/spi-sh-msiof.c                    |  10 +
 sound/soc/renesas/Kconfig                     |   7 +
 sound/soc/renesas/rcar/Makefile               |   3 +
 sound/soc/renesas/rcar/adg.c                  |  44 +-
 sound/soc/renesas/rcar/core.c                 |   7 +-
 sound/soc/renesas/rcar/msiof.c                | 579 ++++++++++++++++++
 9 files changed, 862 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/renesas,msiof.yaml
 create mode 100644 sound/soc/renesas/rcar/msiof.c

-- 
2.43.0


