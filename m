Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09E8740FA25
	for <lists+linux-spi@lfdr.de>; Fri, 17 Sep 2021 16:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241976AbhIQObJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 17 Sep 2021 10:31:09 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:25750 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S242026AbhIQObC (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 17 Sep 2021 10:31:02 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18HCsesB002680;
        Fri, 17 Sep 2021 07:29:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=9LO/hmol6UwKsCBYDA3ILrevklp68vcoO5Hc4re+hUc=;
 b=uE4L3b83f3Abe5e57UHtYH5wr3EaZWr1u7mDBZGIvx7cEWB9e1NMRM4VNaoK3UJQ9uEm
 Cuxw7dc97e9jMDKn3Zpief2dkPWeGSptrToSYWzK8pDO4Xz44a5Z2+TLUAGQw8ciyHjM
 +ZBrWU2vz3hYWzwkm8pMSLri1ozCyloF9Ij0Nerq4ESMPXr1x3csnyOkXoZ+FhGr22mz
 9EwBJ4S+ee7f9jnSAy5BpHnt+jKL3OH7EJskgML5jS2yr8RxTObYvX1pwmK5PxNK/Lyf
 Y9W28GTR2bdCslbuq38OHSYGozKyx1ct/iIUMMxBmUa2uNtsvUjmgiSPHrku9+6KDhnW SQ== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by mx0b-0014ca01.pphosted.com with ESMTP id 3b4etfteve-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Sep 2021 07:29:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e494E/Zrq/Q+ld9LB0PeGJKcMgItByuhxRP5UHNIwEmueg22kIXdOQrkybFIWSVkabqo9V4xeIeUCI4JxhOiwgJR+fEpmUxYr2z5Or2yEmnaV/1+24eRJBnwTvDQEswm7c8baXh6d62fZ2p43PM0IiNffiNLqH5eG+7D7kt36ALRhluY+lGGeHpQOy82qoIm0PdqhY+qaI0CiNzrFrFFjiOJVRjmokyQxLd3tnMi4la8V+OnI1dgfAf9eyP9AVc5+t9nzzg19Yw1nnR4r45XBeLuVxexcO7bQqPtCPmr+Ml8ZJkz7dl8d31E/E4aU1H5tn1VBU5xT7+IKIE0yeOsyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=9LO/hmol6UwKsCBYDA3ILrevklp68vcoO5Hc4re+hUc=;
 b=LLWOJVQces6wyPfE9ktaqBrIXA2YlILv8Sizs00RizcYCsl2jiClDBS9lBAvdEGgwLSJoAjkDDsqbXar2/QE1XEyPpvJPUOjAu6r80qK0K1uOybTy4YjvFqJxqUKrvanTP5gWNhAP4uTCkDoesbnZQRcNQj2DgKhJwBlbtP5CpIjFsjlLyvBDo4ObIB1pwOOVBvSdH1PzB36SuRnqib1eVly1ueU+iPELgX2q2gHs/9uSzOOrpUposVXU0khbEu8kB0XpNBGLa0ZX9ERXAgEEkqHkVKCCYny4+14cMonN8LFm5M2Sbv6SRKJ7OulVikT+ECHLosVLXtbU8uu14pRPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.148) smtp.rcpttodomain=ti.com smtp.mailfrom=cadence.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=cadence.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9LO/hmol6UwKsCBYDA3ILrevklp68vcoO5Hc4re+hUc=;
 b=YQWOYQit0pqotpKpU+xPrp9YLq5HQfrPMLoR4V0ObnF7eQqk1B7aKVui5LcYgSHnwDIwldAz7euyOfB9QSC3ZK5GnOGM5z3GPdvNqoGRNCb/VhVBNcLpNVzhomzHXJCWv+wmI/Wwrn6uqoHmvU3SJNSMIJU/eZeRMLRxJT9Xxqs=
Received: from BN6PR22CA0043.namprd22.prod.outlook.com (2603:10b6:404:37::29)
 by PH0PR07MB9011.namprd07.prod.outlook.com (2603:10b6:510:106::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Fri, 17 Sep
 2021 14:29:32 +0000
Received: from BN8NAM12FT023.eop-nam12.prod.protection.outlook.com
 (2603:10b6:404:37:cafe::7f) by BN6PR22CA0043.outlook.office365.com
 (2603:10b6:404:37::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend
 Transport; Fri, 17 Sep 2021 14:29:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.148)
 smtp.mailfrom=cadence.com; ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.148 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.148; helo=sjmaillnx2.cadence.com;
Received: from sjmaillnx2.cadence.com (158.140.1.148) by
 BN8NAM12FT023.mail.protection.outlook.com (10.13.183.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4544.6 via Frontend Transport; Fri, 17 Sep 2021 14:29:32 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id 18HETTWY020532
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Sep 2021 07:29:30 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu5.global.cadence.com (10.160.110.202) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 17 Sep 2021 16:29:22 +0200
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu5.global.cadence.com (10.160.110.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Fri, 17 Sep 2021 16:29:10 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Fri, 17 Sep 2021 16:29:10 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 18HET95P017095;
        Fri, 17 Sep 2021 16:29:09 +0200
Received: (from pthombar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 18HET8nT017093;
        Fri, 17 Sep 2021 16:29:08 +0200
From:   Parshuram Thombare <pthombar@cadence.com>
To:     <broonie@kernel.org>, <lukas@wunner.de>, <p.yadav@ti.com>,
        <robh+dt@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <jpawar@cadence.com>,
        <mparab@cadence.com>, Parshuram Thombare <pthombar@cadence.com>
Subject: [PATCH v5 0/2] add support for Cadence's XSPI controller
Date:   Fri, 17 Sep 2021 16:29:07 +0200
Message-ID: <1631888947-17058-1-git-send-email-pthombar@cadence.com>
X-Mailer: git-send-email 2.2.2
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 321e64e0-bce0-45c4-1704-08d979e790e0
X-MS-TrafficTypeDiagnostic: PH0PR07MB9011:
X-Microsoft-Antispam-PRVS: <PH0PR07MB901154759276CA5A5B78E937C1DD9@PH0PR07MB9011.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kcLOB6ydZeQbh09CRMh+1vUo+ZPAoyhS8LgtDP+k6rTsBxI0S8nfi3uxavs7lovm8b1Fqlc85L+BstuOUCBEbMSY90006wdozoPDanktbdANPAiuOye2MH7tlh428rVmYnyKaNkdLA4GwrIS6vajqa7PLB3yzm4dmmUr9c4QprQwl78HRgrLI+LKz/Rd8vcEPR++jz/i0wYbOQqp6w1YLs5cNNEdjxGVrugvMG2mM9a2DYVlf7wKpbowOI7hAxGIiiypL67DLLD6FBOOgC1JX64vXnSDVbufZwnME8gR/2vYttw77vU2RK5fxp0SaOy7BAztFH6VfMd6vbnLGxp2dBfXuTKJ6wqgy+zpHlbaFbc961rDu8e9AKL1yC149zC8NHPor3a0avS/p7Np5IoSl5B2a6qLJ4ypsRMx5I9z73eYDPy2c44+Wy2OCm8b12QVF4VQJebyNkoYlv83oelE1ov1CZKG5O7ON8DcuLRovPsEZdS+6yDQjqDuh2nWoL26Trbz5lOb9RrrmUzFv2Xv7Ur+cRluRTXwt/JNDURS89Gdd8IEmApmc45TcpGcsUPLTabf6IXu8TU6v+cVn8ofUH1UHheaSEtrVpO6dBwPUtYCLl488sUrPHFSJ178PwPIYBumhbdcND/Dm6bDhbFfjvoGEDpf08k3267JEpFmAw4Vtf2o2rF+KZiVeUqipWutv5qpOLgN0fHDx8KiGZIw6CbdujQs55XYssxytvFbDpk=
X-Forefront-Antispam-Report: CIP:158.140.1.148;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx2.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(36092001)(36840700001)(46966006)(8676002)(86362001)(110136005)(42186006)(4326008)(5660300002)(70586007)(26005)(70206006)(186003)(36756003)(336012)(54906003)(2616005)(356005)(508600001)(426003)(36860700001)(82310400003)(107886003)(83380400001)(47076005)(7636003)(2906002)(8936002)(36906005)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2021 14:29:32.3287
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 321e64e0-bce0-45c4-1704-08d979e790e0
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.148];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT023.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR07MB9011
X-Proofpoint-GUID: H4qphD4r32JPNCPnzJNsACzkou_xExve
X-Proofpoint-ORIG-GUID: H4qphD4r32JPNCPnzJNsACzkou_xExve
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-17_06,2021-09-17_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 bulkscore=0 mlxscore=0 phishscore=0 mlxlogscore=709
 lowpriorityscore=0 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0
 suspectscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2109030001 definitions=main-2109170093
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
 drivers/spi/spi-cadence-xspi.c                     | 626 +++++++++++++++++++++
 4 files changed, 716 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/cdns,xspi.yaml
 create mode 100644 drivers/spi/spi-cadence-xspi.c

-- 
2.7.4

