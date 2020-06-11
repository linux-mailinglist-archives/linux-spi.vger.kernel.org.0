Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 665EB1F611C
	for <lists+linux-spi@lfdr.de>; Thu, 11 Jun 2020 06:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725782AbgFKE6h (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 11 Jun 2020 00:58:37 -0400
Received: from mail-vi1eur05on2056.outbound.protection.outlook.com ([40.107.21.56]:6054
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725300AbgFKE6h (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 11 Jun 2020 00:58:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UZzuYSgaqr0LnBdu6jjL5MBT1gWkXDTa1zVFl8VwuCExQenCTm6eJV3X/Ax5wpF8EUJUiehVBqmp1RPHgzirH6ipXiG9BLZPuZbktyu83YVT6eJZTOz76UEc8TpUk3i8prxIG/gQprT2p8j1nclKfKQsuWx3i9UJB64cB3U5fVbpL1hCf2Fc4WbrA5kKF0YMhsXRuFK5Z/LYQDwDYFxmVxMYKh2T0yYI3fu42OZQKHyjkh0zHoPLffi2dcKoy20XuXyymYieGkwFfTLyuLZ4W2SZnhgKtPfmXh7cWwZdDnkhOeF9YbKoLSkriel5a2qE+bMpPvF2vbndp0Nfais53g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XJ5XSrDA7EDJOTPFLRlRcPgnKnRbnyBpmcwzX43vYKA=;
 b=Y1O/Qq1MjiItIZfFqGGzSnH5gHecczDU8+jy7ypmW05qqIoM3FKOH8ZxChpkV1HcmcfalO8yVGQKcDOR6cSsI7ScfJVKCf7x76E40XrFRJbQKBtoMiF4jkXTy/hD5Bf9kYSPWGUph+MB2KxDtSLINne0i8e80ICLNcVjf6TXrf86o/zlXPRzcbnFeaSzDE/jFxb9h6mX6a5aCPBYdlqeTAB4oVnQHCGHQvEVhqbiaZnzpv+iVxPDWeool4oEpegNqWJ7TDmt5zHMXfI4ymrjOr6D1O0qGrSwggScD7FknsVWYwCWdGeAuj52NQIPRowdnfIvAHUKyQcQmfSpuKjScA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XJ5XSrDA7EDJOTPFLRlRcPgnKnRbnyBpmcwzX43vYKA=;
 b=oIhd0XAWCaZ651ckXsjvg0O7CIOcOAyoD110MZDomtOgDKooRByk2pw9Wh0YLECUSFPbIAs+R/ts6Z/gadEgIC+h/2z0tHE9M2fPf3ElG0r1LEKOlEyNPPw5IpBAGhdKq/eDfj1vqR8WFGNt+WmnVaH1+sEm3aE0m8SsCEk2JjM=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VE1PR04MB6750.eurprd04.prod.outlook.com (2603:10a6:803:123::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.22; Thu, 11 Jun
 2020 04:58:33 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d%6]) with mapi id 15.20.3066.023; Thu, 11 Jun 2020
 04:58:33 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     broonie@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, robin.murphy@arm.com,
        matthias.schiffer@ew.tq-group.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 RFC 0/2] introduce fallback to pio in spi core
Date:   Thu, 11 Jun 2020 20:58:28 +0800
Message-Id: <1591880310-1813-1-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0171.apcprd04.prod.outlook.com (2603:1096:4::33)
 To VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by SG2PR04CA0171.apcprd04.prod.outlook.com (2603:1096:4::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3066.23 via Frontend Transport; Thu, 11 Jun 2020 04:58:23 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4f454f80-730b-4ad4-ab7e-08d80dc41740
X-MS-TrafficTypeDiagnostic: VE1PR04MB6750:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1PR04MB67502780F4F1A5BB47F8727889800@VE1PR04MB6750.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0431F981D8
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uA37TwtMsqHvRKHoWskCDKXLBoOC5VEiFhd99CsEHs7eCUcOuFVkbKs2rOqS5rsgTtL4vpEDA5KNlffoARKgi4WBq3DUDSPon6hWd04+O3iMt+1MfJNm0xU1IINq7dRKfdQdwrbJ8d6si1JJ/o0AGj08lvAU4Afi1OxLLtYpUC4vCi5wYaNrBLz4wmq+MasBomi54VhqmWUEAgcXZCcZ20OL40MlHwnaemKsXtBHO9JnoguQFJuDJx7aBgsdPxzkonachDyIcYBQgQyJUCTBnUWOO09l2aNSjt49q6PltcaHdre6PGkOFuIxg8RCsJB3oY3DcI4dy+psir5UT+GpR4f2Uco2ogbZSVcNrg2unnyEt+M/OINUTiXEekV4e6H2+Q7Xjd46LB45PDAH/p/rgQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(376002)(346002)(39860400002)(366004)(396003)(478600001)(66476007)(8936002)(316002)(2616005)(7416002)(956004)(966005)(36756003)(86362001)(6486002)(66946007)(8676002)(2906002)(4326008)(6512007)(66556008)(6506007)(83380400001)(4744005)(16526019)(186003)(5660300002)(26005)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: iOxh2+46iPwQ/Sw/H27kE1v7LzxbRKON56sZpgSW/A7DutULwKMrYThGQVPLXIQ9XIISDhWicDGMYDT4GW6F8tUwN5SwRFPCkctIqHq0kxPzj+tcLi1vbuh0EwZrSjYdFu8lCLr4JnLTgrSCynz/9Na7u6GGndZEYYHh0YYXwVHAdYzKOrl0AWNuju6LD4MpaxX6DQKznqr5QezwJsP/SnkUK97NMO5d+gUncse7YqutXmQcDIoUcIwA0xkKBQMsCucEDZczdf/P4KAn/qGX481OpeAtMQ4IVRWpyMR5LXf0wODXyLpQZK971nx5o1XlR+YP3NvZy5stT9Rm1dgr6E53eU3bzwy+xIZX6r0064VbiASlpnbwLwFmZdAOqhGE0vUpx66uTDOl0xIxyGItgyFy3V7RAOl0ReUC7bOaQCtFGAO44wuX9MDYZ1M4y+igK1CmlWNnUm0ArxGFcHUghf9MFoazJt7ZWERJirPQIeA=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f454f80-730b-4ad4-ab7e-08d80dc41740
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2020 04:58:33.1928
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WkPtgyulCMB5iWMthKmeJ2axihU8FbESPHlbGmdSI2GXhlgwjG5aH///Me4+bkBIyHx/q0KJ7aCbdDqwxJkGXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6750
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Introudce fallback pio way at spi core level so that the tx/rx buffer
mapped by spi core for dma could be unmap and fallback pio again. Hence no
need the below patch where 'dma_sync_sg_for_devic' to sync fresh data back
into 'device' memory and sync to 'cpu' again in spi core.
https://www.spinics.net/lists/arm-kernel/msg812236.html

If you want to use this fallback feature, please set 'master->flags' with
SPI_MASTER_FALLBACK and add 'master->fallback' checking in your can_dma()
to ensure it can fallback to pio.

Robin Gong (2):
  spi: introduce fallback to pio
  spi: spi-imx: add fallback feature

 drivers/spi/spi-imx.c   | 23 +++++------------------
 drivers/spi/spi.c       | 11 +++++++++++
 include/linux/spi/spi.h |  4 ++++
 3 files changed, 20 insertions(+), 18 deletions(-)

-- 
2.7.4

