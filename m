Return-Path: <linux-spi+bounces-4647-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19CDD96CC52
	for <lists+linux-spi@lfdr.de>; Thu,  5 Sep 2024 03:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB2E4282EE1
	for <lists+linux-spi@lfdr.de>; Thu,  5 Sep 2024 01:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D8FBE5E;
	Thu,  5 Sep 2024 01:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SQ/ZauQR"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA1EBE4A;
	Thu,  5 Sep 2024 01:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725500314; cv=none; b=FfprqNP3ffUWGt6QT6aC8coYonN/o3hfZsz4eBmwubfx0PKSnD5GygO4uTA2fMd/4uObS7vQBsSnkJ5iDgWQmyYlEO/WzmKaV83ry0q/6wu2eKtKgmGTSvaaB5Jikg5XdH6/5IaQZYOHl0Y9aUXurc/69ywbAzFEQu9B3tpYQNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725500314; c=relaxed/simple;
	bh=P7+//3f0uxXgRToZ3WeE9Im5WHZAxsHHLJVN6juhPBU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KrcDnoFBOKxVhg9us98TrcfXEsoKmFstShR8zLappRIawlZYhD/3OK+MgDMGWC7sY6ZrkTXiM+ljnPRWxkFebn3rdqm/tduNO/+63siybF8D7lMmehPiikj9DCrcJcPoPlWwXGNQxJkAFoL13mpnS+jkyeVc2tagUU71GlRrWMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SQ/ZauQR; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2f406034874so2237921fa.1;
        Wed, 04 Sep 2024 18:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725500310; x=1726105110; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AO648791FxZjc0pfPzn6rezwo34BHpIRDyZ0dfaieMg=;
        b=SQ/ZauQROlbXIKGX0kOmm/5HO9HRvVK+/RvhkQZc0/yGrGlb5tnfcf4zv+BHqFs364
         w1JPcWdINc1IwSdhi+Fn6EiT+MBjpO/Y2ooT4mqcrry9A51yfb/MC0Bd4NBVsnBuvr1L
         ihWoy+cTvMLF1pNkvo1aGSV3glTKeiep4r0syTQRDEZJhogS6C/BqbQDBueZ0BpzW3d2
         6KkW8jztDGBDB//xo2QQsIm2YKTtWHMxw1UyS4dyBWG7Vm7gHw2/6BsJ8aGebx2gBg3R
         OD4gphsn8fQEK8lysVGpwfD+GvGn9QoaJvTVwv7EDaT+ysZeXFrzUAl/dfrNKqM8cmBz
         b2TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725500310; x=1726105110;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AO648791FxZjc0pfPzn6rezwo34BHpIRDyZ0dfaieMg=;
        b=c6/dW79SNUITatBnoZGk8iqxVl2ipn64XLCQhtGwnh5m/1tT+1aqq6iUd0uvC2ocdG
         lP3STjYhYls5v0vHz2Yw8YQ2urIiYNI1pghKAYaKnc1OYt9cLgnujkHwEE57uJJqgMrp
         hlTMtlZCAYlKHZ+mPg0ltQr53l2eMTELlK0oZsP9DVtS1++BJpR/Y9yc9ScPZoC7HD6l
         RYggIug3Ys32aFOPgn6ezncDNtpZjF8QuzbmgvSnnykCnsT3HML0eHgtB+DeIeqyNC6f
         yxJ/LsbcBT+QVflUhNv1MuS66QyuhaYgg+7ydcBvO3pb8nC/cgpcmm23jE1SymtVLbQP
         Dwyw==
X-Forwarded-Encrypted: i=1; AJvYcCVDxNldsJWktGTW5Cj0Ui/MAPc+77JajzD89hXEm1LZF4Fwzte005s+8Db+EMnB1nA5ICygYk6fMkYNvH+e@vger.kernel.org, AJvYcCW7Uw3DAkBJbd8Vj9sbVKTg3QzOWgegACMMJrzTVNrXkqcdnspGUMPzsloFzKzQg1r2XgzWs5B0hCCj@vger.kernel.org, AJvYcCX1I+ZEDC98xKi7bTSFcdpY4dTsZnC9jifbvhfqNYMp/p/v/I58Y20RZxUYOl/m/t3pr46gF0wEBMsW@vger.kernel.org
X-Gm-Message-State: AOJu0YwICnT2+4IvMyrW2i5LZmMe3cQWcf71c6YphtnfIhabG0mKwbWR
	6o6ekfCkbP/AY9+ajIQTbfS9cnjGpi6mukFJVhN00CM9cvVvE7i222uQrZgHZqQb1oOn9yq2tYJ
	wLXVLZn4NG3Yp0cJg0KfKsI2X0Pc=
X-Google-Smtp-Source: AGHT+IEgRQ5E1daIzkoTZjA3SBI5LKy8bNnez+U77us3K03z38F2bspDE0V1pv/8qaBSchrXdvakf6XD4sPmM245Ask=
X-Received: by 2002:a2e:bc22:0:b0:2ef:1784:a20 with SMTP id
 38308e7fff4ca-2f64d53e658mr39075801fa.38.1725500309909; Wed, 04 Sep 2024
 18:38:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240905012617.1864997-1-haibo.chen@nxp.com> <20240905012617.1864997-3-haibo.chen@nxp.com>
In-Reply-To: <20240905012617.1864997-3-haibo.chen@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 4 Sep 2024 22:38:18 -0300
Message-ID: <CAOMZO5ALKfz-w3taJBwCLu+pAnrcGaa-9=EtLH6FFJWBkq=t2g@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] spi: fspi: add support for imx8ulp
To: haibo.chen@nxp.com
Cc: han.xu@nxp.com, yogeshgaur.83@gmail.com, broonie@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, shawnguo@kernel.org, 
	s.hauer@pengutronix.de, kernel@pengutronix.de, singh.kuldeep87k@gmail.com, 
	hs@denx.de, linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Haibo,

On Wed, Sep 4, 2024 at 10:26=E2=80=AFPM <haibo.chen@nxp.com> wrote:

> @@ -373,6 +367,16 @@ static struct nxp_fspi_devtype_data imx8dxl_data =3D=
 {
>         .txfifo =3D SZ_1K,        /* (128 * 64 bits)  */
>         .ahb_buf_size =3D SZ_2K,  /* (256 * 64 bits)  */
>         .quirks =3D FSPI_QUIRK_USE_IP_ONLY,
> +       .lut_num =3D 32,
> +       .little_endian =3D true,  /* little-endian    */

The addition of little_endian to imx8dl should be a separate patch.

The comment is pointless too.

