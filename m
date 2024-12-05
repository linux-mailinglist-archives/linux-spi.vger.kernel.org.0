Return-Path: <linux-spi+bounces-5924-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4838C9E5CE9
	for <lists+linux-spi@lfdr.de>; Thu,  5 Dec 2024 18:19:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29CF1166188
	for <lists+linux-spi@lfdr.de>; Thu,  5 Dec 2024 17:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6205224AF7;
	Thu,  5 Dec 2024 17:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AolqaUjO"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA6938C
	for <linux-spi@vger.kernel.org>; Thu,  5 Dec 2024 17:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733419186; cv=none; b=mE12v5X5GNgag9V0pw7Jj0Re0DkVoEq9Y59i4ga+mIkwMtgMdzBggZUg7AfkSpB3l5cyD4HUuqlBxj4K7eXuCFjlaIA6pt2P2VGsXz78pGYrk104U93gEmGU/bJwTLFXGHhylWh+Lss3+DRKc3R7XcR4a57ZrIzoFtFcAjXHtwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733419186; c=relaxed/simple;
	bh=lYUjWc6zjIdoVN44M09qv+uz55wgl/dR+Cu8fHg5GZU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s6uWWJHezYYhf/EZdqhn41CCQ7q4H2bIkkU7emGiWciOtdm5I01FxQ1ZastkgaiAnPU6zXNH+ekJQA96LpY8xS4V27wUZ0dc05xcuB8QHoWhSmdtXxGfRlj/73X9xSrjqjIsGL+QDeO8o82GpuANRceWfMaBhN0FTkgVN3UOI+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AolqaUjO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B5Bt2P6026094
	for <linux-spi@vger.kernel.org>; Thu, 5 Dec 2024 17:19:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Lm5ndeOU9990FRIjr0qyFHytkSEpGFifKLWwIXMxeEE=; b=AolqaUjOIngK9iOV
	pWktVOg09Db03+kC4HTTv7tj36rXe+nTAdZHethGlEQZEPYleAaszL9/dmvjq0sg
	Gf1CP9QNu2izii7tf4K2e3ggJxwQ8UJwjw36r1JEqgFFKtUQLt/WYwIjLO39sYKJ
	3cULLaqhGFtoE7OYfLSlggiOOmijVpBvbkwekn2cudLwJDxBa/3s5EiUOlAuVbMR
	ZAsDbrZy8o3+JBDPJiJS3LzrW08s2+PwtkLsA10HTLpYSHpFvKD07aQnu1YrP2hw
	5yVs48nom/boGOT1zTEeCWhS7AnPxBpUt8pagPe0K2+4xx1rpu7ajaHs22ObAW1F
	B2q/JA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43bbqm0w29-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Thu, 05 Dec 2024 17:19:44 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4668cee0202so2070901cf.1
        for <linux-spi@vger.kernel.org>; Thu, 05 Dec 2024 09:19:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733419183; x=1734023983;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lm5ndeOU9990FRIjr0qyFHytkSEpGFifKLWwIXMxeEE=;
        b=dBSDwxgR/BwKtlVReEcXiiRfS7MC9PqHGHbcDpxFdurJCXcyhrk9m2+0/xhIwh/LVS
         xcN0PaeDtTZlnE2NjHB5BmagRlanJ6rxQWUTYKBJ1/BFQzerjbLUxKmm0WVCdo09wXjf
         tpblKbpN3Yc/Iz8GwPu9sLMpc5vNXI4mXyn07cuimuqgcczkA2fRSExwgjHCrI9J8TOs
         sJJ4T1Ees2euJuyMm7ZvNbfCNB+0QaX/FM+uh4QN4V+ONmGd1PuAXvEiobfAWLENUcbM
         cCMJsxVnGzxiRxxtcTK1doH2Z1WxKiqIJq/ugmFZRvdFE3o1dDE9i6qSkIlGmSV+Tgks
         iWuw==
X-Forwarded-Encrypted: i=1; AJvYcCVgLH71JjUsxUOS/MXqdqNhwlipSMwI05Sd0ATTzc/uYu/gRP7Qg/qIxzZHQST9Ig/BluwY+SozOUA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwMAEA9sncLPJMIARs3rKCgdlxdvmrwyC7mD1tDBOPFXhybWXM
	45vqk+c9aztD2HXQZFPhmKJziic7Fwg6f7AD6r6jSuVN6g0s5wDSBCQiFLJE5EOfetvgm5OivCf
	CzEUr9ftpLn5Q372Gz5AqRXdyNYIGwgVaa0RQEB5K4WDURqfogbc0VJG3zno=
X-Gm-Gg: ASbGncu64SYp+nnqYwMy5U4ztosK64rH870oAyduE23eJ94rq5Km3/6ofCyPtBoLQMN
	UiAsu8xQb45RNZYv6eSMZfIOiwut6rRO8niuT+MQKqvdVSp/+VnRTyfy1MRAPsa7PbxL/5SGNiU
	r7j+71tIQvtUaFcZ+JUSVfNpsitbfrUFT9AV1uZPCycLAiuM4yUy4rKEKSrq1mzdDQDB/GC6Q+J
	dHgHyn2TQyz195O6oQjbu9n4AwhX9EPjI1nuG0CvPc8MAlcw4fHWSPrr4bSMtjF/RN4jFaI/SGT
	3iiB/NLRgRY5leIv0z+i4YdwgpUFKMw=
X-Received: by 2002:a05:622a:1811:b0:466:8e17:cd1f with SMTP id d75a77b69052e-4670c071462mr65629401cf.3.1733419183506;
        Thu, 05 Dec 2024 09:19:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFaJmOBmk5E91zDvi4GqqziQOrLODRZopwm1Xkdm3u7K10bviytIQBZzrpav1hnIkMXbYrY2A==
X-Received: by 2002:a05:622a:1811:b0:466:8e17:cd1f with SMTP id d75a77b69052e-4670c071462mr65629191cf.3.1733419183166;
        Thu, 05 Dec 2024 09:19:43 -0800 (PST)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa6260e048asm118968866b.175.2024.12.05.09.19.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2024 09:19:42 -0800 (PST)
Message-ID: <02e2640a-22ce-4586-bff1-7f4eaa20cd7e@oss.qualcomm.com>
Date: Thu, 5 Dec 2024 18:19:39 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 8/8] arm64: dts: qcom: ipq9574: Remove eMMC node
To: Md Sadre Alam <quic_mdalam@quicinc.com>, broonie@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        andersson@kernel.org, konradybcio@kernel.org,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        manivannan.sadhasivam@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Cc: quic_srichara@quicinc.com, quic_varada@quicinc.com
References: <20241120091507.1404368-1-quic_mdalam@quicinc.com>
 <20241120091507.1404368-9-quic_mdalam@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241120091507.1404368-9-quic_mdalam@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: UXf3htYDA-FiIyu5p2jkhKm0Z7p9oagp
X-Proofpoint-ORIG-GUID: UXf3htYDA-FiIyu5p2jkhKm0Z7p9oagp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=722 spamscore=0 adultscore=0 suspectscore=0
 malwarescore=0 mlxscore=0 impostorscore=0 bulkscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412050126

On 20.11.2024 10:15 AM, Md Sadre Alam wrote:
> Remove eMMC node for rdp433, since rdp433
> default boot mode is norplusnand
> 
> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

