Return-Path: <linux-spi+bounces-4393-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 86C1D9636B2
	for <lists+linux-spi@lfdr.de>; Thu, 29 Aug 2024 02:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9EABB20F22
	for <lists+linux-spi@lfdr.de>; Thu, 29 Aug 2024 00:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3EDA17FE;
	Thu, 29 Aug 2024 00:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cpf1j/Id"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209CD36B;
	Thu, 29 Aug 2024 00:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724890185; cv=none; b=M88ch+xUpkwGUr6Qoqgp2LGNwxAb2uR36U8/hkEB9sphujjVBwexExn/LRDFFhCxX7WJNrPeP0WeF5tinh5DVKXTAJfnOEUVD7wFmuoS7bFgWzUUn14a/t26S5gO/lhuIbhC1vF+da33UEbK5Tpdqlh6+alwa62u5pvXVnV1vVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724890185; c=relaxed/simple;
	bh=o95ewZ3193PUE/IWFiKo6g3FhPP8NEMPso8sbwn6+Qg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e0yGQfiFQUmQnGjUpcZTk0Sj58312qG7Srnlacd0U0HzcXKhC8XfjrDsbE6iVtbEnhidgIOMulfRwaKH/4AraBj5DTh0YV1WZL+zvWNb2r5es1u1KB4Q/NrZ8XuGDcEhd4lq0kAvuJD0Jjyr3HpbrWW4JKraUOADf3HT/+/D6Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cpf1j/Id; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-53346132348so46510e87.2;
        Wed, 28 Aug 2024 17:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724890182; x=1725494982; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gN6yIhTCjA3QrPDpmdn+bsDxDH53vL8zfxRzdxySUQU=;
        b=Cpf1j/Id/n4ph3A1chYJSzd05qgXl0F6XZ8cZagLSWUYdFpa+TQ8nZ+yQhdHhYbfr/
         c4/KIENpCxkkncHLSL+TTD/enJMectj6PFbLqgLKSHDkuY7Ngm+KEZTVThLPOX1qpi72
         MsyZEEBA+89UE4VCslSuus1PqPC5Qgszo/dyEvLuAvd/yviSTVQ61fv9Cvq8lVZGXQg1
         eGB7GofwteR/N1s9CwjMSksfn6QiEASuzvec8BDAhcWlQc7TrmlvmO/KWgE7v7NU37S6
         GQenUighOGEzCTAfOGq8jyXtqQq2i+Xhwhuvrg5qzpvZMrVuvSwGjAol/5kvi2oyEodL
         HDig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724890182; x=1725494982;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gN6yIhTCjA3QrPDpmdn+bsDxDH53vL8zfxRzdxySUQU=;
        b=uqVxZNfknEeENdmhsLJ269VcTmy0mNrdroH2QPH+NX6Xd4uXHvJIoTXmP7EB/7VEMO
         F6pYPFw4qgz+kFj23YkGIpfaCu/nebGZPUwzMgP9g5AhS28voUb7CwcCUcalhh33lRXo
         aI/g5ZZ/t5D3790SFd+195eWAY7tMfSILX3yApk8dkQXnAVXNV7renq/lCuFtanXGIwD
         Fq2w0bxhaTfANHlT0/K1BE/AVqVXQIJ+GAHGICw84wTy4lx7tcFR3UN+h9FAVrsk6TNh
         P7Hj7BOWHPBeD2zs02KwYcL5Lw3/NNIclFt9narK1dx7KbpGG/fUxxLxaXfZ1Ehr7xb3
         eDWw==
X-Forwarded-Encrypted: i=1; AJvYcCVydfjKhW0JemKMEEnumSqmyh5fcM2H75Ug/2A0Ps7J5OyQFt1wxsL7tILebSVZjVAYNDLjPj0E3V20@vger.kernel.org
X-Gm-Message-State: AOJu0YykRgv1+gdEoSmh8jpBA9hU3clkS7SJsNYC2yLRpjRbgjDsrbsB
	r4k1Uv7C6VfO8eIdhaFRfTSdldwFyzvCyqZQklRkvHkYnyU358x9B8IDD0v+jfngI4lZu0RC4Jg
	bjnlP5LLYoAIFa5Ko0UYyuQjZ8Ok=
X-Google-Smtp-Source: AGHT+IFE1KiGIgoYj51Id9U82AuNmglZTX4E9+uoQlEG3Z9oKfX849d9qWo9OxJ0LvBqJYMPgg7XFbbY5/9YLBPASok=
X-Received: by 2002:a05:6512:a8e:b0:533:1cb8:ec6e with SMTP id
 2adb3069b0e04-5353e57ccfcmr541883e87.33.1724890181850; Wed, 28 Aug 2024
 17:09:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828180057.3167190-1-festevam@gmail.com> <0d6314a3-75a9-4f21-947b-194eaf1fe12f@sirena.org.uk>
In-Reply-To: <0d6314a3-75a9-4f21-947b-194eaf1fe12f@sirena.org.uk>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 28 Aug 2024 21:09:30 -0300
Message-ID: <CAOMZO5Cjrj1V+qmheaOLkvn3gjQ5ocLodx5ijmOKha=FKpqoGA@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 1/3] dt-bindings: trivial-devices: Document elgin,jg10309-01
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, otavio.salvador@ossystems.com.br, 
	heiko@sntech.de, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mark,

On Wed, Aug 28, 2024 at 8:25=E2=80=AFPM Mark Brown <broonie@kernel.org> wro=
te:
>
> On Wed, Aug 28, 2024 at 03:00:55PM -0300, Fabio Estevam wrote:
> > The rv1108-elgin-r1 board has an LCD controlled via SPI in userspace.
> > The marking on the LCD is JG10309-01.
>
> Is there some reason why this is v2 and not v3?  b4 gets terribly
> confused about what version of the series I might want.

That was my mistake, sorry.

I can resend the series as v4 to avoid confusion if needed.

