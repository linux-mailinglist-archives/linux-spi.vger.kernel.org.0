Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13E2A408AA7
	for <lists+linux-spi@lfdr.de>; Mon, 13 Sep 2021 14:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239796AbhIMMEh (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 13 Sep 2021 08:04:37 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:59536 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235453AbhIMMEg (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 13 Sep 2021 08:04:36 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18D9TSxD028609;
        Mon, 13 Sep 2021 05:03:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=CgQB1XJqjoGyTZ4CYmMoARAwvU4iafYkLbbBv4JWJuA=;
 b=sYhmSegaFy2smLCbXnblhFHx4hlwGRPsTmMbYrtcVto+3j28EKADrfPl7FkTCW59iu+I
 0+I7BMnV1MDWIMcJxMZSNPp9AvITZpcO5l9OZE2Y1csJxY3jz6P860NWFY3ZD/iqfc97
 cPYtgPkBkjI9ihnyW1VIJ6z+14jyPv8/At0v0v1+KK8hG6BE6h/CNWSG7g46UXuhwgrM
 ELDXd3Hv3w23uSLpfNgffU+6bFDdn8cgvgkOJiHgmflykaZ+nGPGCqk6QQq/VYLYiJLs
 7099uF2nxRHCq9NvrjEsu8dhUhTMzbCPrBWi9RFiCD28g0eLr7m+b2cVNFEjBPBUzLrU aA== 
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2044.outbound.protection.outlook.com [104.47.73.44])
        by mx0a-0014ca01.pphosted.com with ESMTP id 3b1hnetd25-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Sep 2021 05:03:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bxbvejose7jngB+rWGMtwsdYsyuHJfukAo9Y2isiSzn20g7jUMJj+b/UBH6+KJSq5HtB0Cuq/ZvETfwXwhVsu9qRLg87LsYkhiaGg51hxuAN5mpvDY/cHQ53CvrlZcSUvEzPu9k3wdlWgiyIIcWWQ/lbsygtAkY5daGeQ5+cuYBaF8py5dLnfu2I1XUZ58cE1al7nsEnIieWMiWI8KrKyKvnzmgUSfilTf/BZPKV6jcyNZDfBQb2iWl5yKvsVU9Lf+GkH+bJF0ToSARZjbiBKxfSLey2GbeT/fxUpBQpVJQjk7LZIWVxVZAzHxpNiRktmGDOE5tuXUnfspnwk6eIxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=CgQB1XJqjoGyTZ4CYmMoARAwvU4iafYkLbbBv4JWJuA=;
 b=nRodGFDdIQ+iD1odbFSsh20FVGPMeMHyEYIdOqAa/bmLUecRELoQq/WTd8oghzmrKEx+5MgxkiUs5zrc9hPcLlr+wv8LLBzegdpgXVXh5V5JBD4Yb2KGW748lXM79nb0GKBWXkc4FF6o5A4jmAl5l1yo7bcQrG8A3gUbQMVeoc5SZspA2TKS6hIbdTUqqL9Wqpww1pBAYwufeAfyTMUoIigpxUfvNbZ28XVOgZa4SYmQ0V092Ns1hxGk9JnG5thpUSEIJpmQp85HswpfGz4Y7k70LbcGFsysCJHY8W9QrzRV2V4FZI3+krRXRdfSSRv0z7fg9rX7N1qJSI4quNR9Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.244) smtp.rcpttodomain=ti.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CgQB1XJqjoGyTZ4CYmMoARAwvU4iafYkLbbBv4JWJuA=;
 b=yf9cxUFOnyRpadGpvXUuxgFCPvlxbszm0t4csmBW/PhZhccMfL9Bn7jkwssiQWGwwveJq4/a8GbbsrOxcpPjbbbKLquTVcBsLWMW5tCPPcMFZJ9b/BvesWRMQljqQrJ9grfERa2kDi6Q443DpTSHh7xnAM8oCq/R9iyzD9+xZZk=
Received: from BN9PR03CA0294.namprd03.prod.outlook.com (2603:10b6:408:f5::29)
 by DM6PR07MB4169.namprd07.prod.outlook.com (2603:10b6:5:bd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.17; Mon, 13 Sep
 2021 12:03:16 +0000
Received: from BN8NAM12FT062.eop-nam12.prod.protection.outlook.com
 (2603:10b6:408:f5:cafe::5b) by BN9PR03CA0294.outlook.office365.com
 (2603:10b6:408:f5::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.15 via Frontend
 Transport; Mon, 13 Sep 2021 12:03:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 64.207.220.244)
 smtp.mailfrom=cadence.com; ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.244; helo=wcmailrelayl01.cadence.com;
Received: from wcmailrelayl01.cadence.com (64.207.220.244) by
 BN8NAM12FT062.mail.protection.outlook.com (10.13.183.65) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4523.8 via Frontend Transport; Mon, 13 Sep 2021 12:03:15 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 18DC3CHB097680
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK);
        Mon, 13 Sep 2021 05:03:13 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu5.global.cadence.com (10.160.110.202) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 13 Sep 2021 14:02:54 +0200
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu5.global.cadence.com (10.160.110.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Mon, 13 Sep 2021 14:02:41 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Mon, 13 Sep 2021 14:02:41 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 18DC2eiB008139;
        Mon, 13 Sep 2021 14:02:40 +0200
Received: (from pthombar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 18DC2d5h008138;
        Mon, 13 Sep 2021 14:02:39 +0200
From:   Parshuram Thombare <pthombar@cadence.com>
To:     <broonie@kernel.org>, <lukas@wunner.de>, <p.yadav@ti.com>,
        <robh+dt@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <jpawar@cadence.com>,
        <mparab@cadence.com>, Parshuram Thombare <pthombar@cadence.com>
Subject: [PATCH v4 0/2] add support for Cadence's XSPI controller
Date:   Mon, 13 Sep 2021 14:02:38 +0200
Message-ID: <1631534558-8102-1-git-send-email-pthombar@cadence.com>
X-Mailer: git-send-email 2.2.2
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 98360668-f5dd-4af0-f297-08d976ae77cb
X-MS-TrafficTypeDiagnostic: DM6PR07MB4169:
X-Microsoft-Antispam-PRVS: <DM6PR07MB41693420989219344F204E5EC1D99@DM6PR07MB4169.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 97LiA1pykjq2Tox7YQADa8JTFxVxoC97z4p94+ol06A4BKYmAaX5D+9jS27km7Fh0om89OuiNMOXioRJ5Z2kUkEylMxerIJPLpBAynCW95Sz6Hj6/WaR9h5MGaYsfNOGD1U2Tn9eYZHOzdNpakMMf+0sTNm5XtccvjPtOFSW+MnqNALh3uw0ZK9Ooi2IhZEB2M1HvKD+jzQzQhX+Oz70HM95jqOZwExUuj8QiRnA7NGzWC7EMuMz9IcYxhRk+w1n+Grak9H+4rc7R5SYLRnf39B9F5mCLO/bu0OcWLuoz2wpNaRNKWADq949zutlHOddnz4vp8F0rpZGkm4luOlfH7UOLqW11fea0qJH41n+Ofk5/+te1FM/DNu0996nI14rLZvWJmtioQlOffe8R27DEPvhKt9SJq3AXT2UvjEfOIt9Ig+Vx5xLnYnfUfeAyI14R0fB+ZEaCjZPuxQoOGIcbDYUF1Ff8FQIMn5SRroivcvgWv5SF2OzrqKGi35CGLIOAaJVLiBp15XstyZ8op15Jrkc/lSpAuj5owHz9wRkAZuVDBW4bTNf1Xbxmb6wmDT4etk8aYQGsyytoKn95Pk0LFQ/tlOYSlMYYmVecUFfgm5d5NzEHFZTv2F9Qu0O6AxhnanvMU4hPkLb2dNMI5i8HLpYvJ37linJTmZU6UsRAqRew4iU5bqY/Dv+8PBk5AO22yCMalxGYKB615Imr65CwXautV/UK36I+1ikeIWHQU9z8Nk8snFfzdoltsTl/VBOCghnpcEClgJPHwUvFP9krA==
X-Forefront-Antispam-Report: CIP:64.207.220.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:wcmailrelayl01.cadence.com;PTR:ErrorRetry;CAT:NONE;SFS:(4636009)(346002)(396003)(376002)(39860400002)(136003)(36092001)(36840700001)(46966006)(107886003)(36756003)(316002)(54906003)(81166007)(82740400003)(4326008)(83380400001)(26005)(2616005)(110136005)(8676002)(42186006)(86362001)(426003)(336012)(478600001)(2906002)(356005)(186003)(82310400003)(36860700001)(70206006)(70586007)(5660300002)(8936002)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2021 12:03:15.3848
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98360668-f5dd-4af0-f297-08d976ae77cb
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.244];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT062.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB4169
X-Proofpoint-GUID: Q1NQ7rRNRj6kdr4LJd4l1BF-PjFZzbkL
X-Proofpoint-ORIG-GUID: Q1NQ7rRNRj6kdr4LJd4l1BF-PjFZzbkL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-13_04,2021-09-09_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 clxscore=1015
 mlxscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 mlxlogscore=581 phishscore=0 suspectscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109130081
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This patch series adds support for Cadence's XSPI controller.
It supports 3 work modes.
1. ACMD (auto command) work mode
    ACMD name is because it uses auto command engine in the controller.
    It further has 2 modes PIO and CDMA (command DMA).
    The CDMA work mode is dedicated for high-performance application
    where very low software overhead is required. In this mode the
    Command Engine is programmed by the series of linked descriptors
    stored in system memory. These descriptors provide commands to execute
    and store status information for finished commands.
    The PIO mode work mode is dedicated for single operation where
    constructing a linked list of descriptors would require too
    much effort.
2. STIG (Software Triggered Instruction Generator) work mode
    In STIG mode, controller sends low-level instructions to memory.
    Each instruction is 128-bit width. There is special instruction
    DataSequence which carries information about data phase.
    Driver uses Slave DMA interface to transfer data as only this
    interface can be used in STIG work mode.
3. Direct work mode
    This work mode allows sending data without invoking any command through
    the slave interface.
Currently only STIG work mode is enabled, remaining work modes will
be added later.

Changes since v3:
1. Removed ACMD PIO mode.
2. Return IRQ_HANDLED only for handled interrupts.
3. DT binding changes.

Changes since v2:
1. Removed extra lock around exec_op.
2. Removed PHY parameters setting from the driver, those will be
   handled by bootstrap pins available in the controller.

Changes since v1:
1. Use ACMD PIO work mode for NOR read, program and erase operations,
   for everything else use STIG(Software Triggered Instruction
   Generator) work mode.
2. Changes suggested by Lukas.

Parshuram Thombare (2):
  spi: cadence: add dt-bindings documentation for Cadence XSPI
    controller
  spi: cadence: add support for Cadence XSPI controller

 .../devicetree/bindings/spi/cdns,xspi.yaml         |  77 +++
 drivers/spi/Kconfig                                |  12 +
 drivers/spi/Makefile                               |   1 +
 drivers/spi/spi-cadence-xspi.c                     | 627 +++++++++++++++++++++
 4 files changed, 717 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/cdns,xspi.yaml
 create mode 100644 drivers/spi/spi-cadence-xspi.c

-- 
2.7.4

