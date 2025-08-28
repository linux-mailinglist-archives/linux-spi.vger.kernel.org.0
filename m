Return-Path: <linux-spi+bounces-9684-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E5EA9B3985F
	for <lists+linux-spi@lfdr.de>; Thu, 28 Aug 2025 11:35:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A8A474E1C50
	for <lists+linux-spi@lfdr.de>; Thu, 28 Aug 2025 09:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F072D7DF2;
	Thu, 28 Aug 2025 09:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZpDrCFrY"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA872BD5BF;
	Thu, 28 Aug 2025 09:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756373742; cv=none; b=rv87r1SbmCLdgBx9ec19I0g2zFhdoyUMSs0RLdt46g/H1PMeXAmT+Npd0MChBJozDJZuD8l4IQoPUxsrTuRF1LZ/Y1VYsnXTHGOI20hMyxS0iT1drk99UObLvApWJ862EAXuxRILiq3HYs4lI/7alcx3oPhSu8ZgX+MiQDK+We8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756373742; c=relaxed/simple;
	bh=OZkDAmkv2aNrak69K0oTeLgSiGUso6xoQd6W1xtrgm4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QLgB/P2DtNfv9xaM/oRZmYnjRbesOf8J3jZngWBfPmZ7eDz+rtPZx+WRUeQmzpJOixbDj7jm4OkwikID1IbOB86VywVU0xjc9lpZVn+LiIjWFILm82j8z1O8YAvFApn3mpzv0UlvHy5LayiLNJxdIxm4ZnzlzRTxzvaMJC5Tt20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ZpDrCFrY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57S5nuLo015950;
	Thu, 28 Aug 2025 09:35:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bcuw++0VBS+yA70Y39SUs9cF76+4nMyln0GJ6PA4R9s=; b=ZpDrCFrYOYB514hu
	Mg1nt2YY8kTfZRhwRxsBUk3YQaRgPcYDRY0zudAcN6dtZrPMiXHA4BuFpAYO9VqP
	jcF/frPaZWGF0FpDpemHBu09UI+OtdsYkTQsNY1p2+C/jvCD1Wev9Nftr2fSjRdj
	wsrupBOy/J6C2syrZFH44VGUqy36liCQeIF/urEbJdRVnipRH07CPaPwELR96zEz
	kpEtIHnRLtMYCLsRL30TdT6toN5NdSry5ac97hgOj0KCA3gerXHEQLErg23j+oPB
	KWDIlMKzWS/TkWxa5gACgQMX9aAWpRNse6rsE97APMVXDZbq3uYFPYUNS2lQiJcE
	Rc0ojQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48rtpf214k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Aug 2025 09:35:22 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 57S9ZKrC011149
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Aug 2025 09:35:20 GMT
Received: from haixcui1-gv.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Thu, 28 Aug 2025 02:35:17 -0700
From: Haixu Cui <quic_haixcui@quicinc.com>
To: <andriy.shevchenko@intel.com>, <harald.mommer@oss.qualcomm.com>,
        <quic_msavaliy@quicinc.com>, <quic_haixcui@quicinc.com>,
        <broonie@kernel.org>, <virtio-dev@lists.linux.dev>,
        <viresh.kumar@linaro.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <hdanton@sina.com>,
        <qiang4.zhang@linux.intel.com>, <alex.bennee@linaro.org>
CC: <quic_ztu@quicinc.com>, <virtualization@lists.linux-foundation.org>
Subject: [PATCH v9 2/3] virtio-spi: Add virtio-spi.h
Date: Thu, 28 Aug 2025 17:34:50 +0800
Message-ID: <20250828093451.2401448-3-quic_haixcui@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250828093451.2401448-1-quic_haixcui@quicinc.com>
References: <20250828093451.2401448-1-quic_haixcui@quicinc.com>
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
X-Proofpoint-GUID: 5HluWi42TYG0ldcaA65Y3Rk1vefwJxaa
X-Proofpoint-ORIG-GUID: 5HluWi42TYG0ldcaA65Y3Rk1vefwJxaa
X-Authority-Analysis: v=2.4 cv=Hd8UTjE8 c=1 sm=1 tr=0 ts=68b022da cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=Z4Rwk6OoAAAA:8
 a=VwQbUJbxAAAA:8 a=rqJjEXyH_1KH1bkhQPcA:9 a=TjNXssC_j7lpFel5tvFf:22
 a=HkZW87K1Qel5hWWM3VKY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI1MDE0MiBTYWx0ZWRfX201JJ5mIk1Vw
 HVRI6aVvtRpVWZ27sopt/8rspFxUIU+k/0arz3X9fdJbnS7R/NtfFt+xOIlPMp7Cz4Ze21aGHCY
 qWFYGOI88Jghhm1cHXazc/n1ELW/lcFPii0E74A+GYdyueRrqUtlF7DhPokUwSxBoTP/F5aaWNR
 os3U0PXmtPY4ukO4cU4zHtUW9++8mCBTHzaHCAzav9LSZK0lzmWrbmQhv7IHh/HKinGDDPRBxQY
 o+LKZmWzHd+Bi2FCgvQgZCmQ0efAf7/GqwTlRP4Sznq+i8S634tQBN65rgF1etkBoqy4FVkVMY+
 CYeku31Wyy3pOhiBc7pYiek9KWbM23vyQkYc1GTdcnSMXaV7sB6n2TOplNTNLXjxycWO23OVtQo
 eK6ieTWz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_02,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 adultscore=0 clxscore=1011 impostorscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508250142

Add virtio-spi.h header for virtio SPI.

Signed-off-by: Haixu Cui <quic_haixcui@quicinc.com>
---
 MAINTAINERS                     |   6 ++
 include/uapi/linux/virtio_spi.h | 181 ++++++++++++++++++++++++++++++++
 2 files changed, 187 insertions(+)
 create mode 100644 include/uapi/linux/virtio_spi.h

diff --git a/MAINTAINERS b/MAINTAINERS
index fed6cd812d79..af98e411138d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -26790,6 +26790,12 @@ S:	Maintained
 F:	include/uapi/linux/virtio_snd.h
 F:	sound/virtio/*
 
+VIRTIO SPI DRIVER
+M:	Haixu Cui <quic_haixcui@quicinc.com>
+L:	virtualization@lists.linux-foundation.org
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


