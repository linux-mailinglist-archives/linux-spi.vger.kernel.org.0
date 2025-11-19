Return-Path: <linux-spi+bounces-11291-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 18730C6DC73
	for <lists+linux-spi@lfdr.de>; Wed, 19 Nov 2025 10:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D504E500F12
	for <lists+linux-spi@lfdr.de>; Wed, 19 Nov 2025 09:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D52B43396F1;
	Wed, 19 Nov 2025 09:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OOA32La7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="K3HetOl7"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BF632F75C
	for <linux-spi@vger.kernel.org>; Wed, 19 Nov 2025 09:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763544137; cv=none; b=E9Sa39tbVpzipWkbCV3c/x+TZDK/MCSNSZVKz3KwnqUuGo05NVDjWAqa+RHBVHRbGxN8ALeKJAZAF+r4MLm9clkodiJ5X4XxeKc6cgiAjIivzpPPRNp6SEfkSYsQY90d5VfD9qrGcBZcO+Il7A8YB0ii3D72blodlvETzFGWR1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763544137; c=relaxed/simple;
	bh=lADHfqpowyyKvEv6P/mixvEFhLAPoqY2zbgoMB9bccg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pn8/qPNTpKYdbyH5stybDsZj96qCcTzEwGjbwCvUV2bGqz+8bjeCiPTXSxmQSQzXaaLUVuyDIeLZeF8I3v9SOhoNtYeqsFku4vm0nvf2kfTHmj2B/UuyCu3oHBIiJj4N7f6bGIr53YmRwWNUzBe8b+z9vzfW8dEjL0Uhjca/+CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OOA32La7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=K3HetOl7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AJ4vAks1031508
	for <linux-spi@vger.kernel.org>; Wed, 19 Nov 2025 09:22:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5f+J0fD85sWk8MU0RliMNAOW/+gcld35mbmvM5bB2Go=; b=OOA32La7iBDQsmxD
	JhwmuZMgTjGBCWV6AVMq52GNe5bVEHyz9kWcG98cmxfUYl7XIqmFYGJ4Jd+CkU/Y
	9SMzYYFMcKonJlq8hOvIicfwGdx7tgsd3132NA8bjrbaVLlPL0AxCM4HDgE5woCT
	xC7dq7zPet8BVWju1u3iQjvB9/wfwupdUDqRPitsAyUgP/xEybkeBCLOxunf2B5h
	uczAJbEjjEIoX8XdCJznkryojwXRGCwPNo6iUFjapI02duNm0+aDPECYrZNqORh0
	tLntqIR2+EOLVnGNFUV3w8ExPnzXrdx8BKuno338cK5W8pommSdDbBMm7D1fS77l
	kGRFfA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ah7anrscp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Wed, 19 Nov 2025 09:22:14 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4ee0488e746so15298101cf.0
        for <linux-spi@vger.kernel.org>; Wed, 19 Nov 2025 01:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763544134; x=1764148934; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5f+J0fD85sWk8MU0RliMNAOW/+gcld35mbmvM5bB2Go=;
        b=K3HetOl7K5kZ46TtOps0ym5KQVLSsQYviC+9g2hYB+CAgy469g1jvQDzILEtylpR3n
         37xBXSB3uTJe5xkniz7cFzxJAcOg9zUYZwZeyxlGrYZRnvTOm8aroYBLPtNAUHhwhwXu
         1G8E2y6RBXSfN4sszmaHAQiCjvKRtbGISdZmmJvX5kuzwjTI+EvEYFOgg3Lcf57EKbOr
         Y9wNlP+6+9n6m3OzUQKxwOllcOSqhRtXbDxDOqh3Xf+RoeUso1q5VzvzKECkqF8O2FVl
         gCRBH/MAPNZP3byBbsM5SxE2JvH5Z/ITy69oAjJ3aFZVnBLJvgIzFcuuMmlB7WHmqOtj
         sWaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763544134; x=1764148934;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5f+J0fD85sWk8MU0RliMNAOW/+gcld35mbmvM5bB2Go=;
        b=baViEskZTintJ7IzVcD+P1KvrUEHtQKFGcrvFQoH4NpZNtkt/dcfFRher+4p5TkIWI
         BzZjBaLEhqyO7+kLjHQlUI8s0m+TvceuXRBSNeYfRZ+kRLT7W6CSAQEzeUGQj9JBg6cJ
         J1numHfMMUbeOkmcZF3PgFoDqUzaG2POAVRgG/LfWeN+VSOhjR754mT58Uh75vCUJBKb
         /gYt7x7lftMMOB7GW/uZ71PTuUbBhKs1xUzTVE/KiTsTNVBmeaiP7HY/1y/j8MDcOchZ
         6ZpWzPU2ZbQuMVUV1/ikZLgsE+q8UGEAUY0Ck6kYczp9abeLBex8G+9V5qcprwaP64XG
         5K0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWQLiQRROMwHGL2eG4evq/5AFAojfpSbI4fj6LOwfxdVp/Q9DCAXpB7Ki9i01d2qjC1iZYRTFXJSyY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwF2h51w3fU5xPGZrHow8+YMLHkfPcqdAQEHk7f4CnctDST9pzX
	kx5cuKj4wwNlp6r0Uf1HYL+GMi3+Tl8cNZ3/9O8jY/jxTwUjf1SafW+GoCj1uYkeIOgDbGqLf5C
	mm5pCA3IbPU8E2thCeNHE9UYStKLhLK+KNn3kpIsnRX1sDdCtDaCdukC4UUl0COA=
X-Gm-Gg: ASbGncvbfJ1GkWa4qdiKfY6XRoZF5ZvVdZeCJ9jbnsdrQNDn1ohI7UYUZsaXzGPhKPg
	QFum0WtDpENz7Ec+qdJ32HSWJbNVJsrMdwuoNy3esJvunTD+uxqJsc/11J0OSdvG/Wj8DSFPjl2
	L/mnQ8KGiOx9dlRAlSZSe3QoJHJiXSby9sOoqE9W6ldaLG/AFrJ1R1FUHUlR/+kJacqHpZ1hFlw
	lGbyF4TkvhcvggKC8WDqsioaLGT2ZXN3RKZ9JZLF8gTlyDrIZsdU/nVqhgU2yVSCvrjinfQRC93
	qNgdqOW/a00INs+xiLGACuswTj/psDT1NWm9dFjw14lOSMOjn3xLvRs/I7XKqerZvJXUnb0OEZV
	SfIpvOkruTJ3o3XoXesfLiwcl/iPqU5LRPkoyv5iUnO1926XI43qZycp6Lvy5D6SWa4344EmTz+
	gd4IDAalFfeN0oUsUtmaQtx0U=
X-Received: by 2002:ac8:7f0d:0:b0:4ee:27a9:958d with SMTP id d75a77b69052e-4ee3fdf901cmr21432261cf.16.1763544133871;
        Wed, 19 Nov 2025 01:22:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHZYsTdzI0vo18xePQ7Wn/lJyBt7LqS1yTpBmbK6Nd1hAspec4tyGec1K+AGljwAYmnnQ+ojg==
X-Received: by 2002:ac8:7f0d:0:b0:4ee:27a9:958d with SMTP id d75a77b69052e-4ee3fdf901cmr21432051cf.16.1763544133391;
        Wed, 19 Nov 2025 01:22:13 -0800 (PST)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5959b43420esm867907e87.65.2025.11.19.01.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 01:22:12 -0800 (PST)
Date: Wed, 19 Nov 2025 11:22:10 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Riccardo Mereu Linux Kernel <r.mereu.kernel@arduino.cc>
Cc: Trilok Soni <trilok.soni@oss.qualcomm.com>, andersson@kernel.org,
        konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, broonie@kernel.org, linux@roeck-us.net,
        Jonathan.Cameron@huawei.com, wenswang@yeah.net,
        naresh.solanki@9elements.com, michal.simek@amd.com, nuno.sa@analog.com,
        chou.cosmo@gmail.com, grantpeltier93@gmail.com, eajames@linux.ibm.com,
        farouk.bouabid@cherry.de, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, m.facchin@arduino.cc,
        Riccardo Mereu <r.mereu@arduino.cc>
Subject: Re: [PATCH v2 1/6] dt-bindings: vendor-prefixes: Add Arduino name
Message-ID: <syvywx7pph3fnoayaghxzyufl66xueoi3tw3i4wdaq2cpjhe32@vbmdjywlasnl>
References: <20251114121853.16472-1-r.mereu@arduino.cc>
 <20251114121853.16472-2-r.mereu@arduino.cc>
 <5c30421e-108a-41de-81c7-c0c5e5290cc1@oss.qualcomm.com>
 <CAKA1JhYgUUSQxcvmJPdeLu8S_tO5HUOb2GAhS_zX6jUOQzfm1Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKA1JhYgUUSQxcvmJPdeLu8S_tO5HUOb2GAhS_zX6jUOQzfm1Q@mail.gmail.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE5MDA3MyBTYWx0ZWRfX/YzAyVNfAFgj
 Zttvhh9Khw9DyEiHhbYIL8LMn3oksUASKBRicXf0lTUjW79Um0JIXFIS1GF7G6DphWIl98wMyQD
 WnlQN7vy6I0FfpfHUJugfrjKSYfdWATg4K1fT8PInBBXV+bawYPeprmCa7SsIhcifi9B/fUZq9Z
 GA8mOrUxh/ih/fwAOoee+yyb4j0LbGXM9KZtwZy9WI4Zp0XPVM7YYAj/LW6XI60NZHE42rtH/Ay
 sNfo1Mth9ZPHWFCstkJXvNiPav75EOUwHEBS2h9E30+ty78kfvyMqOxyAHWfpb25s/dGQlkyClM
 rhlCYv2TLC+AK3AkVi+iY3FQ30uvEGar8e7ZUgwNfr/q7Gzu2dOewns9pq/uXxPRjm1UaI/TmMh
 uA0VrQtxrQEtx12lBsFDJBYEssrG5g==
X-Proofpoint-GUID: en8e8d4Fw3WMejH3PYp5IUmayxqC7-hh
X-Authority-Analysis: v=2.4 cv=a7k9NESF c=1 sm=1 tr=0 ts=691d8c46 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Ar_5JxPjAAAA:8 a=EUspDBNiAAAA:8 a=Dh_I03XhuwJppenT9bIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: en8e8d4Fw3WMejH3PYp5IUmayxqC7-hh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-19_02,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 phishscore=0 bulkscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511190073

On Wed, Nov 19, 2025 at 10:11:06AM +0100, Riccardo Mereu Linux Kernel wrote:
> Srl (or SRL) is the equivalent of LLC, SPA (or Spa) is the equivalent of Inc.
> Just noticed I was inconsistent with upper case and lower case letters
> between commit message and commit content.

Should it be S.r.l.?

> Do you want me to fix this in v3?

Yes, please. You need to send v3 anyway to fix From vs SoB story.

> 
> On Wed, Nov 19, 2025 at 5:49 AM Trilok Soni
> <trilok.soni@oss.qualcomm.com> wrote:
> >
> > On 11/14/2025 4:18 AM, Riccardo Mereu wrote:
> > > Add entry for Arduino Srl (https://arduino.cc)
> >
> > Is Srl or SRL = Inc or LLC?
> >
> > >
> > > Signed-off-by: Riccardo Mereu <r.mereu@arduino.cc>
> > > ---
> > >  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> > > index 42d2bc0ce027..07a285c9387e 100644
> > > --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> > > +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> > > @@ -158,6 +158,8 @@ patternProperties:
> > >      description: Arctic Sand
> > >    "^arcx,.*":
> > >      description: arcx Inc. / Archronix Inc.
> > > +  "^arduino,.*":
> > > +    description: Arduino SRL
> > >    "^argon40,.*":
> > >      description: Argon 40 Technologies Limited
> > >    "^ariaboard,.*":
> >

-- 
With best wishes
Dmitry

