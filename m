Return-Path: <linux-spi+bounces-7924-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA6BAAC102
	for <lists+linux-spi@lfdr.de>; Tue,  6 May 2025 12:12:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEF771C21FF3
	for <lists+linux-spi@lfdr.de>; Tue,  6 May 2025 10:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A1927467C;
	Tue,  6 May 2025 10:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jzZ/PcHD"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FE914A639;
	Tue,  6 May 2025 10:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746526360; cv=none; b=f2xbY5X8x5anSDfE4aIyZo2cYfvZuD/eTjgfamV96wbwQkCqQkihX+QNFjKt9FQ4XLBPr+gkO9CmgdZX0I2uMJt9eK+Lmw/CsLdi3OVYaC0Qp0BmGdJc6DtmAgdx6zFaxBnbPsCbEXjwdrT0xWSAgTExMitf1fMbcCN9Z4qoqDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746526360; c=relaxed/simple;
	bh=jxey7fOb8z/w61m9m6UsbaUxtlUPK0mYVbDuoM+RGvM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YqrGc6oVadF+xTAPRUg0R9Y888xwc92Kg/gUizHmpf1lHqBXstLr/0rYxoRThizTfj6tPADN00Tc1lMEQzNlckGX0roCgN70hA9kN7DiaZ+yRM9QcjU26aLaUVzAXqNGPkjYMyHHnEsXfkp3YBVwqu+ESTLIvY5wbi+cACJvv6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jzZ/PcHD; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5498d2a8b89so6737036e87.1;
        Tue, 06 May 2025 03:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746526357; x=1747131157; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mJp0gvwl/+EohkZbSpkJbKg/JPMhDjkyhQTkFH9qrs0=;
        b=jzZ/PcHDMktjyLgO7jgMW+QxcLTcYVjnHYHI2j5xR6yb8dUn4c8c3jglxzathhYKnc
         AnNceh9OlUiTowJpqp9dx9S55f2PF86TIi/Ji8sZUi/mRQ4om91gEuWr33neTgKPx64L
         9Og7Oo2712Qmb/2i/KzP3UWiOerBJOUfD10BnFtv5RfuWOwhrGOiAdLU1nPynStRW7LG
         grWCOUoxzgy1HpwdjeX/3ZF0hj7nxIBSKJLqn9Yf1ovxa9JA0N4r5SNoU47tPDPqY881
         QbRewzXE/ZbYZVRm8vPyV83ys6O/a2KIIQ0qu1O4ZThS52YTgDbij3Aw77d4t9Vnxiq7
         ZqPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746526357; x=1747131157;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mJp0gvwl/+EohkZbSpkJbKg/JPMhDjkyhQTkFH9qrs0=;
        b=V1VPI1wvOdEeODTh1NEAa4YlQ/DW+3e0PZlirzUIuPjXZHM8r2SgPg4TWfSCK704Cz
         Lh3bmEXExt4t3tgSzXCzss9x1xyKypd5rOjup0homVf1AwkVzpnucSyI5lXBmixVBBJ+
         sTsu3nYgU3dQC3QHfcP11KvziWErGpZKAbodrKrL4dhvM5j4AYl8DWOHwyRyAQMbjmcP
         uFwE4CDhMxp80akrCmWcx2dSk+8AtwYYCeKIds/XNcUVF2mJVMlF1OuwyPUQ8Nnv2oSQ
         vYJF5546xqqtD+JIGmShtIFAyaAH2SpAqrN1i76gocTglIMfA5tMB5fY+iJaspJm8MZw
         Azdg==
X-Forwarded-Encrypted: i=1; AJvYcCV+bci/48+Yfu8GSRXg+LT9dp3W3wFHbBh4uancuHuKkov3iirPIsjRDKgKIvVWtDhs8fcfTBeW65fr1Tk=@vger.kernel.org, AJvYcCV4Hug4chSXVvaMVCIywFjDq7Dp+m/8xFNOACdtyFp8gJbpsWy5ZxtAOMem6ZnoqVKvF5TOQQKJ13njbGg=@vger.kernel.org, AJvYcCVtTeuX4X6Op+kyP5X1SSACgACIh/f0U4ePQWKWoGXxcoGEVLQjoS/qAy+HULsfXjsh2g/TFYmWZf3Q@vger.kernel.org, AJvYcCXu3rERdwxUYZYmoD+BZE8nm/rX/JqBZNfJ9UyJIt9AzH2L0H6geX746KP0oGaNdf6i54XOcjQ3@vger.kernel.org
X-Gm-Message-State: AOJu0YwHi+u0IwZ7XOex4BuWWaUrJtAjaCvkeUrV3hpOYvGrxoLdTfTq
	TMNGBzSl8xJEr53QN0WM0hlp+/gjmFfb/33fIM3GHC+8yUoctSR31XP/YPtmQysJQm0ZP1VgRYo
	2HvzREjniG9+ojszyow+xNVkpvD7dxDvmDm8=
X-Gm-Gg: ASbGncsSprmxBoTLAHyDq8beL03HLjGq1keSWszvdUCUq9Orpcb0ZdJrJvGIUP3ZBJX
	TwzQUnYgVMXoLXpSikysN0xP6Nxc/HGvGv8SaatQW1LXnFtvzq5PZJkrCo27T0Ea+zguAngXg0z
	pllKDIhtIryhMMK+SCgmOyRyc=
X-Google-Smtp-Source: AGHT+IEZ1gxTlLOfywqM5qJt0V6DfVuNiEdCu4F1a8cmHinv8fLmByAobF8BwxoJbphakrJv4LmyELLhW5VnjmOXg9s=
X-Received: by 2002:a05:6512:3ca9:b0:545:4cb:b25d with SMTP id
 2adb3069b0e04-54f9efcc142mr2725663e87.13.1746526356594; Tue, 06 May 2025
 03:12:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250423-spi-tegra114-v1-1-2d608bcc12f9@gmail.com>
 <00b119fb-1cbb-432d-a884-5b33696461e6@nvidia.com> <CALHNRZ928KN6ZBDzdGWyabSQw4Hny6F5RdqZ4hBUZosPZtni1A@mail.gmail.com>
 <ea5f8416-64da-4a26-8706-bc7ace502ad1@nvidia.com>
In-Reply-To: <ea5f8416-64da-4a26-8706-bc7ace502ad1@nvidia.com>
From: Aaron Kling <webgeek1234@gmail.com>
Date: Tue, 6 May 2025 05:12:23 -0500
X-Gm-Features: ATxdqUGR63m8acnNToPwMfN0230ptae2vEurQ4x2zJYJHAcaJlVza7b9HRyDsaU
Message-ID: <CALHNRZ9LUqTBf5_WBKVt1FR+aPrTk-HUR2jmgQMrWH8xjAHx8A@mail.gmail.com>
Subject: Re: [PATCH] spi: tegra114: Don't fail set_cs_timing when delays are zero
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Laxman Dewangan <ldewangan@nvidia.com>, Mark Brown <broonie@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Mason Zhang <Mason.Zhang@mediatek.com>, 
	linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 6, 2025 at 5:06=E2=80=AFAM Jon Hunter <jonathanh@nvidia.com> wr=
ote:
>
>
> On 06/05/2025 10:50, Aaron Kling wrote:
>
> ...
>
> >>> -     if (setup->unit !=3D SPI_DELAY_UNIT_SCK ||
> >>> -         hold->unit !=3D SPI_DELAY_UNIT_SCK ||
> >>> -         inactive->unit !=3D SPI_DELAY_UNIT_SCK) {
> >>> +     if ((setup->unit && setup->unit !=3D SPI_DELAY_UNIT_SCK) ||
> >>> +         (hold->unit && hold->unit !=3D SPI_DELAY_UNIT_SCK) ||
> >>> +         (inactive->unit && inactive->unit !=3D SPI_DELAY_UNIT_SCK))=
 {
> >>
> >> The above does not look correct to me. For example, if 'setup->unit' i=
s
> >> 0, this means that the unit is 'SPI_DELAY_UNIT_USECS' and does not
> >> indicate that the delay is 0.
> >>
> >> Shouldn't the above be ...
> >>
> >>    if ((setup && setup->unit !=3D SPI_DELAY_UNIT_SCK) ||
> >>        (hold && hold->unit !=3D SPI_DELAY_UNIT_SCK) ||
> >>        (inactive && inactive->unit !=3D SPI_DELAY_UNIT_SCK)) {
> >
> > This is what the code looked like before 373c36b [0], which dropped
> > that check because the pointers can never be NULL. Should this check
> > if ->value is not 0 instead?
>
> What the code does now does not match what you describe and does not
> appear to be correct. Yes checking ->value is not 0 would make sense.

Alright, I will send in a new revision once I can verify the change.
Since this was already picked up, is there anything I need to do to
get the bad patch pulled?

Sincerely,
Aaron Kling

