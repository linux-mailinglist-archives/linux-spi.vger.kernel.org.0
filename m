Return-Path: <linux-spi+bounces-11602-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C6118C8A712
	for <lists+linux-spi@lfdr.de>; Wed, 26 Nov 2025 15:49:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7C525342C32
	for <lists+linux-spi@lfdr.de>; Wed, 26 Nov 2025 14:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0186F3054C1;
	Wed, 26 Nov 2025 14:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WIPIsv9j"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC80305044
	for <linux-spi@vger.kernel.org>; Wed, 26 Nov 2025 14:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764168564; cv=none; b=kf+4gIw4XvMyIQzupE+KHOMd4ngctKOKLqL7/MesnRdRvEVjud5QrXdYo6hNk+/pwiOVL/gyLgSsrOSgXeCUgv75LK9K2yBsurEsqSaX5sKsoN1oOqUYTX1WzuRL+aKOlDey7IhYFYeVAK8Mp2+aHzabrpzO7uZWdWoF9yKuQWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764168564; c=relaxed/simple;
	bh=X90n4/xEsNNtTW5M+ViLnoEWViGG8uOjy8+up5i3LJo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VBf/MYj7A8AeLvg9Chb06Gc1rk2usiuEJomg3isZ0tNPrx5ocncdlL/kcpQp8j/yO5Wa/ZTwRXJ4qZ99AsBKOAhe0UwgHS9EJCp8MfS2vx1pW04ubZowVhloUtdqIUq3oNi6OnUft//JcvJivYqozHS1OFyvFxZK9DwOUlgrzdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WIPIsv9j; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-42b427cda88so4632730f8f.0
        for <linux-spi@vger.kernel.org>; Wed, 26 Nov 2025 06:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764168560; x=1764773360; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RR1JCp797O9wqgpyCvTsdnJYxWjCsl8jJjbbc9t7CdU=;
        b=WIPIsv9jcg72v0TnOX7Ovj5YHF/9ImpaIzbJXg34bTUKA/9EqRaeVIGVyVALsP6fPn
         52Ln4kLR6aBUA465gl4TnuhQRSUUuySm53BF6r6nq0h6+NnlmA9GaCu44aSlEDmNRZuO
         bbK4mrDlliwQOGYeBymZLvFOwOjkXOILWHJGE0PsKgDhRAHaEGOQpOTq2kKf7plAZ8IU
         400u5Eg2oFaCJLqGzjBTQcteHUXd4wnoGD1DDxq74VM1B8yAIhA0nMgzMzzrRM78uqNl
         4b31dgxzExOVU3kbSl7kmdfX4mQJ4kdAZZq2u1VTC6r642eucT3tqWiRwUQitmO46KN6
         lpeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764168560; x=1764773360;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RR1JCp797O9wqgpyCvTsdnJYxWjCsl8jJjbbc9t7CdU=;
        b=dQo2GCl5vVnMsheitfT4ItBS5PhdDXsMnN66w5SCBEVZfXMBNLg2tiHEjRnlWo5eKG
         c3zc9PNT5s09WF+EAlCXT92Ew+/MWRiAreXuTCGfApBfNO5ITGAJGvp+MMxEogtswniX
         QrslqDqIWfffhmh288spbP2t0NyVqpKVAnTl3QlnxXSFG6ba5FRYS1zT+hBUjlZgdZwE
         9UxQSUi4dWJheLJ6agqlbSoq2W6fD6EKlbhO7CB9xVL43SW8c2pmfMye/kq9CMgzFq53
         XyBX7XzzHQEXtIachwRWO0s6cXODYXT921QxDzaGqDysJnXAMQfOAiNDIX8oii5VwVxC
         96AQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCNkQtKkbJfjWrwG8KYTcZQgB79hskdSZkbmzxtofbALSgXsirVDABUm+lafe4zORw7xX63e8ljdE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDkcdxV8/uxxjEADzCM+/sm0lseC5D5GubDJkF+B/XmB7kZgLC
	J73ekDUMquwoJtrD69KInNIAeJsOYEMb6lkTkE8phvNxMlY11YYf4R+n6quRUBgmFltFonecxDd
	M3D5MGHHS3aSwtbm0nmM1vlIZpc8BRrwJKdApapg=
X-Gm-Gg: ASbGncuHo/hmt72iA2/3N7UPsWMafSbsg0ca4YMExPdg86EXokF7rggy1/lLUs6ZI89
	3khg6kW5VXeYoM2ISvvRZX1mOFpKCMIIZT0w97gG5qztKScg1saj4T/4kImbvOuFp617SXbBIT4
	+ubEUFy5tvD8RNo5nMf2XHztP5iWKVKGV7jJ2JvLE7ZJ8t+At7PuvkxW09jbtsNZZ6Pmhl4T0jQ
	udzL6CjyxrlikAnUKnuTq3WSwpMeIFsn7+u35TfJiHcB3m464iLQJrkg5BdUBh4higutF/fLzOD
	ditKlYtWqidrypaCm5ZUYyuXWPvM
X-Google-Smtp-Source: AGHT+IF5Rmaefo08E8uWq2fz5qazbUVyqew0MeAiJXekiHj02o9RunhH9RATwPSBkkzppcMA+GzGSjRvFEoUNvQDr3E=
X-Received: by 2002:a05:6000:288f:b0:42b:3246:1682 with SMTP id
 ffacd0b85a97d-42cc1ac93aemr19306237f8f.16.1764168559442; Wed, 26 Nov 2025
 06:49:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251125214529.276819-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdXD3f3jN2F7c+yHmEb1C5Byc-e=sEXt_s=UpBQLv_F=Pg@mail.gmail.com> <b3e31f95-fa05-4a57-8983-88f237240068@sirena.org.uk>
In-Reply-To: <b3e31f95-fa05-4a57-8983-88f237240068@sirena.org.uk>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Wed, 26 Nov 2025 14:48:53 +0000
X-Gm-Features: AWmQ_bm_CBLe2VBBiM6Kx1K4mZfwMTLznI-p9OWjk2jULfQ4JKiHB7yS_be1yyg
Message-ID: <CA+V-a8uT+Vpp=3eBEtYm4QC7pbFpebCWg=Obq82kXSknFMkXTA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: spi: renesas,rzv2h-rspi: Document RZ/V2N SoC support
To: Mark Brown <broonie@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-spi@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mark,

On Wed, Nov 26, 2025 at 12:34=E2=80=AFPM Mark Brown <broonie@kernel.org> wr=
ote:
>
> On Wed, Nov 26, 2025 at 12:38:28PM +0100, Geert Uytterhoeven wrote:
> > On Tue, 25 Nov 2025 at 22:45, Prabhakar <prabhakar.csengg@gmail.com> wr=
ote:
>
> > >        - enum:
>
> > Please don't bury the enum between two items.  Put it at either the
> > top or the bottom of the oneOf list.
>
> Can you resubmit with this reordering done please?

Done, posted a v2
https://lore.kernel.org/all/20251126131619.136605-1-prabhakar.mahadev-lad.r=
j@bp.renesas.com/

Cheers,
Prabhakar

