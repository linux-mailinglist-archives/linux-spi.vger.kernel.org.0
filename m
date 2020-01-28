Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB04C14B456
	for <lists+linux-spi@lfdr.de>; Tue, 28 Jan 2020 13:41:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725926AbgA1Ml6 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 28 Jan 2020 07:41:58 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:59454 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725852AbgA1Ml5 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 28 Jan 2020 07:41:57 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00SCbkdK030982;
        Tue, 28 Jan 2020 04:41:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=H7XkXAP62BHAxe9CssuBwEn/jjnBV+MUwHphl2+ZxRk=;
 b=W/F6uEsQ3j2676N9cIRFr37ES8PyM1dPz7V+XdN4qwy5P4nN+K3ZmlzBmuuSe6t2JrPQ
 UN6dnhkoY1I9i5v7DI8bk4Mku1Zd2EnBCh++x4Z/LzoakOinVgkSLKN137UUL/xpGl6V
 8gN+rBUx+vbx4cbxM7yWx2YU0wxq1mH7Uq+nsiMvW+csVOwSk8EWIZ57IUDbLYI3yffJ
 wAlMDgZwE2gAmPVR/3LPVN4dLs5K1TVRl8z9VN6beFVU7QiRYMxmuMFm/+lGMyWsx+vb
 tj3tM8giiDdYLYSd/HS96GKNDDtYFK3D3YcCTIj7VnXq0HK+JhyNItcbwgTdXbXnmddp KA== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2xrk442y3q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Jan 2020 04:41:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SozKlyJKCFRgNjks6RFQoBROZcNxBOLL6LX4RdzC6ooJZBg0FT+rC6D5T7hUIUR1etlYY4596vmQSnrYPRhSl4M+HjxLAmpdZ9DalSQGe7Vm6tlbFbNZlmRo5Y3IfZyXHfLLhmzyhtwEUC0xa1jgWLZ+5Bw0zIZmV83ALygdnhXAA8tJDpEhskEdAKOJyF0e3TeaDYsqIKJniQMd99a4jGUbo66B+3HAwTYRNPe9LFHrlVml/lTc7Wk16wmWPYnTv0pmKv9XEs/zIN3CgT60EQzwY7CECKJTuOK+GpYV3GXCmiaxj5e4rLiAztZvXik/gldbg83gSPTadCpLXZWqhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H7XkXAP62BHAxe9CssuBwEn/jjnBV+MUwHphl2+ZxRk=;
 b=jgClifViVC5QnyO55+IFLgmFeWhdy3TK2UTteXSrs7EW/Wn5aesGbAWJf+T4Z87e61CAkWup1IxaLoQvD6xJbNUdRHPbneAD1HpYZ0n9jgMXUSD9wFOSPFneohDbHWWaXl4mptpOmX+tgzer+/SYBxzznxK0fALEQsKs4rCp4PIN3sIdRChL94smO9f6fieSqSaGUaDYz/9E4kk9HLC+r3vedR8wql4e3d83uc/obW6N1iwaGxhAi5G4+0zxGj9QQh9xvGgg0RJ92F69GkS4xi6L3ZAn8A+/m76yMl1zyPnpJgbzljMxXgGU5NMjahvL6LkFc7gYCqZu4/vMiXlUBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.243) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H7XkXAP62BHAxe9CssuBwEn/jjnBV+MUwHphl2+ZxRk=;
 b=AOchz/8VTveu7iDoJAkrUNK1jcy53OtrHdIgRuUNBBL0Y1cc89hyRB6F1CxZv9yWgSUCnUYHm+TtJ2aPRZ5SbcA/Ry1EiwEI7+iN0YV/yDnjoW4jFRoffiteIJUdeWwBRjmxv7vTozyCU6xmMcO+GeMN+iXWAjEVTGkw8RmAbxw=
Received: from DM5PR07CA0062.namprd07.prod.outlook.com (2603:10b6:4:ad::27) by
 BYAPR07MB4295.namprd07.prod.outlook.com (2603:10b6:a02:c7::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.24; Tue, 28 Jan 2020 12:41:50 +0000
Received: from BN8NAM12FT055.eop-nam12.prod.protection.outlook.com
 (2a01:111:f400:fe5b::205) by DM5PR07CA0062.outlook.office365.com
 (2603:10b6:4:ad::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.22 via Frontend
 Transport; Tue, 28 Jan 2020 12:41:49 +0000
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.243 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.243; helo=wcmailrelayl01.cadence.com;
Received: from wcmailrelayl01.cadence.com (64.207.220.243) by
 BN8NAM12FT055.mail.protection.outlook.com (10.13.182.252) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.12 via Frontend Transport; Tue, 28 Jan 2020 12:41:47 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 00SCfhVB023491
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK);
        Tue, 28 Jan 2020 04:41:45 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Tue, 28 Jan 2020 13:41:43 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Tue, 28 Jan 2020 13:41:43 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 00SCfhbp012258;
        Tue, 28 Jan 2020 13:41:43 +0100
Received: (from konrad@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 00SCfgY6012256;
        Tue, 28 Jan 2020 13:41:42 +0100
From:   Konrad Kociolek <konrad@cadence.com>
CC:     Konrad Kociolek <konrad@cadence.com>,
        Mark Brown <broonie@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>
Subject: [PATCH v2 0/2] spi: cadence-xspi: Add support for Cadence XSPI controller
Date:   Tue, 28 Jan 2020 13:40:29 +0100
Message-ID: <20200128124042.11469-1-konrad@cadence.com>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:64.207.220.243;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(396003)(346002)(376002)(36092001)(189003)(199004)(81166006)(81156014)(8676002)(356004)(6666004)(8936002)(4326008)(2906002)(86362001)(109986005)(42186006)(36906005)(1076003)(316002)(54906003)(70206006)(478600001)(5660300002)(186003)(336012)(2616005)(70586007)(26005)(426003)(36756003)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB4295;H:wcmailrelayl01.cadence.com;FPR:;SPF:Pass;LANG:en;PTR:ErrorRetry;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3ab1ddc0-f910-4c59-6b71-08d7a3ef7052
X-MS-TrafficTypeDiagnostic: BYAPR07MB4295:
X-Microsoft-Antispam-PRVS: <BYAPR07MB4295D969CE22A903AE0B7F83C30A0@BYAPR07MB4295.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 029651C7A1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cnoutwuOSUFG8+mJeHUYnzaTeRpkLEY6LspIvieOZKwpBoPJgOy783FT1V3URz+h8AM35M9bHIFnTqiPSfb6D0HNu1Som8d5sbff2L/YrhTppyWSsWXwpm1oCORZ3agYBKfjni8HzPcMH8iWDd4zRYafFJ6Djju4ZNcteKM1chWNafCmhzhuPeKhW+8sJzuTmaB/HZOlaJru/oI76TGB3/eKRmlDtSZviShOgK8MOXj84zpl1BK/7BKKr3wE0qOczHLimFRhf3HS3mM0D4BpvzPae9Xb4Grmb5s+RtZGdAKBv6BVK4czazZ3czBGINh5qlrJXVFK+8d2n93CITUId2Cwt496qNgYVa3yWkxs1FvbSOgaxWytA9w8IVZimJ/yccsJOW102KKX9nqsMqsf6sEUHYShA9miVtqC76aRbD0v0+uTBNWzGH2U+Ii8wIHmYCJIUAzpEMnZapKTYPXsWIGCmWpGS3u070jlRh66MwW6lfAMnW7F5d7FdIykU7AnDUDZWbRCLr2c/zWpyp1QYw==
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2020 12:41:47.1716
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ab1ddc0-f910-4c59-6b71-08d7a3ef7052
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.243];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4295
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-28_03:2020-01-24,2020-01-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 malwarescore=0
 bulkscore=0 clxscore=1015 suspectscore=0 adultscore=0 mlxscore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 priorityscore=1501
 spamscore=0 mlxlogscore=983 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1911200001 definitions=main-2001280102
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

Changes between initial version and v2:
 - fixed device tree schema yaml file

Konrad Kociolek (2):
  Add Cadence XSPI driver
  Add dt-bindings for Cadence XSPI controller

 .../devicetree/bindings/spi/cdns,xspi.yaml         | 166 ++++
 drivers/spi/Kconfig                                |  11 +
 drivers/spi/Makefile                               |   1 +
 drivers/spi/spi-cadence-xspi.c                     | 895 +++++++++++++++++++++
 4 files changed, 1073 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/cdns,xspi.yaml
 create mode 100644 drivers/spi/spi-cadence-xspi.c

-- 
2.15.0

