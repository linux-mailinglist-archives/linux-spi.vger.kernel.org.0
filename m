Return-Path: <linux-spi+bounces-2860-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D29C58C73C5
	for <lists+linux-spi@lfdr.de>; Thu, 16 May 2024 11:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62A1E1F23CBA
	for <lists+linux-spi@lfdr.de>; Thu, 16 May 2024 09:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 668F2143742;
	Thu, 16 May 2024 09:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gNxoKO7A"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD886182AF;
	Thu, 16 May 2024 09:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715851833; cv=none; b=HwF7HhKGSKx6xTvJDAytN0xQvmJ3rhCAmqHK7eYmB6YGkpBa4zjYnvxhQ6BOVKh+YAuTYbVWL2IszIJ7U9e9ExnZp51KsHrhBPSRKSDcQVu7abuASMXx8SgCGqAMjTUnLHBBMiG6KLThuqwF41JxTxcgZLPhx7LOagFw6iUT13o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715851833; c=relaxed/simple;
	bh=IwBN3sJvmL0IiVGBK5TPlcQXz3br6smbAIO5yeCkE28=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oq60BaLVw6XZrjsg67YZRCxmv5FJ3whrKBpmEEBxx44mShIVTGU2CvVE0YDyFen3z93qOpUig4i4p/+GyZGKizqkPudWAmmV7G7VfEsNA9IhMtdFrslaqVKkmg69doZxr8ZPpnpFbxxU+RsaFgtAk7U9I0nFk8COoFM7dEfLiBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gNxoKO7A; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-56e69888a36so3093150a12.3;
        Thu, 16 May 2024 02:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715851829; x=1716456629; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IwBN3sJvmL0IiVGBK5TPlcQXz3br6smbAIO5yeCkE28=;
        b=gNxoKO7Af/DzhFi5lw4OV2pUEXaIcXnGYesUy9xiZ79eLD2rRKZCkGwBeG2Gkxvi51
         fenZoe0PAc+v9C7rLviA7CLq+3/Y9V9qFOEcv4dmggjfmTolMSkR5p0dXMBtXxyRgnIb
         hadvTsK27yjAnI6j0fjYKKPo4R6ka/G1XZEfMikQ91Q52QkAt8oJi8sKZmEhteLb4m77
         acqM7e9IlF9JqaW2faobHKVxCb+bDIr9/nDRlpSTXPXD6ys8HjytQvZIjBwimABQUuDv
         sdkkwCCzq9e2+IvqrpA9842QXRHqVYst1BbakJp2RHs0e0xoYwEOdyzA5tkHSjG8/b1C
         TCWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715851829; x=1716456629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IwBN3sJvmL0IiVGBK5TPlcQXz3br6smbAIO5yeCkE28=;
        b=rhqv8qDifAkbzntb7lo8R3RBHoDEt02OmzpWZqhjC8ujo2GNYpP8Vw4pU9cJw99R4L
         ggik0DyvDOC3Af1nfEunUQiYwt2mbIpkSmFAb4IviUT6cOGbYGohUWTNvIiLlro8DX5W
         2DdCh9entA/PnDkZANa4AVPkb5tyx/0kZwa+p7ARH5NhAiVd0y7KyAreAGBa3fTloWi1
         gwPngW8OwcxciOa90nmkXAwiW6sOwmf0fAtwEJLE7zwAwhg5IDVtbMkptzTrxpM8xlst
         iEA53KR26iS94e7IfFbFKM6qWrr3Zm/WNFxeAVGkFaNUQi5zIe7rUajw+1z1KWsg3jzr
         aaAw==
X-Forwarded-Encrypted: i=1; AJvYcCXgcjalM3NP3I+9laDCfetFeZ6yivrf6Xhyd5YhfuWv8EniN1Akbg1hSOqyLvqfws55qiNptz/YeDqN3wK/tXyLLyKcN5K+jxwJPFqgSr0G2ldC4EAjoAwu5NB/GEt8zIz9F3PrnRVcbp5uV7Ky35gfz6DBZtRSjhFRy8BG4Q15vdo4Gw==
X-Gm-Message-State: AOJu0YzymsuD1lgpxCilvT3qCmtBlNdAjqxu/bpRc5v6JSg/+3gbcmSC
	R389L98mCHzqnYRF0jfakwTYz6n8mNrsGF0VP94RkpnOqCsAhPai9ENEO2XgGs6LLMl9nz+65US
	eXch88hJBGjelBJ0ISXZzFVPSysA=
X-Google-Smtp-Source: AGHT+IE8MdvP8pmcdxnyQcO8BxF0G/cG0jo0Lrv1oHAoEbj2FQdZ+/B7pMwFQ51oRL7Z8YOXQ2ZU0CQ2Vqbnk0Ig12I=
X-Received: by 2002:a50:bb05:0:b0:572:5f28:1f25 with SMTP id
 4fb4d7f45d1cf-5734d5c1692mr13027701a12.7.1715851829119; Thu, 16 May 2024
 02:30:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240514070051.2959-1-kanakshilledar111@protonmail.com>
 <20240514-sitting-ritzy-498d35eb5ac8@spud> <CAGLn_=vRDj_A2VpqQ6eT3OX6AgCfesA1KzJh+6djyF6MhAgEvw@mail.gmail.com>
 <20240516-encourage-bouncing-77e9c14c9887@wendy>
In-Reply-To: <20240516-encourage-bouncing-77e9c14c9887@wendy>
From: Kanak Shilledar <kanakshilledar@gmail.com>
Date: Thu, 16 May 2024 15:00:15 +0530
Message-ID: <CAGLn_=vpdnDaMoNNqnON5jBuq4LGtAq+gZm-W-f6H-PXQGMfKA@mail.gmail.com>
Subject: Re: [PATCH v3] dt-bindings: spi: brcm,bcm2835-spi: convert to dtschema
To: Conor Dooley <conor.dooley@microchip.com>
Cc: Conor Dooley <conor@kernel.org>, wahrenst@gmx.net, 
	Kanak Shilledar <kanakshilledar111@protonmail.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, linux-spi@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 16, 2024 at 12:27=E2=80=AFPM Conor Dooley
<conor.dooley@microchip.com> wrote:
>
> On Thu, May 16, 2024 at 12:00:29PM +0530, Kanak Shilledar wrote:
> > On Tue, May 14, 2024 at 11:44=E2=80=AFPM Conor Dooley <conor@kernel.org=
> wrote:
> > >
> > > On Tue, May 14, 2024 at 12:30:47PM +0530, Kanak Shilledar wrote:
> > >
> > > > Changes in v3:
> > > > - Updated DCO email address
> > >
> > > I was really hoping you'd tell me why you'd not used the same email
> > > address, rather than just sending another version. My ulterior motive=
 is
> > > that I wrote the section in email-clients.rst saying that protonmail =
had
> > > WKD issues with kernel.org accounts but apparently proton added a
> > > workaround and have yet to be sent an email that confirmed that the
> > > workaround fixed things. (I'm not sure that the WKD issues ever appli=
ed
> > > as there's no GPG key posted for conor+dt@kernel.org, only
> > > conor@kernel.org).
> >
> > Oh, I am primarily using protonmail and I am aware that there are some
> > issues with protonmail and kernel.org so for that reason I am sending m=
y
> > patches via @gmail.com address. I was trying out some things with
> > gmail and proton so had changed my signing email address to @gmail.com
> > apart from sending emails I have no motive on using gmail.com account.
> > Also I am adding my protonmail account in the `CC`.
> > Hope this helps.
> > If this is not the intended route then I will change it and stick
> > to one email address.
>
> I don't care what email you use for stuff, that's your business. I just
> want to know if we can remove the section from the docs that says not to
> use proton. Maybe you could send me an off-list email to
> conor@kernel.org from your proton account, so I can see if it ends up
> getting encrypted? That'd be helpful if you could.

I have sent you a mail off-list using proton. Please let me know if
you were able to view it?
There is a option to attach public key as well when using protonmail.

> > > The patch is fine IMO though, so
> > > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> >
> > Do I need to roll out another version with this reviewed by flag?
>
> No, Mark should be able to pick that up. There's usually no need to
> resend patches solely pick up tags, that's the maintainer's
> responsibility. If you're resending for any other reason, then yes, pick
> up tags.

Alright!
> Cheers,
> Conor.

Thanks and Regards,
Kanak Shilledar

