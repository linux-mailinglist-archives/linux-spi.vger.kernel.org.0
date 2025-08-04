Return-Path: <linux-spi+bounces-9272-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09844B19E36
	for <lists+linux-spi@lfdr.de>; Mon,  4 Aug 2025 11:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BB6E189A90B
	for <lists+linux-spi@lfdr.de>; Mon,  4 Aug 2025 09:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D4C024501D;
	Mon,  4 Aug 2025 09:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="H/j00l76"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4322224677F
	for <linux-spi@vger.kernel.org>; Mon,  4 Aug 2025 09:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754298269; cv=none; b=bTh/xE2WlyD6rIjrpGlkqDzVjPMUglQCRTL2+5cTSltSja6WEJCG4m5xKQk36gzKMvaGYy7a5iucNgzI2R4qGZaP7VoUzf9iTEGs/IQu6JUEyvJZOxBm25L0jrK2S8kc0ia+LfGFKALivz+nKyUyBQqKrOirqEjhsE355z4hYOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754298269; c=relaxed/simple;
	bh=3ynaIvsBNRVvZd577WmJObLTK8KxkOoTLbIepnKpTrs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nWUwbfGGMMkjKWV6Eyz58hfvZ0KRNfTSydcmfXUw2VJW/JVAK0tqZs1UFXyJMhUMlVmYnmGKps8+IWIYKRlt/HYNproAqBu+nLPYWqD6NZITD14vUhfMrtfC3YEDOkbkHGoP6rNsmn7IlCXcJvprTKIths/I9yQBQOgX15maXqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=H/j00l76; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5748gnEp005456
	for <linux-spi@vger.kernel.org>; Mon, 4 Aug 2025 09:04:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yxj88AoDLPC4Xz7nvIZCrmjG+oBu2ULVQ7Y3/Wt0Pxc=; b=H/j00l76Mr+gYapm
	+ZtxUX6bjTjpCIenYszeIdCS8nnZ+QQ7m5Ja34mr+hTJZ3N3w4ClQQnp7jW5sQEy
	kB4zFodR5A65bMjtX0cI9EDDKEvW1WyOqCDZFthtLgb9exhVJ0CAGt42dgiCYQzU
	WT0WmveQ62UM9ig64TDyxkD3he9zgjrl26+NSII0Ox0P6oc7So5KYV5de6y0KKto
	wZqCavNdiTBD62Yww9JsFsuOVHeEmhUDBgyBMQIGq/K/3bbe/sQRV+BNPmCW27oN
	oEQWD4hC/wcRxehaOfK5IIEkLhqh3OCMRXZJ6BThHhpBEoN+3nO4KJMvtdlA3dPw
	a9QMGw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48a2ke2bkq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Mon, 04 Aug 2025 09:04:26 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7e7f8e1dfd3so12780985a.2
        for <linux-spi@vger.kernel.org>; Mon, 04 Aug 2025 02:04:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754298265; x=1754903065;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yxj88AoDLPC4Xz7nvIZCrmjG+oBu2ULVQ7Y3/Wt0Pxc=;
        b=P5bWyVq3iaTMffJzzKSzu70AqRLPvF00qCeZm7GjIa/2lAOGvZaOpfbzGlhflo4SOF
         kzzvWeDcVxR/MiGKiylHnmwlFgrY9BmjiH44CfvlvppRvICbh/iOagQ6Jy16knXiaxyK
         U+ZKl1y8dbJjoKeoNhH2SzCawkn7akECcs1Jz00lekQAOc5q4ogQDGIuXRL4VgM9YruW
         KkXGyYPx+RK3WkLOaAmHg422+qjv/wT5aGCXPUO956qDuJwl5Lo1QUpNVMuDG3K7HCbw
         WfkmLiZrmMi+uGp5WuFGTDtFBkEBxdIurqJ2N6MjC43e9oQpR7sbD9VHCaN/TWxn9CQ8
         brZg==
X-Gm-Message-State: AOJu0YwGiV4Dnj2NeRwqn/tSa1NvEypbUiqgEED6hCESausKnSPuVmAh
	j5kxSmfYERMcHP+hJw+TVQ9nMOXjAxoFNpPrOFf3iLNijc7dFsTrEbq+/fjc2ndlIs7ITx/PTii
	IWZmBm2OHExpOkPHqtCqLjG2Y1jmV01JdwM3pmt8ji7pcjsVso0zxpponjDpHTjE=
X-Gm-Gg: ASbGnctYgpVEjhSbT5AP+LRTVc2JVTV02bktnIf3ecpAmhTlkIhPzRuGb/w2G3wM6YN
	FKi7unL0cQ/qI5T2pVRSrCXQ5wHGdE3RfbBxijrkINKRvXT6SZwDnqCR8StYBBsAiEG68Ob7JDi
	KI+E9Jv1cYVCCQVZq775taAn/QAsdbfBupnQKj2moc6xSdLpTX/9Ts+SSNY4SLIneZwrPQ5/m7K
	Q/WJpQOd5wXq4JOXLD9ZJXGXvmaP66jBh8SybxDZsXnG5xAsb+IKfOI4B0Xc92H1eF0u7MOgMr2
	42nNh02q5Z1DKg3Sfb2mivkNi0ur8HfqxSwwG0eL2FuPTB8I36m8AbfefTMdGdaQ1VTCp9luchb
	7Aw0daE8vSXpYRSflxg==
X-Received: by 2002:a05:620a:40c6:b0:7e8:5bb:b393 with SMTP id af79cd13be357-7e805bbb656mr66104085a.4.1754298265120;
        Mon, 04 Aug 2025 02:04:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHT5U6nf7OFxjlAHz3AXwYcJmyL/ozw3xGtfssCSEsyIVFeEN+uSY6B0F2EWAEjbDHiy3UmaQ==
X-Received: by 2002:a05:620a:40c6:b0:7e8:5bb:b393 with SMTP id af79cd13be357-7e805bbb656mr66101085a.4.1754298264504;
        Mon, 04 Aug 2025 02:04:24 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91aad117dsm695375766b.77.2025.08.04.02.04.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Aug 2025 02:04:24 -0700 (PDT)
Message-ID: <93403461-c0b2-4c0c-91b3-8cbd4c1c5ebe@oss.qualcomm.com>
Date: Mon, 4 Aug 2025 11:04:22 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: spi-qpic-snand: fix calculating of ECC OOB regions'
 properties
To: Gabor Juhos <j4g8y7@gmail.com>, Mark Brown <broonie@kernel.org>,
        Varadarajan Narayanan <quic_varada@quicinc.com>,
        Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        Md Sadre Alam <quic_mdalam@quicinc.com>
Cc: linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250731-qpic-snand-oob-ecc-fix-v1-1-29ba1c6f94e5@gmail.com>
 <72d5f805-1637-4c82-af25-e78b978c5799@oss.qualcomm.com>
 <8883471e-57b9-4492-8d4a-aca3b4538682@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <8883471e-57b9-4492-8d4a-aca3b4538682@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: aGVlji3maMMvBvoG50TkVOwUDO6zjBVO
X-Authority-Analysis: v=2.4 cv=TMNFS0la c=1 sm=1 tr=0 ts=6890779a cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=sgHexgGcLWnyGziH-awA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDA0OCBTYWx0ZWRfX6xmu1/1NIuFH
 kQstA0Hz1AuWqZrr6G9HrK/hbNFAPteKuAMghYAQukz74yMym/ohA7+xD4k8bAorO+ymLRdlFr5
 SHg3EadS6pA8PnId8tLX8pjqZxyb9hD3bm3zPTolDxuBfmyTf9JkBZ3KTvLeuPZUNDgshdBHh0G
 RntWgFlMmhgI98pvSH2DB2CrqdtGpw1K7zrQ+c82F/8PBFN8UVwoikumMxud1qI6suSTNyFYCg+
 htNXVn7T+UuG3W6FKD292WP2eQYqsIKYMzXERlDQTYuhi4PQ0KHzjf0p84+HFsQMoLXUKUQNX5Z
 YYDokOoSuVln3CgsCvrBzRmtY6xwEQNSpzEKf8uIoPq7ClHF1luslYzP+6++1TJK4b4Ikpwdi3O
 f04hF3DRd5R9H1NI7HDWq/IZN9gt4ugjNgTfrKnKdekXRDx4R7/HPdxs2CoVDQxXZxwj3JiE
X-Proofpoint-GUID: aGVlji3maMMvBvoG50TkVOwUDO6zjBVO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_04,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 priorityscore=1501 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508040048

On 8/4/25 9:22 AM, Gabor Juhos wrote:
> Hi Konrad,
> 
> 2025. 08. 01. 13:56 keltezéssel, Konrad Dybcio írta:
>> On 7/31/25 8:11 PM, Gabor Juhos wrote:
> 
> ...
> 
>>> --- a/drivers/spi/spi-qpic-snand.c
>>> +++ b/drivers/spi/spi-qpic-snand.c
>>> @@ -213,8 +213,16 @@ static int qcom_spi_ooblayout_ecc(struct mtd_info *mtd, int section,
>>>  	if (section > 1)
>>>  		return -ERANGE;
>>>  
>>> -	oobregion->length = qecc->ecc_bytes_hw + qecc->spare_bytes;
>>> -	oobregion->offset = mtd->oobsize - oobregion->length;
>>> +	if (!section) {
>>> +		oobregion->offset = 0;
>>> +		oobregion->length = qecc->bytes * (qecc->steps - 1) +
>>> +				    qecc->bbm_size;
>>> +	} else {
>>> +		oobregion->offset = qecc->bytes * (qecc->steps - 1) +
>>> +				    qecc->bbm_size +
>>> +				    qecc->steps * 4;
>>> +		oobregion->length = mtd->oobsize - oobregion->offset;
>>> +	}
>>
>> How about
>>
>> if (section == 0) {
>> } else if (section == 1) {
>> } else { return -ERANGE }
>>
>> ?
> 
> The current way follows the implementation in the qcom_nandc driver, so it makes
> it easier to compare the two, but it can be changed of course.
> 
> However, since the 'section' parameter is an integer can we agree up on using a
> switch statement instead of multiple ifs?

That works too

Konrad

