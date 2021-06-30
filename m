Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBD3C3B81A1
	for <lists+linux-spi@lfdr.de>; Wed, 30 Jun 2021 14:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234387AbhF3MHT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 30 Jun 2021 08:07:19 -0400
Received: from mail-sn1anam02on2086.outbound.protection.outlook.com ([40.107.96.86]:51070
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234489AbhF3MHS (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 30 Jun 2021 08:07:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EIjNtsbTh4E91pdNhCElVcfsyUt0rbfU8ANBXvAQeoLAlyUZFt17WRBM/iFbWF7vIcPRvEpNZ76s4Jh7YOvP6nr+JcCGxx/gPGnKPyEhWFbHPxiQuHZd0zdPNxHTqDJAesp2ADabHzJIO+6xHcJXl4dAQn7PzaPHl/fKDxBxfx0mKfZwb27nRX/7tdLjSshMMveWPKOddkpWxXx5f0o6kmhUvebpEw+1wtB1cuNR0LrQKYKDqSKyJIyhTEONKyardnaKHimd341pwtXsvVTnIhNLxsjnw7fp6qDyCwu4yB0UNB+Y0uET5roNu1+PkV1sLtIDI6Qj3nmKVVJC3riCTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=77000i/WMOcjtKjRx1yCnFBMvAxexx1LbfoLXOBOfUA=;
 b=i5J/JVEeY2G5SshN+j40pxOJvupwihRopy9Vpu76ZObhiBR0Rgyhj0A1nCPzdhxzhdsfzdGgwe/XzpjhPkgOCdY8jaXHnrk5HWdNoX70xjlpHew5dN10moKIVgk5jitXiSe4QakTK9USpnBu8xAyDIUMmBH354scdsIl20+KZBtjpv0gMJi9Xx9LNItFtI/eKgs01c9lVbCx+3ETgg6oDu4i8LTuMVr7iKtMUvMpoeL3MqCQ3e7ZJfGzM9Y1p+wdCTRuVpp+JM+hYspV6r4Hu5tOC2EKCPJZ5qiKp/im/1vLnTgWO1Jv/mOxcVOy49+sVoDavT4M+5HJlZx/Nu5kuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=77000i/WMOcjtKjRx1yCnFBMvAxexx1LbfoLXOBOfUA=;
 b=fqQIvUPOh2MBsuwlTn/Z/upEP5JiLbH/mmgMbQs2T49PeZbo3F2nyvEhwBRX0V1wrAhn8L6y/Q7Q2lnBW/L880Jlgzd+aXK2LQEo+wmLy0Qh/payLoFE+sYgSMKtWmOTzJ+a1jvH8xxBAKprpf1VnwaePMkhewIpWOeVl8J4Kns=
Received: from MWHPR04CA0055.namprd04.prod.outlook.com (2603:10b6:300:6c::17)
 by MN2PR12MB4208.namprd12.prod.outlook.com (2603:10b6:208:1d0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.19; Wed, 30 Jun
 2021 12:04:45 +0000
Received: from CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:6c:cafe::ef) by MWHPR04CA0055.outlook.office365.com
 (2603:10b6:300:6c::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22 via Frontend
 Transport; Wed, 30 Jun 2021 12:04:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT007.mail.protection.outlook.com (10.13.174.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4287.22 via Frontend Transport; Wed, 30 Jun 2021 12:04:44 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 30 Jun
 2021 07:04:41 -0500
From:   Nehal Bakulchandra Shah <Nehal-Bakulchandra.shah@amd.com>
To:     <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Nehal Bakulchandra Shah" <Nehal-Bakulchandra.shah@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Liang Liang <liang.liang@amd.com>
Subject: [PATCH v3 1/3] spi:amd: Add support for latest platform
Date:   Wed, 30 Jun 2021 17:34:23 +0530
Message-ID: <20210630120425.606957-2-Nehal-Bakulchandra.shah@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210630120425.606957-1-Nehal-Bakulchandra.shah@amd.com>
References: <20210630120425.606957-1-Nehal-Bakulchandra.shah@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 91f73ba6-d1a0-4a88-4f4e-08d93bbf3fee
X-MS-TrafficTypeDiagnostic: MN2PR12MB4208:
X-Microsoft-Antispam-PRVS: <MN2PR12MB420867BF5F709FB2B0FA9CC0A0019@MN2PR12MB4208.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S1QLgorwbVEYfS9JjzKxJ44UMz9Do0HiTInwi8zbboOiEi1wTjLOveVT7JScxCSqh8KpWLuS2J7Tqi1whJtCrWYrxrsQ9rGzgrgTJlK1ELxJDCrdQM8pRMh8LPe1H134EXZhDxas6PSfQvS32SkobiVljIC7XFsAdqU5nCF4w7heDF7Fv53xoCK9Kq7kqYudKNu3yemgJN1/dQH2KTNY3Kofu3wFahw3OqmKgo9+y4jdcm2Vp2g0manXK7MsrQ2eoMV1a/Ogrhr+Ut9r1JRpmHkqAkf2mqqwZUdFBHc37jEewV0ZeU0n3MzBI4VOIzeJd/ta5EYCglSwxxukdIXebhyoBAas/4GLSqMXRfFm731gYkMQD6LKhrSFnettHvsTTL7XLoirnNs/mLXCpl9wQkksuipxjInqzJ6g8En3mcjV1TVYI2GjnoSTbRRZfpAg8ZpjK8NU8YUW5ehLgIL8Ah8ANAPBT+7rQhnbKG4ubKxehAm8a84OJQZrKbMUBj9v7PoqJ12LG+JvPEgwFmXyUVIO+6WgG9e28NNtS60uX5EbRA/WzxYR6YduRY8VlvNgkxLYprUefxJOX7c+acDDTMLof2h5VRxhjTxvUU08m8PcHNJFmimSPlBVu7NSRlJaAC20SZlgLO8g48k3SsN/NcOagxZV7MzsATV7XHdxHZ/BZoRqv7nH4DGeUVk9FrGkYwGd8xP49C/zXmEB0sWNbm5+Y1UIns5KEaBh1SPAIvA=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(136003)(39860400002)(346002)(396003)(376002)(46966006)(36840700001)(316002)(6916009)(336012)(426003)(8936002)(82740400003)(54906003)(70206006)(26005)(4326008)(86362001)(2906002)(36756003)(478600001)(70586007)(83380400001)(8676002)(1076003)(186003)(356005)(81166007)(16526019)(2616005)(36860700001)(7696005)(82310400003)(5660300002)(47076005)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2021 12:04:44.5271
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91f73ba6-d1a0-4a88-4f4e-08d93bbf3fee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4208
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
index 3cf76096a76d..2150f54512d9 100644
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

