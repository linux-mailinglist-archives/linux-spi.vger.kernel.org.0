Return-Path: <linux-spi+bounces-11157-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37101C4DE42
	for <lists+linux-spi@lfdr.de>; Tue, 11 Nov 2025 13:53:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A7BA18C3C5E
	for <lists+linux-spi@lfdr.de>; Tue, 11 Nov 2025 12:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4385B357A4A;
	Tue, 11 Nov 2025 12:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DgQibGED";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="So8nqpb+"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB7C358D04
	for <linux-spi@vger.kernel.org>; Tue, 11 Nov 2025 12:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762864143; cv=none; b=BlZAwKOxTXConlxkC2yTFDA4RRVQJhSaXGnF6jbGvSamknwBCpLvbBFYe8GAO/ilpbWjvIHfPyQvz6HAPATIHS9ieN/L8rCKIDEmHnMZPIHnszN8XjasgVp80Aewc+PNX6C0saq33Ug8iN3qYjkbOcLbmy7AGhDCjBXPVaZuInE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762864143; c=relaxed/simple;
	bh=qWO+LslAAiZd3CNygxHIYmwELeyYi6yEhKewOMVfbd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=us9YSMHgm2Pxq0VVtkbfN6mIHwSPnn2YG/jfKPpdNmB6pFLmHl1y0ttf2VaOIqsWRTHeg5ZSuOppJpOpMxeKCLDn6P/a9LsvkTBrNAcMGCyLoHtywOW2/sOB+BDZKjbtsMP4eKUuDXViJ1HY2h9sSGwf6Kot2vsdhui1OY2EiDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DgQibGED; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=So8nqpb+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ABBGV342129948
	for <linux-spi@vger.kernel.org>; Tue, 11 Nov 2025 12:29:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QFlA+rmHCQw2mTHSNf1gtuKKDHdDMWf6upuETlt4zpk=; b=DgQibGEDdAnr38dn
	hlp1J2DOyIw9PACjKvJ3bhLr3qfAgXZRYpfrU1ys943h1nRU56sXJQcfYrCUSorJ
	TmUzfPoaRTlmu0DMQ+3IzfInrM1BhCC9WYiN0vg2VSbDWMc1GSl+LdruscQCWsB3
	FDioslIJPFV7YD17BPji4yM4QlPerQOLH4ugfoNzGPl8ev+vGCFHgYOIAV53nS8C
	YqVGcT7EnVTUhKBa/QdAI3GPKdIsXkf3t2M3adMkvfCXntz5nMxSvFJNfdUvQR/K
	K2spX6loxiPsFV4SMxcX0fPa8MlMgsJdxkOSqLtdIPX8sy+NoYkIXSFStvdkPsse
	sVlORw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4abvhthkes-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Tue, 11 Nov 2025 12:29:00 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8a9ec099b5cso1195698285a.1
        for <linux-spi@vger.kernel.org>; Tue, 11 Nov 2025 04:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762864140; x=1763468940; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QFlA+rmHCQw2mTHSNf1gtuKKDHdDMWf6upuETlt4zpk=;
        b=So8nqpb+AHkaYUIZsugILsuPS5KrO7arDN31AN/PIA5O2K6TutJ6Y/5J4TShlqXmaF
         N9Oybxty3qgrfT68JvOWLRIMDDNNz4CO8WGluwKD3+KsO68XV0V2Z8FA8AjlfX/RYaql
         3WEW4MlX1kfrlTj40Lc7nBrZh6CNjEoBbWiVzOfqqHWldVGySqnj2LS/Ro8TCrYNvzKI
         Bzo3Ilt3xO2VZM9BQIZBczTV1Y3MR4vW6ieXcqAxwpM20AYrqwMy6Q872cLGEEgFs/3z
         vh/hTGvDA0EfLyi4UXNtUFeNgfU0Jcm0XliWxEhnRN/X6PodVV3/ngvQNgrFtkjj7HAy
         nubQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762864140; x=1763468940;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QFlA+rmHCQw2mTHSNf1gtuKKDHdDMWf6upuETlt4zpk=;
        b=gbsa2ciH9EYUa6nMzwc2Jym4TAui13QMmn35iB0pbYrGd5lF948+/37Kxmx05aguvK
         3N+gfiuUh2OFeNd9l5lh4s8NjuBOidGrH04CAT9Eh5hFQzVeT1jD4R25k2UWwufQrEa8
         l6fTJg7YQVJZkik2r2A63I1H0S3SwdpzJpmEc7t4vjhm1CRvWSPzzdjpIXodZBpJXzpI
         r4dTjKN9k4S8Eyl/DlDJiP8SMWez8Y4KozrP0rfJJrOYgYRd1ZfFLKF8Nd7ZZP8be9Cy
         Jce+thkv31YixYnJLxi/SdNcXFagQskotVcPRAewC0xXfUnkbk5VDXCpti79I2dlVuv1
         sytQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhJ5y8ZM6EJLS/3plW3ljwq27qOHDNMA7doRrTd3adHVV7ZuVlNo64/VGzTy0jLNciyeqqNl7Rz40=@vger.kernel.org
X-Gm-Message-State: AOJu0YygV7amQY37geqCjlKU3VdDPIgPk0oPWugHWstpX8LNB6Ub4Ded
	3s0Ba4qYFSgMo2qdZjf6oeeoYkGSRsbxYqHw+YaFAUYIYSMHe/5IKMEijxbTDrtzglGJlb3I8bw
	glI+mJ2Fwifvk8arPwxLrYW8n+Vn3+n0rp+jXzJgodppGIIMqUX77deKAFu0iQtw=
X-Gm-Gg: ASbGncvR8D1e40GdNKsUJu8y0BAywC6M8ohdgx+UQyp+gzUp5kDdfFFaB1Prc6ZXWPJ
	ugj/D7sXFHMw5bo3Q1Ic/VChwnvq6i9/mJJuJOb8ukKWuUWtf3sgxg4Lv0EAkGHx0pHUACQoU6K
	2C+GwxteCwe4HknZ7scE/QaRJve4fiuggPYLRDHOr6m5NkGrl8gPfmmer7WC5nvDaLyWVYwoVE5
	6U+hTbQd5039wlPG3FMvTkTfPqQ4NbBz7q7Lnio1Fyqodk6QVCUiRlXTNsDF/PXQV3jXN8LPNUM
	c7XkhATq2KALrlAj77C6ztDz5vikcD3qNX878gJ//GSz8+Rr5dTnqr2m4UtHgon18T4u/MtnUvv
	7Y5V7tZqtu7e2W+zAI1EbuSq+7d+8pJSYd443YkkDIkntL5Qb/nnG6T17rX9uSvLNee0UnNQKTE
	bQ3EJ+ZH4ZqgcI
X-Received: by 2002:a05:622a:d0:b0:4d8:1f72:ba60 with SMTP id d75a77b69052e-4eda4e7a7a7mr134967891cf.14.1762864139711;
        Tue, 11 Nov 2025 04:28:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFB0QADbO+w8dIjN2emZaXFkoCmnPbMKIptoyc4K6i/3GMqeYEKpmtn9C+u+nB5MxEt9+6ieg==
X-Received: by 2002:a05:622a:d0:b0:4d8:1f72:ba60 with SMTP id d75a77b69052e-4eda4e7a7a7mr134961411cf.14.1762864129941;
        Tue, 11 Nov 2025 04:28:49 -0800 (PST)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-37a5f0dd359sm41987281fa.32.2025.11.11.04.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 04:28:49 -0800 (PST)
Date: Tue, 11 Nov 2025 14:28:47 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Riccardo Mereu <r.mereu.kernel@arduino.cc>, andersson@kernel.org,
        konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, broonie@kernel.org, linux@roeck-us.net,
        Jonathan.Cameron@huawei.com, wenswang@yeah.net,
        naresh.solanki@9elements.com, michal.simek@amd.com, nuno.sa@analog.com,
        chou.cosmo@gmail.com, grantpeltier93@gmail.com, eajames@linux.ibm.com,
        farouk.bouabid@cherry.de, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, mm.facchin@arduino.cc,
        Riccardo Mereu <r.mereu@arduino.cc>
Subject: Re: [PATCH 5/5] arm64: dts: qcom: unoq: add dts for arduino unoq
Message-ID: <vzpbuf3hrmt7axry63tgelbkj54kqby6pjnb3cynew6k476uye@6qonkynked2g>
References: <20251106153119.266840-1-r.mereu@arduino.cc>
 <20251106153119.266840-6-r.mereu@arduino.cc>
 <f20fd593-0173-424d-9951-e0f2ad33b4cd@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f20fd593-0173-424d-9951-e0f2ad33b4cd@oss.qualcomm.com>
X-Proofpoint-GUID: 4eBnr4W3-pP42jqb69o3fCRrKp-aRhyS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTExMDA5OSBTYWx0ZWRfX5aou8HnyqGHp
 onPVUScCHo9M07DSdUWvKmvVsUqVFn4zdb4mJZwkCIV/u1qshV0EQJrOcWAZgJ0VJHjDOWZq6nL
 0WWMX7eWU2LCV0e7MXJFpe5c6DyBWbWNL+Bo0N1KUoixDoS54rW4wOs/l/x8UOaogoPBW8IKkkj
 PLgP3e56xs9/ulm3X80VUxZWjIgDS5wLQGwrlG80sVzm1diQ4ZEu+BCN2EBIiycRi1R+r181bko
 P8O4Yw+sb/KZINdtDXTgYgfD8vsmNt3Ijw0aV2/Q/AOVXmms+vL/GsID2DDgoHQ20V385yJhAVz
 s8+7mn4HASHJhJ5alNs4AkfwjtT66YCamMaR8/XJJvXakehKaFweSYIPBJqnpveaiBwTEbot06H
 L3fb9K310HwqgpFiWZ77kMtKX+wrYg==
X-Proofpoint-ORIG-GUID: 4eBnr4W3-pP42jqb69o3fCRrKp-aRhyS
X-Authority-Analysis: v=2.4 cv=d4b4CBjE c=1 sm=1 tr=0 ts=69132c0c cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=7D5TFTMLEG-0mYwEVy4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_02,2025-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1011 impostorscore=0 suspectscore=0 phishscore=0
 adultscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511110099

On Thu, Nov 06, 2025 at 05:29:47PM +0100, Konrad Dybcio wrote:
> On 11/6/25 4:31 PM, Riccardo Mereu wrote:
> > From: Riccardo Mereu <r.mereu.kernel@arduino.cc>
> > 
> > Arduino UnoQ is a single-board computer combining Qualcomm
> > Dragonwing™ QRB2210 microprocessor with STMicroelectronics STM32U585
> > microcontroller.
> > Support to a simply boot to shell environment includes:
> > - UART, I2C, SPI
> > - onboard LEDS
> > - eMMC
> > - WLAN and BT
> > 
> > Signed-off-by: Riccardo Mereu <r.mereu@arduino.cc>
> > ---
> 
> [...]
> 
> > +        leds: leds {
> > +                compatible = "gpio-leds";
> > +
> > +                ledpanic: led-panic {
> > +                        label = "red:panic";
> > +                        function = LED_FUNCTION_INDICATOR;
> > +                        color = <LED_COLOR_ID_RED>;
> > +                        gpios = <&tlmm 39 GPIO_ACTIVE_HIGH>;
> > +                        linux,default-trigger = "none";
> > +                        default-state = "off";
> > +                        panic-indicator;
> > +                };
> > +
> > +                ledwlan: led-wlan {
> > +                        label = "green:wlan";
> > +                        function = LED_FUNCTION_WLAN;
> > +                        color = <LED_COLOR_ID_GREEN>;
> > +                        gpios = <&tlmm 40 GPIO_ACTIVE_HIGH>;
> > +                        linux,default-trigger = "phy0tx";
> > +                        default-state = "off";
> > +                };
> > +
> > +                ledbt: led-bt {
> 
> The labels (label: node-name@unit-addr {}) for the above 3 LEDs and
> the group are not used, please drop them

Also, I think the nodes here should be sorted alphanumerically.
Otherwise LGTM.

> 
> Looks good otherwise
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> Konrad
> 

-- 
With best wishes
Dmitry

