Return-Path: <linux-spi+bounces-1532-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51627869C55
	for <lists+linux-spi@lfdr.de>; Tue, 27 Feb 2024 17:38:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21CDAB28D6A
	for <lists+linux-spi@lfdr.de>; Tue, 27 Feb 2024 16:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F92200D5;
	Tue, 27 Feb 2024 16:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="2xN/NWyP"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B267F1EB5F
	for <linux-spi@vger.kernel.org>; Tue, 27 Feb 2024 16:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709051784; cv=none; b=jKwL7d2ToNWsOYr9nqrf2gJtw47z2D7Ii0QiFvGjJW4GgxcUiddT/mett4vjqABWde7yp+vYE1ODu5Yx3HhOa7keNkK0L2HTHkAcKtKvP1gX2EQZXo6grwo2HPTNpfn5rQSU+XdaSuLJIc7YTXiAPAcQwh84aT4Ylk/Tyd0ndn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709051784; c=relaxed/simple;
	bh=9i5hlJapLP6jPwsym6zkalPtVBE+pFBSRmyXNbEoAEY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=im8T1U29Hi8btYJKYHho8hxKBj5Apk7MTadxoaZydgSlY9Y0LTk4QImRhwMddOK89ztijYSju/GGQscEaXDR+1lYUAQsZHAP1rNQN14lCRqN8m9oQ5/dn+JNNRlvhJ2bWVgZB3vroBX/2Niqy/O7hndk6pzrifrlbzSyEdDoQlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=2xN/NWyP; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d269b2ff48so53885371fa.3
        for <linux-spi@vger.kernel.org>; Tue, 27 Feb 2024 08:36:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1709051779; x=1709656579; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9i5hlJapLP6jPwsym6zkalPtVBE+pFBSRmyXNbEoAEY=;
        b=2xN/NWyPit65yZi63g9mDUgJJqD/xbqgpnu8+p+Lf6Tp/V6ZAlAu2jatg4oLQVkbCS
         2nml10CFtTWF7+cYsVZKA3ZHmpOtp5xZjJAfC2gvkscm3ZxjDjhbBPo32niH0nnno/jC
         Ltq9JzdI+ODlmZnILiU9uq97wIAQ2MgKDbvFSKbNdDX1BARG9Y//ksia5pXe66psxU46
         zO548gJnTDq5oROX/1x9j7dYicdedUE97zuRNDkTv0OH1Xi0qzhIVqVLILOUOibXYmbM
         yvJ8jEjQRNHUkvtJoOQvi4Cmh3XHcJ6DOnMZqdxLZap1cxcwnCb+kBGv06vZCiFJ1f4k
         j1hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709051779; x=1709656579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9i5hlJapLP6jPwsym6zkalPtVBE+pFBSRmyXNbEoAEY=;
        b=itIGbo43SHWN9cNwaf79+fCrl9CXTexYik3tRVknzoLVwON+IR8pYykPMYeCQrwUZp
         a1V4aADYjTvC6cj/Ozp7PU9EEtdy2GpoqdYJWX9NpT+0bUMcQCxohWtUtOkw3hw8Sp3V
         F3oCGRPa67IesjTe3v82JdlyCIG3ICwZjFf8tZQRTQNTpRr6TZfRNc1Qzq8GtNJLK9jS
         kXOjAO1XKNRyybUyKiK3xCJxQ8BAQgnJ5f7SncYsHhrL3Ehw7QTGvJ3UIrcuTwuRAjRK
         t0N+n6twtReYLGDSDkbzemaZcRIQQ77YXqrobCPOLHALl4GFV+drtbH8fOrMUsb6Vnwi
         NdeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgNe/0pdBIAX0ySWfl7IY7osG3cjqR41f7CvkVrGkMShbfYSiriXcCc8g1gjmbZe8IioGBpfTykH5Ha8VRj2qiQOISRE7a3Gm5
X-Gm-Message-State: AOJu0YyECXotpRxGDDTkATYbv5k6T57vg2zE2w36uNMmQ9psTEKRFiZ8
	3MhFlFL/w8ysPbO/fuHBeYlVMe0y4Pia2FNaSRfyfegOeFatxF/eIb1funV4HGRUaPHao/wgus8
	p8jA8RKs6e1N92W+oVPpJIdyONiy4o15A/GFXAQ==
X-Google-Smtp-Source: AGHT+IH7YLnLMluYbBqba2HqK2U/KdjlxswxBx1MLznMGFPH7zEmPhqgw9gjdxbEvl1zCBEAWp/RcuPS41adiKr/ORI=
X-Received: by 2002:a05:651c:2c4:b0:2d2:7580:e220 with SMTP id
 f4-20020a05651c02c400b002d27580e220mr5748651ljo.15.1709051778879; Tue, 27 Feb
 2024 08:36:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240219-mainline-spi-precook-message-v2-0-4a762c6701b9@baylibre.com>
 <20240219-mainline-spi-precook-message-v2-5-4a762c6701b9@baylibre.com> <20240224165706.18cc0d7e@jic23-huawei>
In-Reply-To: <20240224165706.18cc0d7e@jic23-huawei>
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 27 Feb 2024 10:36:07 -0600
Message-ID: <CAMknhBGZkCx1HT1pzNHAgOCSvA3U7a6_P7DdDibfawziih_PwA@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] iio: adc: ad7380: use spi_optimize_message()
To: Jonathan Cameron <jic23@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Martin Sperl <kernel@martin.sperl.org>, 
	David Jander <david@protonic.nl>, Michael Hennerich <michael.hennerich@analog.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Alain Volmat <alain.volmat@foss.st.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, linux-spi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org, 
	Julien Stephan <jstephan@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 24, 2024 at 10:57=E2=80=AFAM Jonathan Cameron <jic23@kernel.org=
> wrote:
>
> On Mon, 19 Feb 2024 16:33:22 -0600
> David Lechner <dlechner@baylibre.com> wrote:
>
> > This modifies the ad7380 ADC driver to use spi_optimize_message() to
> > optimize the SPI message for the buffered read operation. Since buffere=
d
> > reads reuse the same SPI message for each read, this can improve
> > performance by reducing the overhead of setting up some parts the SPI
> > message in each spi_sync() call.
> >
> > Signed-off-by: David Lechner <dlechner@baylibre.com>
> Looks good to me.
>
> As this is the driver you asked me to drop earlier this cycle,
> how do we plan to merge this series?
>
> If Mark is fine taking 1-4 with the user following along that's
> fine by me, if not I guess we are in immutable tree territory for
> next cycle?

I've been out sick for a week so trying to get back up to speed here.
It looks like Mark has picked up the spi changes, so that part is
resolved. I'll work on getting the ad7380 driver resubmitted, then we
can come back to this patch after 6.9-rc1 (assuming the SPI changes
make it in to 3.9 of course).

