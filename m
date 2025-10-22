Return-Path: <linux-spi+bounces-10779-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 162A7BFCE53
	for <lists+linux-spi@lfdr.de>; Wed, 22 Oct 2025 17:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 42D914FBA13
	for <lists+linux-spi@lfdr.de>; Wed, 22 Oct 2025 15:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1077534D4CD;
	Wed, 22 Oct 2025 15:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ILZvfWV6"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA0834CFD1
	for <linux-spi@vger.kernel.org>; Wed, 22 Oct 2025 15:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761146912; cv=none; b=r+9BH0t7QeBzsjc+JkNeDaXBhXS+RJx1leuayPB1gNBITUWOUSFLh1hBcQotW5tnSmGjXhCKwEEB0X5btB9uryHe0OfoLQfSw2VcxFSw1df8ebpmpSuH7O0Cr7HLh18AGjqCfsSJW3ddlsQ26ObxufIyKAF+FVnru7wj67KagIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761146912; c=relaxed/simple;
	bh=LKg80GSsXajEimsbU2IImSWBv/62yWeZsCxzc4ocqVA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nGFwyzFpDb1GQAkF9sGRtQtq2IT4QsnjksCs/K/nRgJvC/KSXJCzPpn3pAChg2zSI1nl+W1lo1rMuX+XYxTs3eA3IosYtBy+asQRkVNQu5dsv5dw8AsSeGcBd+uWjeemCMK+EFN7kiTJljr8QJVlYhwdqwZBW2fqOeMyO7AFg0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ILZvfWV6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59MAJ5VO004435
	for <linux-spi@vger.kernel.org>; Wed, 22 Oct 2025 15:28:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kEkN3I7ez210KvWSzWyrOcOsuH0KwadB9yDxw0Xm8nE=; b=ILZvfWV6hSPfBB5J
	g2+JWRa5A3ucDW0n2H2/I/8ejYIUzQKN9LYqo6m/rEmw+chUvqXhMcY4/CdbfTGr
	sRT++teJ3xdavvz6u7hIdzFqOmiXRAFzbhewbT5CLz7yNZUGuZToZVTx2aD700bn
	pKHNPVLVCcCnwBw2lHbBDy679TTkT6bWKyZxZTTNZu9nGEhiZ//2Fc8WiOZWkL0I
	05/3zBBEnxjxatTOyk+UMsjM4sLQnZhKc0c/9E8mjvcYEef20Swqa6V0y4piTCLS
	EA71sOigZgcIpSvN6cppV7fEb95urk8T0saPXw2q4kJ7SvWztAQddwx6DEKK5WmK
	+kRTmg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v3nfn4r0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Wed, 22 Oct 2025 15:28:29 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4e8b86252aaso3990511cf.0
        for <linux-spi@vger.kernel.org>; Wed, 22 Oct 2025 08:28:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761146908; x=1761751708;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kEkN3I7ez210KvWSzWyrOcOsuH0KwadB9yDxw0Xm8nE=;
        b=hZAP0GurMIWkuJiUPw31+whGJvAtFg7XwdZym5r9+jGTdK7JHaC+KOA5oxSIjHrkm9
         IRc1L2w/xrVyNdXnSoqXVMZaan3xjB/b/7y87bNpffi9Z424CUfbTehGek7HRNNcDlX8
         mjz0DeNjEdSb7/C7IToN9pnEe0KtVtfDXkSq2NfkeGwBav8YvhDYRM/4QqptmTPaOIxz
         iSLe3N25cs+jMBjRYRRzr4U7FoVfNdW6Ev4EuLzryfkaBkPl1Af6b6Ntb93zFomkBYhf
         De+j1gpQ/XQUQii5YKs+DkRecNeIg4N0Hgw4EBMC9pFvp+bFDyRQoGVXHMfbJtfgK1Kk
         sJiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmoV8idHXuFLBKLo/XxExf1zXx5riaNG3Ay1H6axOBn/u2+e0oOdxeBKFfb0yh6kQ0TsmAxht5Vus=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjBVR2+2rpfWrks1182AONRiSNROZ8f9tza9vkvWxWvRfVcewQ
	eBNlG/CWcXKq2gqvXO2a93SVn8yBbILulkfHB5AxKTcfZOAAIWvyUvrC99Plff1lUZEVytu4bYV
	tKShQU1LZC3LGAEvBIf9/PeHdLUqiirXUDMuNBOLZWsK7yCQWbB/UELWuUjJpj6o=
X-Gm-Gg: ASbGncuWEfOC/5vnWI4apuu7H6l6cnbhn/ZzvhQXS3cAzZLsz4kUhsaMdnaDPG42OFX
	RFUvqzduSMZMbJhE8EedOG0yyNcO6nPjHbqofB0kNg+Fp/8+yFnXOj8eIhSJ3QH7jItSUren2FG
	cYEoFSzZCipwBb7DSDM7X3lsK6p0q5HBv/jaA3x8anEAYP7Bw2zxFjsUHMVNibZ+97YyDe9kIvq
	XitMoVi3WZ4bFujdud9BRtv0DhU0AYGpdf3ddLgffTLRcZqLLtXQE7w0IrtFhZtkx7JX2IY75k7
	9YR3G9fDyOISvzb/VbvVF8zNzdwBV5y8AVPkLeTXARfNbFqOV40dIpIVRhFgOklH3pmHIxCwrOD
	ezN5Hc19Lc5FSKbqWf3SMCwanIys4glMIvuttAJ4/qGSxZGQnWdqJ5o3O
X-Received: by 2002:ac8:5916:0:b0:4d7:e0ed:421f with SMTP id d75a77b69052e-4ea1167dbc0mr64496571cf.3.1761146907968;
        Wed, 22 Oct 2025 08:28:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIbfA/J7/7e/fTVE+4K3MaejRMmguF//6ihYzs52oLlv/Bgz24gIfsByl/uIBh4sKc+gqcHQ==
X-Received: by 2002:ac8:5916:0:b0:4d7:e0ed:421f with SMTP id d75a77b69052e-4ea1167dbc0mr64496241cf.3.1761146907534;
        Wed, 22 Oct 2025 08:28:27 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65eb0365e1sm1371481666b.48.2025.10.22.08.28.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 08:28:27 -0700 (PDT)
Message-ID: <41481de2-12fd-49b5-b3bd-f3e44e78dcb3@oss.qualcomm.com>
Date: Wed, 22 Oct 2025 17:28:24 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/9] spi: dt-bindings: spi-qpic-snand: Add IPQ5424
 compatible
To: Md Sadre Alam <quic_mdalam@quicinc.com>, Mark Brown <broonie@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        andersson@kernel.org, konradybcio@kernel.org, vkoul@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, quic_varada@quicinc.com
References: <20251014110534.480518-1-quic_mdalam@quicinc.com>
 <20251014110534.480518-2-quic_mdalam@quicinc.com>
 <dd1e4289-5e36-4b24-9afd-f09569459a96@sirena.org.uk>
 <96ae7d38-4ce0-fa34-e6f0-6bb6e4ceaa28@quicinc.com>
 <0a743099-face-4cc1-91ef-098a748604b7@sirena.org.uk>
 <49eb9f15-fad9-4f8d-1463-04cd692bbe51@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <49eb9f15-fad9-4f8d-1463-04cd692bbe51@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: b83SWn8kYgIc_aESfjRYcwO2LAIE2x-N
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyNyBTYWx0ZWRfXz7dYpjm/MLNE
 KheApo2yESq2N3ygyZNyRNiBg1LMiDoXVeYOF/jpg9R7VF4oFpCrBb1kbV9eAtmdpg80T0sCyee
 2+H/7s4akgs9nWnKj37ptyZUa/c9gkXw3/dfBCy3QYvTz6Qpw7hOhK9GZoqYSh/+Y5hXr7vdwV5
 /Ei0ezd/6oRtL0QDdV8qXXbO2ywfvbafBNlner8/U9ATRj/YXznMJboA8cLIlWNttlOv1BBH8+T
 QCq+3ZURS6Ti+QmM/5kUj/PsgXzxQVROu+w7VU7Zs8lKIZ42qAYbU3mzepVyzHLja1blTvXv01M
 Ba/eM2yYDiZ8dkIo0CMXNIKDxLPNU9gtrEhJEWCfahd+lRg0tMelSX0dK4ByG/PEPhPPgjue1qo
 gySo/AiT4XAomTlRUZqwB9BW06UnXA==
X-Proofpoint-GUID: b83SWn8kYgIc_aESfjRYcwO2LAIE2x-N
X-Authority-Analysis: v=2.4 cv=EYjFgfmC c=1 sm=1 tr=0 ts=68f8f81d cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=WIUPFbzvC2a9H5sHzXkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=HhbK4dLum7pmb74im6QT:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_06,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180027

On 10/22/25 5:20 PM, Md Sadre Alam wrote:
> Hi,
> 
> On 10/22/2025 4:12 PM, Mark Brown wrote:
>> On Wed, Oct 22, 2025 at 12:29:01PM +0530, Md Sadre Alam wrote:
>>> On 10/22/2025 12:39 AM, Mark Brown wrote:
>>>> On Tue, Oct 14, 2025 at 04:35:26PM +0530, Md Sadre Alam wrote:
>>>>> IPQ5424 contains the QPIC-SPI-NAND flash controller which is the same as
>>>>> the one found in IPQ9574. So let's document the IPQ5424 compatible and
>>>>> use IPQ9574 as the fallback.
>>
>>>> This doesn't apply against current code, please check and resend.
>>
>>> Thank you for the feedback. I’d appreciate a bit more clarity on what
>>> “doesn't apply against current code” refers to in this context. I’ve
>>> manually applied the patch against the latest mainline (torvalds/linux) and
>>> it applied cleanly without any conflicts. Please let me know if there’s a
>>> specific tree or integration point I should be checking against.
>>
>> I tried to apply it to the spi tree
>>
>>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-6.19
> Thanks for letting me know — I’ll rebase the patch on the SPI tree (for-6.19) and resend it.

JFYI you can generally count on linux-next/master as a good base

Konrad

