Return-Path: <linux-spi+bounces-9382-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C97B2487E
	for <lists+linux-spi@lfdr.de>; Wed, 13 Aug 2025 13:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D61E1BC22B7
	for <lists+linux-spi@lfdr.de>; Wed, 13 Aug 2025 11:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CDA32F6580;
	Wed, 13 Aug 2025 11:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ifG0z+Y7"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD4B2F3C2B
	for <linux-spi@vger.kernel.org>; Wed, 13 Aug 2025 11:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755084747; cv=none; b=Zrc1HhWEcT3JInnvZZMFpkIk6AC7KP9Gpyjg8nlouRNjlz2tszS+IucsYpPWahWlD6JNh2zkz6jeu8cqrdTzKESR56ZQF1qygxBPkgUrRkJwxak0lV+VGhNZd88o8t5sr3el67Sua1JHvbonasiAjVN1ncp0lPBWbkaR5TRVcyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755084747; c=relaxed/simple;
	bh=kRpkUjEHh+mveb2bs3Tp9AcZmSD68sinrjNRQO2gQpw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QLw0XczcExj1oL4mISGpCXgAuoO1M7qZFzKdQtqhUbcarsgNQYPDTapV5AiPre7beBsEIROBYAQkxdr7YrAVq0awV9FrjEnsx2c6znyOLLrzOltywI+IPyPqqrLQvccUNwuoSkoc3iVC3npWU/tTEnZlXVVNCJv8Dsk9WRANQSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ifG0z+Y7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57DBLipa002966
	for <linux-spi@vger.kernel.org>; Wed, 13 Aug 2025 11:32:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rjVZidOdjDRebLgVIpzz+zvbQWyC0jDD/g5NDXaHcRc=; b=ifG0z+Y7EQjfHETx
	wMQO6J6Ab6VYi4Yld5QZdL+gwbT9THXSLW0W/rDF8SBy2OYhz2lxxQkgTH3Q1HLv
	ebKs85DMDWV78OrOS0WDdWyfnLG0zSsYJLVv5+nvFGtD7sjJ4SyBqyxqJjQlKNVG
	t32VVDBc4FJbNpJGYU8DDH3RAGmFIB0XjWzYm4OYMgiflSMBXTaa4oRiA5NtOchC
	CYo+099+xrFmDeO2KWHfMxkQ7lAMB7TulNB20a/c+rbJnkp7pqk96ltEU8jc/+Hl
	aWpJcGZPFdsRQEdY4d5zXGkIvNYpPCRdWUAqDrFtfAli2LlV6mSjdQcgJLnLLyx9
	j/veKg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dxdv3k10-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Wed, 13 Aug 2025 11:32:25 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4af23052fb8so9768831cf.0
        for <linux-spi@vger.kernel.org>; Wed, 13 Aug 2025 04:32:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755084744; x=1755689544;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rjVZidOdjDRebLgVIpzz+zvbQWyC0jDD/g5NDXaHcRc=;
        b=N02pqWE4UC7+ul3xPO/ZCxEMKrI4ozM2KEbuwE5uHPehQTaDWBKOl3Q3UCVEERZ28s
         Jaw9fep1tT4tl2gs2EYWiyGLNp/gpu2Vj+2T1MqaxQj+t5owu+Y4JC9ElSykaZf7SyXd
         h0Lcv7UGvkqG2st00KBR/5O5rrmq3eDAVnesBg3wdLL3P3Y70k3GZOO+gN7NuUqalR2/
         1GV5umeB5JmTiK4Udp6pQzU5qfVTTqWcVbK1BKzncDyEKjoA2TG6fwyFmGZtYZWh8brt
         X37eQ9gCmpjFvyu2aHNluCO1eoaL81TVWt0U2gubAkfitaaSeS+xwkXJowz6BuZLuiae
         mWtA==
X-Forwarded-Encrypted: i=1; AJvYcCXuCSKoLLdr2MO3KqGZTxFDOjuGvJotqqXmMouC0VqnLNvMvI5gsQzExaJdfujHaVsP+aTUhwqNkKg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdCXR7r+h8l58jDPJSo7DJZ7me6PmTv/81NWgs7ptbafdeaRzi
	pi+DF+Oppm6NnTP0FX5gupD1FtNStoYJe7y/s2b6wUDSS3ulBQI9odXSSFvPxDpaZAd/nn4sJhs
	GSOml89x0TCOiGCROVZ3jWgY5lQSLgTRC3QIB5HgxjNxKvd0fSnHy2uTkG3LiczA=
X-Gm-Gg: ASbGncvr4nwrLMVs8uGFyVmiOGWkCwSo1kg7lLfhXLORQ6MSbL2FuXX+LTuW/bpBj8f
	kpo9Ha632iD7bIcQcbMedwpAyEPL6ZjxOnsIoYjDJJBsN521ZmTGyJrS87XBo2Aqsm2QFz6OsJT
	/+v0yPi3WdIuYS0CY0c7QHS1HbW6uJRQCNPtaTEDmLTtjpLmO+uTWXfilofbUBinuTsf/KXLa5i
	Zz/48d66qpGQqL7yff4It01W4xL4Lnf1fZdZcY3fDSuyfps98bNGn7Gr1UxQY1Yx2uoIHlfTUoV
	4UE8T5B8ydj0dO5SozWGle3EXlk7Us5ithlaoo3KuK8MER6Ny1XRWBXrLbcxHM6KxJfaDpdhjYO
	HRpaN/SxFiGAyQHVMAA==
X-Received: by 2002:a05:622a:43:b0:4ab:5c58:bb25 with SMTP id d75a77b69052e-4b0fc68ba3amr14426451cf.1.1755084744040;
        Wed, 13 Aug 2025 04:32:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEq0Aur4OMFrqMwkB9SaTqBRiff+d+TLLYRjRQr9B/aNZsuDsLG+6/BcDX/aVTr8EKoadGaEw==
X-Received: by 2002:a05:622a:43:b0:4ab:5c58:bb25 with SMTP id d75a77b69052e-4b0fc68ba3amr14426271cf.1.1755084743438;
        Wed, 13 Aug 2025 04:32:23 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0761f2sm2392951866b.11.2025.08.13.04.32.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 04:32:22 -0700 (PDT)
Message-ID: <c48906a9-4de0-453c-a827-5b45d3a6ed0a@oss.qualcomm.com>
Date: Wed, 13 Aug 2025 13:32:21 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: spi-qpic-snand: handle 'use_ecc' parameter of
 qcom_spi_config_cw_read()
To: Gabor Juhos <j4g8y7@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Md Sadre Alam <quic_mdalam@quicinc.com>,
        Varadarajan Narayanan <quic_varada@quicinc.com>,
        Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250808-qpic-snand-handle-use_ecc-v1-1-67289fbb5e2f@gmail.com>
 <3e790d99-5c6c-4148-85f5-0023a621afeb@oss.qualcomm.com>
 <e5b981f8-9b6b-42c6-b432-537d23f7fd58@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <e5b981f8-9b6b-42c6-b432-537d23f7fd58@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=IuYecK/g c=1 sm=1 tr=0 ts=689c77c9 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=LMlhJLrcAiEsyVNmZoIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: RTDeBT2HrdfYkjyobtN6IDNaqkssrpKF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAyNSBTYWx0ZWRfX0MOE1hLH/bY8
 FJ7tkrPdI49lT8lnwnnZg/Q8RWnvHDeeK/1Dq0Zp6Fat6R6HqBxZNVIR0ffXxycE5kc4KpOt3BT
 hjQ7Dp5rGBnG4Cdc0ESovw0e3iwVv4DU1NPQ5Ud/r1yqx8gLdz/C6q+nBENkPsmkNs3BBnN2SD9
 lIYDEIS0URoDBUarOvE3xxbP8wpJlKYXDiSOuaR9UB9p670RMyBsm2IYEHtUsXLk2W/Rv/7haij
 0HU9qAETAyUePh6+g92brUqqLL12XN/SyC8L2hzDnARQkQ1H1gTfQVjlx2M5B28vexsC4jP25f2
 SmUf8szD+IZz7c0wHmRPGlwc6TPGwBh9Gt5zS7QCPbbco0Kl00Fb0IupHO+YwNrgq0Kix7Owe0f
 Sp8g5Mq4
X-Proofpoint-GUID: RTDeBT2HrdfYkjyobtN6IDNaqkssrpKF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_01,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 priorityscore=1501 adultscore=0
 clxscore=1015 phishscore=0 suspectscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090025

On 8/12/25 1:06 PM, Gabor Juhos wrote:
> 2025. 08. 12. 11:55 keltezéssel, Konrad Dybcio írta:
>> On 8/8/25 7:15 PM, Gabor Juhos wrote:
>>> During raw read, neither the status of the ECC correction nor the erased
>>> state of the codeword gets checked by the qcom_spi_read_cw_raw() function,
>>> so in case of raw access reading the corresponding registers via DMA is
>>> superfluous.
>>>
>>> Extend the qcom_spi_config_cw_read() function to evaluate the existing
>>> (but actually unused) 'use_ecc' parameter, and configure reading only
>>> the flash status register when ECC is not used.
>>>
>>> With the change, the code gets in line with the corresponding part of
>>> the config_nand_cw_read() function in the qcom_nandc driver.
>>>
>>> Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
>>> ---
>>>  drivers/spi/spi-qpic-snand.c | 11 ++++++++---
>>>  1 file changed, 8 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/spi/spi-qpic-snand.c b/drivers/spi/spi-qpic-snand.c
>>> index 7b76d2c82a5287df13ee6fcebc4abbe58ca861ee..119003c4784890458a41c67fa8bc17d721030b0d 100644
>>> --- a/drivers/spi/spi-qpic-snand.c
>>> +++ b/drivers/spi/spi-qpic-snand.c
>>> @@ -494,9 +494,14 @@ qcom_spi_config_cw_read(struct qcom_nand_controller *snandc, bool use_ecc, int c
>>>  	qcom_write_reg_dma(snandc, &snandc->regs->cmd, NAND_FLASH_CMD, 1, NAND_BAM_NEXT_SGL);
>>>  	qcom_write_reg_dma(snandc, &snandc->regs->exec, NAND_EXEC_CMD, 1, NAND_BAM_NEXT_SGL);
>>>  
>>> -	qcom_read_reg_dma(snandc, NAND_FLASH_STATUS, 2, 0);
>>> -	qcom_read_reg_dma(snandc, NAND_ERASED_CW_DETECT_STATUS, 1,
>>> -			  NAND_BAM_NEXT_SGL);
>>> +	if (use_ecc) {
>>> +		qcom_read_reg_dma(snandc, NAND_FLASH_STATUS, 2, 0);
>>
>> Why are we reading 2 registers (the 2 in the func call) here, ...
> 
> Because when ECC is used, we need the status of the ECC correction from the
> NAND_BUFFER_STATUS register which is placed right after the NAND_FLASH_STATUS.
> 
> Here are the relevant definitions from the 'nand-qpic-common.h' header for
> reference:
> 
> #define	NAND_FLASH_STATUS		0x14
> #define	NAND_BUFFER_STATUS		0x18
> 
> So the two registers can be read with a single DMA operation.
> 
>> ... but 1 everywhere else?
> 
> When ECC is not used, we only need the value from the NAND_FLASH_STATUS
> register, so we don't have to read two registers.

OK yeah I can see that

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad


