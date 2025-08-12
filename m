Return-Path: <linux-spi+bounces-9366-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03030B223CD
	for <lists+linux-spi@lfdr.de>; Tue, 12 Aug 2025 11:56:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AEF6189F576
	for <lists+linux-spi@lfdr.de>; Tue, 12 Aug 2025 09:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 798E52E92C7;
	Tue, 12 Aug 2025 09:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KUexjIeE"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E217528726F
	for <linux-spi@vger.kernel.org>; Tue, 12 Aug 2025 09:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754992559; cv=none; b=asOJF8KL46vW/TtdPuBhufMCV3xY7LYwm8pQmTfiodL1Xgu3M0TBbllh43/7fEq7TIYGwYmInGvFuMhvGucYs9vldSPdBsWdiHgQJMy7eelRXvW2tJ3oDv+FB4VxLLwUrko6+VQ+VJVBBcBwn5fpsgx4IULq+iA4aF3gYfo4q9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754992559; c=relaxed/simple;
	bh=dQYFIBmr1qRbEzprHryh0LnUcSKHlaB+KrZ4fdJoJn4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Msyp0n+F8gLw/OLQluwJjoZTSTtRA+RnDUYl+tVXQZHSBKmth30yuVEhCrFTZJvH+9pAh5mkTIKjldK7euWSYJCzBhKOaMdT75jFyfx2qwVq/KTY5kh8HkmABCn6B/sQNZYs+TldM0/XXm/fKUJckoeh3Zv0Mvz5mrbmaXjl7Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KUexjIeE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57C3FJlI004687
	for <linux-spi@vger.kernel.org>; Tue, 12 Aug 2025 09:55:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fy5zAaN1Le8gwkS5f3ejrtBssrUSdwA0NqZDJMsJ1vI=; b=KUexjIeE4/ARZQ7n
	sTm74lM/Gn3RugLldjBpvUw/0ZmVxw2LPmp8TmsugDwKlt5t5tvgyvboPd02tNVM
	sxqvgpYxMDx/BGvnIvUEzu8QhD9xahE1IY7zP2Y5ZrAN9w8mAuPBxiQFe/ZTSIw1
	nvOPeTBXTO5Kc2Py5QktGzGLXdgpWGIp95u+wQipuW74qNywSsQE6veRmel3OU5h
	+jUVsovCHqA9Ch3xFyPqdHwkhlyoWmcpTS+KPFoDqS5L7gkuKybYhK7bKFAHV+Ik
	WAopAZJ2Zd8E8pkHC3JwrnXz5HFpSyRic1/IRco55Kmwyn0C2DtcURtX3m+h3VQh
	T44bTw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48fjxbasnf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Tue, 12 Aug 2025 09:55:57 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b07b805068so11892011cf.3
        for <linux-spi@vger.kernel.org>; Tue, 12 Aug 2025 02:55:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754992555; x=1755597355;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fy5zAaN1Le8gwkS5f3ejrtBssrUSdwA0NqZDJMsJ1vI=;
        b=xVkl+7Z+TvwUodIod4Ewx6ZaHBDJSaB7suXEU+YjEclbYH9O8OavT9Me4lw8gfP8q9
         xbUkrZtsDeJqMSa8KtX+cxmHZUZnvQSaQ6CbLQgwwsSSPTz3dQpfaQ52lFtzj85mMrvZ
         J2XETAbIthdehyWHeDrDPTCTmp553f7nPgiCA4KuE8C6cKAfV+g6huuasr/jTG8gJdLG
         UzscsWApZX5Bq9hyq0Ke/2FNQWtDs/g9qD/3EBRBe7lyEupiW1Jfu4J1IvbQCoXEfc08
         kCDrGtX5lcje3LnBh7kdoLHEjd5JGEzBCq/HNqU60xGHv86PN7vQzGkAFsJabp0DKGvf
         KaHA==
X-Forwarded-Encrypted: i=1; AJvYcCV77Dq/XgYP6BwuWCIdYQDo7HcQlPijgetP40TW88bkyH0JprlOOgiETxod0v6kofXHzMi5ydDkRP4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrklSAO4SqQQVcBHj9KUIKPv0GP6QL4E+aYQm/U9PE5cRyRaPl
	7MBhc7YU8WMrRGxSo17T/FuSF2m4MnSylk0s+trcqEp4RmiPDl4JT6vAF+AflfrdnxM5fCDoyf5
	YMUfZ5z+7Lv6XbLdr/OQKYI/OwQO/53DfDNOWSzHYQa+80T6QQdbJcdZz84t2ki0=
X-Gm-Gg: ASbGncu9uE+jXN1/zIiZhegtjtIqaGIJnFxn5yfRa+1OinDj0bVxAsf8iIMeCq2NfD2
	C3noiz/lsXlkytVDpe5gWrJGODN2W9Psc+fV0/SiVIS9KJY/wKOxAkprJrFlbQFOPfFTXxpFaD/
	OCAddB4IYVluYIojl7LisaZaBtQa0g8ZSAHkJkJIEZ9zvoFZl/0SkCtSxmtlWEDU3KhfA+ki/si
	LRGkwZrBB4Gw40a9eDA3xQG3axZEKtXGkl9FmtmFpIlYe4FGm4Vmi16VH4iJUrCAObd29hqKRc2
	yzOGD6QmWikyLkvro4ATYGHo7kQNklxqYoJ+dstj0S0SiansKuVcTFVqTV7IQRN2NUh+kzg4EwW
	geOsAzBlkezogJazUWw==
X-Received: by 2002:a05:622a:189f:b0:4b0:8cfa:a507 with SMTP id d75a77b69052e-4b0f4ccd933mr2855711cf.10.1754992555239;
        Tue, 12 Aug 2025 02:55:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEReLnphOGEbNWWWfSrjX8K9aTE+4skbxwGcSBRQDYN+gOwpLRpbaZJOvyvPh88HdyWT+9wag==
X-Received: by 2002:a05:622a:189f:b0:4b0:8cfa:a507 with SMTP id d75a77b69052e-4b0f4ccd933mr2855621cf.10.1754992554790;
        Tue, 12 Aug 2025 02:55:54 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0def2esm2146839666b.61.2025.08.12.02.55.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Aug 2025 02:55:54 -0700 (PDT)
Message-ID: <3e790d99-5c6c-4148-85f5-0023a621afeb@oss.qualcomm.com>
Date: Tue, 12 Aug 2025 11:55:52 +0200
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
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250808-qpic-snand-handle-use_ecc-v1-1-67289fbb5e2f@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=G6EcE8k5 c=1 sm=1 tr=0 ts=689b0fad cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=pGLkceISAAAA:8 a=5qz9QPgusZpkEaXBDdAA:9
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA5NyBTYWx0ZWRfX2dmDB5v15r0W
 bJJ7pgCaNNaElUF2M74QD765DAe+qCqO4prDvOhyzq5v7QM5Xmfl17oMnSPJbXXiyeTHphgeipl
 WpeErtGNsDEMqC3a+j592Aa2UuJI2/fkvlyjY0jDJYfNFQPZ4NlLTqAnOtWAr4QVAAG34AX7R9n
 vCrfQ379yskP4vajgTGR0d1gWkgxwlc0nFEOj9JihfSqqHtfg16XcxNDjCrfHccULMMu4VJE5YT
 +yiYiXiyps+MTQEuYALeHz69uC3yTdDndGFqkDVzchLXumJWlAOzwkQtQp85BAnPcUIL1SGAXIt
 epmGIBVdO5DEPumvbL2ROJ0OPApEP2x1VXDCs/eFAUyJkuBRukC2IhsLV/FzB94n8K2JQyJeyoe
 CzXABlqD
X-Proofpoint-ORIG-GUID: Z2UD4xfQu8ee96HVydh8uE5bxC_uE_xY
X-Proofpoint-GUID: Z2UD4xfQu8ee96HVydh8uE5bxC_uE_xY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_04,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 bulkscore=0 spamscore=0 phishscore=0
 malwarescore=0 adultscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508110097

On 8/8/25 7:15 PM, Gabor Juhos wrote:
> During raw read, neither the status of the ECC correction nor the erased
> state of the codeword gets checked by the qcom_spi_read_cw_raw() function,
> so in case of raw access reading the corresponding registers via DMA is
> superfluous.
> 
> Extend the qcom_spi_config_cw_read() function to evaluate the existing
> (but actually unused) 'use_ecc' parameter, and configure reading only
> the flash status register when ECC is not used.
> 
> With the change, the code gets in line with the corresponding part of
> the config_nand_cw_read() function in the qcom_nandc driver.
> 
> Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
> ---
>  drivers/spi/spi-qpic-snand.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/spi/spi-qpic-snand.c b/drivers/spi/spi-qpic-snand.c
> index 7b76d2c82a5287df13ee6fcebc4abbe58ca861ee..119003c4784890458a41c67fa8bc17d721030b0d 100644
> --- a/drivers/spi/spi-qpic-snand.c
> +++ b/drivers/spi/spi-qpic-snand.c
> @@ -494,9 +494,14 @@ qcom_spi_config_cw_read(struct qcom_nand_controller *snandc, bool use_ecc, int c
>  	qcom_write_reg_dma(snandc, &snandc->regs->cmd, NAND_FLASH_CMD, 1, NAND_BAM_NEXT_SGL);
>  	qcom_write_reg_dma(snandc, &snandc->regs->exec, NAND_EXEC_CMD, 1, NAND_BAM_NEXT_SGL);
>  
> -	qcom_read_reg_dma(snandc, NAND_FLASH_STATUS, 2, 0);
> -	qcom_read_reg_dma(snandc, NAND_ERASED_CW_DETECT_STATUS, 1,
> -			  NAND_BAM_NEXT_SGL);
> +	if (use_ecc) {
> +		qcom_read_reg_dma(snandc, NAND_FLASH_STATUS, 2, 0);

Why are we reading 2 registers (the 2 in the func call) here, but 1 everywhere
else?

Konrad

> +		qcom_read_reg_dma(snandc, NAND_ERASED_CW_DETECT_STATUS, 1,
> +				  NAND_BAM_NEXT_SGL);
> +	} else {
> +		qcom_read_reg_dma(snandc, NAND_FLASH_STATUS, 1,
> +				  NAND_BAM_NEXT_SGL);
> +	}
>  }
>  
>  static int qcom_spi_block_erase(struct qcom_nand_controller *snandc)
> 
> ---
> base-commit: 13d0fe84a214658254a7412b2b46ec1507dc51f0
> change-id: 20250805-qpic-snand-handle-use_ecc-de929376d50b
> 
> Best regards,

