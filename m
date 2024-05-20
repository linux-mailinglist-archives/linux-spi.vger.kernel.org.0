Return-Path: <linux-spi+bounces-2954-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 833AB8C9AFC
	for <lists+linux-spi@lfdr.de>; Mon, 20 May 2024 12:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80D8D1C20AFF
	for <lists+linux-spi@lfdr.de>; Mon, 20 May 2024 10:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C914D58A;
	Mon, 20 May 2024 10:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NuYVPV0q"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FBB4C624;
	Mon, 20 May 2024 10:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716199706; cv=none; b=DgvQhYFmuwDoMGHCMo+/kUIXnQmU1NhEC1AumLiRfdslJycTLrFTTzSR4KdDED5o070KPFrrb0VbvuHLHo8yZT1uBRcZuOt7uBOryWKMrky7Xz5wOi3OrVQgsuPe2GGrXFfFayu85gB0D2MrrlVMDvbxH9oI/r/LEZcAGLjms60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716199706; c=relaxed/simple;
	bh=mMgqJNj+JOQz+7GZZyd3VngxWpJT/9GaQ60cUFGsj6M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=knweowvWGN+LcLCQ3lf1kXtfIkLuOOyYcESsl9RCeGu5VdFTtvHLosnGLjFhpJHL5dWZwt9fwQXpZQWzI0QS6/3fa+X9ceJ1oX8Ii2+Cy7ECRZTac+JZlTL79AGMj+wMPkOsGb4/VGCeey9n56AP06RgwGP+AF7655338zdjOt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=NuYVPV0q; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44JMbHb5015032;
	Mon, 20 May 2024 10:08:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=gsCnFxTVhA+gptV68Sl5X9SSCUgXiTgmQB0q8lUzqsI=; b=Nu
	YVPV0qel33VVvRjSSoSspZMlNlUv+2MuHWedabXkc1KvFpLNqqFN5kP03IFRbeE7
	6cjgAvdZL9AeBpthRZa+Lunl12ecZ18IXDJLbSt8wxs4Wt9RnFpyv9hByIxQFB5F
	cmlHgHib/xmQpx36eekVey6jQFK/GnD8R1w6Kkeommpsu5B65nudFjJOlBybxuyk
	GKZwHQEb4u7Yw+Nhf7GlGBg8RcKeaUoN4NDGDcJ+0VG8oSxGsSdBt/7Bum0jyv2S
	iCQ5hytF2V4M1IJhQVQ1vN7X/izkfuOCrG7e9O7OBs0Dphh+Bgd5xnkrvqSz9lUe
	RJvqqWk2zL+b08jijS2g==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y6n3w38xv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 May 2024 10:08:05 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44KA84S3003096
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 May 2024 10:08:04 GMT
Received: from [10.216.4.5] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 20 May
 2024 03:07:58 -0700
Message-ID: <434590e3-9298-dde9-f527-6596dbd1952b@quicinc.com>
Date: Mon, 20 May 2024 15:37:54 +0530
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
From: Md Sadre Alam <quic_mdalam@quicinc.com>
In-Reply-To: <20240516145642.644a7f1c@xps-13>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: f48U-6bfoaQq4DfYUlFnzsGlNU7eb-z2
X-Proofpoint-GUID: f48U-6bfoaQq4DfYUlFnzsGlNU7eb-z2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-20_05,2024-05-17_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 phishscore=0 clxscore=1015 mlxlogscore=999 suspectscore=0
 spamscore=0 bulkscore=0 mlxscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405200084



On 5/16/2024 6:26 PM, Miquel Raynal wrote:
> Hi,
> 
>> --- /dev/null
>> +++ b/drivers/spi/spi-qpic-snand.c
>> @@ -0,0 +1,1423 @@
>> +/*
>> + * SPDX-License-Identifier: GPL-2.0
>> + *
>> + * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
>> + *
>> + * Authors:
>> + *	Md Sadre Alam <quic_mdalam@quicinc.com>
>> + *	Sricharan R <quic_srichara@quicinc.com>
>> + *	Varadarajan Narayanan <quic_varada@quicinc.com>
>> + */
>> +#include <linux/bitops.h>
>> +#include <linux/clk.h>
>> +#include <linux/delay.h>
>> +#include <linux/dmaengine.h>
>> +#include <linux/dma-mapping.h>
>> +#include <linux/dma/qcom_adm.h>
>> +#include <linux/dma/qcom_bam_dma.h>
>> +#include <linux/module.h>
>> +#include <linux/mtd/partitions.h>
> 
> Not sure why partitions.h is needed here?
Will remove in next patch
> 
>> +#include <linux/mtd/rawnand.h>
> 
> No raw NAND include.
Ok
> 
>> +#include <linux/of.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/slab.h>
>> +#include <linux/mtd/nand-qpic-common.h>
>> +#include <linux/mtd/spinand.h>
> 
> ...
> 
>> +static int qcom_spi_ecc_init_ctx_pipelined(struct nand_device *nand)
>> +{
>> +	struct qcom_nand_controller *snandc = nand_to_qcom_snand(nand);
>> +	struct nand_ecc_props *conf = &nand->ecc.ctx.conf;
>> +	struct nand_ecc_props *reqs = &nand->ecc.requirements;
>> +	struct nand_ecc_props *user = &nand->ecc.user_conf;
>> +	struct mtd_info *mtd = nanddev_to_mtd(nand);
>> +	int step_size = 0, strength = 0, steps;
>> +	int cwperpage, bad_block_byte;
>> +	struct qpic_ecc *ecc_cfg;
>> +
>> +	cwperpage = mtd->writesize / NANDC_STEP_SIZE;
>> +	snandc->num_cw = cwperpage;
>> +
>> +	ecc_cfg = kzalloc(sizeof(*ecc_cfg), GFP_KERNEL);
>> +	if (!ecc_cfg)
>> +		return -ENOMEM;
>> +
>> +	nand->ecc.ctx.priv = ecc_cfg;
>> +
>> +	if (user->step_size && user->strength) {
>> +		step_size = user->step_size;
>> +		strength = user->strength;
>> +	} else if (reqs->step_size && reqs->strength) {
>> +		step_size = reqs->step_size;
>> +		strength = reqs->strength;
>> +	}
>> +
>> +	if (step_size && strength)
>> +		steps = mtd->writesize / step_size;
>> +
>> +	ecc_cfg->ecc_bytes_hw = 7;
>> +	ecc_cfg->spare_bytes = 4;
>> +	ecc_cfg->bbm_size = 1;
>> +	ecc_cfg->bch_enabled = true;
>> +	ecc_cfg->bytes = ecc_cfg->ecc_bytes_hw + ecc_cfg->spare_bytes + ecc_cfg->bbm_size;
>> +
>> +	ecc_cfg->steps = 4;
>> +	ecc_cfg->strength = 4;
>> +	ecc_cfg->step_size = 512;
>> +
>> +	mtd_set_ooblayout(mtd, &qcom_spi_ooblayout);
>> +
>> +	ecc_cfg->cw_data = 516;
>> +	ecc_cfg->cw_size = ecc_cfg->cw_data + ecc_cfg->bytes;
>> +	bad_block_byte = mtd->writesize - ecc_cfg->cw_size * (cwperpage - 1) + 1;
>> +
>> +	ecc_cfg->cfg0 = (cwperpage - 1) << CW_PER_PAGE
>> +				| ecc_cfg->cw_data << UD_SIZE_BYTES
>> +				| 1 << DISABLE_STATUS_AFTER_WRITE
>> +				| 3 << NUM_ADDR_CYCLES
>> +				| ecc_cfg->ecc_bytes_hw << ECC_PARITY_SIZE_BYTES_RS
>> +				| 0 << STATUS_BFR_READ
>> +				| 1 << SET_RD_MODE_AFTER_STATUS
>> +				| ecc_cfg->spare_bytes << SPARE_SIZE_BYTES;
> 
> Can we please use FIELD_GET/FIELD_SET?
> 
> Also I think the coding style proposes:
> 
> 	val = foo |
> 	      bar;
> 
> instead of
> 
> 	val = foo
> 	 	| bar;
> 
Ok, Will fix in next patch.
> 
> ...
> 
>> +static int qcom_spi_write_page_cache(struct qcom_nand_controller *snandc,
>> +				     const struct spi_mem_op *op)
>> +{
>> +	struct qpic_snand_op s_op = {};
>> +	u32 cmd;
>> +
>> +	cmd = qcom_spi_cmd_mapping(snandc, op->cmd.opcode);
>> +	s_op.cmd_reg = cmd;
>> +
>> +	if (op->cmd.opcode == SPINAND_PROGRAM_LOAD) {
>> +		if (snandc->page_rw)
>> +			snandc->data_buf = (u8 *)op->data.buf.out;
>> +		if (snandc->oob_rw)
>> +			snandc->oob_buf = (u8 *)op->data.buf.out;
> 
> Quick comment: looks wrong, no?
Yes , oob_buf not needed here. will fix in next patch.
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
>> +		snandc->addr1 = s_op.addr1_reg;
>> +		snandc->addr2 = s_op.addr2_reg;
>> +		snandc->cmd = cmd;
>> +		return qcom_spi_program_execute(snandc, op);
>> +	case SPINAND_READ:
>> +		s_op.addr1_reg = (op->addr.val << 16);
>> +		s_op.addr2_reg = op->addr.val >> 16 & 0xff;
>> +		snandc->addr1 = s_op.addr1_reg;
>> +		snandc->addr2 = s_op.addr2_reg;
>> +		snandc->cmd = cmd;
>> +		return 0;
>> +	case SPINAND_ERASE:
>> +		s_op.addr2_reg = (op->addr.val >> 16) & 0xffff;
>> +		s_op.addr1_reg = op->addr.val;
>> +		snandc->addr1 = s_op.addr1_reg;
>> +		snandc->addr1 <<= 16;
> 
> Feels wrong as well
Ok , will fix in next patch.
> 
>> +		snandc->addr2 = s_op.addr2_reg;
>> +		snandc->cmd = cmd;
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
>> +	default:
>> +		return 0;
> 
> No error state?
   We can't return return error here , since this API is not for checking supported command.
   We can return error only if we submitted the descriptor. That already we are handling.
> 
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
>> +	struct resource *res;
>> +	const void *dev_data;
>> +	struct qpic_ecc *ecc;
>> +	int ret;
>> +
>> +	ecc = devm_kzalloc(dev, sizeof(*ecc), GFP_KERNEL);
>> +	if (!ecc)
>> +		return -ENOMEM;
>> +
>> +	ctlr = __devm_spi_alloc_controller(dev, sizeof(*snandc), false);
>> +	if (!ctlr)
>> +		return -ENOMEM;
>> +
>> +	platform_set_drvdata(pdev, ctlr);
>> +
>> +	snandc = spi_controller_get_devdata(ctlr);
>> +
>> +	snandc->ctlr = ctlr;
>> +	snandc->dev = dev;
>> +	snandc->ecc = ecc;
>> +
>> +	snandc->oob_buf = devm_kzalloc(dev, OOB_BUF_SIZE, GFP_KERNEL);
>> +	if (!snandc->oob_buf)
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
>> +	snandc->iomacro_clk = devm_clk_get(dev, "iom");
>> +	if (IS_ERR(snandc->iomacro_clk))
>> +		return PTR_ERR(snandc->iomacro_clk);
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
> error labels should point at the next freeing instruction, they should
> not be named against where they are called.
  Ok
> 
> Same below.
  Ok
> 
>> +
>> +	ret = clk_prepare_enable(snandc->aon_clk);
>> +	if (ret)
>> +		goto err_aon_clk;
>> +
>> +	ret = clk_prepare_enable(snandc->iomacro_clk);
>> +	if (ret)
>> +		goto err_snandc_alloc;
> 
> This label is really badly named
  Ok
> 
>> +
>> +	ret = qcom_nandc_alloc(snandc);
>> +	if (ret)
>> +		goto err_iom_clk;
> 
> 		goto err_dis_iom_clk; ?
  OK
> 
>> +
>> +	ret = qcom_spi_init(snandc);
>> +	if (ret)
>> +		goto err_init;
>> +
>> +	/* setup ECC engine */
>> +	snandc->ecc_eng.dev = &pdev->dev;
>> +	snandc->ecc_eng.integration = NAND_ECC_ENGINE_INTEGRATION_PIPELINED;
>> +	snandc->ecc_eng.ops = &qcom_spi_ecc_engine_ops_pipelined;
>> +	snandc->ecc_eng.priv = snandc;
>> +
>> +	ret = nand_ecc_register_on_host_hw_engine(&snandc->ecc_eng);
>> +	if (ret) {
>> +		dev_err(&pdev->dev, "failed to register ecc engine.\n");
> 
> Maybe you can print the error if we want the dev_err() call to be
> useful?
  Ok
> 
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
>> +err_iom_clk:
>> +	clk_disable_unprepare(snandc->iomacro_clk);
>> +err_snandc_alloc:
>> +	clk_disable_unprepare(snandc->aon_clk);
>> +err_aon_clk:
>> +	clk_disable_unprepare(snandc->core_clk);
>> +err_core_clk:
>> +	dma_unmap_resource(dev, res->start, resource_size(res),
>> +			   DMA_BIDIRECTIONAL, 0);
>> +	return ret;
>> +}
>> +
>> +static int qcom_spi_remove(struct platform_device *pdev)
>> +{
>> +	struct spi_controller *ctlr = platform_get_drvdata(pdev);
>> +	struct qcom_nand_controller *snandc = spi_controller_get_devdata(ctlr);
>> +	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +
>> +	spi_unregister_controller(ctlr);
>> +
>> +	clk_disable_unprepare(snandc->aon_clk);
>> +	clk_disable_unprepare(snandc->core_clk);
>> +	clk_disable_unprepare(snandc->iomacro_clk);
>> +
>> +	dma_unmap_resource(&pdev->dev, snandc->base_dma, resource_size(res),
>> +			   DMA_BIDIRECTIONAL, 0);
> 
> No unalloc?
> 
> BTW unalloc is a bit weird. "free" or "cleanup" might be better.
  We are having a existing api called qcom_nandc_unalloc() , will use the same in
  next patch.
> 
>> +	return 0;
>> +}
>> +
>> +static const struct qcom_nandc_props ipq9574_snandc_props = {
>> +	.dev_cmd_reg_start = 0x7000,
>> +	.supports_bam = true,
>> +};
>> +
>> +static const struct of_device_id qcom_snandc_of_match[] = {
>> +	{
>> +		.compatible = "qcom,spi-qpic-snand",
>> +		.data = &ipq9574_snandc_props,
>> +	},
>> +	{}
>> +}
>> +MODULE_DEVICE_TABLE(of, qcom_snandc_of_match);
>> +
>> +static struct platform_driver qcom_spi_driver = {
>> +	.driver = {
>> +		.name		= "qcom_snand",
>> +		.of_match_table = qcom_snandc_of_match,
>> +	},
>> +	.probe = qcom_spi_probe,
>> +	.remove = qcom_spi_remove,
>> +};
>> +module_platform_driver(qcom_spi_driver);
>> +
>> +MODULE_DESCRIPTION("SPI driver for QPIC QSPI cores");
>> +MODULE_AUTHOR("Md Sadre Alam <quic_mdalam@quicinc.com>");
>> +MODULE_LICENSE("GPL");
>> diff --git a/include/linux/mtd/nand-qpic-common.h b/include/linux/mtd/nand-qpic-common.h
>> index 096c15d3be76..dd2b56125bc1 100644
>> --- a/include/linux/mtd/nand-qpic-common.h
>> +++ b/include/linux/mtd/nand-qpic-common.h
>> @@ -315,11 +315,56 @@ struct nandc_regs {
>>   	__le32 read_location_last1;
>>   	__le32 read_location_last2;
>>   	__le32 read_location_last3;
>> +	__le32 spi_cfg;
>> +	__le32 num_addr_cycle;
>> +	__le32 busy_wait_cnt;
>> +	__le32 flash_feature;
>>   
>>   	__le32 erased_cw_detect_cfg_clr;
>>   	__le32 erased_cw_detect_cfg_set;
>>   };
>>   
>> +/*
>> + * ECC state struct
>> + * @corrected:		ECC corrected
>> + * @bitflips:		Max bit flip
>> + * @failed:		ECC failed
>> + */
>> +struct qcom_ecc_stats {
>> +	u32 corrected;
>> +	u32 bitflips;
>> +	u32 failed;
>> +};
>> +
>> +struct qpic_ecc {
>> +	struct device *dev;
>> +	const struct qpic_ecc_caps *caps;
>> +	struct completion done;
>> +	u32 sectors;
>> +	u8 *eccdata;
>> +	bool use_ecc;
>> +	u32 ecc_modes;
>> +	int ecc_bytes_hw;
>> +	int spare_bytes;
>> +	int bbm_size;
>> +	int ecc_mode;
>> +	int bytes;
>> +	int steps;
>> +	int step_size;
>> +	int strength;
>> +	int cw_size;
>> +	int cw_data;
>> +	u32 cfg0, cfg1;
>> +	u32 cfg0_raw, cfg1_raw;
>> +	u32 ecc_buf_cfg;
>> +	u32 ecc_bch_cfg;
>> +	u32 clrflashstatus;
>> +	u32 clrreadstatus;
>> +	bool bch_enabled;
>> +};
>> +
>> +struct qpic_ecc;
>> +
>>   /*
>>    * NAND controller data struct
>>    *
>> @@ -329,6 +374,7 @@ struct nandc_regs {
>>    *
>>    * @core_clk:			controller clock
>>    * @aon_clk:			another controller clock
>> + * @iomacro_clk:		io macro clock
>>    *
>>    * @regs:			a contiguous chunk of memory for DMA register
>>    *				writes. contains the register values to be
>> @@ -338,6 +384,7 @@ struct nandc_regs {
>>    *				initialized via DT match data
>>    *
>>    * @controller:			base controller structure
>> + * @ctlr:			spi controller structure
>>    * @host_list:			list containing all the chips attached to the
>>    *				controller
>>    *
>> @@ -375,6 +422,7 @@ struct qcom_nand_controller {
>>   
>>   	struct clk *core_clk;
>>   	struct clk *aon_clk;
>> +	struct clk *iomacro_clk;
>>   
>>   	struct nandc_regs *regs;
>>   	struct bam_transaction *bam_txn;
>> @@ -382,6 +430,7 @@ struct qcom_nand_controller {
>>   	const struct qcom_nandc_props *props;
>>   
>>   	struct nand_controller controller;
>> +	struct spi_controller *ctlr;
>>   	struct list_head host_list;
>>   
>>   	union {
>> @@ -418,6 +467,21 @@ struct qcom_nand_controller {
>>   
>>   	u32 cmd1, vld;
>>   	bool exec_opwrite;
>> +	struct qpic_ecc *ecc;
>> +	struct qcom_ecc_stats ecc_stats;
>> +	struct nand_ecc_engine ecc_eng;
>> +	u8 *data_buf;
>> +	u8 *oob_buf;
>> +	u32 wlen;
>> +	u32 addr1;
>> +	u32 addr2;
>> +	u32 cmd;
>> +	u32 num_cw;
>> +	u32 pagesize;
>> +	bool oob_rw;
>> +	bool page_rw;
>> +	bool raw_rw;
>> +	bool read_last_cw;
>>   };
> 
> If all these definitions are only used by the spi controller, I don't
> see why you want to put them in the common file.
  We are using qcom_nand_controller{..} structure as common b/w raw nand
  and spi nand. These all variables will be used by spi nand only , but
  qcom_nand_controller structure is passed across all the SPI API, thats
  why define these all variables inside qcom_nand_controller structure.
  so that i can access directlty.
> 
> Thanks,
> Miquèl

