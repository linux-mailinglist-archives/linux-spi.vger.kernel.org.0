Return-Path: <linux-spi+bounces-7620-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7BE3A8B7F6
	for <lists+linux-spi@lfdr.de>; Wed, 16 Apr 2025 13:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0AF3444BFF
	for <lists+linux-spi@lfdr.de>; Wed, 16 Apr 2025 11:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D88B023C376;
	Wed, 16 Apr 2025 11:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="o49WG1wb"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B8E221FCD;
	Wed, 16 Apr 2025 11:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744804683; cv=none; b=BYD0V+HvpHgA+HM803dbCDC1liIuTYlXGzngiNMpyMYY3fwS2CY16HCY/Iy+eKNFYYxwyX33xbcAL7ApvzF4AOPU2EuV8gMYmpjHuvjUptANfkdIfg28BdH8Gb7SGLId//XL/AvsuHoGWBL2ZjjdiUH28icK7JsEPjRnwTGkCuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744804683; c=relaxed/simple;
	bh=B4N/tVyDJZIpSunM0HgjujjZhDnUnz3Z/M5m8KGpvGE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=EbmaCKDUifWjJ6rLvlAKA950R0uYutGiLKSmHpFgNfdOxktg1aQU8e/zmjG3zjDQqxf8k/UlzXeZvdiUsKXeLY6fxeW5N0NPizglI1/IrmGitMBXpSZs4NRcGSHq1NrbLH4FUi00kj4x0wEcE7N2LYvYdnVPDUx+jm+wIw902SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=o49WG1wb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53G9mFZE000407;
	Wed, 16 Apr 2025 11:57:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gszDPz4kmoG6mwezXb3AVBzlGyrfhY/LvDie3L4uuT8=; b=o49WG1wbntmiKS6z
	ViYtNSxG/PCPcJnMrMOGSKIe00q8c2o9/We3QRObhliqcKOrn3xuILkPwnGJvCpz
	ABgJsDVYTzSgHlJUY2PMxvT/ZMURDi+TiH+sClIiCt+6jGF+DmlqxqXoUFN0gC0q
	tdq1zNUHuTHousNvEymtDStrxcY+eDYo4KRLD8u2nlTRG/cdPBxxLai96Ag0y+4Y
	lUOhgEoy2vsmc4e+Td6fWQ8CEQJQPj0umxjuTJyioCkpOktOMitcjYl7oGziW1ds
	KQxleBK1Fr5VqQhEWeilqy57LGrVwTXQawjtGWOLhBCKq/J6RU+VWqxKsmVLZRlY
	EYP21Q==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45yf4vkghj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Apr 2025 11:57:54 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53GBvr9S006784
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Apr 2025 11:57:53 GMT
Received: from [10.217.219.207] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 16 Apr
 2025 04:57:50 -0700
Message-ID: <1484e250-bbb6-4d1e-9285-2ccf1b8215fd@quicinc.com>
Date: Wed, 16 Apr 2025 17:27:47 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/6] spi: tegra210-quad: Add support for internal DMA
To: Vishwaroop A <va@nvidia.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <skomatineni@nvidia.com>,
        <ldewangan@nvidia.com>, <broonie@kernel.org>,
        <linux-spi@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kyarlagadda@nvidia.com>,
        <smangipudi@nvidia.com>
References: <20250416110606.2737315-1-va@nvidia.com>
 <20250416110606.2737315-7-va@nvidia.com>
Content-Language: en-US
From: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
In-Reply-To: <20250416110606.2737315-7-va@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 3MmwpKv-YqHWv0IngfpUtXajtM3mxQin
X-Authority-Analysis: v=2.4 cv=IZ6HWXqa c=1 sm=1 tr=0 ts=67ff9b42 cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=Ikd4Dj_1AAAA:8 a=1jq-n9C2WfOyWCMQ9YgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 3MmwpKv-YqHWv0IngfpUtXajtM3mxQin
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-16_04,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1011 malwarescore=0 spamscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 impostorscore=0 suspectscore=0
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504160098



On 4/16/2025 4:36 PM, Vishwaroop A wrote:
> Previous generations of Tegra supported DMA operations by an external
> DMA controller, but the QSPI on Tegra234 devices now have an internal
> DMA controller.
> 
> Introduce routines to initialize and configure internal DMA channels
> for both transmit and receive paths. Set up DMA mapping functions to
> manage buffer addresses effectively.
> 
> The variable err is changed to num_errors to more accurately represent
> its purpose in the code. The updated name clarifies that the variable
> tracks the number of errors encountered during execution, rather than
> serving as a generic error flag or code.
> 
> Tegra241 device supports DMA via an external DMA controller (GPCDMA), so
> enable this.
> 
> Signed-off-by: Vishwaroop A <va@nvidia.com>
> ---
>   drivers/spi/spi-tegra210-quad.c | 227 +++++++++++++++++++-------------
>   1 file changed, 132 insertions(+), 95 deletions(-)
> 
> diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
> index 04f41e92c1e2..e80a0850d07e 100644
> --- a/drivers/spi/spi-tegra210-quad.c
> +++ b/drivers/spi/spi-tegra210-quad.c
> @@ -111,6 +111,9 @@
>   #define QSPI_DMA_BLK				0x024
>   #define QSPI_DMA_BLK_SET(x)			(((x) & 0xffff) << 0)
>   
> +#define QSPI_DMA_MEM_ADDRESS			0x028
> +#define QSPI_DMA_HI_ADDRESS			0x02c
> +
>   #define QSPI_TX_FIFO				0x108
>   #define QSPI_RX_FIFO				0x188
>   
> @@ -167,9 +170,9 @@ enum tegra_qspi_transfer_type {
>   };
>   
>   struct tegra_qspi_soc_data {
> -	bool has_dma;
>   	bool cmb_xfer_capable;
>   	bool supports_tpm;
> +	bool has_ext_dma;
>   	unsigned int cs_count;
>   };
>   
> @@ -605,17 +608,21 @@ static void tegra_qspi_dma_unmap_xfer(struct tegra_qspi *tqspi, struct spi_trans
>   
>   	len = DIV_ROUND_UP(tqspi->curr_dma_words * tqspi->bytes_per_word, 4) * 4;
>   
> -	dma_unmap_single(tqspi->dev, t->tx_dma, len, DMA_TO_DEVICE);
> -	dma_unmap_single(tqspi->dev, t->rx_dma, len, DMA_FROM_DEVICE);
> +	if (t->tx_buf)
> +		dma_unmap_single(tqspi->dev, t->tx_dma, len, DMA_TO_DEVICE);
> +	if (t->rx_buf)
> +		dma_unmap_single(tqspi->dev, t->rx_dma, len, DMA_FROM_DEVICE);
>   }
>   
>   static int tegra_qspi_start_dma_based_transfer(struct tegra_qspi *tqspi, struct spi_transfer *t)
>   {
>   	struct dma_slave_config dma_sconfig = { 0 };
> +	dma_addr_t rx_dma_phys, tx_dma_phys;
>   	unsigned int len;
>   	u8 dma_burst;
>   	int ret = 0;
>   	u32 val;
> +	bool has_ext_dma = tqspi->soc_data->has_ext_dma;
>   
>   	if (tqspi->is_packed) {
>   		ret = tegra_qspi_dma_map_xfer(tqspi, t);
> @@ -634,60 +641,86 @@ static int tegra_qspi_start_dma_based_transfer(struct tegra_qspi *tqspi, struct
>   		len = tqspi->curr_dma_words * 4;
>   
>   	/* set attention level based on length of transfer */
> -	val = 0;
> -	if (len & 0xf) {
> -		val |= QSPI_TX_TRIG_1 | QSPI_RX_TRIG_1;
> -		dma_burst = 1;
> -	} else if (((len) >> 4) & 0x1) {
> -		val |= QSPI_TX_TRIG_4 | QSPI_RX_TRIG_4;
> -		dma_burst = 4;
> -	} else {
> -		val |= QSPI_TX_TRIG_8 | QSPI_RX_TRIG_8;
> -		dma_burst = 8;
> +	if (has_ext_dma) {
> +		val = 0;
> +		if (len & 0xf) {
> +			val |= QSPI_TX_TRIG_1 | QSPI_RX_TRIG_1;
> +			dma_burst = 1;
> +		} else if (((len) >> 4) & 0x1) {
> +			val |= QSPI_TX_TRIG_4 | QSPI_RX_TRIG_4;
> +			dma_burst = 4;
> +		} else {
> +			val |= QSPI_TX_TRIG_8 | QSPI_RX_TRIG_8;
> +			dma_burst = 8;
> +		}
> +
> +		tegra_qspi_writel(tqspi, val, QSPI_DMA_CTL);
>   	}
>   
> -	tegra_qspi_writel(tqspi, val, QSPI_DMA_CTL);
>   	tqspi->dma_control_reg = val;
>   
>   	dma_sconfig.device_fc = true;
> -	if (tqspi->cur_direction & DATA_DIR_TX) {
> -		dma_sconfig.dst_addr = tqspi->phys + QSPI_TX_FIFO;
> -		dma_sconfig.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
> -		dma_sconfig.dst_maxburst = dma_burst;
> -		ret = dmaengine_slave_config(tqspi->tx_dma_chan, &dma_sconfig);
> -		if (ret < 0) {
> -			dev_err(tqspi->dev, "failed DMA slave config: %d\n", ret);
> -			return ret;
> -		}
>   
> -		tegra_qspi_copy_client_txbuf_to_qspi_txbuf(tqspi, t);
> -		ret = tegra_qspi_start_tx_dma(tqspi, t, len);
> -		if (ret < 0) {
> -			dev_err(tqspi->dev, "failed to starting TX DMA: %d\n", ret);
> -			return ret;
> +	if ((tqspi->cur_direction & DATA_DIR_TX)) {
> +		if (tqspi->tx_dma_chan) {
> +			dma_sconfig.dst_addr = tqspi->phys + QSPI_TX_FIFO;
> +			dma_sconfig.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
> +			dma_sconfig.dst_maxburst = dma_burst;
> +			ret = dmaengine_slave_config(tqspi->tx_dma_chan, &dma_sconfig);
> +			if (ret < 0) {
> +				dev_err(tqspi->dev, "failed DMA slave config: %d\n", ret);
> +				return ret;
> +			}
> +
> +			tegra_qspi_copy_client_txbuf_to_qspi_txbuf(tqspi, t);
> +			ret = tegra_qspi_start_tx_dma(tqspi, t, len);
> +			if (ret < 0) {
> +				dev_err(tqspi->dev, "failed to starting TX DMA: %d\n", ret);
> +				return ret;
> +			}
> +		} else {
> +			if (tqspi->is_packed)
> +				tx_dma_phys = t->tx_dma;
> +			else
> +				tx_dma_phys = tqspi->tx_dma_phys;
> +			tegra_qspi_copy_client_txbuf_to_qspi_txbuf(tqspi, t);
> +			tegra_qspi_writel(tqspi, lower_32_bits(tx_dma_phys),
> +					  QSPI_DMA_MEM_ADDRESS);
> +			tegra_qspi_writel(tqspi, (upper_32_bits(tx_dma_phys) & 0xff),
> +					  QSPI_DMA_HI_ADDRESS);
>   		}
>   	}
>   
>   	if (tqspi->cur_direction & DATA_DIR_RX) {
> -		dma_sconfig.src_addr = tqspi->phys + QSPI_RX_FIFO;
> -		dma_sconfig.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
> -		dma_sconfig.src_maxburst = dma_burst;
> -		ret = dmaengine_slave_config(tqspi->rx_dma_chan, &dma_sconfig);
> -		if (ret < 0) {
> -			dev_err(tqspi->dev, "failed DMA slave config: %d\n", ret);
> -			return ret;
> -		}
> -
> -		dma_sync_single_for_device(tqspi->dev, tqspi->rx_dma_phys,
> -					   tqspi->dma_buf_size,
> -					   DMA_FROM_DEVICE);
> +		if (tqspi->rx_dma_chan) {
> +			dma_sconfig.src_addr = tqspi->phys + QSPI_RX_FIFO;
> +			dma_sconfig.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
> +			dma_sconfig.src_maxburst = dma_burst;
> +			ret = dmaengine_slave_config(tqspi->rx_dma_chan, &dma_sconfig);
> +			if (ret < 0) {
> +				dev_err(tqspi->dev, "failed DMA slave config: %d\n", ret);
> +				return ret;
> +			}
> +			dma_sync_single_for_device(tqspi->dev, tqspi->rx_dma_phys,
> +						   tqspi->dma_buf_size, DMA_FROM_DEVICE);
> +			ret = tegra_qspi_start_rx_dma(tqspi, t, len);
> +			if (ret < 0) {
> +				dev_err(tqspi->dev, "failed to start RX DMA: %d\n", ret);
> +				if (tqspi->cur_direction & DATA_DIR_TX)
> +					dmaengine_terminate_all(tqspi->tx_dma_chan);
> +				return ret;
> +			}
>   
> -		ret = tegra_qspi_start_rx_dma(tqspi, t, len);
> -		if (ret < 0) {
> -			dev_err(tqspi->dev, "failed to start RX DMA: %d\n", ret);
> -			if (tqspi->cur_direction & DATA_DIR_TX)
> -				dmaengine_terminate_all(tqspi->tx_dma_chan);
> -			return ret;
> +		} else {
> +			if (tqspi->is_packed)
> +				rx_dma_phys = t->rx_dma;
> +			else
> +				rx_dma_phys = tqspi->rx_dma_phys;
> +
> +			tegra_qspi_writel(tqspi, lower_32_bits(rx_dma_phys),
> +					  QSPI_DMA_MEM_ADDRESS);
> +			tegra_qspi_writel(tqspi, (upper_32_bits(rx_dma_phys) & 0xff),
> +					  QSPI_DMA_HI_ADDRESS);
>   		}
>   	}
>   
> @@ -726,9 +759,6 @@ static int tegra_qspi_start_cpu_based_transfer(struct tegra_qspi *qspi, struct s
>   
>   static void tegra_qspi_deinit_dma(struct tegra_qspi *tqspi)
>   {
> -	if (!tqspi->soc_data->has_dma)
> -		return;
> -
>   	if (tqspi->tx_dma_buf) {
>   		dma_free_coherent(tqspi->dev, tqspi->dma_buf_size,
>   				  tqspi->tx_dma_buf, tqspi->tx_dma_phys);
> @@ -759,16 +789,26 @@ static int tegra_qspi_init_dma(struct tegra_qspi *tqspi)
>   	u32 *dma_buf;
>   	int err;
>   
> -	if (!tqspi->soc_data->has_dma)
> -		return 0;
> +	if (tqspi->soc_data->has_ext_dma) {
> +		dma_chan = dma_request_chan(tqspi->dev, "rx");
> +		if (IS_ERR(dma_chan)) {
> +			err = PTR_ERR(dma_chan);
> +			goto err_out;
> +		}
>   
> -	dma_chan = dma_request_chan(tqspi->dev, "rx");
> -	if (IS_ERR(dma_chan)) {
> -		err = PTR_ERR(dma_chan);
> -		goto err_out;
> -	}
> +		tqspi->rx_dma_chan = dma_chan;
>   
> -	tqspi->rx_dma_chan = dma_chan;
> +		dma_chan = dma_request_chan(tqspi->dev, "tx");
> +		if (IS_ERR(dma_chan)) {
> +			err = PTR_ERR(dma_chan);
> +			goto err_out;
> +		}
> +
> +		tqspi->tx_dma_chan = dma_chan;
> +	} else {
> +		tqspi->rx_dma_chan = NULL;
> +		tqspi->tx_dma_chan = NULL;
> +	}
>   
>   	dma_buf = dma_alloc_coherent(tqspi->dev, tqspi->dma_buf_size, &dma_phys, GFP_KERNEL);
>   	if (!dma_buf) {
> @@ -779,14 +819,6 @@ static int tegra_qspi_init_dma(struct tegra_qspi *tqspi)
>   	tqspi->rx_dma_buf = dma_buf;
>   	tqspi->rx_dma_phys = dma_phys;
>   
> -	dma_chan = dma_request_chan(tqspi->dev, "tx");
> -	if (IS_ERR(dma_chan)) {
> -		err = PTR_ERR(dma_chan);
> -		goto err_out;
> -	}
> -
> -	tqspi->tx_dma_chan = dma_chan;
> -
>   	dma_buf = dma_alloc_coherent(tqspi->dev, tqspi->dma_buf_size, &dma_phys, GFP_KERNEL);
>   	if (!dma_buf) {
>   		err = -ENOMEM;
> @@ -1056,6 +1088,7 @@ static int tegra_qspi_combined_seq_xfer(struct tegra_qspi *tqspi,
>   					struct spi_message *msg)
>   {
>   	bool is_first_msg = true;
> +	bool has_ext_dma = tqspi->soc_data->has_ext_dma;
>   	struct spi_transfer *xfer;
>   	struct spi_device *spi = msg->spi;
>   	u8 transfer_phase = 0;
> @@ -1128,15 +1161,14 @@ static int tegra_qspi_combined_seq_xfer(struct tegra_qspi *tqspi,
>   			if (WARN_ON(ret == 0)) {
>   				dev_err(tqspi->dev, "QSPI Transfer failed with timeout: %d\n",
>   					ret);
> -				if (tqspi->is_curr_dma_xfer &&
> -				    (tqspi->cur_direction & DATA_DIR_TX))
> -					dmaengine_terminate_all
> -						(tqspi->tx_dma_chan);
> -
> -				if (tqspi->is_curr_dma_xfer &&
> -				    (tqspi->cur_direction & DATA_DIR_RX))
> -					dmaengine_terminate_all
> -						(tqspi->rx_dma_chan);
> +				if (tqspi->is_curr_dma_xfer) {
> +					if ((tqspi->cur_direction & DATA_DIR_TX) &&
> +					    tqspi->tx_dma_chan)
> +						dmaengine_terminate_all(tqspi->tx_dma_chan);
> +					if ((tqspi->cur_direction & DATA_DIR_RX) &&
> +					    tqspi->rx_dma_chan)
> +						dmaengine_terminate_all(tqspi->rx_dma_chan);
> +				}
>   
>   				/* Abort transfer by resetting pio/dma bit */
>   				if (!tqspi->is_curr_dma_xfer) {
> @@ -1197,6 +1229,7 @@ static int tegra_qspi_non_combined_seq_xfer(struct tegra_qspi *tqspi,
>   	struct spi_device *spi = msg->spi;
>   	struct spi_transfer *transfer;
>   	bool is_first_msg = true;
> +	bool has_ext_dma = tqspi->soc_data->has_ext_dma;
>   	int ret = 0, val = 0;
>   
>   	msg->status = 0;
> @@ -1251,10 +1284,12 @@ static int tegra_qspi_non_combined_seq_xfer(struct tegra_qspi *tqspi,
>   						  QSPI_DMA_TIMEOUT);
>   		if (WARN_ON(ret == 0)) {
>   			dev_err(tqspi->dev, "transfer timeout\n");
> -			if (tqspi->is_curr_dma_xfer && (tqspi->cur_direction & DATA_DIR_TX))
> -				dmaengine_terminate_all(tqspi->tx_dma_chan);
> -			if (tqspi->is_curr_dma_xfer && (tqspi->cur_direction & DATA_DIR_RX))
> -				dmaengine_terminate_all(tqspi->rx_dma_chan);
> +			if (tqspi->is_curr_dma_xfer) {
> +				if ((tqspi->cur_direction & DATA_DIR_TX) && tqspi->tx_dma_chan)
> +					dmaengine_terminate_all(tqspi->tx_dma_chan);
> +				if ((tqspi->cur_direction & DATA_DIR_RX) && tqspi->rx_dma_chan)
> +					dmaengine_terminate_all(tqspi->rx_dma_chan);
> +			}
>   			tegra_qspi_handle_error(tqspi);
>   			ret = -EIO;
>   			goto complete_xfer;
> @@ -1323,7 +1358,7 @@ static bool tegra_qspi_validate_cmb_seq(struct tegra_qspi *tqspi,
>   			return false;
>   		xfer = list_next_entry(xfer, transfer_list);
>   	}
> -	if (!tqspi->soc_data->has_dma && xfer->len > (QSPI_FIFO_DEPTH << 2))
> +	if (!tqspi->soc_data->has_ext_dma && xfer->len > (QSPI_FIFO_DEPTH << 2))
>   		return false;
>   
>   	return true;
> @@ -1384,41 +1419,43 @@ static irqreturn_t handle_dma_based_xfer(struct tegra_qspi *tqspi)
>   	unsigned int total_fifo_words;
>   	unsigned long flags;
>   	long wait_status;
> -	int err = 0;
> +	int num_errors = 0;
>   
>   	if (tqspi->cur_direction & DATA_DIR_TX) {
>   		if (tqspi->tx_status) {
> -			dmaengine_terminate_all(tqspi->tx_dma_chan);
> -			err += 1;
> -		} else {
> +			if (tqspi->tx_dma_chan)
> +				dmaengine_terminate_all(tqspi->tx_dma_chan);
> +			num_errors++;
> +		} else if (tqspi->tx_dma_chan) {
>   			wait_status = wait_for_completion_interruptible_timeout(
>   				&tqspi->tx_dma_complete, QSPI_DMA_TIMEOUT);
>   			if (wait_status <= 0) {
>   				dmaengine_terminate_all(tqspi->tx_dma_chan);
>   				dev_err(tqspi->dev, "failed TX DMA transfer\n");
> -				err += 1;
> +				num_errors++;
what do you do with incrementing this local num_errors ?
I don't see any post processing .
Also all are are mutually exclusive due to if/else, not sequential. So 
could not get any specific usage.
>   			}
>   		}
>   	}
>   
>   	if (tqspi->cur_direction & DATA_DIR_RX) {
>   		if (tqspi->rx_status) {
> -			dmaengine_terminate_all(tqspi->rx_dma_chan);
> -			err += 2;
> -		} else {
> +			if (tqspi->rx_dma_chan)
> +				dmaengine_terminate_all(tqspi->rx_dma_chan);
> +			num_errors++;
> +		} else if (tqspi->rx_dma_chan) {
>   			wait_status = wait_for_completion_interruptible_timeout(
>   				&tqspi->rx_dma_complete, QSPI_DMA_TIMEOUT);
>   			if (wait_status <= 0) {
>   				dmaengine_terminate_all(tqspi->rx_dma_chan);
>   				dev_err(tqspi->dev, "failed RX DMA transfer\n");
> -				err += 2;
> +				num_errors++;
>   			}
>   		}
>   	}
>   
>   	spin_lock_irqsave(&tqspi->lock, flags);
>   
> -	if (err) {
> +	if (num_errors) {
>   		tegra_qspi_dma_unmap_xfer(tqspi, t);
>   		tegra_qspi_handle_error(tqspi);
>   		complete(&tqspi->xfer_completion);
> @@ -1444,9 +1481,9 @@ static irqreturn_t handle_dma_based_xfer(struct tegra_qspi *tqspi)
>   	/* continue transfer in current message */
>   	total_fifo_words = tegra_qspi_calculate_curr_xfer_param(tqspi, t);
>   	if (total_fifo_words > QSPI_FIFO_DEPTH)
> -		err = tegra_qspi_start_dma_based_transfer(tqspi, t);
> +		num_errors = tegra_qspi_start_dma_based_transfer(tqspi, t);
>   	else
> -		err = tegra_qspi_start_cpu_based_transfer(tqspi, t);
> +		num_errors = tegra_qspi_start_cpu_based_transfer(tqspi, t);
>   
>   exit:
>   	spin_unlock_irqrestore(&tqspi->lock, flags);
> @@ -1474,28 +1511,28 @@ static irqreturn_t tegra_qspi_isr_thread(int irq, void *context_data)
>   }
>   
>   static struct tegra_qspi_soc_data tegra210_qspi_soc_data = {
> -	.has_dma = true,
> +	.has_ext_dma = true,
>   	.cmb_xfer_capable = false,
>   	.supports_tpm = false,
>   	.cs_count = 1,
>   };
>   
>   static struct tegra_qspi_soc_data tegra186_qspi_soc_data = {
> -	.has_dma = true,
> +	.has_ext_dma = true,
>   	.cmb_xfer_capable = true,
>   	.supports_tpm = false,
>   	.cs_count = 1,
>   };
>   
>   static struct tegra_qspi_soc_data tegra234_qspi_soc_data = {
> -	.has_dma = false,
> +	.has_ext_dma = false,
>   	.cmb_xfer_capable = true,
>   	.supports_tpm = true,
>   	.cs_count = 1,
>   };
>   
>   static struct tegra_qspi_soc_data tegra241_qspi_soc_data = {
> -	.has_dma = false,
> +	.has_ext_dma = true,
>   	.cmb_xfer_capable = true,
>   	.supports_tpm = true,
>   	.cs_count = 4,


