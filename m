Return-Path: <linux-spi+bounces-2989-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24BE88CBAFB
	for <lists+linux-spi@lfdr.de>; Wed, 22 May 2024 08:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4759A1C21DE0
	for <lists+linux-spi@lfdr.de>; Wed, 22 May 2024 06:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AD6576056;
	Wed, 22 May 2024 06:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UPBM/UY8"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C9976020;
	Wed, 22 May 2024 06:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716358192; cv=none; b=pStjdPuHA2xlgM1pZxk2HA9UHmxkZXozol/mevDPnHE66p05ZbRGPw87o2y+ljQGf6j4fHorrLEACMnPs1Ju64Pp9oAHdEeMn2Kaz49XSeu7tZZKcbVdS9e1ihmrf8XIDW1hmH+gOlV1tYnRFCIsDoyIbD3tuqFcklfD2oOmb68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716358192; c=relaxed/simple;
	bh=Cn2XFMWoNjuAdqnOy+xVEewcB8yxZQdALf/VDTJWspc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tX1jJtt1AedOfDjYaZZJ8EUyg9Ct5YRta524FNRguoUYULgsOVD9mESsEBH+ks0QEb1pOs3jsntGPojChQzJdMPXxCkS4fAru13kx1ayD7OjPZxgbvvXcsys4FYEB0vh2cGrmJV7+cQQW+Sxyf5N5fUE5c3PcbQkBALO993JOYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UPBM/UY8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44M4W1eE000805;
	Wed, 22 May 2024 06:09:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=yg0dNwgVIJbFrnHIEpXFbKaS8qAQ7OaX5TaUpxBRbG4=; b=UP
	BM/UY8kpvvroQ1RUpYj101AXdsLG4v1xbhPWUq4EncqHMuYBGuk3Cllx/tGYPLSs
	Z7ZfOyCrSqKrkjKNt/10MajRhQB5VssoNVoDntF34NLUeOJxm8E2fTKBADEQjf/7
	Tr+DVYYCm6+Vpvb7NXcZ9LiuGefAzx9k8NsDX/HOArBtkYCsEp6cstbbnanNeXZi
	//xWtb5P1eDpTuhrlSZaN0iZyaNu4eFjqksMUuj2wbLPRJb0boUGklGMbB0Z/lKX
	K/SBGw5OCwMjO9LXy1DSkCmIP//CX2QJJ45nJFEUXo3DGaqPHGi/iGWaHCkUMWK5
	Fbjdn1rHdUVyMDYfGc5g==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y6pqaqswg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 May 2024 06:09:27 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44M69QLN023398
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 May 2024 06:09:26 GMT
Received: from [10.216.52.184] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 21 May
 2024 23:09:20 -0700
Message-ID: <39ccbbbb-e6f5-89e3-e11c-a2338dcd5a30@quicinc.com>
Date: Wed, 22 May 2024 11:39:17 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v6 5/8] drivers: mtd: nand: use FIELD_PREP and GENMASK
Content-Language: en-US
To: Miquel Raynal <miquel.raynal@bootlin.com>
CC: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <richard@nod.at>, <vigneshr@ti.com>,
        <manivannan.sadhasivam@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <quic_srichara@quicinc.com>, <quic_varada@quicinc.com>
References: <20240521105532.1537845-1-quic_mdalam@quicinc.com>
 <20240521105532.1537845-6-quic_mdalam@quicinc.com>
 <20240521145327.745f8b50@xps-13>
From: Md Sadre Alam <quic_mdalam@quicinc.com>
In-Reply-To: <20240521145327.745f8b50@xps-13>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: g9ppQNO8W1rJh15p4AUwxVFKOp3GABtu
X-Proofpoint-ORIG-GUID: g9ppQNO8W1rJh15p4AUwxVFKOp3GABtu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-22_02,2024-05-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 suspectscore=0 bulkscore=0 mlxscore=0 adultscore=0
 spamscore=0 malwarescore=0 mlxlogscore=722 clxscore=1015
 priorityscore=1501 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2405010000 definitions=main-2405220043



On 5/21/2024 6:23 PM, Miquel Raynal wrote:
> Hi,
> 
> quic_mdalam@quicinc.com wrote on Tue, 21 May 2024 16:25:29 +0530:
> 
>> Use the bitfield macro FIELD_PREP, and GENMASK to
>> do the shift and mask in one go. This makes the code
>> more readable.
>>
>> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
>> ---
>> Change in [v6]
>>
>> * Added FIELD_PREP() and GENMASK() macro
> 
> Maybe you want to include linux/bitfield.h now.
  Ok
> 
> Otherwise that's a great improvement.
> 
> Thanks,
> Miquèl

