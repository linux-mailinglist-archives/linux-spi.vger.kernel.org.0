Return-Path: <linux-spi+bounces-7611-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3793CA8B376
	for <lists+linux-spi@lfdr.de>; Wed, 16 Apr 2025 10:23:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18A79444B37
	for <lists+linux-spi@lfdr.de>; Wed, 16 Apr 2025 08:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44717230270;
	Wed, 16 Apr 2025 08:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZUPjHEVp"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A18D2356A8;
	Wed, 16 Apr 2025 08:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744791735; cv=none; b=NsZ7rgoKsElLFkli1BgZXgFwy0SKkMpiJgS5FaEoG5P7CosUhGIo8TCnjziBmhH64iqBLpFfCeBwKOR4G0xb4GRF1VzjUSO11hMQ3dm8elkZ32QdAL81UGwWuP2RWqJ/fUWrng4FhEO8Ee3EhniorCvN0iE0hvktKZoqEApvwM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744791735; c=relaxed/simple;
	bh=0KaFhwTnjmDgReZaYJULJcv+2duhaffN/39etIBXWms=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fdbBLKquix3OFBZtzY4f3sTs+I81+sngE4nVSG2++cD5Rj2/miJ201mpKKEdTtOQu7u4AGT3rChE554Q4aKsvEOzA6UYl/Mf2gPpJGOgcQ+epcnbt8kkngUT0/ufxqK5vwDsiW/cyVXqQe/ovQVROw2PFLgTPJiddpKHoDcH6kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZUPjHEVp; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43edecbfb46so43917515e9.0;
        Wed, 16 Apr 2025 01:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744791732; x=1745396532; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qbOPyx4AvMcXJQ3iWHB+ayWpfG/43B3L2xzA6vm/AYY=;
        b=ZUPjHEVp/qGmhus5FsyLWJTWKjvM5qcsC9+I1sG9d934XwVFO1RI+hTKUNND0P2fw5
         gXUI2qmOFFrKIIumZop+ryyGPoy6jl/dq/9gzbd4odNf+dhWFsb5WywcOZHG/KSzpayn
         ccf1wfADXH+FWSny5JzRcUUkEQ7s/11cVIe3S304tKHpNaPrrKfmTpCL6B0T2nh86lII
         vmn8WaPkqGeXLMwk4Dec8WyMSlddnBaRznR4S8BJnd8sF4pmZ5Y8ZcWb60h1NXw0wHVy
         YOusIOkt1u4kMwXAtyb2WiX48nk5LUj9BEeRAaxwbvX4zZDOoq+aGqtPD8Geae0ZQvBA
         tIsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744791732; x=1745396532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qbOPyx4AvMcXJQ3iWHB+ayWpfG/43B3L2xzA6vm/AYY=;
        b=HGu2UaofS3DdTJDM0TgIgvu3Giw2R1jrM6zphNzgGlvEr06Gd3veGQ0GEnTq3ygZ/1
         Pkp9/nrX9GLnlG6A4ixaHVmFG8BOYb3PdnelbohdkKardgdbDIcsArc5Axqe/bLVClB0
         8/47G+qrL4DvUxqVgNepGiUuODBeqIripE6YEzcd1YIYJ0RYjlR+W0kEt/Id+EEmd7Gg
         y81Xx0cViV04SrIFcaD/E+BQHHjy5622jCW34Z/Fj2ZLx6YkSQJysafxp9FwpQULpdFI
         +xOUvFb0FpwEoqodMth2xaOOeB3C841JNfInAlXJkR94EpYRcxjtu0cydCk7FcJpRp7G
         R+YA==
X-Forwarded-Encrypted: i=1; AJvYcCUiOcv1m/OPWh1nP4c2laTwOejNHNtq3S+hcV3bFwg1lrNmPJs+bWG/Z/TACHk/u4Oc/qTiomeZs50F+uQ=@vger.kernel.org, AJvYcCVcEWR0bt086P4Pk6jRxlfuON0VekXQhjHyndmuAQtTZc/keOhgBht5SAyzuuiHfo3Ps+COnhBhL1kE@vger.kernel.org, AJvYcCWQ/8Z6TUsBIe9sgslIzR4ZFWwbP2mfvF4edV9j5oY2rpznRmONN4Z2vCHP9wvLqSomS77oPD/gQbJd@vger.kernel.org, AJvYcCXNzxEXRChy+6EnFDiT+4qyya6Sv/BJA9ecbMAZhH6XM8Cz9x+5TiRAlmYA86IrtvDbs81Z25T8hAf5TSTxzONqHX8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtosIAwwebKCTvF7dX8F+AwyENqVeW+glRkFauky8keyCuooqb
	k+nONuXcryk/mWBUM5l8wPwErqQa15UwTDJhwHRpob6I/8A3SMB309UxIkLFBgZljrEExr5B0cc
	VoUeInSN0NZHJ7WgliAwU3OfQfGE=
X-Gm-Gg: ASbGnctKLqrO9C/mDlfq0I8BLLhC8E469EEZ0xpcUmrcJ1i1SdPlNetL9Z9+KgLBUAo
	PFObsYfWI+d+HPmyFLnlQXoueu55tXXVnUWOdKRroDs9uewdXvbvoFUsW0H2bSD/2yPfM53o+qR
	HKSAcKZBrCeupuwGGbw652SqUSNUniKreP7ZbCRniL5WwgWle5FM/TQso=
X-Google-Smtp-Source: AGHT+IGZfVNclgSymwQIgJJbTBb/ACviVVFnVXr/eNGWv0CZgkk4ZBmuPt463HFXSBqsYm7JRrtN7+r8xJk/ESB9pPw=
X-Received: by 2002:a05:600c:c0b:b0:43d:934:ea97 with SMTP id
 5b1f17b1804b1-4405d6df1fcmr8497825e9.27.1744791731333; Wed, 16 Apr 2025
 01:22:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87zfgi1a5a.wl-kuninori.morimoto.gx@renesas.com>
 <87plhe1a3f.wl-kuninori.morimoto.gx@renesas.com> <aedc9fed-ba6c-4e22-9641-53ff0df8cb06@oracle.com>
 <87jz7l81s8.wl-kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87jz7l81s8.wl-kuninori.morimoto.gx@renesas.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Wed, 16 Apr 2025 09:21:45 +0100
X-Gm-Features: ATxdqUEKGUTW8hvWeJnxFgZREGiL0SYBtD8B_i0RH8QQtFTkYvwtGPN9SZsaDpU
Message-ID: <CA+V-a8uoMmWK=Q2Gq_y+OnLotPJKA19QWmmY98ED51D-HPQa+w@mail.gmail.com>
Subject: Re: [PATCH v3 07/10] ASoC: renesas: add MSIOF sound support
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, 
	ALOK TIWARI <alok.a.tiwari@oracle.com>
Cc: Conor Dooley <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Jaroslav Kysela <perex@perex.cz>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Takashi Iwai <tiwai@suse.com>, 
	Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>, devicetree@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-sound@vger.kernel.org, 
	linux-spi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Apr 16, 2025 at 12:04=E2=80=AFAM Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
>
>
> Hi ALOK
>
> > > +   irq =3D platform_get_irq(pdev, 0);
> > > +   if (irq <=3D 0)
> > > +           return -ENODEV;
> >
> > nit: -EINVAL will be more relevant here
This is not a right suggestion, please return back irq so the error
gets propagated. (Alok please read upto date documentation prior to
any suggestions, this is the third patch where I'm noticing wrong
suggestions).

Cheers,
Prabhakar

> >
> > > +
> > > +   priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> > > +   if (!priv)
> > > +           return -ENODEV;
> >
> > nit: not sure why -ENOMEM not return
>
> Thanks. Will fix in v4
>
> Best regards
> ---
> Kuninori Morimoto
>

