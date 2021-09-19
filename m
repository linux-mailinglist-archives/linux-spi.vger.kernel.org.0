Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C3A3410A8B
	for <lists+linux-spi@lfdr.de>; Sun, 19 Sep 2021 09:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232832AbhISHkv (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 19 Sep 2021 03:40:51 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:52326 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231495AbhISHku (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 19 Sep 2021 03:40:50 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18J3krpq032162;
        Sun, 19 Sep 2021 00:39:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=kfR70gNtZvjc6l97pHGaKBMfk0sG5B+cTGyix0Sul+I=;
 b=itAXm6WiKmtNlKxogSVZF9oRm+IuK8+LTE4PdLQE81lazEkZvNxe0e5TpGuDhI33/RfU
 rmsKC1ODmIdTKpL/60pRx+8sk1soY1b9m8qm7V0poZtiJgFMTPNMGe9SPhSYBo3GGQl2
 OZNpwMuOLMSJqvDa/m8upzGxDfIAbunTrSLqgjOWZ00WX1v267nzwkDfosfa7GhcM1sl
 bJIC79fPxBMaJImUfo4NjrMzRCGwjgJkryZ+GGx0izOnw4JnB913V79qrtyDGO9VSLh6
 xb8CLycb7JD7Wevho1IjcJXHPUhtY1fdI+ziMfneqx1qSVexstnqDAOqpa5i7ypnagLI ig== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by mx0a-0014ca01.pphosted.com with ESMTP id 3b5cnwa1e1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 19 Sep 2021 00:39:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QjzaKdBXXhemiYWJENEkziCIr/JH/FLCjz4yd87Dj7aVR9uo+vFZak5uQer+4Gh0vhwDmPHTTmlWT/7kkFqYzpV3EqgiowuCkFiDgYllVO3TbpEmWYSYRIaWng8oiceJ/JTyio1GpHBkzYSZGIxK5nMvnqzPnPIfTfI9wNaA3l7UNQtx7GceSCRa1iXMPffFLp5NmRvLkYn8+JbL8kjgZsRcstUG2hOOYoCMqIwFX4Du2IdmZ612nHhSFBVEgP0ef2/Nl7FyMbpFHEIpH8dzOF8DUL2TzIryaEcvMcWH4pXggqCaaB9M/m3qDauZtenghJr0ee8UJM0FrsMd9LThDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=kfR70gNtZvjc6l97pHGaKBMfk0sG5B+cTGyix0Sul+I=;
 b=kh6Z1rgCBLqheFNWD/08w1pbF1a6dezl4cbBQ4oltbEwEkiJ4SAMiSS75E40fsFEWVnnBIK+Wi7WNmjrGdeVrEmvIDRaJxSc7RT4ZEbT+Oenft9x6YFkhHfR/fI+EV6lhtfw4i3lG6e640+zFyhzZ57fvU0EM6r8DDn/QHVY2mT7FLty/2CpIbbTgFfHhIoXF+lPUjs6GSYLb4j6V9ElRV2zQEXxtaU6fNpw6QHwDAoMMFdCTllZxtHC0gB+B9LbMbwEEa/od1WU6oSozh6k7SRx4uBCSMEdCKxdI9KhHv/lDwPsxL/cg+oB/rNTOTsxDcOkeURhl9EySMDK1UlkCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 64.207.220.244) smtp.rcpttodomain=ti.com smtp.mailfrom=cadence.com;
 dmarc=temperror action=none header.from=cadence.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kfR70gNtZvjc6l97pHGaKBMfk0sG5B+cTGyix0Sul+I=;
 b=PGGwtgExzA4LPCJQXuoEIw4xLe3SWT21Sqi7WQMmd/q+sezO6PCPNYuoT4Km+lvZxafP5Z9PnuhSfl6UqSja3Ulpj4kmqZBuCDL+d0FTgw4yL3SqsflvPsdjQYWfBOAXu9y9Yl3c5pklHOU51TKxftEz5bRJLiSVPvMxwicAzXg=
Received: from BN9PR03CA0605.namprd03.prod.outlook.com (2603:10b6:408:106::10)
 by BN6PR07MB2915.namprd07.prod.outlook.com (2603:10b6:404:40::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.17; Sun, 19 Sep
 2021 07:39:20 +0000
Received: from BN8NAM12FT036.eop-nam12.prod.protection.outlook.com
 (2603:10b6:408:106:cafe::29) by BN9PR03CA0605.outlook.office365.com
 (2603:10b6:408:106::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend
 Transport; Sun, 19 Sep 2021 07:39:20 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 64.207.220.244) smtp.mailfrom=cadence.com; ti.com; dkim=none (message not
 signed) header.d=none;ti.com; dmarc=temperror action=none
 header.from=cadence.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of cadence.com: DNS Timeout)
Received: from wcmailrelayl01.cadence.com (64.207.220.244) by
 BN8NAM12FT036.mail.protection.outlook.com (10.13.182.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4544.6 via Frontend Transport; Sun, 19 Sep 2021 07:39:18 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 18J7dEVA066368
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK);
        Sun, 19 Sep 2021 00:39:15 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu4.global.cadence.com (10.160.110.201) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sun, 19 Sep 2021 09:38:44 +0200
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu4.global.cadence.com (10.160.110.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Sun, 19 Sep 2021 09:38:44 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Sun, 19 Sep 2021 09:38:44 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 18J7chvD021055;
        Sun, 19 Sep 2021 09:38:43 +0200
Received: (from pthombar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 18J7cg6s021054;
        Sun, 19 Sep 2021 09:38:42 +0200
From:   Parshuram Thombare <pthombar@cadence.com>
To:     <broonie@kernel.org>, <lukas@wunner.de>, <p.yadav@ti.com>,
        <robh+dt@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <jpawar@cadence.com>,
        <mparab@cadence.com>, Parshuram Thombare <pthombar@cadence.com>
Subject: [PATCH v6 0/2] add support for Cadence's XSPI controller
Date:   Sun, 19 Sep 2021 09:38:41 +0200
Message-ID: <1632037121-21019-1-git-send-email-pthombar@cadence.com>
X-Mailer: git-send-email 2.2.2
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 48b6bda2-94de-4bc5-9eb4-08d97b4096fb
X-MS-TrafficTypeDiagnostic: BN6PR07MB2915:
X-Microsoft-Antispam-PRVS: <BN6PR07MB29157CD867CF2D8316F98E95C1DF9@BN6PR07MB2915.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZEWFbSxIeivL8gMI9PBl0PNWwlEqJ/TpkCRFNLzqoVNBfESEebxM3HBFkq/kwAYvk8VrWdaPfX5nN09WysayqzDkQzvp7D5OF2CvXLrU13OLElzBGMcCAO5zS0WFe3if6OgpeA/HjY8tJDcoiyeHU3KMk5/uLdrIPbq7IcihpZjP/buLW6Aq8OyILqfhPN8dSV7akifnRVXCVNnmuHyBlnfZ4MHiZy6B/seAGvJ0R6cBLLBBpSwCmTZytl6UfOlVrriHEe5yK9Cf4trIAUHN2LmSugagLgxXcIewQT4jnDJpgpLQxGI49RYnhHReadcLAWSF8hd9DHswJ0kvqQK5fb2ZzBiaPigTOJlrydyU2jGmIBPm3eYUAmEhk6KTwSAmHzLgQGzrLgPAmmDNtwOpdCNXh4TfspPcQex3v7MSE9ICEoXpMnOtnpOB5YKBAHkylyWuHao8llTLZ0pqFUzgtEfS5wBrhj51wFwVLHHCV1Qqty9l6ZOJbSuoOLO9giotDa+JGih93TNx60GXqpVb6AKHW4ZCdncFzCdDRctxO5u/pHuP+w/llSzorTbgafhvJrNFzqxnd2++CteXkQDqOoEHSmoF25NEGW0OYCxBEqY1sWiojacC68ZU1xLce7FP06797nI3vv1PCEZzYS7DyyiNMWuYYOCgyt9BFqppFXvTv4eJ6APQ2d3F3NTJEfHPPdirVV53bPS3+QYsD8ODLnpAUcr5v0dDhozhQnh1lP3PS3gpBjSxWir5Ldd9+pEoAuVYcC8GX8g9+dBuNsNr8A==
X-Forefront-Antispam-Report: CIP:64.207.220.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:wcmailrelayl01.cadence.com;PTR:ErrorRetry;CAT:NONE;SFS:(4636009)(346002)(136003)(39860400002)(396003)(376002)(36092001)(46966006)(36840700001)(82740400003)(42186006)(82310400003)(186003)(47076005)(63350400001)(70586007)(86362001)(83380400001)(2616005)(54906003)(63370400001)(81166007)(478600001)(426003)(356005)(2906002)(316002)(36860700001)(26005)(110136005)(8936002)(8676002)(107886003)(336012)(36756003)(70206006)(4326008)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2021 07:39:18.9342
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48b6bda2-94de-4bc5-9eb4-08d97b4096fb
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.244];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT036.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR07MB2915
X-Proofpoint-GUID: -qB-6aE4XuP5tmbrcbfbmsFrqq3v23R5
X-Proofpoint-ORIG-GUID: -qB-6aE4XuP5tmbrcbfbmsFrqq3v23R5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-19_02,2021-09-17_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 phishscore=0 adultscore=0 clxscore=1015 mlxscore=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxlogscore=653 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2109030001 definitions=main-2109190053
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

Changes since v5:
1. Added adjust_op_size to adjust op size according to sdma size.

Changes since v4:
1. Changed reg region names and lengths as suggested by Rob.

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
 drivers/spi/spi-cadence-xspi.c                     | 639 +++++++++++++++++++++
 4 files changed, 729 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/cdns,xspi.yaml
 create mode 100644 drivers/spi/spi-cadence-xspi.c

-- 
2.7.4

