Return-Path: <linux-spi+bounces-102-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D7847FE6A8
	for <lists+linux-spi@lfdr.de>; Thu, 30 Nov 2023 03:28:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E3141C2097B
	for <lists+linux-spi@lfdr.de>; Thu, 30 Nov 2023 02:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D313379EC;
	Thu, 30 Nov 2023 02:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="MFGT5+94"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC17BD5E
	for <linux-spi@vger.kernel.org>; Wed, 29 Nov 2023 18:28:02 -0800 (PST)
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com [209.85.219.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id A8D1B40332
	for <linux-spi@vger.kernel.org>; Thu, 30 Nov 2023 02:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1701311274;
	bh=51BH6r3NTeuU80Og8+pDQ4LBdHK0XIdfBAWZqxE/rY8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=MFGT5+94azVu+ZD9jURjKAOqcrtDbJUr/osgUa3AX2upsm2sP4LsffbqDJBfDynTN
	 zkEvRBRkq3mfeGnHqypd44Qo2ZXqtyYQ0+a3mOAC5fVMhcfPwqgSNfH9VYueJCHFXq
	 9Q2ZT+O973eRHdkAScz06BHbLhawiFBVoSaywzRMF9Tz5MXkzwLAXIWFwt7k2SJ1C/
	 0uuVvghkvwmtyDljphTwBqP+2UGWPiQmkPgYVnCLmMsKXp+MPTM7Gz64XWMGRSE7Oh
	 sJRQ2ynGOmCFcfF6uWo/xuqKcA0yCfCqSqA0swpJUM2HXuEmTTZvVEk4yDp0LG3SoE
	 0NmqWgXvpMX2w==
Received: by mail-yb1-f199.google.com with SMTP id 3f1490d57ef6-da03c5ae220so1421439276.1
        for <linux-spi@vger.kernel.org>; Wed, 29 Nov 2023 18:27:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701311272; x=1701916072;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=51BH6r3NTeuU80Og8+pDQ4LBdHK0XIdfBAWZqxE/rY8=;
        b=D26ic1hkKj+eaNgz0PMSCa681DP2EIR4TZfGqUtlpSbTKpcIcIR1lDw/T2DCBNd1IV
         d7bjOLGMuwTOuqOdfn9lPThtAl48v9tXslC14yK7rZXbPgfgTBDv29uabtV2IjaYrDWd
         Gwx3Ap2D0hCn0d5oVSizWsQiH5NANP5Sfi56JyLDcrXhUB3K1NKs4hk4f1rIF4hg1rvZ
         KbLFX68kjhNQg2gGXMyX0oonfKyRI91P0Xz76hAB0uSG7oBlQiP7059dqCo0k73/8FB7
         MLHoMEJXw1zhYtBEj2bwlAyAdKlUEalAqdfnhL7xfcEeRIDdVVYU22+oTBDmzBw8VbIu
         nULw==
X-Gm-Message-State: AOJu0YwZ6/ZNftJYYSWVfUGrreJ9+hk8CNF2TVseJqnN88cogvSL/k/c
	kf41KKY13hJRWmPYsvDyOk4hM2Q7asqKZ41RGlB+yzYVymkEWGmBaIi5wXh7+0W23egCJ4EApPw
	7RDAgJ9Fb3WLZDAFhB+MDHxgfZbueNzFO9vB+bH+VGUFNfU7dUoWtyg==
X-Received: by 2002:a25:75d7:0:b0:db3:fa4e:5b80 with SMTP id q206-20020a2575d7000000b00db3fa4e5b80mr19047531ybc.20.1701311272344;
        Wed, 29 Nov 2023 18:27:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFU+/+cZbTSn4ReKApKLD82OGBkDM2LrmtNnHt3yCLXIOaJ5oVUUQwfztQHQlCy4aFlUeyNvfUi8DlF3WBb+EM=
X-Received: by 2002:a25:75d7:0:b0:db3:fa4e:5b80 with SMTP id
 q206-20020a2575d7000000b00db3fa4e5b80mr19047524ybc.20.1701311272067; Wed, 29
 Nov 2023 18:27:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231129064311.272422-1-acelan.kao@canonical.com>
 <20231129064311.272422-2-acelan.kao@canonical.com> <9c97e28e-fbb8-4a7f-8205-821fcbd579f6@linaro.org>
 <2e88fbd7-64ac-41a1-8368-edd430e86e6c@sirena.org.uk>
In-Reply-To: <2e88fbd7-64ac-41a1-8368-edd430e86e6c@sirena.org.uk>
From: AceLan Kao <acelan.kao@canonical.com>
Date: Thu, 30 Nov 2023 10:27:40 +0800
Message-ID: <CAFv23Qk6Qpxu+ROou5Uzdwu_0jSF-EYZPHynUps_5GOAakuJvQ@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] mtd: spi-nor: Stop reporting warning message when
 soft reset is not suported
To: Mark Brown <broonie@kernel.org>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>, Pratyush Yadav <pratyush@kernel.org>, 
	Michael Walle <michael@walle.cc>, Miquel Raynal <miquel.raynal@bootlin.com>, 
	Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, Dhruva Gole <d-gole@ti.com>, 
	linux-mtd@lists.infradead.org, Kamal Dasu <kamal.dasu@broadcom.com>, 
	=?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>, 
	Mario Kicherer <dev@kicherer.org>, Chuanhong Guo <gch981213@gmail.com>, linux-spi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Mark Brown <broonie@kernel.org> =E6=96=BC 2023=E5=B9=B411=E6=9C=8830=E6=97=
=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=885:19=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Wed, Nov 29, 2023 at 07:46:02AM +0000, Tudor Ambarus wrote:
>
> > You haven't specified who shall take these patches. Is it fine for you
> > if I take just the SPI NOR bits? If you want Mark to queue both:
>
> I can certainly take both.  I guess there's no build time dependency so
> we could each take the subsystem specific patch, though there'd be some
> bisection drift if that happens?
Hi Mark,

It'd be better if you could take both of them.
Thanks.

