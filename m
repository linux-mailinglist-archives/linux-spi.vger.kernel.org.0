Return-Path: <linux-spi+bounces-9545-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB7CBB2D718
	for <lists+linux-spi@lfdr.de>; Wed, 20 Aug 2025 10:52:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C1BE72062B
	for <lists+linux-spi@lfdr.de>; Wed, 20 Aug 2025 08:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5224E2D9EE2;
	Wed, 20 Aug 2025 08:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hZ8rIp5H"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F952D9EF8;
	Wed, 20 Aug 2025 08:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755679866; cv=none; b=Ngz6zI5TMPs+K7AyMg+pVzqRFsH9ZUIaebWlActl5il1ADDNWTcoEOjN0KFy7OR82aXtA1oP4ydiSET+YMR3t3/LnTZvZsFizKvxkEJVPJGFoMHvflxVtAE//f0UaXLrw7+kEtcaHINwLm6sbDY4RNtKITnKvH7dzqREhcTni/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755679866; c=relaxed/simple;
	bh=qjgrTb9UGLKl+oJivOFr5qAqy4lJlzgCcODzJWsqyVA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kOwo4TAA78Qpm6TB9KNjlzmsj4HnRiDxEmQYeo0nnvFZ/+vEuX9J9UACu4NPncg+xtSHJPiTxFeZZQPVQpiCqTnTH9MCydsskytvf5t8uYp0ztr1+zTpuZiSPQ0Xn+aP1z3hN4wnnqqnsM31WVmJDbTOte3EPsIChTeaWzRJPT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hZ8rIp5H; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57K1pKu5010171;
	Wed, 20 Aug 2025 08:50:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+zhQ5Aab8H1BnQElTRvnaIoKl/zrVd56eCtaBWCLDWo=; b=hZ8rIp5Hv1CwdkXX
	1y3E0NDV6byBYIdhk/uIxIzZDpfRKQHPLbgY0zoxG6aHC2BLjry/RlDoQJljn3kO
	2konswdHbcWe4B8ed4tqaEmMyiIeSC2e/tdGxgyd09wdQHHaH6MqSO6gc6mPq5Xc
	0C6naSwb6RxPioKUgg1dRP8FHKsUsVKzhuMxKwdAHt1e/0M0bBtoRNFaXCrtpgi6
	p7thOcGzjVtgYMpSwp79gle7J2ssqyWrf77Uez2Xtq0F/fzhpy9BdSD4pG7jf5sK
	OmNz37UFMi6RzG1xJDzWMgL/1YDt/2rQt3fKV6thBg0sf/PDVdFPNldhK9//6+K7
	W4NYXg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n52a12jc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Aug 2025 08:50:51 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 57K8oo4C027002
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Aug 2025 08:50:50 GMT
Received: from haixcui1-gv.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 20 Aug 2025 01:50:47 -0700
From: Haixu Cui <quic_haixcui@quicinc.com>
To: <andriy.shevchenko@intel.com>, <harald.mommer@oss.qualcomm.com>,
        <quic_msavaliy@quicinc.com>, <quic_haixcui@quicinc.com>,
        <broonie@kernel.org>, <virtio-dev@lists.linux.dev>,
        <viresh.kumar@linaro.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <hdanton@sina.com>,
        <qiang4.zhang@linux.intel.com>, <alex.bennee@linaro.org>
CC: <quic_ztu@quicinc.com>
Subject: [PATCH v4 3/3] SPI: Add virtio SPI driver
Date: Wed, 20 Aug 2025 16:49:44 +0800
Message-ID: <20250820084944.84505-4-quic_haixcui@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250820084944.84505-1-quic_haixcui@quicinc.com>
References: <20250820084944.84505-1-quic_haixcui@quicinc.com>
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
X-Authority-Analysis: v=2.4 cv=feD0C0QF c=1 sm=1 tr=0 ts=68a58c6b cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=n0-Sf9z_k3ELN0rn3eUA:9
 a=TjNXssC_j7lpFel5tvFf:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: 4rKIgsUeEm9cdyeUR1uf6OdBLL5dAKLY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfX4cUK2Iqzw0M8
 gmvK6GJh5rlP7ySRdKoQci02+F8fMur1Op0R2MDVwClb2qeLm4A3oGI53TJs2yXo85ErQsc8Kld
 6TJ9OM6n9b4tV4/Vx0lKizaFv77TNKEULE2jSRTyeKxD2JApICkqxghABZYunnj9f9A7ZTKLNMw
 kPSYyrfBvAmw9LEryh8FOeWbSPhTmg6bVPZS1KLugMqK50g1NqoGom94pffzUN/h/LTfD0szHQ/
 aVXa4ZYBB1pomHVs6l3TRu3OQCbF4RG0aFCU6bCVP+Wkvvdwpx3bt1dQGmkEQRe9mm7ANoldaF5
 MO3wfLvQ37Nl2tOblDGf7pKfLJcPsSyA6dOyACWcAjTClNM0P6ZOs/lOFo3jQEoUVUcbAdmzOOp
 LWafw2YhfHrwMhw1gUYoJh60rrCMiA==
X-Proofpoint-GUID: 4rKIgsUeEm9cdyeUR1uf6OdBLL5dAKLY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_03,2025-08-20_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

This is the virtio SPI Linux kernel driver.

Signed-off-by: Haixu Cui <quic_haixcui@quicinc.com>
---
 MAINTAINERS              |   1 +
 drivers/spi/Kconfig      |  11 +
 drivers/spi/Makefile     |   1 +
 drivers/spi/spi-virtio.c | 448 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 461 insertions(+)
 create mode 100644 drivers/spi/spi-virtio.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 3e289677ca18..ba276c71ec44 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -26763,6 +26763,7 @@ F:	sound/virtio/*
 VIRTIO SPI DRIVER
 M:	Haixu Cui <quic_haixcui@quicinc.com>
 S:	Maintained
+F:	drivers/spi/spi-virtio.c
 F:	include/uapi/linux/virtio_spi.h
 
 VIRTUAL BOX GUEST DEVICE DRIVER
diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 891729c9c564..7b609013fb05 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -1224,6 +1224,17 @@ config SPI_UNIPHIER
 
 	  If your SoC supports SCSSI, say Y here.
 
+config SPI_VIRTIO
+	tristate "Virtio SPI Controller"
+	depends on SPI_MASTER && VIRTIO
+	help
+	  If you say yes to this option, support will be included for the virtio
+	  SPI controller driver. The hardware can be emulated by any device model
+	  software according to the virtio protocol.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called spi-virtio.
+
 config SPI_XCOMM
 	tristate "Analog Devices AD-FMCOMMS1-EBZ SPI-I2C-bridge driver"
 	depends on I2C
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index 062c85989c8c..27a7cf68d55d 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -158,6 +158,7 @@ spi-thunderx-objs			:= spi-cavium.o spi-cavium-thunderx.o
 obj-$(CONFIG_SPI_THUNDERX)		+= spi-thunderx.o
 obj-$(CONFIG_SPI_TOPCLIFF_PCH)		+= spi-topcliff-pch.o
 obj-$(CONFIG_SPI_UNIPHIER)		+= spi-uniphier.o
+obj-$(CONFIG_SPI_VIRTIO)		+= spi-virtio.o
 obj-$(CONFIG_SPI_XCOMM)		+= spi-xcomm.o
 obj-$(CONFIG_SPI_XILINX)		+= spi-xilinx.o
 obj-$(CONFIG_SPI_XLP)			+= spi-xlp.o
diff --git a/drivers/spi/spi-virtio.c b/drivers/spi/spi-virtio.c
new file mode 100644
index 000000000000..e413c9cc73de
--- /dev/null
+++ b/drivers/spi/spi-virtio.c
@@ -0,0 +1,448 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * SPI bus driver for the Virtio SPI controller
+ * Copyright (C) 2023 OpenSynergy GmbH
+ * Copyright (C) 2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include <linux/completion.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/spi/spi.h>
+#include <linux/stddef.h>
+#include <linux/virtio.h>
+#include <linux/virtio_ring.h>
+#include <linux/virtio_spi.h>
+
+#define VIRTIO_SPI_MODE_MASK \
+	(SPI_CPHA | SPI_CPOL | SPI_CS_HIGH | SPI_LSB_FIRST)
+
+struct virtio_spi_req {
+	struct completion completion;
+	struct spi_transfer_head transfer_head	____cacheline_aligned;
+	const u8 *tx_buf;
+	u8 *rx_buf;
+	struct spi_transfer_result result	____cacheline_aligned;
+};
+
+struct virtio_spi_priv {
+	/* The virtio device we're associated with */
+	struct virtio_device *vdev;
+	/* Pointer to the virtqueue */
+	struct virtqueue *vq;
+	/* Copy of config space mode_func_supported */
+	u32 mode_func_supported;
+	/* Copy of config space max_freq_hz */
+	u32 max_freq_hz;
+};
+
+static void virtio_spi_msg_done(struct virtqueue *vq)
+{
+	struct virtio_spi_req *req;
+	unsigned int len;
+
+	while ((req = virtqueue_get_buf(vq, &len)))
+		complete(&req->completion);
+}
+
+/*
+ * virtio_spi_set_delays - Set delay parameters for SPI transfer
+ *
+ * This function sets various delay parameters for SPI transfer,
+ * including delay after CS asserted, timing intervals between
+ * adjacent words within a transfer, delay before and after CS
+ * deasserted. It converts these delay parameters to nanoseconds
+ * using spi_delay_to_ns and stores the results in spi_transfer_head
+ * structure.
+ * If the conversion fails, the function logs a warning message and
+ * returns an error code.
+ *       .   .      .    .    .   .   .   .   .   .
+ * Delay + A +      + B  +    + C + D + E + F + A +
+ *       .   .      .    .    .   .   .   .   .   .
+ *    ___.   .      .    .    .   .   .___.___.   .
+ * CS#   |___.______.____.____.___.___|   .   |___._____________
+ *       .   .      .    .    .   .   .   .   .   .
+ *       .   .      .    .    .   .   .   .   .   .
+ * SCLK__.___.___NNN_____NNN__.___.___.___.___.___.___NNN_______
+ *
+ * NOTE: 1st transfer has two words, the delay between these two words are
+ * 'B' in the diagram.
+ *
+ * A => struct spi_device -> cs_setup
+ * B => max{struct spi_transfer -> word_delay, struct spi_device -> word_delay}
+ *   Note: spi_device and spi_transfer both have word_delay, Linux
+ *         choose the bigger one, refer to _spi_xfer_word_delay_update function
+ * C => struct spi_transfer -> delay
+ * D => struct spi_device -> cs_hold
+ * E => struct spi_device -> cs_inactive
+ * F => struct spi_transfer -> cs_change_delay
+ *
+ * So the corresponding relationship:
+ * A   <===> cs_setup_ns (after CS asserted)
+ * B   <===> word_delay_ns (delay between adjacent words within a transfer)
+ * C+D <===> cs_delay_hold_ns (before CS deasserted)
+ * E+F <===> cs_change_delay_inactive_ns (after CS deasserted, these two
+ * values are also recommended in the Linux driver to be added up)
+ */
+static int virtio_spi_set_delays(struct spi_transfer_head *th,
+				 struct spi_device *spi,
+				 struct spi_transfer *xfer)
+{
+	int cs_setup;
+	int cs_word_delay_xfer;
+	int cs_word_delay_spi;
+	int delay;
+	int cs_hold;
+	int cs_inactive;
+	int cs_change_delay;
+
+	cs_setup = spi_delay_to_ns(&spi->cs_setup, xfer);
+	if (cs_setup < 0) {
+		dev_warn(&spi->dev, "Cannot convert cs_setup\n");
+		return cs_setup;
+	}
+	th->cs_setup_ns = cpu_to_le32(cs_setup);
+
+	cs_word_delay_xfer = spi_delay_to_ns(&xfer->word_delay, xfer);
+	if (cs_word_delay_xfer < 0) {
+		dev_warn(&spi->dev, "Cannot convert cs_word_delay_xfer\n");
+		return cs_word_delay_xfer;
+	}
+	cs_word_delay_spi = spi_delay_to_ns(&spi->word_delay, xfer);
+	if (cs_word_delay_spi < 0) {
+		dev_warn(&spi->dev, "Cannot convert cs_word_delay_spi\n");
+		return cs_word_delay_spi;
+	}
+	if (cs_word_delay_spi > cs_word_delay_xfer)
+		th->word_delay_ns = cpu_to_le32(cs_word_delay_spi);
+	else
+		th->word_delay_ns = cpu_to_le32(cs_word_delay_xfer);
+
+	delay = spi_delay_to_ns(&xfer->delay, xfer);
+	if (delay < 0) {
+		dev_warn(&spi->dev, "Cannot convert delay\n");
+		return delay;
+	}
+	cs_hold = spi_delay_to_ns(&spi->cs_hold, xfer);
+	if (cs_hold < 0) {
+		dev_warn(&spi->dev, "Cannot convert cs_hold\n");
+		return cs_hold;
+	}
+	th->cs_delay_hold_ns = cpu_to_le32(delay + cs_hold);
+
+	cs_inactive = spi_delay_to_ns(&spi->cs_inactive, xfer);
+	if (cs_inactive < 0) {
+		dev_warn(&spi->dev, "Cannot convert cs_inactive\n");
+		return cs_inactive;
+	}
+	cs_change_delay = spi_delay_to_ns(&xfer->cs_change_delay, xfer);
+	if (cs_change_delay < 0) {
+		dev_warn(&spi->dev, "Cannot convert cs_change_delay\n");
+		return cs_change_delay;
+	}
+	th->cs_change_delay_inactive_ns =
+		cpu_to_le32(cs_inactive + cs_change_delay);
+
+	return 0;
+}
+
+static int virtio_spi_transfer_one(struct spi_controller *ctrl,
+				   struct spi_device *spi,
+				   struct spi_transfer *xfer)
+{
+	struct virtio_spi_priv *priv = spi_controller_get_devdata(ctrl);
+	struct virtio_spi_req *spi_req;
+	struct spi_transfer_head *th;
+	struct scatterlist sg_out_head, sg_out_payload;
+	struct scatterlist sg_in_result, sg_in_payload;
+	struct scatterlist *sgs[4];
+	unsigned int outcnt = 0u;
+	unsigned int incnt = 0u;
+	int ret;
+
+	spi_req = kzalloc(sizeof(*spi_req), GFP_KERNEL);
+	if (!spi_req)
+		return -ENOMEM;
+
+	init_completion(&spi_req->completion);
+
+	th = &spi_req->transfer_head;
+
+	/* Fill struct spi_transfer_head */
+	th->chip_select_id = spi_get_chipselect(spi, 0);
+	th->bits_per_word = spi->bits_per_word;
+	th->cs_change = xfer->cs_change;
+	th->tx_nbits = xfer->tx_nbits;
+	th->rx_nbits = xfer->rx_nbits;
+	th->reserved[0] = 0;
+	th->reserved[1] = 0;
+	th->reserved[2] = 0;
+
+	static_assert(VIRTIO_SPI_CPHA == SPI_CPHA,
+		      "VIRTIO_SPI_CPHA must match SPI_CPHA");
+	static_assert(VIRTIO_SPI_CPOL == SPI_CPOL,
+		      "VIRTIO_SPI_CPOL must match SPI_CPOL");
+	static_assert(VIRTIO_SPI_CS_HIGH == SPI_CS_HIGH,
+		      "VIRTIO_SPI_CS_HIGH must match SPI_CS_HIGH");
+	static_assert(VIRTIO_SPI_MODE_LSB_FIRST == SPI_LSB_FIRST,
+		      "VIRTIO_SPI_MODE_LSB_FIRST must match SPI_LSB_FIRST");
+
+	th->mode = cpu_to_le32(spi->mode & VIRTIO_SPI_MODE_MASK);
+	if (spi->mode & SPI_LOOP)
+		th->mode |= cpu_to_le32(VIRTIO_SPI_MODE_LOOP);
+
+	th->freq = cpu_to_le32(xfer->speed_hz);
+
+	ret = virtio_spi_set_delays(th, spi, xfer);
+	if (ret)
+		goto msg_done;
+
+	/* Set buffers */
+	spi_req->tx_buf = xfer->tx_buf;
+	spi_req->rx_buf = xfer->rx_buf;
+
+	/* Prepare sending of virtio message */
+	init_completion(&spi_req->completion);
+
+	sg_init_one(&sg_out_head, th, sizeof(*th));
+	sgs[outcnt] = &sg_out_head;
+	outcnt++;
+
+	if (spi_req->tx_buf) {
+		sg_init_one(&sg_out_payload, spi_req->tx_buf, xfer->len);
+		sgs[outcnt] = &sg_out_payload;
+		outcnt++;
+	}
+
+	if (spi_req->rx_buf) {
+		sg_init_one(&sg_in_payload, spi_req->rx_buf, xfer->len);
+		sgs[outcnt] = &sg_in_payload;
+		incnt++;
+	}
+
+	sg_init_one(&sg_in_result, &spi_req->result,
+		    sizeof(struct spi_transfer_result));
+	sgs[outcnt + incnt] = &sg_in_result;
+	incnt++;
+
+	ret = virtqueue_add_sgs(priv->vq, sgs, outcnt, incnt, spi_req,
+				GFP_KERNEL);
+	if (ret)
+		goto msg_done;
+
+	/* Simple implementation: There can be only one transfer in flight */
+	virtqueue_kick(priv->vq);
+
+	wait_for_completion(&spi_req->completion);
+
+	/* Read result from message and translate return code */
+	switch (spi_req->result.result) {
+	case VIRTIO_SPI_TRANS_OK:
+		break;
+	case VIRTIO_SPI_PARAM_ERR:
+		ret = -EINVAL;
+		break;
+	case VIRTIO_SPI_TRANS_ERR:
+		ret = -EIO;
+		break;
+	default:
+		ret = -EIO;
+		break;
+	}
+
+msg_done:
+	kfree(spi_req);
+	if (ret)
+		ctrl->cur_msg->status = ret;
+
+	return ret;
+}
+
+static void virtio_spi_read_config(struct virtio_device *vdev)
+{
+	struct spi_controller *ctrl = dev_get_drvdata(&vdev->dev);
+	struct virtio_spi_priv *priv = vdev->priv;
+	u8 cs_max_number;
+	u8 tx_nbits_supported;
+	u8 rx_nbits_supported;
+
+	cs_max_number = virtio_cread8(vdev, offsetof(struct virtio_spi_config,
+						     cs_max_number));
+	ctrl->num_chipselect = cs_max_number;
+
+	/* Set the mode bits which are understood by this driver */
+	priv->mode_func_supported =
+		virtio_cread32(vdev, offsetof(struct virtio_spi_config,
+					      mode_func_supported));
+	ctrl->mode_bits = priv->mode_func_supported &
+			  (VIRTIO_SPI_CS_HIGH | VIRTIO_SPI_MODE_LSB_FIRST);
+	if (priv->mode_func_supported & VIRTIO_SPI_MF_SUPPORT_CPHA_1)
+		ctrl->mode_bits |= VIRTIO_SPI_CPHA;
+	if (priv->mode_func_supported & VIRTIO_SPI_MF_SUPPORT_CPOL_1)
+		ctrl->mode_bits |= VIRTIO_SPI_CPOL;
+	if (priv->mode_func_supported & VIRTIO_SPI_MF_SUPPORT_LSB_FIRST)
+		ctrl->mode_bits |= SPI_LSB_FIRST;
+	if (priv->mode_func_supported & VIRTIO_SPI_MF_SUPPORT_LOOPBACK)
+		ctrl->mode_bits |= SPI_LOOP;
+	tx_nbits_supported =
+		virtio_cread8(vdev, offsetof(struct virtio_spi_config,
+					     tx_nbits_supported));
+	if (tx_nbits_supported & VIRTIO_SPI_RX_TX_SUPPORT_DUAL)
+		ctrl->mode_bits |= SPI_TX_DUAL;
+	if (tx_nbits_supported & VIRTIO_SPI_RX_TX_SUPPORT_QUAD)
+		ctrl->mode_bits |= SPI_TX_QUAD;
+	if (tx_nbits_supported & VIRTIO_SPI_RX_TX_SUPPORT_OCTAL)
+		ctrl->mode_bits |= SPI_TX_OCTAL;
+	rx_nbits_supported =
+		virtio_cread8(vdev, offsetof(struct virtio_spi_config,
+					     rx_nbits_supported));
+	if (rx_nbits_supported & VIRTIO_SPI_RX_TX_SUPPORT_DUAL)
+		ctrl->mode_bits |= SPI_RX_DUAL;
+	if (rx_nbits_supported & VIRTIO_SPI_RX_TX_SUPPORT_QUAD)
+		ctrl->mode_bits |= SPI_RX_QUAD;
+	if (rx_nbits_supported & VIRTIO_SPI_RX_TX_SUPPORT_OCTAL)
+		ctrl->mode_bits |= SPI_RX_OCTAL;
+
+	ctrl->bits_per_word_mask =
+		virtio_cread32(vdev, offsetof(struct virtio_spi_config,
+					      bits_per_word_mask));
+
+	priv->max_freq_hz =
+		virtio_cread32(vdev, offsetof(struct virtio_spi_config,
+					      max_freq_hz));
+}
+
+static int virtio_spi_find_vqs(struct virtio_spi_priv *priv)
+{
+	struct virtqueue *vq;
+
+	vq = virtio_find_single_vq(priv->vdev, virtio_spi_msg_done, "spi-rq");
+	if (IS_ERR(vq))
+		return PTR_ERR(vq);
+	priv->vq = vq;
+	return 0;
+}
+
+/* Function must not be called before virtio_spi_find_vqs() has been run */
+static void virtio_spi_del_vq(struct virtio_device *vdev)
+{
+	virtio_reset_device(vdev);
+	vdev->config->del_vqs(vdev);
+}
+
+static int virtio_spi_probe(struct virtio_device *vdev)
+{
+	struct virtio_spi_priv *priv;
+	struct spi_controller *ctrl;
+	int err;
+	u32 bus_num;
+
+	ctrl = devm_spi_alloc_host(&vdev->dev, sizeof(*priv));
+	if (!ctrl)
+		return -ENOMEM;
+
+	priv = spi_controller_get_devdata(ctrl);
+	priv->vdev = vdev;
+	vdev->priv = priv;
+
+	device_set_node(&ctrl->dev, dev_fwnode(&vdev->dev));
+
+	/* Setup ACPI node for controlled devices which will be probed through ACPI. */
+	ACPI_COMPANION_SET(&vdev->dev, ACPI_COMPANION(vdev->dev.parent));
+
+	dev_set_drvdata(&vdev->dev, ctrl);
+
+	err = device_property_read_u32(&vdev->dev, "spi,bus-num", &bus_num);
+	if (!err && bus_num <= S16_MAX)
+		ctrl->bus_num = bus_num;
+	else
+		ctrl->bus_num = -1;
+
+	virtio_spi_read_config(vdev);
+
+	ctrl->transfer_one = virtio_spi_transfer_one;
+
+	err = virtio_spi_find_vqs(priv);
+	if (err) {
+		dev_err_probe(&vdev->dev, err, "Cannot setup virtqueues\n");
+		return err;
+	}
+
+	/* Register cleanup for virtqueues using devm */
+	err = devm_add_action_or_reset(&vdev->dev, (void (*)(void *))virtio_spi_del_vq, vdev);
+	if (err) {
+		dev_err_probe(&vdev->dev, err, "Cannot register virtqueue cleanup\n");
+		return err;
+	}
+
+	/* Use devm version to register controller */
+	err = devm_spi_register_controller(&vdev->dev, ctrl);
+	if (err) {
+		dev_err_probe(&vdev->dev, err, "Cannot register controller\n");
+		return err;
+	}
+
+	return 0;
+}
+
+static int virtio_spi_freeze(struct device *dev)
+{
+	struct spi_controller *ctrl = dev_get_drvdata(dev);
+	struct virtio_device *vdev = container_of(dev, struct virtio_device, dev);
+	int ret;
+
+	ret = spi_controller_suspend(ctrl);
+	if (ret) {
+		dev_warn(dev, "cannot suspend controller (%d)\n", ret);
+		return ret;
+	}
+
+	virtio_spi_del_vq(vdev);
+	return 0;
+}
+
+static int virtio_spi_restore(struct device *dev)
+{
+	struct spi_controller *ctrl = dev_get_drvdata(dev);
+	struct virtio_device *vdev = container_of(dev, struct virtio_device, dev);
+	int ret;
+
+	ret = virtio_spi_find_vqs(vdev->priv);
+	if (ret) {
+		dev_err(dev, "problem starting vqueue (%d)\n", ret);
+		return ret;
+	}
+
+	ret = spi_controller_resume(ctrl);
+	if (ret)
+		dev_err(dev, "problem resuming controller (%d)\n", ret);
+
+	return ret;
+}
+
+static struct virtio_device_id virtio_spi_id_table[] = {
+	{ VIRTIO_ID_SPI, VIRTIO_DEV_ANY_ID },
+	{}
+};
+MODULE_DEVICE_TABLE(virtio, virtio_spi_id_table);
+
+static const struct dev_pm_ops virtio_spi_pm_ops = {
+	.freeze = pm_sleep_ptr(virtio_spi_freeze),
+	.restore = pm_sleep_ptr(virtio_spi_restore),
+};
+
+static struct virtio_driver virtio_spi_driver = {
+	.driver = {
+		.name = KBUILD_MODNAME,
+		.pm = &virtio_spi_pm_ops,
+	},
+	.id_table = virtio_spi_id_table,
+	.probe = virtio_spi_probe,
+};
+module_virtio_driver(virtio_spi_driver);
+
+MODULE_AUTHOR("OpenSynergy GmbH");
+MODULE_AUTHOR("Haixu Cui <quic_haixcui@quicinc.com>");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Virtio SPI bus driver");
-- 
2.34.1


