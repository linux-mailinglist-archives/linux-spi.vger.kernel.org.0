Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 952D1410AAF
	for <lists+linux-spi@lfdr.de>; Sun, 19 Sep 2021 10:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236595AbhISIGb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 19 Sep 2021 04:06:31 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:30750 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236395AbhISIGa (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 19 Sep 2021 04:06:30 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18J0wSck013151;
        Sun, 19 Sep 2021 01:05:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=TWkffLm+DZNuHXiSk+CCbXbc47Y7JX4KIImKpLmPuPc=;
 b=JziOco09Q3ZAQrpKOdGwMmL9cE7QhyS7EPwUbMuHio4CQn+dqfT+miJnoMKBB2ceDuOK
 dLD+iHTaoKOos/9pKbUVaX5nRjhM8yTc+VsMgeOrSBBTl7qJ5eCW7MT7EljuGWskevNl
 rjIAkD4mmDIi0r3IXo7x8DBPQ4SR/f2Wa9LdsFgNiyZPuV7kseqdVs8eOzBa6DxR3ofj
 VEq4LtkQrMtcgHfx9jcycGB4hiBluKVhwebmCYglEhXz+IiRoS1rAb0BkXMZ+lA9IM1g
 A8uJj9jTfgVOx2X2xQi3bQOYIZvZRg4H1U/ZIpU5G1NYkGV4PWkX4iuj3Ja8W+bGTKGY ww== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by mx0a-0014ca01.pphosted.com with ESMTP id 3b5cnwa2pa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 19 Sep 2021 01:05:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q8ZSP9AHE9133JX3EevACz9QANzp5NDagcHdZ2dA1ZvbugKja7mfuNUwmLjcZzrtDxecvj0G+27mBGlvjBgHvl+zCRqRT7kuIJIzOIY0q3EFTCl2WsjmHwc0XmB15HYeY/f5LVvzzNFx6mWo2rpoldLkmQxylZQjIoehWJa5Kex6mP0q+Q7Z44cMsLAEWzVzfAt4Whx4VtTn2/EjUthB1flLyte5Y8MWQh5M+ZQUIlnEmzekcRIuy5R+32B1zF6UOKvI3c8nriN8L3r6zEZcjcIf/TgBJasTRpRAxfLSW7lu5c33Nuhf0c5ZLwP1h5WjQJjSzwDn6w6ZyvSwZ+c9HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=TWkffLm+DZNuHXiSk+CCbXbc47Y7JX4KIImKpLmPuPc=;
 b=QvgCZR3BO6+d1H/3AO16GmJtQLYnZaYT/Iwuk6NMZlD38A4e17xli7l58ePhUigByS8+XFIX+5Yhcw1+3DKbH1Zj7niJnFUsQ9Bo9P8UEn30kSRILyji0DVVIg8hqmlcLTR+shlr32+KaTRPwGdzay2EVLphX5338Ce0cDqxuG4GSExNR+pT68WP3MUM+CcwbkQYG6ECHBOpTfoKnxE5MLHUiV4OPMCP01M3FD05dk1UioQM17OUm+RHrQcIvBJO9dY4nCIITMNZEofmgMwfIQOmSZJ+m+OphX/Gr/6PW+f194p+QmxVy0WC5rWaLt2mDyndi91OOo5gB/X4e7k+NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.244) smtp.rcpttodomain=ti.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TWkffLm+DZNuHXiSk+CCbXbc47Y7JX4KIImKpLmPuPc=;
 b=Tl9fb9Kq2wTGt0RehR7S4kl1QxRtbiRzrwX1uPXOUMNsk1Mm/ol0T7794BioBhk0eZVbClW5fanScUTZO+6wjQ350/rqd+KztBuKAte3SuFXDYedKc23Gd/fa7IVGNkiMZBl04DQ6uK3ISU1JCk1UcrziO7AcSdrW+Fygk8B4NY=
Received: from MW4P221CA0012.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::17)
 by CH0PR07MB8842.namprd07.prod.outlook.com (2603:10b6:610:102::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Sun, 19 Sep
 2021 08:05:00 +0000
Received: from MW2NAM12FT051.eop-nam12.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::7a) by MW4P221CA0012.outlook.office365.com
 (2603:10b6:303:8b::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend
 Transport; Sun, 19 Sep 2021 08:04:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 64.207.220.244)
 smtp.mailfrom=cadence.com; ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.244; helo=wcmailrelayl01.cadence.com;
Received: from wcmailrelayl01.cadence.com (64.207.220.244) by
 MW2NAM12FT051.mail.protection.outlook.com (10.13.181.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4544.6 via Frontend Transport; Sun, 19 Sep 2021 08:04:58 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 18J84uOT067819
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK);
        Sun, 19 Sep 2021 01:04:57 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu4.global.cadence.com (10.160.110.201) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sun, 19 Sep 2021 10:04:49 +0200
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu4.global.cadence.com (10.160.110.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Sun, 19 Sep 2021 10:04:37 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Sun, 19 Sep 2021 10:04:31 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 18J84URB023792;
        Sun, 19 Sep 2021 10:04:30 +0200
Received: (from pthombar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 18J84Uxt023791;
        Sun, 19 Sep 2021 10:04:30 +0200
From:   Parshuram Thombare <pthombar@cadence.com>
To:     <broonie@kernel.org>, <lukas@wunner.de>, <p.yadav@ti.com>,
        <robh+dt@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <jpawar@cadence.com>,
        <mparab@cadence.com>, Parshuram Thombare <pthombar@cadence.com>
Subject: [PATCH v6 0/2] add support for Cadence's XSPI controller
Date:   Sun, 19 Sep 2021 10:04:28 +0200
Message-ID: <1632038668-23756-1-git-send-email-pthombar@cadence.com>
X-Mailer: git-send-email 2.2.2
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 16161bfc-4eca-4fd2-533c-08d97b442c72
X-MS-TrafficTypeDiagnostic: CH0PR07MB8842:
X-Microsoft-Antispam-PRVS: <CH0PR07MB8842F0223D308DA122CF5AF9C1DF9@CH0PR07MB8842.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E77hn1aE0Ut6FiK3zfzRudGj0Vm26LhpUSV0U3k+3RlXQu2xI8ALbenaZ9a5cTRpbmFf2dVXikLfANA/1B/rP5pnaiYMbekFFUpeQw7r3EDvlj3fO7XXVwDhmPj10WhwUnRupHeKFOPisIlnV5laPCxTvt+mwAqaOxrCXqRlkw1/GfQAXn2GDA+qHORWd8SMkQ56pIhviy4JW0RIZh30e3P7ooETDZV+b3u0n+na/9e7CCxQix1jfSnMEptE1eYaIYRYMUQwXVLJqvpS8Jgi0THGZPV9F64yF1AOgYtFEh+ckpXym5Z8fIh+8NIB3C1mztB9Covaan0f9q8WmjeEvL8RxukyToC9oYsygfClXLxSZI7d9yrktV7lc/6GSJU0LQaP7160V8y0Mf26L5bj+MH/D3wrwyp/RTZBofd2q9qUwwZ1beWAzNyIsNUN3qgPEToUyU0cgrQrBbRPRpGKxVAzoEJK3C1Pl826EmgSxxaXSLZsLRb226uRCYMJ9Y5/cdyP5RuSn8ggFkTjmCMcab6tJTdJ9UNCaF6dq2TlXql2UttQ6eHi0+bfE0c7Inw8pKAL+wC87wXDiDROvS1k0Kc08OuHac6MSHxSBDMvnPXXu6RI9+NIrtQ8HJUeFw8Y40v28AKlUUKsqBf5RObpgJy+HnYFveDdRXNGZSr6yyGdfDPgAtfucVj9Y3yuV63XZdsXlC0wDdkNKWD2J31WPZtQuvmNRIHQGnZKdmJuzbpur+mJV0+zWKSiXMUEBi20Dd6deF38di4b07fw9wYc/w==
X-Forefront-Antispam-Report: CIP:64.207.220.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:wcmailrelayl01.cadence.com;PTR:ErrorRetry;CAT:NONE;SFS:(4636009)(36092001)(36840700001)(46966006)(110136005)(54906003)(36756003)(316002)(42186006)(36860700001)(508600001)(70586007)(2616005)(82310400003)(8936002)(86362001)(8676002)(4326008)(336012)(2906002)(5660300002)(107886003)(356005)(26005)(83380400001)(81166007)(70206006)(426003)(186003)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2021 08:04:58.2788
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16161bfc-4eca-4fd2-533c-08d97b442c72
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.244];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM12FT051.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR07MB8842
X-Proofpoint-GUID: B0mnF2xGb4UYwUhBFxBy1qAZw6RrAikU
X-Proofpoint-ORIG-GUID: B0mnF2xGb4UYwUhBFxBy1qAZw6RrAikU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-19_02,2021-09-17_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 phishscore=0 adultscore=0 clxscore=1015 mlxscore=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxlogscore=653 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2109030001 definitions=main-2109190057
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
 drivers/spi/spi-cadence-xspi.c                     | 640 +++++++++++++++++++++
 4 files changed, 730 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/cdns,xspi.yaml
 create mode 100644 drivers/spi/spi-cadence-xspi.c

-- 
2.7.4

