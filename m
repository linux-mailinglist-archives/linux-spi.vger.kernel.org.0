Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1260C327C43
	for <lists+linux-spi@lfdr.de>; Mon,  1 Mar 2021 11:36:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234536AbhCAKfG (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 1 Mar 2021 05:35:06 -0500
Received: from mail-am6eur05on2060.outbound.protection.outlook.com ([40.107.22.60]:11105
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234577AbhCAKdl (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 1 Mar 2021 05:33:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PMxt6suWljXuhfj1OGV97sysJmvRW6CsNeinmKhd6C9trP2ONn+UaRtVAlJiCEOtDLE7ahFFJM5aGAKXXwbyEo8Mzq9x22YA0Apd9MvRQtfWPxHAS8W+D61bofqqcMl3bDKo0/ovmq0m5++yV4dgnLzvRtKXh+W5EdxQ5JsvMyhzHOGA0rmR/Xeyd4UjCmF3rIkWBTU41A8HootGhMO5VIFJ39Xtskdt54CgFrpbBCqENp7rU1Agy1Xy30GJqok4Gcsh1V7Xy9LxuRzmLDPUpyjFQaXcUI9cgjvQsRA1aJ0n+1DeZ766iD90vGVrM3/2vQtG6LWrNiO5dhxuVKFpVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uTFMXDWjybHc4iaRx1utV9PfV+PFfb1l4kwUwoIihF4=;
 b=QSSOdvtuenleY7/QwpY2/aqgkyYHlurMU621ugZ4VYTvkTW/molBXdjswPxzluMB2Gi7P+i9JMDJkrF2war3o5j61tEdgnvd5Pg4XdT/p0jBmrV7P3HzSbzLUkPgpq+SupU9qPkkabWMkQdhC70p/IBBgkLO/kwCMJSR/7VTxInbPQZg41CfyuyrUJj28t2CWZa/cW5l5/1sN2oVbgPOI+5nc+AfwZaGXaXp4pKH7awC6oycrj8fOUcQVJtbkY7vfusaIK5zh6Ddof0rsHUBD9JoUdN9smeCELBpduAmRvmS8cpRIZHKKhkyBKxNv10Q+FOELhSNCFixA6GgnSgjwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uTFMXDWjybHc4iaRx1utV9PfV+PFfb1l4kwUwoIihF4=;
 b=O+vNfaWXeEL74NU1Rl8zPPe7tdGD8XzHRIdyOj11zcb2oFZfO3wHUysWrGPie0g5s4y1Tt7B1uB+pgEz88sB95YARA1XWWV3KHDfUbpdtl/P0e3w56cfJ24GlJgD0HJmcZ58GnPtGDdnKxaJ7luUTj7TMLkWJufT4Sfw2bS4DGg=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from DB6PR0402MB2758.eurprd04.prod.outlook.com (2603:10a6:4:96::7)
 by DB7PR04MB4236.eurprd04.prod.outlook.com (2603:10a6:5:27::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Mon, 1 Mar
 2021 10:32:51 +0000
Received: from DB6PR0402MB2758.eurprd04.prod.outlook.com
 ([fe80::c99c:dbc3:ed75:e6e8]) by DB6PR0402MB2758.eurprd04.prod.outlook.com
 ([fe80::c99c:dbc3:ed75:e6e8%5]) with mapi id 15.20.3890.028; Mon, 1 Mar 2021
 10:32:51 +0000
From:   Kuldeep Singh <kuldeep.singh@nxp.com>
To:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ashish Kumar <ashish.kumar@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Kuldeep Singh <kuldeep.singh@nxp.com>
Subject: [PATCH 0/3] NXP Flexspi driver patches
Date:   Mon,  1 Mar 2021 16:02:27 +0530
Message-Id: <20210301103230.1816168-1-kuldeep.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [14.142.151.118]
X-ClientProxiedBy: HK2PR02CA0142.apcprd02.prod.outlook.com
 (2603:1096:202:16::26) To DB6PR0402MB2758.eurprd04.prod.outlook.com
 (2603:10a6:4:96::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lsv03378.swis.in-blr01.nxp.com (14.142.151.118) by HK2PR02CA0142.apcprd02.prod.outlook.com (2603:1096:202:16::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20 via Frontend Transport; Mon, 1 Mar 2021 10:32:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9c963864-4ac5-4e31-bb46-08d8dc9d5da4
X-MS-TrafficTypeDiagnostic: DB7PR04MB4236:
X-MS-Exchange-MinimumUrlDomainAge: kernel.org#8760
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB4236FA4DE7D1C6A4C07B24A4E09A9@DB7PR04MB4236.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZDmyjq6Q7l9w7rYy72YBWObcf6zNPwaQ4ft3nCgNR3j1fXFShbUZDkrifJSwze3VipDfaraPqOVte0tU54iEf7XUnxeZqa7CvLzDFV0phhdrG46jXuJ+H+xbSg+WUcsAyx/4o4hiiBxOYJB6J0iNqNQWZwtygLxIPdR0bTNqzpkjNeUNVe9hxg7gzfbWeDqh64n90dIR90TZllooobwtHSo4ffSakWqbz5dd9Dwi+O6lBcTXiAWz7b9VksatCqBIULF8SyXIWPdMZDlcsmf1avfMy9VuvT9kOSh687Nm6Y/uGT/IgmAhKCr/DqYzrpZwqi0wXfwro+3d5T16HlpQnj0QD3y7Ql0uh7245VLltYK7jEKjDL04q6aO3DAg0Ja3N0BeOWvXzSnQecNjSA3VRz9spFTQ5B6IkZSsP9Mdg9sLsdONglI/Wc/zTmK/4qxvX60OK87var0MiSvYmY/fcMdEaCiexBzNBZca4Ja2pBzCD4eWCr/7SU+bzwJ68KSk8CBpjs18lj6hX6mjj9Mhifz6+tajaOBn0CYXqpEsW7O388DJ+AlbJVoYqOPui9gvQFy8pGkMf59kKeDikiXyGoc7FSAh3obQpR7O28hUvMI8vslWPTAlxVrruEb/mR1WRNWbrVtD7WSX9Bd+gHSi2Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2758.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(376002)(346002)(39860400002)(136003)(86362001)(1006002)(5660300002)(7696005)(52116002)(4744005)(6666004)(66556008)(66476007)(66946007)(54906003)(316002)(966005)(478600001)(16526019)(1076003)(55236004)(36756003)(186003)(4326008)(26005)(956004)(2906002)(44832011)(8676002)(6486002)(8936002)(2616005)(83380400001)(110426009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?b7nwatQj8czN/7AYlWjcj5H0dcDMZI7as6sy34Hp25RdSV+PGM0tWfRojWXo?=
 =?us-ascii?Q?MrqrjyS3fR5nRSRXS8+KX7w1+1TXe8WQNFUDTMsliXKRIIOHhZBCLUG+cCQ9?=
 =?us-ascii?Q?yWHPowAYy6xen41RJmn9B2dMszdAp6KINk7YgQE5naE+VIotPF5qIq6Us08j?=
 =?us-ascii?Q?GDcz0dR52nTpxxkDFMB7PAj1CCoRTy7zAa2phMdkPRroHVyzc4apOcbs2VcH?=
 =?us-ascii?Q?3TuLgGC3WzvuoECpcF7BWI1iUNx54ZggtGWFTq1tDbnWmwm+jTuC4MCJjVCB?=
 =?us-ascii?Q?VQRMHg3jCNRcVjAvHrqkKZGIQCCWFKGAWBQhAJfLJcLFCVEujDC6YzsabsAS?=
 =?us-ascii?Q?WRRb9+Rk3+99lUcUcdIqf/JmJ0NobkZI6BICXRdxM94bo2mQlCL/XIC7/3Lp?=
 =?us-ascii?Q?iyNPjhvBW0BQIzgEuYvnoIlJkHQDXDvQ+EN4YxnBNv8sRZanO+Y8YS2KjmAw?=
 =?us-ascii?Q?tEUMYCvIjQhbMMx5v621Mo1eDMFFa9lOMWKCDiw+IaxvJbIo1EFfjreuzW3f?=
 =?us-ascii?Q?1Fi75Shb4YknNakW9kIe/Xyb1u+jZm+VMGt8lqQf+XpLdrCFygRwDj6KDlw0?=
 =?us-ascii?Q?317xm8d+b4IMTKEeW5rCbuYC9ZOp6wYdPEY7TRKQmLv5R5JesZ0l0uG5AFxx?=
 =?us-ascii?Q?MnktcIWbTeaFSLmYnxp/ztIn6XWe59Cvr/9p44g1bwtffpaLaiZ/l6+YG9y7?=
 =?us-ascii?Q?m/rrDOq0jOSnpLHe35PBnl9egNzwpJCHV2lU2RJcfrNfioGK0OrDnFh6bOcP?=
 =?us-ascii?Q?bcV1XwA4e6GSkZarX/aeNq6Dn9X8PCKrQdy1y0SYLs5paWW/2HZAyUw1BxYm?=
 =?us-ascii?Q?2uSZLonorMpJXitS+JjGRqmvxVKGG0l3NrRgrjuFA7o2b01SGXISVUuERUQY?=
 =?us-ascii?Q?+vz0cwIoTjrtyWv2Wos9/8ZcbJIkxXYp0B2wbZ7SyCYR8qPB8AL8ZA8CRjA8?=
 =?us-ascii?Q?R8n/MT5+Wql0kEHXPgf4cYtaB/1UWqgxhG3eObqK8p5ZQ/kj8eF89YoZDLre?=
 =?us-ascii?Q?mkgIxkEGYnkCbbDImNt0rmHHxHziw/gj4+P3wsvpGGc2J12CTeNFxCEctKCm?=
 =?us-ascii?Q?JOd6zj0FNLr46bGpuK+BQJkMmr3QgYUdvuZoqubxGU249JGtuiQw/aU44zyX?=
 =?us-ascii?Q?YbjhFvTB4kKSnU1jPcUbEyaDL0cw5XH+oGO5Q1CXQdlQKuHEZNJ5rSldsnRG?=
 =?us-ascii?Q?LYQoxDdjNeNEWr3kJmmluqxQmVP2sxYcH7qJMoNsowyp1PbM3Jh7ETYNLT/z?=
 =?us-ascii?Q?mjRugWqw4nLq+cv3U3OQ4JYlPJoZLNoU5EmhkzKuAF8ex6SR3H4f3JqedFxi?=
 =?us-ascii?Q?iX49bKmQdo2zK6H1nzM3J0q3?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c963864-4ac5-4e31-bb46-08d8dc9d5da4
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2758.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2021 10:32:51.5266
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mAR7n6iVxkCkZNe2kOfoFbS73TA5PYavpEfPLd6NWVT8DWyqSgHOD0VylqIun6peOHR7Ruuo9OzvtkCyuEwAxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4236
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Mark,
This patchset involves changes in NXP Flexspi driver.
Please note, though all patches might not be related to each other, I
have clubbed them so as to make easy application of series.

Patch2 is dependent on dt-bindings
https://patchwork.kernel.org/project/spi-devel-general/patch/1614593046-23832-1-git-send-email-kuldeep.singh@nxp.com/

Patch1: Enables IP read in flexspi
Patch2: Add imx8dxl support
Patch3: Errata workaround for LS1028A

Han Xu (1):
  spi: spi-nxp-fspi: Add driver support for imx8dxl

Kuldeep Singh (2):
  spi: spi-nxp-fspi: Add support for IP read only
  spi: spi-nxp-fspi: Implement errata workaround for LS1028A

 drivers/spi/spi-nxp-fspi.c | 114 +++++++++++++++++++++++++++++++++----
 1 file changed, 103 insertions(+), 11 deletions(-)

-- 
2.25.1

