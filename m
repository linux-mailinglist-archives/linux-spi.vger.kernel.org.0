Return-Path: <linux-spi+bounces-9336-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E4E1B20238
	for <lists+linux-spi@lfdr.de>; Mon, 11 Aug 2025 10:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5ABEA171F04
	for <lists+linux-spi@lfdr.de>; Mon, 11 Aug 2025 08:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17DF72DC331;
	Mon, 11 Aug 2025 08:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QTcq147/"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CC92DAFC0
	for <linux-spi@vger.kernel.org>; Mon, 11 Aug 2025 08:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754902232; cv=none; b=udrcsEQy/EXElnC3T2RVr7MRe+aE3EokgZyOJbTeTl5L6ejT23OaxmNuPUfMZZSl2Uz/6a38SlWXL6fpoNEMnhcsytnOYXg6nf/FT7M6fmoPtqFDTyb8++MPeZW4/ujAXANQXHFeXyiH31H7bitwCVgpIUxvfWeX130pJsO28VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754902232; c=relaxed/simple;
	bh=CPGYrDDgQzIYUKiy0aUthSOA854YrLJiY4efajvuJCo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bwe4QzN7Xn2VW/ZudLubNcLcWXGLz0by91thFAZtjR89VtKx3tS05VQv+wi+U6S6MnBgWI0USTeTYv1ehAX9JSTbznbvOh9y9fwbTIdnvE1TorwqgxuiupPu9xm8Apn9M013FcCIjgZ3S/9C5ppk9J9XPmapEdNA82TIACg5UwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QTcq147/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57AMvKLp005527
	for <linux-spi@vger.kernel.org>; Mon, 11 Aug 2025 08:50:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CORAd2r8QfE5VI6wSh8ExS3y5u32gjUiHVIBXtOTHh0=; b=QTcq147/b9gOi54Z
	MsLQigOnChXxV4MT8/Vp7U3F/gzGF0mARNbqo4TOEvFFpWzEFX/x9tA6Zig0Ah3a
	nZ4q+4G6/5DNTBG2qYY615/5wAQ/2LAKl4+BESCUTzgOEE+QvH6ZgPDKaaUYVUyS
	5GH4s8krsaGl8NdmNIrXbpDNaQCxHvb5mzjWlEwX2SDyBVanR+Pua80YD04ivzlw
	jSllyohKLQmoiF8DOAIXF18iKiMEwU6m3oNcGUvcPqatsrv0GHO32ajVIJMm2epy
	J/QxiHIV8OjJmV25BjxZuaE3UG3CPMjN5jdvM1msmPepTagC7EOQafQnm/vDvLTQ
	mepANw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dv1fkwk6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Mon, 11 Aug 2025 08:50:29 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b06ad8dadeso10226671cf.1
        for <linux-spi@vger.kernel.org>; Mon, 11 Aug 2025 01:50:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754902228; x=1755507028;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CORAd2r8QfE5VI6wSh8ExS3y5u32gjUiHVIBXtOTHh0=;
        b=vkdhVRc3MedGgGcU8dAEGs3o1dyOLi+9u9X47xiy7i0r9CD/WhHRE7jRFS1UXg3TNj
         yQ1HzPmGHWp6L7xkqsrpdTqQ2fWk0UIfRTp+DNw3lxVwl8p0VeHkZc/+Sgm2HpDV9t9F
         tdUVN8nOP1lCfuqSOAJo6vOLpmqnOhg3pwYfxXHSjcmrvmtt14+cyJvnGTI17qPlv7JQ
         mX4Rw3YYDEZNIiyqxvpDdQXpzIFqWmzjNxkdbKBbW8XtdmHH8C7lm2WpuNai6q8L3qUN
         WlLrXuB1OjRmVsDZWiBJ773Y3uDDreLKz8KY3tYdXQkrzNWiNe9YnRx2Ga0NSZ/2FENy
         Ld2w==
X-Forwarded-Encrypted: i=1; AJvYcCXlXRFnjN085+cm/TOXVwSXQvlfxzQBZte8G+c6iJ3L897+YeZCcbVGOCUyAcktsaw/Cl3/wn+1DCw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLgxL6iZCJ5eqcd7k3xhx8JTbnh2kLVREhZz5UMJkTHyBr0Ado
	jL2wAe/0mqATcwdnpfuCDGqTQWR0YeznRGPB2WfvXuYBe3UluwQug7w19NBsIoizDFy5MJbRdYV
	TmwQnbsOa2ov8uglb0oumeTBzxmxDboChQ4UJ8mjY+Pt8OxQSy/3O6B7Jpr7OaBk=
X-Gm-Gg: ASbGnctdGd+stq1HlRLwn5Tmhc8cKg/DhdeMDJVwAhevyhbjfAytQ5/+9dvaGIzS9fF
	u+OEqJO2Cp7RM450ZG36Caw0oHPoV7zdo7WN0RN2eRUkHii2brsRH4ti9aOpTAsOgNrVvQGU/g6
	TnN9I9cogNQheQddHwKMqckyp8tHmc0GvpCM/8SVvmFdio4t/Bh4pPpj2YrbSOpL88kpMGoAe4+
	xRtrOz518frMV5fBWLFDUNYAV50I3afcrmBudqzQM21FrPcHWE76QRKj6q1iXS3V5prRcNMt0p8
	MOdHRiSxNWmgy0EmVuuIz2NJVMeMgrYapskwyE+p5woA0byRMEnf8ZvEYBaiIDL9CERtGpzorS/
	GRiG4q9Li1NInSouG7A==
X-Received: by 2002:a05:622a:1ba1:b0:4ae:dc5b:5fee with SMTP id d75a77b69052e-4b0beb027a8mr52894041cf.0.1754902228413;
        Mon, 11 Aug 2025 01:50:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2gL+G3g1eE6R8szJqv85HPPf+VErr9fLPtt2IIDrlbNUHP7zeIYNUyGibJo//rQDUPs1VWw==
X-Received: by 2002:a05:622a:1ba1:b0:4ae:dc5b:5fee with SMTP id d75a77b69052e-4b0beb027a8mr52893851cf.0.1754902227923;
        Mon, 11 Aug 2025 01:50:27 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a1e820asm1977227066b.90.2025.08.11.01.50.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 01:50:27 -0700 (PDT)
Message-ID: <cc24ea01-549d-43df-a3d0-62f60c79d5f6@oss.qualcomm.com>
Date: Mon, 11 Aug 2025 10:50:25 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] spi: spi-qpic-snand: remove unused 'dev' member of
 struct 'qpic_ecc'
To: Gabor Juhos <j4g8y7@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Md Sadre Alam <quic_mdalam@quicinc.com>,
        Varadarajan Narayanan <quic_varada@quicinc.com>,
        Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250810-qpic-snand-qpic_ecc-cleanup-v1-0-33a6b2bcbc67@gmail.com>
 <20250810-qpic-snand-qpic_ecc-cleanup-v1-1-33a6b2bcbc67@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250810-qpic-snand-qpic_ecc-cleanup-v1-1-33a6b2bcbc67@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 4-qtU3WrAe6yfB-DklJWj9w2Xx73nOKu
X-Authority-Analysis: v=2.4 cv=cLTgskeN c=1 sm=1 tr=0 ts=6899aed5 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=rbI749AxHwL34t2NiqoA:9 a=QEXdDO2ut3YA:10 a=bDEiuqbIbRIA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAwMyBTYWx0ZWRfXwEojpH2IkeZT
 A5OzinwYLRiGY2I5Go/et6UhWKZW5zL1TSN89v/VUwOBh21UPXPQ4zNqttZI7WJiyhWFKHcBli1
 KmBX/ht+4ePaZk6gzeW0S6yqlaW32usKqql5zRb3HU1tMOySzF6mTUWekzm8FQKnqfKw/7+WQip
 GneGguH1+U7vHgukPkBgC1L+GpUeG43BGefo49aS7ShsSbsv56M090bDv/zQztuNkoLrGUFxtqe
 Z0/eRJYv4TJ0TOo/lRMkhiOsN0QlVu36AWWm+9Xq+9eoy6sXE27wBFmCr8UB0uf61N7/OihIhxT
 2hFRs62uMOcXpRh7Nm7QigGy9Bsb6GWBSIYLW7Xq0yV8Q+7FmEyPXeGWv+zevTvoXQta4+j4jzA
 FrbYfTCI
X-Proofpoint-ORIG-GUID: 4-qtU3WrAe6yfB-DklJWj9w2Xx73nOKu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_01,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090003

On 8/10/25 4:38 PM, Gabor Juhos wrote:
> The 'dev' member of the 'qpic_ecc' structure is never used in the
> code so remove that.
> 
> No functional changes.
> 
> Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

