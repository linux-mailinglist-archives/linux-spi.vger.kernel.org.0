Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8A433B768D
	for <lists+linux-spi@lfdr.de>; Tue, 29 Jun 2021 18:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbhF2Ql0 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 29 Jun 2021 12:41:26 -0400
Received: from mail-dm6nam10on2081.outbound.protection.outlook.com ([40.107.93.81]:13633
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231512AbhF2QlZ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 29 Jun 2021 12:41:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YzERABg8G1FoVZx9v0VKfVXbmIEdgqz5ZBiV+1kHNLisw3SxehAcqDtnazRWoUWqfEKurXHbJO3w1cYhojcjCQzS9Sycs0rldn/ymMT0/KCXGFCAB+Za+Wotqmp3OxG7jlGAcmZ3XtjkBkvmu3tPWtQ66ghs2oRxp+0uvzRhQ0MkHUnF1D9s4tR/4VGHhlxv1oRc56DFV2Xk3WWQ0pme9/OU1w+zvfgVpHtKowixnTYWEgWArkcJeJmK05KLKEEfflN48AWS6/eZ5a3CFDUKm9MqUkCI+XgH79VRwxS4zTubZ12CN6gnwIHXS5sQQSLsij0s23QkITpVDFonU9+/YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PfiIYroj2sTljfvqMV6NuAxVCMQbXWYuBSkWAZCpPeQ=;
 b=XIF0EUehQ1keA4n/7ytDQL1IcgkEOlVwgN+N9ImcoNMAfYbxlB0Y9wWcDSSgS1+O3cC9NseAcYhig87BEBUuvNAp2xl0eKFxqk8TcRI6FDFPreLttFkHa2nC4oxSJ+FeQDWqmR7TDKwE5RxVknfnlWMnN+HxAzBK5C6+cMG4k9xGa7xV6lZ0JLBt9VO63q5ibtq0Kwm8JJbCDKY6jjS1vFN6RJq+Hn5e3+GNzTPCz6KtJNZMwxo5utne73Y6ak0VK7EMTzXfKxGF1aZsPGMTXH3MynXuM2k5uuwkt2Nsm60MkxIwaSZWrdUip1lybLAhttSzuz6RssU6jKfUb5WYVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PfiIYroj2sTljfvqMV6NuAxVCMQbXWYuBSkWAZCpPeQ=;
 b=Eupit6c6vXPdCggZJUjbv4Mq4f53OGYbMRxu39S7ecDJlDy0PXwBxjOj8q4F82Rjn0cg0f7x07qiW8O+5T+uvs+M5v3O+YMwRwCw1gmLEEyH4IIT7dHtM0ixSAFxv1Neo3Eyda/TG3VHxTQfgDR0bM5O29MQfs5JyJMc5t20AA4=
Received: from DM5PR2001CA0023.namprd20.prod.outlook.com (2603:10b6:4:16::33)
 by BN8PR12MB2995.namprd12.prod.outlook.com (2603:10b6:408:41::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.24; Tue, 29 Jun
 2021 16:38:56 +0000
Received: from DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:16:cafe::ef) by DM5PR2001CA0023.outlook.office365.com
 (2603:10b6:4:16::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22 via Frontend
 Transport; Tue, 29 Jun 2021 16:38:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT048.mail.protection.outlook.com (10.13.173.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4264.18 via Frontend Transport; Tue, 29 Jun 2021 16:38:55 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 29 Jun
 2021 11:38:53 -0500
From:   Nehal Bakulchandra Shah <Nehal-Bakulchandra.shah@amd.com>
To:     <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Nehal Bakulchandra Shah" <Nehal-Bakulchandra.shah@amd.com>
Subject: [RESEND PATCH v2 0/2] spi:amd:Support for new generation of AMD SOCs.
Date:   Tue, 29 Jun 2021 22:08:32 +0530
Message-ID: <20210629163834.581774-1-Nehal-Bakulchandra.shah@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b71845c0-8c89-4d45-1689-08d93b1c6333
X-MS-TrafficTypeDiagnostic: BN8PR12MB2995:
X-Microsoft-Antispam-PRVS: <BN8PR12MB299551BFD0E009991D3FBBB1A0029@BN8PR12MB2995.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o40RhMuOBlZRd86dnIQ9hEnqHBqeNwbsNPK/XBoPTJVaXe5GTnit/q/eiqKkM02oZDA5F3vhb2B65Ar5gHnEBAneP3DfBEwxprdHOZTsERbBmDRxUOFVX2fEbHQ81W1QWCvC5cU/+c1HTCjsoUp+Y/+gBkC6vwf3kFeb04NOCJoRYhEO2DhJxZ8ZAjTxwvq2Jm6WvOdgMByPKUE1wlpRe3h9CGr3M7p7J3NrQ8KmO09humPe/rFS/ExjVaKA9+W8R5pXeAv4oKREnQ271jGFSUQYLOW6etSDjzw9dyNClOZtEI1ucHKfHb4UBmOppU6uy7NfUWJ6+qlthLxo+oed0mVmDg5jQso7JywxltSyGZgg7U+l9p3erG4RQfuB2iUzQK4KTLcLljarVeSGIirQYjYHlUXOvAzy2ZkjapMkKVhjCbzz7IXKmRckClZo36VqTOqwphqpgyjU/iOoeNsHzu4u3J9q3I9PaC7iriyv0rMbIVQHiO+674EMNzEVrIi9vWyM1EZ0VDDPUzSaNvOeGEllwdf/CKpOABQ670KWHg71uEjT7xmAcWvqxKOlpBJ+c6bRNtVld66pd28oG7e4to23G5eR3EQmaWK9bTsz3Ht9j6XsP4HmNJ+NCg0nP4OcPLpHMiKWi47bAhCkJXG6p1LWQRr1ajY3hHxYEnz4lRDPtNUKAAYo1+vydi/lPpDRHO1XpWgcINgIyu2/gre4qcOqDk/tZJqL42QerdfTp8c=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(136003)(39860400002)(376002)(396003)(346002)(36840700001)(46966006)(5660300002)(81166007)(336012)(426003)(4744005)(316002)(4326008)(2616005)(26005)(70206006)(36860700001)(54906003)(1076003)(70586007)(47076005)(6666004)(356005)(8936002)(16526019)(7696005)(8676002)(83380400001)(36756003)(478600001)(82740400003)(186003)(86362001)(6916009)(2906002)(82310400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2021 16:38:55.7912
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b71845c0-8c89-4d45-1689-08d93b1c6333
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2995
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Fix for limitation  of max 72 bytes size of fifo transfer.
Also, new generation SOC support added with modificationwith register
and few of the helper functions.

Changes in v2:
-Split the patch
-Incorporate review comments

Changes in v1:
-Initial patch for adding support of new generation of SOC
-Fix for 72 bytes of FIFO Size

Nehal Bakulchandra Shah (2):
  spi:amd: Add support for latest platform
  spi:amd: Fix for transfer large size of data

 drivers/spi/spi-amd.c | 149 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 125 insertions(+), 24 deletions(-)

-- 
2.25.1

