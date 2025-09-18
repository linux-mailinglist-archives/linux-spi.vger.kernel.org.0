Return-Path: <linux-spi+bounces-10113-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2B0B84A69
	for <lists+linux-spi@lfdr.de>; Thu, 18 Sep 2025 14:47:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9ABFC7B7723
	for <lists+linux-spi@lfdr.de>; Thu, 18 Sep 2025 12:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB83302769;
	Thu, 18 Sep 2025 12:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Rtn7nfEp"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1F62459ED
	for <linux-spi@vger.kernel.org>; Thu, 18 Sep 2025 12:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758199620; cv=none; b=t4R1exiOG3s+hmv5VRJ3eo4WSkGyv01Eu37oCJgUFBnTNubx5bXxy0Qz9HOWkujjDF6K6sjmrIvpgBzyPpwJu9e4OqTWtmd26MXEh99c8t62WHTDbdFEtFzJ4djA9XbpK0e8FeQY/K3AFexecewFie+gvEPDzkH5oYefTETMs9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758199620; c=relaxed/simple;
	bh=QcDU0S/gGtyrDJoonhlOJQKmYDHiNPBGxqw1d4DtiHI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YpnjuDdg63Z9XKt9HpJJXuVLfsC06vuFbqW/0nyyjIHHGa9cgR/9pwC9nylAToGsNpy1BjkPUOeCBsL/pzAdSl66Xubpe7IBsAEhOgF47IEqWWPoiPh2VwBfKmFeTtbHUtlgwwKBTNxGOneMDqocU7U79ldZ/pjFKUfYrV65uBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Rtn7nfEp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58I8Yn68003351
	for <linux-spi@vger.kernel.org>; Thu, 18 Sep 2025 12:46:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FQi6E6p9KLnZzlas4XjllmXc+yprtBYyqANSQeumeng=; b=Rtn7nfEpcgK1qY2v
	cgDmu2IVJTGkcyD6haMQgdNdKYiZ4OiXURc2a5BOfNAm67kRCYHsUgZ67lRIDFUP
	YvWmDhfFE5yBPLWzh3FtHByfwVKGHkP63RVaCOv0K7qwsj1l+6SibBWe5o1aw54f
	fqyOzLeuF5BtTopwtXMJRNlTsCSLtVKxFVx1IfOAF7NQn9Mz3V8safHrvI/LbQwb
	0+DsfzBRFP2/MUVapsfLzn51C/K0dl1E/g/0dEbDJVgMxHTkwiGwIT0+75TOwSDD
	rrFRDkwTQIcYIA5NUelBVuFBvG/vIZxuBCl0b+Togc/NJ91K/YNWD1DGJ1iB9oZo
	CSgCHA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497wqgux81-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Thu, 18 Sep 2025 12:46:56 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b4bcb1e32dso3551231cf.1
        for <linux-spi@vger.kernel.org>; Thu, 18 Sep 2025 05:46:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758199615; x=1758804415;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FQi6E6p9KLnZzlas4XjllmXc+yprtBYyqANSQeumeng=;
        b=uNHc8d7sY0/nxMc9Iott1tZaxrTwcuqSzyf0CCIDeHWs8Q2KHk6iQtJR1vF6cDzsJo
         ye24serGCYe9PTsgXdI2Wnu1TW21KCmh1MxMmFRvJAnkGvyBLHwCwr9DVeA/A8sdnqId
         LqRftLF8sGcCuhRUXGSAVPsctmJ5A7kxJaCR2AIJay5/apSmfSg7J+Z+ocyYQWkTGUcZ
         wQp6xtQ5fhgg9SJBENFcJrGNkOBL0PTfu5nzfdvMCY5x5uV8rvk94QKsxSon3D05U2rk
         jqRXH1R8A5XxL2DkUK2ys+wXvFkiPvesUQhsRyybY5idsa7HFOJ0koib0HqilBxatQmg
         V48A==
X-Forwarded-Encrypted: i=1; AJvYcCXEf0W0Ean4dSr6IhJKfmLVtJfPt160RI0GoeueTP4hzbnrmqNMrtOEo2jgXUmriqYKtmoafu3K9gM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwhjLPTWkFTPcad/ehqU9k8CBPn8oORYa/ZhBLYgS2ON1juFVK
	J1pITPW3knXT23j8P+l0k89RKpys2DyR1ShZ0YNXtefMmzmXFglDyUm3vkTPU6grdn4xg2FtefY
	/WrUM07V3pIK/CDAjjpALMJvLCviahzNLXBOhV+ItZROrLN6DtgtYNJXAL1H+UYE=
X-Gm-Gg: ASbGncvfaHCY8MxvJ3evf20JQ96JHZfNID9y1vLFazv0DPY86BJsRiI45N3A3Ch4nQQ
	xP26ABKQpMKPAm1KPXJK2nRR7qaZ5tTkRYtyGv9nfyHUm3T+p9eZ3N8KN0dD27DDgRdP0GsqGcT
	/afoG8M3pmib70JG4j5lsDR2ob4zZZN4LY+VCaaAeM4KH5ciuwZBx5v/3cKldf9do56B2J4pL7R
	8lqwyx1XX/NFd3kdB7HW6aSoW8TeIUu2kgNg/gEZMAYt9OhLGw0mooBwyxXdkb36DFfnNV2WzkZ
	0+b2HtvbSKFaAVsazrx2O715zaNUq1S8hv+JYW46LnNk8fyQ7DfvX+o+oEfuqTN6WwceJrEpv4n
	rrsITQgxKZhkwAPOcWslbRw==
X-Received: by 2002:a05:622a:1a22:b0:4b4:9655:9343 with SMTP id d75a77b69052e-4ba671e4f25mr47443991cf.3.1758199615422;
        Thu, 18 Sep 2025 05:46:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgBR0C+dAzCLmJ+hmxln+f5FlQgcycTu/DhEnyDBQ0nAkbRMwAhB+7lqoqPXh2Ubt8pkL/kQ==
X-Received: by 2002:a05:622a:1a22:b0:4b4:9655:9343 with SMTP id d75a77b69052e-4ba671e4f25mr47443731cf.3.1758199614793;
        Thu, 18 Sep 2025 05:46:54 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62fa981284fsm1033537a12.14.2025.09.18.05.46.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 05:46:54 -0700 (PDT)
Message-ID: <3c42a3b0-b8b3-4c37-963a-e9cec2d3d025@oss.qualcomm.com>
Date: Thu, 18 Sep 2025 14:46:52 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] arm64: dts: qcom: ipq5424: Remove eMMC support
To: Md Sadre Alam <quic_mdalam@quicinc.com>, broonie@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        andersson@kernel.org, konradybcio@kernel.org, vkoul@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org
Cc: quic_varada@quicinc.com
References: <20250918094017.3844338-1-quic_mdalam@quicinc.com>
 <20250918094017.3844338-9-quic_mdalam@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250918094017.3844338-9-quic_mdalam@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: _ZWqV-7htkvl1A_41s5rzZCuvUGufSZ2
X-Authority-Analysis: v=2.4 cv=HITDFptv c=1 sm=1 tr=0 ts=68cbff40 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=be57XhxKj-X5Z9eHZJAA:9
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: _ZWqV-7htkvl1A_41s5rzZCuvUGufSZ2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE3MDEyOCBTYWx0ZWRfX5Z9/gn/q0MFx
 +PqssMDshifYC1KWcdifwjpj2eABYcUiozKeWqeFj3Ikj+q7C6gcG9qwXMw5zWky6MwshFhWSuG
 aNQjkoB/GRV0j5UoJgWZ99qDfwZERM1IKwZSVn/MlRkMv3S2237fieSF+xfPY+tb2Nl0+XYjDvI
 lLftaNo3MNdWgq4yAfbl4Bpte797R1b7KMUEPjFZn9iBnm4FKVJ0TbJ30AyJWBfjyXgJPuUx3L2
 iR57MJ4G5bS1ZHc0CdDyo/oFlMfVEKIVQpqfziJ4PtjKJHju4220W04aiZqxaoQ5Qm92B0wyI4A
 gl6I7ZKmgve04cnUNAYKVRMLtkDVVsxSbng7BGvbLIvZqWQJkHtAXGgGNiW0qplf7+o7S7VxDZ0
 1Vjm9e82
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 adultscore=0 bulkscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509170128

On 9/18/25 11:40 AM, Md Sadre Alam wrote:
> Remove eMMC support from the IPQ5424 RDP466 board configuration to
> resolve GPIO pin conflicts with SPI NAND interface.
> 
> The IPQ5424 RDP466 board is designed with NOR + NAND as the default boot
> mode configuration. The eMMC controller and SPI NAND controller share
> the same GPIO pins, creating a hardware conflict:
> 
> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
> ---

The subject should contain the board name, i.e.:

arm64: dts: qcom: ipq5424-rdp466: xxx

same for patch 9

Konrad

