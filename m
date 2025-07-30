Return-Path: <linux-spi+bounces-9236-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A678EB1605D
	for <lists+linux-spi@lfdr.de>; Wed, 30 Jul 2025 14:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF2B5545398
	for <lists+linux-spi@lfdr.de>; Wed, 30 Jul 2025 12:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C8F17A30F;
	Wed, 30 Jul 2025 12:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jmZoesxt"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2D1347C7
	for <linux-spi@vger.kernel.org>; Wed, 30 Jul 2025 12:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753878712; cv=none; b=IsaIAaDZpeW9lkQ4+eA7QHPolcTf1SLaOji8C2Er6SD3XfrQqOFrgHtK7A08p0xKTXJtGUQ3WMjCfRzBNaWnbnboDgNctFZ0M4vC4Yi5GjDM2jmhfV0fXRwugyPm7kQY/86oOdKz+TWqTepDP5Dnhs404dhbj7T/aena6BoaVRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753878712; c=relaxed/simple;
	bh=y0mhHymve2xd3EafMEuj5nzMjkwEl/iTHvZzMCqVvHE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RUOD07smzAxl4Try7+wziBM5flhy5vDqi/mY7iBzE6gwCorQ56bcsuY+8LlrpbXk3mv3aTBc8ZBD50/8K3qLGPsWD1k6RZ4remskWgFc+rLOkAeixhyGttGx2t2EptZM4JqCVrl3vI+j8wH2abt5H+dG1nHTRlzBb/fSfGw27P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jmZoesxt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56UCRFjo027387
	for <linux-spi@vger.kernel.org>; Wed, 30 Jul 2025 12:31:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oVvkZH8fL4jtpPMoVbOMqc+YwXp8pJW4I1NLZU7D5Yo=; b=jmZoesxtc+Cwh8uf
	z+QpltvlrMZx2KsiWcQyAvE6ULlYQJodVCAo/YRmHhz1DRLRWpX0W9QQFK9IneCC
	9n7xVyIYhN6rWASv1Oco80tYrBivFfRT/kKU4SLBn0pRWX/QSFLGeQ1F8ZgUzpHI
	Vyb2+E2uqSoDdi2xiaXSNQUhXvALb+/3l7dLGbwwS2qVft+skeV6A0CZH0dLFkWs
	cVrRFWGQ1iUZ8/7tx0iIgDojbCAjUioMpWVF87xCZQ1USmrmUGtJogOJz4FPG9Wd
	1+40BTElvuFZFcCtf3VFDWHMCKImCdUNrnahNrIHv7pKe679mSIbXILn152gn9ey
	gHNs1g==
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484pbm3mfj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Wed, 30 Jul 2025 12:31:49 +0000 (GMT)
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-2ea03d4f78cso2955568fac.1
        for <linux-spi@vger.kernel.org>; Wed, 30 Jul 2025 05:31:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753878709; x=1754483509;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oVvkZH8fL4jtpPMoVbOMqc+YwXp8pJW4I1NLZU7D5Yo=;
        b=EIERelW3bobDwqFTY0gAHoUJcPlpA5VrJGmGbVg8d1nPSXmt3K9OY3RBV+qUgb52J4
         kW2X9mMC1DVJUFPGfyXDo6TRdb2PsKTj662EH2+GBpmHeyDz9NDNVz4NT/VK/0xP5xkv
         RpiZpCG0+2IxgmLTm4/b4vb4kMUWh1bUlffBqzsS7YN8f1zx2MaJriU/7QMUcmayFIEl
         aibr4heAl/TwhZ62RkbZSEZKlzDK1N/XtFPJ06GPQ4ycmR1X04Era9zPHUcSQtRaNlBC
         afwT1MDFA4Ik+oWaMkHX8ifNOh01uDw4WFR79oet7+EhhYFjtchk3iSYQr9jdSlP5f40
         Ed/A==
X-Forwarded-Encrypted: i=1; AJvYcCWWd9J3KvfJL7FxURIihV/kQtCE//xkvFswK4YeckTXfSuBCIJGGlDXMmuU9lv7udYf3HYAVVpXW5I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVsORNYHQJQMKrQ0ZiSfWmW3fwHyZ3FLhSmgv45vyhjCPhFOqb
	9gZIvYO2ZRED2LScDTiPT9Vw4jVN52DoRgNFdsSf/NQvqNHYrCX+j0oEZuIiXGqmDK2X/36cUBj
	Wm+QV7iHCJ2kM7oHE2srenT6LvXlX0H6ZqGQoWmaVjHv3qf8aaAVPPG3f1+/IOO0=
X-Gm-Gg: ASbGncvpJ064VmO5X8pRcW1Lw+/pDIJchh++AxNAxwJFAEmwf4C5Zpfm7C5w6mgw24g
	QQrPDh5QwPrGnyJDUKzx7gkCWMkB2ybU+d2wQCFi33HRn6yrjo6sPwW4ISQg1R0bJSU3t2D66PJ
	qYUXJ4p1yDYk9RAYo5eLHRid0zl8DSzTW2yptnAibpyMkyIFQoIoqYXc5M+TeTm42G2ln2biwnk
	mZzTq+ColPd9UIMDVTlO/Cm6X+jiNf+kJJ9vhHDqL56pEw2iQShkDi73U/Yj09Gl8y0Qu9XIDn4
	phBPHXtnpzIh7GfUxhBVijhDg39IpdO9OtnfIhrUgCvIAJxHFgTPGA==
X-Received: by 2002:a05:6870:649f:b0:306:a149:f4c0 with SMTP id 586e51a60fabf-30785c4c08amr2010204fac.23.1753878708482;
        Wed, 30 Jul 2025 05:31:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHa3gmzKUkt2JJpFPsXUuyaMKj2diJtxIRuyxdFH28u6rjOGyjqIyTZ+s5Q2Ph/TjPfmSTjDg==
X-Received: by 2002:a05:6870:649f:b0:306:a149:f4c0 with SMTP id 586e51a60fabf-30785c4c08amr2010170fac.23.1753878707965;
        Wed, 30 Jul 2025 05:31:47 -0700 (PDT)
Received: from [172.22.19.48] ([212.136.9.4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af635aa3095sm733649666b.104.2025.07.30.05.31.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 05:31:46 -0700 (PDT)
Message-ID: <d962ed41-2566-432d-975d-9bab8d844c70@oss.qualcomm.com>
Date: Wed, 30 Jul 2025 14:31:44 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v6 2/3] virtio-spi: Add virtio-spi.h
To: Haixu Cui <quic_haixcui@quicinc.com>, quic_msavaliy@quicinc.com,
        broonie@kernel.org, virtio-dev@lists.linux.dev,
        viresh.kumar@linaro.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, hdanton@sina.com,
        qiang4.zhang@linux.intel.com, alex.bennee@linaro.org
Cc: quic_ztu@quicinc.com, matti@qti.qualcomm.com
References: <20250724092746.1297608-1-quic_haixcui@quicinc.com>
 <20250724092746.1297608-3-quic_haixcui@quicinc.com>
Content-Language: en-US
From: Harald Mommer <harald.mommer@oss.qualcomm.com>
In-Reply-To: <20250724092746.1297608-3-quic_haixcui@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=LsaSymdc c=1 sm=1 tr=0 ts=688a10b5 cx=c_pps
 a=nSjmGuzVYOmhOUYzIAhsAg==:117 a=dNlqnMcrdpbb+gQrTujlOQ==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8 a=H0x4yso8YIw0H6KSdXIA:9
 a=QEXdDO2ut3YA:10 a=1zu1i0D7hVQfj8NKfPKu:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMwMDA4NyBTYWx0ZWRfXz4Ps7vpFJhbg
 K3XRj9UrqVVJpppgWknWy1VfAn/ttaeOtL4scYeYyXStAE3/hUbxE2hK3yVAERGFD65xIkt+1Da
 LxmUXBCo7b74/bopo+YhHg2txR7SfKLvyb0MZZtxaVVX+uIiM7rQboCbgjgrbrCT9DjB9V7MPt7
 lDwCqNdHEaOR5ihD6oBRAXogh5U4bbx860K+CsXm7HGfWQTYAbFLh6F70QN8jSxHl6/d08GDujG
 84ZxjPjBMpRxZQQqbI+gBfbEvEeIMFlT2d37Rh9BH7kLFvawikDfVzf2rhHFFnuyOCryszaDeCb
 gBOBTKVu33XhG00Xh4n2RIluqvqUZlofzgwmHY5g/84L7RUACsRU+yau2ZGJ0oQmy2oEO1uIkwL
 6PD2QRqYGnkDcwSqb6LHGRVd5vbfzIC9k+jfCIAvNczp2OVZywVDKWXeob2/u5Oerff7IpNV
X-Proofpoint-ORIG-GUID: UStPSdaGwFAeZt_rjf8tV-67hiHXMjj3
X-Proofpoint-GUID: UStPSdaGwFAeZt_rjf8tV-67hiHXMjj3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-30_04,2025-07-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 mlxlogscore=999 spamscore=0 phishscore=0 suspectscore=0
 impostorscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 bulkscore=0 mlxscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507300087

Hello,

On 7/24/25 11:27, Haixu Cui wrote:
> Add virtio-spi.h header for virtio SPI.
> 
> Signed-off-by: Haixu Cui <quic_haixcui@quicinc.com>
> ---
>  include/uapi/linux/virtio_spi.h | 185 ++++++++++++++++++++++++++++++++
>  1 file changed, 185 insertions(+)
>  create mode 100644 include/uapi/linux/virtio_spi.h
> 
> diff --git a/include/uapi/linux/virtio_spi.h b/include/uapi/linux/virtio_spi.h
> new file mode 100644
> index 000000000000..db94f32bd229
> --- /dev/null
> +++ b/include/uapi/linux/virtio_spi.h
> @@ -0,0 +1,185 @@
> +/* SPDX-License-Identifier: BSD-3-Clause */
> +/*

Policy was to keep the old OpenSynergy copyright notice when up-streaming started when up-streaming started in OpenSynergy times. This is also the case here with those files.

The old "Copyright (C) 2023 OpenSynergy GmbH" still present in V3 must probably be kept on top of the Qualcomm copyright line.

Re-checked this in virtio_rtc_driver.c from my colleague who also transitioned from OpenSynergy to Qualcomm. Virtio RTC has landed in the meantime in the mainline kernel.

What's for sure is that this has not started in 2025.

> + * Copyright (C) 2025 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +#ifndef _LINUX_VIRTIO_VIRTIO_SPI_H
> +#define _LINUX_VIRTIO_VIRTIO_SPI_H
> +
> +#include <linux/types.h>
> +#include <linux/virtio_config.h>
> +#include <linux/virtio_ids.h>
> +#include <linux/virtio_types.h>
> +
> +/* Sample data on trailing clock edge */
> +#define VIRTIO_SPI_CPHA			BIT(0)
> +/* Clock is high when IDLE */
> +#define VIRTIO_SPI_CPOL			BIT(1)
> +/* Chip Select is active high */
> +#define VIRTIO_SPI_CS_HIGH		BIT(2)
> +/* Transmit LSB first */
> +#define VIRTIO_SPI_MODE_LSB_FIRST	BIT(3)
> +/* Loopback mode */
> +#define VIRTIO_SPI_MODE_LOOP		BIT(4)
> +
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
> + *     supported, chipselect active low is supported by default.
> + *   bit 5: LSB first feature, 0 for unsupported and 1 for supported,
> + *     MSB first is supported by default.
> + *   bit 6: loopback mode feature, 0 for unsupported and 1 for supported,
> + *     normal mode is supported by default.
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
> +#define VIRTIO_SPI_RX_TX_SUPPORT_DUAL		BIT(0)
> +#define VIRTIO_SPI_RX_TX_SUPPORT_QUAD		BIT(1)
> +#define VIRTIO_SPI_RX_TX_SUPPORT_OCTAL		BIT(2)
> +	__u8 tx_nbits_supported;
> +	__u8 rx_nbits_supported;
> +	__le32 bits_per_word_mask;
> +#define VIRTIO_SPI_MF_SUPPORT_CPHA_0		BIT(0)
> +#define VIRTIO_SPI_MF_SUPPORT_CPHA_1		BIT(1)
> +#define VIRTIO_SPI_MF_SUPPORT_CPOL_0		BIT(2)
> +#define VIRTIO_SPI_MF_SUPPORT_CPOL_1		BIT(3)
> +#define VIRTIO_SPI_MF_SUPPORT_CS_HIGH		BIT(4)
> +#define VIRTIO_SPI_MF_SUPPORT_LSB_FIRST		BIT(5)
> +#define VIRTIO_SPI_MF_SUPPORT_LOOPBACK		BIT(6)
> +	__le32 mode_func_supported;
> +	__le32 max_freq_hz;
> +	__le32 max_word_delay_ns;
> +	__le32 max_cs_setup_ns;
> +	__le32 max_cs_hold_ns;
> +	__le32 max_cs_inactive_ns;
> +};
> +
> +/*
> + * @chip_select_id: chipselect index the SPI transfer used.
> + *
> + * @bits_per_word: the number of bits in each SPI transfer word.
> + *
> + * @cs_change: whether to deselect device after finishing this transfer
> + *     before starting the next transfer, 0 means cs keep asserted and
> + *     1 means cs deasserted then asserted again.
> + *
> + * @tx_nbits: bus width for write transfer.
> + *     0,1: bus width is 1, also known as SINGLE
> + *     2  : bus width is 2, also known as DUAL
> + *     4  : bus width is 4, also known as QUAD
> + *     8  : bus width is 8, also known as OCTAL
> + *     other values are invalid.
> + *
> + * @rx_nbits: bus width for read transfer.
> + *     0,1: bus width is 1, also known as SINGLE
> + *     2  : bus width is 2, also known as DUAL
> + *     4  : bus width is 4, also known as QUAD
> + *     8  : bus width is 8, also known as OCTAL
> + *     other values are invalid.
> + *
> + * @reserved: for future use.
> + *
> + * @mode: SPI transfer mode.
> + *     bit 0: CPHA, determines the timing (i.e. phase) of the data
> + *         bits relative to the clock pulses.For CPHA=0, the
> + *         "out" side changes the data on the trailing edge of the
> + *         preceding clock cycle, while the "in" side captures the data
> + *         on (or shortly after) the leading edge of the clock cycle.
> + *         For CPHA=1, the "out" side changes the data on the leading
> + *         edge of the current clock cycle, while the "in" side
> + *         captures the data on (or shortly after) the trailing edge of
> + *         the clock cycle.
> + *     bit 1: CPOL, determines the polarity of the clock. CPOL=0 is a
> + *         clock which idles at 0, and each cycle consists of a pulse
> + *         of 1. CPOL=1 is a clock which idles at 1, and each cycle
> + *         consists of a pulse of 0.
> + *     bit 2: CS_HIGH, if 1, chip select active high, else active low.
> + *     bit 3: LSB_FIRST, determines per-word bits-on-wire, if 0, MSB
> + *         first, else LSB first.
> + *     bit 4: LOOP, loopback mode.
> + *
> + * @freq: the transfer speed in Hz.
> + *
> + * @word_delay_ns: delay to be inserted between consecutive words of a
> + *     transfer, in ns unit.
> + *
> + * @cs_setup_ns: delay to be introduced after CS is asserted, in ns
> + *     unit.
> + *
> + * @cs_delay_hold_ns: delay to be introduced before CS is deasserted
> + *     for each transfer, in ns unit.
> + *
> + * @cs_change_delay_inactive_ns: delay to be introduced after CS is
> + *     deasserted and before next asserted, in ns unit.
> + */
> +struct spi_transfer_head {
> +	__u8 chip_select_id;
> +	__u8 bits_per_word;
> +	__u8 cs_change;
> +	__u8 tx_nbits;
> +	__u8 rx_nbits;
> +	__u8 reserved[3];
> +	__le32 mode;
> +	__le32 freq;
> +	__le32 word_delay_ns;
> +	__le32 cs_setup_ns;
> +	__le32 cs_delay_hold_ns;
> +	__le32 cs_change_delay_inactive_ns;
> +};
> +
> +struct spi_transfer_result {
> +#define VIRTIO_SPI_TRANS_OK	0
> +#define VIRTIO_SPI_PARAM_ERR	1
> +#define VIRTIO_SPI_TRANS_ERR	2
> +	__u8 result;
> +};
> +
> +#endif /* #ifndef _LINUX_VIRTIO_VIRTIO_SPI_H */


