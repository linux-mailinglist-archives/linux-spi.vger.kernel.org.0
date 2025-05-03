Return-Path: <linux-spi+bounces-7874-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E2EAA81D2
	for <lists+linux-spi@lfdr.de>; Sat,  3 May 2025 19:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DF8D5A4F67
	for <lists+linux-spi@lfdr.de>; Sat,  3 May 2025 17:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ADDD27B50B;
	Sat,  3 May 2025 17:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="R2gKFMkr"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713A727B4E2
	for <linux-spi@vger.kernel.org>; Sat,  3 May 2025 17:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746292905; cv=none; b=ZUxMx9Kum8bAmI8Jy4klp6oZ4Irkpin8UYYSAFE5LIQAl8T7WYAfUclIvAubO8uU4ZYItzunSkcAMCJ5iDM5iFwmL6lmgRhHASitNEExUvzBPTvNBevmVfNz+IWJuHnYeTlM9nVhnlUvljCpwvdQdeWhMtSpjkcSACoB8NC8S50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746292905; c=relaxed/simple;
	bh=FkqPTKKa1BYfGmOPnQ1QkH3rInAfKUq2BRkp0CBjjRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NHzTmTDncVniyI8C7N2igaxRM7aSJJ08HTAs7cVbF6+7v+jmGP0IJKA/JXIyI2VGoi/Q6z3O0rLP7JgI9sT2kM3yI9XYoYty43G0k0uLP8bFtTlcKP0MYMNKBbaQQIAyOwe3xpw09mamnMgdysqD7yOMLgT2s12FqsSXaTX+4jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=R2gKFMkr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 543EdeAW006799
	for <linux-spi@vger.kernel.org>; Sat, 3 May 2025 17:21:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=CUPi73K0M4K8c3dJhvQF7DaH
	PF0crJym+waMYMfinqQ=; b=R2gKFMkrIBVeDakGd1qOJMFM1lsPaCsuL1Ou/N7k
	51cL4eIgHohEQVKhFQ/5k6V7LxXGxChYmtnHfIYctDgt0tWTcXArYUH9RlPy1Uwo
	cFq1yr3ge9eHVBNkx+jDCWSnXMWKMygsyc39vVaLEtwcpK6fKiN74YbKkPLZ2PI2
	MNdvXiWIdIkAUU/JlSAICZoKdeRthpFkQ1N87LhHxURqHGww/6EtHslqsi4SMimD
	51Nlf4JveqRfxvTDfYT38w+qJPfhIYarKLqVIs+c0HqrwYFP30oTmx+sTqhdhfRn
	+g0ZuUf4U4rutQMYjTa+VGo28MQ/KvEQ3PL1ZVKleE6BUw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46dbh78va6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Sat, 03 May 2025 17:21:41 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4769a1db721so82272581cf.3
        for <linux-spi@vger.kernel.org>; Sat, 03 May 2025 10:21:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746292900; x=1746897700;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CUPi73K0M4K8c3dJhvQF7DaHPF0crJym+waMYMfinqQ=;
        b=xNiwfDebZ4GjnXq4tbuDWeeLRdhEt6Aa6/JM5oGZaikKPND7FXcMiW5hk/QFHO4jIM
         kZfXNI3UeKOl1R1BayPg85xJoHa47ft/Ho3YeKWhqJO4ytNTIgoQdxC1r/ay9j4X/357
         errO3LFGYfhDRzs38lkpVGK/LqoYjV0r5G/MjFJDNdwwnDg+rqacOPrifHYmA6BRg7fS
         c/hL5HIf2e5UBlqvU+3eD+Dfw/tyd6oXHVxx/ACPQLpjqAFJC06Ez9r7qM+jSjUiDuhm
         iH0XRDcHN50i94NRXdj3Y3GT0LTmytE0IctRgVpcJ9Z3DkDR/padLMq9M57xKb9m3Cru
         zHNA==
X-Forwarded-Encrypted: i=1; AJvYcCVSjCXXUO+MR1eHnjOfEYInRzwAwwgYFYpKXjpTQkMx9RnuMDyNbncnm7gHWjw3P6EcuyZeZ/D3zLk=@vger.kernel.org
X-Gm-Message-State: AOJu0YznUZtpi59ti4uJpM5QyBkqspP6EWb3rDthlM10x/DE3AX6W/NY
	id6qV9vHvK3m7RkUWyk8k4xsm3n2gS5mYR9NNocc7b6MbJ/QzA3biXthSxvyLcdgloM1XmwycQa
	hj9UY4FsNjwdl8Ydo6BP7sZtXO7kt+InlxMVbEBusBFQjCLcQLkRFuYsdb3g=
X-Gm-Gg: ASbGncsoDm1Mpm/KMXmS8Km041lK4QvsQ4+hMTkH1X6DfS9NaXmywH7Du6s5cWXFkAr
	FukOm44T227yJzqofdgyhYLEa/5STAdGWWPmfVIwfpqZ5qWNNOujcetI7mrEBmBnL8wi4A6Zhai
	YC8j5MYI35AjVF1eOuUE/GGxoa9Gw1n7MsbOdJeLAWZIQy3wiWRTZP8q0t6D+wkWx//obxIIKvp
	vt0dGu7t9OtVBBxbanCzkLUWF/tipZ0bs9JotiCG43WCGVmn0XZhd26IyzABnwvxW6jZ5WId0ck
	y8Jo/FsCs1wGAi3usptO0l6ZKfJ/o6VaESiSxdrDeOF68Uk6cM6QRHOqiCE9p16oW9HK3JyoF/4
	=
X-Received: by 2002:ac8:7dc2:0:b0:47a:eade:95eb with SMTP id d75a77b69052e-48e00f625abmr15879571cf.40.1746292900328;
        Sat, 03 May 2025 10:21:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGmoBZgMqriscERLtLJYJxOOTXkywtkwOsXpQzulxWIgQLOXUAe46ItjymMZEGDMLwcrBNHcw==
X-Received: by 2002:ac8:7dc2:0:b0:47a:eade:95eb with SMTP id d75a77b69052e-48e00f625abmr15879411cf.40.1746292899907;
        Sat, 03 May 2025 10:21:39 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54ea94f22a8sm878183e87.176.2025.05.03.10.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 May 2025 10:21:38 -0700 (PDT)
Date: Sat, 3 May 2025 20:21:37 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Viken Dadhaniya <quic_vdadhani@quicinc.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, andi.shyti@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        gregkh@linuxfoundation.org, jirislaby@kernel.org, broonie@kernel.or,
        andersson@kernel.org, konradybcio@kernel.org, johan+linaro@kernel.org,
        dianders@chromium.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org,
        quic_msavaliy@quicinc.com, quic_anupkulk@quicinc.com
Subject: Re: [PATCH v3 6/9] soc: qcom: geni-se: Add support to load QUP SE
 Firmware via Linux subsystem
Message-ID: <vpm4ee4bjuqje7zrpay3pllvcghh547yce4nbqgbeujgdbu3lk@fahrgwfjbrzy>
References: <20250303124349.3474185-1-quic_vdadhani@quicinc.com>
 <20250303124349.3474185-7-quic_vdadhani@quicinc.com>
 <58f46660-a17a-4e20-981a-53cad7320e5a@oss.qualcomm.com>
 <9cc6bdf8-ba4c-4561-962a-74ceb09b72a8@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9cc6bdf8-ba4c-4561-962a-74ceb09b72a8@quicinc.com>
X-Authority-Analysis: v=2.4 cv=fMY53Yae c=1 sm=1 tr=0 ts=681650a5 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8 a=vrWCv2ldUtsF7w5ASE0A:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: Gidvjfv2skyznrnPKml7RGyujCj1GrHG
X-Proofpoint-ORIG-GUID: Gidvjfv2skyznrnPKml7RGyujCj1GrHG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAzMDE1OSBTYWx0ZWRfX6AORo/iTkh7o
 Y26E4LkkzhNUTIGeZVSlFQ7swp90EwkmN5KmOajDqCjJesbL9+d3UdRnyjoXWIbMbG0I0zshP2m
 ZdNC3jYF+DOXxsCkZjgaDJk9sP5J5IYtQQ6dFQj62vBr7pgT+RMzXxO+psj3VHAXz80hz/fWf0n
 ieoQqIc00WJ4zyWQ+FHVCjWlF5zBXVKiHPlcJwVth3Mlw2hUgR48N+tOkAv1du1+2wVoMC2IF3L
 cUhdKQ3drdkLtfrUHSYB3r+yM/PEiCKfMkFUWsohwzLDwIGsKVT/a0dccGYlk0bYNp6WFnTXYMS
 6t4KX67oyuOFK8iu1zh8kZyAdk/kMjiumHysgNzqOGQQs2SOsneAHr8zGkk7s/pDbtL0NLBRUk+
 dLXe4cJL1heQy+GK9DcwsKQgjepv8GpAir04bkEjmr1GOW21KF5Wk2shEg+jJF1ybFziEjHh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-03_07,2025-04-30_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 spamscore=0 mlxscore=0
 adultscore=0 bulkscore=0 clxscore=1011 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2504070000 definitions=main-2505030159

On Sat, May 03, 2025 at 04:47:52PM +0530, Viken Dadhaniya wrote:
> 
> 
> On 3/8/2025 11:36 PM, Konrad Dybcio wrote:
> > On 3.03.2025 1:43 PM, Viken Dadhaniya wrote:
> > > Load the firmware to QUP SE based on the 'firmware-name' property specified
> > > in devicetree. Populate Serial engine and base address details in the probe
> > > function of the protocol driver and pass to firmware load routine.
> > > 
> > > Skip the firmware loading if the firmware is already loaded in Serial
> > > Engine's firmware memory area.
> > > 
> > > Co-developed-by: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
> > > Signed-off-by: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
> > > Signed-off-by: Viken Dadhaniya <quic_vdadhani@quicinc.com>
> > > ---
> > 
> > [...]
> > 
> > > +		break;
> > > +
> > > +	default:
> > > +		dev_err(rsc->se->dev, "invalid se mode: %d\n", rsc->mode);
> > > +		return -EINVAL;
> > 
> > I wouldn't expect this to ever fail..
> 
> Yes, that's correct. But including a default case helps handle unexpected or
> invalid input gracefully.
> 
> Please let me know if you would like me to remove it.

If you are asking for additional comments, please refrain from sending
the next iteration until you actally resolve all the open questions.

-- 
With best wishes
Dmitry

