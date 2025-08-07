Return-Path: <linux-spi+bounces-9308-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED97FB1D357
	for <lists+linux-spi@lfdr.de>; Thu,  7 Aug 2025 09:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36D5B3A6E8A
	for <lists+linux-spi@lfdr.de>; Thu,  7 Aug 2025 07:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B77623FC42;
	Thu,  7 Aug 2025 07:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="eajXjZ2k"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB0D242D88;
	Thu,  7 Aug 2025 07:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754551830; cv=none; b=uoJ4LQjmaWkn7g9xvSQPSNpzueGdzYO92ZRZZzr/ti8aLWC1jU/AIVR1Y8et+49rqrVxb1WkglpuZW8G34m84VnzedqTLFvkx/KXeR/ynjxmipewVGktpdC9tIYjXrvv4ibmE+6HLb2AQFTOkYuBdmoji26BOH7YVAgU5OZYIYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754551830; c=relaxed/simple;
	bh=sAyH69uESItE8aXHIr2kl3jVK8e3WgnnnfhiQiDhumM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lG7Agy2suIQz+xOavDjHkqBCU/VfFTeBb+MVBDT84j4JNryPgmSrsZO3GNvbNT+LKlYVCNm2UgpjdDHFUcBBi5Wnh/fg70bZslu5UMRAHJfDKKFBjYTqAoUL04lgSotldnLBKBEVh6hAf3PdB/DxzhkcQcImiLsxDj0oyjtmMKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=eajXjZ2k; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5776S2vp007925;
	Thu, 7 Aug 2025 07:30:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	z5MaIbOYz0PtLGSnt6wVXnwMFFS/2B9lNDTUOVzY3PY=; b=eajXjZ2kQ2XZor47
	JhBTd8mgADQZMS/UNKW757eN8xDQ4HsuubO7AzmDAw8v/LV/RXJY0Jgzvt9DSZZp
	4RgWJ7T3iTCFIGRyozDaKPKzBptuQRmgG8dL/av4LC01Urw2j+X+jQmB51j+wimd
	ZQMKURdWImPGdFABfux+JL46XSo/zgR5aNoWbt1soZ/wP67SosX+iZjNqOw7pYuV
	yALtMFfTbJ3IGsYa0J7IrWGEFQK14V1gsAySLLmd8nRaRZgn8mdIvBVLqzN0hkQ2
	S1rL6KeH9DOmLe+VWbpQeYEB9ZAljECCAdYX2ukiMHwM288EqZM3LNVzJBUFjdOK
	0312vg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48cpvy05pv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Aug 2025 07:30:20 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5777UJSO002971
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 7 Aug 2025 07:30:19 GMT
Received: from haixcui1-gv.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 7 Aug 2025 00:30:16 -0700
From: Haixu Cui <quic_haixcui@quicinc.com>
To: <harald.mommer@oss.qualcomm.com>, <quic_msavaliy@quicinc.com>,
        <quic_haixcui@quicinc.com>, <broonie@kernel.org>,
        <virtio-dev@lists.linux.dev>, <viresh.kumar@linaro.org>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <hdanton@sina.com>, <qiang4.zhang@linux.intel.com>,
        <alex.bennee@linaro.org>
CC: <quic_ztu@quicinc.com>
Subject: [RFC PATCH v8 2/3] virtio-spi: Add virtio-spi.h
Date: Thu, 7 Aug 2025 15:29:35 +0800
Message-ID: <20250807072936.4155687-3-quic_haixcui@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250807072936.4155687-1-quic_haixcui@quicinc.com>
References: <20250807072936.4155687-1-quic_haixcui@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=TJpFS0la c=1 sm=1 tr=0 ts=6894560c cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=rqJjEXyH_1KH1bkhQPcA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: jJL_mRA02hD9EfferZ1x8RM6sTopCnnW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA3MDA0NiBTYWx0ZWRfX67Ogoh3ydfwu
 BiDQruzK2KIHDIvkH4R+xvLMqHOd6zIEkRzRM5IMLTrHLqAB0Q+4HjD3/+zaCGXQ9fkfKWjTQg6
 Cb66tbdsSBXNDDF7igFD75fQ388odJtwhe1EQImu1iXXzY3viOTHhgt+VEkoPXPS0zgejuqWXDf
 M9+Np6FkmxqfPy2R7sWf9Yys9hAWhj5ZJUVYjG58s9WmQXR2XASMN1IB5EAaGyuizWG5s+Jdd+m
 7uvIVoM406jnPLwYHAJm+rQ0yo1OZINiga9jXCCx+aVODHuTCbCFSBKM9PITJ68OWOghhgd2w/g
 vqZiufwk33TUz0WUaY/vXvd9eii3l5yghna1zV64NV93y6LGSvrxv/JhbCcyInQqAwBjQfxiLcB
 aM2DsvUx
X-Proofpoint-ORIG-GUID: jJL_mRA02hD9EfferZ1x8RM6sTopCnnW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_05,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 adultscore=0 spamscore=0 malwarescore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508070046

Add virtio-spi.h header for virtio SPI.

Signed-off-by: Haixu Cui <quic_haixcui@quicinc.com>
---
 include/uapi/linux/virtio_spi.h | 186 ++++++++++++++++++++++++++++++++
 1 file changed, 186 insertions(+)
 create mode 100644 include/uapi/linux/virtio_spi.h

diff --git a/include/uapi/linux/virtio_spi.h b/include/uapi/linux/virtio_spi.h
new file mode 100644
index 000000000000..c503c6f7ca09
--- /dev/null
+++ b/include/uapi/linux/virtio_spi.h
@@ -0,0 +1,186 @@
+/* SPDX-License-Identifier: BSD-3-Clause */
+/*
+ * Copyright (C) 2023 OpenSynergy GmbH
+ * Copyright (C) 2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+#ifndef _LINUX_VIRTIO_VIRTIO_SPI_H
+#define _LINUX_VIRTIO_VIRTIO_SPI_H
+
+#include <linux/types.h>
+#include <linux/virtio_config.h>
+#include <linux/virtio_ids.h>
+#include <linux/virtio_types.h>
+
+/* Sample data on trailing clock edge */
+#define VIRTIO_SPI_CPHA			BIT(0)
+/* Clock is high when IDLE */
+#define VIRTIO_SPI_CPOL			BIT(1)
+/* Chip Select is active high */
+#define VIRTIO_SPI_CS_HIGH		BIT(2)
+/* Transmit LSB first */
+#define VIRTIO_SPI_MODE_LSB_FIRST	BIT(3)
+/* Loopback mode */
+#define VIRTIO_SPI_MODE_LOOP		BIT(4)
+
+/*
+ * All config fields are read-only for the Virtio SPI driver
+ *
+ * @cs_max_number: maximum number of chipselect the host SPI controller
+ *   supports.
+ * @cs_change_supported: indicates if the host SPI controller supports to toggle
+ * chipselect after each transfer in one message:
+ *   0: unsupported, chipselect will be kept in active state throughout the
+ *      message transaction;
+ *   1: supported.
+ *   Note: Message here contains a sequence of SPI transfers.
+ * @tx_nbits_supported: indicates the supported number of bit for writing:
+ *   bit 0: DUAL (2-bit transfer), 1 for supported
+ *   bit 1: QUAD (4-bit transfer), 1 for supported
+ *   bit 2: OCTAL (8-bit transfer), 1 for supported
+ *   other bits are reserved as 0, 1-bit transfer is always supported.
+ * @rx_nbits_supported: indicates the supported number of bit for reading:
+ *   bit 0: DUAL (2-bit transfer), 1 for supported
+ *   bit 1: QUAD (4-bit transfer), 1 for supported
+ *   bit 2: OCTAL (8-bit transfer), 1 for supported
+ *   other bits are reserved as 0, 1-bit transfer is always supported.
+ * @bits_per_word_mask: mask indicating which values of bits_per_word are
+ *   supported. If not set, no limitation for bits_per_word.
+ * @mode_func_supported: indicates the following features are supported or not:
+ *   bit 0-1: CPHA feature
+ *     0b00: invalid, should support as least one CPHA setting
+ *     0b01: supports CPHA=0 only
+ *     0b10: supports CPHA=1 only
+ *     0b11: supports CPHA=0 and CPHA=1.
+ *   bit 2-3: CPOL feature
+ *     0b00: invalid, should support as least one CPOL setting
+ *     0b01: supports CPOL=0 only
+ *     0b10: supports CPOL=1 only
+ *     0b11: supports CPOL=0 and CPOL=1.
+ *   bit 4: chipselect active high feature, 0 for unsupported and 1 for
+ *     supported, chipselect active low is supported by default.
+ *   bit 5: LSB first feature, 0 for unsupported and 1 for supported,
+ *     MSB first is supported by default.
+ *   bit 6: loopback mode feature, 0 for unsupported and 1 for supported,
+ *     normal mode is supported by default.
+ * @max_freq_hz: the maximum clock rate supported in Hz unit, 0 means no
+ *   limitation for transfer speed.
+ * @max_word_delay_ns: the maximum word delay supported in ns unit,
+ *   0 means word delay feature is unsupported.
+ *   Note: Just as one message contains a sequence of transfers,
+ *         one transfer may contain a sequence of words.
+ * @max_cs_setup_ns: the maximum delay supported after chipselect is asserted,
+ *   in ns unit, 0 means delay is not supported to introduce after chipselect is
+ *   asserted.
+ * @max_cs_hold_ns: the maximum delay supported before chipselect is deasserted,
+ *   in ns unit, 0 means delay is not supported to introduce before chipselect
+ *   is deasserted.
+ * @max_cs_incative_ns: maximum delay supported after chipselect is deasserted,
+ *   in ns unit, 0 means delay is not supported to introduce after chipselect is
+ *   deasserted.
+ */
+struct virtio_spi_config {
+	/* # of /dev/spidev<bus_num>.CS with CS=0..chip_select_max_number -1 */
+	__u8 cs_max_number;
+	__u8 cs_change_supported;
+#define VIRTIO_SPI_RX_TX_SUPPORT_DUAL		BIT(0)
+#define VIRTIO_SPI_RX_TX_SUPPORT_QUAD		BIT(1)
+#define VIRTIO_SPI_RX_TX_SUPPORT_OCTAL		BIT(2)
+	__u8 tx_nbits_supported;
+	__u8 rx_nbits_supported;
+	__le32 bits_per_word_mask;
+#define VIRTIO_SPI_MF_SUPPORT_CPHA_0		BIT(0)
+#define VIRTIO_SPI_MF_SUPPORT_CPHA_1		BIT(1)
+#define VIRTIO_SPI_MF_SUPPORT_CPOL_0		BIT(2)
+#define VIRTIO_SPI_MF_SUPPORT_CPOL_1		BIT(3)
+#define VIRTIO_SPI_MF_SUPPORT_CS_HIGH		BIT(4)
+#define VIRTIO_SPI_MF_SUPPORT_LSB_FIRST		BIT(5)
+#define VIRTIO_SPI_MF_SUPPORT_LOOPBACK		BIT(6)
+	__le32 mode_func_supported;
+	__le32 max_freq_hz;
+	__le32 max_word_delay_ns;
+	__le32 max_cs_setup_ns;
+	__le32 max_cs_hold_ns;
+	__le32 max_cs_inactive_ns;
+};
+
+/*
+ * @chip_select_id: chipselect index the SPI transfer used.
+ *
+ * @bits_per_word: the number of bits in each SPI transfer word.
+ *
+ * @cs_change: whether to deselect device after finishing this transfer
+ *     before starting the next transfer, 0 means cs keep asserted and
+ *     1 means cs deasserted then asserted again.
+ *
+ * @tx_nbits: bus width for write transfer.
+ *     0,1: bus width is 1, also known as SINGLE
+ *     2  : bus width is 2, also known as DUAL
+ *     4  : bus width is 4, also known as QUAD
+ *     8  : bus width is 8, also known as OCTAL
+ *     other values are invalid.
+ *
+ * @rx_nbits: bus width for read transfer.
+ *     0,1: bus width is 1, also known as SINGLE
+ *     2  : bus width is 2, also known as DUAL
+ *     4  : bus width is 4, also known as QUAD
+ *     8  : bus width is 8, also known as OCTAL
+ *     other values are invalid.
+ *
+ * @reserved: for future use.
+ *
+ * @mode: SPI transfer mode.
+ *     bit 0: CPHA, determines the timing (i.e. phase) of the data
+ *         bits relative to the clock pulses.For CPHA=0, the
+ *         "out" side changes the data on the trailing edge of the
+ *         preceding clock cycle, while the "in" side captures the data
+ *         on (or shortly after) the leading edge of the clock cycle.
+ *         For CPHA=1, the "out" side changes the data on the leading
+ *         edge of the current clock cycle, while the "in" side
+ *         captures the data on (or shortly after) the trailing edge of
+ *         the clock cycle.
+ *     bit 1: CPOL, determines the polarity of the clock. CPOL=0 is a
+ *         clock which idles at 0, and each cycle consists of a pulse
+ *         of 1. CPOL=1 is a clock which idles at 1, and each cycle
+ *         consists of a pulse of 0.
+ *     bit 2: CS_HIGH, if 1, chip select active high, else active low.
+ *     bit 3: LSB_FIRST, determines per-word bits-on-wire, if 0, MSB
+ *         first, else LSB first.
+ *     bit 4: LOOP, loopback mode.
+ *
+ * @freq: the transfer speed in Hz.
+ *
+ * @word_delay_ns: delay to be inserted between consecutive words of a
+ *     transfer, in ns unit.
+ *
+ * @cs_setup_ns: delay to be introduced after CS is asserted, in ns
+ *     unit.
+ *
+ * @cs_delay_hold_ns: delay to be introduced before CS is deasserted
+ *     for each transfer, in ns unit.
+ *
+ * @cs_change_delay_inactive_ns: delay to be introduced after CS is
+ *     deasserted and before next asserted, in ns unit.
+ */
+struct spi_transfer_head {
+	__u8 chip_select_id;
+	__u8 bits_per_word;
+	__u8 cs_change;
+	__u8 tx_nbits;
+	__u8 rx_nbits;
+	__u8 reserved[3];
+	__le32 mode;
+	__le32 freq;
+	__le32 word_delay_ns;
+	__le32 cs_setup_ns;
+	__le32 cs_delay_hold_ns;
+	__le32 cs_change_delay_inactive_ns;
+};
+
+struct spi_transfer_result {
+#define VIRTIO_SPI_TRANS_OK	0
+#define VIRTIO_SPI_PARAM_ERR	1
+#define VIRTIO_SPI_TRANS_ERR	2
+	__u8 result;
+};
+
+#endif /* #ifndef _LINUX_VIRTIO_VIRTIO_SPI_H */
-- 
2.34.1


