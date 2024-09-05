Return-Path: <linux-spi+bounces-4649-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA5D396CCE4
	for <lists+linux-spi@lfdr.de>; Thu,  5 Sep 2024 05:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0941F1C223A5
	for <lists+linux-spi@lfdr.de>; Thu,  5 Sep 2024 03:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A5640BF5;
	Thu,  5 Sep 2024 03:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lvq9r3Wa"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B7F25634;
	Thu,  5 Sep 2024 03:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725505442; cv=none; b=WZC/O5mZQRuHBf82poSfrbMkG1887+tDGQ+RsuFvkLN4mD06ePo+pXRRKI8Dz2YBuDIwuEQLm5lfkdobPjp6pX/Ul+sgFTHj0FayNf9v60qbb360U4JFH/jNESHfpXDD+Artm/bo8vuS8KsijVdPUyjeaTPwRtn21FwepB4Z3iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725505442; c=relaxed/simple;
	bh=/11NuV3J13AVBCNEHJBd61OCL7273nbkmFMzpmsJ/3M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FC3OY8dQCHt7e2QqZ0qKDtxCSBIzcdYGf8qK5PSvLzcRxP4hNMW7g4LhI/tf1TtoEBlFBs4skZdOQHDCNf9djvX3eStm1ttYn4XseEPgVPPLy53qFNFgrCHOb8wZOnEcwU24gwP48hPuPQMu4JWeBpo5QO3lBiqEYWolcTMIB78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lvq9r3Wa; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2f50966c478so2895161fa.1;
        Wed, 04 Sep 2024 20:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725505439; x=1726110239; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/11NuV3J13AVBCNEHJBd61OCL7273nbkmFMzpmsJ/3M=;
        b=lvq9r3WacqscNpeOUd84ooGy6VX4SaMtVLXQxJpRnGkZO/z82wg/EJnzp0zPfaDu3k
         /CKUPNltrCQGKB3Bg2eAS1TfJh06d6/nKUeSnVVq5OM8+voRFdtyyJpAGL1GcSVeR7rA
         3o7uyi5qte7CLUs4hn5Lo9HW41cNavq1SE+5BbYahNjYDW42rex7TaRtrbdxqfzEFB++
         +JgHET6Iq3Xr40xv0b1m3bqMEsLsbLiW6v7iUi+jpqJpLTnkxI7wATJXxaNOWZjlncsx
         Y0Ak62xIx4+RnLYONz05/VUn6FMLdQ3E6Pm+f71xrX9MaBCClebGkkLEeVFTF5sXjI1k
         RhmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725505439; x=1726110239;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/11NuV3J13AVBCNEHJBd61OCL7273nbkmFMzpmsJ/3M=;
        b=b0Z9gMGceSzV/RBi8PS8FH7gtzCAuyW6B1R+GCgh2/GiveBbkcRtV7CxPkr8zcEoBZ
         qH2NBgSIKCJt0eQe8uxA5mygl8Hz5JAQ5W0R6iYnwhLmAlQ9GtIeO9Br/5NC8daWZMYM
         +qjZK3abvK6TwAi8kNJ0NVyetcSsQq/mWtCiq27AbdvlhbyQC84fTO+2Snd30w9WbLdL
         DJW5jV3MnJ+ISdjttoOta47GHEmKlqzgdrexnZEKnloQHvCMPJnXpXgctezjciitKGUj
         z9WFND+hRkNV/stfasNWzAL/v1+1cZUZEADF8cgnrhG3Eq6+vEilkRRznJAoXtTn2Nwo
         iszg==
X-Forwarded-Encrypted: i=1; AJvYcCU0mv0Mgaw5MJqSoiJzhQpZERGIMlfzm+wyYHqlA11fyy5ald+7QC51KD4kfO3xh0UQ4Vp2sBRQ+IRXPvpg@vger.kernel.org, AJvYcCUrcI+1d6i6rJOVW0hWNonpozsh/I1o5NX6TOXoh4q2mt5kDw7N7/bgP3a6xF3aNwExf7YzdZ/nzQqB@vger.kernel.org, AJvYcCWnbgmhOy8LWg+h2eYkSVCD3t1uwUUymz9Te7r2nxSNy9klPMMIAmDm7wp7uwkta7OiQcxBfwR9iu8Q@vger.kernel.org
X-Gm-Message-State: AOJu0YzN42U+qEMNLVWJid9OerXtq2rxF1z3MWeUcduZDWhkWBkP6CYL
	9U+2RqnZvOVAJObLj409FD0EeImB9TniyXw6KJ/vQI2FzOkYGtvFdSJ/VIiQ3bamxSNY9Ecg86q
	FfQiECH0OZ+BtY9sqDXmh8ASA9kE=
X-Google-Smtp-Source: AGHT+IFKoW5NyQxeBL8rXaoBWYykLj0w4swcnGUHWTlZ90Pbf5D/BbEifa8Bhjzs4iwGhbX2BuMSl4V40wWz0QQoSEY=
X-Received: by 2002:a05:651c:198c:b0:2f3:d560:ed9f with SMTP id
 38308e7fff4ca-2f61e025823mr141143101fa.5.1725505438583; Wed, 04 Sep 2024
 20:03:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240905012617.1864997-1-haibo.chen@nxp.com> <20240905012617.1864997-3-haibo.chen@nxp.com>
 <CAOMZO5ALKfz-w3taJBwCLu+pAnrcGaa-9=EtLH6FFJWBkq=t2g@mail.gmail.com> <DU0PR04MB9496D185069B3F9D3422BDAE909D2@DU0PR04MB9496.eurprd04.prod.outlook.com>
In-Reply-To: <DU0PR04MB9496D185069B3F9D3422BDAE909D2@DU0PR04MB9496.eurprd04.prod.outlook.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 5 Sep 2024 00:03:46 -0300
Message-ID: <CAOMZO5CCP9urCFixBtF17DaQ2mpno43mprj8hXP70R3-1MvU5g@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] spi: fspi: add support for imx8ulp
To: Bough Chen <haibo.chen@nxp.com>
Cc: Han Xu <han.xu@nxp.com>, "yogeshgaur.83@gmail.com" <yogeshgaur.83@gmail.com>, 
	"broonie@kernel.org" <broonie@kernel.org>, "robh@kernel.org" <robh@kernel.org>, 
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>, 
	"shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, 
	"kernel@pengutronix.de" <kernel@pengutronix.de>, 
	"singh.kuldeep87k@gmail.com" <singh.kuldeep87k@gmail.com>, "hs@denx.de" <hs@denx.de>, 
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 10:49=E2=80=AFPM Bough Chen <haibo.chen@nxp.com> wro=
te:

> Hi Fabio,
>
> I only add the .lut_num here, do not touch .lettle_endian here, and I add=
 another 8ulp in the follow line, but format patch show in this way. Anythi=
ng I can do to adjust how to format patch?

Now that I look at the original code, I see that imx8dl already has
little_endian =3D true.

Sorry for the noise.

