Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 268AF3FDB34
	for <lists+linux-spi@lfdr.de>; Wed,  1 Sep 2021 15:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344010AbhIAMi6 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 1 Sep 2021 08:38:58 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:40486 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S245442AbhIAMhP (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 1 Sep 2021 08:37:15 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 181A6urd025974;
        Wed, 1 Sep 2021 05:36:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=f78AL0IT2V+EYQMzvjJcgruMVloDWcKVnJC+ddGZnOo=;
 b=SiTAaVtoReoXOw232iqBJNuOxElgUrEkbaGDHKDDKWQhB1mCRA/oAlV0hnHAWQpivkP8
 OuCfd9Jo8NpgZXPS+a/NDzG+VSbjyatZkzRe+so/Cw0UHDX2mqoXO4Gdyw5c5q6kB/eA
 EzAQzuafmxwBWfy6rPCLSzpzUBZjA89TVR5CNM4dcNhlI7z02BjIY4R2f6AVEvNgmhyJ
 +0yEIQM3o5GA5NCv6dZ8yCSGZQ8vTI/ZbYcdBD89RRWzlN8kyuvfPvL8d1S9tKxjfHOU
 1gijEeM/kGFCGmp4tb1+TOppCkjEbgXdMWyeXtGiK9Ca8nOHGKhNtjOL/XgMh1E8Te4W CA== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
        by mx0b-0014ca01.pphosted.com with ESMTP id 3asd40nkqv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Sep 2021 05:36:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XFDQ2SYy9Mdf321kY3L0aQKEy7PSv+m34EYAD8QmIAOq1YoIPRKzbp5wNetIswLVs/BlTLHPin7rnYAByFq+mTXoXzrJTjwRxPmPe7SSPjnJP1nFBCgtpv078OarV0mfImXbfbNzxL0n5pTLSG8UXEDGWsvzBEUleSmBZQfaz+3nguPZQxy6OP0P35YGmPSjask8gFou8cnW27uKZGIS7MVlDx2vVdw47OEBCivGMYhskIsZ6EA5p0E0hgo4O4UVdLM3f4HdFPBNc0ZqB+Lvo+PHa6fUQmUreSD1W8rrgez7s0eujY9RWQZOP6ArPo78o1zBBrXJH2+0SzcXIYWMHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f78AL0IT2V+EYQMzvjJcgruMVloDWcKVnJC+ddGZnOo=;
 b=jZ5td2dxGgr66fWUEhP80dyRPtCoSp2Q/ynhw2wkEK5Qqdj4MjUpJ1mxfcLjGoQ4vwoq1PMYcDPCl1h/DDJHBePizs9mfczTZWisVoYEOahwTSdc/N+s9SKHRqwmDlXMW2qY/rt8JypskHRO0z6HEp38/V3i3stX3/nawtSQc8bUaNmGkzHyAGWTc5GD3Ts9ILHQHyB0s80qxFSIukvZB5EEQVezB2e4Wh3D5NA4nniwa+cp7ClBq4gzmi1bW/5srrQJ3tNX/a69y5QOfCUnWcyvSRxTaIoZdXGPZOWST/99JKwqMYzBpvpvUhM+2cJebRiomGBYfE2sIZbgWdhP3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 158.140.1.147) smtp.rcpttodomain=ti.com smtp.mailfrom=cadence.com;
 dmarc=temperror action=none header.from=cadence.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f78AL0IT2V+EYQMzvjJcgruMVloDWcKVnJC+ddGZnOo=;
 b=J/Tji4U7j7guqx1VoGSfQhESVZFBbfHBEt32Xh0fDJxqLVJ9+aeP++RwksPK/W3m7IuKRG4qAkMucibSvsXBoKIfL9e+Nmc44gmzYWKiNqf3BoY2hQihvGP0glOby+us+0WPb0az0LMo0II5+X6fw0n6pEZItAIqgg7uSNICkhQ=
Received: from MWHPR04CA0053.namprd04.prod.outlook.com (2603:10b6:300:6c::15)
 by BL3PR07MB8899.namprd07.prod.outlook.com (2603:10b6:208:35a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Wed, 1 Sep
 2021 12:36:06 +0000
Received: from MW2NAM12FT037.eop-nam12.prod.protection.outlook.com
 (2603:10b6:300:6c:cafe::15) by MWHPR04CA0053.outlook.office365.com
 (2603:10b6:300:6c::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.17 via Frontend
 Transport; Wed, 1 Sep 2021 12:36:06 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 158.140.1.147) smtp.mailfrom=cadence.com; ti.com; dkim=none (message not
 signed) header.d=none;ti.com; dmarc=temperror action=none
 header.from=cadence.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of cadence.com: DNS Timeout)
Received: from sjmaillnx1.cadence.com (158.140.1.147) by
 MW2NAM12FT037.mail.protection.outlook.com (10.13.180.185) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4478.8 via Frontend Transport; Wed, 1 Sep 2021 12:36:05 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 181Ca2b4001877
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 1 Sep 2021 05:36:03 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu4.global.cadence.com (10.160.110.201) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 1 Sep 2021 14:36:01 +0200
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu4.global.cadence.com (10.160.110.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Wed, 1 Sep 2021 05:36:01 -0700
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Wed, 1 Sep 2021 14:36:01 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 181Ca1sH018795;
        Wed, 1 Sep 2021 14:36:01 +0200
Received: (from pthombar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 181Ca0NT018794;
        Wed, 1 Sep 2021 14:36:00 +0200
From:   Parshuram Thombare <pthombar@cadence.com>
To:     <broonie@kernel.org>, <lukas@wunner.de>, <p.yadav@ti.com>,
        <robh+dt@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <jpawar@cadence.com>,
        <mparab@cadence.com>, Parshuram Thombare <pthombar@cadence.com>
Subject: [PATCH v3 0/2] add support for Cadence's XSPI controller
Date:   Wed, 1 Sep 2021 14:35:55 +0200
Message-ID: <1630499755-18751-1-git-send-email-pthombar@cadence.com>
X-Mailer: git-send-email 2.2.2
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 55a0132f-1b25-4ce1-50e0-08d96d451125
X-MS-TrafficTypeDiagnostic: BL3PR07MB8899:
X-Microsoft-Antispam-PRVS: <BL3PR07MB8899C5B38683B30DDA708287C1CD9@BL3PR07MB8899.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: omO4hUab86SpoPCHDrA5KlLD7oMFZWmz4MtvUygyJy94q1r4nftLzy28GWm7+NX9FqWAxQ+ITdfqrbLqYPsWfA+unD2kzfOi5pLpaPAccEAsmIzpqLw/JgUxkVxXvHbeW7rAkFCYQQ+qqZKJqb9mgJQIFV+ySIkIPCbZsgMVhsqOxxoZvHbEacA9JAtO7MeIGFNN56K37liCkytiX9Exzmf8HvEh7anYJlcRfbX1cSAJeukw5IhoooSCKrsyefqKAXgx6Oj7APQkFzny3+WrtEWo8kd9os+xbYM4Nui04DQf1ZcI28fWIRaoDkFXFd1NlK8PNwjIK2KtRkjey/7HpR8Pe4L2e5mirOH6E6zsnINGd7yk086ID9b1v5a4XcFQb+0nzkZNHacEtyqN9vy2i9AaUum1uSqPEJtwQhupSXeCwylT016zIZjqJrYyvbEBPxUTtJiuKehRFzyD0wPEYCPxSmA2MxHya1rbj9xlRjp7LPVdQf4T0Wz+1dFm+1F+PWlV1xwziVOQgf5z7xnu+Qt+UspceqQzdH2HE5vW+0QZsKGwrX6kFajHpBhS+ZhzVDmkG13/5hOkwgC3uCheUm4E+zG/X2aawjz8cl0kX+gwu184b81exroyo5kkExaeEKGCmbDKndBFs3ixrThhdMjYd6rI7xdW8bNx6XTTJwLVZSZYWxdXNUnp2wnsYpw6/3PuOxxusPPURKmEQgPhEbRKyWFO+CsqUuDGLi7V69c=
X-Forefront-Antispam-Report: CIP:158.140.1.147;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx1.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(136003)(376002)(396003)(346002)(39860400002)(36092001)(36840700001)(46966006)(70586007)(36906005)(42186006)(478600001)(107886003)(8676002)(2616005)(70206006)(356005)(6666004)(316002)(63370400001)(54906003)(82310400003)(2906002)(7636003)(186003)(4326008)(82740400003)(47076005)(36756003)(63350400001)(5660300002)(36860700001)(26005)(86362001)(110136005)(8936002)(426003)(336012)(83380400001);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2021 12:36:05.6895
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55a0132f-1b25-4ce1-50e0-08d96d451125
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.147];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM12FT037.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR07MB8899
X-Proofpoint-ORIG-GUID: MFKeH1HrBYTb1K3IM0F6Pir3giY4LggU
X-Proofpoint-GUID: MFKeH1HrBYTb1K3IM0F6Pir3giY4LggU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-01_04,2021-09-01_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 mlxscore=0 spamscore=0 impostorscore=0
 phishscore=0 adultscore=0 mlxlogscore=524 bulkscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2107140000 definitions=main-2109010075
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
Currently ACMD PIO mode is used for NOR flash read, program, erase
operations, all other operations are handled in STIG work mode.

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

 .../devicetree/bindings/spi/cdns,xspi.yaml         |  66 ++
 drivers/spi/Kconfig                                |  11 +
 drivers/spi/Makefile                               |   1 +
 drivers/spi/spi-cadence-xspi.c                     | 837 +++++++++++++++++++++
 4 files changed, 915 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/cdns,xspi.yaml
 create mode 100644 drivers/spi/spi-cadence-xspi.c

-- 
2.7.4

