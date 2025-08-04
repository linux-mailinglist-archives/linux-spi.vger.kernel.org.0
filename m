Return-Path: <linux-spi+bounces-9274-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53650B1A235
	for <lists+linux-spi@lfdr.de>; Mon,  4 Aug 2025 14:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A618180D52
	for <lists+linux-spi@lfdr.de>; Mon,  4 Aug 2025 12:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC5425D53C;
	Mon,  4 Aug 2025 12:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CRfKr2w/"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1C625B309
	for <linux-spi@vger.kernel.org>; Mon,  4 Aug 2025 12:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754311714; cv=none; b=LOuaeIvwDvP8Ci4cnoe813HBCB/4AY3JviYahTpb0FLj6bM2tK4czFlOiSs2cP3LXDwA8P0Va9RH704juKZXfhcEkNfvzzivv6Z7Hh1Jvjbt/j2eKPGvw0YOHWY8wXCqSzjfl6KZkUBfts1hvNj1XQEgW9MSLlj8YrCcjvK9vR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754311714; c=relaxed/simple;
	bh=LYFZ8NhY+QtK8ZVQ32oeWX8L1gtCW4Dk6OsP1dI4e4A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VSBI0vxNB2i20Jm0RcxP3+aVG+4m6QYYHTLAxxCq+Qx/1qOqDTwIb3de5Pd8FAtgzai0Tcli+nGKr7jZKJf34RlFoTVwrakoM1PsVqO3RFYdqegc4LfIN+veKWmfhaYHuiDOZuclJYovHePUoPvMa2pFG6AK/BEhbI6smE1IbYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CRfKr2w/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5746qpBu016480
	for <linux-spi@vger.kernel.org>; Mon, 4 Aug 2025 12:48:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zFheNoJFftwlUhByal86hdBunVF358wbMQHu85MmEGA=; b=CRfKr2w/dSWVNReV
	amxfnKEU1UP5V+Hf36gAfER4V9LSdxV4liDYzGPw7ILeWzdxITAbYpjc/2ZaNk1B
	xm9+RqPtLq+B8an2pBUQBudXv7oibymFTHKGXY4mZweGGZfsGZoTpNC/MNl0GsP0
	SZmWEfjAYO2lrH4KqdITm0pJaeZq+JchfGRrYVpJ5xS1JVFU1lEJvFfU3d2S2X4J
	oTasuFfHY/pHXD11pVmOLgj+dLyK3TNNKFF6b7zo2l7Pp176xrCYCn67g5WtdKB3
	Jsx74JCtymSjy44MAmZR/spl84aKvsNsypcpt5+62oKkTitSQR4WALytmUORaoWz
	QzdQuw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48aqyv17ex-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Mon, 04 Aug 2025 12:48:31 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7e80143e64dso1214385a.3
        for <linux-spi@vger.kernel.org>; Mon, 04 Aug 2025 05:48:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754311710; x=1754916510;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zFheNoJFftwlUhByal86hdBunVF358wbMQHu85MmEGA=;
        b=AS5q27BxhX7IDCd3m2NIpNGnP7oKCD0AqwDsBvG3I4mdXJXTALN1mLXkrtIoFJCe8L
         lrZObrdGdhCVTeHclZDd71MlfxWpv38iGHhQDUNWs5e9YbRXKe3hLG2E/3SoAmzcBN8A
         agAx7NoLOEMV1TmrJnHx7sVkcD/V5kvSH6OqqbIfS7sx0PMCveKHfkEcUyIGc3btqgZF
         GUEfXzndiijok2iyD0XkxXE5B/nyXVTXMVbxSBpS826yvY00+FWOtq8qC04WTaapyUI2
         5u/+kGJd/9BA4WcEUD5xrZxc3O+Ohxrx+NQMeUUohOvX7LU6CQ3iCOpB2w/cuwx34vh0
         tNkw==
X-Gm-Message-State: AOJu0YxEk61B0hUbp1jxXr9pvu5pkb/HJBPc0l7kv0JHJ8KVTgvO9oLl
	j+MzQ88EtuSvMXxUCSwTrNna/1Ykax9hCHeVyhyIOfa+FnSSqyoaC0fyGPCVpl7r89u0F2+Tqay
	qhfEK8FNRSCA6L/TqKNDXo5IyjbPAAYwJuu+ZIuVu9JlfRQ0NRN2NEK6z/bi+2KQ=
X-Gm-Gg: ASbGncv7WlQFzaOAjltQ1PwaXi9pOuRL3CGRIPcM1ySqwQTghK5z0bJDyd54zEei8vl
	0xrQa6C/YBPMbHypR/S/UK4enbZN0QyMYG5HyMtqAJUKTXs4dHjHAFqPEnNhoy93znKD3e62e1e
	Dp8XpYuGcbRksH1hwFDKSV2lryI52yQi/bHUzOgCGQOkLe/EPCrAxIRw7o/P/aZnWeL7q9hbFsK
	jz1vpWAi/a+B4ZI4Z23lmDMv8cq8OP7XBFaSmSiEKBgo/01ArP1ydLA4WYcwNlJ/CAAqrnv8D9j
	cJIG9Cuo1nRmIk4NuP0GnheALmyLRhTAtiZofqLBbt2oHt4VGoFeOT6BGM5zt7riRy7mznguWAU
	oV8aVcQmvn0O+XnoIyg==
X-Received: by 2002:a05:620a:1a96:b0:7e6:2435:b6a4 with SMTP id af79cd13be357-7e696391ba3mr588752085a.12.1754311710420;
        Mon, 04 Aug 2025 05:48:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFfOK2zG/I1wPrVXqw3Ou3u51Ey0rE1CW66ekjlSXKZ6Q9KGh6EBm21/8VsABSjJCoV5JqjTg==
X-Received: by 2002:a05:620a:1a96:b0:7e6:2435:b6a4 with SMTP id af79cd13be357-7e696391ba3mr588749785a.12.1754311710004;
        Mon, 04 Aug 2025 05:48:30 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a21c022sm713556266b.101.2025.08.04.05.48.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Aug 2025 05:48:29 -0700 (PDT)
Message-ID: <ee95cbc8-c1e6-4b23-9e1d-4a74ef441adc@oss.qualcomm.com>
Date: Mon, 4 Aug 2025 14:48:27 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: spi-qpic-snand: use correct CW_PER_PAGE value for
 OOB write
To: Gabor Juhos <j4g8y7@gmail.com>, Mark Brown <broonie@kernel.org>,
        Md Sadre Alam <quic_mdalam@quicinc.com>,
        Varadarajan Narayanan <quic_varada@quicinc.com>,
        Sricharan Ramabadhran <quic_srichara@quicinc.com>
Cc: linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250801-qpic-snand-oob-cwpp-fix-v1-1-f5a41b86af2e@gmail.com>
 <b2e4d6b1-25bc-4b2e-ae54-6588f1573131@oss.qualcomm.com>
 <1ba00a38-7293-4f72-9aee-f87f41a3dcc6@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <1ba00a38-7293-4f72-9aee-f87f41a3dcc6@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: lFHA_ot6V6FbRTPN7yqC6gFZsYpK8UXL
X-Authority-Analysis: v=2.4 cv=F/xXdrhN c=1 sm=1 tr=0 ts=6890ac20 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=6dxo4luPYu9H4ytEELAA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: lFHA_ot6V6FbRTPN7yqC6gFZsYpK8UXL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDA3MCBTYWx0ZWRfX/NHg1sgdGTqj
 ErCAW/S1JQ98Qm61vGil5TaNazeJuJSpnwQlG9nmsmZDsvHzEad+e2h2LaaonFd5Q8ciBmyPdFt
 WNqji4DU/tBl1FNaBhFld1b12KHuQPgeOwwWjiuKzWrzcRHNOaSNvYK2Q4pjmrPrSMvSps6Pk9q
 pFJUM9m1Dfk7XnKE34fbKBtiYFbIOVgg7VzOewSLrWiYVM9C6ATJHssRGnHxQy6toVCXy/5aLks
 eIoBqIVcMdlblwrbRq5VfrzhyDP9dEsksSHRREi3jV3ir4dhRVkUFwkHUjSdCowuEN6tncTpn0U
 +K7BnzWMly7MuQRWEjSY6l9wTsh+oiXp4fXu+hbSNFRq+V8c9hBW9aKQOFeZdzj5DPepN//Nd0F
 kcNHaFgfPikoJoiW4sqE7U7cMujEj/k89d2CwTWeoQCSuWDHcv8AiDpv6sUFBnFzowsg4wkc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_05,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 mlxscore=0 phishscore=0 bulkscore=0 adultscore=0
 clxscore=1015 mlxlogscore=999 priorityscore=1501 impostorscore=0
 malwarescore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2508040070

On 8/4/25 9:40 AM, Gabor Juhos wrote:
> Hi Konrad,
> 
> 2025. 08. 01. 13:08 keltezéssel, Konrad Dybcio írta:
> 
> ...
> 
>>> diff --git a/drivers/spi/spi-qpic-snand.c b/drivers/spi/spi-qpic-snand.c
>>> index 0cfa0d960fd3c245c2bbf4f5e02d0fc0b13e7696..5216d60e01aab26f927baaea24296571a77527cb 100644
>>> --- a/drivers/spi/spi-qpic-snand.c
>>> +++ b/drivers/spi/spi-qpic-snand.c
>>> @@ -1196,7 +1196,7 @@ static int qcom_spi_program_oob(struct qcom_nand_controller *snandc,
>>>  	u32 cfg0, cfg1, ecc_bch_cfg, ecc_buf_cfg;
>>>  
>>>  	cfg0 = (ecc_cfg->cfg0 & ~CW_PER_PAGE_MASK) |
>>> -	       FIELD_PREP(CW_PER_PAGE_MASK, num_cw - 1);
>>> +	       FIELD_PREP(CW_PER_PAGE_MASK, 0);
>>
>> FWIW I'm just a fly-by reviewer for this driver, but the docs say:
>>
>> The value is the number of codewords per page minus one
> 
> Well, the driver uses that differently even without the patch. See below.
> 
>> "NOTE: This field must be cleared for block erase operation"
> 
>     $ git grep -hp 'FIELD_PREP(CW_PER_PAGE_MASK,.*;' drivers/spi/spi-qpic-snand.c
>     static int qcom_spi_block_erase(struct qcom_nand_controller *snandc)
>                                              FIELD_PREP(CW_PER_PAGE_MASK, 0));
>   
> This function implements the block erase operation and it corresponds to the
> documentation. So far so good.
> 
>     static int qcom_spi_read_last_cw(struct qcom_nand_controller *snandc,
>                    FIELD_PREP(CW_PER_PAGE_MASK, 0);
>     static int qcom_spi_read_cw_raw(struct qcom_nand_controller *snandc, u8 *data_buf,
>                    FIELD_PREP(CW_PER_PAGE_MASK, 0);
>   
> 
> These two functions are using a single codeword (with zero CW_PER_PAGE value).
> So, it seems that in reality the CW_PER_PAGE value means the number of codewords
> (minus one) used within a single operation executed. Of course it is possible
> that the existing code is wrong here.
> 
>     static int qcom_spi_read_page_ecc(struct qcom_nand_controller *snandc,
>                    FIELD_PREP(CW_PER_PAGE_MASK, num_cw - 1);
>     static int qcom_spi_read_page_oob(struct qcom_nand_controller *snandc,
>                    FIELD_PREP(CW_PER_PAGE_MASK, num_cw - 1);
>     static int qcom_spi_program_raw(struct qcom_nand_controller *snandc,
>                    FIELD_PREP(CW_PER_PAGE_MASK, num_cw - 1);
>     static int qcom_spi_program_ecc(struct qcom_nand_controller *snandc,
>                    FIELD_PREP(CW_PER_PAGE_MASK, num_cw - 1);
> 
> 
> The previous functions are operating on whole pages, so those are using all codewords
> within a page thus 'num_cw - 1' is getting set in the register field. This also matches
> with the documentation.
> 
>     static int qcom_spi_program_oob(struct qcom_nand_controller *snandc,
>                    FIELD_PREP(CW_PER_PAGE_MASK, num_cw - 1);
> 
> This is the function fixed by the patch. As it is indicated in the commit description
> this also uses a single codeword similarly to the qcom_spi_read_(last_cw,cw_raw) functions
> described above so the CW_PER_PAGE value should be set to zero.

I didn't mean to dispute what you said :)
Simply included some context for other reviewers

But thanks for the insight, this seems to indeed make sense
the way you presented it

Konrad

