Return-Path: <linux-spi+bounces-10114-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 992E8B84A99
	for <lists+linux-spi@lfdr.de>; Thu, 18 Sep 2025 14:49:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43FBE4A5DCB
	for <lists+linux-spi@lfdr.de>; Thu, 18 Sep 2025 12:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F37D30496C;
	Thu, 18 Sep 2025 12:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="itnAxQuM"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851F02FFDD2
	for <linux-spi@vger.kernel.org>; Thu, 18 Sep 2025 12:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758199741; cv=none; b=UF3r/ibKVqYVRR9brcJJbayEG8zDv1Ch3ZXbk92Kspf0CltPmbJxoEJ1GV02QliWPBsU/O9enl5UBVnHvxohMBNIIAn8v/MrmkIoO7NMZugrqezbhl6hUQMk/6gsOdkY8t9KmvjRmbfFNlCLrGXE6vod0YCnVuotSWpnqS2iEo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758199741; c=relaxed/simple;
	bh=6wYNJUpyjOhpghFZETCWFMjXWeOfYKe9IaFUz2uGRVU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OrtjtJSNx0VoA87s1eq0aurCk9OMjU7P1ERM7Uo7E/OTbeentCC/y0NrHvhT86RfUazaF+coUlrOg87xzYhS9MkgYGxa/iTwhNzGmc5j9vuDJuDq1ypnGyO4T/ugfr1efruH5rxr8wtoc6tB9bP1ZNorMEE0PpC7Iuk7ThlnMXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=itnAxQuM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58I6LT9U028087
	for <linux-spi@vger.kernel.org>; Thu, 18 Sep 2025 12:48:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6bvtGgeiT9GdcDYImrybz3NN+DT+yOFMcizDB0PF7SU=; b=itnAxQuMu02zPsbk
	s28ZMC6WmdlWCTaIE4IjIqHrF+3PUef7suYynbSjkQsA3iFLr0B00a5GwIbr9n0V
	VXjpOOZIAglPnR4Y10MwWhuO7BHXu/WhXSyzYCapwYHEzDUcIrpSDxgukjfJxJQI
	ViYbQjCnevhizbxbjYhJQkpDTK88U4Jux+Ek2nY3J+laKwEWwbxz9dP+yp4lSBO2
	7xnx0C5SVX+PiTiqT5uEpfhnzzmdsEmN2GTPMoCDwh/8PUay6DNo5GGc01zaxisv
	7Hesv5UWgQYt9rt9MTx5ebbuXA/ijUPE0VtRbeHzDFi4iNodJA0DKYo0UQzkczsV
	m6xBig==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497v1jcb6u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Thu, 18 Sep 2025 12:48:57 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-70dca587837so2568496d6.3
        for <linux-spi@vger.kernel.org>; Thu, 18 Sep 2025 05:48:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758199736; x=1758804536;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6bvtGgeiT9GdcDYImrybz3NN+DT+yOFMcizDB0PF7SU=;
        b=K3ik6IYKNtwtbuU9cippRE4oGq5t8bFS0FNJGdD3T73EyeGQn8cyBlwIByfDylJuqA
         99Bz/PMmfsdaeoGZeJl607btwUuTKE/EpI64//BEgl8P3JIqF7epbsdeeWbDnkp07lVs
         N74UxtJNR+noK/etfys0k5AnawhFNui/6I8bgcN4IOt8KDML57dhG/JPRQg3BVBCIiHp
         X7t0OJil63RgRMKAUBm/ATbI30iGdP7z5WDXje6uPTllf0xjTq01QByGn6CJjcbKnCrg
         RvBAgmm+85cSuyPbZR+Ed/I5Hzg9+nTtWODIumAxsf+IzL3Sd0rFaZjq8D5BUlccBlI7
         u+jg==
X-Forwarded-Encrypted: i=1; AJvYcCULru76NH+UnduGxgUF8N5P/Phcxpn8w9MdWH0gtnJVp+P2aeWhMCFTO2ZQ/0oyTCn68RbCpgwOS1w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyifou2q9eoRpn8F2Vsllq5Gpq4FBPQhjxdcCV5sHlYSCZBm/4/
	U2PAZth4EruCRFjNTCAAXLModzzSJB9QxVDLlEc0nPNj2vxEkD/M60OWCUM+qIj2nATYha0rVr8
	rK5D6ngy7BGxl97rwrZmHrGVFbt01N3HHazPHQ8V2/jZhDINCOkGzoK2KxI0pxjs=
X-Gm-Gg: ASbGncv0AidHTMKzgMM6ZSCp8kSIllrRYGqAxejxR2J1LKbJHADHWyQxS9LzWZwARRU
	4dABG7oRqySFLeCgoQ4+Vt203Vfs9ZjXdn0Ekp/kjnxFa9myfGzt8J7/uh5Iodgjwz992gUokqR
	wt4UAbza0zhcYN38htKlRVWiKKCK+FggJCYJQOuR9Or79MOLGM7O+oh3STrn5Ayi1dGXa1z24Q4
	zKy8Mj4+cHfqH5FFV7fgs1Zklhj05A6pud2DX59TswdZavNGnEjFOvgSR/bGHlKl7sgLUbX0Z3G
	tO9XX2sToylB4Akv8ipTbITRlDelCcVEr0AoPkeVtzh5m35kvsu9jLOrsZnMtGzfLGVTHV+PjRh
	OtWP6psdpxpPo0JUHvmSgZw==
X-Received: by 2002:a05:6214:5192:b0:78d:d2a3:e170 with SMTP id 6a1803df08f44-78eced2299cmr38306076d6.5.1758199736349;
        Thu, 18 Sep 2025 05:48:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0/sXcCPePkMwJlzd+QPdDzDD4YufK1nMclF2i+JYFp8zsYYxHye3lguODkBPVCCYniAWurA==
X-Received: by 2002:a05:6214:5192:b0:78d:d2a3:e170 with SMTP id 6a1803df08f44-78eced2299cmr38305696d6.5.1758199735742;
        Thu, 18 Sep 2025 05:48:55 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62fa6f03008sm1317666a12.7.2025.09.18.05.48.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 05:48:55 -0700 (PDT)
Message-ID: <905d90fc-eac3-485b-bd8e-98c1e4aff29e@oss.qualcomm.com>
Date: Thu, 18 Sep 2025 14:48:52 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/9] arm64: dts: qcom: ipq5424: Enable QPIC SPI NAND
 support
To: Md Sadre Alam <quic_mdalam@quicinc.com>, broonie@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        andersson@kernel.org, konradybcio@kernel.org, vkoul@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org
Cc: quic_varada@quicinc.com
References: <20250918094017.3844338-1-quic_mdalam@quicinc.com>
 <20250918094017.3844338-7-quic_mdalam@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250918094017.3844338-7-quic_mdalam@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: BQ1iKEz0K4kE6iYGwsQWYgFqkyR5oQzd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE3MDExMCBTYWx0ZWRfX46jxqjbquKPY
 c2JUZYbkAbhB81Ab/yiVfduw7/gBjXKvQZP5pD77QzQ+xtbj8fiO0+y5QhXCa9YzF0i2RGXAszX
 t5g3xjRSDVraJnV+efAeQ8oJw6r5dCYKfsku2lfMqlkzSYKmgl1FOXOv4x3g5GAQ78Nn79WJ9u3
 jUvHn+r06PZITXjYAseC3j+ARCyhKyWhP5Xvx2JWPS5oL5MdxEg7bsA6V5Zalq6fOepesz2QGAP
 7wNArVbVZQwNEfABDgV/BBVNdXj+uGYY/PAT07XDnU4S2SnLvcICUzBNTx3qiHAAYqk1PTUJR8S
 saBDVm2V3puYBOIlKIYzy1QvbwR3AkyyrSsyKtf8Qn0Y8clBAr103FRPbuWRjotzsvs/CTop/Y8
 XFrcxlns
X-Authority-Analysis: v=2.4 cv=AeqxH2XG c=1 sm=1 tr=0 ts=68cbffb9 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=t3lpBGeAFA5ev54tvH4A:9 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: BQ1iKEz0K4kE6iYGwsQWYgFqkyR5oQzd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0 adultscore=0
 impostorscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509170110

On 9/18/25 11:40 AM, Md Sadre Alam wrote:
> Enable QPIC SPI NAND flash controller support on the IPQ5424 RDP466
> reference design platform.
> 
> The RDP466 board features a SPI NAND flash device connected to the QPIC
> controller for primary storage. This patch enables the QPIC BAM DMA
> controller and SPI NAND interface of QPIC, and configures the necessary
> pin control settings for proper operation.
> 
> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
> ---

[...]

> +&qpic_nand {
> +	pinctrl-0 = <&qpic_snand_default_state>;
> +	pinctrl-names = "default";
> +	status = "okay";

\n before 'status' is customary

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

