Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 783464CFD18
	for <lists+linux-spi@lfdr.de>; Mon,  7 Mar 2022 12:35:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239838AbiCGLgi (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 7 Mar 2022 06:36:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238973AbiCGLgf (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 7 Mar 2022 06:36:35 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC3B49248;
        Mon,  7 Mar 2022 03:35:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HBTJI13QxKi31oOoN6sHATrARm8twS6ZGahv1tDQXQWIluW43f2Ny73ptfmuw6/THUPeJxb0sCdoKKJuyOx2H0+fEgUpsj+iT6lV57i64Bir0QFxaW8KRA2z7IURoSSgTy2GpdMFh4aKoIw/hFlxoVPfMbb1B/lpQtonYhhG+hZoOHJrkYB4aw+1MA0xMbaCBzLzLKuU6qBFNJ0kVHX42VISYkHLVv6TGgv3ERrtdhoF9uUOE8KtOpWSg56WBCTyxCj9FXzTSGg8Iuz0Mq8bQYoOsJ+woHN5zQWxQAlZLJX8gkuLMN2UhqAhSawPCuWWW75MzgAkZ1wd2bjRSeZVQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cJnOV6TeYo5H5nNeLTEIyiZ2glBextusHx+phqWUTHg=;
 b=ZguEzI1NXAxcas6ZIbcpvmlI4HTSxQWnzjq1VRmg195DsxW7jC60hS6R0xVRLbGHsS5PuiQJZeHqIiTvxR/uQ2UlyNSDD38/4hFwjpCm7Cgm62H/pVbKAiwJTBReagZLYGheW8cCi+6sDw1TsVIwCePxzzl1AcJuAeq7McW5y8spyb4vT/x1cOoFxcYqJO0s60hh5/YbLMkl/CAEAfVPEDiChFGWuLCvIs8aOrkk3XgkFF9NLGWgjrKr7zIyc/H8X2QDneySh7eVvPzyC2xAIufAfIbtS+SqSXcrHDVtGodhBiiGPNo+MTwxqaGg67ETRDRkEExW9QYkYVFQzE1+wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cJnOV6TeYo5H5nNeLTEIyiZ2glBextusHx+phqWUTHg=;
 b=UHw0b6FxxKtsCYgWLAFUUnLXVR7HuBJoAJOVa0pNGlov9Bpgv05t2mGSErS0kIxVMUJ8275XURGIIaARtUt7GnLm5Uiuj0cKT+QHBzAxcKemxox/Nv+V6NSpXmUfTQ5MxpjLEyrLnwPCXOL7zcxppmIXl/dPpSmrU+I2EEA3QmcSm8IUhjUsojb3qU3l+wrE46uVDGUjkiQKz3/3UOejDabTIsFivyJ4tYXXeyJCN+QbQNRHW/w6cDlI7+87MTqaEG/drhlJB4AJP8jXNUZVtWHnY8X2GGT5YmfXQdWyIPOTGD5ZJlUOWlT36dOG5MJtvro5iXereWnSOwwr8hgvvw==
Received: from DS7PR03CA0050.namprd03.prod.outlook.com (2603:10b6:5:3b5::25)
 by CH2PR12MB3718.namprd12.prod.outlook.com (2603:10b6:610:2e::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Mon, 7 Mar
 2022 11:35:40 +0000
Received: from DM6NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b5:cafe::bc) by DS7PR03CA0050.outlook.office365.com
 (2603:10b6:5:3b5::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Mon, 7 Mar 2022 11:35:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 DM6NAM11FT059.mail.protection.outlook.com (10.13.172.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5038.14 via Frontend Transport; Mon, 7 Mar 2022 11:35:40 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 7 Mar
 2022 11:35:39 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Mon, 7 Mar 2022
 03:35:38 -0800
Received: from moonraker.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Mon, 7 Mar 2022 03:35:36 -0800
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "Thierry Reding" <thierry.reding@gmail.com>
CC:     <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH] dt-bindings: spi: Fix Tegra QSPI example
Date:   Mon, 7 Mar 2022 11:35:29 +0000
Message-ID: <20220307113529.315685-1-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bf08f7a5-a58e-4eec-a851-08da002e9b6a
X-MS-TrafficTypeDiagnostic: CH2PR12MB3718:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB371810F478879215833F8AE7D9089@CH2PR12MB3718.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f6sXnZ7Q8rGcOQLIZ3TKLYmmOD2sxm7sbVuXQJfkiad2wqXgsA3UjKxflRwlQ7p4m6+pZBW88a9tSh/F3LWW4UIULPgP+fbbq+2SRToESGCLtc4ZsSNiHNF2LRdbHqq/qL/3rH6Awtq51g9oW13fm/U/N395EWgkPtqTLgUvYUtksO7POo1V2dS7duGMwii2x6YpHcDdxrAWSXdlOt7OJAkaAUlbqIvhV7jNBX09HCpQA4CUnT99rfp4JthBNi8qDtxBpwQtDXatfN1KgpZiLH2egf+ews2Wfa0wbeuYg5w8mb7I2JmtdzvzVfr/lyDkBDFHVyL3618kZ8mpqPU8LBIcihhjj8wMBwuJNC0nzWY6/ddDry+UzWNGeEbl8pNIy0FcQAYE2S5dCNgvZhScYe/cjaLIqHFa3s/7xeyidh2YvFRTadjZBNNWO5vQN1YpCeZvtvxKPRTsyRLbe2XWZ6hkqvLekZ6BX3hYhkaC6pRD/CVCUh1KUIVxJ1rKc/XedDI+zOsf5o2lNH1SXRnUqKlSttxrSAoPe1t2ZQWDVMYuCrcbHtulZOuSmszmAmpN0sBV+bUtlb0z0apgtMBzmllQ5pOwMk+YuiRcCMXSMCBGXBhnjoCqmyE4Dx9zPVEuInIg8TtlMRwQOzJtnrgMdurdCs+UrrF0TNSV0vjCoR631lfZp3cIKGxFaPrgiMxg/Z2xyZtozsIhZRJWJE+oFw==
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(47076005)(36860700001)(36756003)(7696005)(40460700003)(2616005)(2906002)(83380400001)(107886003)(5660300002)(316002)(54906003)(82310400004)(26005)(70586007)(81166007)(8936002)(70206006)(426003)(336012)(356005)(86362001)(186003)(1076003)(6666004)(8676002)(4326008)(110136005)(508600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 11:35:40.0894
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf08f7a5-a58e-4eec-a851-08da002e9b6a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3718
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

When running dt_binding_check on the nvidia,tegra210-quad.yaml binding
document the following error is reported ...

 nvidia,tegra210-quad.example.dt.yaml:0:0: /example-0/spi@70410000/flash@0:
 	failed to match any schema with compatible: ['spi-nor']

Update the example in the binding document to fix the above error.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml b/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml
index 6efea8970e62..0296edd1de22 100644
--- a/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml
+++ b/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml
@@ -107,7 +107,7 @@ examples:
             dma-names = "rx", "tx";
 
             flash@0 {
-                    compatible = "spi-nor";
+                    compatible = "jedec,spi-nor";
                     reg = <0>;
                     spi-max-frequency = <104000000>;
                     spi-tx-bus-width = <2>;
-- 
2.25.1

