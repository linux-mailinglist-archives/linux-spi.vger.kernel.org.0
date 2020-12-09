Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC0F2D3C8F
	for <lists+linux-spi@lfdr.de>; Wed,  9 Dec 2020 08:59:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725953AbgLIH7b (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 9 Dec 2020 02:59:31 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:23364 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725942AbgLIH7a (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 9 Dec 2020 02:59:30 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0B97vKFX029164;
        Tue, 8 Dec 2020 23:58:24 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=hAn9QRiQLlv+e4+ZcGiTwPXpxp4i+wxQWgmSNb6Sbrk=;
 b=OzO63BRsDXtkasFYw0nXlylC7rZqTxcbDHGnkm18Fv43k0jDovTY9mZUgkmIZucVez7T
 0IRmX2AGqqKKRKmEvtbZ+KUGIpeyPoClIXlEFWaLob+9Mr9W8/s7U+GFwDsTGbfqPyYn
 PDF4yNlxY9Apys6JA0HEXv/r/kovHmbwmdGvEFDseZZBqbawguVKaken7dg3IRANzoW0
 OAnbqQ++9K96n1SoFcfbp6qFq0qNouid1N1HMlnQWHDE11CWtDxLTkAYm8gHXQbuxMMQ
 /hbxN60KCXaYoF/QA/ddrKj+YMkpy7pJjcOL3BfoDCjHZ7xwuav9ugp6/mcXq+Ow+zAv Iw== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by mx0a-0014ca01.pphosted.com with ESMTP id 3587n2v16b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Dec 2020 23:58:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aJD72eGxNAivujY+I/Ra3LkCPgohdAFY1zHNbiguuS45q/YAHrPLMMJTZecyWbfnDlyfrHWujeqRbXzXXCTIXpHZv8oiczFwrEuiPXpg25HhfLOX0207vsONWIn9hjHkDIJjIJusKl/Ta+eaKpa3GbfZX3dzHno3hM0N3oUonDix2PbR6oWbswSsS963f2vaq54I2Rw+veN1tKrjnJQMsmTSutYVj0z9g8tdPMqEnwfv/b5SOJ/XpCbrdSfRQ+Zqzcf/HHTbh3ffW0f6v/XpFNZAMhovLMOIhi4jBCpZ9T3/0HdIlCYpGO/BAb93M5hIfY0IdmcqtNksKxnvyhIquA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hAn9QRiQLlv+e4+ZcGiTwPXpxp4i+wxQWgmSNb6Sbrk=;
 b=J+ZV9mDeafh0Th5xblwl/w6my/5q4hNuqTHc1o2iTs/HYaM5eu+2s5Qdb58a30+DNwepUyRkJZelQ3lU3LzrVxhIpyoBl+v/frAZyz2hYy9PmOufZeHCoR+fJ4fULS1hSGT6iZWDe+q2AxgMje9D4V48GKTAibphIrhy+lNiyoXKUHjH0B6f/rup54wAs/4DoFBRdpGjdk5bdsFbLU81gFMN0kCpEo9G4BC69ovdLJZsZ8fk3C26KJL2qER5r74dEScPSwHb0OnmC9jKWX3M6CYDpwh9geN6Uew9KznRWtu5lLzBRVKP+qsOKeneOjiCb9GRZ+ZP7sGkBsihy0r5Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.147) smtp.rcpttodomain=bootlin.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hAn9QRiQLlv+e4+ZcGiTwPXpxp4i+wxQWgmSNb6Sbrk=;
 b=POQ1ucaN35Wls/0zeM6t45H8qAz4+ZtbjZLoQFJKIxgp5J66QBk7TxFaWSqxyzUW1DGA+ltT9RxPfNhaNnz0AH26RAHbePBGuBHTP/SOWocZ9egfh8YpTzs3OW/Fv9F/8kctNEkr/LC7d5/VZ0hFAgHKXioxhQU2lzGaEvZAHTw=
Received: from DM6PR02CA0145.namprd02.prod.outlook.com (2603:10b6:5:332::12)
 by SN4PR0701MB3808.namprd07.prod.outlook.com (2603:10b6:803:46::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.21; Wed, 9 Dec
 2020 07:58:20 +0000
Received: from DM6NAM12FT043.eop-nam12.prod.protection.outlook.com
 (2603:10b6:5:332:cafe::29) by DM6PR02CA0145.outlook.office365.com
 (2603:10b6:5:332::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend
 Transport; Wed, 9 Dec 2020 07:58:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.147)
 smtp.mailfrom=cadence.com; bootlin.com; dkim=none (message not signed)
 header.d=none;bootlin.com; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.147 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.147; helo=sjmaillnx1.cadence.com;
Received: from sjmaillnx1.cadence.com (158.140.1.147) by
 DM6NAM12FT043.mail.protection.outlook.com (10.13.179.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.10 via Frontend Transport; Wed, 9 Dec 2020 07:58:20 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 0B97wFQ8002826
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 8 Dec 2020 23:58:19 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Wed, 9 Dec 2020 08:58:15 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 9 Dec 2020 08:58:14 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 0B97wEhr024497;
        Wed, 9 Dec 2020 08:58:14 +0100
Received: (from jpawar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 0B97wEt7024496;
        Wed, 9 Dec 2020 08:58:14 +0100
From:   Jayshri Pawar <jpawar@cadence.com>
To:     <linux-spi@vger.kernel.org>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-kernel@vger.kernel.org>, <dkangude@cadence.com>,
        <mparab@cadence.com>, <sjakhade@cadence.com>, <jpawar@cadence.com>
Subject: [PATCH 0/2] Driver for Cadence xSPI flash controller
Date:   Wed, 9 Dec 2020 08:57:56 +0100
Message-ID: <1607500678-23862-1-git-send-email-jpawar@cadence.com>
X-Mailer: git-send-email 2.4.5
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e5f60e01-5101-4dfb-7792-08d89c1831f6
X-MS-TrafficTypeDiagnostic: SN4PR0701MB3808:
X-Microsoft-Antispam-PRVS: <SN4PR0701MB3808804A43FE56C812D95CD8C1CC0@SN4PR0701MB3808.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ppqlCTgOthnl6Fg4ObCizRJjtAuBSR6KoGPTyWC1/LMdlt9WbuMiBfom0Z1e5BgckC0PB3dVtQDT3BYLwRHC+lPyrd7NZxWcxR339YSN2Q7jN94PGJYoJvgsqrhcNxdL7q+1WJ77GsxBEderglzvsHYVh/d6AQcCO0/m+iuwTjCKely0f4KBPvw5lp4nqToSaVokQOXgHibmdRAG18z0QFpjkwtAEIeq2mXLjR5auUPNNz0jutRgJADY2OigthXaqnvM5patrjTG4Y41pEalF9gbHFySvcEvEnzMLxEwwSX5I29gZC5CIX7eKFe27TpybPEc0OGEOrYjMMQ34gOLrPrPU/SdD9cZF1jU4MdXt8TgRHrY0ygJh+R4NakWLK755gyhBRAVe93nWd7ejFpgoU73gBYLmhQm9eefAKoktQoIJF3rXOuBFVdqm6DjoJiI+bUyWkuxX5yRB74YK5XDyQ==
X-Forefront-Antispam-Report: CIP:158.140.1.147;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx1.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(36092001)(46966005)(70206006)(86362001)(8676002)(508600001)(36906005)(70586007)(2906002)(54906003)(2616005)(36756003)(107886003)(34020700004)(82310400003)(26005)(4326008)(8936002)(6666004)(47076004)(7636003)(356005)(5660300002)(186003)(426003)(6916009)(336012)(42186006);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2020 07:58:20.3369
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5f60e01-5101-4dfb-7792-08d89c1831f6
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.147];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT043.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0701MB3808
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-09_07:2020-12-08,2020-12-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxscore=0
 clxscore=1015 phishscore=0 mlxlogscore=819 priorityscore=1501
 suspectscore=1 impostorscore=0 malwarescore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2012090056
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

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

Jayshri Pawar (2):
  Add support for Cadence XSPI controller
  Add dt-bindings documentation for Cadence XSPI controller

 .../devicetree/bindings/spi/cdns,xspi.yaml         | 164 ++++
 drivers/spi/Kconfig                                |  11 +
 drivers/spi/Makefile                               |   1 +
 drivers/spi/spi-cadence-xspi.c                     | 894 +++++++++++++++++++++
 4 files changed, 1070 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/cdns,xspi.yaml
 create mode 100644 drivers/spi/spi-cadence-xspi.c

-- 
2.7.4

