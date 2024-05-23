Return-Path: <linux-spi+bounces-3034-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B928CCB35
	for <lists+linux-spi@lfdr.de>; Thu, 23 May 2024 05:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B9CC28312A
	for <lists+linux-spi@lfdr.de>; Thu, 23 May 2024 03:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A5D33985;
	Thu, 23 May 2024 03:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WoglU0F2"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B8920319;
	Thu, 23 May 2024 03:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716435299; cv=none; b=e43FM55R++zlKnuAphzI+REh2i+LV6C6QRnp2Zc8EPrp/22xbDvrh41pNJfzqE/sN1kfRFvJ5EVXDQUNqrDjciMTS2JR7mU1HnAYqyJcFkFMR6S85iQyM/coOSm6TT/s0KDw02l2r9QfA2U0E1C8CRo5Mp+GEPix5Kyy9kYXD8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716435299; c=relaxed/simple;
	bh=o10imn5J0AI2O2FGptsG7XtejKtBda9RPe1N1FflebA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=czwZ9ZGY4zMRKGzMcST6pSLDaGC9DsdRf7tkxRqHbxzUxihWe7IqJLKIN1hkRmB3J2RnCapaFanuaHdUkB6Sj+4JoIH6mVudJZxY4H/Hf/i2Y7NHdGJO0pMjrU/ZTOR44adzbwpFK1xKCQeFVdnGnIra0V5FR0gh8RvWar2x89M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WoglU0F2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44MLkf46002549;
	Thu, 23 May 2024 03:34:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=7MeQ8tDFi4p6ig6ite5CM/mtmGZW9qTTX3crnlZFHT0=; b=Wo
	glU0F2QPnXttl748KKTmNNkzgvCIbtqR+2PUebRGdrbE/2GKYZy2ayMFi9+LCNsK
	o9sMsMvzp2hu0r9pZiqmOpNwhDibY8c/D3M492J87V77CqRmlS7W/anWU13IkmHi
	TUe4jZTszt8zOXPtE72bMznrjPTPs2K54rRbrsxPTSc7CDcuscVl1qTitjnnWwAk
	Q4kjyiGMUCDt4qpAVAi0dOc1Wlon7OywRvVQ6Yz5f/hpgbbd38h4hBFLdQ5F1VvL
	G48sLTqi1Ke+jaSo8EBFW0DOydPO46gK2qzjThaCM7jorsbAKc5XdSXiAGirF+G0
	0uA4TMuhGTkifs9lN+lA==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y6n4gjmpd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 May 2024 03:34:41 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44N3YdCh024879
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 May 2024 03:34:39 GMT
Received: from [10.216.36.209] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 22 May
 2024 20:34:33 -0700
Message-ID: <6fe417c8-8eb8-2489-5295-c94dd5cc08bd@quicinc.com>
Date: Thu, 23 May 2024 09:04:22 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v6 6/8] spi: spi-qpic: add driver for QCOM SPI NAND flash
 Interface
To: Miquel Raynal <miquel.raynal@bootlin.com>
CC: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <richard@nod.at>, <vigneshr@ti.com>,
        <manivannan.sadhasivam@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <quic_srichara@quicinc.com>, <quic_varada@quicinc.com>
References: <20240521105532.1537845-1-quic_mdalam@quicinc.com>
 <20240521105532.1537845-7-quic_mdalam@quicinc.com>
 <20240521152410.7cff71ab@xps-13>
 <5b96e24a-edcd-df85-9e70-332a6059ee73@quicinc.com>
 <20240522143317.07f78601@xps-13>
Content-Language: en-US
From: Md Sadre Alam <quic_mdalam@quicinc.com>
In-Reply-To: <20240522143317.07f78601@xps-13>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: bLwe8LSLbrzdS-DgTxjFvWXzELXu1Vt1
X-Proofpoint-ORIG-GUID: bLwe8LSLbrzdS-DgTxjFvWXzELXu1Vt1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-23_01,2024-05-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 bulkscore=0 phishscore=0
 mlxscore=0 malwarescore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405230023



On 5/22/2024 6:03 PM, Miquel Raynal wrote:
> Hi,
> 
>>>> +static int qcom_spi_ooblayout_ecc(struct mtd_info *mtd, int section,
>>>> +				  struct mtd_oob_region *oobregion)
>>>> +{
>>>> +	struct nand_device *nand = mtd_to_nanddev(mtd);
>>>> +	struct qcom_nand_controller *snandc = nand_to_qcom_snand(nand);
>>>> +	struct qpic_ecc *qecc = snandc->qspi->ecc;
>>>> +
>>>> +	if (section > 1)
>>>> +		return -ERANGE;
>>>> +
>>>> +	if (!section) {
>>>> +		oobregion->length = (qecc->bytes * (qecc->steps - 1)) + qecc->bbm_size;
>>>> +		oobregion->offset = 0;
>>>
>>> No, offset 0 is for the BBM. This is wrong.
>>> The whole oob layout looks really really wrong.
>>>
>>> ECC bytes are where the ECC engine puts its bytes in the OOB area.
>>> Free bytes start after the BBM and fill the gaps until the end of the
>>> area, except where there are ECC bytes.
>>    QPIC NAND controller having its own page layout with ecc and without ecc.
>>    The same layout we are using in raw nand driver as well, so i used the
>>    same here. The below info is already there in qcom raw nand driver file
>>    in page layout info.
>>
>>    QPIC NAND controller layout as below:
>>
>>     Layout with ECC enabled:
>>
>>       |----------------------|  |---------------------------------|
>>       |           xx.......yy|  |             *********xx.......yy|
>>       |    DATA   xx..ECC..yy|  |    DATA     **SPARE**xx..ECC..yy|
>>       |   (516)   xx.......yy|  |  (516-n*4)  **(n*4)**xx.......yy|
>>       |           xx.......yy|  |             *********xx.......yy|
>>       |----------------------|  |---------------------------------|
>>        codeword 1,2..n-1                  codeword n
>>       <---(528/532 Bytes)-->    <-------(528/532 Bytes)--------->
>>
>>       n = Number of codewords in the page
>>       . = ECC bytes
>>       * = Spare/free bytes
>>       x = Unused byte(s)
>>       y = Reserved byte(s)
>>
>>       2K page: n = 4, spare = 16 bytes
>>       4K page: n = 8, spare = 32 bytes
>>       8K page: n = 16, spare = 64 bytes
>>
>>       the qcom nand controller operates at a sub page/codeword level. each
>>       codeword is 528 and 532 bytes for 4 bit and 8 bit ECC modes respectively.
>>       the number of ECC bytes vary based on the ECC strength and the bus width.
>>
>>       the first n - 1 codewords contains 516 bytes of user data, the remaining
>>       12/16 bytes consist of ECC and reserved data. The nth codeword contains
>>       both user data and spare(oobavail) bytes that sum up to 516 bytes.
>>
>>       When we access a page with ECC enabled, the reserved bytes(s) are not
>>       accessible at all. When reading, we fill up these unreadable positions
>>       with 0xffs. When writing, the controller skips writing the inaccessible
>>       bytes.
>>
>>       Layout with ECC disabled:
>>
>>       |------------------------------|  |---------------------------------------|
>>       |         yy          xx.......|  |         bb          *********xx.......|
>>       |  DATA1  yy  DATA2   xx..ECC..|  |  DATA1  bb  DATA2   **SPARE**xx..ECC..|
>>       | (size1) yy (size2)  xx.......|  | (size1) bb (size2)  **(n*4)**xx.......|
>>       |         yy          xx.......|  |         bb          *********xx.......|
>>       |------------------------------|  |---------------------------------------|
>>            codeword 1,2..n-1                        codeword n
>>       <-------(528/532 Bytes)------>    <-----------(528/532 Bytes)----------->
>>
>>       n = Number of codewords in the page
>>       . = ECC bytes
>>       * = Spare/free bytes
>>       x = Unused byte(s)
>>       y = Dummy Bad Bock byte(s)
>>       b = Real Bad Block byte(s)
>>       size1/size2 = function of codeword size and 'n'
>>
>>       when the ECC block is disabled, one reserved byte (or two for 16 bit bus
>>       width) is now accessible. For the first n - 1 codewords, these are dummy Bad
>>       Block Markers. In the last codeword, this position contains the real BBM
>>
>>       In order to have a consistent layout between RAW and ECC modes, we assume
>>       the following OOB layout arrangement:
>>
>>       |-----------|  |--------------------|
>>       |yyxx.......|  |bb*********xx.......|
>>       |yyxx..ECC..|  |bb*FREEOOB*xx..ECC..|
>>       |yyxx.......|  |bb*********xx.......|
>>       |yyxx.......|  |bb*********xx.......|
>>       |-----------|  |--------------------|
>>       first n - 1       nth OOB region
>>       OOB regions
>>
>>       n = Number of codewords in the page
>>       . = ECC bytes
>>       * = FREE OOB bytes
>>       y = Dummy bad block byte(s) (inaccessible when ECC enabled)
>>       x = Unused byte(s)
>>       b = Real bad block byte(s) (inaccessible when ECC enabled)
>>
>>       This layout is read as is when ECC is disabled. When ECC is enabled, the
>>       inaccessible Bad Block byte(s) are ignored when we write to a page/oob,
>>       and assumed as 0xffs when we read a page/oob. The ECC, unused and
>>       dummy/real bad block bytes are grouped as ecc bytes (i.e, ecc->bytes is
>>       the sum of the three).
> 
> Thanks for the detailed explanation (which would benefit from being
> added somewhere in a comment, maybe at the top of the file).
Ok
> 
> Unfortunately, these ooblayout callbacks do work on a flat <data><oob>
> layout, not on the hardware ECC engine layout. So whatever the real
> physical position of the bad block marker within the NAND array, these
> markers will always be at offset 0 and 1 in the OOB final buffer.
Ok , will fix in next patch.
> 
> Same applies to the spare and ECC bytes. These layouts are totally
> wrong and must be fixed. If the layouts are the same in both raw/spi
> cases, maybe they should be part of the common file?
Ok , will fix in next patch.
> 
>>>> +	} else {
>>>> +		oobregion->length = qecc->ecc_bytes_hw + qecc->spare_bytes;
>>>> +		oobregion->offset = mtd->oobsize - oobregion->length;
>>>> +	}
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +static int qcom_spi_ooblayout_free(struct mtd_info *mtd, int section,
>>>> +				   struct mtd_oob_region *oobregion)
>>>> +{
>>>> +	struct nand_device *nand = mtd_to_nanddev(mtd);
>>>> +	struct qcom_nand_controller *snandc = nand_to_qcom_snand(nand);
>>>> +	struct qpic_ecc *qecc = snandc->qspi->ecc;
>>>> +
>>>> +	if (section)
>>>> +		return -ERANGE;
>>>> +
>>>> +	oobregion->length = qecc->steps * 4;
>>>> +	oobregion->offset = ((qecc->steps - 1) * qecc->bytes) + qecc->bbm_size;
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>
>>> ...
>>>    
>>>> +static int qcom_spi_ecc_prepare_io_req_pipelined(struct nand_device *nand,
>>>> +						 struct nand_page_io_req *req)
>>>> +{
>>>> +	struct qcom_nand_controller *snandc = nand_to_qcom_snand(nand);
>>>> +	struct qpic_ecc *ecc_cfg = nand_to_ecc_ctx(nand);
>>>> +	struct mtd_info *mtd = nanddev_to_mtd(nand);
>>>> +
>>>> +	snandc->qspi->ecc = ecc_cfg;
>>>> +	snandc->qspi->pagesize = mtd->writesize;
>>>> +	snandc->qspi->raw_rw = false;
>>>> +	snandc->qspi->oob_rw = false;
>>>> +	snandc->qspi->page_rw = false;
>>>> +
>>>> +	if (req->datalen)
>>>> +		snandc->qspi->page_rw = true;
>>>> +
>>>> +	if (req->ooblen) {
>>>> +		snandc->qspi->oob_rw = true;
>>>> +		if (req->ooblen == BAD_BLOCK_MARKER_SIZE)
>>>> +			snandc->qspi->read_last_cw = true;
>>>
>>> ???
>>     As per QPIC controller layout , the actual babd block marker will
>>     be present in last code word. Thats why i have added this check.
>>     to read only last codeword for bad block check.
> 
> You need to comply with the request. If ooblen is != 0, you need to
> read the codeword(s) where the oob is. Please don't try to be smarter
> than that. Checking the _value_ of ooblen is an optimization I don't
> think is worth.
Ok, will try to cleanup all the indirection in next patch.
> 
>>>    
>>>> +	}
>>>> +
>>>> +	if (req->mode == MTD_OPS_RAW)
>>>> +		snandc->qspi->raw_rw = true;
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +static int qcom_spi_ecc_finish_io_req_pipelined(struct nand_device *nand,
>>>> +						struct nand_page_io_req *req)
>>>> +{
>>>> +	struct qcom_nand_controller *snandc = nand_to_qcom_snand(nand);
>>>> +	struct mtd_info *mtd = nanddev_to_mtd(nand);
>>>> +
>>>> +	if (req->mode == MTD_OPS_RAW || req->type != NAND_PAGE_READ)
>>>> +		return 0;
>>>> +
>>>> +	if (snandc->qspi->ecc_stats.failed)
>>>> +		mtd->ecc_stats.failed += snandc->qspi->ecc_stats.failed;
>>>> +	mtd->ecc_stats.corrected += snandc->qspi->ecc_stats.corrected;
>>>
>>> Seems strange
>>     In flash error check for each code word i am updating the error value.
>>     So on finishing on io i am assigning that error to mtd variables so that
>>     upper layer check for error.
> 
> You don't clear the qspi ecc_stats so this cannot work properly.
  I am clearing in the qcom_spi_check_error() api, before reading status for the next page.

  snandc->qspi->ecc_stats.failed = 0;
  snandc->qspi->ecc_stats.corrected = 0;
> 
> Plus, I would welcome an else statement for incrementing the corrected
> field.
Ok
> 
>>>    
>>>> +
>>>> +	if (snandc->qspi->ecc_stats.failed)
>>>> +		return -EBADMSG;
>>>> +	else
>>>> +		return snandc->qspi->ecc_stats.bitflips;
>>>> +}
>>>> +
>>>> +static struct nand_ecc_engine_ops qcom_spi_ecc_engine_ops_pipelined = {
>>>> +	.init_ctx = qcom_spi_ecc_init_ctx_pipelined,
>>>> +	.cleanup_ctx = qcom_spi_ecc_cleanup_ctx_pipelined,
>>>> +	.prepare_io_req = qcom_spi_ecc_prepare_io_req_pipelined,
>>>> +	.finish_io_req = qcom_spi_ecc_finish_io_req_pipelined,
>>>> +};
>>>> +
>>>
>>> ...
>>>    
>>>> +static int qcom_spi_read_page_raw(struct qcom_nand_controller *snandc,
>>>> +				  const struct spi_mem_op *op)
>>>> +{
>>>> +	struct qpic_ecc *ecc_cfg = snandc->qspi->ecc;
>>>> +	u8 *data_buf = NULL, *oob_buf = NULL;
>>>> +	int ret, cw;
>>>> +	u32 num_cw = snandc->qspi->num_cw;
>>>> +
>>>> +	if (snandc->qspi->page_rw)
>>>
>>> I don't like this indirection very much. Can't you simplify this and
>>> just follow the spi-mem op instead of constantly trying to add
>>> additional stuff?
>>     This indirection needed due to QPIC controller will not take all the instruction
>>     one-by-one , once we will set CMD_EXEC = 1, then it will execute all the instruction
>>     at once.
> 
> The spi_mem_op structure already describes the whole operation. Why do
> you split the operation in sub routines if you can't actually do that?
Ok , will try to cleanup in next patch.
> 
>>>
>>> The hardware is already quite complex, but it feels like your adding
>>> yet another pile of unnecessary complexity.
>>     Yes hardware is complex. let me check if i can further optimize as per spi-mem op
>>     as you suggested.
>>>    
>>>> +		data_buf = op->data.buf.in;
>>>> +
>>>> +	if (snandc->qspi->oob_rw)
>>>> +		oob_buf = op->data.buf.in;
> 
> ...
> 
>>>> +static int qcom_spi_write_page_cache(struct qcom_nand_controller *snandc,
>>>> +				     const struct spi_mem_op *op)
>>>> +{
>>>> +	struct qpic_snand_op s_op = {};
>>>> +	u32 cmd;
>>>> +
>>>> +	cmd = qcom_spi_cmd_mapping(snandc, op->cmd.opcode);
>>>
>>> I've asked for switch cases to return an error in case they could not
>>> handle the request. If you don't check the returned values, it
>>> does not make any sense.
>>    Ok, will fix in next patch.
>>>    
>>>> +	s_op.cmd_reg = cmd;
>>>> +
>>>> +	if (op->cmd.opcode == SPINAND_PROGRAM_LOAD) {
>>>> +		if (snandc->qspi->page_rw)
>>>> +			snandc->qspi->data_buf = (u8 *)op->data.buf.out;
>>>
>>> What you do here does not write anything in a page cache.
>>     No here just updating the buffer , actual write will happen in program_execute.
>>     This is due to QPIC controller will not take all the instruction one-by-one.
>>     once we will set CMD_EXEC = 1, then it will execute all the instruction
>>     at once. So accumulating all the instruction and then executing at once in
>>     program_execute.
>>>
>>> I also don't understand why you would have to check against the
>>> SPINAND_PROGRAM_LOAD opcode.
>>     Because the actual write will happen in program_execute. and here
>>     PROGRAM_EXECUTE command will also land, so that added the check.
>>>    
>>>> +	}
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +static int qcom_spi_send_cmdaddr(struct qcom_nand_controller *snandc,
>>>> +				 const struct spi_mem_op *op)
>>>> +{
>>>> +	struct qpic_snand_op s_op = {};
>>>> +	u32 cmd;
>>>> +	int ret, opcode;
>>>> +
>>>> +	cmd = qcom_spi_cmd_mapping(snandc, op->cmd.opcode);
>>>> +
>>>> +	s_op.cmd_reg = cmd;
>>>> +	s_op.addr1_reg = op->addr.val;
>>>> +	s_op.addr2_reg = 0;
>>>> +
>>>> +	opcode = op->cmd.opcode;
>>>> +
>>>> +	switch (opcode) {
>>>> +	case SPINAND_WRITE_EN:
>>>> +		return 0;
>>>> +	case SPINAND_PROGRAM_EXECUTE:
>>>> +		s_op.addr1_reg = op->addr.val << 16;
>>>> +		s_op.addr2_reg = op->addr.val >> 16 & 0xff;
>>>> +		snandc->qspi->addr1 = s_op.addr1_reg;
>>>> +		snandc->qspi->addr2 = s_op.addr2_reg;
>>>> +		snandc->qspi->cmd = cmd;
>>>> +		return qcom_spi_program_execute(snandc, op);
>>>> +	case SPINAND_READ:
>>>> +		s_op.addr1_reg = (op->addr.val << 16);
>>>> +		s_op.addr2_reg = op->addr.val >> 16 & 0xff;
>>>> +		snandc->qspi->addr1 = s_op.addr1_reg;
>>>> +		snandc->qspi->addr2 = s_op.addr2_reg;
>>>> +		snandc->qspi->cmd = cmd;
>>>> +		return 0;
>>>> +	case SPINAND_ERASE:
>>>> +		s_op.addr2_reg = (op->addr.val >> 16) & 0xffff;
>>>> +		s_op.addr1_reg = op->addr.val;
>>>> +		snandc->qspi->addr1 = (s_op.addr1_reg << 16);
>>>> +		snandc->qspi->addr2 = s_op.addr2_reg;
>>>> +		snandc->qspi->cmd = cmd;
>>>> +		qcom_spi_block_erase(snandc);
>>>> +		return 0;
>>>> +	default:
>>>> +		break;
>>>> +	}
>>>> +
>>>> +	snandc->buf_count = 0;
>>>> +	snandc->buf_start = 0;
>>>> +	qcom_clear_read_regs(snandc);
>>>> +	qcom_clear_bam_transaction(snandc);
>>>> +
>>>> +	snandc->regs->cmd = s_op.cmd_reg;
>>>> +	snandc->regs->exec = 1;
>>>> +	snandc->regs->addr0 = s_op.addr1_reg;
>>>> +	snandc->regs->addr1 = s_op.addr2_reg;
>>>> +
>>>> +	qcom_write_reg_dma(snandc, &snandc->regs->cmd, NAND_FLASH_CMD, 3, NAND_BAM_NEXT_SGL);
>>>> +	qcom_write_reg_dma(snandc, &snandc->regs->exec, NAND_EXEC_CMD, 1, NAND_BAM_NEXT_SGL);
>>>> +
>>>> +	ret = qcom_submit_descs(snandc);
> 
> And you really don't want to check the validity of the opcode with what
> you support before submitting the descriptors?
Ok , will do in next patch.
> 
>>>> +	if (ret)
>>>> +		dev_err(snandc->dev, "failure in sbumitting cmd descriptor\n");
>>>
>>> typo
>>    Ok , will fix in next patch.
>>>    
>>>> +
>>>> +	return ret;
>>>> +}
>>>> +
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
>>>> +	case SPINAND_RESET:
>>>> +		return 0;
>>>> +	case SPINAND_PROGRAM_EXECUTE:
>>>> +		return 0;
>>>> +	case SPINAND_WRITE_EN:
>>>> +		return 0;
>>>> +	case SPINAND_ERASE:
>>>> +		return 0;
>>>> +	case SPINAND_READ:
>>>> +		return 0;
>>>
>>> You can stack the cases
>> Ok
>>>    
>>>> +	default:
>>>> +		return -EOPNOTSUPP;
>>>> +	}
>>>> +
>>>> +	ret = qcom_submit_descs(snandc);
>>>> +	if (ret)
>>>> +		dev_err(snandc->dev, "failure in submitting descriptor for:%d\n", opcode);
>>>> +
>>>> +	if (copy) {
>>>> +		qcom_nandc_dev_to_mem(snandc, true);
>>>> +		memcpy(op->data.buf.in, snandc->reg_read_buf, snandc->buf_count);
>>>> +	}
>>>> +
>>>> +	if (copy_ftr) {
>>>> +		qcom_nandc_dev_to_mem(snandc, true);
>>>> +		val = le32_to_cpu(*(__le32 *)snandc->reg_read_buf);
>>>> +		val >>= 8;
>>>> +		memcpy(op->data.buf.in, &val, snandc->buf_count);
>>>> +	}
>>>> +
>>>> +	return ret;
>>>> +}
> 
> Thanks,
> Miquèl

