Return-Path: <linux-spi+bounces-3909-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B9493793F
	for <lists+linux-spi@lfdr.de>; Fri, 19 Jul 2024 16:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA1981F22EF5
	for <lists+linux-spi@lfdr.de>; Fri, 19 Jul 2024 14:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69845383AE;
	Fri, 19 Jul 2024 14:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I0WJdU42"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC7CBA20;
	Fri, 19 Jul 2024 14:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721399918; cv=none; b=mW1nWd7tBcz2NYtg4bLYS0cwNNhc5Y5Cp+RJ2i08BjlIDMbgbOhVh73oGmk5/nZUrIE7ArRraEJxEHZsE0qOdwza5xX3JqA8VfffX3mBVxKsGm0ddS7OcvMuU1v+bnSkDm1EzNY1M1XvzXoCpeWc2eUZd938mtvzBYZS2uq1DLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721399918; c=relaxed/simple;
	bh=TNzI3O0yy78NOoIK5RtxjRq6sE5XlidG4AdXuNXlltc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MNrgMxF3qQ98QCJHDYMdm58pym8HAkkgvsfCIc8Dfmw4b+MX9CYwFbef0rsmRO9xwk4G8owYGTrSm1NOuoaAftZPSY+enjNMPVEATmwp+OPgrDw1aWfAB3SwzeEnMRFA3/7Vg1+Y32Yg/7P2dFDzxnfiPcJq4I1NW89vaYjUmOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I0WJdU42; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2ee871fd456so2580361fa.0;
        Fri, 19 Jul 2024 07:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721399915; x=1722004715; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TNzI3O0yy78NOoIK5RtxjRq6sE5XlidG4AdXuNXlltc=;
        b=I0WJdU42DvvdNuabzqrQ/28aiSLMlCAbRx2LRY5eaOgPS0lBN7gVLJ6SMGLF3fw1R2
         sjjOw5X06B2QQuM4ZQu65y7q0rddXjWQ7xOkug7lNHsM9f1Xn+x9+eMuPOSJZ6N13Oej
         peF5rfBJEVbXbs51CF2UKPIIUc9phEPbFc/F4KFpV40L1Vkp9G9m3BEEmYT7nzNt7/Yx
         cJsTRuKNO8fYztUR3la/Qe1EYTktPIMfKon6t02+/84qIRLb1f3McgKUQMkIcZkI4FfG
         Ml+u56MULKXXIUVYJu8ktZd7XAHnL8NwMZH5z52Flk2mFndVRT5a/tSKI6PSyd9Ns530
         EdBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721399915; x=1722004715;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TNzI3O0yy78NOoIK5RtxjRq6sE5XlidG4AdXuNXlltc=;
        b=QwDCZpHFmCahldr2JLsZXSvAjj/o0vCIuhcPAN7H9WH0eHjNu7bxr9jx2+Ys2Rk1yo
         KLIs45oJRjV9p1raISaqtt9IeNkocTm3Te+WXOOrCsuXtmMksTu0pOIFp10MKmwiUzlN
         tVnnwxhqjRj5bvQyft4DuloQnzNz4uOoKG39bWIq0HJCR+3s0yMqv/c/CGEShTsv55dU
         1DGa8GPmZA+92a5lf8KZxkqf464vAWgKCw9w03xMO12RmDq1YLkwARNuHrdhKVLdzXFn
         5pfixMTOsOImnmaJUGQf5h5FYDE+O6305fRpJ9j+0aTfncLyoW/NGKANaGaLYYVIw2Fk
         jDdw==
X-Forwarded-Encrypted: i=1; AJvYcCVzvOZZVogoX82JaccMGch1pm7QwmFdX+B56mTkFuM5yOIU1Nt8BBfmYJNd5KlzKaiyJ94DXqO7X2PunxGFbvkO1JJ1SuClTKSAXqTftPQwMgLqdtDbc376S7F3ksEyPjNVJ8x3pw==
X-Gm-Message-State: AOJu0YyPPrJ6YDoP3OV2+/tIi5LbLbMbkcVSvU6P47BuvSEeY768rilu
	diFfZQ9PsSFdmClSjKwnMqd4PtCB1sxQAVqI1ZXxjH0IG3bz8mSaY5g2d57K46HsLFZbphICC86
	CGsaRZolL6MxkaS2gBxTnEixmoerlDw==
X-Google-Smtp-Source: AGHT+IGvLhXzUqfZi5Ac96zTSjml5Dmj0OwFZ6wRoJNzXFT+GVVoAbqLZFju7YhZ5YvNj6s4GjbB34ciYuEaiwgbWl4=
X-Received: by 2002:a05:651c:a0d:b0:2ee:fac0:2af9 with SMTP id
 38308e7fff4ca-2ef0d67ddbemr13284261fa.6.1721399914440; Fri, 19 Jul 2024
 07:38:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240718200540.955370-1-festevam@gmail.com> <20240719-clunky-skintight-7dde4efd7cb7@spud>
In-Reply-To: <20240719-clunky-skintight-7dde4efd7cb7@spud>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 19 Jul 2024 11:38:23 -0300
Message-ID: <CAOMZO5BDh4RZr7n5J8HKXnfhVVPK76Rfp2Q55d4N=7ToAkoS2g@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: trivial-devices: Document elgin,spi-lcd
To: Conor Dooley <conor@kernel.org>
Cc: broonie@kernel.org, linux-spi@vger.kernel.org, 
	otavio.salvador@ossystems.com.br, heiko@sntech.de, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Conor,

On Fri, Jul 19, 2024 at 5:42=E2=80=AFAM Conor Dooley <conor@kernel.org> wro=
te:

> As mentioned on the dts patch, this needs to be far more specific. Are
> there no markings etc on the panel?

I submitted v2 with a more specific compatible string containing the
markings on the panel.

Thanks

