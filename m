Return-Path: <linux-spi+bounces-5497-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 866B29B0CE1
	for <lists+linux-spi@lfdr.de>; Fri, 25 Oct 2024 20:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B696C282982
	for <lists+linux-spi@lfdr.de>; Fri, 25 Oct 2024 18:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85206206505;
	Fri, 25 Oct 2024 18:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SwPLDvLT"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49D9209F57
	for <linux-spi@vger.kernel.org>; Fri, 25 Oct 2024 18:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729879997; cv=none; b=P2/kisHnBghKm7U7yMO9YzcD5No4P0cdQZgdY455FNtUC65gNFu/M50w1DVl+rW3thAK1Tr2ffpImNtzg3iERSd18hixMpFxyXDoSXusbYBkkRLj1Uc06IYaVaOoCwG1Jl57H4FXYBzCfIr5lS2BYj5WV6e8ieU1+/3QxbVxXak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729879997; c=relaxed/simple;
	bh=yECRnd2IuokgVBJ4FyUPRnU8Ngna585ZRd+94fsPnFs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cYo5t+G3Vo0B7rTSOxH1Oz7ey7fn0ozAHZpaxJIlidJFbjqvDFPN2vkieXkeq/hrbALoEuIDxDFzaibQ9rM/VD1LnNa8F/Bdw+GsLvMsCRrFdTyFPvOjq73Lhy3VhOLxsgKPuioTpd8DcL7d50lxk53o/udgy4em/3ela9+RTPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=fail smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SwPLDvLT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49PFLY17022315
	for <linux-spi@vger.kernel.org>; Fri, 25 Oct 2024 18:13:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	S6J/Qh2/LbR/I7UXVqELD64wgFXzyzqALoQ0edTkwr0=; b=SwPLDvLTVS/mgKUQ
	UeA5oIB9p3422rMg16g/82HFQNxc+9oAJhncxImi/WK/bFtnKOrdW5oUhjisbTZF
	SgTY7vH/7nC1udG5H8t5x9Fzmo4LQwGcqQ+UPaON3doWElfNS1OiCyHAaikbmtS5
	Q6bg8+7uhm9XggVIGZPxHhAWFd1Rs4woXGk7aRn4D4Fv+F/EZPptxSsRMuNL6+Ul
	MWqooxDK5dWQJVb0FD/kpkabGoxmiWNj8zY8CCMBXNu+1BTq3cSYT2WU6npZnu9p
	hjmjgNVqVTZaZk+yA99JLze5MoVs83sxgs1Z2ZjQhlr9A/kECVSJAYVrY3Va8ryb
	NIewoQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42g6y91vtw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Fri, 25 Oct 2024 18:13:14 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6cc290898adso4614816d6.0
        for <linux-spi@vger.kernel.org>; Fri, 25 Oct 2024 11:13:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729879993; x=1730484793;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S6J/Qh2/LbR/I7UXVqELD64wgFXzyzqALoQ0edTkwr0=;
        b=tJco1QFpheFnus+bHcOFeANaL9/azgsKm2YgN07TXYs6wAf/M2qD5mkEGW5g4qfKNQ
         OjC/VjzniDQCk88O0gOMRmBsAO2fVeF85ZE19K0LBXU+SsOJt7Of4tQDFpy+O+RLJXUG
         /h7sqR60uiz8EpC7B0KNZqOHqwdSvgWyfkNs/vZ8LePRzDAnr3NdkC9pL5UgHDDmP8k4
         bGBFCE/OSJSHDvrfAYAoHIKnLnNPY3bbmRiqldK0fpYPyChhthzolp9yqvOD1YG0t8mE
         LHO/UOeg81JcrFxizquTKU/3mzbEnlaG8kuy16df9zckBfWAvuiFRi+E00bky3jtQI0O
         ICKw==
X-Forwarded-Encrypted: i=1; AJvYcCVv4bmZVC4b5QnjQin5BoajsyzV7rsU/Qa/OLThi5KXaHcyFbpqH4fUUyC37ZIS5pkRaWKnaFyaPqE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXK+NbqD2q4JEARjui/ejuPvJceCFjJiGacPX10p9bbXi44l+5
	0q4hMJgaEsHeD4PlkERFl29Yqvjp6cv8M7pjoo0yL3qcM0xGt33iT0J2rIVVpEAXWLm0MVllNfO
	BF+UECQjaC/xV1PVjjTFcv/UFpG5+hHpvVPKEDKxA9An/ZHH1tCm5Pv3Yhgk=
X-Received: by 2002:a05:6214:da9:b0:6cb:e981:d7d0 with SMTP id 6a1803df08f44-6d18581d7d4mr2307846d6.7.1729879993235;
        Fri, 25 Oct 2024 11:13:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFetU8WERXTxmTfnz8BSCC6cA2/u+vTk5Tzq/OIHDVK0c/Vs/rj3bS2lkScfXLw1sM4zfAQAw==
X-Received: by 2002:a05:6214:da9:b0:6cb:e981:d7d0 with SMTP id 6a1803df08f44-6d18581d7d4mr2307666d6.7.1729879992907;
        Fri, 25 Oct 2024 11:13:12 -0700 (PDT)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b1f0298dcsm95063866b.77.2024.10.25.11.13.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Oct 2024 11:13:12 -0700 (PDT)
Message-ID: <a4c85bfc-9e76-4dcd-ab09-699d50fc73a4@oss.qualcomm.com>
Date: Fri, 25 Oct 2024 20:13:09 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 5/8] mtd: rawnand: qcom: use FIELD_PREP and GENMASK
To: Md Sadre Alam <quic_mdalam@quicinc.com>, broonie@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        andersson@kernel.org, konradybcio@kernel.org,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        manivannan.sadhasivam@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Cc: quic_srichara@quicinc.com, quic_varada@quicinc.com
References: <20241021115620.1616617-1-quic_mdalam@quicinc.com>
 <20241021115620.1616617-6-quic_mdalam@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241021115620.1616617-6-quic_mdalam@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: _SXd9MuVC9Igm0S_5B1cpkNMGAnefYj3
X-Proofpoint-ORIG-GUID: _SXd9MuVC9Igm0S_5B1cpkNMGAnefYj3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 spamscore=0 adultscore=0 suspectscore=0 mlxlogscore=815 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410250139

On 21.10.2024 1:56 PM, Md Sadre Alam wrote:
> Use the bitfield macro FIELD_PREP, and GENMASK to
> do the shift and mask in one go. This makes the code
> more readable.
> 
> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
> ---

[...]

> +	host->cfg1 = FIELD_PREP(NAND_RECOVERY_CYCLES_MASK, 7) |
> +		     FIELD_PREP(BAD_BLOCK_BYTE_NUM_MASK, bad_block_byte) |
> +		     FIELD_PREP(BAD_BLOCK_IN_SPARE_AREA, 0) |
> +		     FIELD_PREP(WR_RD_BSY_GAP_MASK, 2) |
> +		     FIELD_PREP(WIDE_FLASH, wide_bus) |
> +		     FIELD_PREP(ENABLE_BCH_ECC, host->bch_enabled);

CS_ACTIVE_BSY is no longer set (not a functional change, but it looks
omitted on accident)

The rest looks good, thank you!

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

