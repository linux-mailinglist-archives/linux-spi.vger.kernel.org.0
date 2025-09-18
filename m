Return-Path: <linux-spi+bounces-10109-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A02EB84159
	for <lists+linux-spi@lfdr.de>; Thu, 18 Sep 2025 12:29:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F4D31B20A00
	for <lists+linux-spi@lfdr.de>; Thu, 18 Sep 2025 10:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB7082F362B;
	Thu, 18 Sep 2025 10:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Xj8+bJON"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430B72E5437
	for <linux-spi@vger.kernel.org>; Thu, 18 Sep 2025 10:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758191240; cv=none; b=u1fUONDCZoJ+BE74jbBHKAGGmgfUvgeqhco+0XDlloYyJepAMYBPN8l4ms9ZOCyvmxf1pyT+yujLQ7OSvSExNJIrMg9pBL6bEyjVR9r1crIxkX6kl4du1ipXU2+gv/VSTViLFWZRzQD7sKbW3WWhycr+cfS6Gf184/yNFeZHN0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758191240; c=relaxed/simple;
	bh=SFFv6NEMjbrj0MqTLSIDkcH/Ec5UzdpQKT06CrRKoh4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jQ/qpeWX/ukopnzDEBox5lFncii1BHud/BGBBNG0s7J4ILKOIc125Rx+oUGPt5HA9LYgrgFndW2C8dgqcKk85/LNDprCvi2lKCVa6C5lGM9GmTGe32FHkRpA67OtiKmxeX4gHSqWMlwzD6wrnVgjUS7G8VZ3HQhv//9OoPzaoHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Xj8+bJON; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58I5U4Oc017736
	for <linux-spi@vger.kernel.org>; Thu, 18 Sep 2025 10:27:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SFFv6NEMjbrj0MqTLSIDkcH/Ec5UzdpQKT06CrRKoh4=; b=Xj8+bJON4h6M4tex
	eud08TlmICVdM46C3Tno3WLRmkhsbNqhTgCberXdpoMD14nQHmlRgjlnHEXKF/2r
	S+J8P8/fiV2JZRB6IsymMfqP7fIVxiS7amroKAScOlJUSy1NJomH6IwwfhRqqgj9
	pOsgXIDONGDPuCe7kEo5WyIhMMCjdyDa4Fwe0bV06eO3TXlDh0HbWW7J6QFnh2tc
	5aR5Xo9CkpAv6qyLtcM8feBGEi3aXP90Yd1yJtKNHZXBbljdopXYR3CgO/pfLQXD
	RH6tVxKP7ZDMibIcy25K4HSl0x5HyrBVpYvDWcSssdxiUbcI1LEFF3zkxLigFthH
	+eP9Bw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4982deaewt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Thu, 18 Sep 2025 10:27:18 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-80e91c02c8cso22683185a.1
        for <linux-spi@vger.kernel.org>; Thu, 18 Sep 2025 03:27:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758191237; x=1758796037;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SFFv6NEMjbrj0MqTLSIDkcH/Ec5UzdpQKT06CrRKoh4=;
        b=GzI4VReBp24oQvQIbYx58jrY0nU+FQ5n5KcnbVEePcjAfbECvgY7GlPbFoBBOgxbpD
         G7Kudi6oUnpb0RQ8xmFERnrK71dL9rRvNDsoSI5UmLKYynOIBlyUjfz1sRkZms+F5O+U
         CbxYk5g+GISZbzAuRhC0XhoEhSbvCQrO9nv2c74xc26M6rJqwcid2Svi1CMo5HWHD6iv
         QcaJyTAxkieASAaJekAY52DrIX34WFFUJTPdnpsjSjxcbVl5Blkpg0qV62mbNKHSe3lB
         1qgcet1bgzbVBPAPgNnAUBW3MmJ7xOIPhLtAGUfork988F4+S4j/pBHmkWzz6wiaqngO
         hD0w==
X-Forwarded-Encrypted: i=1; AJvYcCVJWhTlxL+0QZNueWER3dQNp6+9xmNv2hspSPy3vqk+WCUjZzpz2p7VDeeFh+APyVUJQ1hO5NeTL08=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQhIrdLLSZGGMVZfn+ylXPGeiNUiKV+RVdOEXhPAQ/29YwB7FZ
	XhXDe+HpDBQPY7SJCrWNz1GumMWcBd6bukUSWjnB72bTvRqrGyK+fYDpLbJ8kc0nF4yHOb7Xddd
	wMk+846Y0rAGtQVTYYq2g2Kw1nwmzpk+pTdWiSI9j8pSPCKNwh67tNv8H0uJjW9FK6j+dGfI=
X-Gm-Gg: ASbGnctI5KbpeV7DpZI3gGQDDuikoqWhRymrx3w2esUl7wfzosF5dYALQ9NfJS5/QNs
	7M4FltKjmxCwp3+vgVbPTLIsniQq0BBmgyyYI1QniyesoT4vDLOflW4xAQCpNLhDlKtZNqV28e6
	uY1j0h61t5OfZ7Z74eSiSg/Tt7HztWzqmllzENv3fOX+I1pWuTfjuA8kl90dSzTxKCtnwbXgrtd
	zimi4E4jOM6f8Iks6v5ku8qX3EcGiW64+3vpZEqpG62vk1FPWXsM3he9P6VaXdejv5uleYr19mh
	fUTgce641YXRZ8SfqiemMXHe8td6bXLdchUiAVg5AhfjGbwWhJXe4OafsVy30UAWWu+xcj02iCi
	evklI8Cze4iL3AiFsTHxcxA==
X-Received: by 2002:a05:6214:519b:b0:795:c55c:87de with SMTP id 6a1803df08f44-795c55c8cffmr4039526d6.5.1758191237100;
        Thu, 18 Sep 2025 03:27:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYzlJJuyXGduZqx5WCoB3OgJz/oYERgYQ1D6+IglQ8GmpT3KQfYFFrtxzVLToClE/f0NfFbA==
X-Received: by 2002:a05:6214:519b:b0:795:c55c:87de with SMTP id 6a1803df08f44-795c55c8cffmr4039366d6.5.1758191236525;
        Thu, 18 Sep 2025 03:27:16 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62fa5d1a89esm1217938a12.16.2025.09.18.03.27.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 03:27:15 -0700 (PDT)
Message-ID: <c5d5c026-3240-4828-b9b3-455f057fb041@oss.qualcomm.com>
Date: Thu, 18 Sep 2025 12:27:12 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] dma: qcom: bam_dma: Fix command element mask field
 for BAM v1.6.0+
To: Md Sadre Alam <quic_mdalam@quicinc.com>, broonie@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        andersson@kernel.org, konradybcio@kernel.org, vkoul@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org
Cc: quic_varada@quicinc.com
References: <20250918094017.3844338-1-quic_mdalam@quicinc.com>
 <20250918094017.3844338-4-quic_mdalam@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250918094017.3844338-4-quic_mdalam@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=YfO95xRf c=1 sm=1 tr=0 ts=68cbde86 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=MmGnNXLGTzfTIO6JWNsA:9
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: QHQoGeeL7ZkaDiVOEeHY2GiCkvIXjE4C
X-Proofpoint-ORIG-GUID: QHQoGeeL7ZkaDiVOEeHY2GiCkvIXjE4C
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE3MDE4MiBTYWx0ZWRfX4ZXLWlGmkIwR
 kNnFXBuoP4hpqvaMX1NEbHV14/x0jN8IrIMZN88Bmjegas4ffGTG3rSkoiTzKolaoWQx4nEipMo
 t4P2dlQsWvPpNW+w3F4N6nrVSCei3YSJEOz2KvdIT6pQ63A21o6YI+mqZKMZ2UCwT2+hiA2VQ7M
 9y3RjXPid/LoFb6VbER61HdquUqzBLUKCxENKsJNAFhw27mA/U6nPLkVAFUCA0STUq/JK9sBTGr
 2BRVqJLunfDMkNoDOMHpeVNgZL3ZxBxIG2CoalM9soFWau2z/LJW4pc6wCdYfHdspIRii9a7W9c
 3A9kheTSJcjl3LL2o5IvOtaUSTGftGT5EIeU7WDCtREmI7lS5EmBdj+ODv13oBMBv66pI2gX8ao
 dWszaKtQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509170182

On 9/18/25 11:40 AM, Md Sadre Alam wrote:
> BAM version 1.6.0 and later changed the behavior of the mask field in
> command elements for read operations. In newer BAM versions, the mask
> field for read commands contains the upper 4 bits of the destination
> address to support 36-bit addressing, while for write commands it
> continues to function as a traditional write mask.

So the hardware can read from higher addresses but not write to them?

Plus, you didn't explain what the mask register does on BAM <1.6.0.
If it really masks the address, all reads will now point to 0x0

Konrad


