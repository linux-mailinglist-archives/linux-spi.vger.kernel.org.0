Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 309FC1BB590
	for <lists+linux-spi@lfdr.de>; Tue, 28 Apr 2020 06:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725885AbgD1E5J (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 28 Apr 2020 00:57:09 -0400
Received: from mail-bn8nam11on2085.outbound.protection.outlook.com ([40.107.236.85]:60256
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725792AbgD1E5I (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 28 Apr 2020 00:57:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JxsYYpg/rfXH7j2Kq/9Iqg442hA1JmDsUhV8NsaQCNsULNDYgSR/W1D45tWsLD9Lcke/Ytsd67ydyShesgPFXRo2gx6htQjhxX6rbQVn0zc9Iq1ntje4Xg5xUEO4HD8JAOpCSKuDXlKyCVnjfj2Pe7zP2UZY2agcFwPSOWSZrYMCGEBDM0JeiMZzOU77sBsZTb4whdgVh3HmbOV9rXHER0rcwFYqAb9eOQMBxjccDmlhl68emt+JZ/J/CHShsjKOWATw8mujAr5W1RWV9htJnZlihNyDzP5EuAZ/96sPHZn9SaO9TmW6yFjTBxnxRBk6n+2rcXkzFyA7wyDUe9iXtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p1Cl+HOncr1tWD8IukC1z5Zq/CVoOIYvUCRFoH8zKic=;
 b=jTmProyBwa56i7Nyr7ZsFtal3TMGalbCFyVNDKHb185U0VwkE2936kF32+bKc87ogXQdXCIaWdJO4Va/NGt4JnmYSEnqK+39LU2ZbK8KvUe9yahXcYPQRAvkJxN1yaxx8hqwr6vr96pCAft7eZ1iklLW7ykD3aTvZxPb1Hjpe6k8Rqlj31cWGOVYdVqHoDroFNG8ETxvxqe2fUOPZbMJMtd95Doyh4H1tXmHAups1n3TEfFly2qV9lt0dlmGLA91ntfF9eHH2+UeH+vzU4m/69F2db3SueWZ/uDGEz8lBYqERP+eDjRAxZBVnUTDF+S6iNaKzYGgsdDHdxWYWIInrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p1Cl+HOncr1tWD8IukC1z5Zq/CVoOIYvUCRFoH8zKic=;
 b=Xl398myj/cmwtbZpe7kKaKWb/RHs4Iz+uGYj7/nBr4YBxMV9mTIgSZJuDkC95OOnkq8i+UHfJq52iCiXEEyDOYO+q68xszphj3Hf1fiq+DXO6R7nlMlZs1x7GbcF4tUzOMjsvlJ52yll6PkJJAPBfzKrEE3wK27kfEkg3IG2OkA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Sanju.Mehta@amd.com; 
Received: from DM6PR12MB3420.namprd12.prod.outlook.com (2603:10b6:5:3a::27) by
 DM6PR12MB3499.namprd12.prod.outlook.com (2603:10b6:5:11e::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.22; Tue, 28 Apr 2020 04:57:06 +0000
Received: from DM6PR12MB3420.namprd12.prod.outlook.com
 ([fe80::7545:386:8328:18a0]) by DM6PR12MB3420.namprd12.prod.outlook.com
 ([fe80::7545:386:8328:18a0%6]) with mapi id 15.20.2937.023; Tue, 28 Apr 2020
 04:57:06 +0000
From:   Sanjay R Mehta <sanju.mehta@amd.com>
To:     sfr@canb.auug.org.au, broonie@kernel.org
Cc:     Nehal-bakulchandra.Shah@amd.com, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sanjay R Mehta <sanju.mehta@amd.com>
Subject: [PATCH] spi: spi-amd: fix warning
Date:   Mon, 27 Apr 2020 23:56:41 -0500
Message-Id: <1588049801-37995-1-git-send-email-sanju.mehta@amd.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MAXPR0101CA0014.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:c::24) To DM6PR12MB3420.namprd12.prod.outlook.com
 (2603:10b6:5:3a::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sanjuamdntb2.amd.com (165.204.156.251) by MAXPR0101CA0014.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:c::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2937.13 via Frontend Transport; Tue, 28 Apr 2020 04:57:03 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.156.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c5261db7-c12c-4f1a-6f0d-08d7eb3098fa
X-MS-TrafficTypeDiagnostic: DM6PR12MB3499:|DM6PR12MB3499:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3499357EEC5A14E9E891E60FE5AC0@DM6PR12MB3499.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:243;
X-Forefront-PRVS: 0387D64A71
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3420.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(366004)(396003)(376002)(346002)(136003)(4744005)(86362001)(36756003)(7696005)(16526019)(2906002)(52116002)(6666004)(4326008)(66946007)(66476007)(26005)(478600001)(956004)(5660300002)(66556008)(316002)(8936002)(8676002)(2616005)(186003)(81156014)(6486002);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RUtnW0yPlqgepKLuuWJ20dsmRElDysqEVJ+t0Yo7l6MFTLj35QqqWOye69PrJoIE7fA30MRjmAQ+nO+9CjcynRao3LzhovVyX1E5pUyEk88Zyxbb3f5yQp6t6aksrcISc1i2v5zQSQbncseZFPj7KxHEgEF2ag9qGOJgSHWDrR8spRgvvQ712ukJHzteo8kaW4cqvYOuSeTUSjt3cZ9+ECNaIfK0gmbTg3qEnYLEejFb4iijmvoPvP4T0J6P7afSD14QQcpD8r0Sivxe5wEuO0Ev9BzmuiJLQA6T5BAsu/vfm7gIrJ0S+pBNgjn1HM98YF6Ij8icPPJj1x3dZlhKQ2+Xft1yvLCIiMZxtZ6EjYZ7vQkkbzg+ZdYwBwAevRNpOLFPRH6KHJem9e6gHZZK517PJF110K4rLUzdQPudtPutd2iHdRePSp6/0CDRHYU3
X-MS-Exchange-AntiSpam-MessageData: 5l7Nxej0V3Akn+XSoFzzvS5ef62208s8pXeLlIFNNh/GM9C7G1UX4fkE5BKYZklCNWLfmJ35D5vfQ0Q4rcZqKuEX1u9uI6E/wmT3aMZxpPDyFDXe7LtcdCVUy+CVoaw7vi7K3EOYjx6ixSYbYN6QIRasmGV4uODsbjQ6nut+mb/MaHuPPJeTdE4VA38ihbgeV89c0tULu2AFjxecu2N6LogWZG81Eg028zbPycxoTW8Oe09WSn0jSOLozkIPFmIo/gIplis39a3DJnbsLBJKXqNbrYn9Arooo5wjG5wrMRQZEjHxJuEwj6Z2ZCDrSOSxvewhi3XhR1sWpq/u5gWP1TdJbyfqgm4l4t257pt98NXfyVJtWu6eCq/k2MlssBegi9Vs6m1dEvUTVHotTNv0l/ivweskPTDB1v/x2v/sbN4GW7bgcgLN52islu3rTeb9F1YqVCs0nUFvN4ctCbP54UXwnS4csbaV0ejfbGqGLgfxwS5JsnoXIBM3wH6C+/Twv3WFAFkEOlAWso6HlmjGpm5aXoXJIAQQRiVTGQYyFwJUXEZob32g/AzaZCOvT10Tze+1LA1C4iZepTvZZy4/hvfmha02Cvc2KRksP68jd4xyat6expDVX6i2fQ2/8owFxtFLwPS+uE8aszYduNHx+IgVnN38X4gFHqR/AW9tV3uYjBsyL0lRPDHTSzLThnPIv3WUyR4MovIAfc0EnRcZHQESp1MNtfxzFK3s0UAiBb4bTqCEorgOWD2CKB1/aucK+VUCR833Vlw9aQlOKkMVVr6ET5ZKqYMH9jWvhoVuqoFzqcgnnhkoaGfULl893Mfs
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5261db7-c12c-4f1a-6f0d-08d7eb3098fa
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2020 04:57:06.1197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NDQ7SAhowLXes8lylxZyQSkJM/OlLuAebVEVcZMUGxKRiHfPVdqacJBcO2s0smtyvDVMPYpZsSz8LLWLKnpDaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3499
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

remove unused variable "opcode"

Signed-off-by: Sanjay R Mehta <sanju.mehta@amd.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-amd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-amd.c b/drivers/spi/spi-amd.c
index 0d9debe..c5a16dd 100644
--- a/drivers/spi/spi-amd.c
+++ b/drivers/spi/spi-amd.c
@@ -168,7 +168,7 @@ static inline int amd_spi_fifo_xfer(struct amd_spi *amd_spi,
 {
 	struct spi_master *master = amd_spi->master;
 	struct spi_transfer *xfer = NULL;
-	u8 cmd_opcode, opcode = 0;
+	u8 cmd_opcode;
 	u8 *buf = NULL;
 	u32 m_cmd = 0;
 	u32 i = 0;
-- 
2.7.4

