Return-Path: <linux-spi+bounces-9563-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA9BB2DD09
	for <lists+linux-spi@lfdr.de>; Wed, 20 Aug 2025 14:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 125813A138C
	for <lists+linux-spi@lfdr.de>; Wed, 20 Aug 2025 12:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C342E11B6;
	Wed, 20 Aug 2025 12:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hSr4ipYB"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59EF4220687;
	Wed, 20 Aug 2025 12:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755694156; cv=none; b=OIaDzizZEDEchksPr2yO9W3QRaiYxJ9+bdx4YoUxWDTxpvMZUk68JvKH/UYh4gWwWrlLT2WxtxauBJwPjLhz0iN6T+fJAY3C1f7cuZw/z0If7KdS2Qk2vYM6lEmfvFe9djv13Dp64OyHXqw3D/re9btyDRDEXxZTHV+XgTpMpqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755694156; c=relaxed/simple;
	bh=sOM9v4yroQZjRUu/zyDTVaBmMAil48NlMYd6XOWD7Hs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=g+2eIqKLJb0+o1aDlmxm28KOX8v2YQwX3Vi4ocFvD5/UENG/m+uSmv0GkdtNgSTiE6Tav+Fgqk1c+a1Cm38Wc9Nv6TqOc0SAB+OF2Z9fMG7TMz64eZvHVYPmHq838Xx0qpDTd94WMlnPfSz3BDAfY48yjjsXR4gWrpA//URlUDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hSr4ipYB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57KA26sE022612;
	Wed, 20 Aug 2025 12:49:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gvg5eiBFdfh332hZ+qy5KKmK4l7YaZYxVdrp/7ocSow=; b=hSr4ipYBMgnZmj/W
	l1gEkZPU5Y0KqZIOHHkJthDnG4vwRYv839KQgcGjyqgPE+g0vl6kdoDzsgojqPUN
	G0ZX4fkl96nItgZbI/BicPAZqLwfb3XXJ8/iWao1l27sVUsS4mLbY6QUlSOr19aD
	d2g+C0jw9ZnqzIfWNX7NwGui/eZLSD8CtJRBURn/0LBiGDiRtuLS4rhlMTgUvO38
	ToMuAY2fbJsxn+Ews500qUy2Nb3wuXwhPaXIxoA+tHewv9L7QsDcBYZmO4qED1S4
	gfQHeHFYQvsrkUy7Gl4Fu0EhgQfAyuYf4FmwpHTOzJfxBzvWMvGBNTCToMNnsUhQ
	FOV00g==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n5291qve-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Aug 2025 12:49:00 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 57KCmxvs031813
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Aug 2025 12:48:59 GMT
Received: from [10.216.4.222] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 20 Aug
 2025 05:48:56 -0700
Message-ID: <06bcf2f6-4a3e-4f87-93e4-29e17ae89e62@quicinc.com>
Date: Wed, 20 Aug 2025 18:18:52 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/14] spi: airoha: add support of dual/quad wires spi
 modes
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
        Lorenzo Bianconi
	<lorenzo@kernel.org>, Ray Liu <ray.liu@airoha.com>,
        Mark Brown
	<broonie@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Frieder Schrempf
	<frieder.schrempf@kontron.de>
References: <20250820123317.728148-1-mikhail.kshevetskiy@iopsys.eu>
 <20250820123317.728148-4-mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US
From: Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>
In-Reply-To: <20250820123317.728148-4-mikhail.kshevetskiy@iopsys.eu>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 9QcnaJaeDKhjHyzh_KN94-ECNUxjtNW2
X-Proofpoint-ORIG-GUID: 9QcnaJaeDKhjHyzh_KN94-ECNUxjtNW2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfX8cKxNs1iNO0G
 jsrauxzUqZOcf4/lNd2HegxdLa9+uPzq3AAIy0vFFxXvnzZPV7boLEdsncAvaa/aek33ywG0djs
 dy0dEk5mLNtBxLmAr7ISgwYtsTbkW7UDWd5+f0iBulm/lefJ0U4FgnxIwUHDgkOVR73NFVaoqrN
 gu/YJqwRQTF2xwwjBBJkLE5kEuAkhjj91olVhEtlyFN5OnwwGVQXp0FfJaL6DAKlOir3FumhbvT
 5+5iCxNswGLRe9dzINPrjfE2skGS79uBRKdoAXN5OFdAgKlxONP6OlNHkyNh0qwWCMgUxeHcnoO
 pOpG1okTdd1aDCi1/Bo0iF89Wndw/LWboZhjM/YHH+KVo8PYgCiCXC/lUyc0IWE7B6dKlD9jqTv
 XkVaQCbZpq/ayXkGtm7OBoAzGip1/g==
X-Authority-Analysis: v=2.4 cv=SPkblOvH c=1 sm=1 tr=0 ts=68a5c43c cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=Xrz4UN6QAAAA:8
 a=-btNFGgskHoW0r722lAA:9 a=QEXdDO2ut3YA:10 a=ttJoe86O9ml44D0ClCJH:22
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_04,2025-08-20_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 bulkscore=0 spamscore=0 phishscore=0
 impostorscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013



On 8/20/2025 6:03 PM, Mikhail Kshevetskiy wrote:
> This patch adds support of dual and quad wires spi modes. It will
> speed up flash operations on the hardware with corresponding hardware
> support.
> 
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> ---
>   drivers/spi/spi-airoha-snfi.c | 107 +++++++++++++++++++++++++---------
>   1 file changed, 80 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
> index bcc464ec9c61..7aab3506834a 100644
> --- a/drivers/spi/spi-airoha-snfi.c
> +++ b/drivers/spi/spi-airoha-snfi.c
> @@ -192,6 +192,14 @@
>   #define SPI_NAND_OP_RESET			0xff
>   #define SPI_NAND_OP_DIE_SELECT			0xc2
>   
> +/* SNAND FIFO commands */
> +#define SNAND_FIFO_TX_BUSWIDTH_SINGLE		0x08
> +#define SNAND_FIFO_TX_BUSWIDTH_DUAL		0x09
> +#define SNAND_FIFO_TX_BUSWIDTH_QUAD		0x0a
> +#define SNAND_FIFO_RX_BUSWIDTH_SINGLE		0x0c
> +#define SNAND_FIFO_RX_BUSWIDTH_DUAL		0x0e
> +#define SNAND_FIFO_RX_BUSWIDTH_QUAD		0x0f
> +
>   #define SPI_NAND_CACHE_SIZE			(SZ_4K + SZ_256)
>   #define SPI_MAX_TRANSFER_SIZE			511
>   
> @@ -387,10 +395,25 @@ static int airoha_snand_set_mode(struct airoha_snand_ctrl *as_ctrl,
>   	return regmap_write(as_ctrl->regmap_ctrl, REG_SPI_CTRL_DUMMY, 0);
>   }
>   
> -static int airoha_snand_write_data(struct airoha_snand_ctrl *as_ctrl, u8 cmd,
> -				   const u8 *data, int len)
> +static int airoha_snand_write_data(struct airoha_snand_ctrl *as_ctrl,
> +				   const u8 *data, int len, int buswidth)
>   {
>   	int i, data_len;
> +	u8 cmd;
> +
> +	switch (buswidth) {
> +	case 1:
> +		cmd = SNAND_FIFO_TX_BUSWIDTH_SINGLE;
> +		break;
> +	case 2:
> +		cmd = SNAND_FIFO_TX_BUSWIDTH_DUAL;
> +		break;
> +	case 4:
> +		cmd = SNAND_FIFO_TX_BUSWIDTH_QUAD;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
>   
>   	for (i = 0; i < len; i += data_len) {
>   		int err;
> @@ -409,16 +432,31 @@ static int airoha_snand_write_data(struct airoha_snand_ctrl *as_ctrl, u8 cmd,
>   	return 0;
>   }
>   
> -static int airoha_snand_read_data(struct airoha_snand_ctrl *as_ctrl, u8 *data,
> -				  int len)
> +static int airoha_snand_read_data(struct airoha_snand_ctrl *as_ctrl,
> +				  u8 *data, int len, int buswidth)
>   {
>   	int i, data_len;
> +	u8 cmd;
> +
> +	switch (buswidth) {
> +	case 1:
> +		cmd = SNAND_FIFO_RX_BUSWIDTH_SINGLE;
> +		break;
> +	case 2:
> +		cmd = SNAND_FIFO_RX_BUSWIDTH_DUAL;
> +		break;
> +	case 4:
> +		cmd = SNAND_FIFO_RX_BUSWIDTH_QUAD;
> +		break;
> +	default:
> +		return -EINVAL;
For unknown buswidth cases, not falling back to single lane?
What if the bus width is 0 ? (for SPI, typically default 
SPI_NBITS_SINGLE is used for buswidth 0).> +	}
>   
>   	for (i = 0; i < len; i += data_len) {
>   		int err;
>   
>   		data_len = min(len - i, SPI_MAX_TRANSFER_SIZE);
> -		err = airoha_snand_set_fifo_op(as_ctrl, 0xc, data_len);
> +		err = airoha_snand_set_fifo_op(as_ctrl, cmd, data_len);
>   		if (err)
>   			return err;
>   
> @@ -895,12 +933,27 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
>   static int airoha_snand_exec_op(struct spi_mem *mem,
>   				const struct spi_mem_op *op)
>   {
> -	u8 data[8], cmd, opcode = op->cmd.opcode;
>   	struct airoha_snand_ctrl *as_ctrl;
> -	int i, err;
> +	char buf[20], *data;
> +	int i, err, op_len, addr_len, dummy_len;
>   
>   	as_ctrl = spi_controller_get_devdata(mem->spi->controller);
>   
> +	op_len = op->cmd.nbytes;
> +	addr_len = op->addr.nbytes;
> +	dummy_len = op->dummy.nbytes;
> +
> +	if (op_len + dummy_len + addr_len > sizeof(buf))
> +		return -EIO;
> +
> +	data = buf;
> +	for (i = 0; i < op_len; i++)
> +		*data++ = op->cmd.opcode >> (8 * (op_len - i - 1));
> +	for (i = 0; i < addr_len; i++)
> +		*data++ = op->addr.val >> (8 * (addr_len - i - 1));
> +	for (i = 0; i < dummy_len; i++)
> +		*data++ = 0xff;
> +
>   	/* switch to manual mode */
>   	err = airoha_snand_set_mode(as_ctrl, SPI_MODE_MANUAL);
>   	if (err < 0)
> @@ -911,40 +964,40 @@ static int airoha_snand_exec_op(struct spi_mem *mem,
>   		return err;
>   
>   	/* opcode */
> -	err = airoha_snand_write_data(as_ctrl, 0x8, &opcode, sizeof(opcode));
> +	data = buf;
> +	err = airoha_snand_write_data(as_ctrl, data, op_len,
> +				      op->cmd.buswidth);
>   	if (err)
>   		return err;
>   
>   	/* addr part */
> -	cmd = opcode == SPI_NAND_OP_GET_FEATURE ? 0x11 : 0x8;
> -	put_unaligned_be64(op->addr.val, data);
> -
> -	for (i = ARRAY_SIZE(data) - op->addr.nbytes;
> -	     i < ARRAY_SIZE(data); i++) {
> -		err = airoha_snand_write_data(as_ctrl, cmd, &data[i],
> -					      sizeof(data[0]));
> +	data += op_len;
> +	if (addr_len) {
> +		err = airoha_snand_write_data(as_ctrl, data, addr_len,
> +					      op->addr.buswidth);
>   		if (err)
>   			return err;
>   	}
>   
>   	/* dummy */
> -	data[0] = 0xff;
> -	for (i = 0; i < op->dummy.nbytes; i++) {
> -		err = airoha_snand_write_data(as_ctrl, 0x8, &data[0],
> -					      sizeof(data[0]));
> +	data += addr_len;
> +	if (dummy_len) {
> +		err = airoha_snand_write_data(as_ctrl, data, dummy_len,
> +					      op->dummy.buswidth);
>   		if (err)
>   			return err;
>   	}
>   
>   	/* data */
> -	if (op->data.dir == SPI_MEM_DATA_IN) {
> -		err = airoha_snand_read_data(as_ctrl, op->data.buf.in,
> -					     op->data.nbytes);
> -		if (err)
> -			return err;
> -	} else {
> -		err = airoha_snand_write_data(as_ctrl, 0x8, op->data.buf.out,
> -					      op->data.nbytes);
> +	if (op->data.nbytes) {
> +		if (op->data.dir == SPI_MEM_DATA_IN)
> +			err = airoha_snand_read_data(as_ctrl, op->data.buf.in,
> +						     op->data.nbytes,
> +						     op->data.buswidth);
> +		else
> +			err = airoha_snand_write_data(as_ctrl, op->data.buf.out,
> +						      op->data.nbytes,
> +						      op->data.buswidth);
>   		if (err)
>   			return err;
>   	}


