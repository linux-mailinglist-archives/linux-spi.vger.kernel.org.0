Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7F93B768E
	for <lists+linux-spi@lfdr.de>; Tue, 29 Jun 2021 18:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233875AbhF2Ql1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 29 Jun 2021 12:41:27 -0400
Received: from mail-mw2nam10on2055.outbound.protection.outlook.com ([40.107.94.55]:7265
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232441AbhF2Ql1 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 29 Jun 2021 12:41:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AW4IkPSg9sG6aqTqBPaWKz1qqoVjMfoDgoYzOIhowWsdlo63EF/EZllIClUHJiXdV/DsPykMILuLTt4wvRKjU5MoIrETptxSYv2ff++Yery+7w1vRa8ES6V5t7EzeiXVTpCDrdhCf37GvOMwvXVowIQLBDqUr+HcKRkoyy89WYlOqnCv4qS6HtCrGmaEs0AFQ+4ns6c1liV3jbXFoQfov430K1hx/l3JVNSzhc9NIZDQl6XT2rGgfq9WSJoiePIoxL891KiRnxdyxWaNt3aNs460yrer63E5w7K3Je+LFd74w3KG/lKUOZQ133uROHQ8NTZgylID8G8uludmxlT/+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wPbj7HifNbO+57vSBua/CdJIggwYsNPzCxnexMTVZuY=;
 b=IymJV1TabpOGC4qZ3nrWFiwUXQULS9zlfYbfOgy0tRUcuU0DqfOCucE3vmZBHMZNLXhGiXBfkZt0aHvQM8VPUtU+951EYb0qHXGfxApkeE2vT7kPOBXdyWV3KYxj9mRF7S79Qmk+2oremdYUPrfr0JRGKVYKgUAKPs74un7R91z7TixmiC1rwcrf73a23Hx1//z18pffjauT44i+nViCzAzcepRL67Ja+fWPDvzTQEr/v8xm35ARuYXy8nAf9IX/4TMBV1Gs2cyU8XxG1taMdfj3CnsSI7mX8fvuA6hgaXxuRtK1MHUwQPsGLtkiS8bkuUZAJKycCf6j4nH8CIxtHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wPbj7HifNbO+57vSBua/CdJIggwYsNPzCxnexMTVZuY=;
 b=T3G/yXWxAMlVIzgVJ20/oN5duRkBQru6DiJVG14rRmKacSiGSceX6s5X2INzT4Sqj6So5YjkgghS7JVkEnxAd5QdwnmsonGtUKapl9T6+qGS0xYOSmC7xp6zvbg7giQqcYvKrNdhNk1PJKlDyjO2sD5cKJpOePBvt/IkFJhAsnw=
Received: from DM5PR16CA0023.namprd16.prod.outlook.com (2603:10b6:3:c0::33) by
 CH0PR12MB5185.namprd12.prod.outlook.com (2603:10b6:610:b8::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4264.19; Tue, 29 Jun 2021 16:38:58 +0000
Received: from DM6NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:c0:cafe::e) by DM5PR16CA0023.outlook.office365.com
 (2603:10b6:3:c0::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22 via Frontend
 Transport; Tue, 29 Jun 2021 16:38:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT044.mail.protection.outlook.com (10.13.173.185) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4264.18 via Frontend Transport; Tue, 29 Jun 2021 16:38:57 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 29 Jun
 2021 11:38:55 -0500
From:   Nehal Bakulchandra Shah <Nehal-Bakulchandra.shah@amd.com>
To:     <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Nehal Bakulchandra Shah" <Nehal-Bakulchandra.shah@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Liang Liang <liang.liang@amd.com>
Subject: [RESEND PATCH v2 1/2] spi:amd: Add support for latest platform
Date:   Tue, 29 Jun 2021 22:08:33 +0530
Message-ID: <20210629163834.581774-2-Nehal-Bakulchandra.shah@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210629163834.581774-1-Nehal-Bakulchandra.shah@amd.com>
References: <20210629163834.581774-1-Nehal-Bakulchandra.shah@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5e0e39a6-d101-4cb3-eccd-08d93b1c646d
X-MS-TrafficTypeDiagnostic: CH0PR12MB5185:
X-Microsoft-Antispam-PRVS: <CH0PR12MB5185F94CB5C77CCCA80249DEA0029@CH0PR12MB5185.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J2kiHZScTBOdsUr3+gjo+Lo7KitxDWgegL+U8I4731H5yknhgaIof6FgJ5X6IvKiLXaHV2+LxU1FCMEk4UEHXVcSaTpIjJmOMJXMuDQZ+QKoiVmnLm41mc9CWMafdNoQMTdm+IHQjIvJLXEOFQga90IyLatCgupjrGqpc5sIjn3P8Vi5s73vKw+OuzthMxjlHZPmLqX+UwwkIpeI+NRx7pYxF9E+o/W87+fvl0zkWLJSvneXBXkzB+hUsqPCapj/JisbGVeY9Jh5THCXk12/8nl7ha/sSxFXAxii3s9uz0ZIzv7qcvxtsZa9wDa812bJQBGiOU9eIIOZAXH5z+shGgEVtRSqb37x/pERuy+gei6gQU5VYMjYCl3BxeA6TayQDxZHKpH3qHICZHXKmoXA9KZvPokV8Cv1C4AN8bWYIagrAnp144L8JORXmi1YqOj2QDLIXRgObposiEi2EHQV70WzHuqeZbiMN0vpsPVLNV8vHlJRNuDwHUPcywJk/v3NTDgU+Qwx1lcYD+ijdmtUEunp7TUY83qQnrEBFN0lF3tVKb+I5IlaLeMqEr89DK/Hhkb7gCGICsWH+pIG3FWUaAQ9kChF4gnFg9PaFyFtWd5+3m3uWdNUAnVOCfYKMBI0+D4bO83ohfeFojYGpbvZpUx0QTVRw/bpAv9R4Vju72B8E7nLNDCOHFyJuIkRDoqB9N97V3nChyFy6L2ljdYPwiwvfrha+05SyhC/lJaT/8E=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(396003)(346002)(39860400002)(136003)(376002)(46966006)(36840700001)(426003)(4326008)(70206006)(26005)(8676002)(70586007)(7696005)(336012)(36756003)(5660300002)(82740400003)(82310400003)(8936002)(186003)(16526019)(36860700001)(6916009)(47076005)(6666004)(478600001)(316002)(54906003)(2906002)(1076003)(2616005)(86362001)(81166007)(356005)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2021 16:38:57.8605
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e0e39a6-d101-4cb3-eccd-08d93b1c646d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5185
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

-Add device ID for new generation of platform.
-Modify spi_busy and opcode commands based on controller version.

Reviewed-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Reviewed-by: Liang Liang <liang.liang@amd.com>
Signed-off-by: Nehal Bakulchandra Shah <Nehal-Bakulchandra.shah@amd.com>
---
 drivers/spi/spi-amd.c | 72 +++++++++++++++++++++++++++++++++++++------
 1 file changed, 63 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-amd.c b/drivers/spi/spi-amd.c
index 3cf76096a76d..e65e7178d5fe 100644
--- a/drivers/spi/spi-amd.c
+++ b/drivers/spi/spi-amd.c
@@ -14,10 +14,12 @@
 #include <linux/spi/spi.h>

 #define AMD_SPI_CTRL0_REG	0x00
+#define AMD_SPI_OPCODE_REG  0x45
+#define AMD_SPI_CMD_TRIGGER_REG 0x47
 #define AMD_SPI_EXEC_CMD	BIT(16)
 #define AMD_SPI_FIFO_CLEAR	BIT(20)
 #define AMD_SPI_BUSY		BIT(31)
-
+#define AMD_SPI_TRIGGER_CMD	BIT(7)
 #define AMD_SPI_OPCODE_MASK	0xFF

 #define AMD_SPI_ALT_CS_REG	0x1D
@@ -34,11 +36,31 @@
 #define AMD_SPI_XFER_TX		1
 #define AMD_SPI_XFER_RX		2

+#ifdef CONFIG_ACPI
+struct amd_spi_devtype_data {
+	u32 spi_status;
+	u8	version;
+};
+
+static const struct amd_spi_devtype_data spi_v1 = {
+	.spi_status	= AMD_SPI_CTRL0_REG,
+	.version	= 0,
+};
+
+static const struct amd_spi_devtype_data spi_v2 = {
+	.spi_status	= AMD_SPI_STATUS_REG,
+	.version	= 1,
+};
+#endif
+
 struct amd_spi {
 	void __iomem *io_remap_addr;
 	unsigned long io_base_addr;
 	u32 rom_addr;
 	u8 chip_select;
+	const struct amd_spi_devtype_data *devtype_data;
+	struct spi_device *spi_dev;
+	struct spi_master *master;
 };

 static inline u8 amd_spi_readreg8(struct spi_master *master, int idx)
@@ -98,6 +120,14 @@ static void amd_spi_select_chip(struct spi_master *master)
 			      AMD_SPI_ALT_CS_MASK);
 }

+static void amd_spi_clear_chip(struct spi_master *master)
+{
+	struct amd_spi *amd_spi = spi_master_get_devdata(master);
+	u8 chip_select = amd_spi->chip_select;
+
+	amd_spi_writereg8(master, AMD_SPI_ALT_CS_REG, chip_select & 0XFC);
+}
+
 static void amd_spi_clear_fifo_ptr(struct spi_master *master)
 {
 	amd_spi_setclear_reg32(master, AMD_SPI_CTRL0_REG, AMD_SPI_FIFO_CLEAR,
@@ -106,8 +136,13 @@ static void amd_spi_clear_fifo_ptr(struct spi_master *master)

 static void amd_spi_set_opcode(struct spi_master *master, u8 cmd_opcode)
 {
-	amd_spi_setclear_reg32(master, AMD_SPI_CTRL0_REG, cmd_opcode,
-			       AMD_SPI_OPCODE_MASK);
+	struct amd_spi *amd_spi = spi_master_get_devdata(master);
+
+	if (!amd_spi->devtype_data->version)
+		amd_spi_setclear_reg32(master, AMD_SPI_CTRL0_REG, cmd_opcode,
+				       AMD_SPI_OPCODE_MASK);
+	else
+		amd_spi_writereg8(master, AMD_SPI_OPCODE_REG, cmd_opcode);
 }

 static inline void amd_spi_set_rx_count(struct spi_master *master,
@@ -126,17 +161,20 @@ static inline int amd_spi_busy_wait(struct amd_spi *amd_spi)
 {
 	bool spi_busy;
 	int timeout = 100000;
+	u32 status_reg = amd_spi->devtype_data->spi_status;

 	/* poll for SPI bus to become idle */
 	spi_busy = (ioread32((u8 __iomem *)amd_spi->io_remap_addr +
-		    AMD_SPI_CTRL0_REG) & AMD_SPI_BUSY) == AMD_SPI_BUSY;
+				status_reg) & AMD_SPI_BUSY) == AMD_SPI_BUSY;
+
 	while (spi_busy) {
 		usleep_range(10, 20);
 		if (timeout-- < 0)
 			return -ETIMEDOUT;

+		/* poll for SPI bus to become idle */
 		spi_busy = (ioread32((u8 __iomem *)amd_spi->io_remap_addr +
-			    AMD_SPI_CTRL0_REG) & AMD_SPI_BUSY) == AMD_SPI_BUSY;
+				status_reg) & AMD_SPI_BUSY) == AMD_SPI_BUSY;
 	}

 	return 0;
@@ -146,9 +184,16 @@ static void amd_spi_execute_opcode(struct spi_master *master)
 {
 	struct amd_spi *amd_spi = spi_master_get_devdata(master);

+	/*Check for busy wait*/
+	amd_spi_busy_wait(amd_spi);
+
 	/* Set ExecuteOpCode bit in the CTRL0 register */
-	amd_spi_setclear_reg32(master, AMD_SPI_CTRL0_REG, AMD_SPI_EXEC_CMD,
-			       AMD_SPI_EXEC_CMD);
+	if (!amd_spi->devtype_data->version)
+		amd_spi_setclear_reg32(master, AMD_SPI_CTRL0_REG, AMD_SPI_EXEC_CMD,
+				       AMD_SPI_EXEC_CMD);
+	else
+		amd_spi_setclear_reg8(master, AMD_SPI_CMD_TRIGGER_REG, AMD_SPI_TRIGGER_CMD,
+				      AMD_SPI_TRIGGER_CMD);

 	amd_spi_busy_wait(amd_spi);
 }
@@ -241,7 +286,8 @@ static int amd_spi_master_transfer(struct spi_master *master,
 	 * program the controller.
 	 */
 	amd_spi_fifo_xfer(amd_spi, master, msg);
-
+	if (amd_spi->devtype_data->version)
+		amd_spi_clear_chip(master);
 	return 0;
 }

@@ -266,6 +312,11 @@ static int amd_spi_probe(struct platform_device *pdev)
 		dev_err(dev, "error %d ioremap of SPI registers failed\n", err);
 		goto err_free_master;
 	}
+	amd_spi->devtype_data = device_get_match_data(dev);
+	if (!amd_spi->devtype_data) {
+		err = -ENODEV;
+		goto err_free_master;
+	}
 	dev_dbg(dev, "io_remap_address: %p\n", amd_spi->io_remap_addr);

 	/* Initialize the spi_master fields */
@@ -293,7 +344,10 @@ static int amd_spi_probe(struct platform_device *pdev)

 #ifdef CONFIG_ACPI
 static const struct acpi_device_id spi_acpi_match[] = {
-	{ "AMDI0061", 0 },
+	{ "AMDI0061",
+	.driver_data = (kernel_ulong_t)&spi_v1 },
+	{ "AMDI0062",
+	.driver_data = (kernel_ulong_t)&spi_v2 },
 	{},
 };
 MODULE_DEVICE_TABLE(acpi, spi_acpi_match);
--
2.25.1

