Return-Path: <linux-spi+bounces-2990-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F198CBE1E
	for <lists+linux-spi@lfdr.de>; Wed, 22 May 2024 11:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C84E1F22A86
	for <lists+linux-spi@lfdr.de>; Wed, 22 May 2024 09:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76320811F8;
	Wed, 22 May 2024 09:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ErTHYfsq"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E832354720;
	Wed, 22 May 2024 09:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716370988; cv=none; b=hbXRWuwQKirE54m0NJUol4JkJNpIkbx+srBEzAkwow/GAopltEg5Prr34465I878qJ7/TyhiwEyakLD7ClVSgdlQyIBG5AUxtVf7QDjCSo3rsIw4RX/5GqH2cv5YQ8ZeAapQM6ROAabjbEOJfvuJ31A5vnq6THrdbzF9Sragl44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716370988; c=relaxed/simple;
	bh=3aXCzXk03NlHrBEHPxRwQlzFDBo3nydDUQBJZy03syg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ooIeid3p549ea9IGy/J4VaMLaKs0BPnXVsWQNZMCOZCFHd2luXMwnYf0M9rU9wVe2ul2QafF9woGlLSJ4z3z/UJzC36EMNAONwySl/6r2RGE1nHWpY7D0M/HBRZqkopTjYJaU78RoNfHHP5wxQFomzOquwVJJhNbeF6BnWqgF+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ErTHYfsq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44M58Jgx009703;
	Wed, 22 May 2024 09:42:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=igPoUkGtjpLFfsWeqO6/eaF8vOWZDWeOsDMGJNGygsM=; b=Er
	THYfsqxYy2QJ08d9dyl49Wy4HjR4J3VJfHdhhTPORSwe02TIqx3Pgkg3J/K5tqZ8
	tvQW/HFtvgWxMcT7+GgbSlEeaXQFK56HTszLqeTZAbZeinGbqgUY6yXHrEsdw5kA
	fHvAvYbZibVQI9BPwYuxSp0fX1JoV6Tubk8deHrMyoN3/gCQ+12mou8UXgAnCQCh
	H9t9tKzW72019qFCc9rQTf47Hg89lW5Vnc6AuZO/UfNbXfdcpJsC5M9kjE83ohRb
	7PzX2YdtTcF6FTP1/uk3RsMeC+TcNvdLZwbrDkVD9BtbdSc4gt1nzbQJ6ec2iZLK
	6ZYpkfWMs1D6MKAkc83Q==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y6pqard07-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 May 2024 09:42:49 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44M9glLw017082
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 May 2024 09:42:47 GMT
Received: from [10.216.52.184] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 22 May
 2024 02:42:42 -0700
Message-ID: <5b96e24a-edcd-df85-9e70-332a6059ee73@quicinc.com>
Date: Wed, 22 May 2024 15:12:38 +0530
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
Content-Language: en-US
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
From: Md Sadre Alam <quic_mdalam@quicinc.com>
In-Reply-To: <20240521152410.7cff71ab@xps-13>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: iAxuVzY5wOrwNqPjsjz0iMFqr-zx6Gcc
X-Proofpoint-ORIG-GUID: iAxuVzY5wOrwNqPjsjz0iMFqr-zx6Gcc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-22_04,2024-05-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 suspectscore=0 bulkscore=0 mlxscore=0 adultscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 clxscore=1015
 priorityscore=1501 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2405010000 definitions=main-2405220069



On 5/21/2024 6:54 PM, Miquel Raynal wrote:
> Hi,
> 
>> diff --git a/drivers/mtd/nand/Makefile b/drivers/mtd/nand/Makefile
>> index e59106e0a3af..12ee33c4ac4e 100644
>> --- a/drivers/mtd/nand/Makefile
>> +++ b/drivers/mtd/nand/Makefile
>> @@ -5,6 +5,10 @@ obj-$(CONFIG_MTD_NAND_CORE) += nandcore.o
>>   obj-$(CONFIG_MTD_NAND_ECC_MEDIATEK) += ecc-mtk.o
>>   ifeq ($(CONFIG_MTD_NAND_QCOM),y)
>>   obj-y	+= qpic_common.o
>> +else
>> +ifeq ($(CONFIG_SPI_QPIC_SNAND),y)
>> +obj-y   += qpic_common.o
>> +endif
> 
> Same issue.
  ok, will fix in next patch.
> 
>>   endif
>>   obj-y	+= onenand/
>>   obj-y	+= raw/
>> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
>> index a2c99ff33e0a..bb7579246f2f 100644
>> --- a/drivers/spi/Kconfig
>> +++ b/drivers/spi/Kconfig
>> @@ -892,6 +892,14 @@ config SPI_QCOM_QSPI
>>   	help
>>   	  QSPI(Quad SPI) driver for Qualcomm QSPI controller.
>>   
> 
> ...
> 
>> +static struct qcom_nand_controller *nand_to_qcom_snand(struct nand_device *nand)
>> +{
>> +	struct qpic_spi_nand *qspi;
>> +	struct nand_ecc_engine *eng = nand->ecc.engine;
>> +
>> +	qspi = container_of(eng, struct qpic_spi_nand, ecc_eng);
> 
> Please encode this into a macro and use it on the second line of this
> function:
Ok
> 
> 	struct qpic_spi_nand *qspi = ecceng_to_qspi(eng);
> 
>> +	return qspi->snandc;
>> +}
>> +
>> +static int qcom_spi_init(struct qcom_nand_controller *snandc)
>> +{
>> +	u32 snand_cfg_val = 0x0;
>> +	int ret;
>> +
>> +	snand_cfg_val |= (LOAD_CLK_CNTR_INIT_EN | (CLK_CNTR_INIT_VAL_VEC << 16) |
>> +			 (FEA_STATUS_DEV_ADDR << 8) | SPI_CFG);
> 
> FIELD_PREP ?
Ok
> 
>> +
>> +	snandc->regs->spi_cfg = snand_cfg_val;
>> +	snandc->regs->num_addr_cycle = SPI_NUM_ADDR;
>> +	snandc->regs->busy_wait_cnt = SPI_WAIT_CNT;
>> +
>> +	qcom_write_reg_dma(snandc, &snandc->regs->spi_cfg, NAND_FLASH_SPI_CFG, 1, 0);
>> +
>> +	snand_cfg_val &= ~LOAD_CLK_CNTR_INIT_EN;
>> +	snandc->regs->spi_cfg = snand_cfg_val;
>> +
>> +	qcom_write_reg_dma(snandc, &snandc->regs->spi_cfg, NAND_FLASH_SPI_CFG, 1, 0);
>> +
>> +	qcom_write_reg_dma(snandc, &snandc->regs->num_addr_cycle, NAND_NUM_ADDR_CYCLES, 1, 0);
>> +	qcom_write_reg_dma(snandc, &snandc->regs->busy_wait_cnt, NAND_BUSY_CHECK_WAIT_CNT, 1,
>> +			   NAND_BAM_NEXT_SGL);
>> +
>> +	ret = qcom_submit_descs(snandc);
>> +	if (ret) {
>> +		dev_err(snandc->dev, "failure in submitting spi init descriptor\n");
>> +		return ret;
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +static int qcom_spi_ooblayout_ecc(struct mtd_info *mtd, int section,
>> +				  struct mtd_oob_region *oobregion)
>> +{
>> +	struct nand_device *nand = mtd_to_nanddev(mtd);
>> +	struct qcom_nand_controller *snandc = nand_to_qcom_snand(nand);
>> +	struct qpic_ecc *qecc = snandc->qspi->ecc;
>> +
>> +	if (section > 1)
>> +		return -ERANGE;
>> +
>> +	if (!section) {
>> +		oobregion->length = (qecc->bytes * (qecc->steps - 1)) + qecc->bbm_size;
>> +		oobregion->offset = 0;
> 
> No, offset 0 is for the BBM. This is wrong.
> The whole oob layout looks really really wrong.
> 
> ECC bytes are where the ECC engine puts its bytes in the OOB area.
> Free bytes start after the BBM and fill the gaps until the end of the
> area, except where there are ECC bytes.
  QPIC NAND controller having its own page layout with ecc and without ecc.
  The same layout we are using in raw nand driver as well, so i used the
  same here. The below info is already there in qcom raw nand driver file
  in page layout info.

  QPIC NAND controller layout as below:

   Layout with ECC enabled:

     |----------------------|  |---------------------------------|
     |           xx.......yy|  |             *********xx.......yy|
     |    DATA   xx..ECC..yy|  |    DATA     **SPARE**xx..ECC..yy|
     |   (516)   xx.......yy|  |  (516-n*4)  **(n*4)**xx.......yy|
     |           xx.......yy|  |             *********xx.......yy|
     |----------------------|  |---------------------------------|
      codeword 1,2..n-1                  codeword n
     <---(528/532 Bytes)-->    <-------(528/532 Bytes)--------->

     n = Number of codewords in the page
     . = ECC bytes
     * = Spare/free bytes
     x = Unused byte(s)
     y = Reserved byte(s)

     2K page: n = 4, spare = 16 bytes
     4K page: n = 8, spare = 32 bytes
     8K page: n = 16, spare = 64 bytes

     the qcom nand controller operates at a sub page/codeword level. each
     codeword is 528 and 532 bytes for 4 bit and 8 bit ECC modes respectively.
     the number of ECC bytes vary based on the ECC strength and the bus width.

     the first n - 1 codewords contains 516 bytes of user data, the remaining
     12/16 bytes consist of ECC and reserved data. The nth codeword contains
     both user data and spare(oobavail) bytes that sum up to 516 bytes.

     When we access a page with ECC enabled, the reserved bytes(s) are not
     accessible at all. When reading, we fill up these unreadable positions
     with 0xffs. When writing, the controller skips writing the inaccessible
     bytes.

     Layout with ECC disabled:

     |------------------------------|  |---------------------------------------|
     |         yy          xx.......|  |         bb          *********xx.......|
     |  DATA1  yy  DATA2   xx..ECC..|  |  DATA1  bb  DATA2   **SPARE**xx..ECC..|
     | (size1) yy (size2)  xx.......|  | (size1) bb (size2)  **(n*4)**xx.......|
     |         yy          xx.......|  |         bb          *********xx.......|
     |------------------------------|  |---------------------------------------|
          codeword 1,2..n-1                        codeword n
     <-------(528/532 Bytes)------>    <-----------(528/532 Bytes)----------->

     n = Number of codewords in the page
     . = ECC bytes
     * = Spare/free bytes
     x = Unused byte(s)
     y = Dummy Bad Bock byte(s)
     b = Real Bad Block byte(s)
     size1/size2 = function of codeword size and 'n'

     when the ECC block is disabled, one reserved byte (or two for 16 bit bus
     width) is now accessible. For the first n - 1 codewords, these are dummy Bad
     Block Markers. In the last codeword, this position contains the real BBM

     In order to have a consistent layout between RAW and ECC modes, we assume
     the following OOB layout arrangement:

     |-----------|  |--------------------|
     |yyxx.......|  |bb*********xx.......|
     |yyxx..ECC..|  |bb*FREEOOB*xx..ECC..|
     |yyxx.......|  |bb*********xx.......|
     |yyxx.......|  |bb*********xx.......|
     |-----------|  |--------------------|
     first n - 1       nth OOB region
     OOB regions

     n = Number of codewords in the page
     . = ECC bytes
     * = FREE OOB bytes
     y = Dummy bad block byte(s) (inaccessible when ECC enabled)
     x = Unused byte(s)
     b = Real bad block byte(s) (inaccessible when ECC enabled)

     This layout is read as is when ECC is disabled. When ECC is enabled, the
     inaccessible Bad Block byte(s) are ignored when we write to a page/oob,
     and assumed as 0xffs when we read a page/oob. The ECC, unused and
     dummy/real bad block bytes are grouped as ecc bytes (i.e, ecc->bytes is
     the sum of the three).

> 
>> +	} else {
>> +		oobregion->length = qecc->ecc_bytes_hw + qecc->spare_bytes;
>> +		oobregion->offset = mtd->oobsize - oobregion->length;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int qcom_spi_ooblayout_free(struct mtd_info *mtd, int section,
>> +				   struct mtd_oob_region *oobregion)
>> +{
>> +	struct nand_device *nand = mtd_to_nanddev(mtd);
>> +	struct qcom_nand_controller *snandc = nand_to_qcom_snand(nand);
>> +	struct qpic_ecc *qecc = snandc->qspi->ecc;
>> +
>> +	if (section)
>> +		return -ERANGE;
>> +
>> +	oobregion->length = qecc->steps * 4;
>> +	oobregion->offset = ((qecc->steps - 1) * qecc->bytes) + qecc->bbm_size;
>> +
>> +	return 0;
>> +}
>> +
> 
> ...
> 
>> +static int qcom_spi_ecc_prepare_io_req_pipelined(struct nand_device *nand,
>> +						 struct nand_page_io_req *req)
>> +{
>> +	struct qcom_nand_controller *snandc = nand_to_qcom_snand(nand);
>> +	struct qpic_ecc *ecc_cfg = nand_to_ecc_ctx(nand);
>> +	struct mtd_info *mtd = nanddev_to_mtd(nand);
>> +
>> +	snandc->qspi->ecc = ecc_cfg;
>> +	snandc->qspi->pagesize = mtd->writesize;
>> +	snandc->qspi->raw_rw = false;
>> +	snandc->qspi->oob_rw = false;
>> +	snandc->qspi->page_rw = false;
>> +
>> +	if (req->datalen)
>> +		snandc->qspi->page_rw = true;
>> +
>> +	if (req->ooblen) {
>> +		snandc->qspi->oob_rw = true;
>> +		if (req->ooblen == BAD_BLOCK_MARKER_SIZE)
>> +			snandc->qspi->read_last_cw = true;
> 
> ???
   As per QPIC controller layout , the actual babd block marker will
   be present in last code word. Thats why i have added this check.
   to read only last codeword for bad block check.
> 
>> +	}
>> +
>> +	if (req->mode == MTD_OPS_RAW)
>> +		snandc->qspi->raw_rw = true;
>> +
>> +	return 0;
>> +}
>> +
>> +static int qcom_spi_ecc_finish_io_req_pipelined(struct nand_device *nand,
>> +						struct nand_page_io_req *req)
>> +{
>> +	struct qcom_nand_controller *snandc = nand_to_qcom_snand(nand);
>> +	struct mtd_info *mtd = nanddev_to_mtd(nand);
>> +
>> +	if (req->mode == MTD_OPS_RAW || req->type != NAND_PAGE_READ)
>> +		return 0;
>> +
>> +	if (snandc->qspi->ecc_stats.failed)
>> +		mtd->ecc_stats.failed += snandc->qspi->ecc_stats.failed;
>> +	mtd->ecc_stats.corrected += snandc->qspi->ecc_stats.corrected;
> 
> Seems strange
   In flash error check for each code word i am updating the error value.
   So on finishing on io i am assigning that error to mtd variables so that
   upper layer check for error.
> 
>> +
>> +	if (snandc->qspi->ecc_stats.failed)
>> +		return -EBADMSG;
>> +	else
>> +		return snandc->qspi->ecc_stats.bitflips;
>> +}
>> +
>> +static struct nand_ecc_engine_ops qcom_spi_ecc_engine_ops_pipelined = {
>> +	.init_ctx = qcom_spi_ecc_init_ctx_pipelined,
>> +	.cleanup_ctx = qcom_spi_ecc_cleanup_ctx_pipelined,
>> +	.prepare_io_req = qcom_spi_ecc_prepare_io_req_pipelined,
>> +	.finish_io_req = qcom_spi_ecc_finish_io_req_pipelined,
>> +};
>> +
> 
> ...
> 
>> +static int qcom_spi_read_page_raw(struct qcom_nand_controller *snandc,
>> +				  const struct spi_mem_op *op)
>> +{
>> +	struct qpic_ecc *ecc_cfg = snandc->qspi->ecc;
>> +	u8 *data_buf = NULL, *oob_buf = NULL;
>> +	int ret, cw;
>> +	u32 num_cw = snandc->qspi->num_cw;
>> +
>> +	if (snandc->qspi->page_rw)
> 
> I don't like this indirection very much. Can't you simplify this and
> just follow the spi-mem op instead of constantly trying to add
> additional stuff?
   This indirection needed due to QPIC controller will not take all the instruction
   one-by-one , once we will set CMD_EXEC = 1, then it will execute all the instruction
   at once.
> 
> The hardware is already quite complex, but it feels like your adding
> yet another pile of unnecessary complexity.
   Yes hardware is complex. let me check if i can further optimize as per spi-mem op
   as you suggested.
> 
>> +		data_buf = op->data.buf.in;
>> +
>> +	if (snandc->qspi->oob_rw)
>> +		oob_buf = op->data.buf.in;
> 
> Same buffer pointed by the two pointers? hum
  Ok , will fix in next patch.
> 
>> +
>> +	if (!oob_buf) {
>> +		oob_buf = snandc->qspi->oob_buf;
>> +		memset(oob_buf, 0xff, OOB_BUF_SIZE);
>> +	}
>> +
>> +	for (cw = 0; cw < num_cw; cw++) {
>> +		ret = qcom_spi_read_cw_raw(snandc, data_buf, oob_buf, cw);
>> +		if (ret)
>> +			return ret;
>> +
>> +		if (data_buf)
>> +			data_buf += ecc_cfg->cw_data;
>> +		if (oob_buf)
>> +			oob_buf += ecc_cfg->bytes;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int qcom_spi_read_page_cache(struct qcom_nand_controller *snandc,
>> +				    const struct spi_mem_op *op)
>> +{
>> +	struct qpic_ecc *ecc_cfg = snandc->qspi->ecc;
>> +	u8 *data_buf = NULL, *data_buf_start, *oob_buf = NULL, *oob_buf_start;
>> +	int ret, i;
>> +	u32 cfg0, cfg1, ecc_bch_cfg, num_cw = snandc->qspi->num_cw;
>> +
>> +	if (snandc->qspi->page_rw) {
>> +		data_buf = op->data.buf.in;
>> +		data_buf_start = data_buf;
>> +	}
>> +
>> +	if (snandc->qspi->oob_rw || snandc->qspi->raw_rw) {
>> +		oob_buf = op->data.buf.in;
>> +		oob_buf_start = oob_buf;
>> +	}
>> +
>> +	if (snandc->qspi->page_rw && snandc->qspi->raw_rw)
>> +		return qcom_spi_read_page_raw(snandc, op);
>> +
>> +	if (snandc->qspi->oob_rw && snandc->qspi->raw_rw && snandc->qspi->read_last_cw)
>> +		return qcom_spi_read_last_cw(snandc, op);
>> +
>> +	snandc->buf_count = 0;
>> +	snandc->buf_start = 0;
>> +	qcom_clear_read_regs(snandc);
>> +
>> +	cfg0 = (ecc_cfg->cfg0 & ~(7U << CW_PER_PAGE)) |
>> +				(num_cw - 1) << CW_PER_PAGE;
>> +	cfg1 = ecc_cfg->cfg1;
>> +	ecc_bch_cfg = ecc_cfg->ecc_bch_cfg;
>> +
>> +	snandc->regs->addr0 = snandc->qspi->addr1;
>> +	snandc->regs->addr1 = snandc->qspi->addr2;
>> +	snandc->regs->cmd = snandc->qspi->cmd;
>> +	snandc->regs->cfg0 = cfg0;
>> +	snandc->regs->cfg1 = cfg1;
>> +	snandc->regs->ecc_bch_cfg = ecc_bch_cfg;
>> +	snandc->regs->clrflashstatus = ecc_cfg->clrflashstatus;
>> +	snandc->regs->clrreadstatus = ecc_cfg->clrreadstatus;
>> +	snandc->regs->exec = 1;
>> +
>> +	qcom_spi_set_read_loc(snandc, 0, 0, 0, ecc_cfg->cw_data, 1);
>> +
>> +	qcom_clear_bam_transaction(snandc);
>> +
>> +	qcom_write_reg_dma(snandc, &snandc->regs->addr0, NAND_ADDR0, 2, 0);
>> +	qcom_write_reg_dma(snandc, &snandc->regs->cfg0, NAND_DEV0_CFG0, 3, 0);
>> +	qcom_write_reg_dma(snandc, &snandc->regs->erased_cw_detect_cfg_clr,
>> +			   NAND_ERASED_CW_DETECT_CFG, 1, 0);
>> +	qcom_write_reg_dma(snandc, &snandc->regs->erased_cw_detect_cfg_set,
>> +			   NAND_ERASED_CW_DETECT_CFG, 1,
>> +			   NAND_ERASED_CW_SET | NAND_BAM_NEXT_SGL);
>> +
>> +	for (i = 0; i < num_cw; i++) {
>> +		int data_size, oob_size;
>> +
>> +		if (i == (num_cw - 1)) {
>> +			data_size = 512 - ((num_cw - 1) << 2);
>> +			oob_size = (num_cw << 2) + ecc_cfg->ecc_bytes_hw +
>> +				    ecc_cfg->spare_bytes;
>> +		} else {
>> +			data_size = ecc_cfg->cw_data;
>> +			oob_size = ecc_cfg->ecc_bytes_hw + ecc_cfg->spare_bytes;
>> +		}
>> +
>> +		if (data_buf && oob_buf) {
>> +			qcom_spi_set_read_loc(snandc, i, 0, 0, data_size, 0);
>> +			qcom_spi_set_read_loc(snandc, i, 1, data_size, oob_size, 1);
>> +		} else if (data_buf) {
>> +			qcom_spi_set_read_loc(snandc, i, 0, 0, data_size, 1);
>> +		} else {
>> +			qcom_spi_set_read_loc(snandc, i, 0, data_size, oob_size, 1);
>> +		}
>> +
>> +		qcom_spi_config_cw_read(snandc, true, i);
>> +
>> +		if (data_buf)
>> +			qcom_read_data_dma(snandc, FLASH_BUF_ACC, data_buf,
>> +					   data_size, 0);
>> +		if (oob_buf) {
>> +			int j;
>> +
>> +			for (j = 0; j < ecc_cfg->bbm_size; j++)
>> +				*oob_buf++ = 0xff;
>> +
>> +			qcom_read_data_dma(snandc, FLASH_BUF_ACC + data_size,
>> +					   oob_buf, oob_size, 0);
>> +		}
>> +
>> +		if (data_buf)
>> +			data_buf += data_size;
>> +		if (oob_buf)
>> +			oob_buf += oob_size;
>> +	}
>> +
>> +	ret = qcom_submit_descs(snandc);
>> +	if (ret) {
>> +		dev_err(snandc->dev, "failure to read page\n");
>> +		return ret;
>> +	}
>> +
>> +	return qcom_spi_check_error(snandc, data_buf_start, oob_buf_start);
>> +}
>> +
>> +static void qcom_spi_config_page_write(struct qcom_nand_controller *snandc)
>> +{
>> +	qcom_write_reg_dma(snandc, &snandc->regs->addr0, NAND_ADDR0, 2, 0);
>> +	qcom_write_reg_dma(snandc, &snandc->regs->cfg0, NAND_DEV0_CFG0, 3, 0);
>> +	qcom_write_reg_dma(snandc, &snandc->regs->ecc_buf_cfg, NAND_EBI2_ECC_BUF_CFG,
>> +			   1, NAND_BAM_NEXT_SGL);
>> +}
>> +
>> +static void qcom_spi_config_cw_write(struct qcom_nand_controller *snandc)
>> +{
>> +	qcom_write_reg_dma(snandc, &snandc->regs->cmd, NAND_FLASH_CMD, 1, NAND_BAM_NEXT_SGL);
>> +	qcom_write_reg_dma(snandc, &snandc->regs->exec, NAND_EXEC_CMD, 1, NAND_BAM_NEXT_SGL);
>> +	qcom_read_reg_dma(snandc, NAND_FLASH_STATUS, 1, NAND_BAM_NEXT_SGL);
>> +
>> +	qcom_write_reg_dma(snandc, &snandc->regs->clrflashstatus, NAND_FLASH_STATUS, 1, 0);
>> +	qcom_write_reg_dma(snandc, &snandc->regs->clrreadstatus, NAND_READ_STATUS, 1,
>> +			   NAND_BAM_NEXT_SGL);
>> +}
>> +
>> +static int qcom_spi_program_raw(struct qcom_nand_controller *snandc,
>> +				const struct spi_mem_op *op)
>> +{
>> +	struct qpic_ecc *ecc_cfg = snandc->qspi->ecc;
>> +	u8 *data_buf = NULL, *oob_buf = NULL;
>> +	int i, ret;
>> +	int num_cw = snandc->qspi->num_cw;
>> +	u32 cfg0, cfg1, ecc_bch_cfg;
>> +
>> +	cfg0 = (ecc_cfg->cfg0_raw & ~(7U << CW_PER_PAGE)) |
>> +			(num_cw - 1) << CW_PER_PAGE;
>> +	cfg1 = ecc_cfg->cfg1_raw;
>> +	ecc_bch_cfg = ECC_CFG_ECC_DISABLE;
>> +
>> +	data_buf = snandc->qspi->data_buf;
>> +
>> +	oob_buf = snandc->qspi->oob_buf;
>> +	memset(oob_buf, 0xff, OOB_BUF_SIZE);
>> +
>> +	snandc->buf_count = 0;
>> +	snandc->buf_start = 0;
>> +	qcom_clear_read_regs(snandc);
>> +	qcom_clear_bam_transaction(snandc);
>> +
>> +	snandc->regs->addr0 = snandc->qspi->addr1;
>> +	snandc->regs->addr1 = snandc->qspi->addr2;
>> +	snandc->regs->cmd = snandc->qspi->cmd;
>> +	snandc->regs->cfg0 = cfg0;
>> +	snandc->regs->cfg1 = cfg1;
>> +	snandc->regs->ecc_bch_cfg = ecc_bch_cfg;
>> +	snandc->regs->clrflashstatus = ecc_cfg->clrflashstatus;
>> +	snandc->regs->clrreadstatus = ecc_cfg->clrreadstatus;
>> +	snandc->regs->exec = 1;
>> +
>> +	qcom_spi_config_page_write(snandc);
>> +
>> +	for (i = 0; i < num_cw; i++) {
>> +		int data_size1, data_size2, oob_size1, oob_size2;
>> +		int reg_off = FLASH_BUF_ACC;
>> +
>> +		data_size1 = snandc->qspi->pagesize - ecc_cfg->cw_size * (num_cw - 1);
>> +		oob_size1 = ecc_cfg->bbm_size;
>> +
>> +		if ((i == (num_cw - 1))) {
>> +			data_size2 = NANDC_STEP_SIZE - data_size1 -
>> +				     ((num_cw - 1) << 2);
>> +			oob_size2 = (num_cw << 2) + ecc_cfg->ecc_bytes_hw +
>> +				    ecc_cfg->spare_bytes;
>> +		} else {
>> +			data_size2 = ecc_cfg->cw_data - data_size1;
>> +			oob_size2 = ecc_cfg->ecc_bytes_hw + ecc_cfg->spare_bytes;
>> +		}
>> +
>> +		qcom_write_data_dma(snandc, reg_off, data_buf, data_size1,
>> +				    NAND_BAM_NO_EOT);
>> +		reg_off += data_size1;
>> +		data_buf += data_size1;
>> +
>> +		qcom_write_data_dma(snandc, reg_off, oob_buf, oob_size1,
>> +				    NAND_BAM_NO_EOT);
>> +		oob_buf += oob_size1;
>> +		reg_off += oob_size1;
>> +
>> +		qcom_write_data_dma(snandc, reg_off, data_buf, data_size2,
>> +				    NAND_BAM_NO_EOT);
>> +		reg_off += data_size2;
>> +		data_buf += data_size2;
>> +
>> +		qcom_write_data_dma(snandc, reg_off, oob_buf, oob_size2, 0);
>> +		oob_buf += oob_size2;
>> +
>> +		qcom_spi_config_cw_write(snandc);
>> +	}
>> +
>> +	ret = qcom_submit_descs(snandc);
>> +	if (ret) {
>> +		dev_err(snandc->dev, "failure to write raw page\n");
>> +		return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int qcom_spi_program_execute(struct qcom_nand_controller *snandc,
>> +				    const struct spi_mem_op *op)
>> +{
>> +	struct qpic_ecc *ecc_cfg = snandc->qspi->ecc;
>> +	u8 *data_buf = NULL, *oob_buf = NULL;
>> +	int i, ret;
>> +	int num_cw = snandc->qspi->num_cw;
>> +	u32 cfg0, cfg1, ecc_bch_cfg, ecc_buf_cfg;
>> +
>> +	cfg0 = (ecc_cfg->cfg0 & ~(7U << CW_PER_PAGE)) |
>> +				(num_cw - 1) << CW_PER_PAGE;
>> +	cfg1 = ecc_cfg->cfg1;
>> +	ecc_bch_cfg = ecc_cfg->ecc_bch_cfg;
>> +	ecc_buf_cfg = ecc_cfg->ecc_buf_cfg;
>> +
>> +	if (snandc->qspi->page_rw && snandc->qspi->raw_rw)
>> +		return qcom_spi_program_raw(snandc, op);
>> +
>> +	if (snandc->qspi->data_buf)
>> +		data_buf = snandc->qspi->data_buf;
>> +
>> +	if (snandc->qspi->oob_buf)
>> +		oob_buf = snandc->qspi->oob_buf;
>> +
>> +	snandc->buf_count = 0;
>> +	snandc->buf_start = 0;
>> +	qcom_clear_read_regs(snandc);
>> +	qcom_clear_bam_transaction(snandc);
>> +
>> +	snandc->regs->addr0 = snandc->qspi->addr1;
>> +	snandc->regs->addr1 = snandc->qspi->addr2;
>> +	snandc->regs->cmd = snandc->qspi->cmd;
>> +	snandc->regs->cfg0 = cfg0;
>> +	snandc->regs->cfg1 = cfg1;
>> +	snandc->regs->ecc_bch_cfg = ecc_bch_cfg;
>> +	snandc->regs->ecc_buf_cfg = ecc_buf_cfg;
>> +	snandc->regs->exec = 1;
>> +
>> +	qcom_spi_config_page_write(snandc);
>> +
>> +	for (i = 0; i < num_cw; i++) {
>> +		int data_size, oob_size;
>> +
>> +		if (i == (num_cw - 1)) {
>> +			data_size = NANDC_STEP_SIZE - ((num_cw - 1) << 2);
>> +			oob_size = (num_cw << 2) + ecc_cfg->ecc_bytes_hw +
>> +				    ecc_cfg->spare_bytes;
>> +		} else {
>> +			data_size = ecc_cfg->cw_data;
>> +			oob_size = ecc_cfg->bytes;
>> +		}
>> +
>> +		if (data_buf)
>> +			qcom_write_data_dma(snandc, FLASH_BUF_ACC, data_buf, data_size,
>> +					    i == (num_cw - 1) ? NAND_BAM_NO_EOT : 0);
>> +
>> +		if (i == (num_cw - 1)) {
>> +			if (oob_buf) {
>> +				oob_buf += ecc_cfg->bbm_size;
>> +				qcom_write_data_dma(snandc, FLASH_BUF_ACC + data_size,
>> +						    oob_buf, oob_size, 0);
>> +			}
>> +		}
>> +
>> +		qcom_spi_config_cw_write(snandc);
>> +
>> +		if (data_buf)
>> +			data_buf += data_size;
>> +		if (oob_buf)
>> +			oob_buf += oob_size;
>> +	}
>> +
>> +	ret = qcom_submit_descs(snandc);
>> +	if (ret) {
>> +		dev_err(snandc->dev, "failure to write page\n");
>> +		return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static u32 qcom_spi_cmd_mapping(struct qcom_nand_controller *snandc, u32 opcode)
>> +{
>> +	u32 cmd = 0x0;
>> +
>> +	switch (opcode) {
>> +	case SPINAND_RESET:
>> +		cmd = (SPI_WP | SPI_HOLD | SPI_TRANSFER_MODE_x1 | OP_RESET_DEVICE);
>> +		break;
>> +	case SPINAND_READID:
>> +		cmd = (SPI_WP | SPI_HOLD | SPI_TRANSFER_MODE_x1 | OP_FETCH_ID);
>> +		break;
>> +	case SPINAND_GET_FEATURE:
>> +		cmd = (SPI_TRANSFER_MODE_x1 | SPI_WP | SPI_HOLD | ACC_FEATURE);
>> +		break;
>> +	case SPINAND_SET_FEATURE:
>> +		cmd = (SPI_TRANSFER_MODE_x1 | SPI_WP | SPI_HOLD | ACC_FEATURE |
>> +			QPIC_SET_FEATURE);
>> +		break;
>> +	case SPINAND_READ:
>> +		if (snandc->qspi->raw_rw) {
>> +			cmd = (PAGE_ACC | LAST_PAGE | SPI_TRANSFER_MODE_x1 |
>> +					SPI_WP | SPI_HOLD | OP_PAGE_READ);
>> +		} else {
>> +			cmd = (PAGE_ACC | LAST_PAGE | SPI_TRANSFER_MODE_x1 |
>> +					SPI_WP | SPI_HOLD | OP_PAGE_READ_WITH_ECC);
>> +		}
>> +
>> +		break;
>> +	case SPINAND_ERASE:
>> +		cmd = OP_BLOCK_ERASE | PAGE_ACC | LAST_PAGE | SPI_WP |
>> +			SPI_HOLD | SPI_TRANSFER_MODE_x1;
>> +		break;
>> +	case SPINAND_WRITE_EN:
>> +		cmd = SPINAND_WRITE_EN;
>> +		break;
>> +	case SPINAND_PROGRAM_EXECUTE:
>> +		cmd = (PAGE_ACC | LAST_PAGE | SPI_TRANSFER_MODE_x1 |
>> +				SPI_WP | SPI_HOLD | OP_PROGRAM_PAGE);
>> +		break;
>> +	case SPINAND_PROGRAM_LOAD:
>> +		cmd = SPINAND_PROGRAM_LOAD;
>> +		break;
>> +	default:
>> +		dev_err(snandc->dev, "Opcode not supported: %u\n", opcode);
>> +		return -EOPNOTSUPP;
>> +	}
>> +
>> +	return cmd;
>> +}
>> +
>> +static int qcom_spi_write_page_cache(struct qcom_nand_controller *snandc,
>> +				     const struct spi_mem_op *op)
>> +{
>> +	struct qpic_snand_op s_op = {};
>> +	u32 cmd;
>> +
>> +	cmd = qcom_spi_cmd_mapping(snandc, op->cmd.opcode);
> 
> I've asked for switch cases to return an error in case they could not
> handle the request. If you don't check the returned values, it
> does not make any sense.
  Ok, will fix in next patch.
> 
>> +	s_op.cmd_reg = cmd;
>> +
>> +	if (op->cmd.opcode == SPINAND_PROGRAM_LOAD) {
>> +		if (snandc->qspi->page_rw)
>> +			snandc->qspi->data_buf = (u8 *)op->data.buf.out;
> 
> What you do here does not write anything in a page cache.
   No here just updating the buffer , actual write will happen in program_execute.
   This is due to QPIC controller will not take all the instruction one-by-one.
   once we will set CMD_EXEC = 1, then it will execute all the instruction
   at once. So accumulating all the instruction and then executing at once in
   program_execute.
> 
> I also don't understand why you would have to check against the
> SPINAND_PROGRAM_LOAD opcode.
   Because the actual write will happen in program_execute. and here
   PROGRAM_EXECUTE command will also land, so that added the check.
> 
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int qcom_spi_send_cmdaddr(struct qcom_nand_controller *snandc,
>> +				 const struct spi_mem_op *op)
>> +{
>> +	struct qpic_snand_op s_op = {};
>> +	u32 cmd;
>> +	int ret, opcode;
>> +
>> +	cmd = qcom_spi_cmd_mapping(snandc, op->cmd.opcode);
>> +
>> +	s_op.cmd_reg = cmd;
>> +	s_op.addr1_reg = op->addr.val;
>> +	s_op.addr2_reg = 0;
>> +
>> +	opcode = op->cmd.opcode;
>> +
>> +	switch (opcode) {
>> +	case SPINAND_WRITE_EN:
>> +		return 0;
>> +	case SPINAND_PROGRAM_EXECUTE:
>> +		s_op.addr1_reg = op->addr.val << 16;
>> +		s_op.addr2_reg = op->addr.val >> 16 & 0xff;
>> +		snandc->qspi->addr1 = s_op.addr1_reg;
>> +		snandc->qspi->addr2 = s_op.addr2_reg;
>> +		snandc->qspi->cmd = cmd;
>> +		return qcom_spi_program_execute(snandc, op);
>> +	case SPINAND_READ:
>> +		s_op.addr1_reg = (op->addr.val << 16);
>> +		s_op.addr2_reg = op->addr.val >> 16 & 0xff;
>> +		snandc->qspi->addr1 = s_op.addr1_reg;
>> +		snandc->qspi->addr2 = s_op.addr2_reg;
>> +		snandc->qspi->cmd = cmd;
>> +		return 0;
>> +	case SPINAND_ERASE:
>> +		s_op.addr2_reg = (op->addr.val >> 16) & 0xffff;
>> +		s_op.addr1_reg = op->addr.val;
>> +		snandc->qspi->addr1 = (s_op.addr1_reg << 16);
>> +		snandc->qspi->addr2 = s_op.addr2_reg;
>> +		snandc->qspi->cmd = cmd;
>> +		qcom_spi_block_erase(snandc);
>> +		return 0;
>> +	default:
>> +		break;
>> +	}
>> +
>> +	snandc->buf_count = 0;
>> +	snandc->buf_start = 0;
>> +	qcom_clear_read_regs(snandc);
>> +	qcom_clear_bam_transaction(snandc);
>> +
>> +	snandc->regs->cmd = s_op.cmd_reg;
>> +	snandc->regs->exec = 1;
>> +	snandc->regs->addr0 = s_op.addr1_reg;
>> +	snandc->regs->addr1 = s_op.addr2_reg;
>> +
>> +	qcom_write_reg_dma(snandc, &snandc->regs->cmd, NAND_FLASH_CMD, 3, NAND_BAM_NEXT_SGL);
>> +	qcom_write_reg_dma(snandc, &snandc->regs->exec, NAND_EXEC_CMD, 1, NAND_BAM_NEXT_SGL);
>> +
>> +	ret = qcom_submit_descs(snandc);
>> +	if (ret)
>> +		dev_err(snandc->dev, "failure in sbumitting cmd descriptor\n");
> 
> typo
  Ok , will fix in next patch.
> 
>> +
>> +	return ret;
>> +}
>> +
>> +static int qcom_spi_io_op(struct qcom_nand_controller *snandc, const struct spi_mem_op *op)
>> +{
>> +	int ret, val, opcode;
>> +	bool copy = false, copy_ftr = false;
>> +
>> +	ret = qcom_spi_send_cmdaddr(snandc, op);
>> +	if (ret)
>> +		return ret;
>> +
>> +	snandc->buf_count = 0;
>> +	snandc->buf_start = 0;
>> +	qcom_clear_read_regs(snandc);
>> +	qcom_clear_bam_transaction(snandc);
>> +	opcode = op->cmd.opcode;
>> +
>> +	switch (opcode) {
>> +	case SPINAND_READID:
>> +		snandc->buf_count = 4;
>> +		qcom_read_reg_dma(snandc, NAND_READ_ID, 1, NAND_BAM_NEXT_SGL);
>> +		copy = true;
>> +		break;
>> +	case SPINAND_GET_FEATURE:
>> +		snandc->buf_count = 4;
>> +		qcom_read_reg_dma(snandc, NAND_FLASH_FEATURES, 1, NAND_BAM_NEXT_SGL);
>> +		copy_ftr = true;
>> +		break;
>> +	case SPINAND_SET_FEATURE:
>> +		snandc->regs->flash_feature = *(u32 *)op->data.buf.out;
>> +		qcom_write_reg_dma(snandc, &snandc->regs->flash_feature,
>> +				   NAND_FLASH_FEATURES, 1, NAND_BAM_NEXT_SGL);
>> +		break;
>> +	case SPINAND_RESET:
>> +		return 0;
>> +	case SPINAND_PROGRAM_EXECUTE:
>> +		return 0;
>> +	case SPINAND_WRITE_EN:
>> +		return 0;
>> +	case SPINAND_ERASE:
>> +		return 0;
>> +	case SPINAND_READ:
>> +		return 0;
> 
> You can stack the cases
Ok
> 
>> +	default:
>> +		return -EOPNOTSUPP;
>> +	}
>> +
>> +	ret = qcom_submit_descs(snandc);
>> +	if (ret)
>> +		dev_err(snandc->dev, "failure in submitting descriptor for:%d\n", opcode);
>> +
>> +	if (copy) {
>> +		qcom_nandc_dev_to_mem(snandc, true);
>> +		memcpy(op->data.buf.in, snandc->reg_read_buf, snandc->buf_count);
>> +	}
>> +
>> +	if (copy_ftr) {
>> +		qcom_nandc_dev_to_mem(snandc, true);
>> +		val = le32_to_cpu(*(__le32 *)snandc->reg_read_buf);
>> +		val >>= 8;
>> +		memcpy(op->data.buf.in, &val, snandc->buf_count);
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +static bool qcom_spi_is_page_op(const struct spi_mem_op *op)
>> +{
>> +	if (op->addr.buswidth != 1 && op->addr.buswidth != 2 && op->addr.buswidth != 4)
>> +		return false;
>> +
>> +	if (op->data.dir == SPI_MEM_DATA_IN) {
>> +		if (op->addr.buswidth == 4 && op->data.buswidth == 4)
>> +			return true;
>> +
>> +		if (op->addr.nbytes == 2 && op->addr.buswidth == 1)
>> +			return true;
>> +
>> +	} else if (op->data.dir == SPI_MEM_DATA_OUT) {
>> +		if (op->data.buswidth == 4)
>> +			return true;
>> +		if (op->addr.nbytes == 2 && op->addr.buswidth == 1)
>> +			return true;
>> +	}
>> +
>> +	return false;
>> +}
>> +
>> +static bool qcom_spi_supports_op(struct spi_mem *mem, const struct spi_mem_op *op)
>> +{
>> +	if (!spi_mem_default_supports_op(mem, op))
>> +		return false;
>> +
>> +	if (op->cmd.nbytes != 1 || op->cmd.buswidth != 1)
>> +		return false;
>> +
>> +	if (qcom_spi_is_page_op(op))
>> +		return true;
>> +
>> +	return ((!op->addr.nbytes || op->addr.buswidth == 1) &&
>> +		(!op->dummy.nbytes || op->dummy.buswidth == 1) &&
>> +		(!op->data.nbytes || op->data.buswidth == 1));
>> +}
>> +
>> +static int qcom_spi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
>> +{
>> +	struct qcom_nand_controller *snandc = spi_controller_get_devdata(mem->spi->controller);
>> +
>> +	dev_dbg(snandc->dev, "OP %02x ADDR %08llX@%d:%u DATA %d:%u", op->cmd.opcode,
>> +		op->addr.val, op->addr.buswidth, op->addr.nbytes,
>> +		op->data.buswidth, op->data.nbytes);
>> +
>> +	if (qcom_spi_is_page_op(op)) {
>> +		if (op->data.dir == SPI_MEM_DATA_IN)
>> +			return qcom_spi_read_page_cache(snandc, op);
>> +		if (op->data.dir == SPI_MEM_DATA_OUT)
>> +			return qcom_spi_write_page_cache(snandc, op);
>> +	} else {
>> +		return qcom_spi_io_op(snandc, op);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct spi_controller_mem_ops qcom_spi_mem_ops = {
>> +	.supports_op = qcom_spi_supports_op,
>> +	.exec_op = qcom_spi_exec_op,
>> +};
>> +
>> +static const struct spi_controller_mem_caps qcom_spi_mem_caps = {
>> +	.ecc = true,
>> +};
>> +
>> +static int qcom_spi_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct spi_controller *ctlr;
>> +	struct qcom_nand_controller *snandc;
>> +	struct qpic_spi_nand *qspi;
>> +	struct qpic_ecc *ecc;
>> +	struct resource *res;
>> +	const void *dev_data;
>> +	int ret;
>> +
>> +	ecc = devm_kzalloc(dev, sizeof(*ecc), GFP_KERNEL);
>> +	if (!ecc)
>> +		return -ENOMEM;
>> +
>> +	qspi = devm_kzalloc(dev, sizeof(*qspi), GFP_KERNEL);
>> +	if (!qspi)
>> +		return -ENOMEM;
>> +
>> +	ctlr = __devm_spi_alloc_controller(dev, sizeof(*snandc), false);
>> +	if (!ctlr)
>> +		return -ENOMEM;
>> +
>> +	platform_set_drvdata(pdev, ctlr);
>> +
>> +	snandc = spi_controller_get_devdata(ctlr);
>> +	qspi->snandc = snandc;
>> +
>> +	snandc->dev = dev;
>> +	snandc->qspi = qspi;
>> +	snandc->qspi->ctlr = ctlr;
>> +	snandc->qspi->ecc = ecc;
>> +
>> +	snandc->qspi->oob_buf = devm_kzalloc(dev, OOB_BUF_SIZE, GFP_KERNEL);
>> +	if (!snandc->qspi->oob_buf)
>> +		return -ENOMEM;
>> +
>> +	dev_data = of_device_get_match_data(dev);
>> +	if (!dev_data) {
>> +		dev_err(&pdev->dev, "failed to get device data\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	snandc->props = dev_data;
>> +	snandc->dev = &pdev->dev;
>> +
>> +	snandc->core_clk = devm_clk_get(dev, "core");
>> +	if (IS_ERR(snandc->core_clk))
>> +		return PTR_ERR(snandc->core_clk);
>> +
>> +	snandc->aon_clk = devm_clk_get(dev, "aon");
>> +	if (IS_ERR(snandc->aon_clk))
>> +		return PTR_ERR(snandc->aon_clk);
>> +
>> +	snandc->qspi->iomacro_clk = devm_clk_get(dev, "iom");
>> +	if (IS_ERR(snandc->qspi->iomacro_clk))
>> +		return PTR_ERR(snandc->qspi->iomacro_clk);
>> +
>> +	snandc->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
>> +	if (IS_ERR(snandc->base))
>> +		return PTR_ERR(snandc->base);
>> +
>> +	snandc->base_phys = res->start;
>> +	snandc->base_dma = dma_map_resource(dev, res->start, resource_size(res),
>> +					    DMA_BIDIRECTIONAL, 0);
>> +	if (dma_mapping_error(dev, snandc->base_dma))
>> +		return -ENXIO;
>> +
>> +	ret = clk_prepare_enable(snandc->core_clk);
>> +	if (ret)
>> +		goto err_core_clk;
> 
> Again, the label is better named when it describes what it point at,
> rather than where it comes from.
Ok
> 
>> +
>> +	ret = clk_prepare_enable(snandc->aon_clk);
>> +	if (ret)
>> +		goto err_aon_clk;
>> +
>> +	ret = clk_prepare_enable(snandc->qspi->iomacro_clk);
>> +	if (ret)
>> +		goto err_dis_iom_clk;
>> +
>> +	ret = qcom_nandc_alloc(snandc);
>> +	if (ret)
>> +		goto err_snand_alloc;
>> +
>> +	ret = qcom_spi_init(snandc);
>> +	if (ret)
>> +		goto err_init;
>> +
>> +	/* setup ECC engine */
>> +	snandc->qspi->ecc_eng.dev = &pdev->dev;
>> +	snandc->qspi->ecc_eng.integration = NAND_ECC_ENGINE_INTEGRATION_PIPELINED;
>> +	snandc->qspi->ecc_eng.ops = &qcom_spi_ecc_engine_ops_pipelined;
>> +	snandc->qspi->ecc_eng.priv = snandc;
>> +
>> +	ret = nand_ecc_register_on_host_hw_engine(&snandc->qspi->ecc_eng);
>> +	if (ret) {
>> +		dev_err(&pdev->dev, "failed to register ecc engine:%d\n", ret);
>> +		goto err_init;
>> +	}
>> +
>> +	ctlr->num_chipselect = QPIC_QSPI_NUM_CS;
>> +	ctlr->mem_ops = &qcom_spi_mem_ops;
>> +	ctlr->mem_caps = &qcom_spi_mem_caps;
>> +	ctlr->dev.of_node = pdev->dev.of_node;
>> +	ctlr->mode_bits = SPI_TX_DUAL | SPI_RX_DUAL |
>> +			    SPI_TX_QUAD | SPI_RX_QUAD;
>> +
>> +	ret = spi_register_controller(ctlr);
>> +	if (ret) {
>> +		dev_err(&pdev->dev, "spi_register_controller failed.\n");
>> +		goto err_init;
>> +	}
>> +
>> +	return 0;
>> +
>> +err_init:
>> +	qcom_nandc_unalloc(snandc);
> 
> Same: s/unalloc/free|cleanup/
Ok
> 
>> +err_snand_alloc:
>> +	clk_disable_unprepare(snandc->qspi->iomacro_clk);
>> +err_dis_iom_clk:
>> +	clk_disable_unprepare(snandc->aon_clk);
>> +err_aon_clk:
>> +	clk_disable_unprepare(snandc->core_clk);
>> +err_core_clk:
>> +	dma_unmap_resource(dev, res->start, resource_size(res),
>> +			   DMA_BIDIRECTIONAL, 0);
>> +	return ret;
>> +}
> 
> Thanks,
> Miquèl

