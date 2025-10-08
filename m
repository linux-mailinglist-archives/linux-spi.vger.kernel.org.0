Return-Path: <linux-spi+bounces-10466-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 014EBBC4C99
	for <lists+linux-spi@lfdr.de>; Wed, 08 Oct 2025 14:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF76D3AC902
	for <lists+linux-spi@lfdr.de>; Wed,  8 Oct 2025 12:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C6E24DCE2;
	Wed,  8 Oct 2025 12:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oI4DYbkW"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF3C276038
	for <linux-spi@vger.kernel.org>; Wed,  8 Oct 2025 12:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759926622; cv=none; b=IMu96NyAdgNaxP9AOsXYRcni3ysqOjbfF0C1AqgkwHi4JPaaYP+ldYvuz1QJEOavV/uxDA8h52PQB3z+zfEuTmDE0M2BOLhd5u7H4yd9FhRwuVAdGRw9z2UhP4Oseqs8SDEM5Tzo4e3OJ41IExZGCe/SlndXVUsgesR1PzeOk1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759926622; c=relaxed/simple;
	bh=3NutFA/lGn0R2mNE8a1/k3ypM4Mn0sub0aw8bFRL2HY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ew9exyXrnDPloYg9rNQty7o885umWGGyHrHLNpStG6eulurW0NubXqLvLjLSvxaa7uUuFbKTiZOmyzYfOiU0NdYRStIfsF1AVe0rPz0bCEXZPoYXplRilohxXynTRGr/mAJenYY2Z8tLNu0DkF8cR3t0tSHmDM1pa16c0JqXrgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oI4DYbkW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59890Pmm001400
	for <linux-spi@vger.kernel.org>; Wed, 8 Oct 2025 12:30:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vYwOmmq6eh7c1BlgA/tZn39no0yivZDY9RCiDcAFj/w=; b=oI4DYbkWuaD6yH94
	nOZtDEflYZ5xYXXjFMhsljICpLt/7npA7QQoc66K/oRpaHpkYa8OgviwiXofRYBp
	08atq97uw49H8M7CEsDfpErHmHNcgQHOc6/fzjC6Np34FrxGo/zF0s2KzbEM+hhs
	w5ar8HUJZL9mucZ4KWnkdchApE9TCJLOh2ppNLO+J3uG46c5BeaqgGa5Nv9BQDY/
	KFZO0WRkztMRsQ1FJ+y6YcH/x+wxzSrQxU/S965lejl646L5GzQI1xjlMt1WXGla
	y9nGquhxWkbQECj089H/pYvNAKPwF2hdgbX6KAfuypGmczb025yeOJODkshfg14W
	xPaW3A==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49juy72ev1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Wed, 08 Oct 2025 12:30:19 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-850553dfef2so20327196d6.0
        for <linux-spi@vger.kernel.org>; Wed, 08 Oct 2025 05:30:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759926616; x=1760531416;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vYwOmmq6eh7c1BlgA/tZn39no0yivZDY9RCiDcAFj/w=;
        b=BSAO/Fhp0wTvQgXFjn3xJq9Gxsr4h4N9yLM49dK72Q0pzqI+5QFkSJx9Xn0kFopTJj
         Yjy3bX6r2p+AsWQotC5Y6foDkPD8XltvqD3Eqob+ngOyxeM2e0zKJ54zWVGOqp47nqhH
         1/jD9NG0vXlYM/t7Qazjnwjt6RE5DjO9KG6R06pABUPEJHfSO16vITStaiGKNbTuM9VO
         aXN97EQq2uAQg+g+/mUfKAS3MiH5i89XwBmDC5VOOhdxtCfTPlwz4GygDRiFTl/ViIA3
         yAtt7JvDEvHymxfkwUzgCCNaaxrarFYdTJNGvrclJB7p0svXdgJJvNitUVYTgbtJF53p
         KKhg==
X-Forwarded-Encrypted: i=1; AJvYcCWk9DrHZlAnyyIhnpp2uqsAI46x4KMs4ER8yHkPBRcQcm+Jbs89ZWWqSEWvgX7txsf7rpe67klB+s0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq5uOy1XB+1tvvt7DITZRRlzV3BOn4O6N6/wADo/PqjyS5lRFo
	NMAyGIKnmG9rldsbIomZ9ffmA4uMaUwgtq/mm8dov77nDH2Zl3UceIIzMF5DCZycZ9jlyqwfni8
	J40kT8WA75hrvtn3aGU45m3uFU5UP/OeFjDkjFLKmxL6MKLAHi8LfHU50tUxUJ/A=
X-Gm-Gg: ASbGncviCkTxEXxp35VEwlQ8Toz34xejM79cmuRztNMGpTcT5zRlRammqJooKoMkbfU
	2D5R5r5uGY2mVtGS7SnlkBqKfjMwpyNruIzlS1N4C5MYpvVtr/PLRO3uSbwrA1ToAALTcXm84pB
	EB/ZgHw0CqR/cpNc0uCD4TqgMIECdSDenYNcC2AtMqze6LKk9rhHtrQ7RrhgvJW6J+Miveb8YDs
	8N2rP0xSTZvNCUS7MBvNH23fM0vi6vJQN9RynxcucXvW7b7YocfaxazgeTYWOb8d4QWcnKiweOQ
	cOn3S3CTlEmKB/78we8xhLm2ZircfSeFb6XaK3aBEG6Gro/LASdlFtd+Ym54E4BfV8wWA7Aaixb
	d7qGHjnjT0gH6buaGahPeu9xIYRI=
X-Received: by 2002:a05:622a:30c:b0:4d9:5ce:374e with SMTP id d75a77b69052e-4e6f4acde1fmr5303661cf.8.1759926616107;
        Wed, 08 Oct 2025 05:30:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/AlwhfCmrZxt1Uz+PeJCgLqUiBaGU6v5l4sYwpfDnGoDIJcA7elnm7lMZ7gtM4iXdb4tK9Q==
X-Received: by 2002:a05:622a:30c:b0:4d9:5ce:374e with SMTP id d75a77b69052e-4e6f4acde1fmr5303051cf.8.1759926615439;
        Wed, 08 Oct 2025 05:30:15 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b48652a9ea1sm1633510466b.16.2025.10.08.05.30.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 05:30:14 -0700 (PDT)
Message-ID: <c7848ee9-dc00-48c1-a9b9-a0650238e3a1@oss.qualcomm.com>
Date: Wed, 8 Oct 2025 14:30:12 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/9] arm64: dts: qcom: ipq5424: Add QPIC SPI NAND
 controller support
To: Md Sadre Alam <quic_mdalam@quicinc.com>, broonie@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        andersson@kernel.org, konradybcio@kernel.org, vkoul@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org
Cc: quic_varada@quicinc.com
References: <20251008090413.458791-1-quic_mdalam@quicinc.com>
 <20251008090413.458791-5-quic_mdalam@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251008090413.458791-5-quic_mdalam@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=IrITsb/g c=1 sm=1 tr=0 ts=68e6595c cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=COk6AnOGAAAA:8 a=-ept-RJRzOG-hoP0ccsA:9
 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: wR5CYrUo8fOvydFrmTfGJs8dvgp7j_Pf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAyOSBTYWx0ZWRfX7VYAuAjWL2ps
 zYLuWMRdKAN1CaJhCvi9EUzS3EeQwCJsxYTr2QDAssj7vDhVrUo8fpff1tsfk+VRPI3Mg5uFOaI
 7gWqNt4M9E+JaMnVkiLygNNiPhV2G8m4QzNBoTIAITZnxYP5ssXb58XhXk44Q1q+fWdgmQw1sKu
 067TUuuFzeVL+DWWDMmjuyKqEUXBMAKtzRvTgwpEC4kDZpxby6oxFkmP8hdMmuxRQFU467Vbdsc
 ZMpFJqQmAypIJNcITY2Lsb7ujulmIWfTrdJDdZZb9NlnThdx0Ot87/3Fa1h1sFvpZR05R3hNxig
 ghsz5Jfm42PwDQwmnvFCaJ/NbsRZW1/OjfNLrPPNYQTaCrpilX00gV4BNnVNLsA3iXwTjPBoLv3
 Bnk7ZXSePE31BW+ddsKgh8H4M3/gAg==
X-Proofpoint-ORIG-GUID: wR5CYrUo8fOvydFrmTfGJs8dvgp7j_Pf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_04,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 malwarescore=0
 spamscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040029

On 10/8/25 11:04 AM, Md Sadre Alam wrote:
> Add device tree nodes for QPIC SPI NAND flash controller support
> on IPQ5424 SoC.
> 
> The IPQ5424 SoC includes a QPIC controller that supports SPI NAND flash
> devices with hardware ECC capabilities and DMA support through BAM
> (Bus Access Manager).
> 
> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
> ---

[...]

> +		qpic_bam: dma-controller@7984000 {
> +			compatible = "qcom,bam-v1.7.4", "qcom,bam-v1.7.0";
> +			reg = <0x0 0x07984000 0x0 0x1c000>;
> +			interrupts = <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&gcc GCC_QPIC_AHB_CLK>;
> +			clock-names = "bam_clk";
> +			#dma-cells = <1>;
> +			qcom,ee = <0>;
> +			status = "disabled";
> +		};
> +
> +		qpic_nand: spi@79b0000 {
> +			compatible = "qcom,ipq5424-snand", "qcom,ipq9574-snand";
> +			reg = <0x0 0x079b0000 0x0 0x10000>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			clocks = <&gcc GCC_QPIC_CLK>,
> +				 <&gcc GCC_QPIC_AHB_CLK>,
> +				 <&gcc GCC_QPIC_IO_MACRO_CLK>;
> +			clock-names = "core", "aon", "iom";

1 a line, please, also below

> +			dmas = <&qpic_bam 0>,
> +			       <&qpic_bam 1>,
> +			       <&qpic_bam 2>;
> +			dma-names = "tx", "rx", "cmd";
> +			status = "disabled";

Is there anything preventing us from enabling both these nodes by
default on all boards (maybe secure configuration or required
regulators)?

Konrad

