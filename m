Return-Path: <linux-spi+bounces-9237-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B17C9B1607C
	for <lists+linux-spi@lfdr.de>; Wed, 30 Jul 2025 14:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3D8F18C7519
	for <lists+linux-spi@lfdr.de>; Wed, 30 Jul 2025 12:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A2128031D;
	Wed, 30 Jul 2025 12:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FV2xlWgv"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F5C4C62
	for <linux-spi@vger.kernel.org>; Wed, 30 Jul 2025 12:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753879321; cv=none; b=kH4LHHHJahq/ocg6QHtyjtsQmFHsO+CnEqk1UPVfG9VYuXAv83hKIjCCechdcHzZrSh7PjeIntOtnx0qkEL4fvHWxgaiCcMPsLlK1h1OfGVJNH7iAWQMIzTE1qcxOn07gh3tai23S3KHAnrlIyYyjZvYGYVa0KQw3y3OtA3kWY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753879321; c=relaxed/simple;
	bh=ej2jAZXHD3CR51aB6MhT2IrGL51IuHJFJjrTmCg8PBE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JtkheKm42YE75NzEFLwoSTSMnBwY5EcdRxKR4KoEpPacdSijDcha+E6BB0JM+kOKp+A76LOtE8opujya5cphQwCaM+caPcrMBzesk42cxPLoYVr5sG463mb2MMJxRb04kmZC/KXUR2Wgu0SlEBSXFZdrRZm3hZY61kNqIubX10k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FV2xlWgv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56UCb6lJ030198
	for <linux-spi@vger.kernel.org>; Wed, 30 Jul 2025 12:41:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fw0Nq//8TJeaMcoqBVD1XDiUZJiNPaWvyceervP8S50=; b=FV2xlWgvoFrtrTl4
	0FUccwK41s9YKcMWn/9H8oDqequJWxvn5uz4x3pKKU9709esbw9aQ3jUe5YsAe9T
	2Cam41VqIHyQjCv2lJiaYNcyhoRJzZW2dn+nIMguS6tP6KPZRc0uvi/evsXXGfEw
	aY/CT1oaSLhzaeOopzspWAg5jhx4YaZ5OIV9o4YWmpiSApwnryuBWTADiqQU8L0z
	j0ElIfhUdRP1RzGzmoJ+d8Be/H+3Z/rVyfkgbUzbc87J/YDFKKPDSj8UCxmRsqC2
	LlODJ6yVRuaw4jWvsA7lqyBkkHETAfQZcVsthd+r/pZghaJymnchQ8+C+ei4RT+d
	7wF/Xw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 487jwer48x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Wed, 30 Jul 2025 12:41:58 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-7074bad0561so67111216d6.1
        for <linux-spi@vger.kernel.org>; Wed, 30 Jul 2025 05:41:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753879314; x=1754484114;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fw0Nq//8TJeaMcoqBVD1XDiUZJiNPaWvyceervP8S50=;
        b=Syz7ycA8SdEfgqIBXnLdvcgMamEOyLaQwOVp8efqv5gLv1ybhe2Q2E303wmxbQh7ms
         qVVznY0U/AFrnk1yGj7Jar7RijcIJPHPIXa6plZYrWYtg18j4AXU4DxtSDlxDz2kfeXN
         83v9LvPjh3cZXtH0hnmh2y1PDk1274hAhsqrJkZIM8bYnzT8KAm1mmd8NBrNlHU1Ffg7
         ZAV8WHK5kP9RdE19ZKwvEzs2FGnqms4TQSeJYoYrrgOz3LhGVaiXPW/89t2+tEfu6WYl
         mT3F1hQcnwFYSIOYtPDcitYxTeXZBjvppw4EHqZJcuKE3nqBX9ehrSAOEV6A5w78EFVE
         i15Q==
X-Forwarded-Encrypted: i=1; AJvYcCVn6k3VbtsdM6zzt8jRFMvpB1oB3ienLS2HrC/0CpZP9WOOFBGRtshrHpitepSz7JIfhjd88RhRmlU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKCVWWVjQmLdUdJsVxYQezBlap8aRfkA4hbTm6FjIZzszUnj5y
	6aJF8rnO/L/GvENCUAbZdeP56QOdisRHmDxwl0RlBv+duIN/uDVn9vC/9wnA+32vueNASjiVxyL
	gW9dQdakJVgAsqpFR0aAQlx2UhG+ztQrRqIosTfMSSzd85BY9FO4+IoFqjjOp15E=
X-Gm-Gg: ASbGncvYgdLs4WM6r4CS3ChpTZ+ix3/lslYJza2GDTg2xcF8FrLJVTtccaUAhJQpg8q
	Dwk68y/WlWMjGRyK6YySC+LsqSXiOY4Sg2yYSXsSdSsHz+ABwzWSs3AGIbE7FS1rAsGY18vwmVx
	KjMjd6RNCQOtsAS9FMxwn6xy3gAawBfnlGjk8fE15V7LOqVET159VizLNTUBQceG/4lVWKDVhUM
	5tNot/A4sX6RtHydF5rW4zTH/pdmBThpJWvEbal+PVz5mLYkxer675GKjnAMvfv6BePk7CkeIMY
	vJ/zcjzXGrvR3MUPHpFPI5oAOKynWGQOV9hV4wSeaHej3aXc7R5Psw==
X-Received: by 2002:ad4:5748:0:b0:704:7fd7:c06b with SMTP id 6a1803df08f44-70766a306f1mr41865426d6.0.1753879314430;
        Wed, 30 Jul 2025 05:41:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwxqKkPYbo6gXYoqf4jwmpjKXAD+kDy6CQkkaDMpJcj/hKiqPHZkPvdDAci01xd9R9KaCuUA==
X-Received: by 2002:ad4:5748:0:b0:704:7fd7:c06b with SMTP id 6a1803df08f44-70766a306f1mr41865076d6.0.1753879313996;
        Wed, 30 Jul 2025 05:41:53 -0700 (PDT)
Received: from [172.22.19.48] ([212.136.9.4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af635860103sm752819666b.14.2025.07.30.05.41.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 05:41:53 -0700 (PDT)
Message-ID: <1c10917a-c035-4cc5-9b83-b98f009b5f5c@oss.qualcomm.com>
Date: Wed, 30 Jul 2025 14:41:51 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v7 1/3] virtio: Add ID for virtio SPI
To: Haixu Cui <quic_haixcui@quicinc.com>, quic_msavaliy@quicinc.com,
        broonie@kernel.org, virtio-dev@lists.linux.dev,
        viresh.kumar@linaro.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, hdanton@sina.com,
        qiang4.zhang@linux.intel.com, alex.bennee@linaro.org
Cc: quic_ztu@quicinc.com, matti@qti.qualcomm.com
References: <20250725094144.1783243-1-quic_haixcui@quicinc.com>
 <20250725094144.1783243-2-quic_haixcui@quicinc.com>
Content-Language: en-US
From: Harald Mommer <harald.mommer@oss.qualcomm.com>
In-Reply-To: <20250725094144.1783243-2-quic_haixcui@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: ZqGNxqk-XVTv_pE2PvlREj47_pGN5mfQ
X-Authority-Analysis: v=2.4 cv=Wv0rMcfv c=1 sm=1 tr=0 ts=688a1316 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=dNlqnMcrdpbb+gQrTujlOQ==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=bs-e4Z8cAAAA:8 a=EUspDBNiAAAA:8
 a=COk6AnOGAAAA:8 a=KKAkSRfTAAAA:8 a=ArcK2n1sfW-e6Le9QZEA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22 a=YFpLQiK6rFjqGb8m0bXF:22 a=TjNXssC_j7lpFel5tvFf:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: ZqGNxqk-XVTv_pE2PvlREj47_pGN5mfQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMwMDA5MSBTYWx0ZWRfXxh9+DDVT0XPm
 apDzxbYSKoyG2YKRgrIqxaEFOuS005OiUTnHWIA7u5OvP46bbBGQQzRCwlZrlI+h/1+31spGGfm
 /rBUXa4glugpSXG/WzIJWzAU0jS4hrDoG2K3gOI+g1ewvY4vXAKXvGb/yDLzLsQ5tfMHwEF+X+s
 cWup7YUhsVSmGww/oWYPTYew2MvMVfz2jUizK7Upsei5tfuVPRYH5yss2jTzMD0Jsre4II/Mx6c
 /xOoRfi1Wm1JkgATo7efNCNGt8KGGKxsAshsdLLOZiFoYlwevseIQPbmySaWGZGQ4u+7HGghVvN
 FLcLB/lqrz5xFHzCHq6HvJIfOSnnv7Si8buidBmXeDcxSfJ/MV4MRuyOXWAw+PC0GmRKnRcBgiE
 gTyTbke16fL01VU0XFBLcUwYBCj9c7Qebes87nBkxrtSt2coS9W4BiVrtOEr01CK9gY/mlNc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-30_04,2025-07-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 mlxscore=0 adultscore=0 impostorscore=0
 phishscore=0 mlxlogscore=966 suspectscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507300091



On 7/25/25 11:41, Haixu Cui wrote:
> Add VIRTIO_ID_SPI definition for virtio SPI.
> 
> Signed-off-by: Harald Mommer <harald.mommer@opensynergy.com>

My new E-Mail address: Harald Mommer <harald.mommer@oss.qualcomm.com>

My old OpenSynergy E-Mail address is defunct now, nothing is forwarded. Thought a moment about this but it does really not make any sense to keep the old E-Mail address in the Signed-off-by for historical reasons. Best is to update this everywhere where it occurs in this thread.

> Signed-off-by: Haixu Cui <quic_haixcui@quicinc.com>
> Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  include/uapi/linux/virtio_ids.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/uapi/linux/virtio_ids.h b/include/uapi/linux/virtio_ids.h
> index 7aa2eb766205..6c12db16faa3 100644
> --- a/include/uapi/linux/virtio_ids.h
> +++ b/include/uapi/linux/virtio_ids.h
> @@ -68,6 +68,7 @@
>  #define VIRTIO_ID_AUDIO_POLICY		39 /* virtio audio policy */
>  #define VIRTIO_ID_BT			40 /* virtio bluetooth */
>  #define VIRTIO_ID_GPIO			41 /* virtio gpio */
> +#define VIRTIO_ID_SPI			45 /* virtio spi */
>  
>  /*
>   * Virtio Transitional IDs


