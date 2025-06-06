Return-Path: <linux-spi+bounces-8371-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 196B4ACFECA
	for <lists+linux-spi@lfdr.de>; Fri,  6 Jun 2025 11:06:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 629723A1ED1
	for <lists+linux-spi@lfdr.de>; Fri,  6 Jun 2025 09:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE470286405;
	Fri,  6 Jun 2025 09:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G8l9QigN"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3EE283FFB;
	Fri,  6 Jun 2025 09:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749200794; cv=none; b=jFSUiODyuubhNZXWwr/UkYTSg0tHk0+bCadk8CFQQtgE32tvbxOgrdXEskWiqBvJEECShLAh7ZyxQyyjcjZzmKuIDxAAXFozv7/IZu8WyfAHDLp2eATM8BOkLgW+Sls81yi4olgvem7I0XOFN1piTyPq4VOMnyWyC1jFHc8CgoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749200794; c=relaxed/simple;
	bh=xZFCh0EkmJ6fC+3ypO4Zo22JJAr5ALjmJDD8E4XtJ4c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WPF0vsipdOiX5N966BI87eF45X/8M8if5eC3a4hAMRbWmMa+SiNMk0p6fnaPRHQ5NIcZfaZbHUVgdSghR59l5Fhpf9eNr8D3tgSE6otl7MLCm5XFZCmv8EApChqkkojX2YlUNsngzdG1LH98qElX/VW8dfs/QLk5OMBmKQ0pMXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G8l9QigN; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4a42cb03673so22606291cf.3;
        Fri, 06 Jun 2025 02:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749200792; x=1749805592; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+iEKTaT2LElUyz6hn/T8Mh2vQ8hFTWoMkAbmwi0/NDg=;
        b=G8l9QigN6nfbatr8wQSZiI11udlH5vGQPTx2U7+LrqY1Awy53ZEXckqGqAigXghwt+
         1NCqQauHeC+6KCNhkX4+FYJJ+PMvTpPMZx+qSm1I7nNqRW4FXBX6L3japGSSq+JXosRw
         FlVAZFYo3zSIawiEW/n4sWN48wu5vu807krtI196kEdZD64qW4O5qiFRilyiHKjE1yI7
         EN9a63OiJs1voPbG50R8hX/kVk/4PehyVZTyfEAxdV0/dw+KJMnOa+Ot4kzo4RikNUtn
         AOogTrPIVPFZahy6zgCzeMnaZvctU7tV8J6fWgNI9yK7oVrFF0PglJ85eXfINV5gOKvk
         sIaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749200792; x=1749805592;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+iEKTaT2LElUyz6hn/T8Mh2vQ8hFTWoMkAbmwi0/NDg=;
        b=GYodUHo/nEhYE0/0x1pHFFs5p+CdDhd4Vt/eRNXZ4bkaWdTmIddT/elgH/G3rxZm2+
         wrEd29eOB71ClmjmPuSPunwfMiqcvVfEULv+x55BLLKyI0/FTDG0OElGzCO6SF/PVJhy
         39KhyDmhDUix9oqfMNmA1FdHR1jwdZDhCzkPWM4xiABvJHa1dFKFQwNhpNgmLpm3xu9/
         Rc7Gtf68ffLyII1hrZxd7JN29aeZ/vl5w+00x6sgWeQ7OiSZYmvF2Bthgd1Lk5IM1VSk
         1Ty7GfCKQ+5zPLMxcYgNOB/JQyTI21hp25kU9XcmC9zuRcpnSDo04dkRPAdRHHbHRe7B
         pPpg==
X-Forwarded-Encrypted: i=1; AJvYcCV4Bj4SX3vrQlPWUSLrDyOdvtxvdlSDD+3Bk16+jE7U8sSo3URdGSVFg8ZTVArPKSV0MzcFY4mD+x/D@vger.kernel.org, AJvYcCWhpojanAgvn9y4TU4f1EIEmoZnwLLoEMfIAmiBsCElN5jSaGruzjXit14ddz0WWvv08wqb85qXl2GIMTQv@vger.kernel.org, AJvYcCXONlUgkja/NrJaT/AONMt3TEdWIb05wH8M3qr3vrQ8f9IKl5oQWSQpwDhPjTVEYFS2f1FVuDDaM4Pb@vger.kernel.org
X-Gm-Message-State: AOJu0YzWygNfphq9quIPtbotKKykGIS0pg8n3R+Y3ajgolM2+vMUD8TO
	/b22nLenxE4G75MroBhNCvICwUIeEswva9nTNuvvKldAxHbtZ6AZe9AKfO5bFtw0aAaWcvwLBHJ
	TqQlvjTZqMQRh81eMM8T5qbp1D9ZrZew=
X-Gm-Gg: ASbGncvBda2DHTarZCUjWP7JJJNVggmyUdJ8Dx2F6s/2Edw/yVuO8BBStoXb++ZHFVG
	x4R8thZGFoS1yIFA1T7T0zmQzU5CJShOKOSz0yUFL5zHdxJRMB/UGShehFTnldx08Eekiy09Mhm
	fhTmHtLWMdzWjmp74rVS0ZTPbZTyu7LQKmNJ6GOwbSV3p9TarbZz8Z5bS4xDx+2SWZNuSjB8D23
	9Kl
X-Google-Smtp-Source: AGHT+IEAnnzIxtW3T+9hMHK+wBH7ZD7AMKC5gNvjX9nEPuofdL7PSuw1v4ThDP1ou2X6MNg+w1DXRb5CyDe5GpT5zFk=
X-Received: by 2002:a05:622a:90a:b0:491:20d6:75ff with SMTP id
 d75a77b69052e-4a5b9e55b32mr50608161cf.31.1749200791922; Fri, 06 Jun 2025
 02:06:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250510-wmt-sflash-v1-0-02a1ac6adf12@gmail.com>
 <20250510-wmt-sflash-v1-1-02a1ac6adf12@gmail.com> <20250514204159.GA2988411-robh@kernel.org>
 <CABjd4Yz3w75PtkRk_edzD5yf6b2xPuf20gopbm8ygddgCBfpkw@mail.gmail.com> <2b520ae5-eb0d-40eb-ba73-cc18759f33b9@kernel.org>
In-Reply-To: <2b520ae5-eb0d-40eb-ba73-cc18759f33b9@kernel.org>
From: Alexey Charkov <alchark@gmail.com>
Date: Fri, 6 Jun 2025 13:06:22 +0400
X-Gm-Features: AX0GCFtSe5pvb_MWkkzTKnls_WaiQE0eICzI9uRkedvlSrNICRkV_prB9UA_SHY
Message-ID: <CABjd4YxRMfi3ZFQxhB__6U4Rm3KQ7bm6J=wQLWAkpb++61ddEg@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: spi: Add VIA/WonderMedia serial flash controller
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, Pratyush Yadav <pratyush@kernel.org>, 
	Michael Walle <mwalle@kernel.org>, Miquel Raynal <miquel.raynal@bootlin.com>, 
	Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, linux-spi@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 6, 2025 at 12:29=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On 15/05/2025 21:50, Alexey Charkov wrote:
> >>> +
> >>> +  "#address-cells":
> >>> +    const: 1
> >>> +
> >>> +  "#size-cells":
> >>> +    const: 0
> >>
> >> This follows the SPI binding, right? Drop these 2 and add a $ref to
> >> spi-controller.yaml.
> >
> > Need some advice here. While this controller speaks SPI protocol to
> > its connected flash chips, it's a special-purpose thing that doesn't
> > expose much SPI functionality to the outside world, nor can it drive
> > any SPI devices other than SPI NOR flash. Does that still qualify as
> > an SPI controller as far as the bindings are concerned?
> >
> > Happy to reference the spi-controller.yaml binding if so.
>
> SPI NOR flashes are still child devices of an SPI controller. You can
> look at other examples - aren't they all using spi-controller? Why this
> would be different? Unless you found some cases that are different, but
> then which ones?

No strong opinions here, and no expectation of any special treatment
:) Just wanted to consult on what's most appropriate.

My (subjective and perhaps unfounded) expectation when seeing
something advertise itself as an SPI controller was that it would be a
general purpose SPI master, to which one can e.g. connect an SPI
driven LCD screen and get it to work with generic Linux SPI
infrastructure - which would not be possible with this single-purpose
NOR-only flash controller. Given that I don't know how flexible or
restrictive other examples are in terms of driving arbitrary SPI
devices, I thought it's better to just ask.

What I'm getting from this exchange here is that I'd better use the
spi-controller binding and respective node names regardless of the
fact that this controller cannot drive arbitrary SPI devices beyond
NOR flash (which, as I'm getting, is irrelevant after all).

Best regards,
Alexey

