Return-Path: <linux-spi+bounces-7881-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65437AA8E9D
	for <lists+linux-spi@lfdr.de>; Mon,  5 May 2025 10:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE6071699E9
	for <lists+linux-spi@lfdr.de>; Mon,  5 May 2025 08:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDDC21F4262;
	Mon,  5 May 2025 08:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z6kl/t1m"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBD71C8619;
	Mon,  5 May 2025 08:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746435301; cv=none; b=IWzoNm3o2DigmqBW9g3wuSSdKPYRO+F/8Zhx4EvoUO+qgrWzKmhhIBulEUMYt6fLVMcR9x1ZP9et3P+iSdcNpVYCqEljTTJgAteEQ8TkOpfynlHOZnYWYXg54WAIvPMjk8ZpQcwjHrigKvxtYrstIqiS2k9QYBdgJGZCFY8GbfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746435301; c=relaxed/simple;
	bh=ANkmaSH+jSydLUFYg/7A8fPFIx7Wpt3FwfEdHjI1I5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oK4vpoPIkrdcaX99jfRwyJw+vKg5Liqmi1W+i58nQW41DF6fSQjXJ2xF6ls/L8C+qNBT8EvDzuw0LehJ6p0+6tqhSdsBbMlvwsKfB4GWRzrSUkchdWKTcQNiQVW3IC+pzJ+Yft38+f+tgWithIIgzrgEGlqJ83/hh50HM5T9+o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z6kl/t1m; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-39149bccb69so3170701f8f.2;
        Mon, 05 May 2025 01:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746435298; x=1747040098; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YpsEFMWcB35gcbBcFGpV4LHFhrXxpliMigTkUFYalVw=;
        b=Z6kl/t1meLjPZ7bsqbZcuRHJE2LBpS5Pwbr7wx9F9E0DwIJMSAEV81Dir22sU3nkeb
         0X3WAqkEvNAjeptla+2x3nZW7RrzDozHigq79SbB78RN93b8CmklegB6qiWImq6um0M9
         A0M8H0Ix5BOqWiCO2ntxUK7xzibqjZUoVDFzIHkRBUfaofH7Ech/3aoOjysaN343qhE7
         5uI2iXqvSxY4H1YbyhixL50CK6KY2DJ8PToiGUaDd7qhJvohad42SGJGnXPhm8kYc+7G
         E43V1Yy6IzW7A6PU9QauuGoe564O5ExL+xhmBv7eyrVIKdxelYZcZLikM3QfUnvy/Gdu
         u49Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746435298; x=1747040098;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YpsEFMWcB35gcbBcFGpV4LHFhrXxpliMigTkUFYalVw=;
        b=pbFyRfsax2q5iIWzXobCHgrGHdpR/Bn8KHjDREua+58w20U7I23lR1r6Ve2GVtcZJe
         889fLEEALqZXiPc/ELyoI4LcyZ825ZskoDrPGDGbl6SVm9mAaC6tPiPsqY9tqlaQMR5x
         X3sbzxwRMTM4T6/J9euLJpJlACJd0f2TjQmOJngV1nzURccW40tzLA9LlGEHwe+G4NoX
         0g7cfqqc0YNfleuMFhKDQ6CzDJbXDCmbwdAWQbRF9gVGob+dLqXio81C9n5PPQG+VytC
         C27USlN02FZb1DmLqJycxcfYpbzc253Job4cuUEQVIOo3M1gUvw1/2m2gaT5Fu5/lCnl
         cRpA==
X-Forwarded-Encrypted: i=1; AJvYcCUuVaNunXDKUGDxnKuenZnpx34UVFp0SB7idlKawAFdOCK8EVy7mxBiEbGhxYr7TBeRnYApqXTs5U9h@vger.kernel.org, AJvYcCXiFZHARg8Vq3B9SLTfoOZRUz6CaHjraEujzZ/w+5KWc++xXpN9M0t/Vu4qn8W8nRoFe7tKJUe2A/KYCEk=@vger.kernel.org, AJvYcCXmiG8MZ40oDwwbCYjzvPDsSv969/q+DrtIWRrVSnKk3meRPurqDFsuoofWksweWetDoDHJNZ4uonvb7IY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrJi8UOXxsrTWok/lhU07Dz6ZZ/zNP4zQKXSi13w+Fk+Mwnqdg
	cxS38xcfHheFRXrBzvRSNRoXFaMLQkNVX62U24Xiohf9qIQ94DIm
X-Gm-Gg: ASbGnctGN6AAdlubwXYd0cnchBO994pGNdsxtXCN7vYeLFTzQP6PLzBt39MB2aqRIxg
	1nCVZ22w2YBteOiQK4BX2rOYb+zhtW64uONkg+84djD8fcnb7StOU3vF1lDXoKnoAc4cLrmvw3C
	t62X1gHOvoTaDzbkSRk+K6jTpZrSmCZefIy2yKbKO2Bccm+O4LWZpUxFgMFGoU7GgaGmgbv9SuT
	YIfFGe9aMo8/ofZsXPeo1HQyBcHkR24iTwyPMLUNvNsA9t4yVdJMf+b73G3FQXPJlAuFhM7GcDO
	Sx+qCp1nurY/o5cofY/wSIli0YmSgTPzQ4YTw1Nj7Q==
X-Google-Smtp-Source: AGHT+IFJs4DAHEzrv4OPAPEb9BqOw2eTNDq0LTMwTq1E21oCu2Rmq52qupAsnj6uZ2VNyDW1j5Ox7w==
X-Received: by 2002:a05:6000:2c6:b0:3a0:7b07:157 with SMTP id ffacd0b85a97d-3a09cea68e9mr6121795f8f.9.1746435297966;
        Mon, 05 May 2025 01:54:57 -0700 (PDT)
Received: from Red ([2a01:cb1d:898:ab00:4a02:2aff:fe07:1efc])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3a099ae831esm9904574f8f.57.2025.05.05.01.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 01:54:57 -0700 (PDT)
Date: Mon, 5 May 2025 10:54:55 +0200
From: Corentin Labbe <clabbe.montjoie@gmail.com>
To: Aaron Kling <webgeek1234@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, ldewangan@nvidia.com,
	thierry.reding@gmail.com, jonathanh@nvidia.com,
	linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: Re: [regression] jetson-tk1: spi do not probe anymore
Message-ID: <aBh839v-3Z1ReDi4@Red>
References: <aBdOMUhuUqbZm9w1@Red>
 <aBfsJpId0Jrcz228@finisterre.sirena.org.uk>
 <CALHNRZ-At4WmJXoNs_x0XD=bRTRsKMBm1qOQGkFcNOvFfVDaMw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALHNRZ-At4WmJXoNs_x0XD=bRTRsKMBm1qOQGkFcNOvFfVDaMw@mail.gmail.com>

Le Sun, May 04, 2025 at 09:10:59PM -0500, Aaron Kling a écrit :
> On Sun, May 4, 2025 at 5:37 PM Mark Brown <broonie@kernel.org> wrote:
> >
> > On Sun, May 04, 2025 at 01:23:29PM +0200, Corentin Labbe wrote:
> >
> > > On my jetson-tk1, SPI do not probe anymore:
> > > [    1.330681] spi spi1.0: Invalid delay unit 2, should be SPI_DELAY_UNIT_SCK
> > > [    1.335185] spi-tegra114 7000da00.spi: can't setup spi1.0, status -22
> > > [    1.341643] spi_master spi1: spi_device register error /spi@7000da00/flash@0
> > > [    1.348637] spi_master spi1: Failed to create SPI device for /spi@7000da00/flash@0
> > > I tested 6.14.7
> > > The SPI probed perfectly in 4.17.14
> >
> > That's a pretty big jump in versions...
> >
> > > I tried to debug a bit, and the driver requires units to be SPI_DELAY_UNIT_SCK, but it seems there is no way to set it.
> > > Removing the "return -EINVAL" in tegra_spi_set_hw_cs_timing() lead to a successfull probe and the flash device appear.
> > > But I agree, it is not a correct fix:)
> > >
> > > Since only the test made it fail, I think the driver is bad since commit 810593668468 ("spi: tegra114: change format for `spi_set_cs_timing()` function")
> >
> > Adding Alexandru who wrote that commit.  Assuming the delays came from
> > DT (I'm not actually finding them, I didn't look too hard though) and
> > are therefore in units of wall clock time I think we need to add a
> > conversion helper for the units which the driver can use to convert to
> > whatever units it actually wants to use, we do need to accept units of
> > wall clock time given the generic binding there.  That gets a bit
> > annoying if the bus speed changes, though that's quite infrequent in
> > practice.
> 
> This should be fixed by a patch [0] which was recently picked up. I
> saw the same issue on a tegra 210 device and submitted that to fix it.
> Can you verify if it fixes this case too?
> 
> Sincerely,
> Aaron
> 
> [0] https://lore.kernel.org/all/20250423-spi-tegra114-v1-1-2d608bcc12f9@gmail.com/

Yes it fixes my case

Thanks
Regards

