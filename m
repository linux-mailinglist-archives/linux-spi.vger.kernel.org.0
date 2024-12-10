Return-Path: <linux-spi+bounces-5996-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6FD9EB8A1
	for <lists+linux-spi@lfdr.de>; Tue, 10 Dec 2024 18:49:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE48D281B95
	for <lists+linux-spi@lfdr.de>; Tue, 10 Dec 2024 17:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD69204692;
	Tue, 10 Dec 2024 17:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VnRBCC3c"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACD11B4220
	for <linux-spi@vger.kernel.org>; Tue, 10 Dec 2024 17:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733852933; cv=none; b=R34vKiHCp32uclPN8PWtjLGWUJF2fO7Lh24+cdvIGeFJ/0dscA9R2NDBv8nkDdsbM/gmqjiY8doLfWgVtEFf97pF892/MabaWT3bpFWkdFqSozOm4czbuw2KcPsULe/42HXMpTryHWPiE5TGrmvyX0Y8CoRyjeEl/KrZhoorskM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733852933; c=relaxed/simple;
	bh=zyY+LvfKIlfyAiCLJWS7+1JGxiO0FEIr6sylV/Xgzzg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LPrHe9nX8MdQnMaA2kezURrewQOQM2SosfMGnHqkeGhm3KIebxRJbGXhd9BTVXR1Wocji75OHCwDqmQXrfE1IwQRHsNBkrLYOBm1/4r1fVkjFXSOwc89FSEv79fjRukT6L28d5XRo/099yYYNNm4gjk4lQbC0ZMWEiaWwpR+dp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=VnRBCC3c; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aa66c1345caso230456466b.3
        for <linux-spi@vger.kernel.org>; Tue, 10 Dec 2024 09:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733852930; x=1734457730; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AjuuFtemyP+DI+76rQdawmoZ3eTqeNEd2wfGxX97PdQ=;
        b=VnRBCC3c2JYmfBrTBbV+/x1lwq0kb0c7z14csdDy4IKoll5FrGx5l4ieaxJmXnpXfb
         Lu59KYhYTHqkoNQ6NB5gIDFVTYYLFAFYuorPjH8fLwx3f/7i2s/LbLU0QU3crMFppYb/
         rvooYyBCJDP+shqFIs3soxmfnBpJy3w6x+C/I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733852930; x=1734457730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AjuuFtemyP+DI+76rQdawmoZ3eTqeNEd2wfGxX97PdQ=;
        b=L0ChboQ9kvd/Xvx15BrZO5htnWbzMLGK/MIbqJ2ozAF9zbdmYL3uIEjlBq+0tQN8Ju
         ugmn4t1rEA8sHTbPSaMbxHcXb//TI4vWuSbGBLMAF3DxXXTmHUn/356uMDW9hJFIE7wf
         Qlqs7YjD/2Xqicd8nQ7YIidtOzzSAifBzNCPQLmf492ETEpopESzIYRd4j6pKDTYKoMN
         iMEDiwaLAdqrjYDn9QjqVxz8A0GRaPnnkyLPk0ir6CHQWPdUFVL77gNNeN1ad9yAwabJ
         FcbqatYDyv2wiAjEoiCt6a1fuILoTEpc2k+Ex4/d3mZy6zVqOXuUaGwRqEd6SjEhaSOi
         w+bQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwEjrYCKHwV2EELxutcHDnzpscpabLEftacK27ykKoWsceXzdIdkDWgaXYMy2iPdn7sNMbomD6iME=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXeK81Gd90L09SXEf08Slw1Rigxfke/BXdZBRWDeRJ5g7/lstI
	zCrpUcAOQSX9ZyVupge1hM8Qmcq5EFc80+STFKaj9SLN3koJBfXCDU9ru0r0Ql2t4YL0XP5+Mqa
	zDs+P
X-Gm-Gg: ASbGnctFTLCZiF3FK3cZ76cK6K59M3y+nZp9buKh4eYpLERt5Y1Qflef0+6FZKMlL5V
	UGXDS8pxfYG0z95vap42SjybYGQTudsDwYZeu88GFz1GlWIrnG5kLMkZQEK1sfTveWLmw1MZxkw
	k1CgpWDYJyfALwY/mp4VN7/OSairlu6rMB4qkvWe0mbuCmLTwV89gd93y08shKsnnbgNgrBSac1
	Vm4d9e0cyzQKLLd+P+iICbzdiRU41bdGpzC42nzS5ebiylspgseqIii0Nj/CNa1u1E3T6Uxk7Gy
	EWcn5B7f7lQv2LO5kQ==
X-Google-Smtp-Source: AGHT+IHLAMZdanHqqHblLFedQfTSSFs2wNfg5ueNlP5jyeblYWIXpJs9E6N7X8P4+eG0AbEnh0TkPA==
X-Received: by 2002:a17:906:292a:b0:aa6:727a:2af8 with SMTP id a640c23a62f3a-aa6727a3109mr929900066b.37.1733852929881;
        Tue, 10 Dec 2024 09:48:49 -0800 (PST)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com. [209.85.221.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa68880b3f7sm340944066b.92.2024.12.10.09.48.49
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 09:48:49 -0800 (PST)
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-385de9f789cso4334835f8f.2
        for <linux-spi@vger.kernel.org>; Tue, 10 Dec 2024 09:48:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX+JocCLrwkvdWWKfnXb4nP6aMtWK0yZDOr6kZmW3HuDDqNCNaDLeyuP9AXyfXEcaAJwIdW2r2wKqY=@vger.kernel.org
X-Received: by 2002:a2e:800a:0:b0:302:1c90:58d9 with SMTP id
 38308e7fff4ca-30240ced962mr314001fa.16.1733852563643; Tue, 10 Dec 2024
 09:42:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204150326.1470749-1-quic_vdadhani@quicinc.com>
 <20241204150326.1470749-2-quic_vdadhani@quicinc.com> <CAD=FV=XF+9wxZ5xNtO3Uy8QW9UY4tb+KR46jkondvBeQuVLsrA@mail.gmail.com>
 <6736db20-127b-45c3-ac90-3e3e359c343b@quicinc.com>
In-Reply-To: <6736db20-127b-45c3-ac90-3e3e359c343b@quicinc.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 10 Dec 2024 09:42:31 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VReNQ3nw+wfZizL7JjxEX9z=GwDEJAFzheNkW7rSrB5Q@mail.gmail.com>
X-Gm-Features: AZHOrDkKw2FmHmZQUJPUfL4ELobjfrjI9icl10Uq0FkzH_2PdMnaEbBKyuOx5E0
Message-ID: <CAD=FV=VReNQ3nw+wfZizL7JjxEX9z=GwDEJAFzheNkW7rSrB5Q@mail.gmail.com>
Subject: Re: [PATCH v1 1/7] dt-bindings: i2c: qcom,i2c-geni: Document DT
 properties for QUP firmware loading
To: Viken Dadhaniya <quic_vdadhani@quicinc.com>
Cc: andi.shyti@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	broonie@kernel.or, andersson@kernel.org, konradybcio@kernel.org, 
	johan+linaro@kernel.org, agross@kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-spi@vger.kernel.org, quic_anupkulk@quicinc.com, 
	Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Dec 9, 2024 at 9:28=E2=80=AFPM Viken Dadhaniya
<quic_vdadhani@quicinc.com> wrote:
>
> On 12/4/2024 10:55 PM, Doug Anderson wrote:
> > Hi,
> >
> > On Wed, Dec 4, 2024 at 7:03=E2=80=AFAM Viken Dadhaniya
> > <quic_vdadhani@quicinc.com> wrote:
> >>
> >> Document the 'qcom,load-firmware' and 'qcom,xfer-mode' properties to
> >> support SE(Serial Engine) firmware loading from the protocol driver an=
d to
> >> select the data transfer mode, either GPI DMA (Generic Packet Interfac=
e)
> >> or non-GPI mode (PIO/CPU DMA).
> >>
> >> I2C controller can operate in one of two modes based on the
> >> 'qcom,xfer-mode' property, and the firmware is loaded accordingly.
> >>
> >> Co-developed-by: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
> >> Signed-off-by: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
> >> Signed-off-by: Viken Dadhaniya <quic_vdadhani@quicinc.com>
> >> ---
> >>   .../devicetree/bindings/i2c/qcom,i2c-geni-qcom.yaml   | 11 +++++++++=
++
> >>   1 file changed, 11 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/i2c/qcom,i2c-geni-qcom.=
yaml b/Documentation/devicetree/bindings/i2c/qcom,i2c-geni-qcom.yaml
> >> index 9f66a3bb1f80..a26f34fce1bb 100644
> >> --- a/Documentation/devicetree/bindings/i2c/qcom,i2c-geni-qcom.yaml
> >> +++ b/Documentation/devicetree/bindings/i2c/qcom,i2c-geni-qcom.yaml
> >> @@ -66,6 +66,15 @@ properties:
> >>     required-opps:
> >>       maxItems: 1
> >>
> >> +  qcom,load-firmware:
> >> +    type: boolean
> >> +    description: Optional property to load SE (serial engine) Firmwar=
e from protocol driver.
> >> +
> >> +  qcom,xfer-mode:
> >> +    description: Value 1,2 and 3 represents FIFO, CPU DMA and GSI DMA=
 mode respectively.
> >> +    $ref: /schemas/types.yaml#/definitions/uint32
> >> +    enum: [1, 2, 3]
> >
> > I'm a little confused about this. I'll admit I haven't fully analyzed
> > your patch with actual code in it, but in the past "CPU DMA" mode and
> > "FIFO" mode were compatible with each other and then it was up to the
> > driver to decide which of the two modes made sense in any given
> > situation. For instance, last I looked at the i2c driver it tried to
> > use DMA for large transfers and FIFO for small transfers. The SPI
> > driver also has some cases where it will use DMA mode and then
> > fallback to FIFO mode.
> >
> > ...so what exactly is the point of differentiating between "FIFO" and
> > "CPU DMA" mode here?
>
> Yes, correct, Will update in V2.
> I plan to add 2 modes, GSI and non-GSI(PIO or DMA based on length).
>
> >
> > Then when it comes to "GSI DMA" mode, my understanding is that the
> > firmware for "GSI DMA" mode is always loaded by Trustzone because the
> > whole point is that the GSI mode arbitrates between multiple clients.
> > Presumably if the firmware already loaded the GSI firmware then the
> > code would just detect that case. ...so there shouldn't need to be any
> > reason to specify GSI mode here either, right?
> >
> > -Doug
>
> GSI firmware is loaded from TZ per QUP, but to use GSI mode,
> we need to configure the SE to use GSI mode by writing into SE register
> QUPV3_SE_GENI_DMA_MODE_EN and SE_GSI_EVENT_EN. This register is
> used to configure data transfer mode for Serial Engine.

Can't you detect it's in GSI mode without any device tree property
like the code does today?

-Doug

