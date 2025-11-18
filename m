Return-Path: <linux-spi+bounces-11273-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F95CC68E34
	for <lists+linux-spi@lfdr.de>; Tue, 18 Nov 2025 11:44:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 71FC629357
	for <lists+linux-spi@lfdr.de>; Tue, 18 Nov 2025 10:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D0F34DB67;
	Tue, 18 Nov 2025 10:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DAF5ONL8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="USJoa3e2"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3155346E59
	for <linux-spi@vger.kernel.org>; Tue, 18 Nov 2025 10:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763462683; cv=none; b=MI5teu0vBc4ASf7NcYiaPyUO6RrvQTFj+X60rcei2x288qFarKvTnulsGtbUypHQ1tNQ0rSjJmG0Wn9hMEDpYAIrLBnkFrsXjl5oM+BWxfYbsxkoDmzB6UYzg+ZPhf+9g1ZFhfs3GudK1Vx+LMTXoDlVaoNNuy3ucUJKjpU1uos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763462683; c=relaxed/simple;
	bh=iPkSGmX9KxQ79XLq9QwfSgi/5sR/v08OwyUjdBUS4Iw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gbAAVbv5NDlBkfVN0Au2622bBQDZ4l9UezUifSAL5FVLnr6vynqeGdMC6cpuhbOE6hlSL3mgJlaNVs0X2vRu5liGnseCB+zeeREwLzJdVHgDUNVlIh/MZIxR1zAevQUKdpAcJiask3EFzx8/U4Sk7i32h3gOl8OAPTmdr5xVoUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DAF5ONL8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=USJoa3e2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AIAW2ra375669
	for <linux-spi@vger.kernel.org>; Tue, 18 Nov 2025 10:44:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sCaK7aEvfsFFZyY5KFZUmcHBNjI4yJN5kXzzhPr5dBc=; b=DAF5ONL82otdyD37
	ZpBScCYfdJaJ8/Vs3uShfNzk7+NKwnbwQW+pAiUAPijuG05RDZ2YFZvUerVgP/YU
	l3yGfLkK6gnljrLGQY4/d38u0XuGI9MR/DCQiuXWHug/sFzSpC4EkbReLGVq7hDi
	YcHHfCDUpOgesOUct6RJL+cLXxmNUIVrEnpRvCDOFv6LKddMLjGXAbxsDbt5gcrg
	NYEBzGq3/GlJV6z0kr6hN3HGxu6IsNH7kIx6g+mj5M9LEHcsufaQ2OpjRQC/xFi3
	9YaOdQ5jleItgTfJ05YciyWQOs1gyrrHnlpYA/pj4ZC0M167B/7ef/C/LARPpdxH
	0yCn4Q==
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ag76njuaw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Tue, 18 Nov 2025 10:44:39 +0000 (GMT)
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-9490672b7aeso200238239f.3
        for <linux-spi@vger.kernel.org>; Tue, 18 Nov 2025 02:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763462679; x=1764067479; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sCaK7aEvfsFFZyY5KFZUmcHBNjI4yJN5kXzzhPr5dBc=;
        b=USJoa3e2u44cnh7pF+tEXEI3QvsKJdUYACfY7jSnVXoiYfgkSsAGhO3I7vr99+2nhw
         TbDs+Kv7PMx4ZBr/vtSlCodW+J3o8/eb0lFR2sq8c17LAhljIQ2lwj4qsu+VECPPClgK
         vUl8CIhl822vhFZgTtzEM2h9ys4xT5fRmL3AbKcvCWo67WgOzOC+wIGX6ACUGCBla0e4
         YNXfbcHRrnVA5DWRbJgTsqF3gIHiuNbZ8XF67vxYG4F28rNethRs8A3ekJ4elaZWMVTS
         9yyJvu9boFKO4ehVYz6bPq7LzpMI8iPEm76Ym+daVrBcHxCL+LERB2OlbkUJRLp5Douw
         OveQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763462679; x=1764067479;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sCaK7aEvfsFFZyY5KFZUmcHBNjI4yJN5kXzzhPr5dBc=;
        b=azUQsl9E4ThSQ2GgOtLxEFH06fNhmmiL6HI4ia5T83BygQWTmTanSxrh3W+xL2/4vb
         97t6yYsv/qUcbsygWy0FywXcUgmRZvJiglAqv9FHSfDDQvgrbZaJbIaoJ2+1xH8aYsxy
         PplySsntbnZJPl4kKsZsodGp0mH7uIpWQxMvkLDj8V7Yle7sAyAZmraQtDtyTxCQfWQR
         Z/VaDyQfoHnFplznsQSdkmFOjLybRQ/4dHZa0yjpFvy8ElZV96S0m0Viu8mHQC8cK6/C
         WIsWsR/ZhtTS/cqPzJ0M3ISHkRI2MxYR8lpMrjZXbldU9Vt7+w3UvUiTzZFrngdPfAMZ
         K+6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVM294QgmMaAp89+PVwOpqIUiyXfXKE46P5Q7+QXmuNSOY36ArcokF9Fu5yJcmcEUQ5AR8ahDmdJqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5tI8ztZjXfveblLtv0JwqW4kv0ydHQOpcegURxvqM//ueBciq
	NgXNFJ6GvVeRETLvKG9q/IIJd6k1ITeliVz52v6RYuHz0nR8eR5NE2LkKrUz3jAW/PxZPPVQkZk
	LXkzS8vPZe0+BXvNGBR0IuKqKgeDT8PPpcFluSWrdLrU0GxeLB07KNqB6VerLeytxGBFRwCJm8M
	tmqx59kNUFZj09WYSGOPzto6HjCr34aooT0fA2PQ==
X-Gm-Gg: ASbGncvr5mE4VAVwcEoSQHaGz06C+1x9gqklS8zHTZrB87J4cV3lMqkuzJd7oADzP6a
	St/8mGlkILz8KTvBB+7pYSVxkStSdhUxbdJu9kB9SKAs36ATF78kWBOuaPfzP8HHiDKtbZ6d5XN
	1MfPeyKr3RzFC3S0OkGuOgm+Xv3weUOGZqhvpkEAXk0pqBtkKXG/ww1e0VOc7/HtowbjyQm9Nkd
	XGyVSEa0Sm7S9C07PXSYjqD6QoDBo/5j/k9xhY3941Ggg==
X-Received: by 2002:a05:6638:838b:b0:5b7:3de1:e1a5 with SMTP id 8926c6da1cb9f-5b7c9c5678dmr8785663173.1.1763462679212;
        Tue, 18 Nov 2025 02:44:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGR4bh7rs9exhJQVqVxgzqNa8Hqi9xarFc0Bf1cW1lcX+y/WBnb8w+purdq/irbPPDybbw5G4vnB/UapB3Q5S4=
X-Received: by 2002:a05:6638:838b:b0:5b7:3de1:e1a5 with SMTP id
 8926c6da1cb9f-5b7c9c5678dmr8785632173.1.1763462678815; Tue, 18 Nov 2025
 02:44:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251114121853.16472-1-r.mereu@arduino.cc> <20251114121853.16472-7-r.mereu@arduino.cc>
In-Reply-To: <20251114121853.16472-7-r.mereu@arduino.cc>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 18 Nov 2025 11:44:27 +0100
X-Gm-Features: AWmQ_bmN3GDVSaMzesy1zRTz832e_xMXref004SjMzrpC1Nyjrzj_zI6bF87WTY
Message-ID: <CAFEp6-31A9arc=JmO7ob4uDnTj+Uhv_xJFwiUAZnfNLoAnOkOA@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] arm64: dts: qcom: qrb2210: add dts for Arduino unoq
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE4MDA4NSBTYWx0ZWRfX6FQu303f5Tc4
 vZnYuQbDUpp0NK8gORH9B+8zRnXNCYIKoTDEUxxRotjhyrPdhhYi9U6Q/B26o20khMqy6FVx1Cy
 TDMUSfehov9qMXvNQplVkB49EI+4gS1AekOoaH6L7XU6jq8m15CJbsHxIKEKveDlknr4jlXk337
 biroX4rtW4Pta+ZXOIEITJAxVmQYsU9UJEi6zuhOo3JXadboNWC61o+j4518JEIPK8fVWLR3IMg
 I6RQRo3+sqFEbA4MHSKJu2Gc47GoTOYIIrjXB0i3mOyWGK2gl6bNfyStnK2NCBmWuHLRtmDsG54
 OL1jZhDEKLXaK9GuN6+8n65UEoj9rhLBJ2lIs9BV5C9+6byPul2XryJlFTfIsHVCf8Xl49/STRA
 7WrqeFVc3HuqvIX/C3ggaP4ZRsGuYQ==
X-Proofpoint-GUID: w6DyTxF7NUc_jWW8u2wNmoCTUGR1tzc7
X-Proofpoint-ORIG-GUID: w6DyTxF7NUc_jWW8u2wNmoCTUGR1tzc7
X-Authority-Analysis: v=2.4 cv=a4I9NESF c=1 sm=1 tr=0 ts=691c4e18 cx=c_pps
 a=x6q9Wowz3da5qcMoR2tSzg==:117 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=UdB4yIQZu0W153naj6EA:9
 a=QEXdDO2ut3YA:10 a=TsFzuV67ciA61D7d30EA:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_04,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 clxscore=1011 bulkscore=0
 adultscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511180085

Hi Riccardo,

On Fri, Nov 14, 2025 at 1:29=E2=80=AFPM Riccardo Mereu
<r.mereu.kernel@arduino.cc> wrote:
>
> Arduino UnoQ is a single-board computer combining Qualcomm
> Dragonwing=E2=84=A2 QRB2210 microprocessor with STMicroelectronics STM32U=
585
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
>  .../boot/dts/qcom/qrb2210-arduino-imola.dts   | 456 ++++++++++++++++++
>  2 files changed, 457 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts
>
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom=
/Makefile
> index 6f34d5ed331c..9f98a7f2cbb4 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -143,6 +143,7 @@ dtb-$(CONFIG_ARCH_QCOM)     +=3D qcs8550-aim300-aiot.=
dtb
>  dtb-$(CONFIG_ARCH_QCOM)        +=3D qcs9100-ride.dtb
>  dtb-$(CONFIG_ARCH_QCOM)        +=3D qcs9100-ride-r3.dtb
>  dtb-$(CONFIG_ARCH_QCOM)        +=3D qdu1000-idp.dtb
> +dtb-$(CONFIG_ARCH_QCOM)        +=3D qrb2210-arduino-imola.dtb
>  dtb-$(CONFIG_ARCH_QCOM)        +=3D qrb2210-rb1.dtb
>  dtb-$(CONFIG_ARCH_QCOM)        +=3D qrb4210-rb2.dtb
>  dtb-$(CONFIG_ARCH_QCOM)        +=3D qrb5165-rb5.dtb
> diff --git a/arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts b/arch/ar=
m64/boot/dts/qcom/qrb2210-arduino-imola.dts
> new file mode 100644
> index 000000000000..8de355a1bf6d
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts
> @@ -0,0 +1,456 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
> +/*
> + * Copyright (c) 2025, Arduino SRL
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/leds/common.h>
> +#include "agatti.dtsi"
> +#include "pm4125.dtsi"
[...]
> +
> +&wifi {
> +       vdd-0.8-cx-mx-supply =3D <&pm4125_l7>;
> +       vdd-1.8-xo-supply =3D <&pm4125_l13>;
> +       vdd-1.3-rfa-supply =3D <&pm4125_l10>;
> +       vdd-3.3-ch0-supply =3D <&pm4125_l22>;
> +       qcom,ath10k-calibration-variant =3D "Arduino_UnoQ";

The board-file you're shipping has been integrated with `ArduinoImola`
name in board-2.bin.
You should keep that name to use the right board file.


> +       firmware-name =3D "qcm2290";
> +
> +       status =3D "okay";
> +};
> +
> +&xo_board {
> +       clock-frequency =3D <38400000>;
> +};
> --
> 2.51.2
>
>

