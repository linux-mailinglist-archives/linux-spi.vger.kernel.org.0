Return-Path: <linux-spi+bounces-9995-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 73988B53919
	for <lists+linux-spi@lfdr.de>; Thu, 11 Sep 2025 18:24:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C73B7BBD84
	for <lists+linux-spi@lfdr.de>; Thu, 11 Sep 2025 16:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 591B535A296;
	Thu, 11 Sep 2025 16:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RpRkE62q"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD94E356919
	for <linux-spi@vger.kernel.org>; Thu, 11 Sep 2025 16:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757607770; cv=none; b=eGQWwoMBvn7lsDLUvP006jfQ7KV5dXM16cmPNab+iLiFMm6kA6iHaaCGJLaWCkQUK131b4mc7q09Rfi2wnIUd0noh8FVGM5GO9L8HYsJwVAp33wghcnCNZ5MQtGDwbrEYygsIZiIefz+uBD26ydsq/GtXi2dhx4g+K7NM51erv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757607770; c=relaxed/simple;
	bh=Xu6ROB2iJBlOB3ife+XMQrejKQjN+28vFsRAOhZTeAQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q0WRFuF0zY67uIA1ZZyUi5cpLxUGvs7tWXlIEQNEeU8djMqtv1l4PTKBKl6cE2jHsdSUVWef7dsnDR8dZBhAgojg8XjCGeho3ONkLr3UZAmytB0ErRo2HUHdOxIWnjlNSdAV556piJI9U5e+8uhlLMKDC1xDQ0Pjbpv0AlH2QNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RpRkE62q; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-746d3b0d926so386039a34.1
        for <linux-spi@vger.kernel.org>; Thu, 11 Sep 2025 09:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757607768; x=1758212568; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Xu6ROB2iJBlOB3ife+XMQrejKQjN+28vFsRAOhZTeAQ=;
        b=RpRkE62qlrGIjXcRZs3oJfP13l4LU3O5HoicZLDK25K6AbfoWw0bSiXGVa0V7ZLT3G
         uDZ9bPK6GWcnxoNpuysiOXmohQbf25e7LdquLFEKrW2BSUnO733yAIlLFPpCuXnD6JAx
         NSQtIrh002IeEz4gl6otXdebV0kmA8U+pUSkphxx0sbIp/58oesnxU0Rh3MyTnmcKYXc
         WT9SqfhS5emcHMUyPnKMrWkXHhDHywgfc5t5rO5HOPB4pjdtzt9CSmDns5Elt6Gk/aJC
         Syj+vhbB37PtEORnhXQxmyH1C/RZ3mLAx345eXSVRWds+KUYT1msMSiOhGpxZOQOVAFu
         XS2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757607768; x=1758212568;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xu6ROB2iJBlOB3ife+XMQrejKQjN+28vFsRAOhZTeAQ=;
        b=CTFFYLNeG+/SF0zy/SwP5dBNjKXRAxHvv+LjAfEuPMSlc0mgRsYJFCI2R4VTDsF2tp
         W1pm8Ygsrw6Iiq7we7UvZeeI9Hq3iU+bnqY1n5sjIyApzpfAnBtV+6K6y0V0O0b9RgmJ
         ZGNZE/nJN+FmQKddbAaAWM2ch2iBO3aEBwFaYJB5ZVaSTJaBEpYtO6wDrL3A8zNfeX8D
         RWc8Y4GJ71LMoqsb7Md+CAFTqNCT2CIfHCdF1llWcYogJjynFHSC9f0B0Inqnf1SqG7+
         A4UoKdIGtUpdScuRWMozqbcKLD1jitGfL3uBbgspan+qfRvLpkNh0Q0bD591+FF+3tkI
         UWqA==
X-Forwarded-Encrypted: i=1; AJvYcCVUzO2Dpz4QEVAf7ZvNRH173PFge+BNPD1LAodxoDJrYqx3aAbJr1iDOIYq+7c2e63YCkpKJcd9EBQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa3PVLwsRRPPK8Y9zx+iUfu1vuGpNCHKG/+CxR4QHt22HhIcWz
	PbLm7Wi84rFL20uELYxZR7JHRex2by1g/Iw3MHTp7ivELfZv6lDZE9cmTYREBq836BE=
X-Gm-Gg: ASbGnctkyZsfvdqqS4IUMjRfHHh7fwRq20a95QQV0Gb3cpUcZuUBKYEA4uOceLa/8Np
	lK6Rn4axT0Dm7ysoq0+Zb9Sj88/LBQU0kmErk+ngjFG8E2FUClclAQxqsn4TVgb3X3UmLdMessS
	BZsdgV/Q5scfA9M72dU2PfqHsjF4861l99dEJfz7XWJskZuO6setb/wMzp6fo14ZsMfua0N5uA9
	a0mNcGvLoJjL3vjnwvAQmVtD5P3E8lGwdkvSxcyhKkboxr+CItprJIYBNsLTtpSQ2pvaQQ5HZji
	J1qVA3+lW6H89JbrGe7hOlSTamwcPoA5rjzGWMmVZiGclM7lxxiv3qQMW/qfyJ95Dy8zPEm3P44
	psoqBNXiBE6zynB8Rg3fASME=
X-Google-Smtp-Source: AGHT+IECctlFaz868hU/I7B6dJmVIqWLueZda9+UPQrP1OylkzpYavqojCcaxjupK+bo6Clm7vigeg==
X-Received: by 2002:a05:6830:3c04:b0:745:5320:c4bd with SMTP id 46e09a7af769-753552d595amr14583a34.28.1757607767743;
        Thu, 11 Sep 2025 09:22:47 -0700 (PDT)
Received: from [10.5.0.2] ([185.189.25.35])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-621b7bf520esm144468eaf.7.2025.09.11.09.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 09:22:47 -0700 (PDT)
Message-ID: <a34a18e85fcaefe0e91bf5ac69806e113099d3d9.camel@gmail.com>
Subject: Re: [PATCH 0/2] spi: axi-spi-engine: improve version checks
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Michael Hennerich	
 <michael.hennerich@analog.com>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>,  Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Date: Thu, 11 Sep 2025 17:23:07 +0100
In-Reply-To: <20250815-spi-axi-spi-enigne-improve-version-checks-v1-0-13bde357d5b6@baylibre.com>
References: 
	<20250815-spi-axi-spi-enigne-improve-version-checks-v1-0-13bde357d5b6@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-08-15 at 12:40 -0500, David Lechner wrote:
> We have a pending major version bump for the axi-spi-engine so to
> prepare for that, improve the existing version checks for feature
> enablement.
>=20
> Unless Nuno knows something I don't, it should be fine for the header
> file patch to go through the SPI tree.
>=20
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> David Lechner (2):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 include: adi-axi-common: add version check=
 function
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spi: axi-spi-engine: use adi_axi_pcore_ver=
_gteq()
>=20
> =C2=A0drivers/spi/spi-axi-spi-engine.c | 17 +++++++----------
> =C2=A0include/linux/adi-axi-common.h=C2=A0=C2=A0 | 21 +++++++++++++++++++=
++
> =C2=A02 files changed, 28 insertions(+), 10 deletions(-)
> ---
> base-commit: bbe4656eae2729b8ca87116defa19c568898d08f
> change-id: 20250815-spi-axi-spi-enigne-improve-version-checks-cdceedf356d=
6
>=20
> Best regards,

LGTM,

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

