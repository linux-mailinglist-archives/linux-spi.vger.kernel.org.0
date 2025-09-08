Return-Path: <linux-spi+bounces-9941-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5202B48840
	for <lists+linux-spi@lfdr.de>; Mon,  8 Sep 2025 11:24:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8278B3C4624
	for <lists+linux-spi@lfdr.de>; Mon,  8 Sep 2025 09:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92541E1E19;
	Mon,  8 Sep 2025 09:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BbzNeHyr"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144712F066A;
	Mon,  8 Sep 2025 09:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757323472; cv=none; b=YA/wpIwI9EA+xtkBmrDg141x+7HzOnv8lE+7Nz5lLZ3Yc3g3AUdrAa9rpezDMn+VAvQPiRXrpzhVCEKhyrGP0ZRBJg/1jdStkHr8gfO6tGp89fPHYC0k2snVZOpYh1irdbolEd9ZiDUQidXK5GKAz2gSZEmOu1g/qz+pWTg+D64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757323472; c=relaxed/simple;
	bh=y3OV92ZBfjz9Unv45KjmT75My/jD9kH0gpa0afCTmnI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vd+D/1lknmgTXgsJT8mc3HBiugFshVWxroF//9XdOlwixDwvzDywm4Q/IER6LT9XZblyjFcCcegycSfLO3j/xVwzt19a0cR4KaQg+WUI2S+rzEEBA4eEJnGRzvKvQjS064y96rBexfI/A1jjJUiTV9GFFswQpaxuiC4hAF/49Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=BbzNeHyr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5880K3R8018961;
	Mon, 8 Sep 2025 09:24:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dljVRImY4V6dI88vlkoSWy4DEhe3I30NGPKOhgkN7iE=; b=BbzNeHyrrGQPSel3
	mCYfGJxDkh3GnNMa+pjTsgBG9rhlgmTae22BVuAcFJnAm4FEKgsjUUdc1szZtG/5
	KIz0Y1pEbqsQ9HC9xmDRYzCl668QbTe25WIUZ80bFcPxu5AAASAMegAnIC3vJysL
	xOUAHRyFZm6qU8kFTasVScRl+SrvhVpXBdntl5wJcrij6QNPDI5xc2MnihBU/WMd
	FnjxrMOL4oqoxw0CPmqtBIuW8PPdAAsUtMoZA446EtTQ5rluELdK5l76C6bpVDPR
	jeAKye1PQu4wXsVl50MXES1Lw/PnqdqTgOo83ob3ORE2FJsBQJsjJgpr98sa/ZVs
	bJ6ytQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490e8a3xva-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Sep 2025 09:24:21 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5889OKHw016681
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 8 Sep 2025 09:24:20 GMT
Received: from haixcui1-gv.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Mon, 8 Sep 2025 02:24:17 -0700
From: Haixu Cui <quic_haixcui@quicinc.com>
To: <andriy.shevchenko@intel.com>, <harald.mommer@oss.qualcomm.com>,
        <quic_msavaliy@quicinc.com>, <quic_haixcui@quicinc.com>,
        <broonie@kernel.org>, <virtio-dev@lists.linux.dev>,
        <viresh.kumar@linaro.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <hdanton@sina.com>,
        <qiang4.zhang@linux.intel.com>, <alex.bennee@linaro.org>
CC: <virtualization@lists.linux-foundation.org>, <quic_ztu@quicinc.com>
Subject: [PATCH v10 2/3] virtio-spi: Add virtio-spi.h
Date: Mon, 8 Sep 2025 17:23:47 +0800
Message-ID: <20250908092348.1283552-3-quic_haixcui@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250908092348.1283552-1-quic_haixcui@quicinc.com>
References: <20250908092348.1283552-1-quic_haixcui@quicinc.com>
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
X-Authority-Analysis: v=2.4 cv=H7Dbw/Yi c=1 sm=1 tr=0 ts=68bea0c5 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=VwQbUJbxAAAA:8
 a=rqJjEXyH_1KH1bkhQPcA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 6i7cUxQGdkJGXombLjOq2QGkpNhUqOiY
X-Proofpoint-ORIG-GUID: 6i7cUxQGdkJGXombLjOq2QGkpNhUqOiY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzOSBTYWx0ZWRfX2PNqwNnRFMpy
 EhnIUS1R4mzSo67ANOyxLnDoXvoAPXQPIfQSukFSj1djmF0/FnbpZedb4cjuOHzNhA6vwfTtkzE
 jixxWcHGdYfpNrqYqoo10/dcdw0C+18XdtZSIGYbaokq0DS5YB6lwNqsbq+5j/kgekPLPAnoNEs
 mWVEFUVAcvsNUwXqJiNMhO/P3im4N4b/C7LJVcmd/okL+5g2FqsQIGpkFDFw+PfmqbLhJ4G91sC
 VBV/B+9il2FmbO7Z6P4WEvnPTvbY53ZwvOab3y+t+56AGcQ4QM27HwiuCzrjOi/iKcVG49QqvDp
 Gx3WMYcTT/UbdRXtcfuJVxlAE7gUAqteEyF76X4mlNHx1bkdQZq3e+8ZIUITYNbADtwyF8eu5c9
 HnjYQRp7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_03,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0 phishscore=0
 clxscore=1015 suspectscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060039

Add virtio-spi.h header for virtio SPI.

Signed-off-by: Haixu Cui <quic_haixcui@quicinc.com>
---
 MAINTAINERS                     |   6 ++
 include/uapi/linux/virtio_spi.h | 181 ++++++++++++++++++++++++++++++++
 2 files changed, 187 insertions(+)
 create mode 100644 include/uapi/linux/virtio_spi.h

diff --git a/MAINTAINERS b/MAINTAINERS
index cd7ff55b5d32..bd3877016ec5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -26797,6 +26797,12 @@ S:	Maintained
 F:	include/uapi/linux/virtio_snd.h
 F:	sound/virtio/*
 
+VIRTIO SPI DRIVER
+M:	Haixu Cui <quic_haixcui@quicinc.com>
+L:	virtualization@lists.linux.dev
+S:	Maintained
+F:	include/uapi/linux/virtio_spi.h
+
 VIRTUAL BOX GUEST DEVICE DRIVER
 M:	Hans de Goede <hansg@kernel.org>
 M:	Arnd Bergmann <arnd@arndb.de>
diff --git a/include/uapi/linux/virtio_spi.h b/include/uapi/linux/virtio_spi.h
new file mode 100644
index 000000000000..8ab3c970cdd3
--- /dev/null
+++ b/include/uapi/linux/virtio_spi.h
@@ -0,0 +1,181 @@
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
+#define VIRTIO_SPI_CPHA			_BITUL(0)
+/* Clock is high when IDLE */
+#define VIRTIO_SPI_CPOL			_BITUL(1)
+/* Chip Select is active high */
+#define VIRTIO_SPI_CS_HIGH			_BITUL(2)
+/* Transmit LSB first */
+#define VIRTIO_SPI_MODE_LSB_FIRST		_BITUL(3)
+/* Loopback mode */
+#define VIRTIO_SPI_MODE_LOOP			_BITUL(4)
+
+/**
+ * struct virtio_spi_config - All config fields are read-only for the
+ * Virtio SPI driver
+ * @cs_max_number: maximum number of chipselect the host SPI controller
+ *   supports.
+ * @cs_change_supported: indicates if the host SPI controller supports to toggle
+ *   chipselect after each transfer in one message:
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
+ * @max_word_delay_ns: the maximum word delay supported, in nanoseconds.
+ *   A value of 0 indicates that word delay is unsupported.
+ *   Each transfer may consist of a sequence of words.
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
+	__u8 cs_max_number;
+	__u8 cs_change_supported;
+#define VIRTIO_SPI_RX_TX_SUPPORT_DUAL		_BITUL(0)
+#define VIRTIO_SPI_RX_TX_SUPPORT_QUAD		_BITUL(1)
+#define VIRTIO_SPI_RX_TX_SUPPORT_OCTAL		_BITUL(2)
+	__u8 tx_nbits_supported;
+	__u8 rx_nbits_supported;
+	__le32 bits_per_word_mask;
+#define VIRTIO_SPI_MF_SUPPORT_CPHA_0		_BITUL(0)
+#define VIRTIO_SPI_MF_SUPPORT_CPHA_1		_BITUL(1)
+#define VIRTIO_SPI_MF_SUPPORT_CPOL_0		_BITUL(2)
+#define VIRTIO_SPI_MF_SUPPORT_CPOL_1		_BITUL(3)
+#define VIRTIO_SPI_MF_SUPPORT_CS_HIGH		_BITUL(4)
+#define VIRTIO_SPI_MF_SUPPORT_LSB_FIRST		_BITUL(5)
+#define VIRTIO_SPI_MF_SUPPORT_LOOPBACK		_BITUL(6)
+	__le32 mode_func_supported;
+	__le32 max_freq_hz;
+	__le32 max_word_delay_ns;
+	__le32 max_cs_setup_ns;
+	__le32 max_cs_hold_ns;
+	__le32 max_cs_inactive_ns;
+};
+
+/**
+ * struct spi_transfer_head - virtio SPI transfer descriptor
+ * @chip_select_id: chipselect index the SPI transfer used.
+ * @bits_per_word: the number of bits in each SPI transfer word.
+ * @cs_change: whether to deselect device after finishing this transfer
+ *     before starting the next transfer, 0 means cs keep asserted and
+ *     1 means cs deasserted then asserted again.
+ * @tx_nbits: bus width for write transfer.
+ *     0,1: bus width is 1, also known as SINGLE
+ *     2  : bus width is 2, also known as DUAL
+ *     4  : bus width is 4, also known as QUAD
+ *     8  : bus width is 8, also known as OCTAL
+ *     other values are invalid.
+ * @rx_nbits: bus width for read transfer.
+ *     0,1: bus width is 1, also known as SINGLE
+ *     2  : bus width is 2, also known as DUAL
+ *     4  : bus width is 4, also known as QUAD
+ *     8  : bus width is 8, also known as OCTAL
+ *     other values are invalid.
+ * @reserved: for future use.
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
+ * @freq: the transfer speed in Hz.
+ * @word_delay_ns: delay to be inserted between consecutive words of a
+ *     transfer, in ns unit.
+ * @cs_setup_ns: delay to be introduced after CS is asserted, in ns
+ *     unit.
+ * @cs_delay_hold_ns: delay to be introduced before CS is deasserted
+ *     for each transfer, in ns unit.
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
+/**
+ * struct spi_transfer_result - virtio SPI transfer result
+ * @result: Transfer result code.
+ *          VIRTIO_SPI_TRANS_OK: Transfer successful.
+ *          VIRTIO_SPI_PARAM_ERR: Parameter error.
+ *          VIRTIO_SPI_TRANS_ERR: Transfer error.
+ */
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


