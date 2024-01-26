Return-Path: <linux-spi+bounces-870-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B1B83E294
	for <lists+linux-spi@lfdr.de>; Fri, 26 Jan 2024 20:32:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA2EE286E25
	for <lists+linux-spi@lfdr.de>; Fri, 26 Jan 2024 19:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68083225DA;
	Fri, 26 Jan 2024 19:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DMYIKWJD"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D144422F1A
	for <linux-spi@vger.kernel.org>; Fri, 26 Jan 2024 19:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706297526; cv=none; b=dUErdqYiKP0KfGu0X0PNLSV8Di3n7bz9Quze6kHXCpdbaTcF5bt/8vNMnNLM5KXRy3IQ4aAmc06tNqQw/Rgm4Tyni/8TuITq9Ofonb8bahAWj0WuZ+VitMia/1SZWYYhjhktNcTrXdKr7E0z5zuwrGSPx56hkb0S9X7aBPSISBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706297526; c=relaxed/simple;
	bh=4bn/sB8tSLsIIPq6gl/AUEyattz3mYuuGWSOuaRmbWQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o4LHigzp05zQdpd1YGB9z3lQWkJd6Yp91HWvqsnUhl1X6NTxCbb/MKX0JnPldurHE31WOAsmq5OhMPgbYAXkzpWBwCrZZvzybHhwQusu78csb2P4FKO2C5p7I5JNqJ9L57iRkeh9CcGYMNDaPMTuwOKd/6vIJZx73Qjw8VMMr4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DMYIKWJD; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-29036dc3a63so459726a91.3
        for <linux-spi@vger.kernel.org>; Fri, 26 Jan 2024 11:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706297524; x=1706902324; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mq0DzuapwNb+at6/+GR6PN1NNqZZZWZopm5NTAYFnRg=;
        b=DMYIKWJDqTAOuFhNETjb8mZC6i1h+fNlcYZMfPJgLiYKSoD8DoLO0CKUOzLcGRdG85
         Rqewz9nU7w89gb8jlOr/KQdxN/oEdxkFOJwXrCbJmu+EjXgqgnbsBM6AbDlEQG5PtJRv
         6aqxB6GZkMxOL2XidhUFm10q2i8Gfr5xUH7SaS5mI3eYffAcgbJahxclw31Nw66YKq4y
         aaTh2gviG6RgOh/wduSVnrkAG/NWgjhgRzhvEjBqL3vpamU5xlDZro4EudclfLtA6B+v
         VAlLEhNND+PNSZ/opNarHyp+DheHKLq73dUOR0nuEB5nhfs1nY6YhPDNsCoLyaSjt/6Y
         vKXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706297524; x=1706902324;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mq0DzuapwNb+at6/+GR6PN1NNqZZZWZopm5NTAYFnRg=;
        b=cabDJTQ9y357DcJe4IVLTzsgFI9lsQBjt8vklkRAtm38NbHCH7siuFKw/Tu0xIHcvj
         zTkf5B5HBNz5/xidGZN4H2fTAUo+baJcaJuUlvXispBc2YSV5WLVgv/Y9mPIQ3MhayP0
         v8KjYkj/jKWx6BX/It9PxMLgUHaQBaMTUbZc0DESGWDlXyeXn0rsJPjdxRxnZyG5zxGd
         TINF9xyiH8PKXkxle9gMoqFbNf44+UkSgklhY02c838r/KhJEAjFyctKznxmuMFnzc+A
         6QKQ2A1GeehMsAXFF4Im3eyqyHxsDr3c11h642Eklnqvtb33LDI2RTxAf2sURg3vr+yp
         wWIw==
X-Gm-Message-State: AOJu0YwGhR0idmuk8tyzOj3FjIQ3wG6yck31vlDVbSmOv8XQpwqAcsPf
	tDlvgByF7WvbwlqdzpNkRyTq8l4xjxXdE0iYnxlOaigy0Ie3HLLq4uj+c7pPfrplFVCit94tjmr
	l71j9j9JQb9PughOC3rlsU+fY/r1NoakQ/E3Wow==
X-Google-Smtp-Source: AGHT+IFBa6CU0gSHmGQst+5z4PcIsnVzYeH5WRcM7mrPV+jhkrgM9ohuUe97W/fJAYEGMiqNHQkddJwK/+eLNatKOUA=
X-Received: by 2002:a17:90b:3758:b0:290:3b83:8897 with SMTP id
 ne24-20020a17090b375800b002903b838897mr515505pjb.40.1706297524016; Fri, 26
 Jan 2024 11:32:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240125145007.748295-1-tudor.ambarus@linaro.org>
 <20240125145007.748295-17-tudor.ambarus@linaro.org> <CAPLW+4mLWU-8H=qESe9csXm=e_ByvP=nc7MEJzknv+XAUjqUZg@mail.gmail.com>
 <36a664b1-666d-4fc4-90d9-35b42e56973d@linaro.org>
In-Reply-To: <36a664b1-666d-4fc4-90d9-35b42e56973d@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Fri, 26 Jan 2024 13:31:53 -0600
Message-ID: <CAPLW+4mPMBszTFcs_wUZgmksiRQ13SprQYYu3tShvkRXmZ_Mkg@mail.gmail.com>
Subject: Re: [PATCH v2 16/28] spi: s3c64xx: simplify s3c64xx_wait_for_pio()
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: broonie@kernel.org, andi.shyti@kernel.org, arnd@arndb.de, 
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	alim.akhtar@samsung.com, linux-spi@vger.kernel.org, 
	linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-arch@vger.kernel.org, andre.draszik@linaro.org, 
	peter.griffin@linaro.org, kernel-team@android.com, willmcvicker@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2024 at 1:56=E2=80=AFAM Tudor Ambarus <tudor.ambarus@linaro=
.org> wrote:
>
> On 1/25/24 20:43, Sam Protsenko wrote:
> > On Thu, Jan 25, 2024 at 8:50=E2=80=AFAM Tudor Ambarus <tudor.ambarus@li=
naro.org> wrote:
> >>
> >> s3c64xx_spi_transfer_one() makes sure that for PIO the xfer->len is
> >> always smaller than the fifo size. Since we can't receive more that th=
e
> >> FIFO size, droop the loop handling, the code becomes less misleading.
> >
> > Drop (spelling)?
>
> oh yeah, thanks.
>
> >
> > For the patch: how exactly it was tested to make sure there is no regre=
ssion?
>
> no regression testing for the entire patch set, I have just a gs101 on
> my hands.
>
> However, we shouldn't refrain ourselves on improving things when we
> think they're straight forward and they worth it. In this particular

This patch clearly brings a functional change. The way I see things,
the risk of having a regression outweighs the benefits of this
refactoring. I don't think it's even methodologically right to apply
such changes without thoroughly testing it first. It might be ok for
super-easy one-line cleanups, but that's not one of those.

> case, for PIO, s3c64xx_spi_transfer_one() does:
>         xfer->len =3D fifo_len - 1;
> then in s3c64xx_enable_datapath() we write xfer->len and then in
> s3c64xx_wait_for_pio() we code did the following:
>         loops =3D xfer->len / FIFO_DEPTH(sdd);
> loops is always zero, this is bogus and we shall remove it.
>

[snip]

