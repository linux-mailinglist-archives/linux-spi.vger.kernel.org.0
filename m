Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD5D6142B4D
	for <lists+linux-spi@lfdr.de>; Mon, 20 Jan 2020 13:54:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbgATMyX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 20 Jan 2020 07:54:23 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:64950 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726589AbgATMyX (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 20 Jan 2020 07:54:23 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00KCqMas025894;
        Mon, 20 Jan 2020 04:54:20 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=jgV/LWeBDD8OqVf8YjsosQzxifjHHUjXGlT/J7EQRmo=;
 b=PzQwUS4vfQOa1lSSEwJmR59qD3GbKy8Rc8xpICPyQA0mWJ5lIePi6V97PPc3tnIUyRmr
 U1hUz6DOV46gagzKpxIvgtX7gWKn6AqjB1Bq7nSOXtXub3hCqJSyTr46F4cv9yNgXvke
 wsU2h/X/K+XM7lby95ooHkYEJcxWNW/zQpNJb6BHqfrgX+TLjr9RvNu9qMzCHWYzX9BL
 upeP1602t6HF/l3yY/gxS1hgrUPEnQV87kOR5HQ69CvjC9F99ZFRRRSlLwskHI396HLr
 aFvlYjN45OWXiZjvb0BS59kml0uHc78xbSwGodEL6rz3m/k6+tFQkZTVhtF4uQeSnlB3 LQ== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2xkyf5dcs2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Jan 2020 04:54:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SCxa9SjztyntI5d7pT2d43T71Ze89Tq34ehgvaRBYLRxHu3BYGsCuDDgOEzyhLmBGc90+HHg8s/ZBqu+2hkdXgbcwVLKbLtqRBhNTdd3+XkBEvE19aAmwhLaoekoyuY0cCwLUdcvrIfBUAwxF6cT8rPOPKjo1bq7o4HqeQwGYmcYLLR6BdcF9zdR8W6yuw8G4vWql6RPngvCWWQS+hfl9j13eUyVJQebnkQaJeP5tIlctF+N/Zs5LvoW7MDEa1QKmPE6AffL3Qb8ZoS1NkolgQRmY0Az7xqq/nrB1mpFSTICTFCO3jUfEmjA4KKwVc+Q3klC08XDoi26l1csZuJMNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jgV/LWeBDD8OqVf8YjsosQzxifjHHUjXGlT/J7EQRmo=;
 b=ORx2mX1Tis21R1mcSEGseyYCkBdUngeQ2moZ+hSsTllKEGuK8zUXPig+l4ciyzvCXcKga0Ija8nseKdlrqNPTrzZB2IqbEsObGVakjwcJ6tiomy1jJY2ZkKoPIXfmjYSHC0oFZvIrlH/AZuilEWf4k949jcBxN78SQajJXWOP6381umvHg+AGz5Jv6iMr4opDrpdp1J0SzqhrcXluAyYjpUv+z+o8gGx1euSm7DxEDAljvtjonAawEKIeKYpY2LOsLvm/wGM6YDzKyixPYI0N/jG4CvaaJ/60USxYgZhD2BcIUk1Pxq+0d4IBXJjeZuShVPP0Q0/1hKmhUmWhm5tDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.243) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jgV/LWeBDD8OqVf8YjsosQzxifjHHUjXGlT/J7EQRmo=;
 b=m0SatcRqgw6E4RK3SvOZT5BwJ8Fp8K1TEnpGsXrwP+m3BZa9VH+0qqjKAF8VflKy52rZqnIZhaZUr6mBkiq2BeUPGaM1eZ/OafpNyaKlzxY+0p7uYzYuLDBM5zAZO0pGxwnP+Jzwek5KKDo45vwuBfqDC+vtSVLyhn1MnO8IwVY=
Received: from SN4PR0701CA0015.namprd07.prod.outlook.com
 (2603:10b6:803:28::25) by BYAPR07MB5190.namprd07.prod.outlook.com
 (2603:10b6:a03:6c::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.23; Mon, 20 Jan
 2020 12:54:06 +0000
Received: from BN8NAM12FT033.eop-nam12.prod.protection.outlook.com
 (2a01:111:f400:fe5b::207) by SN4PR0701CA0015.outlook.office365.com
 (2603:10b6:803:28::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.20 via Frontend
 Transport; Mon, 20 Jan 2020 12:54:06 +0000
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.243 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.243; helo=wcmailrelayl01.cadence.com;
Received: from wcmailrelayl01.cadence.com (64.207.220.243) by
 BN8NAM12FT033.mail.protection.outlook.com (10.13.182.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.6 via Frontend Transport; Mon, 20 Jan 2020 12:54:05 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 00KCs3AF175248
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK);
        Mon, 20 Jan 2020 04:54:04 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Mon, 20 Jan 2020 13:54:02 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 20 Jan 2020 13:54:02 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 00KCs27Z009469;
        Mon, 20 Jan 2020 13:54:02 +0100
Received: (from konrad@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 00KCs2ne009468;
        Mon, 20 Jan 2020 13:54:02 +0100
From:   Konrad Kociolek <konrad@cadence.com>
CC:     Konrad Kociolek <konrad@cadence.com>,
        Mark Brown <broonie@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>
Subject: [PATCH 0/2] spi: cadence-xspi: Add support for the Cadence XSPI controller
Date:   Mon, 20 Jan 2020 13:51:27 +0100
Message-ID: <20200120125149.7607-1-konrad@cadence.com>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:64.207.220.243;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(346002)(136003)(396003)(199004)(36092001)(189003)(316002)(42186006)(5660300002)(36756003)(36906005)(86362001)(54906003)(356004)(478600001)(6666004)(1076003)(336012)(2616005)(426003)(2906002)(8936002)(81156014)(81166006)(4326008)(109986005)(26005)(186003)(70586007)(70206006)(8676002)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB5190;H:wcmailrelayl01.cadence.com;FPR:;SPF:Pass;LANG:en;PTR:unused.mynethost.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0196d123-e1d1-4d74-0be2-08d79da7d54d
X-MS-TrafficTypeDiagnostic: BYAPR07MB5190:
X-Microsoft-Antispam-PRVS: <BYAPR07MB519056EAB6FBE4572689AD5DC3320@BYAPR07MB5190.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0288CD37D9
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QpZvSW7kGw40xxXOxeVbCyTHrHrZnF8B4q4PWCt9tKV/RD+WGZOoTQDyQpCCOncFOJ8QLmupJqhVWyMDiFvtLysYJ1i7DrLlHNT30PLNcr2lUlXzPL1MDr6ZJ5pebNoOYywnr34zJDF+8r9ldrKJ1Y/uz2p9KVwr4TfylyvNvh7u5Hb8Cb+u/WZH/uc4ioHLRI9/CayLDwPnj5IfEK9xx+UDa+lAQ/TctHGO8fit2QPROS7uVzDCO9V4/Fr7kwE5GVRV9iP+KasnSERJ/g1lVpcw3/nVyHZ5voYxQIz6/PXYxte5oPj9R+P8IlCSJqcze25Nxfd3Mu36xCU/8cykl1g5ha309qAZHCGC1BDsBAZwEGJ2baYk74AKjKtrAWWK+InvrC79LE4/6DKYgTf1J1PaS5n3GpTcDsbQmFJQ9W9H993bd/0b2wm9bsVuPRc2d3ETDL5PTQpi7cidDadNcsc9wIQ6zVyEYgd+P6+5SRU1EsQbruppEISMnDc0LdUVghcY+lc0ZWaM/Wg0f/BNrw==
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2020 12:54:05.8460
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0196d123-e1d1-4d74-0be2-08d79da7d54d
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.243];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB5190
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-20_02:2020-01-20,2020-01-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxlogscore=927
 bulkscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0 clxscore=1011
 priorityscore=1501 adultscore=0 spamscore=0 impostorscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001200111
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Driver for Cadence xSPI flash controller.

Command processing
Driver uses STIG work mode to communicate with flash memories.
In this mode, controller sends low-level instructions to memory.
Each instruction is 128-bit width. There is special instruction
DataSequence which carries information about data phase.
Driver uses Slave DMA interface to transfer data as only this
interface can be used in STIG work mode.

PHY initialization
The initialization of PHY module in Cadence XSPI controller
is done by driving external pin-strap signals to controller.
Next, driver runs PHY training to find optimal value of
read_dqs_delay parameter. Controller checks device discovery
status and if it's completed and with no error PHY training
passes.

Konrad Kociolek (2):
  Add dt-bindings schema for Cadence XSPI controller driver
  Add support for Cadence XSPI controller

 .../devicetree/bindings/spi/cdns,xspi.yaml         | 164 ++++
 drivers/spi/Kconfig                                |  11 +
 drivers/spi/Makefile                               |   1 +
 drivers/spi/spi-cadence-xspi.c                     | 895 +++++++++++++++++++++
 4 files changed, 1071 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/cdns,xspi.yaml
 create mode 100644 drivers/spi/spi-cadence-xspi.c

-- 
2.7.4

