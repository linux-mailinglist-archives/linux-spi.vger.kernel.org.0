Return-Path: <linux-spi+bounces-7707-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C55A95DB1
	for <lists+linux-spi@lfdr.de>; Tue, 22 Apr 2025 08:04:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E386716EACE
	for <lists+linux-spi@lfdr.de>; Tue, 22 Apr 2025 06:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584F619ADA6;
	Tue, 22 Apr 2025 06:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="n6jR4upQ"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AA01A238C;
	Tue, 22 Apr 2025 06:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745301838; cv=none; b=R409JiWFjf+zr8tk2VZGWTMLMCqmdlzD8lXYhQ8lOk0WcQGayJlsFCnC8v+rr7PKiRw6jcpfz/bqH55wP8J11f/RbtbkIQLabFzeZ5DipxA6DBcYNqSBU93+sJLyqAFd5FNAkfu9SdvDskClTPgh6l0v7ufyZa5bScDh6jXESP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745301838; c=relaxed/simple;
	bh=WLtWTJWigPU5TFlGKiLoo+pb65ueNTFvtKu7GVsVzxs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gnGkQ3kSVtfLboED8s568Z2XNh0P27lxkReSP/M2FkIe1QefQApAUpW7XJgg1TEa+r/V3rWBhI0yTwNMsfbhFE1L4gY7MbsJF6jc33Owc7CO7usoB3Pbox0nM9FBZGpkBF/vwb6BD9qQ3jhfU7xCZQ1tdV9qflE1bnnTvcjsUqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=n6jR4upQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53M4OcYY019396;
	Tue, 22 Apr 2025 06:03:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aioItRdQrIEfQa5VwoYckJjRtxFNeTPw5Fn9EIRDy8Q=; b=n6jR4upQydAvm0nY
	z7GivzuRxkpYg9z+2W0UdEGTFkweN5m9Ffjy1GN3YzJyzPb75vv51nNB74EFl/4s
	UNqnqMEMk+rrOVQsDJcbWgB4gUKa1DF3v0FP0TmZidcvc0BOVu/1xazTPt/mOxpd
	YVE/+Z3LOS/hXTbUd5ux4hLU+USct3lQSu1fl9/qscJKr6mP7R8QN65RyDlGZMch
	F8f+VmPouB7r96x8CXsbAxY2K8pQADpCyMAtQDoIIlTlVxX84wSeBw8qaVn3Lq0M
	rFZM2WmewTwiezDEmQp8AYavyz7KEkYBbeIF8dDzW4djBtTv3y/m9xUyDU76J+Mx
	B0AXRg==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46454bp87b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Apr 2025 06:03:48 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53M63mQG029911
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Apr 2025 06:03:48 GMT
Received: from [10.217.219.207] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 21 Apr
 2025 23:03:45 -0700
Message-ID: <f6f087f9-83c9-452e-9a0f-f8743b8c71c2@quicinc.com>
Date: Tue, 22 Apr 2025 11:33:42 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 2/3] virtio-spi: Add virtio-spi.h
To: Haixu Cui <quic_haixcui@quicinc.com>, <broonie@kernel.org>,
        <virtio-dev@lists.oasis-open.org>, <viresh.kumar@linaro.org>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <hdanton@sina.com>, <qiang4.zhang@linux.intel.com>,
        <alex.bennee@linaro.org>
CC: <quic_ztu@quicinc.com>
References: <20250401033621.1614194-1-quic_haixcui@quicinc.com>
 <20250401033621.1614194-3-quic_haixcui@quicinc.com>
Content-Language: en-US
From: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
In-Reply-To: <20250401033621.1614194-3-quic_haixcui@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=cdrSrmDM c=1 sm=1 tr=0 ts=68073144 cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=3TZUXHRvvuryK2-Qt-IA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 3VNBjrDh-A1P7MNS3ivXpHhwvouIjcoz
X-Proofpoint-GUID: 3VNBjrDh-A1P7MNS3ivXpHhwvouIjcoz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-22_03,2025-04-21_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 phishscore=0 adultscore=0 mlxlogscore=999 malwarescore=0 clxscore=1015
 spamscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504220045

Thanks Haixu ! Important changes.

On 4/1/2025 9:06 AM, Haixu Cui wrote:

[...]
> +/*
> + * All config fields are read-only for the Virtio SPI driver
> + *
> + * @cs_max_number: maximum number of chipselect the host SPI controller
> + *   supports.
> + * @cs_change_supported: indicates if the host SPI controller supports to toggle
> + * chipselect after each transfer in one message:
> + *   0: unsupported, chipselect will be kept in active state throughout the
> + *      message transaction;
> + *   1: supported.
> + *   Note: Message here contains a sequence of SPI transfers.
> + * @tx_nbits_supported: indicates the supported number of bit for writing:
> + *   bit 0: DUAL (2-bit transfer), 1 for supported
> + *   bit 1: QUAD (4-bit transfer), 1 for supported
> + *   bit 2: OCTAL (8-bit transfer), 1 for supported
> + *   other bits are reserved as 0, 1-bit transfer is always supported.
> + * @rx_nbits_supported: indicates the supported number of bit for reading:
> + *   bit 0: DUAL (2-bit transfer), 1 for supported
> + *   bit 1: QUAD (4-bit transfer), 1 for supported
> + *   bit 2: OCTAL (8-bit transfer), 1 for supported
> + *   other bits are reserved as 0, 1-bit transfer is always supported.
> + * @bits_per_word_mask: mask indicating which values of bits_per_word are
> + *   supported. If not set, no limitation for bits_per_word.
> + * @mode_func_supported: indicates the following features are supported or not:
mode_func_supported[b'6-0] : something like this may help to know size 
of this variable.
> + *   bit 0-1: CPHA feature
> + *     0b00: invalid, should support as least one CPHA setting
> + *     0b01: supports CPHA=0 only
> + *     0b10: supports CPHA=1 only
> + *     0b11: supports CPHA=0 and CPHA=1.
> + *   bit 2-3: CPOL feature
> + *     0b00: invalid, should support as least one CPOL setting
> + *     0b01: supports CPOL=0 only
> + *     0b10: supports CPOL=1 only
> + *     0b11: supports CPOL=0 and CPOL=1.
> + *   bit 4: chipselect active high feature, 0 for unsupported and 1 for
> + *     supported, chipselect active low should always be supported.
You mean to say "chipselect active low is default supported" ?

Just thinking instead of keeping always supported, can we mentione as 
default supported ?

> + *   bit 5: LSB first feature, 0 for unsupported and 1 for supported,
> + *     MSB first should always be supported.
MSB first is default supported ?
> + *   bit 6: loopback mode feature, 0 for unsupported and 1 for supported,
> + *     normal mode should always be supported.
we can reverse the write up for all "always be supported"

bit 6: if not specified, normal mode is supported by default. if set 1, 
specifies loopback mode.
> + * @max_freq_hz: the maximum clock rate supported in Hz unit, 0 means no
> + *   limitation for transfer speed.
> + * @max_word_delay_ns: the maximum word delay supported in ns unit,
> + *   0 means word delay feature is unsupported.
> + *   Note: Just as one message contains a sequence of transfers,
> + *         one transfer may contain a sequence of words.
> + * @max_cs_setup_ns: the maximum delay supported after chipselect is asserted,
> + *   in ns unit, 0 means delay is not supported to introduce after chipselect is
> + *   asserted.
> + * @max_cs_hold_ns: the maximum delay supported before chipselect is deasserted,
> + *   in ns unit, 0 means delay is not supported to introduce before chipselect
> + *   is deasserted.
> + * @max_cs_incative_ns: maximum delay supported after chipselect is deasserted,
> + *   in ns unit, 0 means delay is not supported to introduce after chipselect is
> + *   deasserted.
> + */
> +struct virtio_spi_config {
> +	/* # of /dev/spidev<bus_num>.CS with CS=0..chip_select_max_number -1 */
> +	__u8 cs_max_number;
> +	__u8 cs_change_supported;
> +#define VIRTIO_SPI_RX_TX_SUPPORT_DUAL (1 << 0)
> +#define VIRTIO_SPI_RX_TX_SUPPORT_QUAD (1 << 1)
> +#define VIRTIO_SPI_RX_TX_SUPPORT_OCTAL (1 << 2)
Can use BIT(x) ?
> +	__u8 tx_nbits_supported;
> +	__u8 rx_nbits_supported;
> +	__le32 bits_per_word_mask;
> +#define VIRTIO_SPI_MF_SUPPORT_CPHA_0 (1 << 0)
> +#define VIRTIO_SPI_MF_SUPPORT_CPHA_1 (1 << 1)
> +#define VIRTIO_SPI_MF_SUPPORT_CPOL_0 (1 << 2)
> +#define VIRTIO_SPI_MF_SUPPORT_CPOL_1 (1 << 3)
> +#define VIRTIO_SPI_MF_SUPPORT_CS_HIGH (1 << 4)
> +#define VIRTIO_SPI_MF_SUPPORT_LSB_FIRST (1 << 5)
> +#define VIRTIO_SPI_MF_SUPPORT_LOOPBACK (1 << 6)
All with BIT(x) ?
> +	__le32 mode_func_supported;
> +	__le32 max_freq_hz;
> +	__le32 max_word_delay_ns;
> +	__le32 max_cs_setup_ns;
> +	__le32 max_cs_hold_ns;
> +	__le32 max_cs_inactive_ns;
> +};
[...]
> +
> +#endif /* #ifndef _LINUX_VIRTIO_VIRTIO_SPI_H */


