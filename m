Return-Path: <linux-spi+bounces-9182-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F8DB11B0F
	for <lists+linux-spi@lfdr.de>; Fri, 25 Jul 2025 11:43:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8EE31CC7F21
	for <lists+linux-spi@lfdr.de>; Fri, 25 Jul 2025 09:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46979291C0C;
	Fri, 25 Jul 2025 09:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Gt5aOkPd"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D502C326A;
	Fri, 25 Jul 2025 09:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753436557; cv=none; b=LvNgncV2mmj6lPCQZC3YmrBNFyOFHaEiCZ3lvvJicvZBi1xizLvKhmym1EUgMm+3nh+rwfpeqNoJ38NTm5H6AGknyg4W9av4ALSunO3UB7l1aGKl01iuQIPPLBn2Xf8GjKQGsiZNhKq2BBPs9KMfDgXaDjLT7sWQdiPu6/fya4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753436557; c=relaxed/simple;
	bh=kssAHkmRsnCHR424B4QsdAlZleqyE+EDdZUxpYLmluo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KRB/Y9hxM9Zs+tnsEo3KmNgH0CGMbFd02SZgRf8Dv18dS5KbuT/4HNLRa3MpY90eU4yG1Y70aVHbxJwCfMnElNj9H/iWrWh8BJ6W8RYHotqD11cmEOfEbfdIMPKdXxIcWtbmpumDZytKecwLX4Ixz0KBLMoXewzsglAsueprteU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Gt5aOkPd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56P96JmG015923;
	Fri, 25 Jul 2025 09:42:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uUFHSKcjQlM49h4mGENZnUXtoPzPbWlZq6JkPSqICxM=; b=Gt5aOkPdirx/b2i+
	BCnap17HGOkwb0oLcjEEbzLnhc+hIunG2RBXI+uMTEtha7KtS6dixt+S87BE0h7l
	oyy0OaQOWwSaF5R4sf3HiXObrcC4Glknt4/8qqI0TMBJ8Iy9+KQY/BNuO0JJXg5T
	BhahDMIWHWoq4VYlBf1aMu5XSb1WjOJPm9pu7t4shwxPqBIWRcv2cNTMru/VC22l
	ztQdcveffeHiZHLQcEPPoCBZM2j3POFwjw/KZm/E3slDhle/mlmaTwhM2Fc26QpD
	cNRxEmijz9b+HiDVhgU+y1tyZIueztRmQVFdOz8srDJZ/Xe2wnZ2dbrQOTAfPl7M
	VNlxTw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 483w501kfa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Jul 2025 09:42:21 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 56P9gK6m025270
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Jul 2025 09:42:20 GMT
Received: from haixcui1-gv.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 25 Jul 2025 02:42:17 -0700
From: Haixu Cui <quic_haixcui@quicinc.com>
To: <quic_msavaliy@quicinc.com>, <quic_haixcui@quicinc.com>,
        <broonie@kernel.org>, <virtio-dev@lists.linux.dev>,
        <viresh.kumar@linaro.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <hdanton@sina.com>,
        <qiang4.zhang@linux.intel.com>, <alex.bennee@linaro.org>
CC: <quic_ztu@quicinc.com>, Harald Mommer <harald.mommer@opensynergy.com>
Subject: [RFC PATCH v7 2/3] virtio-spi: Add virtio-spi.h
Date: Fri, 25 Jul 2025 17:41:43 +0800
Message-ID: <20250725094144.1783243-3-quic_haixcui@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250725094144.1783243-1-quic_haixcui@quicinc.com>
References: <20250725094144.1783243-1-quic_haixcui@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Xwgm5_sMH3jJI6Tl8V4es-t7Cn5K037r
X-Proofpoint-ORIG-GUID: Xwgm5_sMH3jJI6Tl8V4es-t7Cn5K037r
X-Authority-Analysis: v=2.4 cv=bKAWIO+Z c=1 sm=1 tr=0 ts=6883517d cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=Wb1JkmetP80A:10 a=bs-e4Z8cAAAA:8 a=COk6AnOGAAAA:8
 a=rqJjEXyH_1KH1bkhQPcA:9 a=YFpLQiK6rFjqGb8m0bXF:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDA4MSBTYWx0ZWRfX9c5r1lQZ33Le
 UzhBiVnKi2+S10y50evVzkC/CKtI6q3SN7Nvfs+Ml8Ece47ZTw6461pH5wP7xm5JFS1NQhz8I2/
 ifECzXHGm9ulq0BHjLOhn1ES5i8KyJXHBeFH5WXs7raikOzTRAIL9uv1iKGNcT/totKyN2eY/Xd
 sHmyrj7ae6i5VDzPT3cOH4raT9WVdhf4KZwBgVRszVdZdAS3QtxyyhMGYflHAApi2/SROmwRozg
 9RPyLnLOG40yKeCEvKwEneMzvhnYvvidv95HUCPAz0kA12W27bzXV1rqBqes3xyM8pTev9HdqBG
 eYuT8bvouC9/S39DbREBdsD8cs9RgqGXiHtfkEIGUXL6jooAFyf60/jCDT8oa6hPRvzgXg/3iE2
 zIOX30AoTFaVeLoPm7DlI1Qj0JjHTvqJWuCeMfGPwZ6NvYZwNEZHy5v7sFozhOQKak5MMfqh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_02,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 spamscore=0 mlxlogscore=999 clxscore=1011
 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507250081

Add virtio-spi.h header for virtio SPI.

Signed-off-by: Harald Mommer <harald.mommer@opensynergy.com>
Signed-off-by: Haixu Cui <quic_haixcui@quicinc.com>
---
 include/uapi/linux/virtio_spi.h | 185 ++++++++++++++++++++++++++++++++
 1 file changed, 185 insertions(+)
 create mode 100644 include/uapi/linux/virtio_spi.h

diff --git a/include/uapi/linux/virtio_spi.h b/include/uapi/linux/virtio_spi.h
new file mode 100644
index 000000000000..db94f32bd229
--- /dev/null
+++ b/include/uapi/linux/virtio_spi.h
@@ -0,0 +1,185 @@
+/* SPDX-License-Identifier: BSD-3-Clause */
+/*
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


