Return-Path: <linux-spi+bounces-4786-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D732976121
	for <lists+linux-spi@lfdr.de>; Thu, 12 Sep 2024 08:16:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8905287A30
	for <lists+linux-spi@lfdr.de>; Thu, 12 Sep 2024 06:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D25188A35;
	Thu, 12 Sep 2024 06:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nyOaIF7G"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637E723D7;
	Thu, 12 Sep 2024 06:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726121760; cv=none; b=T6GdAqFcIiuC7xDjoefwaoo/7d1+dDMkjuWj2T2lDEnJ4pb+YzDut+bjA59kdPvpMdNF2ApVh2Td8vSVbbGdKVmp8oOTYudl691pwjFYPXawJ3eH7vyy3AwL0J988cLGNdQ3imVCK3yjxlhvVHSPjI/ilfhPp/7C6OrfsXRx/Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726121760; c=relaxed/simple;
	bh=d9ANOiv3g65caoxUJzNR/elgsaYtsXpovZNaKDK9+No=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=n2sdV9V6coDomUKADX5OwGq1Tbcvm75jT4L11OlRl5WGHxQihGv6c3AkEiOdjcmo0zlE9HwrXGvM2qRlsO/cdyI3N8kKvDwIUNatHNAFq1/5Z+wY2JTROd6VFCLUAflO0ADkJEGlyZTJp9KACXZPvvvDbyD0pihwsTr7iNjzwPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nyOaIF7G; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48C2L4Z5000776;
	Thu, 12 Sep 2024 06:15:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=ThCy74xY633evxCMvrZ5Nl
	DMHVJ580fCGBacyvcK75w=; b=nyOaIF7GI/sx9yMVK3b10ZSmkijqTMEH7H1SCS
	QxwD6D3Ww+8OcWWMkYVZqtMND1Rrxls0PXB4J6Q2JxwT4xtHNld698KgZMoIpsfe
	OpdUA6bVnZkcdwu5J0TEVkzvRTmJmXUvEPpL4h0glNPYOUvzoKZ+ijDimsQNNehr
	Z8sbg8j/V4wRfyLZpNcEaUGvAkK03fEaSzUlDOwdL8qJyy/tWQJCZ24urqcEAqM/
	0wGCo47Xe4/0HJWgjS3xjwYAAEIWgUieSiW28w6x3gNxF6OLvskxmXOwa01VwLU2
	474wZwxJgUhmEIf2HG2FcNiEQCYxaDKYgPTVoY1557eUsvug==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41gybpv0ma-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Sep 2024 06:15:24 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48C6FNVQ007459
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Sep 2024 06:15:23 GMT
Received: from hu-mdalam-blr.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 11 Sep 2024 23:15:17 -0700
From: Md Sadre Alam <quic_mdalam@quicinc.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <andersson@kernel.org>,
        <konradybcio@kernel.org>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <vigneshr@ti.com>,
        <manivannan.sadhasivam@linaro.org>, <esben@geanix.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>
CC: <quic_mdalam@quicinc.com>, <quic_varada@quicinc.com>,
        <quic_srichara@quicinc.com>
Subject: [PATCH v9 0/8] Add QPIC SPI NAND driver
Date: Thu, 12 Sep 2024 11:44:55 +0530
Message-ID: <20240912061503.3468147-1-quic_mdalam@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Zj8TGpUUrwwnMeofDQ-jR29PlRL3zZRf
X-Proofpoint-GUID: Zj8TGpUUrwwnMeofDQ-jR29PlRL3zZRf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 spamscore=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=809 clxscore=1015 bulkscore=0
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409120043

v9:
 * Fixed all the compilation warning reported by
   kernel test robot
  * Changed type of cmd1, vld to u32 from __le32 in qcom_nand_controller
   structure
 * Changed type of cfg0, cfg1, cfg0_raw, cfg1_raw, clrflashstatus,
   ecc_buf_cfg, ecc_bch_cfg, clrreadstatus to u32 in qcom_nand_host
   structure
 * In nandc_set_read_loc_first() api added cpu_to_le32() macro to fix
   compilation warning reported by kernel test bot
 * In nandc_set_read_loc_last() api added cpu_to_le32() macro to fix
   compilation warning reported by kernel test bot
 * Changed data type of cw_offset, read_size, is_last_read_loc to
   u32 in nandc_set_read_loc() api to fix compilation warning reported
   by kernel test bot
 * In set_address() api added cpu_to_le32() macro to fix compilation
   warning reported by kernel test bot
 * In update_rw_regs() api added cpu_to_le32() macro to fix compilation
   warning reported by kernel test bot
 * In qcom_op_cmd_mapping() api added cpu_to_le32() macro to fix
   compilation warning reported by kernel test bot
 * In qcom_read_status_exec() api added cpu_to_le32() macro to fix
   compilation warning reported by kernel test bot
 * In qcom_read_id_type_exec() api added cpu_to_le32() macro to fix
   compilation warning reported by kernel test bot
 * In qcom_misc_cmd_type_exec() api added cpu_to_le32() macro to fix
   compilation warning reported by kernel test bot
 * In qcom_param_page_type_exec() api added cpu_to_le32() macro to fix
   compilation warning reported by kernel test bot   
 * In update_rw_regs() api added cpu_to_le32() macro to fix compilation
   issue reported by kernel test bot
 * In qcom_param_page_type_exec() api added cpu_to_le32() macro to fix
   compilation issue reported by kernel test bot
 * Changed data type of addr1, addr2, cmd, to __le32 in qpic_spi_nand
   structure
 * In qcom_spi_set_read_loc_first() api added cpu_to_le32() macro to fix
   compilation warning
 * In qcom_spi_set_read_loc_last() api added cpu_to_le32() macro to fix
   compilation warning
 * In qcom_spi_init() api added cpu_to_le32() macro to fix compilation
   warning
 * In qcom_spi_ecc_init_ctx_pipelined() api removed unused variables
   reqs, user, step_size, strength and added cpu_to_le32() macro as well
   to fix compilation warning
 * In qcom_spi_read_last_cw() api added cpu_to_le32() macro to fix
   compilation warning
 * In qcom_spi_check_error() api added cpu_to_le32() macro to fix
   compilation warning
 * In qcom_spi_read_page_ecc() api added cpu_to_le32() macro to fix
   compilation warning
 * In qcom_spi_read_page_oob() api added cpu_to_le32() macro to fix
   compilation warning
 * In qcom_spi_program_raw() api added cpu_to_le32() macro to fix
   compilation warning
 * In qcom_spi_program_ecc() api added cpu_to_le32() macro to fix
   compilation warning
 * In qcom_spi_program_oob() api added cpu_to_le32() macro to fix
   compilation warning
 * In qcom_spi_send_cmdaddr() api added cpu_to_le32() macro to fix
   compilation warning
 * In qcom_spi_io_op() api added cpu_to_le32() macro to fix compilation
    warning
v8:
 * Fixed compilation warning reported by kernel test robot
 * Added "chip" description in nandc_set_read_loc_first()
 * Added "chip" description" in nandc_set_read_loc_last()
 * Changed data type of read_location0, read_location1,
   read_location2, read_location3, addr0, addr1, cmd, cfg0,
   cfg1, ecc_bch_cfg, ecc_buf_cfg, clrflashstatus, clrreadstatus,
   orig_cmd1, orig_vld to __le32 to fix compilation warning.
 * Included bitfield.h header file in spi-qpic-snand.c to
   fix compilation warning
 * Removed unused variable "steps" variable from 
   qcom_spi_ecc_init_ctx_pipelined()

v7:
 * Added read_oob() and write_oob() api
 * Added FIELD_PREP() in spi init
 * Made CONFIG_SPI_QPIC_SNAND and CONFIG_MTD_NAND_QCOM
   as bool type
 * Removed offset 0 in oob_ecc() layout
 * Handled multiple error condition

v6:
 * Added FIELD_PREP() and GENMASK() macro
 * Added qpic_spi_nand{..} structure for
   spi nand realted variables
 * Made qpic_common.c slectable based on
   either CONFIG_MTD_NAND_QCOM or CONFIG_SPI_QPIC_SNAND
 * Removed rawnand.h from qpic-common.h 
 * Removed partitions.h and rawnand.h form spi-qpic-snand.c
 * Added qcom_nand_unalloc() in remove()

v5:
 * Fixes nandbiterr issue
 * Added raw_read() and raw_write() API
 * Added qcom_ prefix to all the common API
 * Removed register indirection
 * Following tests for SPI-NAND devices passed

   - mtd_oobtest
   - mtd_pagetest
   - mtd_readtest
   - mtd_speedtest
   - mtd_stresstest
   - mtd_subpagetest
   - mtd_nandbiterrs
   - nandtest
   - nanddump
   - nandwrite
   - nandbiterr -i
   - mtd erase
   - mtd write
   - dd
   - hexddump

v4:
 * In this patch series fixes kernel doc for all the cmmon api
 * Also fixes dm-binding commit message
 * Fix qpic_common.c compilation based on config

v3:
 * In this patch series fixes multiple things like
   added clock-name, added _alloc_controller api instead
   of alloc_master, made common apis more generic etc.

 * Addressed all the comment from v2 patch series

v2:
 * https://lore.kernel.org/linux-arm-msm/20240215134856.1313239-1-quic_mdalam@quicinc.com/
 * In this series of patchs we have added basic working QPIC SPI NAND
   driver with READ, WRITE, ERASE etc functionality

 * Addressed all the comments given in RFC [v1] patch

v1:
 * https://lore.kernel.org/linux-arm-msm/20231031120307.1600689-1-quic_mdalam@quicinc.com/
 * Initial set of patches for handling QPIC SPI NAND.

Md Sadre Alam (8):
  spi: dt-bindings: Introduce qcom,spi-qpic-snand
  mtd: rawnand: qcom: cleanup qcom_nandc driver
  mtd: rawnand: qcom: Add qcom prefix to common api
  mtd: nand: Add qpic_common API file
  mtd: rawnand: qcom: use FIELD_PREP and GENMASK
  spi: spi-qpic: add driver for QCOM SPI NAND flash Interface
  arm64: dts: qcom: ipq9574: Add SPI nand support
  arm64: dts: qcom: ipq9574: Disable eMMC node

 .../bindings/spi/qcom,spi-qpic-snand.yaml     |   83 +
 .../boot/dts/qcom/ipq9574-rdp-common.dtsi     |   43 +
 arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts   |    2 +-
 arch/arm64/boot/dts/qcom/ipq9574.dtsi         |   27 +
 drivers/mtd/nand/Makefile                     |    7 +
 drivers/mtd/nand/qpic_common.c                |  738 +++++++
 drivers/mtd/nand/raw/Kconfig                  |    2 +-
 drivers/mtd/nand/raw/qcom_nandc.c             | 1763 +++--------------
 drivers/spi/Kconfig                           |    8 +
 drivers/spi/Makefile                          |    1 +
 drivers/spi/spi-qpic-snand.c                  | 1634 +++++++++++++++
 include/linux/mtd/nand-qpic-common.h          |  482 +++++
 12 files changed, 3348 insertions(+), 1442 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/qcom,spi-qpic-snand.yaml
 create mode 100644 drivers/mtd/nand/qpic_common.c
 create mode 100644 drivers/spi/spi-qpic-snand.c
 create mode 100644 include/linux/mtd/nand-qpic-common.h

-- 
2.34.1


