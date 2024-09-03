Return-Path: <linux-spi+bounces-4522-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A95B96987E
	for <lists+linux-spi@lfdr.de>; Tue,  3 Sep 2024 11:16:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07E6AB28308
	for <lists+linux-spi@lfdr.de>; Tue,  3 Sep 2024 09:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074B119F419;
	Tue,  3 Sep 2024 09:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="VdGUxvQP"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647E31A4E89;
	Tue,  3 Sep 2024 09:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725354989; cv=none; b=WSobYEK5NolBdsG1Mgr8iQcKLknXDGczayYLQraeT0sJWLLIJt14qsoBe7XDqhdD3W6FYOFhUr9V+posS+3mEvI44JQAYDmr6mLSUVMnOj4XGZEqH/v2Qd6LdW2uNDq1YBEt6BHK2u52jnwQ2LfO8joMTeTGSPI3FS5rv/ajlmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725354989; c=relaxed/simple;
	bh=Y42K+VKdaOGaWK9Z/RB9RHq/t5rX2mCJb59mIktkP64=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=CCpKyJXA57KZ2NNz4Thv4ElewQkgh7sKvamX4ccsQCZ5TuHBCnMbtCwuJidXIYsorssIXF+oRGFalGBBrz5NT6oEUYgCvLBv9y21WRI70ZZIb2qRYBi4YA8PLCdsxv63wEf9ijV3RouFCudbDoCpPrOWBbmgakbkw4OhduHyke0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=VdGUxvQP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4835AldG009037;
	Tue, 3 Sep 2024 09:15:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	f+aDtDkpqgV1KQ/TcVWTCcSca/Y0X5xFWjMV1qZhGnM=; b=VdGUxvQPWzKAoMkO
	T0himFDsc9/6hcdNDyf3bIY1Sjq/GTEqWqb3E2JJz1P+TyvKhLrPOs+DeiO6Q0GW
	40NDT2z+W2Y7k21QWUt0N5l5a5Hmql+HLdacfuhBsIRQgvervtpD1zhYhL0gk28n
	I3O0ph/u5L1v0CkIPxEzsZSm7nvXzOBLseAoQe8uyareib8c+uueetl0ji00oAQ1
	YblUxjC7yuMjZ+CGTx68PLhntYsy8IH6PKz6Fa6UZQ8c6V+GuRCP9Yna61xAWd81
	AL8HIfEm2/nLVdKhOF8vVsht4xCfkencTutYkKg5jC1jkYr4/SgLWGSMTwdSoqdR
	J3ajvg==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41bt66xu4s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Sep 2024 09:15:55 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4839Fs58008084
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 3 Sep 2024 09:15:54 GMT
Received: from [10.216.9.110] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 3 Sep 2024
 02:15:49 -0700
Message-ID: <5169761b-422d-70ab-ba53-a898cb7bfa2f@quicinc.com>
Date: Tue, 3 Sep 2024 14:45:15 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v8 0/8] Add QPIC SPI NAND driver
From: Md Sadre Alam <quic_mdalam@quicinc.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <andersson@kernel.org>,
        <konradybcio@kernel.org>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <vigneshr@ti.com>,
        <manivannan.sadhasivam@linaro.org>, <esben@geanix.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>
References: <20240820104239.1774600-1-quic_mdalam@quicinc.com>
Content-Language: en-US
In-Reply-To: <20240820104239.1774600-1-quic_mdalam@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: UmnCr2WGft70bqzkiVvBtlXxBDElRjoT
X-Proofpoint-GUID: UmnCr2WGft70bqzkiVvBtlXxBDElRjoT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-02_06,2024-09-03_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 bulkscore=0 mlxscore=0 impostorscore=0 suspectscore=0 phishscore=0
 mlxlogscore=999 lowpriorityscore=0 spamscore=0 clxscore=1011
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2409030074

Hi Miquel,

On 8/20/2024 4:12 PM, Md Sadre Alam wrote:
> v8:
>   * Fixed compilation warning reported by kernel test robot
>   * Added "chip" description in nandc_set_read_loc_first()
>   * Added "chip" description" in nandc_set_read_loc_last()
>   * Changed data type of read_location0, read_location1,
>     read_location2, read_location3, addr0, addr1, cmd, cfg0,
>     cfg1, ecc_bch_cfg, ecc_buf_cfg, clrflashstatus, clrreadstatus,
>     orig_cmd1, orig_vld to __le32 to fix compilation warning.
>   * Included bitfield.h header file in spi-qpic-snand.c to
>     fix compilation warning
>   * Removed unused variable "steps" variable from
>     qcom_spi_ecc_init_ctx_pipelined()
> 
     I have addressed your comments to v6 and further posted till v8.
     Could you please let me know if this is fine.
     and how to get this merged ?

Regards,
Alam.

