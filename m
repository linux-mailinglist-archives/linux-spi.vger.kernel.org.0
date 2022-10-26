Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 871BC60E509
	for <lists+linux-spi@lfdr.de>; Wed, 26 Oct 2022 17:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233978AbiJZP4u (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 26 Oct 2022 11:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233798AbiJZP4s (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 26 Oct 2022 11:56:48 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2066.outbound.protection.outlook.com [40.107.94.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C79E9E2D4;
        Wed, 26 Oct 2022 08:56:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OMi52kop2beGOh0LC+Gi2jpTLD4pUDmfwmwu3o76jG9Cq5Dk9tgNe2S1W9K4ChN0QsZHYoDUSqO1BbM0dz70tMLyKBXUGdsKiUQSUIkPHzk1CY+cbJuVxjZSBjxr760qYHq2ImlV3DdcsqOvRXxLT37575I93dmYVOeP2SmG45WgLGECkIb1kkm4bnD8Dbg5aIMUvhgUFfoHCxlReNtuZ7nTW8Xc8amRujdymubnidNqirB3vgrcTbo7qqkixSXxR8ZICCp2+z4vmGChputzolt1rotpGnNUqmHf7vfWWSX0IyHFNqFAIeYpRldhf4XJtcKAph30FvgrdT1ZnA4y6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aqU3GP+uEdkdjPx4mM4/PvOVjlU/obaXOd8OngWP1OM=;
 b=mIgDWbOXo1TIIIYIh0YdOnmekNfaqaT/Q5Ob2u7bxbmfskGTePsoGkpHj+sATY4NagkspKFcMna8zygYtxHOH+g4ENPqypjCObh/scwGE/V8/PAd7yd/OftAk++5IfV6aTABrn/7oO9TXU9NAY5U7EMscXMt9hjH+h+J3C2jwEfffmXc+PEyCQ5Fa4dc7xoWkuFKmtULCSzU0nQ/JyJ46pikPAnmDrWzvgPLjsAErslCs2ad0aNa127egFt7vrnDOoROCcyBqhqB0gYYaEn+NNYzE3HzJPNav/13VZxtRotMBT9qv8COmgKh00hM//EHpF5hLNi6rCSGqEIsOGn7Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aqU3GP+uEdkdjPx4mM4/PvOVjlU/obaXOd8OngWP1OM=;
 b=WPWMgDkw7PZbqUhhjBm2iUREKILebtJtBM0yvj9UPHsYFgnlVNZjAy+W9Ch0q1nQsnuip1UM+MltBQOiK9bQQPap4JHQt4UM55Mav9Lj2Nt0lJb4/xaB+hLigK9TrAJ/5FFUoGTGDV/J0XsZrYrV9XK2Q1ryrPuqlx5snhS1FbNqTACZ1SoHB3hFJJyF79P2giD7z6QJtkwLYWh9OO+n9PAwM3NsWvsXhs8WzEkhQTO/rJNrg27YHXjCCAR+gWKcH+SPRU/WGnj7iPHA8qMScCddn2l7elxZHOsEqp+uyJQx8p3T5mbXDZQLk1qgTP+iAukAwXTnGMsQBHmfjh7MgQ==
Received: from DM6PR03CA0025.namprd03.prod.outlook.com (2603:10b6:5:40::38) by
 SA0PR12MB4479.namprd12.prod.outlook.com (2603:10b6:806:95::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5746.28; Wed, 26 Oct 2022 15:56:45 +0000
Received: from DM6NAM11FT082.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:40:cafe::9) by DM6PR03CA0025.outlook.office365.com
 (2603:10b6:5:40::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28 via Frontend
 Transport; Wed, 26 Oct 2022 15:56:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DM6NAM11FT082.mail.protection.outlook.com (10.13.173.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5746.16 via Frontend Transport; Wed, 26 Oct 2022 15:56:45 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Wed, 26 Oct
 2022 08:56:37 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Wed, 26 Oct 2022 08:56:36 -0700
Received: from moonraker.home (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Wed, 26 Oct 2022 08:56:35 -0700
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>
CC:     <linux-tegra@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        "Krishna Yarlagadda" <kyarlagadda@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH] spi: tegra210-quad: Don't initialise DMA if not supported
Date:   Wed, 26 Oct 2022 16:56:33 +0100
Message-ID: <20221026155633.141792-1-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT082:EE_|SA0PR12MB4479:EE_
X-MS-Office365-Filtering-Correlation-Id: f2051904-2fd7-41fe-2c06-08dab76aaf12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4Xw6lLWThM0YKQidk44WqvB14/KxyGnEPA7ZBQ5wEYMEOvhzQqNL1e4on5yO5RcEsEg61qtPQ4d0uJvIp+WEgx604G9vcDd4y60FuGypMDB7tzQZnpqzEzqdxbbA312k63Zv1CpwT8i040IRpE8GyHv/eRVppzXAh3AouVy6VWwt3C4DKFcBDg/9DTnazz7UPU85KuG2thBgEF/5aKfa1R3MJtIkW7+bcoOvRW/VeAILdCkY0IHdAjmXNtopSvYsmW50QDuom9AcfSh1QNhOOX2ChVsECGTVx8ij9qe6ewIC+Eae82+vVdVSbxT+ghMnict9ErvkVMNmyB4dsk4m5WtRsBgx5Y1xksftt2D/YZrQWtSNc3TonLERl+vSIooc6w/Vrd2I0/djJmx2NlL5PBqfuEeh9X+R+bFE1b5MTghyFXKz0LVXqHx72d0LRij/zgDk6M/3llX8AuExaP84FuDHGYD8ugbxaM31PyBzCZpNYXBheUmWzjWVS9UmzQDCunHtlTB/q/9forYSGrrHeRJIfpfcTMjQQNZRckE8KIKpMwyAVYVB+W1LbQoUvKT6/TyKSXWsTzv9/hKq3g/pX5Pb0EnBAIbvOCVezp2vFwleP1LmPnZlLltzaFWZ/GIcNt21wPX6Blfq0gpRsDSK7y0xlVrtRaL9rEtLeR7A1Tia4ONYvz4NU297dFZwcgE/QokOZX82L5WPHnH1Ue1et/QQYTXtMnZJ2jRh6WkIb6bluaEFKmg0YErPWswwBfiPzd0/GPJ5UvTUR4mylz0ifg==
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(346002)(396003)(39860400002)(451199015)(40470700004)(46966006)(36840700001)(70586007)(41300700001)(70206006)(36756003)(8676002)(4326008)(356005)(5660300002)(478600001)(8936002)(54906003)(316002)(40480700001)(7636003)(83380400001)(110136005)(107886003)(26005)(82740400003)(36860700001)(86362001)(47076005)(426003)(40460700003)(186003)(1076003)(2616005)(336012)(2906002)(82310400005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2022 15:56:45.6247
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2051904-2fd7-41fe-2c06-08dab76aaf12
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT082.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4479
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The following error messages are observed on boot for Tegra234 ...

 ERR KERN tegra-qspi 3270000.spi: cannot use DMA: -19
 ERR KERN tegra-qspi 3270000.spi: falling back to PIO

Tegra234 does not support DMA for the QSPI and so initialising the DMA
is expected to fail. The above error messages are misleading for devices
that don't support DMA and so fix this by skipping the DMA
initialisation for devices that don't support DMA.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 drivers/spi/spi-tegra210-quad.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
index 904972606bd4..10f0c5a6e0dc 100644
--- a/drivers/spi/spi-tegra210-quad.c
+++ b/drivers/spi/spi-tegra210-quad.c
@@ -720,6 +720,9 @@ static int tegra_qspi_start_cpu_based_transfer(struct tegra_qspi *qspi, struct s
 
 static void tegra_qspi_deinit_dma(struct tegra_qspi *tqspi)
 {
+	if (!tqspi->soc_data->has_dma)
+		return;
+
 	if (tqspi->tx_dma_buf) {
 		dma_free_coherent(tqspi->dev, tqspi->dma_buf_size,
 				  tqspi->tx_dma_buf, tqspi->tx_dma_phys);
@@ -750,6 +753,9 @@ static int tegra_qspi_init_dma(struct tegra_qspi *tqspi)
 	u32 *dma_buf;
 	int err;
 
+	if (!tqspi->soc_data->has_dma)
+		return 0;
+
 	dma_chan = dma_request_chan(tqspi->dev, "rx");
 	if (IS_ERR(dma_chan)) {
 		err = PTR_ERR(dma_chan);
-- 
2.25.1

