Return-Path: <linux-spi+bounces-1365-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD3038566C0
	for <lists+linux-spi@lfdr.de>; Thu, 15 Feb 2024 16:01:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6421E2855C8
	for <lists+linux-spi@lfdr.de>; Thu, 15 Feb 2024 15:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0B7433B9;
	Thu, 15 Feb 2024 15:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MpjcItyx"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCF213248B
	for <linux-spi@vger.kernel.org>; Thu, 15 Feb 2024 15:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708009252; cv=none; b=WCvWiHVKZhtNQvSBpGjYf9erYu6405ZM2ajknIsYdkB6XZ7czMCY5EpTv//9Jg1H7+cinr3Q8zMuKnoZlCetF6kDnkQgYaoxwdArT7rzr8jat6CBZqsr12Imm3v/t9e4FGkdWw/CyEfbzgToyB4uX7IVBsSa8YlWFIwgDJhdA4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708009252; c=relaxed/simple;
	bh=TuiNAUvyq1clV8TcQUgStWd7GbVGRghSxXf3rSzZwzE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=miysz6fGXMnV0WHDxscv6ND5FExu5nz+2dEkpZupAIxb/l8875R7WpkPqG3nBe70E1F1nP1mjMIuxtN0Dx9nxi6kqImSDjw8g2bvMXPhX1sQ+cw4A+5UfC/Cuj+rphKI4R5Bp5RTlNnPw46p1xNEwIEk1NhDpHMaf/FCmAGjGn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MpjcItyx; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-60777552d72so9369437b3.1
        for <linux-spi@vger.kernel.org>; Thu, 15 Feb 2024 07:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708009250; x=1708614050; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CJ0BMQ4fbAPxFZIL+ExAw2UZkWvzvacKzKpaYXVa9bs=;
        b=MpjcItyxaCUbywq2/eFa9EpNJTbqxHjYzxiGUvadyJ4OpD2g3m4X/lGDCmwdji0F89
         ZI3iiZzXixEt5Ceq2UT/wY6vmjXC6KX5du0vxdF+ZnJH0R4cB96e0DF9PgVExW/+PJ9G
         owZiDKQ4YK3LEngMTT6K1FVQmx2pltalCWdLGmxV766sl7oax+LSo/5H2dJ7jIBfOCG+
         NfeLZACVrTmdxU4rSK1ptNPKzImM3PtzV3W03K/9imOLSjYcvzQJcVGA7a+cKKrbzfVE
         KvGCKypdYp7V70/ltmKfLfVkw2SUm5ku6/RfV+DUnaCYMBLfJG5LnMRxHfhK7cfXTWBx
         Y/0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708009250; x=1708614050;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CJ0BMQ4fbAPxFZIL+ExAw2UZkWvzvacKzKpaYXVa9bs=;
        b=feSZZqDTVH4nFtBZzROFwcTB+ireL1+33KsTrYAgJBZENUGbR8Uo7Fa70yZ2g5BtnG
         kcATqq22oIfQgVoKrcaSNHEBJksW3XB+HzhrYLXllszjgQ0NuJt3z2JY8JjRa+BhnWwz
         Go9br8RblePoRUc7jWpaCM0tNt57y8xjdqMHQY5aa1TRr1e7hSDoJHpA7p1bi5TurpX/
         6V/NxqcKurJ07iOTPytve7P5teJDudMF97ELKIDIXj+FkoDbH+1jmoVqtJXYGPCHJOUF
         7s/OLpzNdXK9TkEP1I6aJHpDxaq3XP3Ly3+7boDYrGyvsLYOk8qRRFT28mVSFDEm4fji
         gJow==
X-Forwarded-Encrypted: i=1; AJvYcCX/gky/2SoRFEWp3Nmy2jvz8Ou8saLFSJYFywjtgUpcirWo2/z334AMokWExlsTWe9fN3liN6UlqEf5QIltm9iM8nyzoxsiaqiV
X-Gm-Message-State: AOJu0Yw7GdEB/cqbrBdMdnazPQDWGUlWs+5p2y3KZ3n+zG4D0Vhc7HVo
	3yCHKUR6VzNXoCaFzTHemwKCTmVi1KhdrHO8hqQh+3yjw7zjT2/QoxsGKKoA161mEptV20+fFcg
	l6KgKrOWPApD+xO1pPDpRpr2QyL+/GnAiGWp8+g==
X-Google-Smtp-Source: AGHT+IH1iXXNMam85attnJ7ZRIB2/4oXnewhRdPWa1d/MOJ9E89Emu3qeIMg52lohwW+P6inqZ48cubKQOYzlT5hKRw=
X-Received: by 2002:a81:7994:0:b0:607:7e73:fce1 with SMTP id
 u142-20020a817994000000b006077e73fce1mr2063382ywc.26.1708009249786; Thu, 15
 Feb 2024 07:00:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240215134856.1313239-1-quic_mdalam@quicinc.com> <20240215134856.1313239-6-quic_mdalam@quicinc.com>
In-Reply-To: <20240215134856.1313239-6-quic_mdalam@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 15 Feb 2024 17:00:37 +0200
Message-ID: <CAA8EJpqV=w38TqjfTp6OurAwHjR87PpmQTs2jUo6O7vF1-T-WQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] arm64: dts: qcom: ipq9574: Disable eMMC node
To: Md Sadre Alam <quic_mdalam@quicinc.com>
Cc: andersson@kernel.org, konrad.dybcio@linaro.org, broonie@kernel.org, 
	robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com, 
	manivannan.sadhasivam@linaro.org, linux-arm-msm@vger.kernel.org, 
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, 
	quic_srichara@quicinc.com, quic_varada@quicinc.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 15 Feb 2024 at 15:49, Md Sadre Alam <quic_mdalam@quicinc.com> wrote:
>
> Disable eMMC node for rdp433, since rdp433 default boot mode
> is norplusnand.

Are they exclusive?

>
> Co-developed-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> Co-developed-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts b/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
> index 1bb8d96c9a82..e33e7fafd695 100644
> --- a/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
> +++ b/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
> @@ -24,7 +24,7 @@ &sdhc_1 {
>         mmc-hs400-enhanced-strobe;
>         max-frequency = <384000000>;
>         bus-width = <8>;
> -       status = "okay";
> +       status = "disabled";
>  };
>
>  &tlmm {
> --
> 2.34.1
>
>


-- 
With best wishes
Dmitry

