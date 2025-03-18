Return-Path: <linux-spi+bounces-7209-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 733BAA67CD4
	for <lists+linux-spi@lfdr.de>; Tue, 18 Mar 2025 20:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9447B42612A
	for <lists+linux-spi@lfdr.de>; Tue, 18 Mar 2025 19:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F411D212D6B;
	Tue, 18 Mar 2025 19:09:02 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144E2211A3D;
	Tue, 18 Mar 2025 19:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742324942; cv=none; b=i9RKz58RC7w7CJPA8AapziFvVs6ElDyVp2peX/AvjS0uTF7chk8Dxup1CwmNUdUKxPByxbYzUkF/7GInYQT2NJ4InVyLlx8bnF7nG4avDAjoHHfMs+vUhFMSs8sDrP0YkvM9zDk1nShC0DrXzNpftLWA6DgF07kw1/4Z5u7ickw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742324942; c=relaxed/simple;
	bh=ZGGZME9btt7FCuf3LYHWPQnMBsioZA/zWJtYZ67EYXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lEO/IZuqg3KrRbC/ZDajAgpnzIQuuf+cuXhLfxIrtoPcn+X3Yt2g2/VpJwpIo1cH67qYUGacGir54MbOH7JNTnPKIruhzWrhwFMFembuNl70weLsXY7Ovea9fp+W3NLrEO5gdi906u8OsSJJX07Bo2J8aG2fNVFy+OqDwnGVpRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aaf0f1adef8so580548866b.3;
        Tue, 18 Mar 2025 12:09:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742324939; x=1742929739;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zTHy8KzyUCOX4E8SztWoQbpq6eM6Toce0g6QZf7AXbU=;
        b=sdluRHnsP237jLHBLG0u12iKoHECCLdxYeu6/YafvV5+iqHPDmDod0Rmdv6Kx1X3HH
         DhFjL5vfkOGGiXg8cpGRq34V3/TP+FgGzPfFSrmy8gTHo/spCvdyohwqOWPsGuyPQZZ+
         AunMFTi34y3TWsq3FbW9JPRaWWY1Pqmy0zdzEN26lNA78/EaDVQdMCMbjEB0em5N06+2
         hmSmav91KNFDmkME2/dcm4zW7US2Fs6xwwfqFzzuF8jIaF80zEbAkNwe7jrVoMF3EoYw
         VvS1J1/XRFWN8fd9rhpUDXkBC9AaXo19fzHly6EVJj29+AuJa7ujMUG6+HlhYYqfKXUm
         L7lw==
X-Forwarded-Encrypted: i=1; AJvYcCVaSQOOs48osJ65nnAM59psU+xdBU2dPoMkEINc018fZo7v/2kQC4gp09x9s2Zqmv7asHnkrQNSWHe4Hrw=@vger.kernel.org, AJvYcCW/SZaNsyWy2q320JASi35BFH0G1dxYg6V3m0JMT6EH2HNT2kPunKzIL4vuwIPBJZwJMkhOaKVasszNQ+c=@vger.kernel.org, AJvYcCWMPx88NM2uuKm3ugHWUpbMEdHF3rwLsFSbDtsXal2oyyFCu6yTp36IE5iQrBPTePp4x9/1RLBnwGxC@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3VsCH/POyDTY7olX2lq8Wa/2tI7QvF/5xKpdtWrn/j74lM0rZ
	KPxZZtwzM4C1OC1qH8hHpTnbWx43EbKp7Ysp0kheCDvjbjjq8V55
X-Gm-Gg: ASbGncsz17u1b8/G+LPHfL9TYaEFdwHDde+TSUYMxOPMuCjZMtKccGC+kt2AE7KvLnc
	KrPjgA6jXCxc1fB2Ha2RLsAs7keW3CZsbbURzVR+Vie7I7Uge7K0BjkpwmJM0vokjZFJJ0jqfhP
	JTib/qmh3Ik1mhkY8KVES+4CnHeN+W5qp3cEx5KflJnEvcw/+vUg1qmB7r5ETZEjCGWlGNVkkkt
	6sHbdRv6P1HglOTpNptsfyBVtutteo/nXNZ6ajK/QlgWcgLZphQyirrEkGuR35XfjcAaLnA2Yse
	G3YA/fOUa1nNV8mPfdvwACzL1/D5u564W7g=
X-Google-Smtp-Source: AGHT+IGuzWPvTvfw/MmeqFCv3w696lCvdp5HT3v4F80QEn8ekrgZn2etIb1k2ztir6ec4whvMXJFUw==
X-Received: by 2002:a17:907:7290:b0:ac2:1793:adc3 with SMTP id a640c23a62f3a-ac330442f1bmr2148721866b.41.1742324938947;
        Tue, 18 Mar 2025 12:08:58 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:2::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3149d0b4csm884622666b.122.2025.03.18.12.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 12:08:58 -0700 (PDT)
Date: Tue, 18 Mar 2025 12:08:56 -0700
From: Breno Leitao <leitao@debian.org>
To: Mark Brown <broonie@debian.org>
Cc: Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Sowjanya Komatineni <skomatineni@nvidia.com>,
	Laxman Dewangan <ldewangan@nvidia.com>, linux-tegra@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	rmikey@meta.com, kernel-team@meta.com
Subject: Re: [PATCH 1/3] spi: tegra210-quad: use device_reset_optional()
 instead of device_reset()
Message-ID: <20250318-impetuous-vagabond-pig-eb288c@leitao>
References: <20250317-tegra-v1-1-78474efc0386@debian.org>
 <22ffa8f5-6590-4602-853d-ceffed580f22@sirena.org.uk>
 <20250317-solemn-debonair-sambar-f04fa7@leitao>
 <f3e47d12-f6be-4bb5-b87b-84aa0037e1ef@sirena.org.uk>
 <20250318-cuddly-translucent-teal-e2ac2d@leitao>
 <6355bbb3-a4b1-4fdc-8a97-d81bc5e1cf65@sirena.org.uk>
 <20250318-furry-piquant-orca-da28c2@leitao>
 <47c40ec0-291c-4664-a66e-d76bd6360c0d@sirena.org.uk>
 <20250318-boisterous-adorable-chowchow-cea03b@leitao>
 <7f2ac489-51e5-4798-a38a-a8b7ef3d4c83@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f2ac489-51e5-4798-a38a-a8b7ef3d4c83@sirena.org.uk>

On Tue, Mar 18, 2025 at 06:35:18PM +0000, Mark Brown wrote:

> > Do you want me to resend those two separately, or, is this thread
> > enough?
> 
> Please resend.  I think I was anticipating a new version of this patch
> with a clarified changelog and some rework to tone down the logging
> that's generated similar to the other patches rather than just silently
> ignoring the lack of a reset controller.

Sorry, I am more than happy to change it the way you prefer, but, the
warnings coming from "device reset failed" are already printed once:

Here are the instances of calls to device_reset(), all of them with
`dev_warn_once()`:

	if (device_reset(tqspi->dev) < 0)
		dev_warn_once(tqspi->dev, "device reset failed\n");

and

	/* Reset controller if timeout happens */
	if (device_reset(tqspi->dev) < 0)
		dev_warn_once(tqspi->dev,
			"device reset failed\n");


So, this one is not very noisy. Should I change anything?

On the other side, I see some other messages that are very noise, being
displayed at every message that is failing to go through. They are:

           spi_master spi0: failed to transfer one message from queue
           spi_master spi0: noqueue transfer failed

I will rate limit those as well.

Thanks for your direction,
--breno

