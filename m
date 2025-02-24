Return-Path: <linux-spi+bounces-6890-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 205CBA41C2D
	for <lists+linux-spi@lfdr.de>; Mon, 24 Feb 2025 12:14:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C5C43AAFDC
	for <lists+linux-spi@lfdr.de>; Mon, 24 Feb 2025 11:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A032594BD;
	Mon, 24 Feb 2025 11:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="G1jhEIDp"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBB72F50;
	Mon, 24 Feb 2025 11:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740395693; cv=none; b=Z+6bgT7+bnfXcaB9TTicI/vzP1ImLeozuBgHLuUsPaUhHtp07ixwxNfZstNnol8Jj6xqxivo+hWOesOBn+DSHsJXoz8UMvoJU4c8Z14rzDEgHtDdnRM+cYnq3eqjGUekQjpdGPWfvJl3sDbGspNYs5q1HyF5qVpbsY0VtIMovzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740395693; c=relaxed/simple;
	bh=7XVfpivs/508FDgM+M0v2yslKB76t3gtztOCiUHCwUA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=m0E6VoaclHIUw9tBy1qlNFDQb4z9RdlfBBcthRuuVcQ70BtWgfhUZTBH/5NMigEYjhn5HpeOkkDW/r2rtJ+SK3a3OY2KFrce2P5rHCrUN/FSPZAG+xXDAX0Jt/I0Cto4K4BwcruU/5Tcekk9l3Mb58jUNj9LKQET0HrkXzy2Y4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=G1jhEIDp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51O9SSmu003510;
	Mon, 24 Feb 2025 11:14:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=runldPnSECGMYe8Cfktypq
	hB7KpomuFwreQAJakO/HQ=; b=G1jhEIDpL9o9VviGBKj5Qri5BPvM7DZXXEXcCR
	eXJmj3PXCvAEBdQWv6ir5GXbuHruTg6q5dK1NUvDFep+FG3lCXD2GCYhzkKMyUh9
	G+2th3hBWZkzurl6RFDl0M6X7QaeS5WYvrgcyegyA+gfk/JcFlhhfX7KPeoAb56z
	lq25wEClxKGcTxL0GMfVoRhu+mPHOhzas8BhX29PSMu+Rv5HOfHZ6wqosr7wZxYk
	US5u0Ekbi2UzLsHpRp8R/WPvBn71DLu0RJjZd1rlXzZnDRtjmwuditCYLRivlc0f
	QFSLYzCDPlR1AJsCtGlSHL/GzqV3W39iznKM5Wa+vKcEcQ4A==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44y7rjvr3f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Feb 2025 11:14:32 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51OBEWa1003048
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Feb 2025 11:14:32 GMT
Received: from hu-mdalam-blr.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 24 Feb 2025 03:14:28 -0800
From: Md Sadre Alam <quic_mdalam@quicinc.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <quic_mdalam@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>
Subject: [PATCH v15 0/2] Add QPIC SPI NAND driver
Date: Mon, 24 Feb 2025 16:44:12 +0530
Message-ID: <20250224111414.2809669-1-quic_mdalam@quicinc.com>
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
X-Proofpoint-GUID: R3xmSlKntb05B97PM4FHqhwQIpbUgwch
X-Proofpoint-ORIG-GUID: R3xmSlKntb05B97PM4FHqhwQIpbUgwch
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_04,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 phishscore=0 impostorscore=0 malwarescore=0 adultscore=0 spamscore=0
 priorityscore=1501 mlxlogscore=920 lowpriorityscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502240082

v15:
 * Skipping the following patches
	Merged:-
		mtd: rawnand: qcom: cleanup qcom_nandc driver
		mtd: rawnand: qcom: Add qcom prefix to common api
		mtd: nand: Add qpic_common API file
		mtd: rawnand: qcom: use FIELD_PREP and GENMASK

	Will post a new series per review feedback:-
		arm64: dts: qcom: ipq9574: Add SPI nand support
		arm64: dts: qcom: ipq9574: Remove eMMC node

 * Separate return value and 'cmd' value in qcom_spi_cmd_mapping() to
   avoid 'cmd' with MSB set as failure.

v14:
 * Updated commit message
 * Fix spelling mistake
 * Remove "inline" from multiple APIs from qcom_nandc.c file
 * Move '|' in qcom_param_page_type_exec() APIs at the end of line

v13:
 * Added Reviewed-by tag 
 * Added MODULE_DESCRIPTION() macro
 * Added 2024 Qualcomm Innovation Center Copyright
 * Changed return type of qcom_spi_cmd_mapping() from u32 to
   int to fix the kernel test bot warning
 * Changed type of variable cmd in qcom_spi_write_page() from u32
   to int
 * Removed unused variable s_op from qcom_spi_write_page()
 * Updated return value variable type from u32 to int in
   qcom_spi_send_cmdaddr()

v12:
 * Added EXPORT_SYMBOL() macro for all the api in qpic_common.c
 * Added MODULE_LICENSE() macro in qpic_common.c to build
   qpic_common.c as module as well
 * Removed bool type for CONFIG_MTD_NAND_QCOM to fix build error
   reported by kernel test bot
 * Added obj-$(CONFIG_MTD_NAND_QCOM) += qpic_common.o condition
   in Makefile to build qpic_common.c as built-in or as module
   based on CONFIG_MTD_NAND_QCOM
 * Added Reviewed-by tag
 * Added obj-$(CONFIG_SPI_QPIC_SNAND) += qpic_common.o in Makefile
   to build qpic_common.c based on CONFIG_SPI_QPIC_SNAND
 * Updated commit header and commit message
 * Removed sdhci node from rdp433.dts file 

v11:
 * Dropped Reviewed-by tag
 * Added soc based compatible "qcom,ipq9574-snand"
 * fixed build error reported by kernel test bot by
   changing statement "depends on MTD" to "select MTD"
   in drivers/spi/Kconfig file

v10:
 * Fixed compilation warnings reported by kernel test robot
 * Added depends on CONFIG_MTD for qpic-spi nand driver
 * Removed extra bracket from statement if (i == (num_cw - 1))
   in qcom_spi_program_raw() api.

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
   spi nand related variables
 * Made qpic_common.c selectable based on
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
 * In this series of patches we have added basic working QPIC SPI NAND
   driver with READ, WRITE, ERASE etc functionality

 * Addressed all the comments given in RFC [v1] patch

v1:
 * https://lore.kernel.org/linux-arm-msm/20231031120307.1600689-1-quic_mdalam@quicinc.com/


Md Sadre Alam (2):
  spi: dt-bindings: Introduce qcom,spi-qpic-snand
  spi: spi-qpic: add driver for QCOM SPI NAND flash Interface

 .../bindings/spi/qcom,spi-qpic-snand.yaml     |   83 +
 drivers/mtd/nand/Makefile                     |    4 +
 drivers/spi/Kconfig                           |    9 +
 drivers/spi/Makefile                          |    1 +
 drivers/spi/spi-qpic-snand.c                  | 1631 +++++++++++++++++
 include/linux/mtd/nand-qpic-common.h          |    7 +
 6 files changed, 1735 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/qcom,spi-qpic-snand.yaml
 create mode 100644 drivers/spi/spi-qpic-snand.c


base-commit: d4b0fd87ff0d4338b259dc79b2b3c6f7e70e8afa
-- 
2.34.1


