Return-Path: <linux-spi+bounces-2388-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A648A7C4F
	for <lists+linux-spi@lfdr.de>; Wed, 17 Apr 2024 08:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC7DCB22C94
	for <lists+linux-spi@lfdr.de>; Wed, 17 Apr 2024 06:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F26E5537E5;
	Wed, 17 Apr 2024 06:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LpsV1kuJ"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9154F1851
	for <linux-spi@vger.kernel.org>; Wed, 17 Apr 2024 06:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713335366; cv=none; b=BP2cQX9i/iId3A4/mEFRse76AzUxj/BCiT6CVPkXgVOaljQ0OrUta1paTTNMpqur6TGcoB9J8pgTON+39QE6KBKaY2YC430KNMp9hHUnIw0Ghgyv7Vf7zOtzzQ5HlzW5QWpf2TdZLn9/3EpjdT8363q/MOhdC6Cd3TKoL02og+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713335366; c=relaxed/simple;
	bh=zOuw1eJRYDZNmaVdVjGYIu581bMf2HS6hcsde8LTzaQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PKg+ARqyNpJva+f2Rh8hvMsDbfm+C5YllZeh0Q8DkPMZdywGZXNCLHg+hruPbaBAfWGRIDc0CEs2G6Qh+FqrBD4zV2ieBLdsEuXY5lDo4Tlw98+nXRYUm4nveRH2/AZVB4xmrkTwkComujFGcEP6TpiY1miQKS/N23YOP7Wt35c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LpsV1kuJ; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4348110e888so204511cf.1
        for <linux-spi@vger.kernel.org>; Tue, 16 Apr 2024 23:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713335364; x=1713940164; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UyngQvsvNX4IVjE6EtxACZNPOHV77/T++2RB3m9+N3E=;
        b=LpsV1kuJMLYPXRTYCAnuBPVjaC74V2HYUZOxWm4EMfnHIZZdKVQpI1CYfmojmI0zsZ
         aeRI0Zia6cthod57DF6kjhhmMaqlXIP+i4Twap4YQePJV3kiY6tL1NiALOtA/ZHIxuE2
         th2ZW5QgykcXDxOfOnmHIp0cIF2u3GIieYb0Jv5Lvn7bezZi0wHt25xRVPSEBdFE2tb8
         kX1xGMq5FjQ/4cjFPRdOY4lhxn+dG/zQViTbhpnbTGEyC7lBSIiJWb/n1zHLW+mGKvmy
         DPS6MFCsrZrn4pA1YMx37z102QALxM9mYgthr2kj48Kmv7ztOAOIFM5rUyx1FJk+DzEr
         vD9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713335364; x=1713940164;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UyngQvsvNX4IVjE6EtxACZNPOHV77/T++2RB3m9+N3E=;
        b=N2xnYu9/HN45AN1dAIkvZ4DpF0pa9BWiySunWC3YkNWtSe42jN4eG6rbgji7ABNN74
         LJGBu91Los6/Oc6fyrabFeBf1bPbcbn61YMvSW4Ewfw02m0PfIJeUf4aPU03psko6X2j
         p+0PwV9HZ2weX3Y9c6ac2CjyxnkvLB6LaDnIf4MgFCnEGxglX0Ln/bDq4OKqZXkOhjf3
         pBLtni/mm95gbvtoS0Nxa7ocsAiEsGNEgws+c9VGQ1ZAcVA+XqPtZdpSqxDQBieSboWC
         ZEBrs0Z6FcnXEHA9Y6bCxDsF5j/rIAZfBuJfEPwnBVHGjRpV7rWYUAj0Xuk6i2JGEGj+
         h/uA==
X-Forwarded-Encrypted: i=1; AJvYcCVKjS7/z6+Gi3LAgZgsTaZJRX4eb1gMTLROF9TU9E3fnpuPrJrzKcJY++fWjmDyShKU7WvMH23CpArTu61VEdtNhU1SzSIXmil3
X-Gm-Message-State: AOJu0Yy57EYI2KjRc7SWBoTbNEDb7hy1C445y8fxBVKrmPozRD5D4wip
	rCEp82QuDLfyyEV/RHRJnQlSx3XRbq8l8b72Eb0UhOeQdgq1Ph3JojzRodeW6oVTGYirHgPzgGB
	MhPgMUr63o3eZ5mVS7W0+j2n3Q5Vik0CgQAzV
X-Google-Smtp-Source: AGHT+IGHXQ5c36NdPnQ8e2OzYJ8YGPtp3VigSixmG1sd9NrQgjUSDxsXVn1v8tti2TbzQ+n3DGTVwYYT2xmvyD/Cdj8=
X-Received: by 2002:a05:622a:24f:b0:436:4015:1d82 with SMTP id
 c15-20020a05622a024f00b0043640151d82mr176693qtx.24.1713335364329; Tue, 16 Apr
 2024 23:29:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411235623.1260061-1-saravanak@google.com>
 <20240411235623.1260061-3-saravanak@google.com> <CAL_JsqKRVVNzgQk6PETfJ9RrDuzT1CTjHWW02Twc_T4C82t__Q@mail.gmail.com>
 <Zhx9qqiymJdXwYQs@finisterre.sirena.org.uk>
In-Reply-To: <Zhx9qqiymJdXwYQs@finisterre.sirena.org.uk>
From: Saravana Kannan <saravanak@google.com>
Date: Tue, 16 Apr 2024 23:28:48 -0700
Message-ID: <CAGETcx97QjnjVR8Z5g0ndLHpK96hLd4aYSV=iEkKPNbNOccYmA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] of: dynamic: Fix overlayed devices not probing
 because of fw_devlink
To: Mark Brown <broonie@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Herve Codina <herve.codina@bootlin.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, Len Brown <lenb@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	kernel-team@android.com, Wolfram Sang <wsa@kernel.org>, linux-kernel@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-spi@vger.kernel.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 14, 2024 at 6:06=E2=80=AFPM Mark Brown <broonie@kernel.org> wro=
te:
>
> On Fri, Apr 12, 2024 at 07:54:32AM -0500, Rob Herring wrote:
> > On Thu, Apr 11, 2024 at 6:56=E2=80=AFPM Saravana Kannan <saravanak@goog=
le.com> wrote:
>
> > > +#define get_dev_from_fwnode(fwnode)    get_device((fwnode)->dev)
>
> > I think it is better to not have this wrapper. We want it to be clear
> > when we're acquiring a ref. I know get_device() does that, but I have
> > to look up what get_dev_from_fwnode() does exactly.
>
> Or perhaps calling it get_device_from_fwnode() would make it more
> obvious that it is a get_device() variant?

Ack, I'll do this in my next version. Right now I'm waiting for Herve
and Geert to confirm this series fixes their issues.

-Saravana

