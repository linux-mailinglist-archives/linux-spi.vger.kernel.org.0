Return-Path: <linux-spi+bounces-5923-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A735A9E5CE6
	for <lists+linux-spi@lfdr.de>; Thu,  5 Dec 2024 18:19:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFA641881E1B
	for <lists+linux-spi@lfdr.de>; Thu,  5 Dec 2024 17:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4688D224AF3;
	Thu,  5 Dec 2024 17:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lMWjN/ih"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C684A18BC1D
	for <linux-spi@vger.kernel.org>; Thu,  5 Dec 2024 17:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733419170; cv=none; b=pPTOZm5sZHyedPAqf+3w4Kwg6OiJ4q6JAlewIkQa3ELgwHmlUcFykH/H+al15/se8SKmtDDRkdof75UMS0C1dpHh3qz5sM2A0BddlybAkLzh03W7lfQfVI+NtjCjGAia7O21bHV61rOkwhZIqn3u70iF74gxPmpyBgtjD1Xbpq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733419170; c=relaxed/simple;
	bh=FGdLII5M2j68FMwyvtPhVuF7iwrg4WLaaHEdlGb8rF8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DJzHwAHStA3C7K4mgqbTsIoMx2ovuGQLipTiPCntFwjmFRyd5swYBaa+0V+rJIiUw4M/Bk72HR+KnxzCi/68yrgTRqciEKQXmwo+rSwlvAgN4zwp5fCoJHER66LrW6zCU71CJcgXYXbiV29zFThwH5Ma+wliTZwebiAjSt9fQr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lMWjN/ih; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B59vkTx026596
	for <linux-spi@vger.kernel.org>; Thu, 5 Dec 2024 17:19:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	b2LZXubXxt0wXoBWUWDvvdcZjo8ptXI01DoAjxRfdtY=; b=lMWjN/ihVKDTbF27
	/9o7ls8/KzeIgN0rOdEyPVBdhVcQTuC+L473GzrXFYcs35I7Q3FPfIx21YWNL4Vi
	gO6K8npY5ApznvQtDKlEGdR/l/G2+JAUO8v/kUhRkbYIdPsib4YB0pKgdVlOdFg+
	yZjU+d1K+4j1x59OdFWROS6sg5X2cKGoW+msfvpOysVSPiNeu5FiRyWEO5TnP6n9
	kyc6JP8a6masegVwmZ32/brPpW7aA8ek9YL+s7hW/TwTlHZkiJj8G0Q8jJXyWU7Y
	MKFwHlKLqG4crLdAEUuPlijtXPDeK2zmLIa9Vhvg0mp3P4B1nGDII8TuBxIdumFw
	41RPqQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43ba0kh7fg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Thu, 05 Dec 2024 17:19:27 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-46680667b3aso2783521cf.2
        for <linux-spi@vger.kernel.org>; Thu, 05 Dec 2024 09:19:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733419166; x=1734023966;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b2LZXubXxt0wXoBWUWDvvdcZjo8ptXI01DoAjxRfdtY=;
        b=TFd3U5P9YHKxw+hkMFL7DDgHaOMOxgxPFMR9Ji76QqDav6x9rBfy26aYGpyS+rcWcj
         4Js6q23nCHyDIEPaDtZdbPcOgl8+gedEVa3tZuQirrWwTlWPmECoYjz4LNNUB6ZB7GAa
         vOjesUph/fYYc6fC/1XBlRAHwvyu0hfo0kwBRmMrBjYNeFn7TpV2itt7dxgf3Gb6VBh3
         iRXgqD0ogFj2JcOgLuBQrFOcFVvVf/eSRdEDxEuxf+HCH6j4In1CesYJGpZQcXhyl3ui
         LB6TMK78MzfU7wgVFmEsvg2OCztL7vYA+1HJfLKF+0Hs+Jw8bUiajPjqBD7Aho77Hn9s
         SeUw==
X-Forwarded-Encrypted: i=1; AJvYcCV+5iFzHQSjalX4IPS1UuMm6a0xO7n9CA7SNNmJRplxFHEuh02WDZxdg+iIh2A0z+y0NHbqEbBKU6U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlqJjjIEvd7EMooghfE13Gh+aC4NApGznocPyz96s17cobcF9q
	urfC6aXfYBeq7Y0vuQDs4DUrVhvBMkLKlx+D3i6GD6YrQVtUDHcITcy42dqAAqH8HwlK93GC3LU
	U2phbVi0vSfBZqIwdfduGeSsdgKNNFb0nJeZWZqvF5yGUdjSIyV/3zuhpnTU=
X-Gm-Gg: ASbGnctGiMQR+L6jxNvRE55Mm/mhFCK2+CfiLM0tm3sNto4YoVKsDkUA/hPEKv0Wr1O
	sSTs6hGk/GDA8Fc595pTzlixks4bLttepHZavlWciOB82tOnYb0moopkR3YIVTsZmq7ErCNo9Fq
	Zpkfio5zyJmGvqdq1wA6WQOdCye6ggH+p9dKt4XpMp5o0YpLIfAavenyx8aWlWUrTj8tlOxSfWV
	iyS694Q1OZK9o9KIDIrWoE9OvwK6scZPkl3FrC+wd1aVWqL4HE3/vbV3f9/td1Dd0eV+YZ9RNGu
	qiSTYD5Am32SxhAIffsZ3sWr7maU5ww=
X-Received: by 2002:ac8:5f07:0:b0:461:6599:b9a with SMTP id d75a77b69052e-4670c3742e7mr76163301cf.11.1733419165686;
        Thu, 05 Dec 2024 09:19:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEU+qJE6QKbgG5HlW99mhr99xiUoytBvTGuUz4N/wFy5f4STO28PHZ+UXuC1vGJjl+c0VW2ow==
X-Received: by 2002:ac8:5f07:0:b0:461:6599:b9a with SMTP id d75a77b69052e-4670c3742e7mr76163011cf.11.1733419165176;
        Thu, 05 Dec 2024 09:19:25 -0800 (PST)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa625e4db84sm120014166b.41.2024.12.05.09.19.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2024 09:19:24 -0800 (PST)
Message-ID: <4c1fe789-5190-465d-bb41-3fe1534d2523@oss.qualcomm.com>
Date: Thu, 5 Dec 2024 18:19:21 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 7/8] arm64: dts: qcom: ipq9574: Add SPI nand support
To: Md Sadre Alam <quic_mdalam@quicinc.com>, broonie@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        andersson@kernel.org, konradybcio@kernel.org,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        manivannan.sadhasivam@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Cc: quic_srichara@quicinc.com, quic_varada@quicinc.com
References: <20241120091507.1404368-1-quic_mdalam@quicinc.com>
 <20241120091507.1404368-8-quic_mdalam@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241120091507.1404368-8-quic_mdalam@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: LQt4xEyCae7SGU7r-v-Eu57V0eGCB63n
X-Proofpoint-GUID: LQt4xEyCae7SGU7r-v-Eu57V0eGCB63n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 mlxscore=0 bulkscore=0 mlxlogscore=999 spamscore=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412050126

On 20.11.2024 10:15 AM, Md Sadre Alam wrote:
> Add SPI NAND support for ipq9574 SoC.
> 
> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
> ---

[...]

Feel free to put dt patches in a separate series after Miquel picks
up the mtd changes

>  &usb_0_dwc3 {
> diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> index d1fd35ebc4a2..45fb26bc9480 100644

board and dtsi patches should be 2 separate ones

> --- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> @@ -330,6 +330,33 @@ tcsr: syscon@1937000 {
>  			reg = <0x01937000 0x21000>;
>  		};
>  
> +		qpic_bam: dma-controller@7984000 {
> +			compatible = "qcom,bam-v1.7.0";
> +			reg = <0x7984000 0x1c000>;

Please pad the address part to 8 hex digits with leading zeroes

> +			interrupts = <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&gcc GCC_QPIC_AHB_CLK>;
> +			clock-names = "bam_clk";
> +			#dma-cells = <1>;
> +			qcom,ee = <0>;
> +			status = "disabled";
> +		};
> +
> +		qpic_nand: spi@79b0000 {
> +			compatible = "qcom,ipq9574-snand";
> +			reg = <0x79b0000 0x10000>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			clocks = <&gcc GCC_QPIC_CLK>,
> +				 <&gcc GCC_QPIC_AHB_CLK>,
> +				 <&gcc GCC_QPIC_IO_MACRO_CLK>;
> +			clock-names = "core", "aon", "iom";
> +			dmas = <&qpic_bam 0>,
> +			       <&qpic_bam 1>,
> +			       <&qpic_bam 2>;
> +			dma-names = "tx", "rx", "cmd";

Please make clock/dma names a vertical list, like clocks/dmas

Also, is it okay not to use any of the GCC_QPIC_BCR/
GCC_QPIC_AHB_ARES/GCC_QPIC_ARES resets found in GCC?

Konrad

