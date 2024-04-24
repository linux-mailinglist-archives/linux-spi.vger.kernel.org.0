Return-Path: <linux-spi+bounces-2484-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8CAE8B0A0C
	for <lists+linux-spi@lfdr.de>; Wed, 24 Apr 2024 14:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A98F11C22A44
	for <lists+linux-spi@lfdr.de>; Wed, 24 Apr 2024 12:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3801715957A;
	Wed, 24 Apr 2024 12:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BFQxEJcz"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9730B134A5;
	Wed, 24 Apr 2024 12:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713963102; cv=none; b=LExkI2TdTUARP9KwMyb4OQ476xeFNZ12+gjY26V7ZelwKJInzEk9y7h0L092P03vDd5bQ6A0mFGOPV0hgvcHlnEL/flShTNwbSaDbozkt/yP+U+1Y3TaBuGs0K7B4Q9jAkADwp1sRAYXeDallh06P2laQZR+nl26sBAdJB0cBlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713963102; c=relaxed/simple;
	bh=8k9h/fB4ObhnXmP5vlzLNrzghznfwOtBlHsG8iBsKYk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=poIemnNI7P0cbbv/lZBUpa8IRXLnx0kmTU6goWELCgoTpEENCbi7r7QM/tCz7gIcQmy/8f5olhK1r1GYH55FqjctDQri9yteaTCwtmoNF0dsxOJJla0e4dwAuJPpyvh0O1z9S8FhE17AkTWE9ahvIIeD6EVGeaBkIa4Gu2El9q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BFQxEJcz; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-57225322312so1903003a12.1;
        Wed, 24 Apr 2024 05:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713963099; x=1714567899; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lrSDGxIcCbhabTE8LlgRMA3a1B1b0WUwAReVcV5t1RA=;
        b=BFQxEJczg3VE/hVUYFmq6+BZqst7iQzqkBkOt3ThPVl6EwTOOgBZmJHQwiBlECQ6Wr
         AcNn4aOVX6BZ6zFXoj1piGRlW972UfOS2VruKgUmBKNo1nCi1djbGP2w0iV1Uetlzmr+
         Xf4dEN7hE+PaA1vMRtN00pQ/NT2/uU1gFBqiFIN6hMw/X2LoeMYo59+HQLNb5Yi+8nZB
         M/96JTi7W6E0OH5VqRCj+aB3H7NNkC4ItDncmAVS8983EN/1i9VaJPPlYDhKFZZGMfuv
         lRee9VZRY6iNF0j04fftoA7mVSbR9KkfA6mTyifZ5XJJgVD1YwuJxia6Rv2UT30GkRAz
         /G4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713963099; x=1714567899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lrSDGxIcCbhabTE8LlgRMA3a1B1b0WUwAReVcV5t1RA=;
        b=MeoYYuKOWj/V+IrhXaoFKRrWtQGgJLT/HZqQi3uMY5JoyypuirkhuHmwU9Z23r8E+q
         OFLk1sj0ji7OrrcfurYabfcUUAIdoILQKwwmxOk4ehKTEqsHszDSthNl4YA7VJ9nY1Qt
         HCPqItw15qmyP6bGMvmaZMrDEPy4RTWHFLlXocPPi/lwqUH8FXH6FqLfA6xZxcN3QFJt
         z2BAQQvBQ4JFgbgCH+CqvANXbrYf+pChpLQWo3GZinxdSl61pahLShSTGim4zwVMHcT0
         hRmKLgf5MKfU5HFtRxuESrJsMmDPVEZ/UAUuiRBcsSL93bLrReQOfJJSvak3ow/J+akY
         t95A==
X-Forwarded-Encrypted: i=1; AJvYcCULjf9yPt0xKTaWgPfOneM3FzpIl9n07djI6gNvWqJdAxWjdKya5+yiAz6Od6kmAc5AviCdORo+DvWfiZmlHtUF8/6ZnHEuG9XNIA==
X-Gm-Message-State: AOJu0YyxAf+sO7hjf+aj8tZQ5jQaBkmoRH6h0ndk0xj7mjP5bDl3iUdq
	MQNvoNwzPTJSU1rm7Y8BYcPi6ob5Ttxym7e9pN7NyYk60UxUTz2174jKOEcnkTFN8MqCe6y38SD
	gbXAOXySxZRvn0Z/L4LMCKW2IlC/lmHKG
X-Google-Smtp-Source: AGHT+IHypYiwjw+HCvMDz/EgTlrL70fJ1Vb5av54OYHFAqNBkcq/KZ4fkWMkewMbZcksCFK2PXCZrc2lutlg5zgUk0E=
X-Received: by 2002:a17:906:5ace:b0:a51:adac:d6e0 with SMTP id
 x14-20020a1709065ace00b00a51adacd6e0mr1408519ejs.62.1713963098783; Wed, 24
 Apr 2024 05:51:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1713866770.git.lorenzo@kernel.org> <497dc9dad823fcd1403ed62ba164dd7d70f31f90.1713866770.git.lorenzo@kernel.org>
 <ZihJfcmjoJZwLofz@surfacebook.localdomain> <ZijZwXCHbaSEyAQL@lore-desk>
In-Reply-To: <ZijZwXCHbaSEyAQL@lore-desk>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 24 Apr 2024 15:51:02 +0300
Message-ID: <CAHp75Vdf9_-KDLkm2jmkpM=pw=U4nnwYf4dKn8xg=N+DpFYXTQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] spi: airoha: add SPI-NAND Flash controller driver
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-spi@vger.kernel.org, conor@kernel.org, broonie@kernel.org, 
	lorenzo.bianconi83@gmail.com, linux-arm-kernel@lists.infradead.org, 
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	devicetree@vger.kernel.org, nbd@nbd.name, john@phrozen.org, dd@embedd.com, 
	catalin.marinas@arm.com, will@kernel.org, upstream@airoha.com, 
	angelogioacchino.delregno@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 1:07=E2=80=AFPM Lorenzo Bianconi <lorenzo@kernel.or=
g> wrote:
> > Tue, Apr 23, 2024 at 12:16:37PM +0200, Lorenzo Bianconi kirjoitti:

...

> > > +   /* addr part */
> > > +   for (i =3D 0; i < op->addr.nbytes; i++) {
> > > +           u8 cmd =3D opcode =3D=3D SPI_NAND_OP_GET_FEATURE ? 0x11 :=
 0x8;
> > > +
> > > +           data =3D op->addr.val >> ((op->addr.nbytes - i - 1) * 8);
> >
> > Seems like you wanted to have always the same endianess and hence can b=
e done
> > outside the loop via cpu_to_xxx()?
>
> sorry, I did not get what you mean here, data value relies on the loop
> iteration.

  u8 byte_stream[8];
  u8 cmd;

  cmd =3D ...;

  // find what suits your case(s)
  put_unaligned_be64(op->addr.val, byte_stream);
  for-loop {
     err =3D _write_data();
     ...
  }


> > > +           err =3D airoha_snand_write_data(as_ctrl, cmd, &data,
> > > +                                         sizeof(data));
> > > +           if (err)
> > > +                   return err;
> > > +   }

...

> > Why not utilising cleanup.h? (__free(), no_free_ptr(), etc)
>
> I guess we can just allocate as_dev and as_dev->txrx_buf with devm_kzallo=
c()
> here, agree?

If this is a solely part of ->probe() stage, yes.

--=20
With Best Regards,
Andy Shevchenko

