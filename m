Return-Path: <linux-spi+bounces-4625-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC8696C119
	for <lists+linux-spi@lfdr.de>; Wed,  4 Sep 2024 16:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F01228779A
	for <lists+linux-spi@lfdr.de>; Wed,  4 Sep 2024 14:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46A51DA2FC;
	Wed,  4 Sep 2024 14:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bc8xIe5U"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B2826AED;
	Wed,  4 Sep 2024 14:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725461195; cv=none; b=glbGoAc2EekHWe4hPcZnBbe5paHDHXtlouyP9z9IOCKkk4RMK/RwbGcnIWfVh8RYc0qpLSrI6jZORcb52XvgtQnOkWNnllNGZRr/vZZnhefyRiEUL3x/ZNMlzRmZniH7YqL6vddXjSmANwBWVHAX4faLrRVpN/Ol1okcU9A/c6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725461195; c=relaxed/simple;
	bh=jjhUvktSSK6oRKWqJSi1DkoYWq4WT8VdynjaNASoxqM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jBSwnyvL6BImSkKIoSIIQvvn+ptvfIfgtvhADRqSbuqynZNPZaIFdTretxb8LVBbNFdnlvobAYloDo7JWsGoqcFgPxYHmvpODCSBCYwivA0lW14ld5MlRhC9w+9x8S4pvFFxuRGYBgr8Q17Q+9AGcJ2AIIKK8c2VNh0v3vdV5nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bc8xIe5U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F450C4CEC9;
	Wed,  4 Sep 2024 14:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725461195;
	bh=jjhUvktSSK6oRKWqJSi1DkoYWq4WT8VdynjaNASoxqM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Bc8xIe5UYNFy+x/bRukuZuHBhWAekXtaiyDeczSqzE/3xx97XRtvnyN2Sl+jY8ipc
	 5CV75N5bkddMXhh1dNsUzENDKnRCI1npE7zLGVX7z9vTaLnZmWzefzhE2fKOTO4a8V
	 B8QT3KQ0ac0nZNiqjtsEd8p8vDD68FbYJF0aUvgsSDW5WSCA84OlhdiFk/vyvO4Ezr
	 VsRktRNVlWkzug+01CUY/jHbyWX5r0+BwRlJ3Jw7LyiFFHsaqmaukQriiGLQrUQlhp
	 l9AgsWfH8rx2gbxdZvr4ZaMPR2j3MSeOEFPrBVSNiSzYhDjYPl+WcMQodFL4szx8i7
	 7J64QYuMpHaXg==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5334c018913so6362777e87.0;
        Wed, 04 Sep 2024 07:46:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVKo1Qu2akNcYyc8ipGFbAuU9uCIBFckWtoWRVZR1BD675a5ReIvvhl3fQzx/1gRomtfKzhx6uXQ4QM0RbD@vger.kernel.org, AJvYcCWexsRQldDf2FQ1bCdQUGKDo6Xfgnb49zWNR3aoTxP2/yGMVtIkpJwayWQe8ByYTTvF/tgQK2J6sFyv@vger.kernel.org, AJvYcCWmQMvA5I22ukNLXiONS5z+ENb9VKGE6PyNo2h9SzxJ41e5zQZ5pULwRApPI59KMK1k98KTXIB5wG+n@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+neQuRTIYT82IscQwEVE4AywyDDf2DlFSgGT+fUyeOLsbQSz/
	ouibX+iL2HFaO+GEVOIc/3x3MRy0HJi8CvNj1H93xhiqI9OqYh0kokKD/hM+Kp/U80COYpg++Bj
	7JWht+a+aJLdwROEF9cuhcHIqsg==
X-Google-Smtp-Source: AGHT+IGtxU4o6s/f1DAK6nTPPwgCHa6Sg526x73C4tz20dZ4bjnMAiznKvUV5aaf+LWCkh4CxWXHiTVso1GTb4+vUh4=
X-Received: by 2002:a05:6512:10d6:b0:52b:c27c:ea1f with SMTP id
 2adb3069b0e04-53546bc0a1dmr11831535e87.55.1725461193461; Wed, 04 Sep 2024
 07:46:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240627-mikrobus-scratch-spi-v5-0-9e6c148bf5f0@beagleboard.org>
 <20240627-mikrobus-scratch-spi-v5-1-9e6c148bf5f0@beagleboard.org>
 <D2AYUH4XY0SK.1SYOUCT0PLAKT@kernel.org> <e0f9754e-4d84-4ab4-82a4-34cb12800927@beagleboard.org>
 <D2AZMD2YYGAQ.1B3AGXIC7B44@kernel.org> <e2558820-f36f-406d-8f83-95c7188c0ce3@beagleboard.org>
In-Reply-To: <e2558820-f36f-406d-8f83-95c7188c0ce3@beagleboard.org>
From: Rob Herring <robh@kernel.org>
Date: Wed, 4 Sep 2024 09:46:20 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+6ruu23UrwJ=NUUrh-9R_E5tKREv1AyU24op_uUigpNg@mail.gmail.com>
Message-ID: <CAL_Jsq+6ruu23UrwJ=NUUrh-9R_E5tKREv1AyU24op_uUigpNg@mail.gmail.com>
Subject: Re: [PATCH v5 1/7] dt-bindings: connector: Add mikrobus-connector
To: Ayush Singh <ayush@beagleboard.org>
Cc: Michael Walle <mwalle@kernel.org>, Mark Brown <broonie@kernel.org>, 
	Vaishnav M A <vaishnav@beagleboard.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Derek Kiernan <derek.kiernan@amd.com>, 
	Dragan Cvetic <dragan.cvetic@amd.com>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nishanth Menon <nm@ti.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	jkridner@beagleboard.org, robertcnelson@beagleboard.org, 
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 31, 2024 at 1:11=E2=80=AFPM Ayush Singh <ayush@beagleboard.org>=
 wrote:
>
> >> But here you can have subnodes, no? These could then be just
> >> enumerated as usual.
> >>
> >> &mikrobus_board {
> >>      mikrobus_gpio: gpio {
> >>              gpio-controller;
> >>              #gpio-cells =3D <1>;
> >>      };
> >>
> >>      spi {
> >>              cs-gpios =3D <&mikrobus_gpio 1>;
> >>
> >>              spi@0 {
> >>                      compatible =3D "mydevice";
> >>                      reg =3D <0>;
> >>              };
> >>      };
> >> };
> >>
>
> Hi, I am now working on an approach for mikroBUS based on the apprach
> described here: [1]
>
>
> I am thinking of the gpio-controller approach you seem to have used
> here. So I wanted to inquire if there already exists a gpio-controller
> driver that can create a proxy controller that forwards stuff to the
> underlying actual controller.

gpio-map is what you are looking for. It's documented in the DT spec.
It was created exactly for this purpose of remapping GPIO lines on a
connector.

Rob

