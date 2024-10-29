Return-Path: <linux-spi+bounces-5531-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B453C9B4186
	for <lists+linux-spi@lfdr.de>; Tue, 29 Oct 2024 05:16:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71E07283416
	for <lists+linux-spi@lfdr.de>; Tue, 29 Oct 2024 04:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F161DFE26;
	Tue, 29 Oct 2024 04:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="p8Gmiyz2"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BE814900E;
	Tue, 29 Oct 2024 04:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730175370; cv=none; b=r0HxbFNjVUQVyCnwSMHQGpF+/qE0r1qZNnUFs9MmU+QMv4658oAk3CnCQK6nVE9Or4epE+WXlu0dEpbXo+BCA992N3nHBOlGumTqdTdfmljCjSO2WQjjyq+FxCIurIBDE1lwjYjv4XBLtKsl6ud1HS6123KCYsStPxfJXmkefdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730175370; c=relaxed/simple;
	bh=nhtrrKv3W9KNUUBPwSISzLocWlPuKH88RGhBdZIsBM0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=D8wU1uJDGSytQh7niGua0wN+ZjNZn64uYaAZWZYMrdEK53tGfkOBe6RIjZ+PEIIZbjq5Nstr9w7sjwXRY5t35t9wDfdROIA43C5+6+xQsy5E+gtLWwvbYEn7GzBQWLoMRji5l1xV651n/1o+OVbCckfGW4H1Vn0RQPKpdRDLFGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=p8Gmiyz2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49SKeops008480;
	Tue, 29 Oct 2024 04:15:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3LBEammmJWyw3g0OzjhKohK2SuwOFyJvCBOLPi8y7Hw=; b=p8Gmiyz22CHHi5W2
	PoA6U33xe0nJFym5sMuSFMxkNYMgU+nAoqkqduqXHtDYLgfhIlzi3rsmQIwJLpXA
	ZAYeiU1VeBA27AAzDnEr8GW9XyA3rV7991ZzLlKEfW6EsQN3A/xDa4fQyQEBnC/3
	lzrH21X8ExwXTHMCP3upstRP9FoqBb3NOh7n8eY8xqBrtEIfv+zVEL0aNH05PoDY
	3UrKk0PYsfuifNoDBwV+S1/tkzBPvBYBX4ZiOXwE2lXLxp2U0zncTs84jBTZe9l7
	o3ui5ZmJIH57tFcg2foUnIwR3Vd9zXTpLLmMMq6aRiOCsI0sqZlIfcHp0zzyQLZO
	PGaaww==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42gqrgq32g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Oct 2024 04:15:44 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49T4FhT7004294
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Oct 2024 04:15:43 GMT
Received: from [10.151.37.94] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 28 Oct
 2024 21:15:37 -0700
Message-ID: <8795ecde-5faf-0110-a01c-8e194ea9b43b@quicinc.com>
Date: Tue, 29 Oct 2024 09:45:26 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v12 6/8] spi: spi-qpic: add driver for QCOM SPI NAND flash
 Interface
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        kernel test robot
	<lkp@intel.com>, <broonie@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <andersson@kernel.org>, <konradybcio@kernel.org>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <manivannan.sadhasivam@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>
CC: <oe-kbuild-all@lists.linux.dev>, <quic_srichara@quicinc.com>,
        <quic_varada@quicinc.com>
References: <20241021115620.1616617-7-quic_mdalam@quicinc.com>
 <202410252355.ZofaMeku-lkp@intel.com>
 <5a98076f-f5ce-4400-b554-6593d51de9f2@oss.qualcomm.com>
Content-Language: en-US
From: Md Sadre Alam <quic_mdalam@quicinc.com>
In-Reply-To: <5a98076f-f5ce-4400-b554-6593d51de9f2@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: addbZRrfOE2H6dZn2kuNmTa_OeTRhRZL
X-Proofpoint-GUID: addbZRrfOE2H6dZn2kuNmTa_OeTRhRZL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 clxscore=1011 impostorscore=0 suspectscore=0 spamscore=0 mlxscore=0
 adultscore=0 priorityscore=1501 mlxlogscore=999 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410290032



On 10/25/2024 11:44 PM, Konrad Dybcio wrote:
> On 25.10.2024 6:08 PM, kernel test robot wrote:
>> Hi Md,
>>
>> kernel test robot noticed the following build warnings:
>>
>> [auto build test WARNING on mtd/nand/next]
>> [also build test WARNING on broonie-spi/for-next robh/for-next linus/master v6.12-rc4 next-20241025]
>> [If your patch is applied to the wrong git tree, kindly drop us a note.
>> And when submitting patch, we suggest to use '--base' as documented in
>> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>>
>> url:    https://github.com/intel-lab-lkp/linux/commits/Md-Sadre-Alam/spi-dt-bindings-Introduce-qcom-spi-qpic-snand/20241021-200849
>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next
>> patch link:    https://lore.kernel.org/r/20241021115620.1616617-7-quic_mdalam%40quicinc.com
>> patch subject: [PATCH v12 6/8] spi: spi-qpic: add driver for QCOM SPI NAND flash Interface
>> config: sparc64-randconfig-r073-20241023 (https://download.01.org/0day-ci/archive/20241025/202410252355.ZofaMeku-lkp@intel.com/config)
>> compiler: sparc64-linux-gcc (GCC) 14.1.0
>>
>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>> the same patch/commit), kindly add following tags
>> | Reported-by: kernel test robot <lkp@intel.com>
>> | Closes: https://lore.kernel.org/oe-kbuild-all/202410252355.ZofaMeku-lkp@intel.com/
>>
>> smatch warnings:
>> drivers/spi/spi-qpic-snand.c:1260 qcom_spi_write_page() warn: unsigned 'cmd' is never less than zero.
>> drivers/spi/spi-qpic-snand.c:1279 qcom_spi_send_cmdaddr() warn: unsigned 'cmd' is never less than zero.
>>
>> vim +/cmd +1260 drivers/spi/spi-qpic-snand.c
>>
>>    1252	
>>    1253	static int qcom_spi_write_page(struct qcom_nand_controller *snandc,
>>    1254				       const struct spi_mem_op *op)
>>    1255	{
>>    1256		struct qpic_snand_op s_op = {};
>>    1257		u32 cmd;
>>    1258	
>>    1259		cmd = qcom_spi_cmd_mapping(snandc, op->cmd.opcode);
>>> 1260		if (cmd < 0)
>>    1261			return cmd;
> 
> The robot is right, qcom_spi_cmd_mapping() should return an int, as you
> return a negative errno upon failure
Ok will fix in next revision.
> 
> Konrad

