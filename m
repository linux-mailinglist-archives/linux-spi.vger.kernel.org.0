Return-Path: <linux-spi+bounces-8886-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03842AED84D
	for <lists+linux-spi@lfdr.de>; Mon, 30 Jun 2025 11:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA2633B57DD
	for <lists+linux-spi@lfdr.de>; Mon, 30 Jun 2025 09:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51BAF23B60B;
	Mon, 30 Jun 2025 09:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="f3gvANkX"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DA223FC5F;
	Mon, 30 Jun 2025 09:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751274724; cv=fail; b=qYHHJgTwhQxtlLuZX5kczySXxKAvQBTrHD1VxBsfsrG4ceBybhudoBqnviEBVqqELwmjAZKIf7x1jSnuY/tXnVyRMcmfbQ3agx1ZjEyFFWE6wqe05JnpJA3rRhiOJRS5NbSUvDAlCeQ89+O1god8l4kWDSFt4AQsRH7vokfVt3Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751274724; c=relaxed/simple;
	bh=yTyNWvaCsfhD1yMEfDDXsJVhx5qzhDOsgBAV3J87Hoo=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WkpPkZBtp2FJhOBFkFBneHjcEUzBahcS8tzX5CN8S8znwpSPnXS2uZLk1Uw2TDXq48WrfYE95Gr+yoHPmkF4lhKDiyRudozyJHCrYz8Li7B2rsEgLULJYcJYldUYPfKoV8tDlMr62uPoGgCMgRbzm0zMtFY+OcrNt6T3RW9/Tz4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=f3gvANkX; arc=fail smtp.client-ip=40.107.94.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q2HC+JI5GgAfqaKS7/YJyZX34R1QqidacN1P19G1H/8GVvae7+e9d6c4/DT68h49cwTaLAVUO7YI5YpHjg46dM7WMft5/hZw4ed/qCjbbjKX635kCUn7YacLdvzrXDD/9DDDUSxRqRQBWb6ZO/cx8RnIGvoOHYIGKO3pGtHZiCn+IvypyybbZMxWW0G7HRDmfhpMYwh2453MbPaocWqqH+gjGzLwXpvOozZ1IiY/eIQLvvxr5wCwpGoPfZX8yhALW2iUm9UhdH1RN9/WCJDFqg3oaWugNjj8InZjUAkt7RcWw0lqSdhmUpx83cAQonk6b6SR+qKycq0uxNQAd2eY3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yfbjyhnj4FKAwjaoYWHesop3cBRza5fPG517s5TvOVM=;
 b=qIUOcRSOjrPu5toojsIyEV48jNImzTqCHBxt9+KEEPbG3Qszguy5BdTwsJKDVrt8fbDGDTGHVwgXI776GhZNCE/vf0oi66q0cl03Srjlb6LCTk+VZ3/jZhzzE9+61LI9v89X4m53+VJV52jJb00ziOC/LaiBosyY98+9c4Ngeeuz7jSZOuxJTorVllE4XmWJfALCQkjFTLoLSObW4PkXU/7x7CjHjBkD2O78UX48OmFegmgTfjhn6bTZkC2ZHrNEabrMngKunyeCzBKFho8T9Txqekqlzqleywqe37Fx1ujRXRl9VFIV1RU6Ozj48+DPeyNVwqSHkA2gAZ+ax5pR6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yfbjyhnj4FKAwjaoYWHesop3cBRza5fPG517s5TvOVM=;
 b=f3gvANkXDtb8BSOX9usyWTU/ucAb8bavFF1mgTgx5s+s1ankZPqtZc3Keq3gc9xCcv6ifT7ad62P676smlzhIorgmxaQhSb52cqKwWInYrTAHM2LbQ3EwmLXLbLYKXd1+YysMBxQiVdlh/oVe1lANWkbBMSu3MHHvvnQhifKe03k6I5d5QNLa6mddCLr0Dc3iRwI9Jm6U95AXKQlDCEXoJgPo51WKFwkRubAB73KjWhHbktqlEhQ9I8cW/RIa6eH1YnvCdF8PFEdO1gRMLuMa201uUoVIKrDsPELxq2F9VsnbvhoTV//OX6Qg1uIFpm+5W6WmPI0x8u1WPwTPs02MA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM6PR03MB5017.namprd03.prod.outlook.com (2603:10b6:5:1ee::21)
 by SJ0PR03MB5391.namprd03.prod.outlook.com (2603:10b6:a03:287::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.29; Mon, 30 Jun
 2025 09:12:01 +0000
Received: from DM6PR03MB5017.namprd03.prod.outlook.com
 ([fe80::2898:accd:c6dc:2168]) by DM6PR03MB5017.namprd03.prod.outlook.com
 ([fe80::2898:accd:c6dc:2168%6]) with mapi id 15.20.8880.027; Mon, 30 Jun 2025
 09:12:01 +0000
From: khairul.anuar.romli@altera.com
To: Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org (open list:SPI SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list),
	Matthew Gerlach <matthew.gerlach@altera.com>,
	Khairul Anuar Romli <khairul.anuar.romli@altera.com>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH 1/1] spi: cadence-quadspi: fix cleanup of rx_chan on failure paths
Date: Mon, 30 Jun 2025 17:11:56 +0800
Message-Id: <89765a2b94f047ded4f14babaefb7ef92ba07cb2.1751274389.git.khairul.anuar.romli@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1751274389.git.khairul.anuar.romli@altera.com>
References: <cover.1751274389.git.khairul.anuar.romli@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR01CA0042.prod.exchangelabs.com (2603:10b6:a03:94::19)
 To DM6PR03MB5017.namprd03.prod.outlook.com (2603:10b6:5:1ee::21)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR03MB5017:EE_|SJ0PR03MB5391:EE_
X-MS-Office365-Filtering-Correlation-Id: c33c9ad8-27e2-48da-78cb-08ddb7b62c2b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LQtmhNSmZodLCnKk7kGDQm6q5DoeVHjwTk84+YlPd863WEaCbtENsaRxXCxY?=
 =?us-ascii?Q?3Tull5Q5HkMAgMkQRztzE9D5f8FqGF1YC8XNnuR3+5GYF/GP1yqR5Lhx4UJF?=
 =?us-ascii?Q?zTfW3Qnkr0FJQAQbiLpdgsxBvFv26yZuzNZqIGFi/GKfVzUyw+bDy+RnWAwR?=
 =?us-ascii?Q?jWJsU5viBbjadqIwDqlEhOrJB5avklJBrdW6xLm+tz1pzMaAkVHky5mo029r?=
 =?us-ascii?Q?bZ8JVhBsjBiUHlrh3EhmVtCZNPSSTCaRDO6sLfpehvGQLpI48FoKNaSZQQK5?=
 =?us-ascii?Q?0zW3+xOuYLJpIgCSofJ4/M17fYh+S1oHT0BYT2rPDXVxL7DtyNMxKmgpamux?=
 =?us-ascii?Q?+YKaNe/WedzuzF6OmuFazxRQF3/pSc446HTq6cbBVXkbtG0wqMqb+RE8RW0s?=
 =?us-ascii?Q?FdU5XuqnQka7tZoWsKUBA20PP6qS0CM7JDyikhPpE6SdgHQttrt+SCQ8vhv9?=
 =?us-ascii?Q?DCP9BqiZ3dPIvY8G3kt7P/24qoZz5CVVSvI7/u/DLCQGi17xztqkpC1z7q7T?=
 =?us-ascii?Q?4FyQKwaQQN2OT9o1IdfXPjlBy7Fm+pi2Yf3JJ9D9FkXlt59MZyIM8KZFUfHK?=
 =?us-ascii?Q?jPbtxCDjUATK6iO10PvEDX301AOFYisHNlE1uHgwmpc+FQxJJXP2jYn5WSOx?=
 =?us-ascii?Q?cWASCFbQPBB1lQRrqw9CF9Iy8OObFulnuUY1LtxYQnr5ZYPw3EYnrEOiY4co?=
 =?us-ascii?Q?BcBJUAEbNdHVa0nVuJ/mFnSpFkLsBd0GfbAKI8kpBwd31n9jSuv+VjApTE6q?=
 =?us-ascii?Q?zkMARkmPjre4AHHsIgYVFgrUuIb2+KodXPpLY35S950ed+dvQ+Idh4LGgLwh?=
 =?us-ascii?Q?zIgF6Rgf1jexBsrCDpWupeTzpRkMUgxjsqC6GcNZlzM/2lIzzYz+KAOVNx5N?=
 =?us-ascii?Q?I/keUvPoUjGXfFkvWkpUSu4MIoBPAXcVhQNFlLPUudUIP6jl6yevUfyTis/m?=
 =?us-ascii?Q?ZggApOziFTt8npN6znPzC4hGtixMsU+IK/RTceNeVtrsjmV9THcPUWjbDEdE?=
 =?us-ascii?Q?TSOzb8JIUUuYmk8M97r7lza6qDsvJGxafieW+cuShuSMJrZ6IF4YBbjseITY?=
 =?us-ascii?Q?tc43kyB2kTaqx68WTTnLIe/SGmUFXi2ujSaxwVCx/b6sg3nQS7SxHjpZfnnc?=
 =?us-ascii?Q?Nolgo42Dedw4AXOKtHD4+y9JhtkYbbtZIbPWJ003wgvkjU1ipnbBzyuEU0Wf?=
 =?us-ascii?Q?yy+3nj4JaWZMd6eS/lROx8pwp6tCTlMoOC9szL0SL02QRZX5krLTTO1KkoWF?=
 =?us-ascii?Q?oRvZ1597qfwaD5AY72HzRLS6y4/5lq990hN4Bgl4rOYFjjb4JrbInZsJhTjk?=
 =?us-ascii?Q?I8ott9GaOOrXQ2mcIVleNXHOfKJ2lnxABuv/wwNUbiJ+xZsf5GCmhylROwFZ?=
 =?us-ascii?Q?YSXQqEV8spEJDDhhBNsLlmd29LVeC16q9XD2wYwvm6lAukiGRasE5IV6nnrd?=
 =?us-ascii?Q?cCbrX8nomOc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB5017.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NNV13Ar2jPPLcM+CFSqYQLVJBKxCSypQQhQqhD92DC1O+QRVl1kacKYyl1sn?=
 =?us-ascii?Q?F1gSJ+thVrl3mNYr1lmxc3tJRo9GhBrE8EoZY+3XSZrAKQzm38Kt0X1ut+XJ?=
 =?us-ascii?Q?lQRsmaY+F9bDL+NnzrgmZwIw7+VOCaov2yhLMa/+gWgmJVEZNpSBtKSPLz2f?=
 =?us-ascii?Q?qGMNek8kSQ4JyMNiIRJdtnAVz/2svMUIyphk4va8mtExeZ55tfMS8f98mLSN?=
 =?us-ascii?Q?mnubdVkeYYSNkKngaLMT9Pa47oLV9voC1nKISOnQFwwxuwOnVYsH23gHlL6B?=
 =?us-ascii?Q?Y4nfgw/70Io/Te01Ryl5X+j11ShVsLyeSpoxgFp9CjDHUEh6rf7D8HJ/36xU?=
 =?us-ascii?Q?HbT/XDD7puE0ukw7hiREd5VQ9BZ3+QlbWVKXRVUNg7GRsFu/CbkC383PsUDL?=
 =?us-ascii?Q?Nk3sWKlRyOjgQWzotiCnEHUWu6AMlAalZVvGryDHlEwIXEa32KCD4/gRl2sW?=
 =?us-ascii?Q?UIHYSZOBpJteXOkxFW+Hxmkp1o7DzCDXspr0Fr5uQCRz3IzTq9WHdmIP8Rrk?=
 =?us-ascii?Q?cb3KQ26lC+6o/lkNNU9XEBuVS4rCm+3DYh71ymFkb9nI0nIt3DdCPGYVU7GB?=
 =?us-ascii?Q?coii8G/BcN6RrrB1MnfJ9csQXXHmxN+qCOtLpy8sP75rBoLl0F9DIBQKYrvJ?=
 =?us-ascii?Q?1iWTR0rQfEWHGO+06YDljPEZIhJx+i2JKW6z1WNzygGU/9bRjyJTk75bHn0h?=
 =?us-ascii?Q?3z7KuoAL8iZ6HU8cTe23Y95tbn4kUBdggRZhAuoRiik9hC+uGxnEnW0epD2q?=
 =?us-ascii?Q?I3WqGThrxa7BY6yVrm+eSf4UxG2rxUlqDWoT6oUjvbpA5/TKQ1AYlPZLVAo3?=
 =?us-ascii?Q?WSEOWpQD8RUBHRIz/734u7bN8CgX5duTDG/9unCPWzaudvuF8isJbDP1UDyc?=
 =?us-ascii?Q?D1vkOsrZVrzLtdqrF1d2X+1PH/5joRLVlLps7uC2lDAQytSHSlmJVyJXDYu7?=
 =?us-ascii?Q?xzNlrlisUv9ojbFmbRoAQZZZY+6uM0M2hebA7NQcHYf3hPbz9xpwGNDFpiId?=
 =?us-ascii?Q?8MNlehMgUPYQruuOQ67CPcEByNIi6aJBL7E2WyGVcodQ1hnDJeN7DfqP2fMj?=
 =?us-ascii?Q?PnJf1pj/aSNVsq71n1YzWZHqpkf1+CRblT+pUVz6lC0qd8oSpWggZ1mXZ3NL?=
 =?us-ascii?Q?PVbqM6r2g5EWNTVm3Eyyg48NzNTAqe5xTEt05LtXaBupjENCKOSX4NCap3cZ?=
 =?us-ascii?Q?g3Jj+1FH5I81KPKrxpusoFe3MW/8dSfcKyFatsj5TEVpg4giwsa0/2/QSS44?=
 =?us-ascii?Q?te9xZK7pNFse4VL/WDcdijXPqxD2X4TtQjLczVAPbLyarUhvL8S4OJlEscie?=
 =?us-ascii?Q?aWU/2GFbvDC64b+78N565y7utGOlPHBexWLh1/eY5aqpKGgxzJWjHkMNC5fe?=
 =?us-ascii?Q?38VWbFbFi/gsmxvGrdUQ4rFauIptmnq+nU3agLrFgH/UUOdmK7uH273ONEfA?=
 =?us-ascii?Q?GpnAV5Z9OBm4vqDPgMfXmhod4ecPyXkZ0i6CSBLB9m7pZdIojJvk7MpQl7Nk?=
 =?us-ascii?Q?cBzVtGA7muWH50fqhRSnz7PDr28iFwxdLaphLjpbvqncn2hmp7g4bzvtfJOO?=
 =?us-ascii?Q?Qsr0AEO8zzI4niINOx+fNm6w5QEFv/M5TJQYl7dMaHXS9eaNDEaOy9JiLrlL?=
 =?us-ascii?Q?AQ=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c33c9ad8-27e2-48da-78cb-08ddb7b62c2b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB5017.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 09:12:01.2442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vs3RQ600KZd1ncZLsW7b+quufxIMZlauSn7jvGEUIjegqSclVXCO/t+xWzr5+wWa41rYnn2F0MFa3cTj4iOJ2Cnl2ubq9w7eAVMAQiD92vc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5391

From: Khairul Anuar Romli <khairul.anuar.romli@altera.com>

Remove incorrect checks on cqspi->rx_chan that cause driver breakage
during failure cleanup. Ensure proper resource freeing on the success
path when operating in cqspi->use_direct_mode, preventing leaks and
improving stability.

Signed-off-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
---
 drivers/spi/spi-cadence-quadspi.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index aa1932ba17cb..d3c78f59b22c 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1960,11 +1960,6 @@ static int cqspi_probe(struct platform_device *pdev)
 
 	pm_runtime_enable(dev);
 
-	if (cqspi->rx_chan) {
-		dma_release_channel(cqspi->rx_chan);
-		goto probe_setup_failed;
-	}
-
 	pm_runtime_set_autosuspend_delay(dev, CQSPI_AUTOSUSPEND_TIMEOUT);
 	pm_runtime_use_autosuspend(dev);
 	pm_runtime_get_noresume(dev);
-- 
2.35.3


