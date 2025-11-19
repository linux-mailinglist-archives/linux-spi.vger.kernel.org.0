Return-Path: <linux-spi+bounces-11290-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 59FCAC6D9EA
	for <lists+linux-spi@lfdr.de>; Wed, 19 Nov 2025 10:14:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 53FAF2D67D
	for <lists+linux-spi@lfdr.de>; Wed, 19 Nov 2025 09:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3694E336EE0;
	Wed, 19 Nov 2025 09:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arduino.cc header.i=@arduino.cc header.b="SqizxynX"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C6A336EC7
	for <linux-spi@vger.kernel.org>; Wed, 19 Nov 2025 09:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763543482; cv=none; b=oy4JPnNGwdkrbM/nu+yQ1FyfOHL6gJrnqBB2+jbNuQhzIHS0LVrGJdAJwQZ5nnjNy1/+XwjwZlrMCWNOadGFiK0PSaOSahKymDcotTAuXWjpIJk0WiBXjEgHcUwMhtoA25PyZJ6KsLZ5VFp3YnZYcWfPl+8xy7RrPtHD4V6vflw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763543482; c=relaxed/simple;
	bh=8mU4ut9Xtv8ppJaj6RvfY2g7TpvDfeb9Tu6G1ZJZNac=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bbgoi73xZpMJpe3ZdbRuQo14ljArbX20bLb+offK2qlRSjYXfH62ilmrKUNvkUkXaqSYrtJPHp0NJbgYKvQX7Ia7hmXbQwJxagrgWDGWXCMb+D8Rxqs+SSRQbs6KwxBxCNL/zAuJqwhkXY2yqM0OtcgY785pnoiLFMes023RKgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arduino.cc; spf=pass smtp.mailfrom=arduino.cc; dkim=pass (1024-bit key) header.d=arduino.cc header.i=@arduino.cc header.b=SqizxynX; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arduino.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arduino.cc
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-59447ca49afso8171071e87.1
        for <linux-spi@vger.kernel.org>; Wed, 19 Nov 2025 01:11:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arduino.cc; s=google; t=1763543478; x=1764148278; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TTTF42fHK5mGdQSQ9elb7+2UnZ+sckGT0/TBrhCYXmM=;
        b=SqizxynXEkob4WzS3EJpXtPTvihvF9tYg89Xg21iEj0mQ5e22OWkccRm69QTMWwIHn
         rL7tm8AcEHdJzf1vLjSjH874v/aKwAt4BjsmhwEsBOEMo8LL15TuRlXGwlZLIHYptEwO
         O9hORrEqQoHXEKOj0hGBgevFKqxCJ7YvoTFME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763543478; x=1764148278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TTTF42fHK5mGdQSQ9elb7+2UnZ+sckGT0/TBrhCYXmM=;
        b=dN0D4tD3V+QsFgd8c7iQzuKFIVK7yKkbjSRmzZx+TYi7oz0HVudi5QtB9AVu1meO+Z
         UNcSZBGQ00dPlVsMFhYIetIclMzyU+AbEpSJfM3CqesRkGxDS2kBxY9/DWNgUzcevdXh
         OFt+6/bA9wyG/GlyTMcQPsp7Sf+opz67SbMS7fATK42lyj8IeHCP54h4IGVuzQuIF986
         Ty+ztV4CU0N0TVLRf7zCBI5055TQCVCD/eEpNzm+8+jWTp55Ktv1ic2uLtHkSjgJ7Sr9
         kIxNEmlfUfvJqWklECvVvEEkGQGnK8xeMfvQhhIF1bf6qNezRXy3kALHPDhMsWsJXz6q
         Gu3w==
X-Forwarded-Encrypted: i=1; AJvYcCVkcO7CsZL8yPCK+wlW7CKqwtxvvo5vkDnRALyIudK1agjUSLWEx+BN6uJn4a5hO9E2VyuLgXsujbg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTyTs+1NLPrp4vQywbDDNSC2gAZSOcs0KY88XlqCySQdj3okgU
	+NwWe2CvywSMWb41JIy3FwiWwO9Z1EAj2iB/OIhm/ywU0H4mhjpsn1sQYI1w65SnC4bTqz9JgQ7
	jll65cN2CZbZ3da8xW3Losmu4M73FI4FxhsT5KTR4QA==
X-Gm-Gg: ASbGncvmCDLARvJALPCMrs8KDe3YpxDvcYMsc/DNIcDWg2ipfO3u9mSqo3sM2DL3qjB
	VZUgchQFEmCIaSla9N6Wz+YY9f4zKAgBzktSZFrUgAbjF8F+Ou6FDWNNmepW1YWDgJVE1uESlq3
	0hzmXJ6Qtr0NB2DPc+Chb4Sy9glaxSTR2JykSnoOgmM/1XY1PJCkHsNaRaLPxubBFVCrK1BX64X
	lje7Lvx9+FWkipjy5kCWvjnL6I9QUFGuiZodPEqwiFAFQPuNnkX8wvXBm7049KffNAbWuti
X-Google-Smtp-Source: AGHT+IGUbmXRNV8j6kxI8Xn7Sl5eUfTFpf8w41GTfqJnIcWHEeTQ0N7Q5jnCCd2iqGfQtnpuBxHOO/hGyXAlFCmqfu8=
X-Received: by 2002:a05:6512:3e02:b0:594:34ae:1446 with SMTP id
 2adb3069b0e04-5958424f6a9mr6235982e87.41.1763543477881; Wed, 19 Nov 2025
 01:11:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251114121853.16472-1-r.mereu@arduino.cc> <20251114121853.16472-2-r.mereu@arduino.cc>
 <5c30421e-108a-41de-81c7-c0c5e5290cc1@oss.qualcomm.com>
In-Reply-To: <5c30421e-108a-41de-81c7-c0c5e5290cc1@oss.qualcomm.com>
From: Riccardo Mereu Linux Kernel <r.mereu.kernel@arduino.cc>
Date: Wed, 19 Nov 2025 10:11:06 +0100
X-Gm-Features: AWmQ_bnNqwRxZncGu0OHJ90obULTPlnvAB2TqnHrw0p7-cDSRsSM1l0RzAquaR8
Message-ID: <CAKA1JhYgUUSQxcvmJPdeLu8S_tO5HUOb2GAhS_zX6jUOQzfm1Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] dt-bindings: vendor-prefixes: Add Arduino name
To: Trilok Soni <trilok.soni@oss.qualcomm.com>
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

Srl (or SRL) is the equivalent of LLC, SPA (or Spa) is the equivalent of In=
c.
Just noticed I was inconsistent with upper case and lower case letters
between commit message and commit content.
Do you want me to fix this in v3?

On Wed, Nov 19, 2025 at 5:49=E2=80=AFAM Trilok Soni
<trilok.soni@oss.qualcomm.com> wrote:
>
> On 11/14/2025 4:18 AM, Riccardo Mereu wrote:
> > Add entry for Arduino Srl (https://arduino.cc)
>
> Is Srl or SRL =3D Inc or LLC?
>
> >
> > Signed-off-by: Riccardo Mereu <r.mereu@arduino.cc>
> > ---
> >  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/D=
ocumentation/devicetree/bindings/vendor-prefixes.yaml
> > index 42d2bc0ce027..07a285c9387e 100644
> > --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> > +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> > @@ -158,6 +158,8 @@ patternProperties:
> >      description: Arctic Sand
> >    "^arcx,.*":
> >      description: arcx Inc. / Archronix Inc.
> > +  "^arduino,.*":
> > +    description: Arduino SRL
> >    "^argon40,.*":
> >      description: Argon 40 Technologies Limited
> >    "^ariaboard,.*":
>

