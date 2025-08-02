Return-Path: <linux-spi+bounces-9267-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 816F0B18E78
	for <lists+linux-spi@lfdr.de>; Sat,  2 Aug 2025 14:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8F51189D8A1
	for <lists+linux-spi@lfdr.de>; Sat,  2 Aug 2025 12:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E2723815B;
	Sat,  2 Aug 2025 12:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DOQMtJD9"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F74022836C
	for <linux-spi@vger.kernel.org>; Sat,  2 Aug 2025 12:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754138401; cv=none; b=pyRAjt0pJRU9Dr1+4YG0sWUV3SkPZacHbOjdCSi9GY4axSR7c3Uz1wU74oip4SI/uXNs0Lyo6y4ll3Cjpz3mrEImKr6IKCNdTnkfgKVCIYDaASLI0nUgRLPienjuphxTtPYYJ3nW6msWkjIPOPELA6vpLqaxhQPj++PTZXyw644=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754138401; c=relaxed/simple;
	bh=20GZjV/9etu8Dh+QrGksTZEKnBLbOiAfPjovI45mWjE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t3XTlRtElIFyLYOri7LlquQH8NTGyhHdom+Z0L4uRHSuQHZ5+bLqyH13Cc2CfqHt7AtMZWy0sfs6Ha4aARSB4m1bjHigYqAmOn4xPPswKw7IEuyi3YWhp4LT1RDO+ipSLhn8lF5zIgYZWxpT2lynO+HSK6yBBlHeUfThWw6YJvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DOQMtJD9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5725g2J5010575
	for <linux-spi@vger.kernel.org>; Sat, 2 Aug 2025 12:39:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	r9VK3kXUy5TNVKQthyOGQ0SFCHNZ+dt1IH8nz2OWv34=; b=DOQMtJD9xjdE7K4H
	vt+tAL+ijFCF/Ppx46PTq6wc0Tn4/X98XLLrGBLGuzMvbAxreC3RezQp8EyPZa0+
	UzJW6dPZmAIDc6+9IQeviwcJmVcn12IlqcBecAfYSutXBJr+KyZvSqxFtgMMo9du
	llmeNIzI2yHwmB8wloQBV8amiGbLg6kLeWquA++hJ11zyqHDF33b7slzh3B0tFYr
	A1fOQ+7KHo3LhiJjF1ji/no0ao8zJy6eh31X7yiFpqa2FD+ip3SBTFBwj/8a5s4d
	xvZZXb4ZGPo/7wRpiihVK7awCZ1GbbBUY6miBEig1e3yCvdFUp5HadPxMnra5b45
	h8VRQw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 489a91ru7t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Sat, 02 Aug 2025 12:39:59 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4ab65611676so7446351cf.0
        for <linux-spi@vger.kernel.org>; Sat, 02 Aug 2025 05:39:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754138398; x=1754743198;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r9VK3kXUy5TNVKQthyOGQ0SFCHNZ+dt1IH8nz2OWv34=;
        b=Ag7W24eSMkdflLL99cQjrUv5QRdAkhkT78yKP+SuuVbWkphlBtV3kuLtzMCDIjCoKM
         80s9xuS3WomKrjTegRCEMD6XBTTHcuRaP99oQcc21hGF6h7HapTSiINB8AEjN3uVe2Pq
         8C67p7bS7UpNfJ953+ZxZto3wRqQ8sCtpLJa6XbW4wmM+XeOBmzQ5jhLPIA5LvuGuTDs
         mqpcbpNTlHcFe0iddJxS+esmT+k10zluaP65kq0zvitwvMXLW0BjWiZJ6NrM6UeifZJm
         whQ2uaMCWmEf0C1oGk2qdTBQsRC4M2vda2m2jsoMhdP22YTtsxL/2wXg4eyqMNK4Xgk4
         Q0Jw==
X-Forwarded-Encrypted: i=1; AJvYcCV8/8zhlyEhAtXSBCpZeYBSXfhT8Izf4AloJh6SveL4/mlcKVz/hv7FZNOaczx/00Y+CP+EWIQWop4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy4VGudQvw+EXPwo17Uwka8584qajjxtYwK3XU14I8IsxABq33
	QmfyVeq61Xhb7NedVXWBNmXj4HhTjuuQVycbnGDIyg1s5iSfOrA/NGoSJwSv9cJunKCuBVmOp2u
	PR/8qPtmJFSUkhaCeVkOtjY9eZvu4fWfqTZDqP9pByrmrwmqfeNMshS4s1IR5CMY=
X-Gm-Gg: ASbGncvdCioyCcP9HvHLy3uWUhtRc3KfEV4Aj3RqmQFZ05TqxEN1k7lIIoYEsARUd6J
	kjQsO4faUFjpnHqhV/dtCiXNlPvJhK6EGcwq1bnLaK9jGD6wQDMIzCaTpU8hSvYQ0H1Msd1rkAC
	EcZJmaverYIn7fl2xEYO2YjT9YxQv1oQedCbAbyvGMLkzgQaNdF/yIaXOEI1TyjPhwv8l/VGar8
	2RATlcWp1d/FyK5kvQVcQEpY+SLpGSQVzzl0SznTf+e10pEU7gac7aDCRyj9kJD11ql9hyevx8I
	mpKaHTvzv1as4oBG+jPPlNC/raTvM56/YGORRVuxUL6S0mQAvJIoyvwEHDvMGB7T9Z6lCRO9kZg
	cyMxThxVcaGQ8zw4SXQ==
X-Received: by 2002:ac8:5f90:0:b0:4ab:5ac3:1347 with SMTP id d75a77b69052e-4af10a84c91mr23333661cf.13.1754138398204;
        Sat, 02 Aug 2025 05:39:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEm4NEl6EUx3LCCGFmAhcLGEPc2/M/pvg1mmL0vg2ErLHKHgVKDYHB4PV/P/gfOCagScMPDYw==
X-Received: by 2002:ac8:5f90:0:b0:4ab:5ac3:1347 with SMTP id d75a77b69052e-4af10a84c91mr23333291cf.13.1754138397693;
        Sat, 02 Aug 2025 05:39:57 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8fe77cfsm4167407a12.42.2025.08.02.05.39.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Aug 2025 05:39:57 -0700 (PDT)
Message-ID: <e0886f9e-bcc1-48dc-a175-2147d8d4fc3e@oss.qualcomm.com>
Date: Sat, 2 Aug 2025 14:39:48 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 3/6] dmaengine: qcom: gpi: Accept protocol ID hints
To: Geert Uytterhoeven <geert@linux-m68k.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>, Sven Peter <sven@kernel.org>,
        Janne Grunau <j@jannau.net>, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Neal Gompa <neal@gompa.dev>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
        Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Frank Li <Frank.Li@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Taichi Sugaya <sugaya.taichi@socionext.com>,
        Takao Orito <orito.takao@socionext.com>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?=
 <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        =?UTF-8?Q?Am=C3=A9lie_Delaunay?= <amelie.delaunay@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Chen-Yu Tsai
 <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Laxman Dewangan
 <ldewangan@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Michal Simek <michal.simek@amd.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>,
        =?UTF-8?Q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>,
        Viken Dadhaniya <quic_vdadhani@quicinc.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Krzysztof Kozlowski
 <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        imx@lists.linux.dev, linux-actions@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com, linux-sunxi@lists.linux.dev,
        linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
        linux-sound@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-spi@vger.kernel.org
References: <20250730-topic-dma_genise_cookie-v1-0-b505c1238f9f@oss.qualcomm.com>
 <20250730-topic-dma_genise_cookie-v1-3-b505c1238f9f@oss.qualcomm.com>
 <CAMuHMdV0JO=qtregrrHsBZ-6tpNdPUj3G1_LWRfRsj0vBb+qyw@mail.gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <CAMuHMdV0JO=qtregrrHsBZ-6tpNdPUj3G1_LWRfRsj0vBb+qyw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: POwLprhgLbtJgeyZQazTJxPrulXa-NRo
X-Proofpoint-GUID: POwLprhgLbtJgeyZQazTJxPrulXa-NRo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAyMDEwNSBTYWx0ZWRfX7c7+WFowV6ca
 rykzi8Xdw34O+iG1z9Z0o/LEZXDquQmfxlCTsMeYffiC6TcvGC0tFigfpbJ0W5FmRM73x8pLodf
 0sn4hmXNYzWsJ1oGsUFWqHdjEXqLljkf3bp3DMUDIbRyYGrEabVhQvH7I3payd4w2+IzbFX8HuH
 1Aou/lqVdn2APnMcwsuKUtZqREp1OPt0Q3KFIcdi87nJd1JwznJa0UbFtF/LMjlBE/ThKgYSayC
 tjcvlFlyJH3LDT+0nOpXiHTfOg2BTGS4nEY4Ieiotv/7cPsRv1ixOiR1yvX1E6hfWzo+FmFGw/g
 w0pGrXVxj+FWV9CRVFCDn3kX37+j3nR30xZCLc1aChXPNc+LQNFIjzTI0Qk3bF2kgfj8+JODlkT
 sKvNX7cqwsU0/jvEgX4wtlW9J57J052NnSRB+svg9IafsuftNezfLMYG7s7JX0EdeSciS4ni
X-Authority-Analysis: v=2.4 cv=UdpRSLSN c=1 sm=1 tr=0 ts=688e071f cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=sidZTQT7lcrlHK7IIakA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_08,2025-08-01_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 mlxlogscore=864
 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 mlxscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2508020105

On 7/30/25 1:32 PM, Geert Uytterhoeven wrote:
> Hi Konrad,
> 
> On Wed, 30 Jul 2025 at 11:35, Konrad Dybcio <konradybcio@kernel.org> wrote:
>> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>>
>> Client drivers may now pass hints to dmaengine drivers. GPI DMA's only
>> consumers (GENI SEs) need to pass a protocol (I2C, I3C, SPI, etc.) ID
>> to the DMA engine driver, for it to take different actions.
>>
>> Currently, that's done through passing that ID through device tree,
>> with each Serial Engine expressed NUM_PROTOCOL times, resulting in
>> terrible dt-bindings that are full of useless copypasta.
>>
>> To help get rid of that, accept the driver cookie instead, while
>> keeping backwards compatibility.
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> Thanks for your patch!
> 
>> --- a/drivers/dma/qcom/gpi.c
>> +++ b/drivers/dma/qcom/gpi.c
>> @@ -2145,7 +2151,8 @@ static struct dma_chan *gpi_of_dma_xlate(struct of_phandle_args *args,
>>         }
>>
>>         gchan->seid = seid;
>> -       gchan->protocol = args->args[2];
>> +       /* The protocol ID is in the teens range, simply ignore the higher bits */
>> +       gchan->protocol = (u32)((u64)proto);
> 
> A single cast "(uintptr_t)" should be sufficient.
> Casing the pointer to u64 on 32-bit may trigger:
> 
>     warning: cast from pointer to integer of different size
> [-Wpointer-to-int-cast]

Good point, not compiling for 32-bit always ends up biting.. thanks

Konrad

