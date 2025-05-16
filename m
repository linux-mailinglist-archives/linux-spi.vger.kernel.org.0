Return-Path: <linux-spi+bounces-8146-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 603ADAB976C
	for <lists+linux-spi@lfdr.de>; Fri, 16 May 2025 10:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A4254E647B
	for <lists+linux-spi@lfdr.de>; Fri, 16 May 2025 08:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87AEE22D4DB;
	Fri, 16 May 2025 08:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OUbyQ1t+"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80398225A40;
	Fri, 16 May 2025 08:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747383644; cv=none; b=dEOjOWf/Bfw9h05bIvqvr83BPy9i/HsipcJmuPYbLSsDuNds015vC/8wo+tCad7gRWzn8/ta/6D6JYu36CZXl/TkMa9A1AdHt2518VMKFq395WTFBDutljn5pjdjZ9iW1NEEtEVAe77rpuRRFl0fB0zn2VoLux1yuB5iaAKRcR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747383644; c=relaxed/simple;
	bh=4KxDsjfmuWwumtBSQpxtMjShXqpffTu9yrvlxS6EKGk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Hm0tAfFDW8pteF3vtuAfOGrdKxQYH24/k3xiOotl3EBC7/cnopVcQ+9POaNk+ncx/6kgzsed9mYkf0Ed+KqYnHhmVccwkxGM9jG3vQpbOEnAIuPN4nmnoOXiaoygvNJ3O+LfLGglb7tTP158p6fmu3Ui7fQS6cx4Slc4YP4ODvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OUbyQ1t+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54G38k3p018185;
	Fri, 16 May 2025 08:20:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TAtG8onWHzVbtQpTvV5KpBDQBOr77n6vrrRyZgC1p7I=; b=OUbyQ1t+oEovg1bI
	jZLYkvLCQynJJpgDoylma9QKO75UvYkmxgrGQ3gn3ELy+yLgYp+/jUQ6KbNwHRzL
	gycMZZahvawUvOnctmlxrfZeWITkRDYOh7J5i1RCHCxBgATxhPRgO5BriCnsttbK
	wvHujTVnd/9Hq7e7RX67MVY/BXPkhe3/OhqLADkIquC6w5CRXH/NYZwfOp8mgBU2
	Tw1qX1Iu+HLUVL49dRYuPxtIxh1cQllaLYhv15U18kwiXGY6fC0xDnUjumhVLU3l
	Vq9W9CpCOPzRAWwyTlTM1NLDkeVK7MMagpsu50qof6KnqRgeVTGGzmCM4rvPPm+U
	kSJegg==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46mbcns6a2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 May 2025 08:20:33 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54G8KWHD026533
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 May 2025 08:20:32 GMT
Received: from [10.151.36.184] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 16 May
 2025 01:20:29 -0700
Message-ID: <ee487379-0aab-d2ac-eb24-d38a0b3805ef@quicinc.com>
Date: Fri, 16 May 2025 13:50:17 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 1/2] spi: spi-qpic-snand: use CW_PER_PAGE_MASK bitmask
Content-Language: en-US
To: Gabor Juhos <j4g8y7@gmail.com>, Mark Brown <broonie@kernel.org>
CC: Varadarajan Narayanan <quic_varada@quicinc.com>,
        Sricharan Ramabadhran
	<quic_srichara@quicinc.com>,
        <linux-spi@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20250515-qpic-snand-use-bitmasks-v1-0-11729aeae73b@gmail.com>
 <20250515-qpic-snand-use-bitmasks-v1-1-11729aeae73b@gmail.com>
From: Md Sadre Alam <quic_mdalam@quicinc.com>
In-Reply-To: <20250515-qpic-snand-use-bitmasks-v1-1-11729aeae73b@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: U4FXvq5EHSmoxfcHHbYDYzz3c4KEsJEH
X-Authority-Analysis: v=2.4 cv=aIbwqa9m c=1 sm=1 tr=0 ts=6826f551 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=pGLkceISAAAA:8
 a=COk6AnOGAAAA:8 a=llW5jWN4sgg2yBcSlIUA:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: U4FXvq5EHSmoxfcHHbYDYzz3c4KEsJEH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE2MDA3NyBTYWx0ZWRfX9bXDlppfeXMx
 VAzR9C8b8eak5YA6TuuJuqW0hY142k0Wf/ebVHUAf0HAtGqnspmXauA3vpjbKABgDL/rv1hvgww
 FgWc3Ad/UcZWHqrCHPK/4bO4w+FfIhvSe5CIUB9zLR9gNSIXoT3jbELQOiljKICKKYlRKeGcdn9
 GGPM6I0F7pHXBVr57xVs5WQVU2OzeIQwggv+vQpx6e8nwRmHn5Wlzw6I1vIO97VGJCHWDa+IRWG
 2nFrkoHwAJLOrM0jUHn0dkJupIcikDaUlJMi1eoqKS9FwI0xyIpguF93zQtNfBI52FhZaJoO2nx
 CeDq0j78s7U4Eycla5pX7wLlIQMd1tA7fmSr3LXfrf0GEcliOqfCZGqZXriN2P6JeBWb+CXpBKN
 vHo4FfhdQqNR+tME7sAKjGL9+bm6ZdVBgwaPmM0C6w/a85wDqwnmi8qlMOrT0RkHDNsYCCGc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-16_03,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0 impostorscore=0
 clxscore=1015 phishscore=0 suspectscore=0 mlxscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505070000 definitions=main-2505160077



On 5/16/2025 12:28 AM, Gabor Juhos wrote:
> Change the code to use the already defined CW_PER_PAGE_MASK
> bitmask along with the FIELD_PREP() macro instead of using
> magic values.
> 
> This makes the code more readable. It also syncs the affected
> codes with their counterparts in the 'qcom_nandc' driver, so it
> makes it easier to spot the differences between the two
> implementations.
> 
> No functional changes intended.
> 
> Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
> ---
>   drivers/spi/spi-qpic-snand.c | 31 ++++++++++++++++---------------
>   1 file changed, 16 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/spi/spi-qpic-snand.c b/drivers/spi/spi-qpic-snand.c
> index 7207bbb57802ce53dfab4d9689113e7f9ba8f131..bc45b834fadc5456eda1fe778e5ca8b16177465e 100644
> --- a/drivers/spi/spi-qpic-snand.c
> +++ b/drivers/spi/spi-qpic-snand.c
> @@ -483,7 +483,8 @@ static int qcom_spi_block_erase(struct qcom_nand_controller *snandc)
>   	snandc->regs->cmd = snandc->qspi->cmd;
>   	snandc->regs->addr0 = snandc->qspi->addr1;
>   	snandc->regs->addr1 = snandc->qspi->addr2;
> -	snandc->regs->cfg0 = cpu_to_le32(ecc_cfg->cfg0_raw & ~(7 << CW_PER_PAGE));
> +	snandc->regs->cfg0 = cpu_to_le32((ecc_cfg->cfg0_raw & ~CW_PER_PAGE_MASK) |
> +					 FIELD_PREP(CW_PER_PAGE_MASK, 0));
>   	snandc->regs->cfg1 = cpu_to_le32(ecc_cfg->cfg1_raw);
>   	snandc->regs->exec = cpu_to_le32(1);
>   
> @@ -544,8 +545,8 @@ static int qcom_spi_read_last_cw(struct qcom_nand_controller *snandc,
>   	snandc->regs->addr0 = (snandc->qspi->addr1 | cpu_to_le32(col));
>   	snandc->regs->addr1 = snandc->qspi->addr2;
>   
> -	cfg0 = (ecc_cfg->cfg0_raw & ~(7U << CW_PER_PAGE)) |
> -		0 << CW_PER_PAGE;
> +	cfg0 = (ecc_cfg->cfg0_raw & ~CW_PER_PAGE_MASK) |
> +	       FIELD_PREP(CW_PER_PAGE_MASK, 0);
>   	cfg1 = ecc_cfg->cfg1_raw;
>   	ecc_bch_cfg = ECC_CFG_ECC_DISABLE;
>   
> @@ -687,8 +688,8 @@ static int qcom_spi_read_cw_raw(struct qcom_nand_controller *snandc, u8 *data_bu
>   	qcom_clear_bam_transaction(snandc);
>   	raw_cw = num_cw - 1;
>   
> -	cfg0 = (ecc_cfg->cfg0_raw & ~(7U << CW_PER_PAGE)) |
> -				0 << CW_PER_PAGE;
> +	cfg0 = (ecc_cfg->cfg0_raw & ~CW_PER_PAGE_MASK) |
> +	       FIELD_PREP(CW_PER_PAGE_MASK, 0);
>   	cfg1 = ecc_cfg->cfg1_raw;
>   	ecc_bch_cfg = ECC_CFG_ECC_DISABLE;
>   
> @@ -808,8 +809,8 @@ static int qcom_spi_read_page_ecc(struct qcom_nand_controller *snandc,
>   	snandc->buf_start = 0;
>   	qcom_clear_read_regs(snandc);
>   
> -	cfg0 = (ecc_cfg->cfg0 & ~(7U << CW_PER_PAGE)) |
> -				(num_cw - 1) << CW_PER_PAGE;
> +	cfg0 = (ecc_cfg->cfg0 & ~CW_PER_PAGE_MASK) |
> +	       FIELD_PREP(CW_PER_PAGE_MASK, num_cw - 1);
>   	cfg1 = ecc_cfg->cfg1;
>   	ecc_bch_cfg = ecc_cfg->ecc_bch_cfg;
>   
> @@ -904,8 +905,8 @@ static int qcom_spi_read_page_oob(struct qcom_nand_controller *snandc,
>   	qcom_clear_read_regs(snandc);
>   	qcom_clear_bam_transaction(snandc);
>   
> -	cfg0 = (ecc_cfg->cfg0 & ~(7U << CW_PER_PAGE)) |
> -				(num_cw - 1) << CW_PER_PAGE;
> +	cfg0 = (ecc_cfg->cfg0 & ~CW_PER_PAGE_MASK) |
> +	       FIELD_PREP(CW_PER_PAGE_MASK, num_cw - 1);
>   	cfg1 = ecc_cfg->cfg1;
>   	ecc_bch_cfg = ecc_cfg->ecc_bch_cfg;
>   
> @@ -1015,8 +1016,8 @@ static int qcom_spi_program_raw(struct qcom_nand_controller *snandc,
>   	int num_cw = snandc->qspi->num_cw;
>   	u32 cfg0, cfg1, ecc_bch_cfg;
>   
> -	cfg0 = (ecc_cfg->cfg0_raw & ~(7U << CW_PER_PAGE)) |
> -			(num_cw - 1) << CW_PER_PAGE;
> +	cfg0 = (ecc_cfg->cfg0_raw & ~CW_PER_PAGE_MASK) |
> +	       FIELD_PREP(CW_PER_PAGE_MASK, num_cw - 1);
>   	cfg1 = ecc_cfg->cfg1_raw;
>   	ecc_bch_cfg = ECC_CFG_ECC_DISABLE;
>   
> @@ -1098,8 +1099,8 @@ static int qcom_spi_program_ecc(struct qcom_nand_controller *snandc,
>   	int num_cw = snandc->qspi->num_cw;
>   	u32 cfg0, cfg1, ecc_bch_cfg, ecc_buf_cfg;
>   
> -	cfg0 = (ecc_cfg->cfg0 & ~(7U << CW_PER_PAGE)) |
> -				(num_cw - 1) << CW_PER_PAGE;
> +	cfg0 = (ecc_cfg->cfg0 & ~CW_PER_PAGE_MASK) |
> +	       FIELD_PREP(CW_PER_PAGE_MASK, num_cw - 1);
>   	cfg1 = ecc_cfg->cfg1;
>   	ecc_bch_cfg = ecc_cfg->ecc_bch_cfg;
>   	ecc_buf_cfg = ecc_cfg->ecc_buf_cfg;
> @@ -1175,8 +1176,8 @@ static int qcom_spi_program_oob(struct qcom_nand_controller *snandc,
>   	int num_cw = snandc->qspi->num_cw;
>   	u32 cfg0, cfg1, ecc_bch_cfg, ecc_buf_cfg;
>   
> -	cfg0 = (ecc_cfg->cfg0 & ~(7U << CW_PER_PAGE)) |
> -				(num_cw - 1) << CW_PER_PAGE;
> +	cfg0 = (ecc_cfg->cfg0 & ~CW_PER_PAGE_MASK) |
> +	       FIELD_PREP(CW_PER_PAGE_MASK, num_cw - 1);
>   	cfg1 = ecc_cfg->cfg1;
>   	ecc_bch_cfg = ecc_cfg->ecc_bch_cfg;
>   	ecc_buf_cfg = ecc_cfg->ecc_buf_cfg;
>

Reviewed-by: Md Sadre Alam <quic_mdalam@quicinc.com>


