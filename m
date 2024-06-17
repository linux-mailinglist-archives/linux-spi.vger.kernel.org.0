Return-Path: <linux-spi+bounces-3422-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29BC590BB6E
	for <lists+linux-spi@lfdr.de>; Mon, 17 Jun 2024 21:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF2CB1F216C6
	for <lists+linux-spi@lfdr.de>; Mon, 17 Jun 2024 19:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C3AF18733D;
	Mon, 17 Jun 2024 19:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MFKIAMqq"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52858D53E;
	Mon, 17 Jun 2024 19:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718654046; cv=none; b=rbSkDE0sVU5eO6euSYrolLEsUwR+Av/L2t+44/hZVhkYtqQp3b0BsI17LjzxjYM824dFvn8ExoTY2uR2Y/Z2+D0vBWmiID98MZd8loQWFelgucxBlW8j/bhPtdquemy79oVef1yuZXmIqU4XJNncATcB0Ap3K0XrQ+MU6t2+MKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718654046; c=relaxed/simple;
	bh=DQqHUJXrZhYgytXar68LbEUwdnDFVthmbJrH6f3+M4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y/agpu4Y3vRc6ITNvobP4h2Z735HAhwvGNoFACxXvJL8F80LCdGziIs/MPdW78Np/TZcj920zzoRSt1T1HtOpXVVMZafJS4J27vpSlljGYrzIDgRsaiVOqPavgZlAGpLl/ySrtq2RsEIIp0luTALZNPwRByzeD8chLyCzwft3xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MFKIAMqq; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1f6fd08e0f2so32843185ad.3;
        Mon, 17 Jun 2024 12:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718654044; x=1719258844; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DQqHUJXrZhYgytXar68LbEUwdnDFVthmbJrH6f3+M4Q=;
        b=MFKIAMqqwmrcPjpcJ2U8RsT1AxKr/SuiXdd7KTXDmHoP4kP3vv/DUzDuelGmoY+Uqs
         5lo9J5nSLTQv1Gad6i0e6gjVTGi4e8hGkuuRwxOw+mtExPAZGlwdR6lTLhTzSe6xe6lg
         7Smw5fOnCcOdxVg8k8xS/9gCtmFooX4m18uR/elYTqi5mU7w6Bc+ncrVhjLcZzjl8ShF
         1/d1EfR9Zt7lTc4t6KP8osin+b+k3Ygc1uh46iqLfoF2/TE+wI8gWfM7RR2wVCE4N+5u
         O3jNiDh/emkSxPRKaBDJw0McSnjBKLgwk4PsofdozxF6A+FHi9mKtzGZ/ATs6eirUI01
         ik4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718654044; x=1719258844;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DQqHUJXrZhYgytXar68LbEUwdnDFVthmbJrH6f3+M4Q=;
        b=DYS9b+LNmK+2e4bFkkH3WNnDudbXBuoucvlMnwTHXQdBKCcarK73IidZWiut4VmdPn
         bQYtrRFpqfwEwxTpiPbsXA7NMdMIq6rjgZMc37GhuS/szTfQw52kc98cIB5Ev7WmvwYA
         jhNyORyTe12cw0BYKOjkQGIS29NiCROKUjSJE5WeSVGlmZTjmzkPhApS9HsEH1SWlNN7
         V5N9Pmz232XdQ8PvIzixmJv/JBm7nQSVdDoyYwZB+637/Nr/opHygZpPCiyrbZrwLvxM
         nTuUGkT5Ybq/49ZXvKrp+oeI/DMSkNi/RjhmTgJbpFttxsTO+mg9poGf0OxsRw1DKTmR
         +s4A==
X-Forwarded-Encrypted: i=1; AJvYcCXVrM8/eM7CzWWK1U5aR2uqSMAPuulfYTKkndL+E56Fl3wIG8XzdOKPPGCe9wqm/ril2p6/s3KFt8mHsrk9ixqdq65F6rzewMuOcHYyPdJC4iufhfPD6wnmKpZKAfRoFSIb/V72eZzd
X-Gm-Message-State: AOJu0YwdUR1JDtHTmPguNkgfV6OF3VOIjoScjD+vMKy1BM2Ds4aGG8u+
	MDMTVV9/o6FCsPFdDLyeW+q1fI8y4lgEsAZkqYTS/TRuumDU3un6
X-Google-Smtp-Source: AGHT+IFk8Yj6XtGc1pOKgW/lQjPMWfBclQjaJyUFTViDzfBUzpvXdVF/37gf/vWTdCZAGxJnR/ittw==
X-Received: by 2002:a17:902:c94d:b0:1f7:1688:9e36 with SMTP id d9443c01a7336-1f86290073cmr124274645ad.48.1718654044461;
        Mon, 17 Jun 2024 12:54:04 -0700 (PDT)
Received: from joaog-nb (201-13-139-53.dial-up.telesp.net.br. [201.13.139.53])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e55ebbsm83370875ad.13.2024.06.17.12.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 12:54:03 -0700 (PDT)
Date: Mon, 17 Jun 2024 16:53:58 -0300
From: =?utf-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <jpaulo.silvagoncalves@gmail.com>
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Mark Brown <broonie@kernel.org>, Vaishnav Achath <vaishnav.a@ti.com>,
	Louis Chauvet <louis.chauvet@bootlin.com>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	joao.goncalves@toradex.com,
	Linux kernel regressions list <regressions@lists.linux.dev>
Subject: Re: [REGRESSION] spi: omap2-mcspi: not working with kernel v6.10
Message-ID: <20240617195358.v3ewnsu4jgkygvby@joaog-nb>
References: <20240612170030.3qatttsgrwjg2m5s@joaog-nb>
 <1b9852d1-4454-4f62-bd8a-fb6167dc0576@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1b9852d1-4454-4f62-bd8a-fb6167dc0576@leemhuis.info>

Hi Thorsten,

On Mon, Jun 17, 2024 at 11:29:05AM +0200, Thorsten Leemhuis wrote:
> In that case the thing that really
> helps would be if you could use a git bisection to find the change that
> causes this.

For me, spi stopped working in commit d153ff4056cb ("spi: omap2-mcspi:
Add support for MULTI-mode").

Thanks!

Regards,
João Paulo Gonçalves

