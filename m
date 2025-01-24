Return-Path: <linux-spi+bounces-6472-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C50F4A1B9BE
	for <lists+linux-spi@lfdr.de>; Fri, 24 Jan 2025 16:55:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2258D16D450
	for <lists+linux-spi@lfdr.de>; Fri, 24 Jan 2025 15:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6DC15D5C5;
	Fri, 24 Jan 2025 15:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s7zZ3quV"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C32315886D
	for <linux-spi@vger.kernel.org>; Fri, 24 Jan 2025 15:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737734135; cv=none; b=dky32U+N7BuPZrYgXMRk7gRV/yFiMRD1rTiM7ziT6WneY/L3qH/rlrDqjXSVvx04qIdpm535lkZOcFbBcIwnNtwyUWZr2PqKIWbgu6N386cUP1GIoUfbXnWSYtxvCb6ARYpbLysqJfNfYn1b7x6fDZT9ehNWohsyiltMLojdh1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737734135; c=relaxed/simple;
	bh=s/jO4NPWKOieyxzi6luyHh+P5ju9zoKIC7bH0SB8o4s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R8AGUFHKTvZcjryVQY9grTuDtjf02uylwp0RWfgprZvG7+th+WzEjbKGWeQRy8YoDoW6HRgb4imk0PA440/fdryOV5knyxSWD/UOzGby5AFs0gMTHSFQZhKd9Z24Ec6RYmzytdEWhmwrsYoy/NlY/1yJAZsPRmil3sNf2HRTfQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=s7zZ3quV; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e39f43344c5so3223720276.1
        for <linux-spi@vger.kernel.org>; Fri, 24 Jan 2025 07:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737734131; x=1738338931; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ilPZPULNnLI6UK/uv5dVV+2Dss3A/uBmwkDVQdaY3K0=;
        b=s7zZ3quV6sSGQi23hJ8dEM4EP7tlS0VnAiaxBv3lK2wpY8qVBS+nv0u+LtSgG3zm7a
         3jC/AeebNiMJTjl0CVRjs0C+ZCprv/VSwLRNaAB+dBzP91o0J1unli1foSINTUIjCnrN
         WHlsm/odmDIZNdqV4J+p6YtC9wuZ+t6FP+ZlBqLaLju/eWO3BGhQmaL8HMcSn3NxA5uM
         wozOiTvrTWMH9N0FeRUT9N3m3ZjyqmTfRJlH4vvuzIdATqdDi3VjBVvW1VdVijcrWkOK
         N5FZhjLj2bhGl8EF8f1n+WVssM5PB9NIxCkKwnRfCaN37YqkH2LBT4uq39WZsLnGIbfF
         Dgpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737734131; x=1738338931;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ilPZPULNnLI6UK/uv5dVV+2Dss3A/uBmwkDVQdaY3K0=;
        b=Nt5AMuJSaddTOJK1axLRFPvhytyih7IPo4L170Bv3RzGIWswEvVbKxdat/5f3nzMPQ
         I25bbEWz94jXHAF1jaXCp1OccVarSGpFnyMn+HI83lx7xN7ehwwxcBBFHGEd8JfwcmpZ
         CugPSIoH3etNIMQVTKRbNDiM7zFsykUGZN8y/C/ES7djJ0JeVYTYFAVprB79tY5qm0Ko
         Ya10i0y7c8GpgoDYUJ487J6Tsc5f488WWW8OuclKpymfzlSn6Gqc3mwyzh4U9Cy737dF
         ytt7ZU9OpjZxIwn9Y2utuT0nA2rP2YpsK4A2BD1i47pTOaldcGxTxrVcKJWSBdAkiSBw
         eqcA==
X-Forwarded-Encrypted: i=1; AJvYcCWIX38k2QdD+nJNXh9TIXDcJXMVDXyTUMBwYSrfrEikD20htah9SgAk4l4yze16qidYbwMI3WdzkGY=@vger.kernel.org
X-Gm-Message-State: AOJu0YweaS2zYwLi4NBNxoFUq2MljRM97gDCpsURiTekjewIG8tCcXaj
	XoFeyTsPIJJKyxMmvprlmQLh5cx9jyHB310P/PENq4vvRMomnHsgnxOSVMSEQS7Qze+XLt9Y5jn
	irQv0Puoo6fd4Hm0vi0YFa5hOdIQFdV/HV29GhA==
X-Gm-Gg: ASbGnctd0YfW7qF//sp9VymszeyE6k3RVoDzCBaKIIBZPeauX3AwQCogO7Kh8O/YV+g
	7eMpvOGiAqLkLaHr8mKzS3/EBPv6NcoLW/FpGP5DDfOfcUlFUMBA1JAM/PwrU1MvNDapAZjbrg3
	qvlD8hh55iH3NCAKYIMg==
X-Google-Smtp-Source: AGHT+IE5CrP20lwY9b957F+q8FfX4UrWyqpcD5u1RzqaZ3UIpMjXmbJiX0igSbAvphxXL+FBMTlukLRROvc9N2dsUB8=
X-Received: by 2002:a05:690c:3701:b0:6f6:d4bf:d01a with SMTP id
 00721157ae682-6f6eb940fb8mr246220177b3.34.1737734131503; Fri, 24 Jan 2025
 07:55:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250124105309.295769-1-quic_vdadhani@quicinc.com>
 <20250124105309.295769-7-quic_vdadhani@quicinc.com> <d3tydp3m7pehhiphupwybjlol5v2u3sabqotqximxmnswjlczb@jmdzpbrcrgou>
 <08545d45-bfe6-45e4-b7be-503c318315af@quicinc.com>
In-Reply-To: <08545d45-bfe6-45e4-b7be-503c318315af@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 24 Jan 2025 17:55:20 +0200
X-Gm-Features: AWEUYZm4pYCNJdHGiPnsyF_MnRCwaJQzJ4L3pN0DCmSTM3Gxdme16eoXtL4QfTk
Message-ID: <CAA8EJprSZx9Bx7EXA_RpwZdhieOLtrTARqXSuo-gO9sVMdK5Qg@mail.gmail.com>
Subject: Re: [PATCH v2 6/8] i2c: qcom-geni: Load i2c qup Firmware from linux side
To: Viken Dadhaniya <quic_vdadhani@quicinc.com>
Cc: andi.shyti@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	broonie@kernel.or, andersson@kernel.org, konradybcio@kernel.org, 
	johan+linaro@kernel.org, dianders@chromium.org, agross@kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-spi@vger.kernel.org, 
	quic_msavaliy@quicinc.com, quic_anupkulk@quicinc.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 24 Jan 2025 at 17:24, Viken Dadhaniya <quic_vdadhani@quicinc.com> wrote:
>
>
>
> On 1/24/2025 8:34 PM, Dmitry Baryshkov wrote:
> > On Fri, Jan 24, 2025 at 04:23:07PM +0530, Viken Dadhaniya wrote:
> >> Add provision to load firmware of Serial engine for I2C protocol from
> >> Linux Execution Environment on running on APPS processor.
> >>
> >> Co-developed-by: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
> >> Signed-off-by: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
> >> Signed-off-by: Viken Dadhaniya <quic_vdadhani@quicinc.com>
> >> ---
> >>   drivers/i2c/busses/i2c-qcom-geni.c | 7 +++++--
> >>   1 file changed, 5 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
> >> index 7bbd478171e0..9ad3b8c9a224 100644
> >> --- a/drivers/i2c/busses/i2c-qcom-geni.c
> >> +++ b/drivers/i2c/busses/i2c-qcom-geni.c
> >> @@ -872,8 +872,11 @@ static int geni_i2c_probe(struct platform_device *pdev)
> >>      }
> >>      proto = geni_se_read_proto(&gi2c->se);
> >>      if (proto != GENI_SE_I2C) {
> >> -            ret = dev_err_probe(dev, -ENXIO, "Invalid proto %d\n", proto);
> >> -            goto err_resources;
> >> +            ret = geni_load_se_firmware(&gi2c->se, GENI_SE_I2C);
> >
> > Hmm, so if the SE has been configured to e.g. SPI by the TZ, can we
> > switch it to the I2C?
>
> No, in the current design, TZ will not load the SE firmware.

But that's what your patch is doing: if the protocol is not I2C, try
switching to I2C.

Instead it should be 'if unconfigured, try loading I2C'.

>
> >
> >> +            if (ret) {
> >> +                    dev_err(gi2c->se.dev, "i2c firmware load failed ret: %d\n", ret);
> >> +                    goto err_resources;
> >> +            }
> >>      }
> >>
> >>      if (desc && desc->no_dma_support)
> >> --
> >> 2.34.1
> >>
> >



-- 
With best wishes
Dmitry

