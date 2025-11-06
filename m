Return-Path: <linux-spi+bounces-11094-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DE72EC3C7F0
	for <lists+linux-spi@lfdr.de>; Thu, 06 Nov 2025 17:39:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3430B502966
	for <lists+linux-spi@lfdr.de>; Thu,  6 Nov 2025 16:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2666034AAFD;
	Thu,  6 Nov 2025 16:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ydg14ijM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ejb1xGIR"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAA934CFDD
	for <linux-spi@vger.kernel.org>; Thu,  6 Nov 2025 16:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762446436; cv=none; b=VumoLlZkCk87ou9z9+30ev1fEry6mpLWU4qQeqkFe/ofbtRkFU4F31oDpQepVllfuBmtN/9kwahFAxLCEFNqGJuuO5B/lo5J4JsS3Wud/AjgQpn46A9xCl1G1TpZfxmGL7sxi53LSRsOLOqRxIzba6XIXWSvoby3EhSCcVTR7uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762446436; c=relaxed/simple;
	bh=hUjqN3UmpFYq00xIpLfCIerEemZqaq/567W5oV6EEVo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OiWUy4nNdb1sCz0he6Ka12afQJEzfX+hYQmJohF9Khy4tyig+duG/+b9Zlr7iJe0O6awOpiG9enqa8cCbIuJ5Qsv26WJUI8xx5cN3xnGqqidzlc7PDTr3nEOqr7qk3nby5+GaM2mVuechOAYOFceeZoFFLCRvBGvhsaFs48kFQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ydg14ijM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ejb1xGIR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A68bpVb2165126
	for <linux-spi@vger.kernel.org>; Thu, 6 Nov 2025 16:27:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1VaDp85O3a0ogLuE5Bn7wN2ygZpImA+jz5Nmrdl9jCU=; b=Ydg14ijMuPUiIsko
	KC0mTT/xNVdWJ/OhNSO6upps3QnhpE17KxJKkJPyLNFL6/ytVAi7nhO4r9gHGIFo
	KvqwWFLvmZejvzdzRN/9Xpbc0hSMMm6ew0JXQ8xSedWzN8ivlhyHTT0PSZmRSQf3
	5Rdzm2k1yRcMkF9iTBIzVOOsYAg3Ibmr8pO0yTW4fGAfnFXmlU+ABaY7iGcyawB/
	MnFHAcnSAuoa+oIZJCWMhQ+umGjHLkdPraT7dggXQpI7Gb4s3ndAIML7QKd5m2A3
	qXR1QsDoIxKSGKyAZ1t0kZ9SejzNTMVQTOwQdYmp0C5pLsh/ox8VKwpmQUnZiiMW
	VCguMA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a8g6etqsh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Thu, 06 Nov 2025 16:27:11 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4e8934ae68aso3941881cf.2
        for <linux-spi@vger.kernel.org>; Thu, 06 Nov 2025 08:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762446431; x=1763051231; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1VaDp85O3a0ogLuE5Bn7wN2ygZpImA+jz5Nmrdl9jCU=;
        b=Ejb1xGIRw9EUqjDct6EqiD5aAyP5DSBylSdhVnXiILZzRRJjZnV0buXoljxeUF+5Ln
         +8cwndAdd/7PUlPqfArWaycPb2eDyrSpSTqhHBL/5S6cqPDfR3gDBRTCWkOQB0vj0epO
         xLBVNgM9wa3FteIUgv9abSu0zMvUES/n9h279a19n83gXtmMQ7J4NRK4/2eZwqaKQQjo
         6DoWyosGjMcR0/tln13WpWNzjOoeuMZHvavsnWjrbbYY9vsEb7MuYnu8obnkZE3uO9jL
         U4RQSTH1w1wYrDf/aKdhUpsxGlG1UEi1wlu+hc0PBep0FnL+0TpspwLu353PHKw2CvJA
         nPRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762446431; x=1763051231;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1VaDp85O3a0ogLuE5Bn7wN2ygZpImA+jz5Nmrdl9jCU=;
        b=d5OaxouNcQRLtYFlVcQ5OLt3lzzUGmsIUrrIKbstngICBxD4msK0lgOonlXnM3G0oT
         RxuH/OeSTYfOpE/vvjDpY37emxBLexSGlOaN56FIYhXMwmO/xVyrOhHCsDHamJUIX+E3
         Q5UenW0zBPqHO9LoRN6OapZ71oH5LjvclvjIATSU4Jqn7fLJEI7Ed/tCm6xF0x7ZJ0WV
         u3Bod8bYYap9rayu/eQ0G6myg4qJkYOySu0bstlnNRvt9Wfeek1cpEWsp2rW7jm3AzoP
         zaQ+ZnbWPudiJJzh/pOJiCiEC1V8lbMLMrSl/uyXq0loI9QfOxv4j8aehKTODvn35EZ9
         lWYg==
X-Forwarded-Encrypted: i=1; AJvYcCUhk4MLpIPShBRIWywu5kZeFPH1SWVQ2i66xwX3noUWX5lLA0xm+4ZU+12nhybpfmTB3gJylGK4uwI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu+6RI8ghrLC8Rx6x4m1+0Qa2R4GKk2cXQuwx+lwYlgHJSwxdn
	nEuDwkoA02ZIkmIzv51hIy4WX2YxYMDBgHiZAFoFEZp4b6q3EKv2zIZTQdRcU9TpQKkyD9QOFjP
	u7OSj1xbBy4B+X2NRQGE3Kir37EaMpyxJt/gML0BrTRzStUuGYdpp24+D1QgVDB4=
X-Gm-Gg: ASbGncsj6LNxfyzBDc5DnGrYB6qxQofJpFLdHD0kYzlp9gGz9EJi3CYN4OY+B/S20gT
	lyIh3qcE+ZrArh/n53iHOyqQ50m7Iq1R66EY2xt55paTiHy85Gkyq3oOgJmQiKf0z46gbVdhmik
	cvjGsKKBP7Onol+XJpD21vHRj1jHnIkNMU5QZ6ya5GJPXI4anIggvBKiEpc0ZXlz0ILXf5AmU9n
	FxkTqsNXeCAN8yE2V8YMEE3Ti8suLsU3OagUeP99askw1Gn3/W8vMJa/m01GM6EY7UQxlsC8neI
	w7lXnyfJ+v7uPYdx2XdcD9YVn0hSDQERFRCBjTVM+ar/rE5hOSb6Ck93wSCc3253rE5pn9syi85
	PTR5IQjfcTA2Kkhj4kPKPWURI0WnZg3HZLYfzBkJkWRMNVJkjMwqbWXcb
X-Received: by 2002:ac8:5751:0:b0:4ec:ed46:ab6d with SMTP id d75a77b69052e-4ed81554e98mr31937081cf.9.1762446431058;
        Thu, 06 Nov 2025 08:27:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGch4/nmENfqzYvd9p/t3ol3PAJQJYH7BPeMAhJloDyKCtlTa4jeKX7kLqaIJ92wnHC029zUw==
X-Received: by 2002:ac8:5751:0:b0:4ec:ed46:ab6d with SMTP id d75a77b69052e-4ed81554e98mr31936541cf.9.1762446430436;
        Thu, 06 Nov 2025 08:27:10 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6411f8575eesm2131956a12.22.2025.11.06.08.27.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 08:27:09 -0800 (PST)
Message-ID: <17ba4580-bd78-4bdb-8e19-b326aadd3010@oss.qualcomm.com>
Date: Thu, 6 Nov 2025 17:27:06 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] arm64: dts: qcom: qcm2290: add uart2 node
To: Riccardo Mereu <r.mereu.kernel@arduino.cc>, andersson@kernel.org,
        konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, broonie@kernel.org
Cc: linux@roeck-us.net, Jonathan.Cameron@huawei.com, wenswang@yeah.net,
        naresh.solanki@9elements.com, michal.simek@amd.com, nuno.sa@analog.com,
        chou.cosmo@gmail.com, grantpeltier93@gmail.com, eajames@linux.ibm.com,
        farouk.bouabid@cherry.de, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, mm.facchin@arduino.cc,
        Riccardo Mereu <r.mereu@arduino.cc>
References: <20251106153119.266840-1-r.mereu@arduino.cc>
 <20251106153119.266840-5-r.mereu@arduino.cc>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251106153119.266840-5-r.mereu@arduino.cc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA2MDEzMSBTYWx0ZWRfXzaDFpcNTjyXj
 DLmR6xzXJEkBpZVp4rIClWVWB2UjdZW5/li9XZl1YtSww/ef9bh3fY50M/uj+HYLy6+/ujtwcQX
 XrEAqVKY9kx5usGpMlNclqtDTc7LOetDJOQx99fcGA3JHDxyLvp+e4YYaJw/WiO31B+ck0zsR12
 S6wGy0s5TK7/7JbuGV/vEK3IMqbTbeYvut9n6DNoOACWu1LahUydkT3jY+a8418TtaW+XiIqRCa
 C2BcQ5Efa+nb8Ab8MFvJ7GtN6CTL5xlc65LrmuXaftrYVDHJNb2LmCyxpl78YmqGoT2Cx1hqZZG
 xon0vMHXSUAC29gHmSQQVmHhdZn1EdOseUQLI9z7PTD0lW9W7M768T3qZP0uR1Il3l5eP7XQDS1
 HH0KHCU2AWrhQtdNjmIZVI3j0VOW2g==
X-Authority-Analysis: v=2.4 cv=D5FK6/Rj c=1 sm=1 tr=0 ts=690ccc5f cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=D7qGd7DG7pF3fn8uCYwA:9
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: YCP5uiraeXCC0aXgkQhp3vI-tVtwnBrA
X-Proofpoint-ORIG-GUID: YCP5uiraeXCC0aXgkQhp3vI-tVtwnBrA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_03,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 phishscore=0 suspectscore=0 impostorscore=0
 adultscore=0 priorityscore=1501 clxscore=1015 lowpriorityscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511060131

On 11/6/25 4:31 PM, Riccardo Mereu wrote:
> uart2 is used in Arduino UnoQ as an interface between microprocessor and
> microcontroller.
> 
> Signed-off-by: Riccardo Mereu <r.mereu@arduino.cc>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

