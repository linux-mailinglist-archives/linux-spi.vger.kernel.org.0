Return-Path: <linux-spi+bounces-5686-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 443D59C5772
	for <lists+linux-spi@lfdr.de>; Tue, 12 Nov 2024 13:15:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03E7F284AE6
	for <lists+linux-spi@lfdr.de>; Tue, 12 Nov 2024 12:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5721CD212;
	Tue, 12 Nov 2024 12:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="F0oOMgpt"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0CE23099A;
	Tue, 12 Nov 2024 12:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731413745; cv=none; b=A2RM7LGmofmhzpStBuvtGUtYQMZ/oCfY/6Yu+cSAe8nMusYupUaTDdfockKOhKwJmF2IKZa0SlnN2pqPuCy6fcTdmy2/lTjZGD00wCWJSzMwJ9pt9vr5JswDQcNYL7MquBlSi3hM6NQ5+LaGGAZCRntnBLl6QMwM6cmKcfDpHfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731413745; c=relaxed/simple;
	bh=y8wYpJKQPppWOwG+stODco0nODyFQc2893XETWW0e0o=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dHve5DzuTPi4n63aYnFkHMZg+Cd0gLHHMn31eG/XL1EnVRIcmrXOEYhju7t98grbgLFR/T93GEML4IghSASqRovTsNYAL5uVexeE1imhdQzc/H1nzQNgzF3M/mE6PD3OF2ipP18QvC0Gh8n3Tyfq+onzo8MsoBpefhkEe390JxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=F0oOMgpt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AC6Ac7t004261;
	Tue, 12 Nov 2024 12:15:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/1upKaL3B/gyY1s3YNSg8f5Kv6R8Vl0kZB3qVnOQmTQ=; b=F0oOMgptnI79JcQp
	qwLKaddGlBRY5kwvo6B1vSzHOUTs1lj9Sd62IPPf3xeyOrKK2z1ztQ0n/VizgIC5
	p1olyqTTII1wXd29n64Poqyx2aneResAgsSdUGJgemKZsn8y68aUzc6z3wdCAWfb
	DI55cm8tA7yd+JKp3kxLdeEkRMlk93FgimsyO65VL8UodQXrs+aaaoB6bNsrk1KJ
	eRHewjlqAs6oKZt/br7qT960gCBnZNXTw/Aw8oqo2vUZsvRNifszy5hHbtFn0+Gm
	dw01A+jbB2qf85T+IjpKgBUI2Wh8XoIoyL/CETFCjCW0nPFCqqxYpk9M+ybdpFZW
	Zaci3A==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42v1h6gvgr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Nov 2024 12:15:26 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4ACCFPoK002281
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Nov 2024 12:15:25 GMT
Received: from [10.152.197.144] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 12 Nov
 2024 04:15:19 -0800
Message-ID: <374ea155-0970-38bd-470f-cc440ca0bab5@quicinc.com>
Date: Tue, 12 Nov 2024 17:45:07 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v13 2/8] mtd: rawnand: qcom: cleanup qcom_nandc driver
Content-Language: en-US
To: Miquel Raynal <miquel.raynal@bootlin.com>
CC: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <andersson@kernel.org>,
        <konradybcio@kernel.org>, <richard@nod.at>, <vigneshr@ti.com>,
        <manivannan.sadhasivam@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <quic_srichara@quicinc.com>, <quic_varada@quicinc.com>
References: <20241030121919.865716-1-quic_mdalam@quicinc.com>
 <20241030121919.865716-3-quic_mdalam@quicinc.com>
 <871pzh397j.fsf@bootlin.com>
From: Md Sadre Alam <quic_mdalam@quicinc.com>
In-Reply-To: <871pzh397j.fsf@bootlin.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: FFG0lJqQ5KR-9Tjw0S2SFNIdQrY4v1A7
X-Proofpoint-GUID: FFG0lJqQ5KR-9Tjw0S2SFNIdQrY4v1A7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 phishscore=0 adultscore=0 priorityscore=1501 mlxscore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 spamscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411120099



On 11/12/2024 12:00 AM, Miquel Raynal wrote:
> On 30/10/2024 at 17:49:13 +0530, Md Sadre Alam <quic_mdalam@quicinc.com> wrote:
> 
>> cleanup qcom_nandc driver as below
> 
> Perform a global cleanup of the Qualcomm NAND controller driver with the
> following improvements:
Ok
>>
>> - Remove register value indirection api
> 
> API
Ok
> 
>>
>> - Remove set_reg() api
> 
> API
Ok
> 
>>
>> - Convert read_loc_first & read_loc_last macro to function
> 
> functions
Ok
> 
>>
>> - Renamed multiple variables
> 
> Rename
Ok
> 
> ...
> 
>> @@ -549,17 +535,17 @@ struct qcom_nand_host {
>>    * among different NAND controllers.
>>    * @ecc_modes - ecc mode for NAND
>>    * @dev_cmd_reg_start - NAND_DEV_CMD_* registers starting offset
>> - * @is_bam - whether NAND controller is using BAM
>> - * @is_qpic - whether NAND CTRL is part of qpic IP
>> - * @qpic_v2 - flag to indicate QPIC IP version 2
>> + * @supports_bam - whether NAND controller is using BAM
> 
> Use the plain letters BAM acronym at least here
Ok
> 
>> + * @nandc_part_of_qpic - whether NAND controller is part of qpic IP
>> + * @qpic_version2 - flag to indicate QPIC IP version 2
>>    * @use_codeword_fixup - whether NAND has different layout for boot partitions
>>    */
>>   struct qcom_nandc_props {
>>   	u32 ecc_modes;
>>   	u32 dev_cmd_reg_start;
>> -	bool is_bam;
>> -	bool is_qpic;
>> -	bool qpic_v2;
>> +	bool supports_bam;
>> +	bool nandc_part_of_qpic;
>> +	bool qpic_version2;
>>   	bool use_codeword_fixup;
>>   };
>>   
>> @@ -613,19 +599,11 @@ static void clear_bam_transaction(struct qcom_nand_controller *nandc)
>>   {
>>   	struct bam_transaction *bam_txn = nandc->bam_txn;
>>   
>> -	if (!nandc->props->is_bam)
>> +	if (!nandc->props->supports_bam)
>>   		return;
>>   
>> -	bam_txn->bam_ce_pos = 0;
>> -	bam_txn->bam_ce_start = 0;
>> -	bam_txn->cmd_sgl_pos = 0;
>> -	bam_txn->cmd_sgl_start = 0;
>> -	bam_txn->tx_sgl_pos = 0;
>> -	bam_txn->tx_sgl_start = 0;
>> -	bam_txn->rx_sgl_pos = 0;
>> -	bam_txn->rx_sgl_start = 0;
>> +	memset(&bam_txn->bam_ce_pos, 0, sizeof(u32) * 8);
>>   	bam_txn->last_data_desc = NULL;
>> -	bam_txn->wait_second_completion = false;
>>   
>>   	sg_init_table(bam_txn->cmd_sgl, nandc->max_cwperpage *
>>   		      QPIC_PER_CW_CMD_SGL);
>> @@ -640,17 +618,7 @@ static void qpic_bam_dma_done(void *data)
>>   {
>>   	struct bam_transaction *bam_txn = data;
>>   
>> -	/*
>> -	 * In case of data transfer with NAND, 2 callbacks will be generated.
>> -	 * One for command channel and another one for data channel.
>> -	 * If current transaction has data descriptors
>> -	 * (i.e. wait_second_completion is true), then set this to false
>> -	 * and wait for second DMA descriptor completion.
>> -	 */
>> -	if (bam_txn->wait_second_completion)
>> -		bam_txn->wait_second_completion = false;
>> -	else
>> -		complete(&bam_txn->txn_done);
>> +	complete(&bam_txn->txn_done);
>>   }
>>   
>>   static inline struct qcom_nand_host *to_qcom_nand_host(struct nand_chip *chip)
>> @@ -676,10 +644,9 @@ static inline void nandc_write(struct qcom_nand_controller *nandc, int offset,
>>   	iowrite32(val, nandc->base + offset);
>>   }
>>   
>> -static inline void nandc_read_buffer_sync(struct qcom_nand_controller *nandc,
>> -					  bool is_cpu)
>> +static inline void nandc_dev_to_mem(struct qcom_nand_controller *nandc, bool is_cpu)
> 
> No static inline in C code, you can also remove it.
Ok
> 
>>   {
>> -	if (!nandc->props->is_bam)
>> +	if (!nandc->props->supports_bam)
>>   		return;
>>   
>>   	if (is_cpu)
>> @@ -694,93 +661,90 @@ static inline void nandc_read_buffer_sync(struct qcom_nand_controller *nandc,
>>   					   DMA_FROM_DEVICE);
>>   }
> 
> ...
> 
>> +/* Helper to check the code word, whether it is last cw or not */
> 
> Helper to check whether this is the last CW or not
Ok
> 
> 
>> +static bool qcom_nandc_is_last_cw(struct nand_ecc_ctrl *ecc, int cw)
>> +{
>> +	return cw == (ecc->steps - 1);
>>   }
>>   
>> -static void nandc_set_reg(struct nand_chip *chip, int offset,
>> -			  u32 val)
>> +/**
>> + * nandc_set_read_loc_first() - to set read location first register
>> + * @chip:		NAND Private Flash Chip Data
>> + * @reg_base:		location register base
>> + * @cw_offset:		code word offset
>> + * @read_size:		code word read length
>> + * @is_last_read_loc:	is this the last read location
>> + *
>> + * This function will set location register value
>> + */
> 
> ...
> 
>>   	if (host->use_ecc) {
>> -		cfg0 = (host->cfg0 & ~(7U << CW_PER_PAGE)) |
>> -				(num_cw - 1) << CW_PER_PAGE;
>> +		cfg0 = cpu_to_le32((host->cfg0 & ~(7U << CW_PER_PAGE)) |
>> +				(num_cw - 1) << CW_PER_PAGE);
>>   
>> -		cfg1 = host->cfg1;
>> -		ecc_bch_cfg = host->ecc_bch_cfg;
>> +		cfg1 = cpu_to_le32(host->cfg1);
>> +		ecc_bch_cfg = cpu_to_le32(host->ecc_bch_cfg);
>>   	} else {
>> -		cfg0 = (host->cfg0_raw & ~(7U << CW_PER_PAGE)) |
>> -				(num_cw - 1) << CW_PER_PAGE;
>> +		cfg0 = cpu_to_le32((host->cfg0_raw & ~(7U << CW_PER_PAGE)) |
>> +				(num_cw - 1) << CW_PER_PAGE);
>>   
>> -		cfg1 = host->cfg1_raw;
>> -		ecc_bch_cfg = 1 << ECC_CFG_ECC_DISABLE;
>> +		cfg1 = cpu_to_le32(host->cfg1_raw);
>> +		ecc_bch_cfg = cpu_to_le32(1 << ECC_CFG_ECC_DISABLE);
>>   	}
>>   
>> -	nandc_set_reg(chip, NAND_FLASH_CMD, cmd);
>> -	nandc_set_reg(chip, NAND_DEV0_CFG0, cfg0);
>> -	nandc_set_reg(chip, NAND_DEV0_CFG1, cfg1);
>> -	nandc_set_reg(chip, NAND_DEV0_ECC_CFG, ecc_bch_cfg);
>> -	if (!nandc->props->qpic_v2)
>> -		nandc_set_reg(chip, NAND_EBI2_ECC_BUF_CFG, host->ecc_buf_cfg);
>> -	nandc_set_reg(chip, NAND_FLASH_STATUS, host->clrflashstatus);
>> -	nandc_set_reg(chip, NAND_READ_STATUS, host->clrreadstatus);
>> -	nandc_set_reg(chip, NAND_EXEC_CMD, 1);
>> +	nandc->regs->cmd = cmd;
>> +	nandc->regs->cfg0 = cfg0;
>> +	nandc->regs->cfg1 = cfg1;
>> +	nandc->regs->ecc_bch_cfg = ecc_bch_cfg;
>> +
>> +	if (!nandc->props->qpic_version2)
>> +		nandc->regs->ecc_buf_cfg = cpu_to_le32(host->ecc_buf_cfg);
>> +
>> +	nandc->regs->clrflashstatus = cpu_to_le32(host->clrflashstatus);
>> +	nandc->regs->clrreadstatus = cpu_to_le32(host->clrreadstatus);
>> +	nandc->regs->exec = cpu_to_le32(1);
>>   
>>   	if (read)
>>   		nandc_set_read_loc(chip, cw, 0, 0, host->use_ecc ?
>> @@ -1121,7 +1088,7 @@ static int read_reg_dma(struct qcom_nand_controller *nandc, int first,
>>   	if (first == NAND_DEV_CMD_VLD || first == NAND_DEV_CMD1)
>>   		first = dev_cmd_reg_addr(nandc, first);
>>   
>> -	if (nandc->props->is_bam)
>> +	if (nandc->props->supports_bam)
>>   		return prep_bam_dma_desc_cmd(nandc, true, first, vaddr,
>>   					     num_regs, flags);
>>   
>> @@ -1136,25 +1103,16 @@ static int read_reg_dma(struct qcom_nand_controller *nandc, int first,
>>    * write_reg_dma:	prepares a descriptor to write a given number of
>>    *			contiguous registers
>>    *
>> + * @vaddr:		contnigeous memory from where register value
>> will
> 
> Please run a spell checker on your commits.
Ok
> 
>> + *			be written
>>    * @first:		offset of the first register in the contiguous block
>>    * @num_regs:		number of registers to write
>>    * @flags:		flags to control DMA descriptor preparation
>>    */
>> -static int write_reg_dma(struct qcom_nand_controller *nandc, int first,
>> -			 int num_regs, unsigned int flags)
>> +static int write_reg_dma(struct qcom_nand_controller *nandc, __le32 *vaddr,
>> +			 int first, int num_regs, unsigned int flags)
>>   {
>>   	bool flow_control = false;
>> -	struct nandc_regs *regs = nandc->regs;
>> -	void *vaddr;
>> -
>> -	vaddr = offset_to_nandc_reg(regs, first);
>> -
>> -	if (first == NAND_ERASED_CW_DETECT_CFG) {
>> -		if (flags & NAND_ERASED_CW_SET)
>> -			vaddr = &regs->erased_cw_detect_cfg_set;
>> -		else
>> -			vaddr = &regs->erased_cw_detect_cfg_clr;
>> -	}
>>   
>>   	if (first == NAND_EXEC_CMD)
>>   		flags |= NAND_BAM_NWD;
>> @@ -1165,7 +1123,7 @@ static int write_reg_dma(struct qcom_nand_controller *nandc, int first,
>>   	if (first == NAND_DEV_CMD_VLD_RESTORE || first == NAND_DEV_CMD_VLD)
>>   		first = dev_cmd_reg_addr(nandc, NAND_DEV_CMD_VLD);
>>   
>> -	if (nandc->props->is_bam)
>> +	if (nandc->props->supports_bam)
>>   		return prep_bam_dma_desc_cmd(nandc, false, first, vaddr,
>>   					     num_regs, flags);
>>   
> 
> ...
> 
>> @@ -2872,38 +2823,38 @@ static int qcom_param_page_type_exec(struct nand_chip *chip,  const struct nand_
>>   	clear_read_regs(nandc);
>>   	clear_bam_transaction(nandc);
>>   
>> -	nandc_set_reg(chip, NAND_FLASH_CMD, q_op.cmd_reg);
>> -
>> -	nandc_set_reg(chip, NAND_ADDR0, 0);
>> -	nandc_set_reg(chip, NAND_ADDR1, 0);
>> -	nandc_set_reg(chip, NAND_DEV0_CFG0, 0 << CW_PER_PAGE
>> -					| 512 << UD_SIZE_BYTES
>> -					| 5 << NUM_ADDR_CYCLES
>> -					| 0 << SPARE_SIZE_BYTES);
>> -	nandc_set_reg(chip, NAND_DEV0_CFG1, 7 << NAND_RECOVERY_CYCLES
>> -					| 0 << CS_ACTIVE_BSY
>> -					| 17 << BAD_BLOCK_BYTE_NUM
>> -					| 1 << BAD_BLOCK_IN_SPARE_AREA
>> -					| 2 << WR_RD_BSY_GAP
>> -					| 0 << WIDE_FLASH
>> -					| 1 << DEV0_CFG1_ECC_DISABLE);
> 
> Please fix the coding style. The '|' should be at the end of the line.
Ok
Thanks for the review. Will fix all the comments in next revision.
> 
> Thanks,
> Miquèl

