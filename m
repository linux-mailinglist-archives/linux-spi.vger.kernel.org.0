Return-Path: <linux-spi+bounces-10468-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF816BC4CEE
	for <lists+linux-spi@lfdr.de>; Wed, 08 Oct 2025 14:32:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D810D19E20D9
	for <lists+linux-spi@lfdr.de>; Wed,  8 Oct 2025 12:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB39243951;
	Wed,  8 Oct 2025 12:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WC0Ya4SP"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB0723F424
	for <linux-spi@vger.kernel.org>; Wed,  8 Oct 2025 12:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759926694; cv=none; b=EcuINRMHO5bXv5W7Xm6+t02WX/Lej1v12PvsElg9Ml0kdv41tKVL3Y80tgRkqRVl7cL/6OVl1qldAP2q+/fpXePUjz2Ggjaiddb20YxgSVBLZTzVi9xW6DiEn27UPFJqlHE5/nG8YN9S+ivU6Y46M3QfGDhLCv+GovXVGaOhYfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759926694; c=relaxed/simple;
	bh=ATHazlMaG3uXrz/8bapVZ0QyRnQ3LTj31ll9TPp9054=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qqa0BewV7iqJwMXEilRQAuOpG+ba28/5n3MDT1D1egWKKQY7LZ8Fz8/+r1amlOUVEQCLq/wphhrn2NomhhMItrfiQkc58H4oT6d+dS+61tOpeyXxWW7FOZA1NEQdfVPI+f5cdsCpOpyVGBlcLXddTVMgTwPf4rbrwEtAGryueOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WC0Ya4SP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59890PvV011898
	for <linux-spi@vger.kernel.org>; Wed, 8 Oct 2025 12:31:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	W2xJeI3OG9l4i5P/NiO0E6EXHSuabja0k88qJFuiXuE=; b=WC0Ya4SPaTu0KwZ4
	FTweXLcB3jSodnqWhwuo5dwMkiTuAC6SVx+mwi+wZSrgekVIlCtrtSFEyPbhtMCO
	Y2KvqLuxIORVAk0BD8Q2XrumwCGcLhnV25TSVTlXEYMXk/TyA30NjQOwigqUVkta
	J0Cxq0q/CIG1Eyq2/yRzt8Ofam48l/FZ9oI9dMibVVwthHrOLplHhvXrMgm2ayW1
	quAGp42uoohAm4tr253GOnYYtpXouyojAkFnqMii4Tkrf63WPd+M+XtDugY2ctPO
	kdXQeOMKlzNHXCaBufK4GxLuJMVDKfUbZHq18ZyMj6MwXP7WrZ/xaHNBMZHrzmvd
	Oe2TYA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49mnkpwara-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Wed, 08 Oct 2025 12:31:32 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4ddf2a2d95fso26239801cf.3
        for <linux-spi@vger.kernel.org>; Wed, 08 Oct 2025 05:31:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759926691; x=1760531491;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W2xJeI3OG9l4i5P/NiO0E6EXHSuabja0k88qJFuiXuE=;
        b=wa82iijE3ITS71Vj3ZrPh5SPXogU8O8IpLed3c70jOdliLcrCgGM4Pz9UJbPoe2ibL
         sTTVoX2JSIqIv/mb8qbpZmrj6NKU9zvx+ePL0WVXNPKCYwInPZIpRG4yCuTA8s1snBZB
         mV4UkG1faY5Q5Ywvee/0HV9wfZxGxcQnlNQo27C4FDIAO1YWd5sgBzlrn2baKk1oxK+q
         pPqnW7sIuCHVLF1JfwZl2tArgynddgMPrCVt/+7jE62+uJP4G0o1m3CSP7lwpmumHCOW
         oIqatEwjhQNNXHm73vtIYhXoX2M6L/bhYXQqRa8WowqqC7uG/ipFx0ALJJR5HenDdk9z
         Jamw==
X-Forwarded-Encrypted: i=1; AJvYcCWRena2QiKuUEQtknR18qxFRx09NFuq71ktv6TxYmfpGvGjJYLks2uONZ5xb/s/r+1+RmbGH/lTSyY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkBPORkZfQ9kcfw3OrAJXAdBHt5AQMssgUZfp0ZiJ7jZpmQhtx
	DRzHRzt/i7V4mVWKKV50W0gUTw9Z5Y/agvfRQUXX3AwqxUTOajsZHsfhdtrh1n7EwYoy0mbrl0n
	NOrjS46DR1ZOrmSpGwA0jxBSwzeBAPGL8B56W9+nkPJZ6y5Ypj/BiU/83iuuslNk=
X-Gm-Gg: ASbGncvbk/cTxmhb1RhnvA14V4zzT+RqWRKuaM0ENKFH3viBi0Gt99n94DWqk2VZl6V
	2le8zSWXxSGS509hBt7U45IOi43c2bmOhgopiasgnmQrUkrAlEqRMGePNQpvQbHLqs/DChJPuhm
	4vZ15TN5D3304gKBmf8Lu/UII/KrYDuuYjZA8yGaZS11mGXFkAq1Fqo/3EBLlRoRuU/MZwjDQXj
	lmX7Ca+VuwcXZpBMUIKWIxn634iPA14kyXQCrQFVrifMrH/86SQKPjQdp35VrwVi9aj4GkG6w+U
	McG3mi/m05OhWelBPEC1pbVLgs+C6eGbQWtZaCUVHt/uiRr2sY+HZkpaDE4nV41cM+QjTI+Wvr7
	ieu6nzbIZ3Jmwu6K53gsf+EbZ7H8=
X-Received: by 2002:a05:622a:60c:b0:4d9:ac87:1bdc with SMTP id d75a77b69052e-4e6ead0aba7mr29275061cf.6.1759926690681;
        Wed, 08 Oct 2025 05:31:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFf19WcSpWdEUFhuwsgE9dJ2DJvAeifUnbLDZML0K0s/i9UQH0GMuTwSzetRW1A09yhfc7ONg==
X-Received: by 2002:a05:622a:60c:b0:4d9:ac87:1bdc with SMTP id d75a77b69052e-4e6ead0aba7mr29274531cf.6.1759926690078;
        Wed, 08 Oct 2025 05:31:30 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b4865e7e8d8sm1639249266b.41.2025.10.08.05.31.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 05:31:29 -0700 (PDT)
Message-ID: <0ebc651b-e174-411f-9ecf-c165edc8f754@oss.qualcomm.com>
Date: Wed, 8 Oct 2025 14:31:27 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 9/9] arm64: dts: qcom: ipq5332-rdp442: Remove eMMC
 support
To: Md Sadre Alam <quic_mdalam@quicinc.com>, broonie@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        andersson@kernel.org, konradybcio@kernel.org, vkoul@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org
Cc: quic_varada@quicinc.com
References: <20251008090413.458791-1-quic_mdalam@quicinc.com>
 <20251008090413.458791-10-quic_mdalam@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251008090413.458791-10-quic_mdalam@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Bl7GK9gapFOScuiUlKcRBlXPsKN28Q8m
X-Proofpoint-ORIG-GUID: Bl7GK9gapFOScuiUlKcRBlXPsKN28Q8m
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA2MDE2OCBTYWx0ZWRfXzWrsUHpykwKU
 HfBaYQRNu3PyqhdTIve9mR6fWhKNGcE5AvU1DP/Lx8P4kTK49ovHQwuEUuoeY7juiRn2Rn42LFD
 OEGQyKUHr7RfKc9Z7BfnZwroLA3INI5m5mSRj9ElMyrIHm5gK7jNTZRCYv6eOLwG7cjvFCkO3fu
 AjSzqQihlZV0auusj1pWFH/yJ6zYzyKiMvYPb+1uat9cPIRjmcW4CD0KUKXr1TN6zja81tJlH8g
 fAA1zom5NLM7zoyIaqZv64UzIQgdqurxAyQXaCEh1+1IICa+yaSyCxoxMYAwAW4OSWjvNok/NmQ
 gnHZiSJgx55oZ9vSOq3aTrMLkGhQFSP6o5IdeetqMYtBuXLxsQTdzDKb0iHfwcxkAVhpfFqSmy8
 ZX7IcKHqSVvFSeFtWqod0cKHCDiWNw==
X-Authority-Analysis: v=2.4 cv=BuCQAIX5 c=1 sm=1 tr=0 ts=68e659a4 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=VaBRgJVrheE2JgugGuQA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_04,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510060168

On 10/8/25 11:04 AM, Md Sadre Alam wrote:
> Remove eMMC support from the IPQ5332 RDP442 board configuration to
> align with the board's default NOR+NAND boot mode design.
> 
> The IPQ5332 RDP442 board is designed with NOR+NAND as the default boot
> mode configuration. The eMMC and SPI NAND interface share
> same GPIO
> 
> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

