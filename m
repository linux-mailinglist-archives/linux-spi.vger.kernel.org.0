Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C22333D0A66
	for <lists+linux-spi@lfdr.de>; Wed, 21 Jul 2021 10:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236060AbhGUHdY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 21 Jul 2021 03:33:24 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:63266 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236442AbhGUHby (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 21 Jul 2021 03:31:54 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16L8BxHU019546;
        Wed, 21 Jul 2021 01:12:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=od1qgwPdesVrx/a5RzhfIJUjik2Kl6xewfT1iFSN8Gg=;
 b=D/EwDv1zG7qjZ8tSeF5Lpp9e3w7Qdx15Ljtc6vFIm29dl3P4dYQHd4+FpaBFnZmCaDtu
 64A0dtwaT9Q+F2ONTRyxP98uz4fxbfypMft9xiqgTT88tTDs4+OvzpwtvyK7L7iYG6Ed
 HfZCtyzPFUPL4bfMkpJ8rd7MHHsz/xNAofSjt7fbwLMSvu/BRzxx4vYyv/LgJQ4JvK9O
 8g1id4TMJZNoUJxnCsvySmJggpMuJvjLNA+9bM1+Jrgy6iCjzTdWc/mACf0QvvgnQJTp
 +xRy20m+P9RjRPhgDjpPbUcvm6+9PMpO7/GX8tLs/ERlGUcD30pXrtrUXMFn789Sk9fF tA== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
        by mx0a-0014ca01.pphosted.com with ESMTP id 39xawqgud0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Jul 2021 01:12:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R8SADzB7CQZKW2aL1ffiDOAJRIuLW8SmHqyq/AFUsgA6WsfTXaD2TpmsPm7vIbKmBfZlBaOyne/zNqMHtbKK1HQ124diYlMToWU9nsSd61ibvFVY7cyldoq+kXVU8LootmvEDpuy7phKH22kyJHGbifri4DOeuLuCDGA8DH0w+xlyne4zvjqhxhpz/7uawwxx2r5l/W1jdBDzeP3/zteKBhv2YjJ8oVDQ3fFLqlbkNX7mOXh9Cje5NdChpRod5DWrtkARxipEo1P9L0AkAHtGYsN7fIKjPfxSbgjxsfGfAYPZDUEA7tFOlrMRdUmoh7xvtrDu5zN4B9mKr4BrZQDow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=od1qgwPdesVrx/a5RzhfIJUjik2Kl6xewfT1iFSN8Gg=;
 b=IaamaKq7Pp9Hyo4MKpS9Jv/OiR+rbiPV1+M+DCYZILbPJXNBhr2BEIzlp/+yT3lXPvun3qHxIXUleNprpjVufRg0nQPwTHAky1WzkjsXF967V086istB7/GSSEMAZgjdfAew3c05hlEBQW3T6VrpUK6PQ0J7BWcMaRYymSlKT9Wbju1kvsAeK3ulAt9hObWr4kvxeFgw7DTKXFlIqwrHoLjqXAhwr+wEbUYJ/mkNcWFLMKX/l9jzMFtdAezuU86jmeaCAVeTHVz0AujUsiGkjzQvR3Fz2OLyxm8kW6sgD+cPbxereMlFU+AizwdmGVgxH8DHu83FGvGVxJN+Zk8WDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.147) smtp.rcpttodomain=bootlin.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=od1qgwPdesVrx/a5RzhfIJUjik2Kl6xewfT1iFSN8Gg=;
 b=EkaRoizrrus8AxuWC5YurzHtbY3hdyon0Bj8+jDOHNRujtPk+4IdcQBs47ftucdIT4lZLFrVeu/quY86hh7SEfhVTUfblGPEoIcrh5EQ2A+/xPvZgSlhWsWAfkhjmKPTqM0dzkoMxfd3JNk3kcBx/OjFKaAnKTG4jzqmueutTY4=
Received: from MWHPR1401CA0018.namprd14.prod.outlook.com
 (2603:10b6:301:4b::28) by BY5PR07MB7157.namprd07.prod.outlook.com
 (2603:10b6:a03:1f1::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.23; Wed, 21 Jul
 2021 08:12:08 +0000
Received: from MW2NAM12FT040.eop-nam12.prod.protection.outlook.com
 (2603:10b6:301:4b:cafe::13) by MWHPR1401CA0018.outlook.office365.com
 (2603:10b6:301:4b::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend
 Transport; Wed, 21 Jul 2021 08:12:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.147)
 smtp.mailfrom=cadence.com; bootlin.com; dkim=none (message not signed)
 header.d=none;bootlin.com; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.147 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.147; helo=sjmaillnx1.cadence.com;
Received: from sjmaillnx1.cadence.com (158.140.1.147) by
 MW2NAM12FT040.mail.protection.outlook.com (10.13.180.228) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4352.9 via Frontend Transport; Wed, 21 Jul 2021 08:12:08 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 16L8C2SF012308
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Jul 2021 01:12:05 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 21 Jul 2021 10:12:02 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Wed, 21 Jul 2021 10:12:02 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 16L8C2dd025374;
        Wed, 21 Jul 2021 10:12:02 +0200
Received: (from pthombar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 16L8C1Xj025373;
        Wed, 21 Jul 2021 10:12:01 +0200
From:   Parshuram Thombare <pthombar@cadence.com>
To:     <lukas@wunner.de>, <linux-spi@vger.kernel.org>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-kernel@vger.kernel.org>, <mparab@cadence.com>,
        <jpawar@cadence.com>, Parshuram Thombare <pthombar@cadence.com>
Subject: [PATCH v2 0/2] add support for Cadence's XSPI controller
Date:   Wed, 21 Jul 2021 10:11:58 +0200
Message-ID: <1626855118-25327-1-git-send-email-pthombar@cadence.com>
X-Mailer: git-send-email 2.2.2
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f361608e-2a33-4c37-522c-08d94c1f3bd6
X-MS-TrafficTypeDiagnostic: BY5PR07MB7157:
X-Microsoft-Antispam-PRVS: <BY5PR07MB7157F197BBE0B86F44FDB001C1E39@BY5PR07MB7157.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WjfmcCq5lU7T6FQhfaWBe4qHwUx8hUtpFDI4qQb/XVZc4xqObiIlzJ3XJBaju4fCOaYt77/G7pFLSth1HOsrGVrzYpOL+CwaRnGpq9TcnKCPIeKyd7e6fV4sIU611TqwQUSTzPp04XFvkVLoPOS7Ly1V1JiAZdwaRxFXsKTj8qyVYFYZCfrL16/8y05fFTF5HKirIT3BF+51yrSt8zetWaf34hycYXBMQmwAgUqkuoKwcuEcn9epGDlg/dWoAWP1r5MJe8C6yri6a5ZvRoYVxoGWFQ0PwdQMOLjbs9MFEW0cRuNredwj7RO2AFEPVeacNcrNUKNM2asNGdqA2MiaF4d1XSPZn4pnsvAtEDKHVHH/4lOBNz6QGhlDqksJfU4BJxn0YNkW0U/acut0Ki6+OsKqkF9RBoGWX2jm2ElrPxxBr+p8mQTYcsmqhZ3qSpRXqpbIC0G7E3P4H2HsuD96gUCMR5FTnHwBcjxFKpsoRmS7qvN0QU/1zYc/lFUpDwQD2dQFeg/3PpUejjfugergyJa+JKwD20hlEEsp1zJR8+8M+raLk8JgQh0ugKZcyFR/j8worPq8TfAO+Y/78rGFCTI9oXjThJG4gEfJVBLUPBTDQ4rxuGtqEgSuBWShjJDcv5dlmLSgeoQ5+hwekwDva3hhTz8JkvPjFPpWZf6S2UIt1YNSz4fTJ+kXZDyr9mopGyUDqo0eI3n3zZ4xpMXlWtd0qzBuBrFMjossJsMrq2W86rUXicYvLH3WScSZCZrZ
X-Forefront-Antispam-Report: CIP:158.140.1.147;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx1.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(39860400002)(346002)(136003)(376002)(396003)(36092001)(36840700001)(46966006)(7636003)(42186006)(82310400003)(70586007)(2906002)(47076005)(70206006)(186003)(316002)(110136005)(26005)(107886003)(86362001)(4326008)(54906003)(8936002)(478600001)(8676002)(36756003)(5660300002)(82740400003)(356005)(2616005)(426003)(36860700001)(6666004)(336012)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2021 08:12:08.0644
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f361608e-2a33-4c37-522c-08d94c1f3bd6
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.147];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM12FT040.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR07MB7157
X-Proofpoint-ORIG-GUID: ZtA3RWYVVQc0ZpeX8tF4uA0lnKLtpeIw
X-Proofpoint-GUID: ZtA3RWYVVQc0ZpeX8tF4uA0lnKLtpeIw
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-21_04:2021-07-21,2021-07-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 adultscore=0
 lowpriorityscore=0 phishscore=0 mlxlogscore=501 impostorscore=0
 bulkscore=0 malwarescore=0 priorityscore=1501 clxscore=1011 mlxscore=0
 spamscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107210045
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This patch series adds support for Cadence's XSPI controller.
This controller supports multiple work modes e.g.
STIG (Software Triggered Instruction Generator) mode, ACMD PIO
and CDMA modes, direct mode.
In STIG mode, controller sends low-level instructions to memory.
Each instruction is 128-bit width. There is special instruction
DataSequence which carries information about data phase.
Driver uses Slave DMA interface to transfer data as only this
interface can be used in STIG work mode.
The CDMA work mode is dedicated for high-performance application
where very low software overhead is required. In this mode the
Command Engine is programmed by the series of linked descriptors
stored in system memory. These descriptors provide commands to execute
and store status information for finished commands.
The PIO mode work mode is dedicated for single operation where
constructing a linked list of descriptors would require too
much effort.
Currently ACMD PIO mode is used for NOR flash read, program, erase
operations, all other operations are handled in STIG work mode.

Changes since v1:
1. Use ACMD PIO work mode for NOR read, program and erase operations,
   for everything else use STIG(Software Triggered Instruction
   Generator) work mode.
2. Changes suggested by Lukas.

Parshuram Thombare (2):
  spi: cadence: add dt-bindings documentation for Cadence XSPI
    controller
  spi: cadence: add support for Cadence XSPI controller

 .../devicetree/bindings/spi/cdns,xspi.yaml         |  169 +++
 drivers/spi/Kconfig                                |   11 +
 drivers/spi/Makefile                               |    1 +
 drivers/spi/spi-cadence-xspi.c                     | 1102 ++++++++++++++++++++
 4 files changed, 1283 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/cdns,xspi.yaml
 create mode 100644 drivers/spi/spi-cadence-xspi.c

-- 
2.7.4

