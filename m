Return-Path: <linux-spi+bounces-11156-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C012C4DBC3
	for <lists+linux-spi@lfdr.de>; Tue, 11 Nov 2025 13:33:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F318F4F772F
	for <lists+linux-spi@lfdr.de>; Tue, 11 Nov 2025 12:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A02358D2F;
	Tue, 11 Nov 2025 12:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ld0DXzZa";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cFNhgKKN"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A18358D25
	for <linux-spi@vger.kernel.org>; Tue, 11 Nov 2025 12:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762864047; cv=none; b=XbS0OSMZ4r7y6JfEhHOdTyalEul9ByMyS4Jk5HbEy8ophjwrwDfXNX3Kq6tSJZezAz+3gDvcI4LrXe4gLQseUcXNCSn8NgQGI6jP0Pwo9k6seoSep4yglyPgPH8BSeDwzsYuTHkhBo3PcdcgIn4rMtH1m0sYJlM1nSCCe8uyIxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762864047; c=relaxed/simple;
	bh=9VPdrRXuIiNKZGp5Pxv40MBiLERQtMECtEUEhoRYdWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iWBFmenHqot2i+yCpdBGEHtId5/eyuNF+miL4D2Y6RIAQsRO25FhkuQ0bsk+OnsS0PuogbLJDTJSRRlsbhbARbivdouDXlNkdMjjAFlOlWQGMSKZuEVq7aqkG+AC5efA0C/j4nhWFy3ckJ5bCQ6BcU91NOZifS/c1ItdIHnwvaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ld0DXzZa; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cFNhgKKN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ABBGYLo1937346
	for <linux-spi@vger.kernel.org>; Tue, 11 Nov 2025 12:27:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=pbbrsg49P2hYmXm7dQ5eWDSM
	EBm36DXZS4l1a3OLYOE=; b=Ld0DXzZarx87x9JI2y8/ul/5gkJi8yJh/Z55cq6p
	4xtqa0zi81A3mxRcAzsccv269OjllNaHt5kBQQEJvDOIqgqjTauVG35qaoJIgf3g
	psL0WT1EPGDJafvFMGpXcQTwLp96ePUl0IN90LNGP8se7xfwXL48YxY8x0AtqS8a
	9Istrm52AUczg19MDs2vOL07nSpcPZfLuswESwKTqJCCNe0uKnhgVJFAo+QPkdu9
	NCoyEFxVK00YOB/2ML5qw0x8XtrrQQf+U+RH8t+ZnfcbSm0Gl8TN1SOgzO7T0U5g
	TJOa5APySl5w8hG+eGXRVG0+5+ji0qfvfLNYSEmHnFmsVw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4abwtj9cd7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Tue, 11 Nov 2025 12:27:22 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4ed74e6c468so57524421cf.3
        for <linux-spi@vger.kernel.org>; Tue, 11 Nov 2025 04:27:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762864041; x=1763468841; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pbbrsg49P2hYmXm7dQ5eWDSMEBm36DXZS4l1a3OLYOE=;
        b=cFNhgKKNhtLvsA30GrXls655vYepZ4TdijQb2zb85x1XFLhnUiqdvj52HnRk3l5kG/
         NJqnEsBgbX3wNZSqXuY1ZxncHbXoZqbe74UMQm/t106h7f4xibGaklPZ9Ax/Nj7mLNgB
         z8QsR2tqLVSEtoZ/oWIUywG/XCeO570l798sFwTazoXEagBk2xuPfhPdmPuRHpI0Jc9h
         6DW0Fz/Nl8LIscE4A+hu+cR8hw6pa9PadTpXcuIQG6z7wArf90WOEM261st+qZvBngG7
         hMZZJvQksUCKokX9cGBCjlPkwT5jH/9mR29vWspiwBv+bMeFi29kLMTmt/28tc0+EeDK
         yebQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762864041; x=1763468841;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pbbrsg49P2hYmXm7dQ5eWDSMEBm36DXZS4l1a3OLYOE=;
        b=wrg//XN+4kbUYeAD5k6EjbPcANyIrYs3LFwkB/KCSuL+AHq7DnZfaZLz+Xzx+1MCul
         TpfalkTwG8K3yDDtQ2rgd660zF5k8RbVEqCnN9fdYFoZq1dW7gBPfp3aXqWhR8srOdYD
         5h/mSvibn2EBPu1DeS1+Y+GK2sMe6Y5tV/UzmU+mjb3AvdpWyikMZ4YRtOOR3B/tmhPK
         m/8u4MV9iD+Bvc/t3dHsc9yBw/8td6zKraFt9ZzamDyt7vwqUkvZiNt99S5myIyNAi2x
         UN0Mh2MtGOfsgg7sD9JjO4ryNPU18IN8XU6VihrbfUV8fJV1VAbz6VlY25PLO84o55ld
         VWig==
X-Forwarded-Encrypted: i=1; AJvYcCUDcVMdexxBnJTeZmetYHbkWyxbc0xrrvo4J/sHGMXAOvN50J80XvjOww6oYUFjyoXoKsjMInurAR8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9ja+kc2sJ1fJgmd7x08W6anhv6u5Z1dpmbJDHobVNeUv/gry0
	8uMdh16ZAGQgmRrSPII41bu+hacSg3clU5RWR9qqtSK/Ge0tD93hskyG3opj4qjuAI5bha43LjF
	iv6lSAmzXY49GASgyYvBLyvYqDYdOSYAasYc6y0ffpJ4PKdOtzP2fII6q3PtyykE=
X-Gm-Gg: ASbGncsaN53xR7n2DA7FJ9RrgaopSII4bMDdiNcWAXLP4Hmgqhz7snEXONwLwCB6Pxw
	I/b9worGq0ewrFRxjMS1i6nxPdYPQHDb+lGy17p5zAlm+WUYYwfqoPQ7twVsDV2aS4pWsV405RE
	Rm/fvwhCdzdNdox8KovqB38hbLEuMaBrQUXOArFcSBGJROMy5EPb4yfh4Th1lxAHdOtDW+JPDRX
	Fg+LQ00nAvjGmp/YXU18o/nJD6HzHPQOWlOCEb2QZIvj6kosBUjyfBC7jHnPJQU/MRbAvgY6HuH
	1R38QVVMAdPI/91uOBUrg4g7VK1WJUb40R9KqVvTP5+YTQosZt4vMDZs8ADK5FQgbzo4sCATEdF
	PfvvvTGWl3CZU2xLBwsqPQ5SvhXjpZbS9rArUSskfGgscupF2DkwtNxcK7F5EfEvUGDEs/WWRIo
	Qxt1+j+saLJGEl
X-Received: by 2002:ac8:5751:0:b0:4ec:eea3:41fa with SMTP id d75a77b69052e-4eda4fe0032mr122499151cf.77.1762864041379;
        Tue, 11 Nov 2025 04:27:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG0G04Stzhf8pvrcPOEA7hZPvaHFQrTVkryE5kOpt4Q5+i+ssVi1BunvdZnSlbfnyCsgzQ5bw==
X-Received: by 2002:ac8:5751:0:b0:4ec:eea3:41fa with SMTP id d75a77b69052e-4eda4fe0032mr122498701cf.77.1762864040830;
        Tue, 11 Nov 2025 04:27:20 -0800 (PST)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5944a5a2042sm4884994e87.112.2025.11.11.04.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 04:27:20 -0800 (PST)
Date: Tue, 11 Nov 2025 14:27:18 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Riccardo Mereu <r.mereu.kernel@arduino.cc>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, broonie@kernel.org,
        linux@roeck-us.net, Jonathan.Cameron@huawei.com, wenswang@yeah.net,
        naresh.solanki@9elements.com, michal.simek@amd.com, nuno.sa@analog.com,
        chou.cosmo@gmail.com, grantpeltier93@gmail.com, eajames@linux.ibm.com,
        farouk.bouabid@cherry.de, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, mm.facchin@arduino.cc,
        Riccardo Mereu <r.mereu@arduino.cc>
Subject: Re: [PATCH 4/5] arm64: dts: qcom: qcm2290: add uart2 node
Message-ID: <6mr3k3vxgcxpddh4zmheeon77mru6r7hd7udtup2cqmvvziywx@xapbmrtblpti>
References: <20251106153119.266840-1-r.mereu@arduino.cc>
 <20251106153119.266840-5-r.mereu@arduino.cc>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251106153119.266840-5-r.mereu@arduino.cc>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTExMDA5OSBTYWx0ZWRfX9pL22vSNXj/m
 I/iumz7L0ia9P/pIPJMEWB32lgBLGp8Ax2V0+9E4y1ds4Anw3dBLojjKagFK0glc9+gq/50KMfc
 lb47IJz46nDRsNJOyatIFMSZYHn1F2Lq46b6cVaQSEtze6VwBEPZT9o0TxQEpyiFSsrd9oe1YJf
 0RT33J6SY8A3m91V5TwTpIZzn0Zj7iWgA0wwRIcFf8aiEO/RwFyYpER1yQhS7hrv3+Ff/RNAETc
 IRfW9Av8Ei+lwPl8/+pzFhly8Q5XT/rRVApSxs2apN+HVtzLqq2JSlFR4Uij5PhxiWQto/5AshU
 /vLH19a0KdIlx5si+viB/m2Y0e+jGd2fdUJFVaNZP25IoU0bTP+0ly36tCI1X6S5jgEeWYaQRik
 2PRlnCPO3PiiJaSwM4DkK0kULkm3GQ==
X-Proofpoint-GUID: Uogj3ymcyU-N4Yl3A3NyoqiD89oOsxvi
X-Proofpoint-ORIG-GUID: Uogj3ymcyU-N4Yl3A3NyoqiD89oOsxvi
X-Authority-Analysis: v=2.4 cv=UI3Q3Sfy c=1 sm=1 tr=0 ts=69132baa cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=D7qGd7DG7pF3fn8uCYwA:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_02,2025-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 phishscore=0 impostorscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 clxscore=1011 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511110099

On Thu, Nov 06, 2025 at 04:31:18PM +0100, Riccardo Mereu wrote:
> uart2 is used in Arduino UnoQ as an interface between microprocessor and
> microcontroller.
> 
> Signed-off-by: Riccardo Mereu <r.mereu@arduino.cc>
> ---
>  arch/arm64/boot/dts/qcom/agatti.dtsi | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

