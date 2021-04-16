Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7AE3616E6
	for <lists+linux-spi@lfdr.de>; Fri, 16 Apr 2021 02:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237288AbhDPAtP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 15 Apr 2021 20:49:15 -0400
Received: from mail-co1nam11on2045.outbound.protection.outlook.com ([40.107.220.45]:62277
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237139AbhDPAtL (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 15 Apr 2021 20:49:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PEqWFRWvJdeC+pDoern1zEaERwMB6YRnh83o/JC3s8DZpmnTZbiuURjNegC7zN3GEqrkBOlzT7cyL+QykOvaNgN8PIlFs2AHKGonuLIfrKpfLZsn6dNJJz5gwxM1dQAn2MeM3DV0uk3bfxbxcVIbDOzH2xcsPpMhT8GvAi0D8D7PiFH+eM70yJ+Qb5lqmAlUm+IEwCtU7aalLegqJVqhM9lcn8Annrf6Ov0/sU7rfJEGKQ5IdO03kQ1D5weGV7NBjgseUfvasWvm4cxRWKPD72VvHP7aoqMqauPWU1FpdB9f1iRpCcS5rKQVn+/Qz8YXVXP9k8K1B0SWYn2ED+FR2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u/9gx7cYwefuIjIRlTeJLGSktrCfwnhSF9n8vX3HhBE=;
 b=XJd/lLTEIGgUx7+UrfKig3N0r83DUE1CR9YVxB/6JB4S5NpnrLjRC9amoe3Zn8CVs2iih/p7bgJmQ2M8nUhY/Fw7O1G+M3wmerV2SylJGnnjSo4K0pkbNFDK3R6wFrE4L8xW/EnXhbL2XQa2zkA4IA/LZVqlcstsdGFDM5H4AKwJKflGbejpZff6881KtPtf7SZoE9QVaqzvwNtnni2lkz4obIO8PJiAjbCw+FIrJv48bMOICJiyA2mxQok3IdS8ozQxJmRRhmiYcY/3OCuwroMFo+DV5pbIA++jEusA47oYX+5AUcRYT+kr4qFD1hnyyKHnRKDB5R/nC9ksa8KXQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u/9gx7cYwefuIjIRlTeJLGSktrCfwnhSF9n8vX3HhBE=;
 b=qTh+WBUgpE834lNsh0W8x0vwkx1fgYITrR6RZcATxbpAWss+Qu1ufd2c0Rc/hdqHFOn+0fMTdDxiLEdZgfR+jLaSMsHMt0syiPnnfninhuQ920NHCxiZUVYGVDTzpwgg89SH+JWpCFSZzNlirE9hVIeqX/H2Cvya9cn5B10fTOY=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=windriver.com;
Received: from CY4PR11MB0071.namprd11.prod.outlook.com (2603:10b6:910:7a::30)
 by CY4PR11MB1256.namprd11.prod.outlook.com (2603:10b6:903:25::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.21; Fri, 16 Apr
 2021 00:48:46 +0000
Received: from CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::f45f:e820:49f5:3725]) by CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::f45f:e820:49f5:3725%6]) with mapi id 15.20.3999.037; Fri, 16 Apr 2021
 00:48:46 +0000
From:   quanyang.wang@windriver.com
To:     Mark Brown <broonie@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
Cc:     linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Quanyang Wang <quanyang.wang@windriver.com>
Subject: [PATCH 0/5] spi: spi-zynqmp-gqspi: fix spi issues
Date:   Fri, 16 Apr 2021 08:46:47 +0800
Message-Id: <20210416004652.2975446-1-quanyang.wang@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: SJ0PR13CA0026.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::31) To CY4PR11MB0071.namprd11.prod.outlook.com
 (2603:10b6:910:7a::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-qwang2-d1.wrs.com (60.247.85.82) by SJ0PR13CA0026.namprd13.prod.outlook.com (2603:10b6:a03:2c0::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.8 via Frontend Transport; Fri, 16 Apr 2021 00:48:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1e8217bc-02cc-4c96-705c-08d9007163d9
X-MS-TrafficTypeDiagnostic: CY4PR11MB1256:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR11MB1256903B605BBC511199DCC0F04C9@CY4PR11MB1256.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oLAFLDfWmEKqBrxGvrnfEjxLC1Ca+3IVpSDwANsg8nLBjODRq5ozfv6eMVOvtTJGMvrwre5BnxEqEY/DGoCiZ9udR5eXHzTmWJqjrSxS60vXkA1LYmdjZ3ZtpADRb9t5jrpoT5yG+HDGvjYK21WdMDbHOxvHOY9eDSVZyl0i+KBRXg2NKVxoTEKKPc4iPijzygc+mEi32oJhZK5E6l9QVjk53dGzo8PPIYV76KQi4PuS/DNqTCL+/IScGsO7mwNYZx8OMEycivoVQij5uhMds+unVsxlTnpbVZ7LPW6ntkCb+X8aESc/Runq1QkdMgBo0RnJlZGVRhjNsHtPK/TRkLfIYDh1pSdSwSdrtNZIXy7P7Dz1f6bYNV9C8tEWlsv5rNaj7da1+OOyq+nt/e4gYwD0xLpY5BvhYlQrEq2SPuZpqNoZKtJ13CtQgQhtDKBsgi5xIXguY3O05kcDCy04B3CSFRjcpckJpn0qhShuSyRlLI7Kjv/LRtUhLf/FRxFNa2kgLwN6TLaNAiDFBtp3ykrXI9iNPyAZWbwG+ULkPlG2EGYuvfJNdPxhEz05vYoG3awIVFSNq5CPJqtaiXcm/xCJMPfulcosdtMqqUyQOSYmrzolqemL+UtEiJgD8N6fkmqYSD9m3OkZOwlEYqL76aSY/wFpjI9bUrgQ3T0yYTk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB0071.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39840400004)(376002)(366004)(346002)(396003)(136003)(956004)(66476007)(2616005)(66946007)(86362001)(83380400001)(4326008)(6506007)(66556008)(107886003)(5660300002)(52116002)(1076003)(6486002)(9686003)(4744005)(2906002)(316002)(26005)(36756003)(8676002)(6512007)(38100700002)(110136005)(38350700002)(16526019)(478600001)(186003)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?n223HQy6UMOG/+IgYKDpAXvLv34A5zdRu2fGpFn7X/PllCMoSydXHhkRc1rn?=
 =?us-ascii?Q?S33KhubyP3v+nO8C9AGU5Yixb223SZnO8zpn2QJiWeT+5EqHLDQOsq6hYgmL?=
 =?us-ascii?Q?l4F822vA16737WydLi5nKyGQBrsmvjC/Jkwbp4HohawyYOWSQvXdpq4xTru1?=
 =?us-ascii?Q?110IEsHEqgYFTg5L575cWoB3YHsjsEUwKzMMVzGBh+OXGsM0zzANDhnWJCko?=
 =?us-ascii?Q?iC+6N9Wg06tkAspLE4uQ28u8ao+R6x4vlIMPvqEfNcKYg+NHd8nxAWOXMDJj?=
 =?us-ascii?Q?haWjJ6ZptlRD4PL2ojzvEteULjv4x5GuPYI5G1GVoKXiqlUEI/fgifNPxwJe?=
 =?us-ascii?Q?mZRHauoULZoxOfK46zpzOcLF3pYgagMjFnG+kRONXSGH2LbvKHTEBiv9I9t3?=
 =?us-ascii?Q?vk+HwFkVaWwQDAIPkR4RxTD/ookWYSvAIbfjqRa+zUFPu/t3Sc/fn+VsJh0w?=
 =?us-ascii?Q?1FkjSo+dhLu6YurV/34NEjZe25K3wsjsq/ttFBHD1TTH3TLxCrSJJaQgEfyz?=
 =?us-ascii?Q?ZYlwS1YBntdG6T9V/8vj14g+LKZPvrb/6gaSXY24BgfokILPekj2hfIgWoSh?=
 =?us-ascii?Q?5/Mpon3TlL7YhrjDZ+yv/ahUnGFE1jvLUA4Vs9DU6ejysU2YsqzGCdl5V8PV?=
 =?us-ascii?Q?fUcwEQnWkzeTebEo3pkjchjk15gd5+PEmEP94tdpHrNV6/gqExDoZHyTQP7K?=
 =?us-ascii?Q?2YSKEse8NtEvMLed9itgyJeMb5Nix7Rxhs864dCwaMKM6626Ya5Syvp6uj4V?=
 =?us-ascii?Q?rI9eFcsx97MbxI4fRn2P6aW4ZhVJlq6MRuWsb2DDeRe+KU43VzYwkB2W2Mek?=
 =?us-ascii?Q?3gHYh5nH7nPVSXSvLfk6kYoxZfMPpnsEkuE9uAejWMA+AI+HIhNjRZhZnkPa?=
 =?us-ascii?Q?XPPpOioTQzW2gR1pldHbxvWtbjLXbhL7GF5oJkKOu61GvsDjRgH7F8rJbXSp?=
 =?us-ascii?Q?56AXGWAmhSbZ2fGIGexJ4KnFu+2IB9YfKKw8F/vKmqPQimXV1wdJRsQb2h9y?=
 =?us-ascii?Q?JbslGSiRdWGHc9GXUNviGZlc+E4ioGGBbhtrXITbEwk4UTcnnjR9lVxgLCY6?=
 =?us-ascii?Q?BmWkLjk9lnt3xVkTx34C3MS77M3pC7WH81IfCyvdld4xsUAOVy/JYRZmrFGM?=
 =?us-ascii?Q?YbWWC5XhYrwM51u4HXzorRkWVvkFB09JVbEr3KU1K/UYwX6Urac6GKi8LmZL?=
 =?us-ascii?Q?ML/8Bry/JhWeMIaBdQMvTzAucfc5tFwXEs5XiuVTlJEWOYtxZX7zKnxjkPk3?=
 =?us-ascii?Q?np4Z7ZF7rln6heqYVyQi2Ad/RLCWx62a3u423cAOo2utOT+cZf5Z+PPb/iv2?=
 =?us-ascii?Q?9MC2LQUT8ll8crPqKyjlroYq?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e8217bc-02cc-4c96-705c-08d9007163d9
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB0071.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2021 00:48:45.9252
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A1vY+ocx7tq6uNF7+UTvUjJpJWT49+oRR2nOtlhSW3r79J1gAFX0J35nNZBxZXwB2KszFhfvxU2zkynYGhO+TvwUVZzxkweVM0gABEDb5sM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1256
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Quanyang Wang <quanyang.wang@windriver.com>

Hi all,

This series fix some issues that occurs in spi-zynqmp-gqspi.c.

Thanks,
Quanyang

Amit Kumar Mahapatra (1):
  spi: spi-zynqmp-gqspi: Resolved slab-out-of-bounds bug

Quanyang Wang (4):
  spi: spi-zynqmp-gqspi: fix clk_enable/disable imbalance issue
  spi: spi-zynqmp-gqspi: fix hang issue when suspend/resume
  spi: spi-zynqmp-gqspi: fix use-after-free in zynqmp_qspi_exec_op
  spi: spi-zynqmp-gqspi: return -ENOMEM if dma_map_single fails

 drivers/spi/spi-zynqmp-gqspi.c | 115 +++++++++++++++------------------
 1 file changed, 51 insertions(+), 64 deletions(-)

-- 
2.25.1

