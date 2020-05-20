Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5871DB366
	for <lists+linux-spi@lfdr.de>; Wed, 20 May 2020 14:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726940AbgETMeC (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 20 May 2020 08:34:02 -0400
Received: from mail-eopbgr00050.outbound.protection.outlook.com ([40.107.0.50]:58434
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726452AbgETMeB (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 20 May 2020 08:34:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NdGJLy3Ag6b/YldzD93N0eAhYtvDaVgT0gEyEQdYimOhQExYrlIk0Lu6Degmeg1cA29TSbs7FtTSapmcZJEfHrdu1d+mvpZKayageGPj8YAYy6QVpzOk/WfUv3DUIubccgNJI1vayGEBPssBUcpxOLu4mkQMNedkcA3RJtQG+yg29g8AJTHzhlQAedlVgOaE2i4RtSczQoSRsXfc8ECodW+N9m8Su+UWy4pSDAL7gaNSmYJbH3K+yw79EqPo9Msux9WhdJLPqF8dv2zHN0xEGRGxeQC0+ZXp+Gp1LEOR8bYWgDNAv5sy4dmK1Z6+pABr10+wdFLWmPIK2edmaIg5rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=65CWtx/DkzTR/Im+FbLuRd5whJwyj5pCJ2s/b0WeL2A=;
 b=P78zJmRF/+HgvZHEcaENpJ88v8f5ZP3GhnW6WusjUXAUbhZzC9YN6OnI/tBI1UipcDTMd2P688LwpK5QhaQBGKXLwOj/h1nP68S4rG4UECLNeMomhsd3CwkRH1VUwNZNrw0wUwZgsnaao1OUOEmirA9lmwX36khXbxn2otRvbyuSi9lmbD8uM4f/6zHeRalqGnbb0rPh+u5iA1kjrx9fEI7+YKDuJ+7thzPL8JCGQgblXAAzQp0C/I7mZBSvwSNmTP9n6isTHMsGqa7Q1e5oZk4AE1WqxK8WkAKzaTNZtnnKd9CGDn9pnHmy+M+nOC1tGJFCf4+4ydccgICVNW1Aog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=65CWtx/DkzTR/Im+FbLuRd5whJwyj5pCJ2s/b0WeL2A=;
 b=PiZ+4CdqcVdBauityJJexdQArk7VVtziUEkvSX3AJ7DztJM2R3fjSr72zw7yL9A2sBtBNy5z299OyGtyfOUW48kupD0YlJwFGar/O3daEEiaN59NvhLH3wi+ap8sxuI9CNRo/XUBEXYrU+AZbn6wszTj+BFZCWuBMj8W3Qvx/1U=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6630.eurprd04.prod.outlook.com (2603:10a6:20b:f4::33)
 by AM6PR04MB4279.eurprd04.prod.outlook.com (2603:10a6:209:4a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26; Wed, 20 May
 2020 12:33:56 +0000
Received: from AM6PR04MB6630.eurprd04.prod.outlook.com
 ([fe80::bdbc:dab3:70f7:d5fa]) by AM6PR04MB6630.eurprd04.prod.outlook.com
 ([fe80::bdbc:dab3:70f7:d5fa%6]) with mapi id 15.20.3000.034; Wed, 20 May 2020
 12:33:56 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     mark.rutland@arm.com, broonie@kernel.org, robh+dt@kernel.org,
        catalin.marinas@arm.com, vkoul@kernel.org, will.deacon@arm.com,
        shawnguo@kernel.org, festevam@gmail.com, s.hauer@pengutronix.de,
        martin.fuzzey@flowbird.group, u.kleine-koenig@pengutronix.de,
        dan.j.williams@intel.com
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, linux-imx@nxp.com
Subject: [PATCH v8 00/13] add ecspi ERR009165 for i.mx6/7 soc family
Date:   Thu, 21 May 2020 04:34:12 +0800
Message-Id: <1590006865-20900-1-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0103.apcprd03.prod.outlook.com
 (2603:1096:4:7c::31) To AM6PR04MB6630.eurprd04.prod.outlook.com
 (2603:10a6:20b:f4::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by SG2PR03CA0103.apcprd03.prod.outlook.com (2603:1096:4:7c::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3021.12 via Frontend Transport; Wed, 20 May 2020 12:33:50 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2eadbb9b-7dd7-4d4d-7748-08d7fcba0fd7
X-MS-TrafficTypeDiagnostic: AM6PR04MB4279:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB427935E52F7F093E21361D3189B60@AM6PR04MB4279.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-Forefront-PRVS: 04097B7F7F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QCnPku+fRW63QapdWXe66F1JXOcP8V/Aj4gUGPJkxUTotUa8FQS3v8/HzX2/SZ7aGA7DROoHYVHgTH84mf0mp1n85lispXxOzSr7fhmpG4g/6yX5PeEXXLvAY0GAv4DmeDmYGkEF8plwO7iBRGD6M77C4N+SeMvh/FsPo49ktJhFmha7yPvRlmvkDyU1BwR+FXpR/RFaU8VveFny9/q0ucGZl1BEyRuuqFbhER3yL1kAuYqCQZ4n8AGd0uWf9Afx9m/r+ZtfjhF38e0EvUdaHoXR/d+1ziw1oer3lzhsEBsXJiUjxq84IniBPaVGJ4y3LzC0ElBuCALiuLhFlPTGyGweKKRs/t3s+eJnNNV2mfikXEAlMDl7Mo/JrZ4Z5ilrvTjrUNSDQUUInubUFrNrYcdoUiAtMadVIFwb4BmiWaIbwaRcgFrYml9s1xldXJS5pwExNzjLxwyQOJlm9ndADayq2whF1AEWU7xU45trKkMqt0wVhdyrkzFznidQnIVBC3z5R3puDquSG0hrTirwjL+k1XdvJbDMELQKUOLJnNb/lUfJRu6yssDK6pJ2cFBv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(366004)(376002)(136003)(396003)(39860400002)(6512007)(36756003)(8676002)(6666004)(52116002)(66946007)(66556008)(7416002)(8936002)(66476007)(86362001)(5660300002)(186003)(966005)(478600001)(316002)(26005)(6506007)(6486002)(956004)(2616005)(4326008)(2906002)(16526019)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: KNGYC87zFD7yBqZWrqu0evE0Rt3BxshuSsy8aMphpgtUYWhG22qOHx9CHzyImEKo/Go+hSO7LLnRpB4+f0+Ns4mE1SJVyZxXCwUR9l4aDO72FxZ3s5lu+0J8f7oWVlr1i+s8TW8k5iyeklJuidvXehzt9L9oEsTCC/cX5t7IjpoCZ6+BxITehRc+ORiv1/DGSxMfVBTnCHF5Tzh4Wy6pHy0CJ6oHSJvhKRmvYb1nE7f8BvH07NiipzD/QVmG0RRt/kKeVI5hfQcENihgp5OMfyLZwN2ATWLw5l3C/r7xyCcKlicDu253hXbePtuS+YAseIrOXmIZfnJxKozlGeHub2Z+ThLz2VXGlHCDqrWD2vgNNnsYvjlxKAK1x4UWcsYdSZV7ZCh0ZAhXfk11W5QM/golXaxiiSj/wo6E0KNjVSJ97JhhJ2BhnTOY90btK5sFa20R+Ua7sSN/w+58JaTWBMfSrK35DE7o8EUN/ikejgA=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eadbb9b-7dd7-4d4d-7748-08d7fcba0fd7
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2020 12:33:55.9618
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x0+K1xSgL1QNff+ScmzWkPzjE00+vEKmbGvGKD/NR0qLLU87JsxkAh5aSQe346A6zSF7ffqaYJxvvOocQDzpag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4279
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

There is ecspi ERR009165 on i.mx6/7 soc family, which cause FIFO
transfer to be send twice in DMA mode. Please get more information from:
https://www.nxp.com/docs/en/errata/IMX6DQCE.pdf. The workaround is adding
new sdma ram script which works in XCH  mode as PIO inside sdma instead
of SMC mode, meanwhile, 'TX_THRESHOLD' should be 0. The issue should be
exist on all legacy i.mx6/7 soc family before i.mx6ul.
NXP fix this design issue from i.mx6ul, so newer chips including i.mx6ul/
6ull/6sll do not need this workaroud anymore. All other i.mx6/7/8 chips
still need this workaroud. This patch set add new 'fsl,imx6ul-ecspi'
for ecspi driver and 'ecspi_fixed' in sdma driver to choose if need errata
or not.
The first two reverted patches should be the same issue, though, it
seems 'fixed' by changing to other shp script. Hope Sean or Sascha could
have the chance to test this patch set if could fix their issues.
Besides, enable sdma support for i.mx8mm/8mq and fix ecspi1 not work
on i.mx8mm because the event id is zero.

PS:
   Please get sdma firmware from below linux-firmware and copy it to your
local rootfs /lib/firmware/imx/sdma.
https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/tree/imx/sdma

v2:
  1.Add commit log for reverted patches.
  2.Add comment for 'ecspi_fixed' in sdma driver.
  3.Add 'fsl,imx6sll-ecspi' compatible instead of 'fsl,imx6ul-ecspi'
    rather than remove.
v3:
  1.Confirm with design team make sure ERR009165 fixed on i.mx6ul/i.mx6ull
    /i.mx6sll, not fixed on i.mx8m/8mm and other i.mx6/7 legacy chips.
    Correct dts related dts patch in v2.
  2.Clean eratta information in binding doc and new 'tx_glitch_fixed' flag
    in spi-imx driver to state ERR009165 fixed or not.
  3.Enlarge burst size to fifo size for tx since tx_wml set to 0 in the
    errata workaroud, thus improve performance as possible.
v4:
  1.Add Ack tag from Mark and Vinod
  2.Remove checking 'event_id1' zero as 'event_id0'.
v5:
  1.Add the last patch for compatible with the current uart driver which
    using rom script, so both uart ram script and rom script supported
    in latest firmware, by default uart rom script used. UART driver
    will be broken without this patch.
v6:
  1.Resend after rebase the latest next branch.
  2.Remove below No.13~No.15 patches of v5 because they were mergered.
  	ARM: dts: imx6ul: add dma support on ecspi
  	ARM: dts: imx6sll: correct sdma compatible
  	arm64: defconfig: Enable SDMA on i.mx8mq/8mm
  3.Revert "dmaengine: imx-sdma: fix context cache" since
    'context_loaded' removed.
v7:
  1.Put the last patch 13/13 'Revert "dmaengine: imx-sdma: fix context
    cache"' to the ahead of 03/13 'Revert "dmaengine: imx-sdma: refine
    to load context only once" so that no building waring during comes out
    during bisect.
  2.Address Sascha's comments, including eliminating any i.mx6sx in this
    series, adding new 'is_imx6ul_ecspi()' instead imx in imx51 and taking
    care SMC bit for PIO.
  3.Add back missing 'Reviewed-by' tag on 08/15(v5):09/13(v7)
   'spi: imx: add new i.mx6ul compatible name in binding doc'
v8:
  1.remove 0003-Revert-dmaengine-imx-sdma-fix-context-cache.patch and merge
    it into 04/13 of v7
  2.add 0005-spi-imx-fallback-to-PIO-if-dma-setup-failure.patch for no any
    ecspi function broken even if sdma firmware not updated.
  3.merge 'tx.dst_maxburst' changes in the two continous patches into one
    patch to avoid confusion.
  4.fix typo 'duplicated'.

Robin Gong (13):
  Revert "ARM: dts: imx6q: Use correct SDMA script for SPI5 core"
  Revert "ARM: dts: imx6: Use correct SDMA script for SPI cores"
  Revert "dmaengine: imx-sdma: refine to load context only once"
  dmaengine: imx-sdma: remove duplicated sdma_load_context
  spi: imx: fallback to PIO if dma setup failure
  dmaengine: imx-sdma: add mcu_2_ecspi script
  spi: imx: fix ERR009165
  spi: imx: remove ERR009165 workaround on i.mx6ul
  spi: imx: add new i.mx6ul compatible name in binding doc
  dmaengine: imx-sdma: remove ERR009165 on i.mx6ul
  dma: imx-sdma: add i.mx6ul compatible name
  dmaengine: imx-sdma: fix ecspi1 rx dma not work on i.mx8mm
  dmaengine: imx-sdma: add uart rom script

 .../devicetree/bindings/dma/fsl-imx-sdma.txt       |  1 +
 .../devicetree/bindings/spi/fsl-imx-cspi.txt       |  1 +
 arch/arm/boot/dts/imx6q.dtsi                       |  2 +-
 arch/arm/boot/dts/imx6qdl.dtsi                     |  8 +-
 drivers/dma/imx-sdma.c                             | 67 ++++++++++------
 drivers/spi/spi-imx.c                              | 92 +++++++++++++++++++---
 include/linux/platform_data/dma-imx-sdma.h         |  8 +-
 7 files changed, 135 insertions(+), 44 deletions(-)

-- 
2.7.4

