Return-Path: <linux-spi+bounces-3735-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B0D926696
	for <lists+linux-spi@lfdr.de>; Wed,  3 Jul 2024 19:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A9A11F2363E
	for <lists+linux-spi@lfdr.de>; Wed,  3 Jul 2024 17:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D3218508B;
	Wed,  3 Jul 2024 16:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Gylv5GDD"
X-Original-To: linux-spi@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010002.outbound.protection.outlook.com [52.101.69.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCDF1836FB;
	Wed,  3 Jul 2024 16:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720025991; cv=fail; b=e5IkcflXJGtmNW2HUvv6kZ3RLi4Ii+bcDxF4aXivJwqcUm+u5lmlzImuC3fHr9RPtLTAS73sC3pVBIHZHNWsVLyaA9Rr4pVQ52gO8DVqLtiXzKRJUhDOJPcUOVwYKsRd57Dc5ySGymY2uE8HvKFPK0xrPjLoIpRWft1NIybegt0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720025991; c=relaxed/simple;
	bh=/lv0BfadPxL0XdGjOmqTO45Gx0WqRn3UBc97a/+AayE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HsbxmQr5BHNTgiynn5ytHr69itUnUa4N8xdwyjvb5Ez8AziaRLO8B0JtGbMa0mKJu/gots5DabQ5TdKF1zAOeNWTrGVeFn5/FwG6YwQkOvaVqPV/JcA7hcyHqHDJtOd2NKzwO+0xvZ0XlOcpGzGeaKEYR69wkIMY/cx3y52474Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Gylv5GDD; arc=fail smtp.client-ip=52.101.69.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rm2e1cMsYKlEvXGazQjrohVoDynBS8xSvlPPNcSEVz+tVIQarhyjnC83gvYSS7QWoYh1xWprjU57GSzp1SsgYNV8socpMmNmmb4l6hLy20muqKNHXgUgZBZl422m/HJV1E2RtEtklD//99EigJxYUiUQctE7+vyT9fqLQGsM1KMO8uI0xlUipxkky4MtuMtHJ5LzORXzf/T3wGCdf1B6KDeIwAk8oJVqKl4Ob62B6n/us5BTUVcML+iTIgk7yUg+v4qKu+YrtbDPwF+O+Ue3SgqKEp81+J+JinUB23y2cq0jajTcCWOgFosdZgdxtO11nHXMtyzF2OfahxewXcq9fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MusBSkIdzPfr8YLej69KMmTg6YKAfCSCh6OAfo+vd0E=;
 b=HrRsWpRTJE03PM2si3L0+aMU8bJJOhFeNSH/qArG9CYe8mN/KhdrgJBvWdFnGqVNObKd1lyXS3SGi2ZkXpB7XhzttgAggCyym+QykBK3Irj1bDlUEZmzMjUKC8zwHayo5KSO2lRTccwGKS5hT2WjN4KBj5iVbKvwNsbRg3+krd/c6QV3bWrkpwcscvGId04pga0ghJ2lgsb5HfuO8iMF5RNtiujBvsWv+wioJnfheRNWh1evKBdjLb8SSt14NdWgrpxagfCXXmst/D5k+Lb6xaQFN/QOIM3WqXf1+PGyGrzUSu8YSbJcMppxKNesppg6T+FhhSvKPXcNbcxXBSna6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MusBSkIdzPfr8YLej69KMmTg6YKAfCSCh6OAfo+vd0E=;
 b=Gylv5GDDJDWMTbDvt7otVwk9YSWDgSXcoHe1Mpf3lLqfB+s4AdpIV90hXVzguWyN2+ksgwNI0LlptaqjOM5nAOqba6uWUZUGcK1W2lnoZMqRQlTRUfzsqHsUGscYBD2rnjN9kPLnJ8bMj5BE1FrMasq6lKEF1rvGeqCqaamlgG8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS4PR04MB9435.eurprd04.prod.outlook.com (2603:10a6:20b:4eb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.23; Wed, 3 Jul
 2024 16:59:47 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7719.029; Wed, 3 Jul 2024
 16:59:47 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Vladimir Oltean <olteanv@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-spi@vger.kernel.org (open list:FREESCALE DSPI DRIVER),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH v2 2/2] spi: dt-bindings: fsl-dspi: add compatible string 'fsl,lx2160a-dspi'
Date: Wed,  3 Jul 2024 12:59:31 -0400
Message-Id: <20240703165931.2325807-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240703165931.2325807-1-Frank.Li@nxp.com>
References: <20240703165931.2325807-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR04CA0023.namprd04.prod.outlook.com
 (2603:10b6:a03:40::36) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS4PR04MB9435:EE_
X-MS-Office365-Filtering-Correlation-Id: 70bedffe-825a-4bdf-a8ae-08dc9b818b8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gsHlN8Xp0ClrnROjLRoOcLxCXZu0+AHym1iNz7tp6mn+SbCOP1rHVKsNlQNd?=
 =?us-ascii?Q?RHadF4AJh1Ds5W0cyzufh2VMbLmi3i9zXNRzw1nBj9VVuYKdRIZJaiXYEnaY?=
 =?us-ascii?Q?8MOdEFMamARk3tgoBHDV4XMU+BJzr5gnNCnJNEozRPKxNK7Uh3fnG6Iv5AXY?=
 =?us-ascii?Q?91MLMBWTMVwAHXgljX0e5QgoaoEQnGLJuxw9RixTTsF1KWXCdnbWVz3NgmVr?=
 =?us-ascii?Q?DR90uLtzlr7XOJZENHuFJHD/6DFgq7tXW8xeoTfM8bsOAaMCrO9QCKu8n0TC?=
 =?us-ascii?Q?vlSp+q/5IMIVajasuRk3mnOGVzcu1zKhY2wHhABpkBrp1Lsinly6zirS7bjX?=
 =?us-ascii?Q?MnfwQhXHTP1tv4sF5OcUs8g7sRnF01n+j8jJBwrxS2Ez6mJ4Ezpwsiz2P2Kg?=
 =?us-ascii?Q?k9nxjwN4r4IlKgoGTBG6kWRmfYBfkuZHTv8aOsIhlgjmAVs5gCmjFonslyyN?=
 =?us-ascii?Q?gMhkW31gKwujZCpJvSP56MNzyZ1Oe6O/apVETvIKv6ehkE9hbSWH071ATFig?=
 =?us-ascii?Q?YyLjC/HUsVKiwoPUlovQB/MV+rvQ2bHfcXZnQ7mH6kZYc4dSKLbdVhDEQyC8?=
 =?us-ascii?Q?vQoY0pyY33zsEJP29hqUqiNugos/aeIV1Ymqzpy7VPvpWLNySW+hJVIJ3MAv?=
 =?us-ascii?Q?xHHJfsOzFspT4v35L4XPBj4nDPXvue3OAdg29i73aUyororPT6vjS/QxZhnI?=
 =?us-ascii?Q?wsjd6Dk4W5tXOwPE8wULGphrmRKNJIiE37Wfq8VKASK2D0KH0Q8doBNFIuRZ?=
 =?us-ascii?Q?3WLFkYQB7EebnkZT/wXa2WH0QHK+C789p8D5CmLnWD2aDk0uQ4vUFIz2hp0B?=
 =?us-ascii?Q?O9WuOAlSI0WGCODi9hheJS+hDiTYHNcf76JnPlqAn4+0Pm208O8ghXmkHjlK?=
 =?us-ascii?Q?tqrHG3CEkVd3QiJAxepPe9FRCTkNiY6oZSnk6PbAIjkadzENIHoZX9eo9cZU?=
 =?us-ascii?Q?2qUvm4IPTV58O59JdDUGFbWuACD/P0DNq5u0kQviyi9CNy7biqqjSyilMXXK?=
 =?us-ascii?Q?plB7jmrZxtdEImkwFkSX5sSs6MkAuWDpyFQyJEpE7GrP2FKEWhw+Sq6HHe1N?=
 =?us-ascii?Q?kXe68ZwdTSOTkxQiuxa2NJs4jhqCqtU8vb81RmS0oPwQnkq1HiAsjK2MX9/f?=
 =?us-ascii?Q?OiprIM8agWNYi3btC3gxjxGF/PlMCBPq9MKFWdEvbZup3FrBzgVTGCloUq0s?=
 =?us-ascii?Q?vsf2ks2aO+hNcfTecFEqdWBq8hsbJKgjdpZYMxbHVtukb64dfrsv7fZgK3Ms?=
 =?us-ascii?Q?XGeV+7h51CRxheZ6kMszBkB51UsprqcY5kkNzGanTlxMD/iOKkOBNTGanbPf?=
 =?us-ascii?Q?YqwudJqXcyEhWJTv96ewEya/CgPID2yy2NZjrrIfJPoKaxN/cGeFzTlGrtlo?=
 =?us-ascii?Q?CjFCSC8gpKtqlcxmrtTaaemsgyxyVYmhx3JwS01aE7I1u1xUsA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RbWzr9d5CsqSeP82hGBchxWSFcu+Hgvnv9+qC9lh0B+gGnnN4REsKjuv0dkV?=
 =?us-ascii?Q?M7YFOR0heobVuN0gadAyM/GXbH1ACeisu0Mx6tTCtVHdM622dBqB4DabjUhI?=
 =?us-ascii?Q?9qWU4IBl7bCNmbDzhwN0+nsAZMFTjZiVuAqb/YcUephklu9HGTHab+OJL6VU?=
 =?us-ascii?Q?4aT92Tmytu8/RlPM35PdBO3b27I5fkdLMmGikT/fzHJlbejb7XpJpLVLwIpl?=
 =?us-ascii?Q?55PJyjZft3cCOG/RqeAjOSHAsiZGgugyaTZoq38aGi9UNivRLYJocG5lW03a?=
 =?us-ascii?Q?f4EDrIyGnu0m0u+1SwDFOA1pBeVOiGNtyU+tjZr/s2b5qMu7QZzbXdCRgg4h?=
 =?us-ascii?Q?hCszucNejcvDljJeuDqJWIvRLBVb/NECfsHpgpKoeNqcXbDBPm0T4xvqyEbz?=
 =?us-ascii?Q?g4fKlYpgrX6qMpGe1PLFx3+s4c0b49F1UL6WCKHfZGrG++vMDBeR9dVKDZwj?=
 =?us-ascii?Q?u2YGA0Yei6CVCcyc+0Xqmp0iW6lA62Klml1aS7rl3zhqvXgiVx5FYpL71XhC?=
 =?us-ascii?Q?PXDcoQ/9/YmJS8WJVLcvmv3441h17feOHe4vmyy6Yr6xdkU25pePjR/Z16yU?=
 =?us-ascii?Q?phWujXF+vV3sN1p7rVMygp0B3n+P2xHwByIzi/cjx17dZXdowpy97s7MbqU2?=
 =?us-ascii?Q?zqgPRozA3HUpGSrMecoCpr0Nn1TABpnX5IjIa50zHPHA6xlsM+rN8+EQr8SA?=
 =?us-ascii?Q?GEllqYEQT1INe/ciDWItbc/A5S/SZZyESpVN7bNks4MoZVnf3gDXWNJvH256?=
 =?us-ascii?Q?3eCKhM64gJEfvRsApk09jXklmG/Anm1uY0czxm6cpJ5TLJDgKZfyGyR/EWyn?=
 =?us-ascii?Q?ka0n68Oo226BGY2KWxfWb1SaAMCatyrsBf2DtW09HyL3231psPMN2gl3kkvq?=
 =?us-ascii?Q?epvXWxUGkp3vbUlTyH7tQflagapV3QyJshcJ290U4+zHDBPJ9c6zM9gKxCMu?=
 =?us-ascii?Q?/paRoX8+NCowau0Mf+hAArIv1wWc0O4bFhXO5V0PLpSNvgzC9aYe8EmGZHGd?=
 =?us-ascii?Q?/oXWJxHIOZao5p6LddqIlQdVEk/avwk+YvA/HX0HKBhamEYkhsHdNzXieDAU?=
 =?us-ascii?Q?lQ6nRwDEHhpraLF3OYdcAIDoL5X0vakL2XlMklyx415T4jiSblF5qqDbPm7+?=
 =?us-ascii?Q?/wRr0+CaVB13waykFKL+R9mOgbtYONo68FMsKnnvwLw8ZmR0BYnRZrPrzYVa?=
 =?us-ascii?Q?qdVUQawxLihkRDTvZwIaa+ooxXAnlyQgTIs+XfmTnRwmqoX/t9dIoASZIarT?=
 =?us-ascii?Q?98hlrtbXiA4lUHzV+fJ8xN6injDpU4rKEoOOV7j7g2ua2qZW+pasAYsh0NLA?=
 =?us-ascii?Q?vMABkFQha9l7u6a+ZXxdOTkqqLM8YjWwXEZoxv5qvBLbPYrJgc5UpKGOLzvL?=
 =?us-ascii?Q?51HyhYuzx9lIlV678P3ZLKJ7riTq/1pBnnVLG7VtGDf3WFLtce4BGtQ/9Yer?=
 =?us-ascii?Q?an5ns635y82tjHxmVoJ5Q67rlDnb1rPiI6eDUPhG9T0z0MlGiMlLW7/j5zQg?=
 =?us-ascii?Q?HlddjxdAW366Z+AKohxv1RQnQF+FM1JoDHEiKY5B6+ga41btNa24hyzWrs1z?=
 =?us-ascii?Q?aPAtbt7I5Z1jfbJEk1/Xe+rusTOY9iXVQl7PRVEE?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70bedffe-825a-4bdf-a8ae-08dc9b818b8f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 16:59:47.7034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zhHLN89/q+wXZKlb8ozki9ez1apZSvdm3A+QdP21FxTbhh26n1DlgJEuj/GiP+KL++Ik8pCIpcJeCxtLrrMc3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9435

Add compatible string 'fsl,lx2160a-dspi' and allow fall back to
'fsl,ls2085a-dspi'.
Fix below CHECK_DTBS warning.

arch/arm64/boot/dts/freescale/fsl-lx2160a-bluebox3.dtb: spi@2100000: compatible: 'oneOf' conditional failed, one must be fixed:
        ['fsl,lx2160a-dspi', 'fsl,ls2085a-dspi'] is too long

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v1 to v2
- new patch
---
 Documentation/devicetree/bindings/spi/fsl,dspi.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/fsl,dspi.yaml b/Documentation/devicetree/bindings/spi/fsl,dspi.yaml
index f16ac22291456..7ca8fceda7179 100644
--- a/Documentation/devicetree/bindings/spi/fsl,dspi.yaml
+++ b/Documentation/devicetree/bindings/spi/fsl,dspi.yaml
@@ -34,6 +34,9 @@ properties:
       - items:
           - const: fsl,ls2080a-dspi
           - const: fsl,ls2085a-dspi
+      - items:
+          - const: fsl,lx2160a-dspi
+          - const: fsl,ls2085a-dspi
 
   reg:
     maxItems: 1
-- 
2.34.1


