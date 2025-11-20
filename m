Return-Path: <linux-spi+bounces-11412-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 70EC9C74577
	for <lists+linux-spi@lfdr.de>; Thu, 20 Nov 2025 14:50:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CCD834EEB63
	for <lists+linux-spi@lfdr.de>; Thu, 20 Nov 2025 13:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4CB833A01E;
	Thu, 20 Nov 2025 13:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Cj/79O9W"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5B933BBDD
	for <linux-spi@vger.kernel.org>; Thu, 20 Nov 2025 13:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763646198; cv=none; b=fWdaH6FBya0q1dOKJl71VQ4s2VwzjzPV5I8icK2mwHDmnWBjlOpFgiz1QM/ZriXhpflya484sZSl60NLaZ4aOKgrBB5rx+DM95pfxBYAzacJJoHhzhs+z9DFXadkwzMaqxk2T1bigoA7vxBwKcm4YQM/5yK/d7AD3VWlZ39Y3QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763646198; c=relaxed/simple;
	bh=wa1cYreEuhPusWJYYO4Ix97DcBazcxezDPQ9b/FQHWo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R2ydH+KsUg6SxEyX7wVtZhun547OeoTRFcFVblV+Oj58Yi51uQcgTzWt38rGlT8gl/R+3NmzedID18m2uzNonzbMbHyW+5+qrrV3wHtVlIluR7miuhx8rMk2LTb4ZOWfQkT5TXpR1UynasNoG90WVrNaFCx9A/JqUgnaEKhenZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Cj/79O9W; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5958232f806so962791e87.0
        for <linux-spi@vger.kernel.org>; Thu, 20 Nov 2025 05:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1763646195; x=1764250995; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wa1cYreEuhPusWJYYO4Ix97DcBazcxezDPQ9b/FQHWo=;
        b=Cj/79O9WEhdKJxf//LRXUZc+Nylb6F95PCDszy30q8Fm2hs1lw+3y//OLe76LaEjs9
         W2aLun9scc7aQlTDrBqdVl9qgk2B7ZliCeU++iIRB4vWCwxURoBgN9FZmCdfiHbmH82b
         Nb4iRV21nY9kJ78OsiXKxkvQPdXN5e+4Nb6ISmx6avow1o2gmfjtQ3Tt3KJKCKUTLtEJ
         kDFh3jHRVoT+KR7MMlLSnkCweCu01NiTiGXXBxyaDoD9ZF0bHBnt58EMaaiv8plDfTbr
         t9L6vmqiqB28Fn9z60T2DAJ+pby7/JCLMTe//YiHEWvgbNXkEWVoqiip3tZnA9btYx/1
         RSnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763646195; x=1764250995;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wa1cYreEuhPusWJYYO4Ix97DcBazcxezDPQ9b/FQHWo=;
        b=vv3r30JGSErlSa2B3K8bA7+leQq5jWvfpayjWoUY5IXGZBC2Ozi/6MZE7XP9p8p2Fq
         +X9NwgfIPBsPOD5FtNPcgBtl8IbhaxHc60ESg7p77E4dN9aEO3zscCfjjev+6uSoZ3il
         uPogusmeF93BHz7DVTI4o3vsQ2Ildvvi0MMRASPt6DA3yOJFFWeuOd3h2QXKwYLCzgoN
         OUMxTyOX7nLdFwsM2UPxuam7Yb4OHNiwVVJoGIhB7zdSa6Ow80duR2IQl/BzZuvmJAfT
         /BwuFq0vPGz3L9OxTTlywfGC3EIEwVNuRQuCUOl0kVgrQv2mUP4y69wJS0orlg36qZox
         40Yg==
X-Forwarded-Encrypted: i=1; AJvYcCU8ZMY5i+bfT0ahMvn/4CvjUOT7qRdUQpfM8P9JeaOH9LvYgTqdR21fwHka9Hz8o8ucXPUYXHsmshI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzezAmnlpT6PaP71Kzbc5ud7SgGAGiChz5xNz19TufQkfk26y/A
	snRcydHlAqEj0PGojnpy+wuz7tKd5Ji3bbEkMEKjcprQxCi/vz4Ba4KJHjdr02+8Uqsfx3jk1hM
	G/r8JKN95cahVKQhN/vogG6eZbH3TMo2B0bOxb8OGlWa7hi954ZLQYXTstDFG
X-Gm-Gg: ASbGncskNK5RfSeeAbI6XyVGYFTCVIkLCLGZeowfOLWsb+rD9/sItqp0mwj3/oYHClC
	YZhP+KJVoOAjwebqOS/fMs8Te4GF+Fq42DsGbF991vsRrq7ILN3I24YBKteOrvhPC305V7VKneJ
	nzFHkC87a8p+KQ9ANzhzwhj0utqYykd8KPe9MS15GD5N3U/htu3Uq8Eah48MEzx0oqHbtZIHlAz
	qFa+R9bTDJNlD4Tbn+8aqvzet6kNw1NwpW6z7IHNk/AcJlxie1tAtWuCYrYXF9WiFSnBpK+j5LR
	dGYjlWd+Wqp77AIpmpCILivRsg==
X-Google-Smtp-Source: AGHT+IEv/hvofFpnwmg1EFFXAO0BKbZx04dZ7a8h59chxZ1fDoMYfsth8URZsqMBbgdoeiJHb2EE68PocBZxwM7RQPk=
X-Received: by 2002:a05:6512:1096:b0:594:273c:e816 with SMTP id
 2adb3069b0e04-5969f49a0ccmr721176e87.30.1763646195156; Thu, 20 Nov 2025
 05:43:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251120105907.1373797-1-ckeepax@opensource.cirrus.com>
 <3beb841e99f62767547054c4344f2c60eae4ed9b.camel@pengutronix.de> <CAMRc=MdJp8T2gZ=ExWCOKSaVqZqo4Dc2qAX0hXkx98ShUx3mjw@mail.gmail.com>
In-Reply-To: <CAMRc=MdJp8T2gZ=ExWCOKSaVqZqo4Dc2qAX0hXkx98ShUx3mjw@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 20 Nov 2025 14:43:03 +0100
X-Gm-Features: AWmQ_bmLUVCGUTc1rji11XbGDq5H_oq8sqkiig_6rGRBlDJnQgdBjd2YrcPQObw
Message-ID: <CAMRc=MdM-VCJQ_BwjHTNzRxipQPObOvz8K8NGRjy4k+5TDBpGA@mail.gmail.com>
Subject: Re: [PATCH v2] spi: cs42l43: Use actual ACPI firmware node for chip selects
To: Philipp Zabel <p.zabel@pengutronix.de>, broonie@kernel.org
Cc: Charles Keepax <ckeepax@opensource.cirrus.com>, linus.walleij@linaro.org, 
	andy@kernel.org, linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org, 
	bartosz.golaszewski@linaro.org, linux-kernel@vger.kernel.org, 
	patches@opensource.cirrus.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 20, 2025 at 1:27=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
>
> Mark: can you Ack it and Philipp will include it in the immutable
> branch with the swnode series[1] I will resend?
>

I've included it as part of v7 [1] of my reset series, please Ack this
one instead.

Bartosz

[1] https://lore.kernel.org/all/20251120-reset-gpios-swnodes-v7-4-a100493a0=
f4b@linaro.org/

