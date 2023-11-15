Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A01C47E7791
	for <lists+linux-spi@lfdr.de>; Fri, 10 Nov 2023 03:34:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234849AbjKJCeS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 9 Nov 2023 21:34:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjKJCeS (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 9 Nov 2023 21:34:18 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D183449A;
        Thu,  9 Nov 2023 18:34:15 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AA2SBPv020029;
        Fri, 10 Nov 2023 02:34:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=eEivUfct7fn5caGRT7DDTh9aydVN/iPMyfP2ktF6Wb0=;
 b=cZPldTJ+taQklBfg1q7I2pvsw/pkg+eIVCNbKDzTvJlaQhFKlzL0e91uLcjnbG4IlvH1
 LCHkI+lyUFeaUnEU2aJdFHOKJx+1Yz9RsCqDZrskMbKbdDqKo3w7x6eW02YkFkUGce3Y
 ksIkUoBAJoYdSNWBeAhywUxhTnsZfWBcJ4WyZYrR/AJNcqoR+MudmcUc4Zk7uyHSaWMZ
 alPQTTQlrIPaCkCsx9dwml5ELflZ71ySgE2Imyt+Ub1mvr/i0eFoGo0u3yaO8Pn+djDi
 i4/W+YPtV/nC3kY5qUSYZlVZFS5qJssukfHp5UcW2jA8Vn/NEZ2KjD46MwGlPgJS28Zf Vw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u8w0nt2b7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Nov 2023 02:34:09 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AA2Y8dH028880
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Nov 2023 02:34:08 GMT
Received: from [10.253.12.68] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Thu, 9 Nov
 2023 18:34:04 -0800
Message-ID: <30d9f8a9-2465-4f33-bdbe-dc0844d34858@quicinc.com>
Date:   Fri, 10 Nov 2023 10:34:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 3/3] SPI: Add virtio SPI driver (V4 draft
 specification).
Content-Language: en-US
To:     Harald Mommer <Harald.Mommer@opensynergy.com>,
        <virtio-dev@lists.oasis-open.org>, Mark Brown <broonie@kernel.org>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Harald.Mommer@gmail.com>
CC:     <quic_ztu@quicinc.com>, Matti Moell <Matti.Moell@opensynergy.com>,
        "Mikhail Golubev" <Mikhail.Golubev@opensynergy.com>
References: <20231027161016.26625-1-Harald.Mommer@opensynergy.com>
 <20231027161016.26625-4-Harald.Mommer@opensynergy.com>
From:   Haixu Cui <quic_haixcui@quicinc.com>
In-Reply-To: <20231027161016.26625-4-Harald.Mommer@opensynergy.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: nbaie0WAzoYK1j-YhOvuK4ZSJwaIO0-X
X-Proofpoint-ORIG-GUID: nbaie0WAzoYK1j-YhOvuK4ZSJwaIO0-X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-09_17,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 lowpriorityscore=0 malwarescore=0 bulkscore=0 phishscore=0 spamscore=0
 adultscore=0 impostorscore=0 mlxlogscore=999 priorityscore=1501
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311100019
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Harald,
     Please refer to my comments below.

On 10/28/2023 12:10 AM, Harald Mommer wrote:
> From: Harald Mommer <harald.mommer@opensynergy.com>
> 
> This is the first public version of the virtio SPI Linux kernel driver
> compliant to the "PATCH v4" draft virtio SPI specification.
> 
> Signed-off-by: Harald Mommer <Harald.Mommer@opensynergy.com>
> ---
>   drivers/spi/Kconfig      |  10 +
>   drivers/spi/Makefile     |   1 +
>   drivers/spi/spi-virtio.c | 513 +++++++++++++++++++++++++++++++++++++++
>   3 files changed, 524 insertions(+)
>   create mode 100644 drivers/spi/spi-virtio.c
> 
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index 35dbfacecf1c..55f45c5a8d82 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -1125,6 +1125,16 @@ config SPI_UNIPHIER
>   
>   	  If your SoC supports SCSSI, say Y here.
>   
> +config SPI_VIRTIO
> +	tristate "Virtio SPI SPI Controller"
> +	depends on VIRTIO
> +	help
> +	  This enables the Virtio SPI driver.
> +
> +	  Virtio SPI is an SPI driver for virtual machines using Virtio.
> +
> +	  If your Linux is a virtual machine using Virtio, say Y here.
> +
>   config SPI_XCOMM
>   	tristate "Analog Devices AD-FMCOMMS1-EBZ SPI-I2C-bridge driver"
>   	depends on I2C
> diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
> index 4ff8d725ba5e..ff2243e44e00 100644
> --- a/drivers/spi/Makefile
> +++ b/drivers/spi/Makefile
> @@ -146,6 +146,7 @@ spi-thunderx-objs			:= spi-cavium.o spi-cavium-thunderx.o
>   obj-$(CONFIG_SPI_THUNDERX)		+= spi-thunderx.o
>   obj-$(CONFIG_SPI_TOPCLIFF_PCH)		+= spi-topcliff-pch.o
>   obj-$(CONFIG_SPI_UNIPHIER)		+= spi-uniphier.o
> +obj-$(CONFIG_SPI_VIRTIO)		+= spi-virtio.o
>   obj-$(CONFIG_SPI_XCOMM)		+= spi-xcomm.o
>   obj-$(CONFIG_SPI_XILINX)		+= spi-xilinx.o
>   obj-$(CONFIG_SPI_XLP)			+= spi-xlp.o
> diff --git a/drivers/spi/spi-virtio.c b/drivers/spi/spi-virtio.c
> new file mode 100644
> index 000000000000..12a4d96555f1
> --- /dev/null
> +++ b/drivers/spi/spi-virtio.c
> @@ -0,0 +1,513 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * SPI bus driver for the Virtio SPI controller
> + * Copyright (C) 2023 OpenSynergy GmbH
> + */
> +
> +#include <linux/completion.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/stddef.h>
> +#include <linux/virtio.h>
> +#include <linux/virtio_ring.h>
> +#include <linux/version.h>
> +#include <linux/spi/spi.h>
> +#include <linux/virtio_spi.h>
> +
> +/* SPI device queues */
> +#define VIRTIO_SPI_QUEUE_RQ 0
> +#define VIRTIO_SPI_QUEUE_COUNT 1
> +
> +/* virtio_spi private data structure */
> +struct virtio_spi_priv {
> +	/* The virtio device we're associated with */
> +	struct virtio_device *vdev;
> +	/* The virtqueues */
> +	struct virtqueue *vqs[VIRTIO_SPI_QUEUE_COUNT];
> +	/* I/O callback function pointers for the virtqueues */
> +	vq_callback_t *io_callbacks[VIRTIO_SPI_QUEUE_COUNT];
> +	/* Support certain delay timing settings */
> +	bool support_delays;
> +};
> +
> +/* Compare with file i2c_virtio.c structure virtio_i2c_req */
> +struct virtio_spi_req {
> +	struct completion completion;
> +#ifdef DEBUG
> +	unsigned int rx_len;
> +#endif
> +	// clang-format off
> +	struct spi_transfer_head transfer_head	____cacheline_aligned;
> +	const uint8_t *tx_buf			____cacheline_aligned;
> +	uint8_t *rx_buf				____cacheline_aligned;
> +	struct spi_transfer_result result	____cacheline_aligned;
> +	// clang-format on
> +};
> +
> +static struct spi_board_info board_info = {
> +	.modalias = "spi-virtio",
> +	.max_speed_hz = 125000000, /* Arbitrary very high limit */
> +	.bus_num = 0, /* Patched later during initialization */
> +	.chip_select = 0, /* Patched later during initialization */
> +	.mode = SPI_MODE_0,
> +};
> +
> +/* Compare with file i2c_virtio.c structure virtio_i2c_msg_done */
> +static void virtio_spi_msg_done(struct virtqueue *vq)
> +{
> +	struct virtio_spi_req *req;
> +	unsigned int len;
> +
> +	while ((req = virtqueue_get_buf(vq, &len)))
> +		complete(&req->completion);
> +}
> +
> +static int virtio_spi_one_transfer(struct virtio_spi_req *spi_req,
> +				   struct spi_master *master,
> +				   struct spi_message *msg,
> +				   struct spi_transfer *xfer)
> +{
> +	struct virtio_spi_priv *priv = spi_master_get_devdata(master);
> +	struct device *dev = &priv->vdev->dev;
> +	struct virtqueue *vq = priv->vqs[VIRTIO_SPI_QUEUE_RQ];
> +	struct spi_device *spi = msg->spi;
> +	struct spi_transfer_head *th;
> +	struct scatterlist sg_out_head, sg_out_payload;
> +	struct scatterlist sg_in_result, sg_in_payload;
> +	struct scatterlist *sgs[4];
> +	unsigned int outcnt = 0u;
> +	unsigned int incnt = 0u;
> +	int ret;
> +
> +	th = &spi_req->transfer_head;
> +
> +	/* Fill struct spi_transfer_head */
> +	th->slave_id = spi->chip_select;
> +	th->bits_per_word = spi->bits_per_word;
> +	th->cs_change = xfer->cs_change;
> +	th->tx_nbits = xfer->tx_nbits;
> +	th->rx_nbits = xfer->rx_nbits;
> +	th->reserved[0] = 0;
> +	th->reserved[1] = 0;
> +	th->reserved[2] = 0;
> +
> +#if (VIRTIO_SPI_CPHA != SPI_CPHA)
> +#error VIRTIO_SPI_CPHA != SPI_CPHA
> +#endif
> +
> +#if (VIRTIO_SPI_CPOL != SPI_CPOL)
> +#error VIRTIO_SPI_CPOL != SPI_CPOL
> +#endif
> +
> +#if (VIRTIO_SPI_CS_HIGH != SPI_CS_HIGH)
> +#error VIRTIO_SPI_CS_HIGH != SPI_CS_HIGH
> +#endif
> +
> +#if (VIRTIO_SPI_MODE_LSB_FIRST != SPI_LSB_FIRST)
> +#error VIRTIO_SPI_MODE_LSB_FIRST != SPI_LSB_FIRST
> +#endif
> +
> +	th->mode = spi->mode &
> +		   (SPI_LSB_FIRST | SPI_CS_HIGH | SPI_CPOL | SPI_CPHA);
> +	if ((spi->mode & SPI_LOOP) != 0)
> +		th->mode |= VIRTIO_SPI_MODE_LOOP;
> +
> +	th->freq = cpu_to_le32(xfer->speed_hz);
> +
> +	ret = spi_delay_to_ns(&xfer->word_delay, xfer);
> +	if (ret < 0) {
> +		dev_warn(dev, "Cannot convert word_delay\n");
> +		goto msg_done;
> +	}
> +	th->word_delay_ns = cpu_to_le32((u32)ret);
> +
> +	ret = spi_delay_to_ns(&xfer->delay, xfer);
> +	if (ret < 0) {
> +		dev_warn(dev, "Cannot convert delay\n");
> +		goto msg_done;
> +	}
> +	th->cs_setup_ns = cpu_to_le32((u32)ret);
> +	th->cs_delay_hold_ns = cpu_to_le32((u32)ret);
> +
> +	/* This is the "off" time when CS has to be deasserted for a moment */
> +	ret = spi_delay_to_ns(&xfer->cs_change_delay, xfer);
> +	if (ret < 0) {
> +		dev_warn(dev, "Cannot convert cs_change_delay\n");
> +		goto msg_done;
> +	}
> +	th->cs_change_delay_inactive_ns = cpu_to_le32((u32)ret);
> +
> +	/*
> +	 * With the way it's specified in the virtio draft specification
> +	 * V4 the virtio device just MUST print a warning and ignores the delay
> +	 * timing settings it does not support.
> +	 * Implementation decision: Only warn once not to flood the logs.
> +	 * TODO: Comment on this
> +	 * By the wording of the speciification it is unclear which timings
> +	 * exactly are affected, there is a copy & paste mistake in the spec.
> +	 * TODO: Comment on this
> +	 * Somewhat unclear is whether the values in question are to be
> +	 * passed as is to the virtio device.
> +	 *
> +	 * Probably better specification for the device:
> +	 *   The device shall reject a message if tbd delay timing is not
> +	 *   supported but the requested value is not zero by some tbd error.
> +	 * Probably better specification for the driver:
> +	 *   If the device did not announce support of delay timings in the
> +	 *   config space the driver SHOULD not sent a delay timing not equal to
> +	 *   zero but should immediately reject the message.
> +	 */
> +	if (!priv->support_delays) {
> +		if (th->word_delay_ns)
> +			dev_warn_once(dev, "word_delay_ns != 0\n");
> +		if (th->cs_setup_ns)
> +			dev_warn_once(dev, "cs_setup_ns != 0\n");
> +		if (th->cs_change_delay_inactive_ns)
> +			dev_warn_once(dev,
> +				      "cs_change_delay_inactive_ns != 0\n");
> +	}
> +
> +	/* Set buffers */
> +	spi_req->tx_buf = xfer->tx_buf;
> +	spi_req->rx_buf = xfer->rx_buf;
> +#ifdef DEBUG
> +	spi_req->rx_len = xfer->len;
> +#endif
> +
> +	/* Prepare sending of virtio message */
> +	init_completion(&spi_req->completion);
> +
> +	sg_init_one(&sg_out_head, &spi_req->transfer_head,
> +		    sizeof(struct spi_transfer_head));
> +	sgs[outcnt] = &sg_out_head;
> +
> +	pr_debug("sgs[%u] len = %u", outcnt + incnt,
> +		 sgs[outcnt + incnt]->length);
> +	pr_debug("Dump of spi_transfer_head\n");
> +	print_hex_dump_debug(KBUILD_MODNAME " ", DUMP_PREFIX_NONE, 16, 1,
> +			     &spi_req->transfer_head,
> +			     sizeof(struct spi_transfer_head), true);
> +	outcnt++;
> +
> +	if (spi_req->tx_buf) {
> +		sg_init_one(&sg_out_payload, spi_req->tx_buf, xfer->len);
> +		sgs[outcnt] = &sg_out_payload;
> +		pr_debug("sgs[%u] len = %u", outcnt + incnt,
> +			 sgs[outcnt + incnt]->length);
> +		pr_debug("Dump of TX payload\n");
> +		print_hex_dump_debug(KBUILD_MODNAME " ", DUMP_PREFIX_NONE, 16,
> +				     1, spi_req->tx_buf, xfer->len, true);
> +		outcnt++;
> +	}
> +
> +	if (spi_req->rx_buf) {
> +		sg_init_one(&sg_in_payload, spi_req->rx_buf, xfer->len);
> +		sgs[outcnt + incnt] = &sg_in_payload;
> +		pr_debug("sgs[%u] len = %u", outcnt + incnt,
> +			 sgs[outcnt + incnt]->length);
> +		incnt++;
> +	}
> +
> +	sg_init_one(&sg_in_result, &spi_req->result,
> +		    sizeof(struct spi_transfer_result));
> +	sgs[outcnt + incnt] = &sg_in_result;
> +	pr_debug("sgs[%u] len = %u", outcnt + incnt,
> +		 sgs[outcnt + incnt]->length);
> +	incnt++;
> +
> +	pr_debug("%s: outcnt=%u, incnt=%u\n", __func__, outcnt, incnt);
> +
> +	ret = virtqueue_add_sgs(vq, sgs, outcnt, incnt, spi_req, GFP_KERNEL);
> +msg_done:
> +	if (ret)
> +		msg->status = ret;
> +
> +	return ret;
> +}
> +


This function here seems very similar with the default 
transfer_one_message interface provided by Linux driver, that is 
spi_transfer_one_message.

What if using the default interface? In default one, xfer->delay and
xfer->cs_change_delay are executed by software,  which means these two 
values don't need to pass to the backend.

> +static int virtio_spi_transfer_one_message(struct spi_master *master,
> +					   struct spi_message *msg)
> +{
> +	struct virtio_spi_priv *priv = spi_master_get_devdata(master);
> +	struct virtqueue *vq = priv->vqs[VIRTIO_SPI_QUEUE_RQ];
> +	struct virtio_spi_req *spi_req;
> +	struct spi_transfer *xfer;
> +	int ret = 0;
> +
> +	spi_req = kzalloc(sizeof(*spi_req), GFP_KERNEL);
> +	if (!spi_req) {
> +		ret = -ENOMEM;
> +		goto no_mem;
> +	}
> +
> +	/*
> +	 * Simple implementation: Process message by message and wait for each
> +	 * message to be completed by the device side.
> +	 */
> +	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
> +		ret = virtio_spi_one_transfer(spi_req, master, msg, xfer);
> +		if (ret)
> +			goto msg_done;
> +
> +		virtqueue_kick(vq);
> +
> +		wait_for_completion(&spi_req->completion);
> +
> +		/* Read result from message */
> +		ret = (int)spi_req->result.result;
> +		if (ret)
> +			goto msg_done;
> +
> +#ifdef DEBUG
> +		if (spi_req->rx_buf) {
> +			pr_debug("Dump of RX payload\n");
> +			print_hex_dump(KERN_DEBUG, KBUILD_MODNAME " ",
> +				       DUMP_PREFIX_NONE, 16, 1, spi_req->rx_buf,
> +				       spi_req->rx_len, true);
> +		}
> +#endif
> +	}
> +
> +msg_done:
> +	kfree(spi_req);
> +no_mem:
> +	msg->status = ret;
> +	/*
> +	 * Looking into other SPI drivers like spi-atmel.c the function
> +	 * spi_finalize_current_message() is supposed to be called only once
> +	 * for all transfers in the list and not for each single message
> +	 */
> +	spi_finalize_current_message(master);
> +	dev_dbg(&priv->vdev->dev, "%s() returning %d\n", __func__, ret);
> +	return ret;
> +}
> +
> +static void virtio_spi_read_config(struct virtio_device *vdev)
> +{
> +	struct spi_master *master = dev_get_drvdata(&vdev->dev);
> +	struct virtio_spi_priv *priv = vdev->priv;
> +	u16 bus_num;
> +	u16 cs_max_number;
> +	u8 support_delays;
> +
> +	bus_num = virtio_cread16(vdev,
> +				 offsetof(struct virtio_spi_config, bus_num));
> +	cs_max_number = virtio_cread16(vdev, offsetof(struct virtio_spi_config,
> +						      chip_select_max_number));
> +	support_delays =
> +		virtio_cread16(vdev, offsetof(struct virtio_spi_config,
> +					      cs_timing_setting_enable));
> +
> +	if (bus_num > S16_MAX) {
> +		dev_warn(&vdev->dev, "Limiting bus_num = %u to %d\n", bus_num,
> +			 S16_MAX);
> +		bus_num = S16_MAX;
> +	}
> +
> +	if (support_delays > 1)
> +		dev_warn(&vdev->dev, "cs_timing_setting_enable = %u\n",
> +			 support_delays);
> +	priv->support_delays = (support_delays != 0);
> +	master->bus_num = (s16)bus_num;
> +	master->num_chipselect = cs_max_number;
> +}
> +
> +static int virtio_spi_find_vqs(struct virtio_spi_priv *priv)
> +{
> +	static const char *const io_names[VIRTIO_SPI_QUEUE_COUNT] = { "spi-rq" };
> +
> +	priv->io_callbacks[VIRTIO_SPI_QUEUE_RQ] = virtio_spi_msg_done;
> +
> +	/* Find the queues. */
> +	return virtio_find_vqs(priv->vdev, VIRTIO_SPI_QUEUE_COUNT, priv->vqs,
> +			       priv->io_callbacks, io_names, NULL);
> +}
> +
> +/* Compare with i2c-virtio.c function virtio_i2c_del_vqs() */
> +/* Function must not be called before virtio_spi_find_vqs() has been run */
> +static void virtio_spi_del_vq(struct virtio_device *vdev)
> +{
> +	vdev->config->reset(vdev);
> +	vdev->config->del_vqs(vdev);
> +}
> +
> +static int virtio_spi_validate(struct virtio_device *vdev)
> +{
> +	/*
> +	 * SPI needs always access to the config space.
> +	 * Check that the driver can access the config space
> +	 */
> +	if (!vdev->config->get) {
> +		dev_err(&vdev->dev, "%s failure: config access disabled\n",
> +			__func__);
> +		return -EINVAL;
> +	}
> +
> +	if (!virtio_has_feature(vdev, VIRTIO_F_VERSION_1)) {
> +		dev_err(&vdev->dev,
> +			"device does not comply with spec version 1.x\n");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int virtio_spi_probe(struct virtio_device *vdev)
> +{
> +	struct virtio_spi_priv *priv;
> +	struct spi_master *master;
> +	int err;
> +	u16 csi;
> +
> +	err = -ENOMEM;
> +	master = spi_alloc_master(&vdev->dev, sizeof(struct virtio_spi_priv));
> +	if (!master) {
> +		dev_err(&vdev->dev, "Kernel memory exhausted in %s()\n",
> +			__func__);
> +		goto err_return;
> +	}
> +
> +	priv = spi_master_get_devdata(master);
> +	priv->vdev = vdev;
> +	vdev->priv = priv;
> +	dev_set_drvdata(&vdev->dev, master);
> +
> +	/* the spi->mode bits understood by this driver: */
> +	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LSB_FIRST |
> +			    SPI_LOOP | SPI_TX_DUAL | SPI_TX_QUAD | SPI_RX_DUAL |
> +			    SPI_RX_QUAD | SPI_TX_OCTAL | SPI_RX_OCTAL;
> +
> +	/* What most support. We don't know from the virtio device side */
> +	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(8, 16);
> +	/* There is no associated device tree node */
> +	master->dev.of_node = NULL;
> +	/* Get bus_num and num_chipselect from the config space */
> +	virtio_spi_read_config(vdev);
> +	/* Maybe this method is not needed for virtio SPI */
> +	master->setup = NULL; /* Function not needed for virtio-spi */
> +	/* No restrictions to announce */
> +	master->flags = 0;
> +	/* Method to transfer a single SPI message */
> +	master->transfer_one_message = virtio_spi_transfer_one_message;
> +	/* Method to cleanup the driver */
> +	master->cleanup = NULL; /* Function not needed for virtio-spi */
> +
> +	/* Initialize virtqueues */
> +	err = virtio_spi_find_vqs(priv);
> +	if (err) {
> +		dev_err(&vdev->dev, "Cannot setup virtqueues\n");
> +		goto err_master_put;
> +	}
> +
> +	err = spi_register_master(master);
> +	if (err) {
> +		dev_err(&vdev->dev, "Cannot register master\n");
> +		goto err_master_put;
> +	}
> +
> +	/* spi_new_device() currently does not use bus_num but better set it */
> +	board_info.bus_num = (u16)master->bus_num;

bus_num is not necessary actually, driver will dynamicly assign it if 
bus_num is -1(initial value), besides, it's not necessary to build the 
mapping relationship via bus_num.

> +
> +	/* Add chip selects to master device */
> +	for (csi = 0; csi < master->num_chipselect; csi++) {
> +		dev_info(&vdev->dev, "Setting up CS=%u\n", csi);
> +		board_info.chip_select = csi;
> +		if (!spi_new_device(master, &board_info)) {
> +			dev_err(&vdev->dev, "Cannot setup device %u\n", csi);
> +			goto err_unregister_master;
> +		}
> +	}
> +
> +	/* Request device going live */
> +	virtio_device_ready(vdev); /* Optionally done by virtio_dev_probe() */
> +
> +	dev_info(&vdev->dev, "Device live!\n");
> +
> +	return 0;
> +
> +err_unregister_master:
> +	spi_unregister_master(master);
> +err_master_put:
> +	spi_master_put(master);
> +err_return:
> +	return err;
> +}
> +
> +static void virtio_spi_remove(struct virtio_device *vdev)
> +{
> +	struct spi_master *master = dev_get_drvdata(&vdev->dev);
> +
> +	virtio_spi_del_vq(vdev);
> +	spi_unregister_master(master);
> +}
> +
> +#ifdef CONFIG_PM_SLEEP
> +/*
> + * Compare with i2c-virtio.c function virtio_i2c_freeze()
> + * and with spi-atmel.c function atmel_spi_suspend()
> + */
> +static int virtio_spi_freeze(struct virtio_device *vdev)
> +{
> +	struct device *dev = &vdev->dev;
> +	struct spi_master *master = dev_get_drvdata(dev);
> +	int ret;
> +
> +	/* Stop the queue running */
> +	ret = spi_master_suspend(master);
> +	if (ret) {
> +		dev_warn(dev, "cannot suspend master (%d)\n", ret);
> +		return ret;
> +	}
> +
> +	virtio_spi_del_vq(vdev);
> +	return 0;
> +}
> +
> +/*
> + * Compare with i2c-virtio.c function virtio_i2c_restore()
> + * and with spi-atmel.c function atmel_spi_resume()
> + */
> +static int virtio_spi_restore(struct virtio_device *vdev)
> +{
> +	struct device *dev = &vdev->dev;
> +	struct spi_master *master = dev_get_drvdata(dev);
> +	int ret;
> +
> +	/* Start the queue running */
> +	ret = spi_master_resume(master);
> +	if (ret)
> +		dev_err(dev, "problem starting queue (%d)\n", ret);
> +
> +	return virtio_spi_find_vqs(vdev->priv);
> +}
> +#endif
> +
> +static struct virtio_device_id virtio_spi_id_table[] = {
> +	{ VIRTIO_ID_SPI, VIRTIO_DEV_ANY_ID },
> +	{ 0 },
> +};
> +
> +static struct virtio_driver virtio_spi_driver = {
> +	.feature_table = NULL,
> +	.feature_table_size = 0u,
> +	.driver.name = KBUILD_MODNAME,
> +	.driver.owner = THIS_MODULE,
> +	.id_table = virtio_spi_id_table,
> +	.validate = virtio_spi_validate,
> +	.probe = virtio_spi_probe,
> +	.remove = virtio_spi_remove,
> +	.config_changed = NULL,
> +#ifdef CONFIG_PM_SLEEP
> +	.freeze = virtio_spi_freeze,
> +	.restore = virtio_spi_restore,
> +#endif
> +};
> +
> +module_virtio_driver(virtio_spi_driver);
> +MODULE_DEVICE_TABLE(virtio, virtio_spi_id_table);
> +
> +MODULE_AUTHOR("OpenSynergy GmbH");
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("SPI bus driver for Virtio SPI");

Best Regards
Haixcui
