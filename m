Return-Path: <linux-spi+bounces-3918-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28098939243
	for <lists+linux-spi@lfdr.de>; Mon, 22 Jul 2024 18:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D61F92825EF
	for <lists+linux-spi@lfdr.de>; Mon, 22 Jul 2024 16:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E685016E870;
	Mon, 22 Jul 2024 16:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZT9NtxD3"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F88916E88F
	for <linux-spi@vger.kernel.org>; Mon, 22 Jul 2024 16:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721664367; cv=none; b=Kuj+oJgZLz3kYxW+49bejlPH8kaT1akheWx6FckH2+EPWNJSEYHPabPVC8bw1xE8DsaiQZdatt1eLakKOuQSqOGBNafkDdLG/hEnMEMZk9kWcaJj2vNkJFtbPbUAeHA/bxoebM21VAQd4rX3Hmvvegr1N9oRxFkwAOAu4NJ9veY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721664367; c=relaxed/simple;
	bh=yX8s5ckqkA+tmDQRyK0eydul/3vH3fqS4T3avsDFFDo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NDjraPhUU0ud+35TjmXWdxCGo9TVVSwYO+h+R8zM63ogPv1yWdsnajXq4SK2PpDOAs37TERorcu+BWuqG8dYWZM7tT1u8hTxlQtr/euvhFlfWExxDtr/a3J3NKJR8dSDYYTW11ceMzCKcYpnQnbjQb8BgmvNTjxZu0v2ClqM744=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZT9NtxD3; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e0878971aa9so1413659276.0
        for <linux-spi@vger.kernel.org>; Mon, 22 Jul 2024 09:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721664365; x=1722269165; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l77jSYybQoKi38+B80qfMYfJS9baLUBLOyUXFrvfZIE=;
        b=ZT9NtxD3bPSxhsji5jAiq4/Y0uaaJ4/RGSgvYhAS/BtwBkHke6FNr3nZYwC/FfPkmV
         Eootu4FF5pmfEXeJAiZGIkDC4EpicqCoBPt1hAOResjXGwuUQTX/cIVWt7zciqtCGUwD
         pEyecrnXBCNKnMYWO9Lv66lXUFNCjpaB4Mbq+8hAyDVxoP+RzKpPI8L8aVBplQrXn4Aj
         wYrcQEIL+MlnQ+8vjr1loOw1ixutvehyhNOrfXTH/vwtYvam1t34QH1E3GDl4n/3E4Ur
         OP0mgoQJ99EZKvorcomtZWaVjIX6JF+tmpjx0SfGZFhG8e+nUtdcsQapgOlshqCahSpg
         fZDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721664365; x=1722269165;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l77jSYybQoKi38+B80qfMYfJS9baLUBLOyUXFrvfZIE=;
        b=w6GNuDj8Q9HwLo9oi8GsRONR5jqLHtxqtgbdJm+QpJEI70Kj5ItTHaJGSp451zSRn+
         7L9OAHPFbGtpSRozk9YeKDxfrTyVFlYqnxphYe1qKjs6Og1H/ao37WSIk+CcLc42M58C
         Ha6zKKGbod7CEJJQmlhGi0ST26YxukV46jek1L472vhYIiUwPO/DVymP1+XeG+t3xrac
         S32KdUpShn+f1jxXDsGFLkCL2F5Rr93RPDU/m+rrcJGj8QsfDdvK/46mWA7DNWqYbF1N
         YOLSufRegaIlECEBA6jJGBgFnuxNzOWvkC3Bs+NmHRTxY8S6bXIvYEBpV9QhW1Chi2NP
         5WKw==
X-Forwarded-Encrypted: i=1; AJvYcCXTwQuuE1RKJzFgUSGLf2+U/BVnyY/SPEND/P75BGnqx4RCOaWGkaaWx7Yj8JHt8vE95z3L9c+kCVlQ1Ld5sC+iM+qNw8znCMsz
X-Gm-Message-State: AOJu0YxcqVJX9XDLAtffhdjXIsFYT/Vo3hRdpNKVKuOYt63e8renTfoy
	lIijlyYHKL64OEee04ksAzHMjFHzXpAUIDd9nRnaoNaPrmakMGRtSsk+t0JTySgzG51RQopsm68
	0R/72i3/roT7KbQoqgqUmbWEYe7F4Gh2vcinXFvg/jsfsZeo8Q/g=
X-Google-Smtp-Source: AGHT+IEG9SkUvJgZIdWtaf/EFjPpmxBx+1aNx5IoS27Aunm/PI/GhuSsGK4x2MLGLXNoDyTHQlooZdORQO200RrHaC8=
X-Received: by 2002:a25:4a83:0:b0:e03:a2f6:6787 with SMTP id
 3f1490d57ef6-e05ff1ea636mr9827351276.10.1721664363508; Mon, 22 Jul 2024
 09:06:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240529-dma-oops-dummy-v1-1-bb43aacfb11b@collabora.com> <ZleYXoesgdAboMoF@surfacebook.localdomain>
In-Reply-To: <ZleYXoesgdAboMoF@surfacebook.localdomain>
From: Yongqin Liu <yongqin.liu@linaro.org>
Date: Tue, 23 Jul 2024 00:05:52 +0800
Message-ID: <CAMSo37X1GRUtuyHDL5GfQAqbH8EVjgAWR129D3uTF3CRPpLKPQ@mail.gmail.com>
Subject: Re: [PATCH] spi: Assign dummy scatterlist to unidirectional transfers
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>, 
	Mark Brown <broonie@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, kernel@collabora.com, linux-spi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sumit Semwal <sumit.semwal@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 30 May 2024 at 05:04, Andy Shevchenko <andy.shevchenko@gmail.com> w=
rote:
>
> Wed, May 29, 2024 at 11:42:35AM -0400, N=C3=ADcolas F. R. A. Prado kirjoi=
tti:
> > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >
> > Commit 8cc3bad9d9d6 ("spi: Remove unneded check for orig_nents")
> > introduced a regression: unmapped data could now be passed to the DMA
> > APIs, resulting in null pointer dereferences. Commit 9f788ba457b4 ("spi=
:
> > Don't mark message DMA mapped when no transfer in it is") and commit
> > da560097c056 ("spi: Check if transfer is mapped before calling DMA sync
> > APIs") addressed the problem, but only partially. Unidirectional
> > transactions will still result in null pointer dereference. To prevent
> > that from happening, assign a dummy scatterlist when no data is mapped,
> > so that the DMA API can be called and not result in a null pointer
> > dereference.
>
> I feel that with this the da560097c056 ("spi: Check if transfer is mapped
> before calling DMA sync APIs") can be reverted as unneeded. N=C3=ADcolas,=
 can
> you check that? If it works, we better revert the unneeded checks.

FYI, just tested based on the Android Common Kernel android-mainline branch=
,
with only the following two changes, the issue is not reported too:
    9dedabe95b49 spi: Assign dummy scatterlist to unidirectional transfers
    9f788ba457b4 spi: Don't mark message DMA mapped when no transfer in it =
is


--=20
Best Regards,
Yongqin Liu
---------------------------------------------------------------
#mailing list
linaro-android@lists.linaro.org
http://lists.linaro.org/mailman/listinfo/linaro-android

