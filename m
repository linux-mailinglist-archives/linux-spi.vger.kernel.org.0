Return-Path: <linux-spi+bounces-7706-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3572FA95DAE
	for <lists+linux-spi@lfdr.de>; Tue, 22 Apr 2025 08:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB9177A287A
	for <lists+linux-spi@lfdr.de>; Tue, 22 Apr 2025 06:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E2819DF4D;
	Tue, 22 Apr 2025 06:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="TnqKO601"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7871155CB3;
	Tue, 22 Apr 2025 06:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745301808; cv=none; b=L0Zx9Pb9aoyaMyz/5kEQFIjxerfoPd1DWvi6MfKj4fncslPB2u/tMfZ10At7jOpQHIUxT1Y5+a7xOUQh2tWNBpVJLZDgQbNNLF0zzb5jVQZBmpoMJ+1+qbjCslDrZ2/5FblXAfNHDeQ2gDLz2DpKaKvc2Qk27D2Lrp1i22Aal5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745301808; c=relaxed/simple;
	bh=yqsU8DJJZB0DJzvJVPEwGOtjZVQlUcRnucynwfuEGKc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ThGNS+Q09O4e1G14G31Zgc5xRITmYWHaimDj3JllmK3cMTIyZo24pDFCKL4+NDamNx/5lFmNm5bFAZf93jt5ojqAOSQ6ukiy3MofhiUmgSxOb5ew4B1T1Hfopfm42JN7nsmgh8jdEOfV/bhrYQR5boj05KaH7brhHW7wZvbOCMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=TnqKO601; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53M4OZ73031595;
	Tue, 22 Apr 2025 06:03:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lpjgdopW0L/Ir0Ci+frFRToyiGz+NG957nj9kOnQOwI=; b=TnqKO601AjP2Ryqq
	IZfIi7lUilInrpCXPQcyUWuqBr1u6TvFWhsiNkWJsc6WiLDTFvu9Xs5WjeB5kmYY
	7TS/q3cmGTHu+ObSKpzx86Ncgbm6iERZ+05ZIIuGChwoHqIUMJkTVyw/9auy8J1H
	+rjWgTt7JwYEoRIYTKPaP6+R/gWe9qsoC9zfJFS5qhrgq+UprSaaZhxaPk4J0fcs
	RasKM1yuk4QZprCNltcuyIPSGNdz4DxiXD/Je+IbSAUwt7N++saMdq+jh4I0kuFm
	jfFnyV6xGRYt/jWijo9N4bPblgTtdh22rO8b22K3zHYxmeQNG/MBFRg7H3E71QaD
	sZj9XQ==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4641hhpeuw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Apr 2025 06:03:15 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53M63Frq002550
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Apr 2025 06:03:15 GMT
Received: from [10.217.219.207] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 21 Apr
 2025 23:03:12 -0700
Message-ID: <74698d99-db5b-4ec7-a965-eea2a29e54b1@quicinc.com>
Date: Tue, 22 Apr 2025 11:33:09 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 3/3] SPI: Add virtio SPI driver
To: Haixu Cui <quic_haixcui@quicinc.com>, <broonie@kernel.org>,
        <virtio-dev@lists.oasis-open.org>, <viresh.kumar@linaro.org>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <hdanton@sina.com>, <qiang4.zhang@linux.intel.com>,
        <alex.bennee@linaro.org>
CC: <quic_ztu@quicinc.com>
References: <20250401033621.1614194-1-quic_haixcui@quicinc.com>
 <20250401033621.1614194-4-quic_haixcui@quicinc.com>
Content-Language: en-US
From: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
In-Reply-To: <20250401033621.1614194-4-quic_haixcui@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=Fe43xI+6 c=1 sm=1 tr=0 ts=68073123 cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=ZBDlC2t2MhUFoHvmL_4A:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: vEJalvamZJ4r2vffYIcqLrh1MVXNODTD
X-Proofpoint-ORIG-GUID: vEJalvamZJ4r2vffYIcqLrh1MVXNODTD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-22_03,2025-04-21_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 phishscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 suspectscore=0
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504220045



On 4/1/2025 9:06 AM, Haixu Cui wrote:
> This is the virtio SPI Linux kernel driver.
[...]
> +static void virtio_spi_msg_done(struct virtqueue *vq)
> +{
> +	struct virtio_spi_req *req;
> +	unsigned int len;
> +
> +	while ((req = virtqueue_get_buf(vq, &len)))
> +		complete(&req->completion);
> +}
> +
> +/*
Could you please help add exact function description which can help 
understand below details with some background/purpose ?

> + *       .   .      .    .    .   .   .   .   .   .
> + * Delay + A +      + B  +    + C + D + E + F + A +
> + *       .   .      .    .    .   .   .   .   .   .
> + *    ___.   .      .    .    .   .   .___.___.   .
> + * CS#   |___.______.____.____.___.___|   .   |___._____________
> + *       .   .      .    .    .   .   .   .   .   .
> + *       .   .      .    .    .   .   .   .   .   .
> + * SCLK__.___.___NNN_____NNN__.___.___.___.___.___.___NNN_______
> + *
> + * NOTE: 1st transfer has two words, the delay between these two words are
> + * 'B' in the diagram.
> + *
> + * A => struct spi_device -> cs_setup
> + * B => max{struct spi_transfer -> word_delay, struct spi_device -> word_delay}
> + *   Note: spi_device and spi_transfer both have word_delay, Linux
> + *         choose the bigger one, refer to _spi_xfer_word_delay_update function
> + * C => struct spi_transfer -> delay
> + * D => struct spi_device -> cs_hold
> + * E => struct spi_device -> cs_inactive
> + * F => struct spi_transfer -> cs_change_delay
Alignment of single line arrow  -> .
> + *
> + * So the corresponding relationship:
> + * A <===> cs_setup_ns (after CS asserted)
> + * B <===> word_delay_ns (no matter with CS)
what does it mean when you say "no matter with CS" ? Any other 
simplified statement ?
Delay from sending actual data /Clock generation ?
> + * C+D <===> cs_delay_hold_ns (before CS deasserted)
> + * E+F <===> cs_change_delay_inactive_ns (after CS deasserted, these two
> + * values are also recommended in the Linux driver to be added up)
Alignment of all double dashed line arrows <===> to left side symbols .
> + */
> +static int virtio_spi_set_delays(struct spi_transfer_head *th,
> +				 struct spi_device *spi,
> +				 struct spi_transfer *xfer)
> +{
> +	int cs_setup;
> +	int cs_word_delay_xfer;
> +	int cs_word_delay_spi;
> +	int delay;
> +	int cs_hold;
> +	int cs_inactive;
> +	int cs_change_delay;
Please maintain reverse christmas tree alingment.
int cs_word_delay_xfer;
int cs_word_delay_spi;
int cs_change_delay;
int cs_inactive;
int cs_setup;
int cs_hold;
int delay;

[...]
> +
> +static int virtio_spi_transfer_one(struct spi_controller *ctrl,
> +				   struct spi_device *spi,
> +				   struct spi_transfer *xfer)
> +{
> +	struct virtio_spi_priv *priv = spi_controller_get_devdata(ctrl);
> +	struct virtio_spi_req *spi_req = &priv->spi_req;
> +	struct spi_transfer_head *th;
can move it to down to maintain revierse christmas tree alignment.
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
> +	th->chip_select_id = spi_get_chipselect(spi, 0);
> +	th->bits_per_word = spi->bits_per_word;
> +	th->cs_change = xfer->cs_change;
> +	th->tx_nbits = xfer->tx_nbits;
> +	th->rx_nbits = xfer->rx_nbits;
> +	th->reserved[0] = 0;
> +	th->reserved[1] = 0;
> +	th->reserved[2] = 0;
> +
> +	BUILD_BUG_ON(VIRTIO_SPI_CPHA != SPI_CPHA);
> +	BUILD_BUG_ON(VIRTIO_SPI_CPOL != SPI_CPOL);
> +	BUILD_BUG_ON(VIRTIO_SPI_CS_HIGH != SPI_CS_HIGH);
> +	BUILD_BUG_ON(VIRTIO_SPI_MODE_LSB_FIRST != SPI_LSB_FIRST);
> +
> +	th->mode = cpu_to_le32(spi->mode & (SPI_LSB_FIRST | SPI_CS_HIGH |
> +					    SPI_CPOL | SPI_CPHA));
> +	if ((spi->mode & SPI_LOOP) != 0)
> +		th->mode |= cpu_to_le32(VIRTIO_SPI_MODE_LOOP);
> +
> +	th->freq = cpu_to_le32(xfer->speed_hz);
> +
> +	ret = virtio_spi_set_delays(th, spi, xfer);
> +	if (ret)
> +		goto msg_done;
> +
> +	/* Set buffers */
> +	spi_req->tx_buf = xfer->tx_buf;
> +	spi_req->rx_buf = xfer->rx_buf;
> +
> +	/* Prepare sending of virtio message */
> +	init_completion(&spi_req->completion);
> +
> +	sg_init_one(&sg_out_head, th, sizeof(*th));
> +	sgs[outcnt] = &sg_out_head;
> +	outcnt++;
> +
> +	if (spi_req->tx_buf) {
> +		sg_init_one(&sg_out_payload, spi_req->tx_buf, xfer->len);
> +		sgs[outcnt] = &sg_out_payload;
> +		outcnt++;
> +	}
> +
> +	if (spi_req->rx_buf) {
> +		sg_init_one(&sg_in_payload, spi_req->rx_buf, xfer->len);
> +		sgs[outcnt] = &sg_in_payload;
> +		incnt++;
> +	}
> +
> +	sg_init_one(&sg_in_result, &spi_req->result,
> +		    sizeof(struct spi_transfer_result));
> +	sgs[outcnt + incnt] = &sg_in_result;
> +	incnt++;
> +
> +	ret = virtqueue_add_sgs(priv->vq, sgs, outcnt, incnt, spi_req,
> +				GFP_KERNEL);
> +	if (ret)
> +		goto msg_done;
> +
> +	/* Simple implementation: There can be only one transfer in flight */
> +	virtqueue_kick(priv->vq);
> +
> +	wait_for_completion(&priv->spi_req.completion);
> +
> +	/* Read result from message and translate return code */
> +	switch (priv->spi_req.result.result) {
> +	case VIRTIO_SPI_TRANS_OK:
> +		/* ret is 0 */
> +		break;
> +	case VIRTIO_SPI_PARAM_ERR:
> +		ret = -EINVAL;
> +		break;
> +	case VIRTIO_SPI_TRANS_ERR:
> +		ret = -EIO;
> +		break;
> +	default: /* Protocol violation */
> +		ret = -EIO;
> +		break;
> +	}
> +
> +msg_done:
> +	if (ret)
> +		ctrl->cur_msg->status = ret;
> +
> +	return ret;
> +}
> +
> +static void virtio_spi_read_config(struct virtio_device *vdev)
> +{
> +	struct spi_controller *ctrl = dev_get_drvdata(&vdev->dev);
> +	struct virtio_spi_priv *priv = vdev->priv;
> +	u8 cs_max_number;
> +	u8 tx_nbits_supported;
> +	u8 rx_nbits_supported;
> +
same here.
> +	cs_max_number = virtio_cread8(vdev, offsetof(struct virtio_spi_config,
> +						     cs_max_number));
> +	ctrl->num_chipselect = cs_max_number;
> +
> +	/* Set the mode bits which are understood by this driver */
> +	priv->mode_func_supported =
> +		virtio_cread32(vdev, offsetof(struct virtio_spi_config,
> +					      mode_func_supported));
> +	ctrl->mode_bits = priv->mode_func_supported &
> +			  (VIRTIO_SPI_CS_HIGH | VIRTIO_SPI_MODE_LSB_FIRST);
> +	if ((priv->mode_func_supported & VIRTIO_SPI_MF_SUPPORT_CPHA_1) != 0)
> +		ctrl->mode_bits |= VIRTIO_SPI_CPHA;
> +	if ((priv->mode_func_supported & VIRTIO_SPI_MF_SUPPORT_CPOL_1) != 0)
> +		ctrl->mode_bits |= VIRTIO_SPI_CPOL;
> +	if ((priv->mode_func_supported & VIRTIO_SPI_MF_SUPPORT_LSB_FIRST) != 0)
> +		ctrl->mode_bits |= SPI_LSB_FIRST;
> +	if ((priv->mode_func_supported & VIRTIO_SPI_MF_SUPPORT_LOOPBACK) != 0)
> +		ctrl->mode_bits |= SPI_LOOP;
> +	tx_nbits_supported =
> +		virtio_cread8(vdev, offsetof(struct virtio_spi_config,
> +					     tx_nbits_supported));
> +	if ((tx_nbits_supported & VIRTIO_SPI_RX_TX_SUPPORT_DUAL) != 0)
> +		ctrl->mode_bits |= SPI_TX_DUAL;
> +	if ((tx_nbits_supported & VIRTIO_SPI_RX_TX_SUPPORT_QUAD) != 0)
> +		ctrl->mode_bits |= SPI_TX_QUAD;
> +	if ((tx_nbits_supported & VIRTIO_SPI_RX_TX_SUPPORT_OCTAL) != 0)
> +		ctrl->mode_bits |= SPI_TX_OCTAL;
> +	rx_nbits_supported =
> +		virtio_cread8(vdev, offsetof(struct virtio_spi_config,
> +					     rx_nbits_supported));
> +	if ((rx_nbits_supported & VIRTIO_SPI_RX_TX_SUPPORT_DUAL) != 0)
> +		ctrl->mode_bits |= SPI_RX_DUAL;
> +	if ((rx_nbits_supported & VIRTIO_SPI_RX_TX_SUPPORT_QUAD) != 0)
> +		ctrl->mode_bits |= SPI_RX_QUAD;
> +	if ((rx_nbits_supported & VIRTIO_SPI_RX_TX_SUPPORT_OCTAL) != 0)
> +		ctrl->mode_bits |= SPI_RX_OCTAL;
> +
> +	ctrl->bits_per_word_mask =
> +		virtio_cread32(vdev, offsetof(struct virtio_spi_config,
> +					      bits_per_word_mask));
> +
> +	priv->max_freq_hz =
> +		virtio_cread32(vdev, offsetof(struct virtio_spi_config,
> +					      max_freq_hz));
> +}
> +
> +static int virtio_spi_find_vqs(struct virtio_spi_priv *priv)
> +{
> +	struct virtqueue *vq;
> +
> +	vq = virtio_find_single_vq(priv->vdev, virtio_spi_msg_done, "spi-rq");
> +	if (IS_ERR(vq))
> +		return (int)PTR_ERR(vq);
> +	priv->vq = vq;
> +	return 0;
> +}
> +
> +/* Function must not be called before virtio_spi_find_vqs() has been run */
> +static void virtio_spi_del_vq(struct virtio_device *vdev)
> +{
> +	virtio_reset_device(vdev);
> +	vdev->config->del_vqs(vdev);
> +}
> +
> +static int virtio_spi_probe(struct virtio_device *vdev)
> +{
> +	struct virtio_spi_priv *priv;
> +	struct spi_controller *ctrl;
> +	int err;
> +	u32 bus_num;
> +
> +	ctrl = devm_spi_alloc_host(&vdev->dev, sizeof(*priv));
> +	if (!ctrl)
> +		return -ENOMEM;
> +
> +	priv = spi_controller_get_devdata(ctrl);
> +	priv->vdev = vdev;
> +	vdev->priv = priv;
> +	ctrl->dev.of_node = vdev->dev.of_node;
> +
> +	/*
> +	 * Setup ACPI node for controlled devices which will be probed through
> +	 * ACPI.
> +	 */
> +	ACPI_COMPANION_SET(&vdev->dev, ACPI_COMPANION(vdev->dev.parent));
> +
> +	dev_set_drvdata(&vdev->dev, ctrl);
> +
> +	init_completion(&priv->spi_req.completion);
> +
> +	err = device_property_read_u32(&ctrl->dev, "spi,bus-num", &bus_num);
> +	if (!err && bus_num <= S16_MAX)
> +		ctrl->bus_num = (s16)bus_num;
> +	else
> +		ctrl->bus_num = -1;
> +
> +	virtio_spi_read_config(vdev);
> +
> +	ctrl->transfer_one = virtio_spi_transfer_one;
> +
> +	err = virtio_spi_find_vqs(priv);
> +	if (err) {
> +		dev_err(&vdev->dev, "Cannot setup virtqueues\n");
> +		return err;
Use dev_err_probe()
> +	}
> +
> +	err = spi_register_controller(ctrl);
> +	if (err) {
> +		dev_err(&vdev->dev, "Cannot register controller\n");
> +		goto err_return;
> +	}
> +
> +	return 0;
> +
> +err_return:
> +	vdev->config->del_vqs(vdev);
> +	return err;
> +}
> +
> +static void virtio_spi_remove(struct virtio_device *vdev)
> +{
> +	struct spi_controller *ctrl = dev_get_drvdata(&vdev->dev);
> +
> +	/* Order: 1.) unregister controller, 2.) remove virtqueue */
> +	spi_unregister_controller(ctrl);
> +	virtio_spi_del_vq(vdev);
> +}
> +
> +static int virtio_spi_freeze(struct virtio_device *vdev)
> +{
> +	struct device *dev = &vdev->dev;
> +	struct spi_controller *ctrl = dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret = spi_controller_suspend(ctrl);
> +	if (ret) {
> +		dev_warn(dev, "cannot suspend controller (%d)\n", ret);
> +		return ret;
> +	}
> +
> +	virtio_spi_del_vq(vdev);
> +	return 0;
> +}
> +
> +static int virtio_spi_restore(struct virtio_device *vdev)
> +{
> +	struct device *dev = &vdev->dev;
> +	struct spi_controller *ctrl = dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret = virtio_spi_find_vqs(vdev->priv);
> +	if (ret) {
> +		dev_err(dev, "problem starting vqueue (%d)\n", ret);
> +		return ret;
> +	}
> +
> +	ret = spi_controller_resume(ctrl);
> +	if (ret)
> +		dev_err(dev, "problem resuming controller (%d)\n", ret);
> +
> +	return ret;
> +}
> +
> +static struct virtio_device_id virtio_spi_id_table[] = {
> +	{ VIRTIO_ID_SPI, VIRTIO_DEV_ANY_ID },
> +	{ 0 },
> +};
> +
> +static struct virtio_driver virtio_spi_driver = {
> +	.driver.name = KBUILD_MODNAME,
> +	.driver.owner = THIS_MODULE,
> +	.id_table = virtio_spi_id_table,
> +	.probe = virtio_spi_probe,
> +	.remove = virtio_spi_remove,
> +	.freeze = pm_sleep_ptr(virtio_spi_freeze),
> +	.restore = pm_sleep_ptr(virtio_spi_restore),
> +};
> +
> +module_virtio_driver(virtio_spi_driver);
> +MODULE_DEVICE_TABLE(virtio, virtio_spi_id_table);
> +
> +MODULE_AUTHOR("Haixu Cui <quic_haixcui@quicinc.com>");
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Virtio SPI bus driver");


