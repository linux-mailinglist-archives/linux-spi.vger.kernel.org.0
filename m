Return-Path: <linux-spi+bounces-11453-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CDBDEC7A18B
	for <lists+linux-spi@lfdr.de>; Fri, 21 Nov 2025 15:17:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 40EDE4F5720
	for <lists+linux-spi@lfdr.de>; Fri, 21 Nov 2025 14:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4732DCF4C;
	Fri, 21 Nov 2025 14:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pNkLkKft";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aYYcb6nj"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D703358B7
	for <linux-spi@vger.kernel.org>; Fri, 21 Nov 2025 14:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763733917; cv=none; b=qZR4ighbiZvM30ZITayKDGnRaG+jnB1LOmxaEFZjbVkSpt0PxfxZJyeH/Pwr4pMcXLK+cpt3ZcOu8vRdLws5uoRrYeRNAQEHXJftIlb73tIvRdtjkE+roCF+UaLYLvY4dsJ15NyKg/n/MTXniPmNMtMlTRE18dV1b4CZGOmhkFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763733917; c=relaxed/simple;
	bh=68PnXc69UCyFtg6GEAXARqQQjQ2Dic9mmjK7WiX8SKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OWE/RBYiDy8P1L+pkztrUcVD9eFUALhTLfDAcl3ZCsqz4T38CvK4+i44ynDnHKKUYyK0KKGZI85Lw0SEf3BurhV/8UphIzHzSZcO5N4ze8eD9yk7awckazwBx4tBPsdqFHeM5lJsE5MKyULMcOQ1kII2MElRNYjNNOGms3tUIZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pNkLkKft; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aYYcb6nj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ALC3iiD2831860
	for <linux-spi@vger.kernel.org>; Fri, 21 Nov 2025 14:05:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Qaf5DRptIZQbru9+g9r5oqVEbW05dE2A+/lFcNwVwN4=; b=pNkLkKftTrJcb7/U
	AoRdeouXIFHSrymMO1FaKZTyfF+9htqqXlJ9PLJFopyC4k50++wVDi9Ps5WH3Ot4
	RSxqpsvFGBnWN9zroCwJB04RKRvKjKuHNEX0KXmrlEBvDV60Y/C3nkwiiKbwNWRn
	tHu8PmjVNDd4C0U9826q9nkU2WmvGpx2KkjygiZqp0T15MOPADKFUJbTcOjFcywZ
	Th1PS4WOtBBPzdkPKvYNl+p+IHV0HF5dxUX5ts9o/4zsv3vadyRYJpsCGUYitw4Z
	bDC3s8/cXFCx8GnlST7ymMfQHcPmW+wG9ug2tVcZuwa0m0NSF3GZoumPBT9T5R/0
	xTO/qg==
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com [74.125.224.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ajhyq1m9k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Fri, 21 Nov 2025 14:05:14 +0000 (GMT)
Received: by mail-yx1-f69.google.com with SMTP id 956f58d0204a3-63f9c4e3701so2860959d50.1
        for <linux-spi@vger.kernel.org>; Fri, 21 Nov 2025 06:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763733913; x=1764338713; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Qaf5DRptIZQbru9+g9r5oqVEbW05dE2A+/lFcNwVwN4=;
        b=aYYcb6njfe7vHEZA6+cQAQWOR/va4GUze8RxEvPf2bxyDMuL9wftOiDPugkbVtvreR
         4yLplUr4LA/poce1yrAOw0GtSBE4Ym2W4NadCcQMz6vHb10jpaIJl3fTySoxCUButzo2
         NhGanz6BrLT1BppFxoItLtoWTaaxfMK4glrMQpXMkPAZACgsyOq08+8LoHrbBX26+lp8
         fe1pt0BeFvPem37lp+FsTnXN/gZw+Z7n9Q1Rick/0XHbICgppafeo8U9gYncAhpyfDsZ
         f5dRKueGSyI6Zia/TJi6CmYr+z6hTQOSKa+7MdbENfhcvOLyfF10KhwlFLlvo+2AcE0i
         cGAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763733913; x=1764338713;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qaf5DRptIZQbru9+g9r5oqVEbW05dE2A+/lFcNwVwN4=;
        b=ugqzsY4QEjuXdOSbzvvnNg5aDp9WSNi5A7rH0ZmP+b4hxYEvFNxbyRATB55XyM12CX
         6zu8smRFTLJJPjpBMFtDugKI7LkgBhaA/Q17+fbK/2KF4ktGjLd6swdA/S4hWj7Dr32+
         SZk6k59sYntlPARNaPHp62QakAHm3ev/mzjDRjZpVPVn2B1nZv72jJzT9X6VhfOgEk0I
         Z05+9srcAnyINX+oVcGZW0u2hkqFBXB38YYnaKyCyAsn7LrB1f7igJBm6Ntq42+LRF+I
         WSLpFAP8JHs72FD0vlD2vEUCULBKx8QKuVqjZCNF7KlcjUZDusfvrac2IYDzslrQopcI
         TWew==
X-Forwarded-Encrypted: i=1; AJvYcCUnAg/fyoK1+3z6/GIC/4IU8f86GjeLXaPnWttjoAs7bphE0C2VlYlION8BWC/9bKdxe/PlCTksXQY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMjJlowAqpHCH0E3AlV/fQjfTqDPRJGGF2NGrPnGNo5eI+MAiR
	KiKcwwpP991PA46bhw7NuForXuc35oPf4vhcB2IZVverr5tTBsclSkzwINFY3MQxDlZAcJBwUF+
	J/eRA3NE6FwpWiAry4M8yXse/tgrtCFrtmktCloTXj3m14nNzTsKWmouHNnoUbJo=
X-Gm-Gg: ASbGnctoy5MkUUu6xEQhguxjv+I7RbVF/uUuxJSNxmQQ4Nwpt0+pLe7qYBBXd1qNiNy
	x/Z/HBUK2GR/Q2G2TfLQL5YYQUPJ0TmOZXn78z84atJkkWUx2tQG36kh0rCgEG0y4pjDR1rgnY+
	N8Dc35zAudFJ6LmI60ozebCmXtqIDEQqMVbIiZ0KBgZ2+nWIdTvKJA7KPpJjioMN2bCnUo+os3z
	9vM9NZqWmtRE9iuFkfr2XxJ7Cm4EyRI5KWETkDL+3M0ctcQBonNjzwHuBwe4AHVxoGop9o3g/d0
	lSgmCigR0QQApFg9nW9/kzwTI7AK6W2O8Ou4JRFQsHfivtxGage+u1ZRTkn3eJHZKcRaaiP1KGR
	OGAuJRuE5aJASbx7NDaw4IdR4VBWsVyypT7eQb4RGmMvz0lmgG4OWT558aIHL/85NPwghgLCfsN
	oJo/2F9KiM9noNxlFXK+p7cvM=
X-Received: by 2002:a05:690e:1596:20b0:63f:9473:4749 with SMTP id 956f58d0204a3-64302b08cf9mr1207685d50.56.1763733913488;
        Fri, 21 Nov 2025 06:05:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGppYmqmjg85tb7as+vnEDGkkvnF45Ln0ar2bN/42BQHk6sTjweL/7Zyd/ipDSPuQ9GY2H5dg==
X-Received: by 2002:a05:690e:1596:20b0:63f:9473:4749 with SMTP id 956f58d0204a3-64302b08cf9mr1207628d50.56.1763733912963;
        Fri, 21 Nov 2025 06:05:12 -0800 (PST)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5969dbcd137sm1652527e87.94.2025.11.21.06.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 06:05:07 -0800 (PST)
Date: Fri, 21 Nov 2025 16:05:04 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Riccardo Mereu <r.mereu.kernel@arduino.cc>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, broonie@kernel.org,
        linux@roeck-us.net, Jonathan.Cameron@huawei.com, wenswang@yeah.net,
        naresh.solanki@9elements.com, michal.simek@amd.com, nuno.sa@analog.com,
        chou.cosmo@gmail.com, grantpeltier93@gmail.com, eajames@linux.ibm.com,
        farouk.bouabid@cherry.de, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, m.facchin@arduino.cc,
        Riccardo Mereu <r.mereu@arduino.cc>
Subject: Re: [PATCH v3 6/6] arm64: dts: qcom: qrb2210: add dts for Arduino
 unoq
Message-ID: <eydthsrk7atlrbp5gwtc47snyiof5yknlzkuj3kwgaoymkqkih@xt5klwnsn32c>
References: <20251120155825.121483-1-r.mereu.kernel@arduino.cc>
 <20251120155825.121483-7-r.mereu.kernel@arduino.cc>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251120155825.121483-7-r.mereu.kernel@arduino.cc>
X-Proofpoint-GUID: nJq_Q9vdCCxh42Ahjc6fKOZ3ItnM3Njo
X-Proofpoint-ORIG-GUID: nJq_Q9vdCCxh42Ahjc6fKOZ3ItnM3Njo
X-Authority-Analysis: v=2.4 cv=N94k1m9B c=1 sm=1 tr=0 ts=6920719a cx=c_pps
 a=J+5FMm3BkXb42VdG8aMU9w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=AyA9t-mhxxp3BJy63IYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=Epx66wHExT0cjJnnR-oj:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIxMDEwMiBTYWx0ZWRfX0/4YRrkiNsjv
 IhB/gjHGMVODTJnG53uz7a5jf6VlaEzWCohPXYutkaIM1B+Sg2xJaZHs0Gg8cLy3Df2LdBvsmHT
 kVRdZkdAhkVMYvgP/ctbk0Z3J8110lNeAwVvOIxcGzTJJEhUTKic3P7M3u9jrMbosTEG+EEqEFU
 S+QXM3Vp+vqKjF02IujiQbYxY0qYyDgFsPuaW0cWbtO+fmqbwiXbdOaY1/u8fYaSnGvGRVNqW8i
 WvFj8/b1g1jjN2Es716U0Sep7kiN4Pud2p2sPMZt+4f26jPbB2XVJ1TMrIhwjWtQBgdlx8QkhS5
 NMIlvg+xTN9xZjom/IPqabMnragkfXJ4QBkgsDzCbiU+R8tHoc8ZDCmnfYNo/1+QoZZ3bU7ZpD5
 9RlGl7ssDSrsd5lOKPh7QV6AqeFCbg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-21_03,2025-11-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 spamscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511210102

On Thu, Nov 20, 2025 at 04:58:25PM +0100, Riccardo Mereu wrote:
> From: Riccardo Mereu <r.mereu@arduino.cc>
> 
> Arduino UnoQ is a single-board computer combining Qualcomm
> Dragonwing™ QRB2210 microprocessor with STMicroelectronics STM32U585
> microcontroller.
> Support to a simply boot to shell environment includes:
> - UART, I2C, SPI
> - onboard LEDS
> - eMMC
> - WLAN and BT
> 
> Signed-off-by: Riccardo Mereu <r.mereu@arduino.cc>
> ---
>  arch/arm64/boot/dts/qcom/Makefile             |   1 +
>  .../boot/dts/qcom/qrb2210-arduino-imola.dts   | 459 ++++++++++++++++++
>  2 files changed, 460 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

