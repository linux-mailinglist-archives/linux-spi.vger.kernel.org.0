Return-Path: <linux-spi+bounces-6468-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A784A1B850
	for <lists+linux-spi@lfdr.de>; Fri, 24 Jan 2025 16:03:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42AFB168728
	for <lists+linux-spi@lfdr.de>; Fri, 24 Jan 2025 15:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A25514A098;
	Fri, 24 Jan 2025 15:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BlLbmnyU"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B58178F57
	for <linux-spi@vger.kernel.org>; Fri, 24 Jan 2025 15:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737731025; cv=none; b=gZmkYzc2JTxlF7kaOyelrX+KuKfYU9cukVWkyLnFiPNQlMYgRsEuNAmh/7uA8M8CH+rkAD2Q05qzhnbRAIH8UjYQjDLxuT24iDweWateu6VKua5c7AxRr234hpw2tA1ViTCf1S4ykY0HqrwhGXzUORO9PYngTTTEhMibE03cc98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737731025; c=relaxed/simple;
	bh=gN+7KPBjQ3apdp+svz6jKhy2+Bo20hn7fXqkj0diiq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZEPS+P8Eq9CaNZEEdXznrpUfqQtk/nOCkfM2HvSKfUw6LqEbmLHmqK3TGplHlAikfjYJMBsd5rePCf/zPkfJ3nAwfslpTOiqNd3B6ratyiv7B0hCbRFvJJuavqyd+GIWUl5G38nxaocr8JK4HYZjK8jE9ZDhw+s5lFfLvEfJXxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BlLbmnyU; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-53ff1f7caaeso2257290e87.0
        for <linux-spi@vger.kernel.org>; Fri, 24 Jan 2025 07:03:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737731022; x=1738335822; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7T+NCUqaMb1L5bzUtS5gNUEu0whQ9tB9Ycz/UKjNxK0=;
        b=BlLbmnyUT0ycV2izcUqK/Edmivp3CDhs7W7/4Fd+eyFeXh7WOoCRI6R5MdTyyhwvQF
         sCliwK/OYmOu1akAu3jlss+5Cq47MPG2VM+hpIWfSQd3pxZk33IwGFCXSRh6p3/Z7Gre
         x20au7Q2OsbMvF5S01jm8ekv+zmAJXQmyu1YtEuH2hZfZf1XhabTRCA+ngIxaOwxnsw/
         bSe3u2soMfXTzepPckPMxvutfzqGKHldaaWuaPauNZC4Mhl1Egdas+GrvkdaUvAacKNm
         SOoa0u4tKzqn68Ru021/yLmHTqo3t29tiQ5jqmxNAixj2Whsw+PY/tvyHCWZFuneK0WI
         cDCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737731022; x=1738335822;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7T+NCUqaMb1L5bzUtS5gNUEu0whQ9tB9Ycz/UKjNxK0=;
        b=n00I1GlDifeChkNakamodSOGIKp649d+3/hYzNHhYJJGuacAWUXx7U3IZOSDodRYUm
         yEnqzBSQhc393qqA9FE9UX7xK5HR+GAuKuPDbvF4t10QeGIlTwXR1FE3p56TB0tg8JRk
         og2D/zAuaxCvBF7byPmAODrpEdT4HfrtPkYSPLKvXXsfupiYb5scOX3sBzpwQnJ27/8J
         /gC7NzkMvwXp3b3FlNOKrjbhGmiGzLa/zjUVAjCYnYgnPU+ilLOnfXqlFsHAACHsRMZ5
         DMV16HDtZj4jUJl3B7hgdu7Ds7FwwvsZN34jNr/V+TuvoA02saj9uszjNMmpXHRzaMEJ
         s2Fg==
X-Forwarded-Encrypted: i=1; AJvYcCVTYMQbW27x9fD9EAObT6UZQsdXrIyL3JjbkrRbF85ZhDOCGzytF9K+NopZVXIWa8r2GFuEUjbT4Mw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRn+KCJ7/2mG6DRTD3+cYSf6lAdmt5YGFDfnmHN3lbcrtGa8Nz
	Z7zQxZ7um0fYhkruYWnTvf6ybqU5pcMKVN8ttZlZdkUhl3JvGfhDUVQjcLGWCXM=
X-Gm-Gg: ASbGncsqsrWGUUuxArtaEfQjhFWdhY0zmhgq3DZ5oY7/xhdNkCvSu+pmp3eyJu33YC2
	GtgQTd4DRE92wTjUnuasxBzCo6Xtoyl7pEHkaVu9E0l8EWImll9pxnnpzCQDSXQAL3stJ/6+SJD
	0kBoyS12XN8qYBLkW02c8OE00kjWTr66mLcXXvHpjxgnglt74vCGetv3OFUprV6qppJKmXLOFC5
	kzwWh/9sQpCpABhaUN0UwQjHLtKh/I4QOCooFyXtNvH5RaMPwvIDsZ5xThFRpOTBjVv0wiFWSfw
	zZUpntOY0GDBpyRlv3cIhq1DjU2WhsR1w8WGIXx9Kc00ClcoJQsFZGL24Wd/
X-Google-Smtp-Source: AGHT+IEQdJgfpDkA2kLfF64yUHBaMCdd2VK0VHt4hFo/cuvczFWmqHG+G2R0tRPk4Ktqceg412FjcA==
X-Received: by 2002:a05:6512:691:b0:542:29a6:db5a with SMTP id 2adb3069b0e04-5439c2820cemr10379948e87.35.1737731020389;
        Fri, 24 Jan 2025 07:03:40 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-543c8368537sm316786e87.108.2025.01.24.07.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 07:03:39 -0800 (PST)
Date: Fri, 24 Jan 2025 17:03:36 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Viken Dadhaniya <quic_vdadhani@quicinc.com>
Cc: andi.shyti@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	broonie@kernel.or, andersson@kernel.org, konradybcio@kernel.org, 
	johan+linaro@kernel.org, dianders@chromium.org, agross@kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-spi@vger.kernel.org, 
	quic_msavaliy@quicinc.com, quic_anupkulk@quicinc.com
Subject: Re: [PATCH v2 2/8] dt-bindings: i2c: qcom,i2c-geni: Add support for
 selecting data transfer mode
Message-ID: <ewwk5tvwlhu7cbev7su75ysooboq7ivloydvd3unwic2e6p7ap@bpyoqsrgvf6f>
References: <20250124105309.295769-1-quic_vdadhani@quicinc.com>
 <20250124105309.295769-3-quic_vdadhani@quicinc.com>
 <r4zfoaub3dwkirdbsolbl56xxa7ax5eusb2256c7ezlyl2s3vh@hit4g5cpzijw>
 <da7b9678-76cc-4e45-89e9-4e8d9c9a2005@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da7b9678-76cc-4e45-89e9-4e8d9c9a2005@quicinc.com>

On Fri, Jan 24, 2025 at 05:52:24PM +0530, Viken Dadhaniya wrote:
> 
> 
> On 1/24/2025 4:48 PM, Dmitry Baryshkov wrote:
> > On Fri, Jan 24, 2025 at 04:23:03PM +0530, Viken Dadhaniya wrote:
> > > Data transfer mode is fixed by TrustZone (TZ), which currently restricts
> > > developers from modifying the transfer mode from the APPS side.
> > > 
> > > Document the 'qcom,xfer-mode' properties to select the data transfer mode,
> > > either GPI DMA (Generic Packet Interface) or non-GPI mode (PIO/CPU DMA).
> > > 
> > > I2C controller can operate in one of two modes based on the
> > > 'qcom,xfer-mode' property, and the firmware is loaded accordingly.
> > 
> > Is it possible to load the firmware after it being loaded by TZ? Is it
> > possible to change the mode at runtime too?
> 
> No, firmware can be loaded either from the TZ side or APPS side.

You answer actually reads as "No, yes" (excuse me, non-native here).
Most likely you mean that it can not be reloaded once either TZ or APPS
has loaded it.

> In non-GPI mode, the transfer mode will change runtime between PIO and CPU
> DMA based on the data length.
> 
> We need to update the device tree property(qcom,xfer-mode) to change the
> mode between non-GPI and GPI.

So, is it actually possible to change the mode? E.g. if the TZ has
loaded the firmware and configured SE for PIO/SE DMA, is it possible to
change it to GPI DMA?

> 
> > 
> > > 
> > > Co-developed-by: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
> > > Signed-off-by: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
> > > Signed-off-by: Viken Dadhaniya <quic_vdadhani@quicinc.com>
> > > ---
> > > 
> > > v1 -> v2:
> > > 
> > > - Drop 'qcom,load-firmware' property and add 'firmware-name' property in
> > >    qup common driver.
> > > - Update commit log.
> > > 
> > > v1 Link: https://lore.kernel.org/linux-kernel/20241204150326.1470749-2-quic_vdadhani@quicinc.com/
> > > ---
> > > ---
> > >   .../devicetree/bindings/i2c/qcom,i2c-geni-qcom.yaml        | 7 +++++++
> > >   1 file changed, 7 insertions(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/i2c/qcom,i2c-geni-qcom.yaml b/Documentation/devicetree/bindings/i2c/qcom,i2c-geni-qcom.yaml
> > > index 9f66a3bb1f80..68e4bf0c84d1 100644
> > > --- a/Documentation/devicetree/bindings/i2c/qcom,i2c-geni-qcom.yaml
> > > +++ b/Documentation/devicetree/bindings/i2c/qcom,i2c-geni-qcom.yaml
> > > @@ -66,6 +66,12 @@ properties:
> > >     required-opps:
> > >       maxItems: 1
> > > +  qcom,xfer-mode:
> > > +    description: Set the value to 1 for non-GPI (FIFO/CPU DMA) mode and 3 for GPI DMA mode.
> > > +      The default mode is FIFO.
> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > +    enum: [1, 3]
> > > +
> > >   required:
> > >     - compatible
> > >     - interrupts
> > > @@ -142,5 +148,6 @@ examples:
> > >           interconnect-names = "qup-core", "qup-config", "qup-memory";
> > >           power-domains = <&rpmhpd SC7180_CX>;
> > >           required-opps = <&rpmhpd_opp_low_svs>;
> > > +        qcom,xfer-mode = <1>;
> > 
> > What does <1> mean? Please provide corresponding defines.
> 
> Do we need to add a string instead of a number, like
> include/dt-bindings/dma/qcom-gpi.h?

You need to '#define FOO_BAR 1', then another one for 3. String is a
"string", it's not required here (in my opinion).

-- 
With best wishes
Dmitry

