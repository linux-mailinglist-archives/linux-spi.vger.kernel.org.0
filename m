Return-Path: <linux-spi+bounces-11577-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D48CC88F1A
	for <lists+linux-spi@lfdr.de>; Wed, 26 Nov 2025 10:28:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 15A0F355D58
	for <lists+linux-spi@lfdr.de>; Wed, 26 Nov 2025 09:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 070163168E4;
	Wed, 26 Nov 2025 09:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arduino.cc header.i=@arduino.cc header.b="DgiBW3yo"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046543016F6
	for <linux-spi@vger.kernel.org>; Wed, 26 Nov 2025 09:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764149295; cv=none; b=W1vAGgdbSJD7oPz0dlbjmoEWMoLdZSOX7vx01nzp+3+qXb5ceU8KPYa16YVlFtQ/lokIgkIOE5aMdI8rdkutdT2y2/o/07mUfJgDO2OcL3nUGpxtuSjCRqMGiNCTZLaLHM71gf5PrLx920KVXGcM9tG3wzDPc3XAWf9fN8CVn+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764149295; c=relaxed/simple;
	bh=EQI3YRAOQlsv/50/jtc+m8TveG6L4PJ60t8l+dOtrnQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jad9FMfoYTCD1+B9qYflKxA/n6dylfaLmaP5P2Wgrmw3gYekqf3fxYzufmCrBzjrblcE0+DY4r0ShgudjYmteR/d+nlXr8tYzelatrXPnP97xwC/fNXsBGVpzM2ndUtq7xhzb/Lrmth5xfZE3xzR8++E0FQpm1/CbXu0Vj7VCtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arduino.cc; spf=pass smtp.mailfrom=arduino.cc; dkim=pass (1024-bit key) header.d=arduino.cc header.i=@arduino.cc header.b=DgiBW3yo; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arduino.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arduino.cc
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-591c98ebe90so8271527e87.3
        for <linux-spi@vger.kernel.org>; Wed, 26 Nov 2025 01:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arduino.cc; s=google; t=1764149291; x=1764754091; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=84kp7mvpy609O4P8atJgqEkhRccxZ+4bKydmYjW/Bdg=;
        b=DgiBW3yoTOZhJCRZUMCwemm2CGfjuTLsdJ8ByLI55mvhp1TNvntfhwR196lZ72yrL+
         BeUOsY8bh8XFUW4oJSmVAtSdo3IM1ChXPuvtSq2cmep6K3a0KJR/jMK6M6pEHvazHA1a
         i85R9SIpY98WLtnnPwfslr7g28+on78YewR28=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764149291; x=1764754091;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=84kp7mvpy609O4P8atJgqEkhRccxZ+4bKydmYjW/Bdg=;
        b=CeF3XN1zx6ye4L0u09m/cl47ZsBC2M+9KqAvpZd4qcmeAJPzN/yjbuwNOkgKssM2Y3
         vTAko4t5hFrajKqviYguq6cc9irGOUSUdTJyBM1AvXArL3huL2P5N7fC5CP66rI9b4h/
         q3eL5IdXuuYSK37AOCTG351rwNsrWDz4zlknr8HsxwmS6AtYMzMa8pE60O+pJ1n+wCse
         QmT/xCeUoTyCZnU8OWDazInl7EwtoLSNwr5PrhaSxc0bkzqWtx4GMas6x4hd0De74MZx
         U+hdU4qQlgkZQWO9y78EmYlSCsMiJfCdHv7AHd6aVg5aHcH+xg5afHj2oTh5iMcCjn+n
         kgzg==
X-Forwarded-Encrypted: i=1; AJvYcCWDE7pN16aJevZPmzN88tzjMzahMquePA8Pfu/FEp1549aar+oa5qC0kWCRTXvzEdR7HYsa1tYXcKg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJgaTd6SsQ+zu3lCeFpBxyVvBhdxLBf/Xgr/TAc5wGIvTGf7fA
	Wjom6jn7Lviu0TJCoqhq6PEQ4OQImYJ79k4gEQzy0Pr46RK9UDm+M0UT7B05GRYsldCnxuEUIXs
	GUuQtIm46uLvc6KwJc9q9gbYfnI1ovaac07FzllfuQQ==
X-Gm-Gg: ASbGncvZnsm+W6e1F5LvfjQXoDxkAJUTNngpsrw/yc3ikFE34RZhVc+Anl1CawHFAOZ
	1TuMuYvYMS8FdHt08MUgY0VYsK9fkbI35fmHBzEpWMDNwq2sceeEbQZmE5jxXBWpl8f5FKSNf1y
	vH7x4gQf42F0Y4+cDemAZ37pMb9ZXTklZgX+N6UZHFsO8wj1LOpZ2oLvSPh7VJYY2YvYzOyncXV
	KfMcevwit0KS7PDIaKQhOZj7bW4vTIx7W2T/+0P4nM6yy1DoNMWKdJsQC+pfh6dxj6qzomL
X-Google-Smtp-Source: AGHT+IF1+PB8oM28RkeDHPoge6KuDSLw2KinizbNZu9Z/hmrrITwS55K9mgMQr+6rdi6qM9GjhtyjajgRbxpYywLwKI=
X-Received: by 2002:a05:6512:3d1f:b0:594:2e7e:7897 with SMTP id
 2adb3069b0e04-596a3ecee86mr6911639e87.29.1764149291029; Wed, 26 Nov 2025
 01:28:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251120155825.121483-1-r.mereu.kernel@arduino.cc>
 <20251120155825.121483-7-r.mereu.kernel@arduino.cc> <45329a9f-545b-4425-9667-26bceca67982@oss.qualcomm.com>
In-Reply-To: <45329a9f-545b-4425-9667-26bceca67982@oss.qualcomm.com>
From: Riccardo Mereu Linux Kernel <r.mereu.kernel@arduino.cc>
Date: Wed, 26 Nov 2025 10:27:59 +0100
X-Gm-Features: AWmQ_bnksptY2VS0WbIEjjuom7AG_UPOEx3GG-ifRxT1W7-ppfRbkLP9jL5JiOo
Message-ID: <CAKA1Jha7HuEC-KgGktmuiG-U0ZVbKnmLU4bXTwLg+paoLpQ=kQ@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] arm64: dts: qcom: qrb2210: add dts for Arduino unoq
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, broonie@kernel.org, 
	linux@roeck-us.net, Jonathan.Cameron@huawei.com, wenswang@yeah.net, 
	naresh.solanki@9elements.com, michal.simek@amd.com, nuno.sa@analog.com, 
	chou.cosmo@gmail.com, grantpeltier93@gmail.com, eajames@linux.ibm.com, 
	farouk.bouabid@cherry.de, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-spi@vger.kernel.org, m.facchin@arduino.cc, 
	Riccardo Mereu <r.mereu@arduino.cc>, loic.poulain@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 24, 2025 at 12:44=E2=80=AFPM Konrad Dybcio
<konrad.dybcio@oss.qualcomm.com> wrote:
>
> On 11/20/25 4:58 PM, Riccardo Mereu wrote:
> > From: Riccardo Mereu <r.mereu@arduino.cc>
> >
> > Arduino UnoQ is a single-board computer combining Qualcomm
> > Dragonwing=E2=84=A2 QRB2210 microprocessor with STMicroelectronics STM3=
2U585
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
> > +&wifi {
> > +     vdd-0.8-cx-mx-supply =3D <&pm4125_l7>;
> > +     vdd-1.8-xo-supply =3D <&pm4125_l13>;
> > +     vdd-1.3-rfa-supply =3D <&pm4125_l10>;
> > +     vdd-3.3-ch0-supply =3D <&pm4125_l22>;
> > +     qcom,ath10k-calibration-variant =3D "ArduinoImola";
> > +     firmware-name =3D "qcm2290";
>
> I'm not sure about this line but otherwise this lgtm

This should be fine, I'll gently ask Loic (added in CC) to confirm that.

>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>
> Konrad
>

