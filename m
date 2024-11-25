Return-Path: <linux-spi+bounces-5829-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF319D85D9
	for <lists+linux-spi@lfdr.de>; Mon, 25 Nov 2024 14:05:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A752DB28688
	for <lists+linux-spi@lfdr.de>; Mon, 25 Nov 2024 11:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBCA9191F7E;
	Mon, 25 Nov 2024 11:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m85SvOCY"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE69185949
	for <linux-spi@vger.kernel.org>; Mon, 25 Nov 2024 11:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732534746; cv=none; b=ITpkCrBhq5dwvzusRdwtSlhQe/1hqmSUtB1gq5uegawNw1cWKInIt9pgdlgSucon8MchQd63tnm0eb/Vsj9VWBdLAA2RGJ18p59eOxKf4/U9CbNOx1wkXzCbAFRvJMkpsgG97c/nIRkSNTMgl932Rz+1NpaXQvRAchvI+ZIJsOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732534746; c=relaxed/simple;
	bh=zVq1Xjn96VpYQiXEYLW3yS7kNqqzVELbO4IpQNcvagE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ef/ZwU2ptbpMxVxpMla1oqxJPcONW6IRRF2Lf3G62i1f7b8vdumub5k9HcUexS7q6neGPTfNGSN91Nc2eE1me13IF0lPvYoZbihxhdhMjKYEXmPfnOZf1AuCzj5fLAlUIbRsOCVju1dKhOps4F8Uf0MT3rMTXnuNkHZJqNAKjXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m85SvOCY; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2f7657f9f62so45910221fa.3
        for <linux-spi@vger.kernel.org>; Mon, 25 Nov 2024 03:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732534743; x=1733139543; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zVq1Xjn96VpYQiXEYLW3yS7kNqqzVELbO4IpQNcvagE=;
        b=m85SvOCYeiWurq/CjzSdIkS3tZG7q/ZXmHtfJg4fJkX6/7Yf2GwT7LAq9YptzEu6CY
         YyzrUY/27EAoseJCQdkE9WdIUe069JESwDcFqq9i+T+e0u7UhSKGpMDZPdYzusEx3FWr
         1jsdJdcllbjU1OF6s+PAa+WG2yO82RlPjOsm9ff9cWWhHr4lXUUyVM3hLF61hs8eCBky
         W5/iOpQf1AP4LWEnuWTobx70MZtwEkzNTZKiWrhxlymvEYl3HKQxtlsLQX5hqpbd6O0h
         b1yUl35sWRe1QaQwuFy7CirnL9PUAGqX017Ao4dZpYdmSSQS26eZ0V1NKBYp7/UsNkHr
         ArSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732534743; x=1733139543;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zVq1Xjn96VpYQiXEYLW3yS7kNqqzVELbO4IpQNcvagE=;
        b=q/nA0WqA0svgx/YfVnv5t0XzLzMBhWLdQmlD1pkphyzLGa952Ax+pMXGlSbyC0Zs9d
         cOlVIJ2mR1t5CoPg0WqtFR+CwVgqBlfez6Uj+YrNjm3UW35oi7qSGfcJzx8Tz7GJeoxr
         dScPqhVsaPhi9Bmb9VZnht2SGR9Pjo0KVgcTKZToBo0z+uzZW3NAyUqK2nclPSIV+aHH
         rtRXR5pUTRY2DAJVqxtvaI3t5O3iiTHu5+QYC7RNOwiJqPe0/cCSbnVNgxQCEOWHSZsf
         7Y7NK9PUEitC4cPLjPnYfT7iKckB0fotMz0kEt7kPZYNoxc0Tj8xIJJ1IW0fdvwFJ/Dv
         MzjA==
X-Forwarded-Encrypted: i=1; AJvYcCVTZHq2iVqdyMJ5+MNCTJsxZMFPV6o3dBFlTxAXwA288SYnVBx9OpcNaAVhfMm4OJuZ0tyFBdPBd9I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0jtx6aRBJHU/5tT7bEs0O41dd3Tc8T0wXlvsAEWeaJq35jM5F
	VGyvaStCG+6Xngl8f+lx8bDWah9y37R4+X3Z06wIGSsD1z5N4FnmpDkjWaFK//1+V03qPMqRFWz
	XXaaTrv1zt21w6j/9Z9rZeJ9D8cSpyqKl
X-Gm-Gg: ASbGnctU3s0mVBT3Xqnu4LX7T2of1Ewo9QUhSpMzha+F37R2mamXFtZN5Xzho9cIU6O
	+zgudRBl4zR4IymqUhk1mWhyDOjkY1E1cln/bkbn7nT4przpELWJYYp8LvC+xMyo=
X-Google-Smtp-Source: AGHT+IGdrwuYUNl3+JWDDdcN1z+AOqHL+NUl6PN1fNn4S4NF+AQc2bH1cVYg7V3LIE7XMcSeHwbw9Q0I+9GCDlNq3LQ=
X-Received: by 2002:a05:6512:250d:b0:53d:de72:f78f with SMTP id
 2adb3069b0e04-53dde72f85bmr2283436e87.14.1732534743097; Mon, 25 Nov 2024
 03:39:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOMZO5A5MxbKCnaoRo-ax+doTcEbu+S-bGoxcmYrA=eO5ExT4g@mail.gmail.com>
 <20221219200857.fckuqovt3xt5r352@umbrella> <CAOMZO5CyeHW_bNB+ow2=dxWA-6bg2Rm-vY3Wx4LGvu=bJ+fagw@mail.gmail.com>
In-Reply-To: <CAOMZO5CyeHW_bNB+ow2=dxWA-6bg2Rm-vY3Wx4LGvu=bJ+fagw@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 25 Nov 2024 08:38:51 -0300
Message-ID: <CAOMZO5CJ_XbXRQCMDdb6V4HC2DTvc71SzZXv2E_HjMoawaYurg@mail.gmail.com>
Subject: Re: DMA support for FlexSPI driver
To: Han Xu <han.xu@nxp.com>
Cc: Bough Chen <haibo.chen@nxp.com>, Yogesh Gaur <yogeshgaur.83@gmail.com>, 
	Michael Walle <michael@walle.cc>, linux-spi <linux-spi@vger.kernel.org>, 
	Adam Ford <aford173@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Han Xu,

I am resurrecting this old thread.

On Wed, Jan 11, 2023 at 11:27=E2=80=AFAM Fabio Estevam <festevam@gmail.com>=
 wrote:
>
> Hi Han Xu,
>
> On Mon, Dec 19, 2022 at 5:09 PM Han Xu <han.xu@nxp.com> wrote:
>
> > We are working on that, both flexspi driver and sdma driver need to be =
updated,
> > and will upstream all once done.
>
> Do you have some patches you share with us so we could try flexspi DMA
> operation on i.MX8MM?

I still don't see FlexSPI DMA support on the spi-nxp-fspi.c driver in
the upstream kernel and also in the NXP vendor kernel.

Is this something that is still in the plans?

Thanks

