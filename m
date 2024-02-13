Return-Path: <linux-spi+bounces-1333-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 344E4853A7F
	for <lists+linux-spi@lfdr.de>; Tue, 13 Feb 2024 20:05:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE7D6285635
	for <lists+linux-spi@lfdr.de>; Tue, 13 Feb 2024 19:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB8B1F5F6;
	Tue, 13 Feb 2024 19:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="R1KrDkri"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECF11CA8F
	for <linux-spi@vger.kernel.org>; Tue, 13 Feb 2024 19:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707851088; cv=fail; b=BUnPERX5fsh8ZHyhoGQo4lAsHeODDJhuW3UaPhIlIJovqq/G6Ng+8Ygmfy4pGMGsa9BfUAuO6A/wyYWJWqCX1lM02RAW5QDspeyJbs2pXxjca2gu4ga6IxvaC44trcfmVB7VCacNZl3AcBxS2AmTb7BJr0GnhX/7ofDjs66RoM0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707851088; c=relaxed/simple;
	bh=1+T0L6qs4dlnzeYPfo23K7y+qd5W5uWBXLFdBFbdKLY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NhAxrQo0wKgAS3/lpzK66p8Fg0Ds5ZUXyO0dIGN5Z/a6FvsL3uIhj4Y9qKVcBNbF/Ww8O2IeFBMkaKtK4wTtoW5qUDwG4nhRJn7aa8GdM5tBx6KqhwZnNYlnQuVrgD19DDSyGgiVoFWb9RKsa4zGYgX6BDXBvRtqOvp3PkS9yko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=R1KrDkri; arc=fail smtp.client-ip=40.107.223.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kUIZG/wQCatoD1WhYqrLFtTUA4KchBVOvNmc4YqRlyjWFh8w1MrF1QQkVttOT+Mrc+uB3mMCjNIGiKKdxpRktsi9hPWt6E0/Q6yvZZqZYqWvtmcc4VgQ+6ep87ghDUyeNyJ02cFOaHdYh2XkHKxV6FQtFh/tI/i2sjc+Sadt4EBmvhqgOBU55eUNjJ6Jsq2+XRpPyc96P5BloYRlMF+kUdW1+15Jo6RKU5xVz/P8MuzCWf1TyiRWuD/hQcm0tjdzec0ETStJfTxb8SVlUZ5cOegFM2eIPM75z/UBdZH/6kCS5pAvUblXvwk+aGE7uWMVyEquXvlAIhDpKzI+L0OfIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aU90vmOK1HpcKtCTXVTNz6C9SVJEK2ZIj4ToyU1VHhE=;
 b=PV1PdMtiCbh4pWfyc5zZLIf+dTfJMVr/bVTR/6Ys+t3NNTUDevuF8MeoF6Gc7+yVag/L3O6NyNmcIZDdIvqedyFqgwS6Nxcj4BIdH2vlMQavR1nJ1Qgd9GM50hOU0DB3vzSvFwuprWXJFiULWs19D3Q4o2WOjuYN2WWmkkh8xw33IBrOlUtoeqHavt2g6amj24yxMA2pNJUW/xe1czdqsRAi3C/0V3J4i9oDd6iZkc6C9ou7KxFK0ge+dgkt17dgqqih54BdNLaqpU3YGYaZMOypgMOip4Ul1aXqW4JDGo+PI5BXe9iSFH8kcAfEX6as6pQZdzEpedL756kxv0nLLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aU90vmOK1HpcKtCTXVTNz6C9SVJEK2ZIj4ToyU1VHhE=;
 b=R1KrDkripd/MsfV5EXo7Z+ioslpKI/2SN9ENLYvnZ9uKkw9HTAV+7wU50NbFzW8AuXJsW1zFDJGrYh3p5s5XRMU+1cfsa5l3QFd73j+uDRBoRNaaNZFmj4vbd1gwmrHr8aH10iGD07o867/nTJJ7qRZaNM1OxDo1/j8UQy/L0MU=
Received: from BYAPR02CA0049.namprd02.prod.outlook.com (2603:10b6:a03:54::26)
 by IA1PR12MB6233.namprd12.prod.outlook.com (2603:10b6:208:3e7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.23; Tue, 13 Feb
 2024 19:04:44 +0000
Received: from SJ5PEPF000001D6.namprd05.prod.outlook.com
 (2603:10b6:a03:54:cafe::c8) by BYAPR02CA0049.outlook.office365.com
 (2603:10b6:a03:54::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.40 via Frontend
 Transport; Tue, 13 Feb 2024 19:04:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D6.mail.protection.outlook.com (10.167.242.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Tue, 13 Feb 2024 19:04:44 +0000
Received: from platform-dev1.pensando.io (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 13 Feb 2024 13:04:42 -0600
From: Brad Larson <blarson@amd.com>
To: <soc@kernel.org>
CC: <linux-spi@vger.kernel.org>, <arnd@arndb.de>, <blarson@amd.com>
Subject: SPI device driver with userspace interface
Date: Tue, 13 Feb 2024 11:04:35 -0800
Message-ID: <20240213190435.23645-1-blarson@amd.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D6:EE_|IA1PR12MB6233:EE_
X-MS-Office365-Filtering-Correlation-Id: 19505ce9-344d-4982-a181-08dc2cc6a3c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0wiNhDPeJ9ZrabyA6OXoCAfgctRQIq7KcqAPBKKLIiFM3epcCqrzB4uqMqM3IsKvGxINqf73OvwAoSLBx6zA3+8DPq8pgssDI/OjnUkO4AhLq0HJvEoApQXNh57sbDtVpR40V5p+1Rr+VyoSLRPCpumRCD6KXzaAroWV0DOlW3Qs9F3eS6ql4fGLxciU1zMXpjEZ7fr5ZLb1Q/e5R1M0yUIR+dVlW9regdKGmDHtOSBUQToBRLsMDHuzau84SApbp3oa6nuebaB5YD42zhykzTWhkhdBU/rfBM22YzNDyiqBE6v3vgpLQfLTiTJaBC4SKra7Znd1wFTey7gDW5CKL4FJK9pkVoxPymRqqB/MBD+DU0BQVhJ4+nxeAIdJfY1P9YWmYCaq8B8Atl5BGEJMoT7eKwEHIYKrWkIi8D8wkW9piTk0mGe+vX3zPFD2tRBFUEJTdL/ElR2MdD3D2Oa+2ltTGeFWyEg/TUY4LTjau8sU7QYYN1PC+WqhT/YyFKGTUstskL2zhuydnW8azPkITl+3ncHZwLTFujwxMA90j89h8Phuj7pvJXiU7hvda+0tk7kERvR7mxGLLKn4g+PDNmrGuYCk8SgXvG/Zdomduc8=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(376002)(136003)(39860400002)(230922051799003)(64100799003)(1800799012)(186009)(82310400011)(451199024)(36840700001)(46966006)(40470700004)(478600001)(41300700001)(8936002)(4326008)(8676002)(5660300002)(6666004)(2906002)(70586007)(54906003)(6916009)(70206006)(316002)(83380400001)(26005)(2616005)(336012)(426003)(81166007)(16526019)(1076003)(356005)(36756003)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 19:04:44.1433
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19505ce9-344d-4982-a181-08dc2cc6a3c7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6233

In the process of enabling the AMD Elba SoC I pulled out a driver that
was not converging on acceptance.  Please provide guidance on how I should
implement a spi device driver, with emmc reset control, and access from
userspace in a form that is acceptable if possible.

The device tree topology describes this:

+------------+              +-----------+
|            | <-- spi0 --> |           |
|            | --- cs0 ---> |           |
|            | --- cs1 ---> | CPLD/FPGA | --+
|    SoC     | --- cs2 ---> |           |   |
|            | --- cs3 ---> |           |   | rstc
|            |              +-----------+   |
|            |              +-----------+   |
|            | --- spi1 --> +   eMMC    | <-+
+------------+              +-----------+

The functionality is exclusively accessed via userspace programs 
except for the mmc hardware reset which is triggered by the kernel. 
The choice of CPLD or FPGA is decided based on cost/functionality.

CS0: CPLD/FPGA Board controller registers
CS1: Designware SPI to I2C to board peripherals
CS2: Lattice dual I2C master for transceiver peripherals
CS3: CPLD/FPGA internal storage for firmware update

The desired CS0, CS1 and CS3 interfaces are /dev/penctrl.0,
/dev/penctrl.1, and /dev/penctrl.3.  This is very similar
to the spidev.c driver which is considered inappropriate for
production.  CS2 is matched to a Lattice spi to i2c driver to
provide /dev/i2c-1 and /dev/i2c-2 to access to transceiver I2C
peripherals.

Relevant DT fragments are shown below:

        emmc: mmc@30440000 {
                compatible = "amd,pensando-elba-sd4hc", "cdns,sd4hc";
                reg = <0x0 0x30440000 0x0 0x10000>,
                      <0x0 0x30480044 0x0 0x4>; /* byte-lane ctrl */
                ...
        };

&emmc {
       bus-width = <8>;
       cap-mmc-hw-reset;
       resets = <&rstc 0>;   <== mmc hwreset is a bit in a CPLD CS0 register
       status = "okay";
};

One possible hardware description is shown below with a common driver for
three of the chip-selects and a different driver for cs2.

&spi0 {
       #address-cells = <1>;
       #size-cells = <0>;
       num-cs = <4>;
       cs-gpios = <0>, <0>, <&porta 1 GPIO_ACTIVE_LOW>,
                  <&porta 7 GPIO_ACTIVE_LOW>;
       status = "okay";

       rstc: system-controller@0 {   <== common driver for cs0/cs1/cs3
               compatible = "amd,pensando-elba-ctrl";
               reg = <0>;
               spi-max-frequency = <12000000>;
               interrupt-parent = <&porta>;
               interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
               #reset-cells = <1>;
       };

       system-controller@2 {
                compatible = "amd,pensando-cpld-rd1173";
                #address-cells = <1>;
                #size-cells = <1>;
                spi-max-frequency = <12000000>;
                reg = <2>;
                interrupt-parent = <&porta>;
                interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
        };
};

The spidev driver provides the needed userspace interface, however
- Having multiple sub-device nodes with the same compatible is unacceptable
- The spidev driver is not for production and can't extend compatible list
- MMC hardware reset is problematic in DT description to driver implementation

Is there a recommended way to implement this driver with userspace access
using normal kernel abstractions.  I thought the use of cdev and file_operations
would be acceptable.

Thanks for the help!

Regards,
Brad

