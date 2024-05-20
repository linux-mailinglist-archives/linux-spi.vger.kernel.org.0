Return-Path: <linux-spi+bounces-2959-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 472638C9FA6
	for <lists+linux-spi@lfdr.de>; Mon, 20 May 2024 17:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3FC42832EF
	for <lists+linux-spi@lfdr.de>; Mon, 20 May 2024 15:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B31136E37;
	Mon, 20 May 2024 15:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fGFPhlgM"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0D6136E10;
	Mon, 20 May 2024 15:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716218787; cv=none; b=uCzXWOAu4di9Juwhr4i2kw8UbrChuhVBLKvku4tvmY3Z2QfRd8WVkMhgpS8ziBSwjZJ6UMj81rPZ/MICIw0XGpaOvYA6mzE4Yup5T+vvZnqnXQeFjvLTTSG9IgB+uvvzXT6IFCgYFZg9ebqBAb95SJ36J4B4FwmNxIs67MzbfbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716218787; c=relaxed/simple;
	bh=W0vT2FrrIbPGc1vwza9gzC0PgLUAF86JysbkOaE94lY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SrytlLakOBVIGIYBsktnw6KFYVYBXNx9UMRYxaarPpRQ5bILfmV2U7+j8nTaSZddM+m5IPsnosamMU6rQYcVJ6XkgQQRffy84JavNL9PSon8bgh8eC7YD9IwatUBviESZqzbE0uMdPripq+FQ7Tbkj4OnkVHGVMsh24YBNlrw1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fGFPhlgM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44KBxetH027895;
	Mon, 20 May 2024 15:26:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=1GSnmUdRyYGVKwRtFxOe1UDSnBY7e7eDTA9KqNUtPp0=; b=fG
	FPhlgMPau73LyO7j+fW76sNe4luWpc4YDoFqVQckgn+Qj61wtppvNUqoSqRZEX6m
	97n4yOQHdWsYuV3k94BC9DrIwpu9/xfwT2thqFRUjgGoIvv2NgvJPr2subK200Z/
	5SDLODnQ9xPIudxwHRH/qQwR2/8V63WAFNWcKm7yuk1MkMWWmMijqiqG9i8vXlD4
	KZLORf/YD4BR0Nskgii+f4mskRbWmFXisZLqtJZGYW9+6q/G8nbpAvNFssobet/+
	gudV/UQ9g9dBSvD+3G3KJxDCwQUpUjb5uZlZ8XfdezVxe1GfQgTZ4d+urOcgUROV
	Wc3+L/sGfmklTfQIUXnQ==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y6pqc3h9k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 May 2024 15:26:09 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44KFQ8Cd021529
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 May 2024 15:26:08 GMT
Received: from [10.216.4.5] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 20 May
 2024 08:26:02 -0700
Message-ID: <05657afe-0c09-a199-00bb-abc864d78780@quicinc.com>
Date: Mon, 20 May 2024 20:55:58 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v5 5/7] spi: spi-qpic: add driver for QCOM SPI NAND flash
 Interface
Content-Language: en-US
To: Miquel Raynal <miquel.raynal@bootlin.com>
CC: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <richard@nod.at>, <vigneshr@ti.com>,
        <manivannan.sadhasivam@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <quic_srichara@quicinc.com>, <quic_varada@quicinc.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>
References: <20240508083637.3744003-1-quic_mdalam@quicinc.com>
 <20240508083637.3744003-6-quic_mdalam@quicinc.com>
 <20240516145642.644a7f1c@xps-13>
 <434590e3-9298-dde9-f527-6596dbd1952b@quicinc.com>
 <20240520144334.79c754e3@xps-13>
From: Md Sadre Alam <quic_mdalam@quicinc.com>
In-Reply-To: <20240520144334.79c754e3@xps-13>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: oclv6RiNCPsGapctBgEFi2IJmX6v0UP1
X-Proofpoint-GUID: oclv6RiNCPsGapctBgEFi2IJmX6v0UP1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-20_05,2024-05-17_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 impostorscore=0 adultscore=0 lowpriorityscore=0
 phishscore=0 spamscore=0 suspectscore=0 mlxscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405200123



On 5/20/2024 6:13 PM, Miquel Raynal wrote:
> Hi,
> 
>>>> +static int qcom_spi_io_op(struct qcom_nand_controller *snandc, const struct spi_mem_op *op)
>>>> +{
>>>> +	int ret, val, opcode;
>>>> +	bool copy = false, copy_ftr = false;
>>>> +
>>>> +	ret = qcom_spi_send_cmdaddr(snandc, op);
>>>> +	if (ret)
>>>> +		return ret;
>>>> +
>>>> +	snandc->buf_count = 0;
>>>> +	snandc->buf_start = 0;
>>>> +	qcom_clear_read_regs(snandc);
>>>> +	qcom_clear_bam_transaction(snandc);
>>>> +	opcode = op->cmd.opcode;
>>>> +
>>>> +	switch (opcode) {
>>>> +	case SPINAND_READID:
>>>> +		snandc->buf_count = 4;
>>>> +		qcom_read_reg_dma(snandc, NAND_READ_ID, 1, NAND_BAM_NEXT_SGL);
>>>> +		copy = true;
>>>> +		break;
>>>> +	case SPINAND_GET_FEATURE:
>>>> +		snandc->buf_count = 4;
>>>> +		qcom_read_reg_dma(snandc, NAND_FLASH_FEATURES, 1, NAND_BAM_NEXT_SGL);
>>>> +		copy_ftr = true;
>>>> +		break;
>>>> +	case SPINAND_SET_FEATURE:
>>>> +		snandc->regs->flash_feature = *(u32 *)op->data.buf.out;
>>>> +		qcom_write_reg_dma(snandc, &snandc->regs->flash_feature,
>>>> +				   NAND_FLASH_FEATURES, 1, NAND_BAM_NEXT_SGL);
>>>> +		break;
>>>> +	default:
>>>> +		return 0;
>>>
>>> No error state?
>>     We can't return return error here , since this API is not for checking supported command.
> 
> I no longer remember exactly where this is called, but if there are
> possible unhandled cases, I want an error to be returned.
Ok
> 
>>     We can return error only if we submitted the descriptor. That already we are handling.
> 
> ...
> 
>>>> --- a/include/linux/mtd/nand-qpic-common.h
>>>> +++ b/include/linux/mtd/nand-qpic-common.h
>>>> @@ -315,11 +315,56 @@ struct nandc_regs {
>>>>    	__le32 read_location_last1;
>>>>    	__le32 read_location_last2;
>>>>    	__le32 read_location_last3;
>>>> +	__le32 spi_cfg;
>>>> +	__le32 num_addr_cycle;
>>>> +	__le32 busy_wait_cnt;
>>>> +	__le32 flash_feature;
>>>>    >>   	__le32 erased_cw_detect_cfg_clr;
>>>>    	__le32 erased_cw_detect_cfg_set;
>>>>    };
>>>>    >> +/*
>>>> + * ECC state struct
>>>> + * @corrected:		ECC corrected
>>>> + * @bitflips:		Max bit flip
>>>> + * @failed:		ECC failed
>>>> + */
>>>> +struct qcom_ecc_stats {
>>>> +	u32 corrected;
>>>> +	u32 bitflips;
>>>> +	u32 failed;
>>>> +};
>>>> +
>>>> +struct qpic_ecc {
>>>> +	struct device *dev;
>>>> +	const struct qpic_ecc_caps *caps;
>>>> +	struct completion done;
>>>> +	u32 sectors;
>>>> +	u8 *eccdata;
>>>> +	bool use_ecc;
>>>> +	u32 ecc_modes;
>>>> +	int ecc_bytes_hw;
>>>> +	int spare_bytes;
>>>> +	int bbm_size;
>>>> +	int ecc_mode;
>>>> +	int bytes;
>>>> +	int steps;
>>>> +	int step_size;
>>>> +	int strength;
>>>> +	int cw_size;
>>>> +	int cw_data;
>>>> +	u32 cfg0, cfg1;
>>>> +	u32 cfg0_raw, cfg1_raw;
>>>> +	u32 ecc_buf_cfg;
>>>> +	u32 ecc_bch_cfg;
>>>> +	u32 clrflashstatus;
>>>> +	u32 clrreadstatus;
>>>> +	bool bch_enabled;
>>>> +};
>>>> +
>>>> +struct qpic_ecc;
>>>> +
>>>>    /*
>>>>     * NAND controller data struct
>>>>     *
>>>> @@ -329,6 +374,7 @@ struct nandc_regs {
>>>>     *
>>>>     * @core_clk:			controller clock
>>>>     * @aon_clk:			another controller clock
>>>> + * @iomacro_clk:		io macro clock
>>>>     *
>>>>     * @regs:			a contiguous chunk of memory for DMA register
>>>>     *				writes. contains the register values to be
>>>> @@ -338,6 +384,7 @@ struct nandc_regs {
>>>>     *				initialized via DT match data
>>>>     *
>>>>     * @controller:			base controller structure
>>>> + * @ctlr:			spi controller structure
>>>>     * @host_list:			list containing all the chips attached to the
>>>>     *				controller
>>>>     *
>>>> @@ -375,6 +422,7 @@ struct qcom_nand_controller {
>>>>    >>   	struct clk *core_clk;
>>>>    	struct clk *aon_clk;
>>>> +	struct clk *iomacro_clk;
>>>>    >>   	struct nandc_regs *regs;
>>>>    	struct bam_transaction *bam_txn;
>>>> @@ -382,6 +430,7 @@ struct qcom_nand_controller {
>>>>    	const struct qcom_nandc_props *props;
>>>>    >>   	struct nand_controller controller;
>>>> +	struct spi_controller *ctlr;
>>>>    	struct list_head host_list;
>>>>    >>   	union {
>>>> @@ -418,6 +467,21 @@ struct qcom_nand_controller {
>>>>    >>   	u32 cmd1, vld;
>>>>    	bool exec_opwrite;
>>>> +	struct qpic_ecc *ecc;
>>>> +	struct qcom_ecc_stats ecc_stats;
>>>> +	struct nand_ecc_engine ecc_eng;
>>>> +	u8 *data_buf;
>>>> +	u8 *oob_buf;
>>>> +	u32 wlen;
>>>> +	u32 addr1;
>>>> +	u32 addr2;
>>>> +	u32 cmd;
>>>> +	u32 num_cw;
>>>> +	u32 pagesize;
>>>> +	bool oob_rw;
>>>> +	bool page_rw;
>>>> +	bool raw_rw;
>>>> +	bool read_last_cw;
>>>>    };
>>>
>>> If all these definitions are only used by the spi controller, I don't
>>> see why you want to put them in the common file.
>>    We are using qcom_nand_controller{..} structure as common b/w raw nand
>>    and spi nand. These all variables will be used by spi nand only , but
>>    qcom_nand_controller structure is passed across all the SPI API, thats
>>    why define these all variables inside qcom_nand_controller structure.
>>    so that i can access directlty.
> 
> Maybe you can move the spi-nand specific variables in a struct, and the
> raw NAND specific variables in another, and then use an enum in this
> structure. This way only the useful fields are available. Or maybe you
> can have two pointers and only populate the relevant one from the
> relevant driver with the fields that are missing. But this is a generic
> include, so don't put specific fields there just because it is
> convenient.
Ok , will do in next patch.
> 
> Thanks,
> Miquèl

