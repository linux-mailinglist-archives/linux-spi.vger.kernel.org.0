Return-Path: <linux-spi+bounces-5177-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF3C997E8A
	for <lists+linux-spi@lfdr.de>; Thu, 10 Oct 2024 09:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E9E51C2133C
	for <lists+linux-spi@lfdr.de>; Thu, 10 Oct 2024 07:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF451BD4F2;
	Thu, 10 Oct 2024 07:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YXuF8+qb"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8241B5ED6;
	Thu, 10 Oct 2024 07:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728543986; cv=none; b=iWBekrV0L6zULv1Wl0XHdZZRU8P3D6l5Ep2ZHEYSIIZESDqscRR1mNXMAQI8Kw7dGllxce9kfApp1EPpwb8XqKGHRd7x8sYy5ThPrSXTGrK1Yeukwu5sLmfKleYf8A1ysdhCNwW4+NdCkpxj1u+hFrX5p8KI3UdnQCDHl7gA4QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728543986; c=relaxed/simple;
	bh=vuEpQ4RUZxQv/pOsCPinwqX70CELW16laofpwWDKP/4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uS2e17C8q5X+4L/Yxc/sBVvC8h59nlLjBxxjwFq2C0eyvZ8hx/s3FImSZ6o9lE+FO4rQl3Wa++QJGZD9o55wuS7GHj00ox75rVHaNL5zdmqEJAdro6m6/zE38letiCF9yYBBaonm47EjdGrRY+WqXqohR9OoKKpRbiSd58cvwBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YXuF8+qb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49A1bRrv030491;
	Thu, 10 Oct 2024 07:05:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=iWKu71tbyjUY2xSflRyTyV
	MfAOtyEe4rEt6XsCm5LKQ=; b=YXuF8+qbZRJ1ul7iUcpLYzCFDF5rHMTvfN3uXe
	mYmPLFIpAmt8cyG3mfcz+B5vZh3Ys0XCZxumVSyZZN7LKtwDVx2Hg+k1GJ5aqPk2
	xUL6FnZnRp4RerX543vogGMbfpBJP8PsjIgnp/XE9GEM4fiaiAL2w/JfDrOar+P4
	4bZlzPkIPWFP2w4otcx88fIQ+/SR/Pc4f1OT44EVtenzanyxwTCr6bQ3uKwMENp7
	ebubxPaNPNOmnl/hB5gYM5RE3QPvtf67ZRm0OF42thyrfnqxPNVpLI5UzJ+nE0qq
	Py0D4FHGitOcuj9EeUqzfCae2UYiE+/NWGUWtbdLf+FboLCQ==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 424x7ryjyh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Oct 2024 07:05:43 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49A75gPA024983
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Oct 2024 07:05:42 GMT
Received: from hu-mdalam-blr.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 10 Oct 2024 00:05:36 -0700
From: Md Sadre Alam <quic_mdalam@quicinc.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <andersson@kernel.org>,
        <konradybcio@kernel.org>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <vigneshr@ti.com>,
        <manivannan.sadhasivam@linaro.org>, <arnd@arndb.de>,
        <esben@geanix.com>, <nikita.shubin@maquefel.me>,
        <linux-arm-msm@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>
CC: <quic_srichara@quicinc.com>, <quic_varada@quicinc.com>
Subject: [PATCH v11 0/8] Add QPIC SPI NAND driver
Date: Thu, 10 Oct 2024 12:35:02 +0530
Message-ID: <20241010070510.1504250-1-quic_mdalam@quicinc.com>
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
X-Proofpoint-GUID: gEZA7mpsPY_6NXCgAGvtShwtpcQlsGXb
X-Proofpoint-ORIG-GUID: gEZA7mpsPY_6NXCgAGvtShwtpcQlsGXb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 phishscore=0 mlxlogscore=822 spamscore=0 clxscore=1011 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410100045

v11:
 * Dropped Reviewed-by tag
 * Added soc based compatible "qcom,ipq9574-snand"
 * fixed build error reported by kernel test bot by
   changing statement "depends on MTD" to "selct MTD"
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
 drivers/spi/Kconfig                           |    9 +
 drivers/spi/Makefile                          |    1 +
 drivers/spi/spi-qpic-snand.c                  | 1634 +++++++++++++++
 include/linux/mtd/nand-qpic-common.h          |  482 +++++
 12 files changed, 3349 insertions(+), 1442 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/qcom,spi-qpic-snand.yaml
 create mode 100644 drivers/mtd/nand/qpic_common.c
 create mode 100644 drivers/spi/spi-qpic-snand.c
 create mode 100644 include/linux/mtd/nand-qpic-common.h

-- 
2.34.1


