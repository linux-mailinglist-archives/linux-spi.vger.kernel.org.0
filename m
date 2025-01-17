Return-Path: <linux-spi+bounces-6396-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19ED8A1521A
	for <lists+linux-spi@lfdr.de>; Fri, 17 Jan 2025 15:49:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B926188BE49
	for <lists+linux-spi@lfdr.de>; Fri, 17 Jan 2025 14:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7BAE149C64;
	Fri, 17 Jan 2025 14:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GcetBMnV"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B13C13CA81;
	Fri, 17 Jan 2025 14:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737125379; cv=none; b=Gu/uCo3yHmZz5z4my9szXbJJ+oO0/gIPSAIXcAXr2/VVmniwnGlA7ZZNIvlGQf+TAlneyePdXFMq4AqHSmAeM8iZVxkLaO+MapxJkKKMlFg6kaHsJQWvTfJd2S7YeqJ6u3pcfhJFfqGbsQK4CA9eh6atW+f+qOZK+C2srlovJ8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737125379; c=relaxed/simple;
	bh=J7NtJ/2CGnRPUrqXAzSrynFAm0A1v3zdhB9kY4SE/QQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hHrCzB7YdBaGG4OxldbUkkPqQ+U+ln8MO+TYB2iOkoAB9858KAbzwdijSqEDwO6mPSFlr37vKsqwufBx6z/nhG0W4Rn8Vk9XAeoL6Bs9ISMyd4MrUI+VMPcg+wNpmLMiKy/ztbs+VSx8FDF5c4ObxJjPt1SJR5RktR4jSWvVvjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GcetBMnV; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5d9837f201aso5945682a12.0;
        Fri, 17 Jan 2025 06:49:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737125377; x=1737730177; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=J7NtJ/2CGnRPUrqXAzSrynFAm0A1v3zdhB9kY4SE/QQ=;
        b=GcetBMnVOT15+AuEstLd8YLV5kiGBrFQIHxZ8mMLZNtMDD5/VOYT8Ja8hq49EofFR1
         5FER1GkjxC5Rs7aonCXhwF8X9ydRBDHTqFYBTgozi8Pa+bDI0mokuR8GA19hy+MN3yx8
         1l/qcQn3JTQOMlhYaIXa4RblzK38RRRrv6CbEW6u7lBx2H9agEtjWLkgHXnW/bT+L6Qu
         q7ZKeLpoaXgBczkRPbKijClk5SVX8Mw4y04F70SU3m+lvgtBLtSZzYbL73wDicmVfjCM
         8yLMhz5viawzd8xha8Lz1zDcznAqD5keG0kczGLJLl17oz8wkB4R/yxNNbMb7Yp3tlfW
         ZxnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737125377; x=1737730177;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J7NtJ/2CGnRPUrqXAzSrynFAm0A1v3zdhB9kY4SE/QQ=;
        b=mWotP274uTHjbmJFJVa45tFRUBezW4029tSHuezXJKFAQuDC3pbCMkQ0GFFBxO2SQg
         aOm5BetNQrGwWaFeDWpUeMCft/oYY2osq71mu0CZsMcISHezTdG+e+hx+smEf0UzA3PE
         3BKBPHrnwTFuSNgYW8tyW+n7fdlwVQru9J7L4J2IJAtUnTUjbcwzbjoWM7ajJK3kGHuc
         DL2bd188rah7O7QtMDFU1KeEx5WdM0kFvzCCAUEkgXEVVql64sPIq+GatYUPGxfYZS9u
         hTpJZA03T/F1ZxYEPBN+c63E7+0H3UsaPvx+FGdJTKB/Tx0O6FXjXG4rNc+JIsVn9yQD
         Rr7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWa4y4O7Lssnw3Zip+NlVv3ybPtpAz5piVVlrhM59DjvN+MajA621GwBOyKARyuR28YwP4WACTwqCo=@vger.kernel.org
X-Gm-Message-State: AOJu0YztLYypFdzhRugxMMmoLgv5xp9xVTGDiiXEIahDR5x0GNZ6MkeA
	H83+nKvzHjhyvh1xf2xZuYLOyLQwibVx1C1gbs2QhnyHpfMIHEWln3Zlfln4iUhu7MEb2fr9CM/
	6lqvS7bFcF9iXbyUByVYtgCGPPBY=
X-Gm-Gg: ASbGncshjxORRIrDEGGje1+r4nfarsM+8D7iXakW9spW2QgRe7oF6YBgorBh0y0Zcl5
	oKGnm142g9Y33pd6gcT/Uu0lIb6BsjW4NLOH7ISEQ++3YkdQmIts=
X-Google-Smtp-Source: AGHT+IGpEcOBlkQvfFQwR1IfdaH3ql+5HBvL7fnpTjZQnIXw+y5aVXFA9OTwVbCl4BUwqlz7q2N78jpEoIqUI049McU=
X-Received: by 2002:a05:6402:3514:b0:5d0:e9a8:4c96 with SMTP id
 4fb4d7f45d1cf-5db7dc6a1d7mr2569157a12.9.1737125376429; Fri, 17 Jan 2025
 06:49:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKd8=GsoKj5eG6VAMkrxMbzNyoBX=JiwafrfXman8xMNK+XU_w@mail.gmail.com>
 <2025011703-erupt-oblivion-82a0@gregkh>
In-Reply-To: <2025011703-erupt-oblivion-82a0@gregkh>
From: Lars Pedersen <lapeddk@gmail.com>
Date: Fri, 17 Jan 2025 15:49:25 +0100
X-Gm-Features: AbW1kvavePghQR7w76HiBZJJQWzrG1w3Qh6lfSk_xp_TBweAsK6Fg0BTdYxCGGM
Message-ID: <CAKd8=GtrnvEgZv4y-UYNTJWt0oU9zLxZUYGnm9__H2yXKwyOGg@mail.gmail.com>
Subject: Re: SPI regression seen on ARM am335x in kernel 6.12.8 and 6.6.71
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, regressions@lists.linux.dev, broonie@kernel.org, 
	linux-spi@vger.kernel.org, psiddaiah@mvista.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 17 Jan 2025 at 13:32, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Thu, Jan 16, 2025 at 03:21:13PM +0100, Lars Pedersen wrote:
> > Hi. We have discovered an SPI regression when upgrading from 6.1.99 to
> > a newer LTS version. Same error on kernel 6.6.71 and 6.12.8.
> >
> > I think we have identified the problem down to the reference clock
> > calculation that seems to end up to zero in the spi-omap2-mcspi
> > driver.
> >
> > Also we think it relates to commit
> > 4c6ac5446d060f0bf435ccc8bc3aa7b7b5f718ad, where OMAP2_MCSPI_MAX_FREQ
> > is used as fallback on error. In our case it seems to hit the else
> > case.
> >
> > Snippets for device tree, spi-omap2-mcspi driver and kernel divide by
> > zero error log with dynamic debug enabled.
>
> If you revert the offending commit, does that solve the issue?
>
> thanks,
>
> greg k-h

Hi Greg.

No it doesn't solve the issue by reverting the commit. The commit
isn't the regression, but it attempts to handle it in the if/else
statement. Everything starts to work again if we hard code it to
"mcspi->ref_clk_hz = OMAP2_MCSPI_MAX_FREQ;", so it seems like the if
else statement isn't 100% foolproof (or we have missed a setting in
the device tree).

Thanks

/Lars Pedersen

