Return-Path: <linux-spi+bounces-2858-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A898C71A5
	for <lists+linux-spi@lfdr.de>; Thu, 16 May 2024 08:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3CE72821B1
	for <lists+linux-spi@lfdr.de>; Thu, 16 May 2024 06:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F991642B;
	Thu, 16 May 2024 06:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YGyo/1It"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2668BEA4;
	Thu, 16 May 2024 06:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715841046; cv=none; b=ZpuKo9OQqu5JdkZ3MERZBZZeo/brLwJVuXXHTWypNLthW4OgGQyqkNz3eoCwgNtC+1ACJo3ssxC+GebETDeqiQooZAFpwsvTDkotU4hs/6QModQnm4r0Eurr+ZfobtatpytKPWozPgxwdsxY1atjgaQ7dtaqErP9BdjavHOA/x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715841046; c=relaxed/simple;
	bh=fPBTd5uxchEoKW8l3r53TEJU9W7YylYMjqDXE+6TwOM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LqKhpo5YhOEySNdJD0Th8Hh60VI6+6EWlj3PTvKvrmf7LQC58xi5RF2AhI06SKjH7sQxXz4+Xb9Au7CZH3RiNheABDpVYATCY+4CUJPGscSfGouwDpjmQ48uoV0ycpIcgaGghUJBbk55mQvqHJviiG+bNmgFufcYizFL2sldjRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YGyo/1It; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-56e56ee8d5cso3181410a12.2;
        Wed, 15 May 2024 23:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715841043; x=1716445843; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fPBTd5uxchEoKW8l3r53TEJU9W7YylYMjqDXE+6TwOM=;
        b=YGyo/1ItLYuj2hyzDnDRuV59GUzprJWzCtlrLQFH/c2NeKR9b0kopjuUhXVmSqk8u9
         Gkj0EiUQoUm0ZReimx+8qzq/l4bPbUOOcWB66NzdmOmfkBcJJXHrvWzyDG5c2CesOU9u
         3dvHZ/4wKBk2VEPNa2ryJucvm8K+3ErKaGJBu6D7DIBbHFgrFB2svL5xs0qWe7MOtIr9
         RNi4IhOM4+hag8BK8Vkd+Pt+bk7qJNoskEsKjwrhNj0XUfQ3SwaX8I6nSWA+bfx/pdKR
         v7xhQ6Jcfuoh0h9MtsH4t+1vuuNUhpGnbZMUpD1cJ/g3Dc2PHE7lqwNl6nBg6J2bzztj
         Jndw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715841043; x=1716445843;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fPBTd5uxchEoKW8l3r53TEJU9W7YylYMjqDXE+6TwOM=;
        b=MTjwE9rrGMPJdQzg1gCjIlJ/EjTzK1X4SegpJ0P4u1Q8xK+9CFNoFCBmcbotQVtlev
         18cmnxEDJt1fwqDQHpp4XBNXzBpDX8avPn7JlSf1dvU3HWQbF0/xqgXBp7wZBhL4Cuzn
         c1QYKxo5+L8vrxTiMHVu6W0v5OSx6E/qXXy1rk/8p5oVHF7ya8uSW/U4CqPmpyzi2GjH
         MZJTK8dqzWlpfIDulFm1vnkfuu/juwWk8Rnx6Ghck6H9w3SjGPs/in/g7vtoC1Xmblzk
         +ZLxX93euKu/W9rYXwqQ/XKZ3CSirwLoASSp0wRCZ5VSwWqPN5c0i7kEH17n18myYETN
         fr+A==
X-Forwarded-Encrypted: i=1; AJvYcCVD0osy+y0y6pjvuaS1vG+eyP3oCScyU0z7B/9Xd5fPXHGMv/V0JnCTWNPcNQPxR/zEjEdZ9BcMQyw9uZG+IstGDqQyjTd+Y6FCHO7wtn0V9qydS4RxOUUMoayluAGJy51H9vDB5jvOsFTMoZOoSCR4ggODJiDNQ+18+WJi6oyi6qXTqA==
X-Gm-Message-State: AOJu0YxobK5fjNru35VEBx2bkW9rhFB5ygohAK1qHibOKyTxmsvA0PYh
	uoxJbauq5ny4hIowVQzNwtm4VT2MU26iV3ERXCqeQhT5+G0d8SWyfPGvO7PHVuVOprJ95ONib6U
	yFKOHSYIC5lDg6oXEbTvnHPMoc9M=
X-Google-Smtp-Source: AGHT+IFhgmhYlVWiE4ufjDHyd9xZdN6gQBkhsS2mE9DemOWlCtL7sx0LnvR5dhQJqSVcryT0279ac/Kf8iD7r7uPuCs=
X-Received: by 2002:a50:9f21:0:b0:572:6249:96bc with SMTP id
 4fb4d7f45d1cf-5734d67eea4mr13082226a12.32.1715841043205; Wed, 15 May 2024
 23:30:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240514070051.2959-1-kanakshilledar111@protonmail.com> <20240514-sitting-ritzy-498d35eb5ac8@spud>
In-Reply-To: <20240514-sitting-ritzy-498d35eb5ac8@spud>
From: Kanak Shilledar <kanakshilledar@gmail.com>
Date: Thu, 16 May 2024 12:00:29 +0530
Message-ID: <CAGLn_=vRDj_A2VpqQ6eT3OX6AgCfesA1KzJh+6djyF6MhAgEvw@mail.gmail.com>
Subject: Re: [PATCH v3] dt-bindings: spi: brcm,bcm2835-spi: convert to dtschema
To: Conor Dooley <conor@kernel.org>
Cc: wahrenst@gmx.net, Kanak Shilledar <kanakshilledar111@protonmail.com>, 
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, linux-spi@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024 at 11:44=E2=80=AFPM Conor Dooley <conor@kernel.org> wr=
ote:
>
> On Tue, May 14, 2024 at 12:30:47PM +0530, Kanak Shilledar wrote:
>
> > Changes in v3:
> > - Updated DCO email address
>
> I was really hoping you'd tell me why you'd not used the same email
> address, rather than just sending another version. My ulterior motive is
> that I wrote the section in email-clients.rst saying that protonmail had
> WKD issues with kernel.org accounts but apparently proton added a
> workaround and have yet to be sent an email that confirmed that the
> workaround fixed things. (I'm not sure that the WKD issues ever applied
> as there's no GPG key posted for conor+dt@kernel.org, only
> conor@kernel.org).

Oh, I am primarily using protonmail and I am aware that there are some
issues with protonmail and kernel.org so for that reason I am sending my
patches via @gmail.com address. I was trying out some things with
gmail and proton so had changed my signing email address to @gmail.com
apart from sending emails I have no motive on using gmail.com account.
Also I am adding my protonmail account in the `CC`.
Hope this helps.
If this is not the intended route then I will change it and stick
to one email address.

> The patch is fine IMO though, so
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Do I need to roll out another version with this reviewed by flag?
> Cheers,
> Conor.


Thanks and Regards
Kanak Shilledar

