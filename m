Return-Path: <linux-spi+bounces-142-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B2F803ED7
	for <lists+linux-spi@lfdr.de>; Mon,  4 Dec 2023 20:55:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B989128113F
	for <lists+linux-spi@lfdr.de>; Mon,  4 Dec 2023 19:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF72830F9D;
	Mon,  4 Dec 2023 19:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hefring-com.20230601.gappssmtp.com header.i=@hefring-com.20230601.gappssmtp.com header.b="g8hKhZP0"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F41107
	for <linux-spi@vger.kernel.org>; Mon,  4 Dec 2023 11:54:54 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-67a8a745c43so35993096d6.0
        for <linux-spi@vger.kernel.org>; Mon, 04 Dec 2023 11:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hefring-com.20230601.gappssmtp.com; s=20230601; t=1701719693; x=1702324493; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JGHpcniqj4N4OVIiCaIFNQVtHMVvgMth5+0aM+Fp7ss=;
        b=g8hKhZP0a7uwxMliF/GtyrDiywzEIRMn3by8xFgEk7Xpyk69ai9pPb7JuSRSyYsmcf
         Dtr/DtqmTAvCIZRflijKhlLW1nQ1NvY4dke1GasvOE87V7hYrfw7l+43k9yEtpX9zvMS
         DFzF8x2rKGlTz1H999X1gloUFTkpNoDqcF6+yjprBid5Q7+FV+R2JKkY/cK1v1igVeQj
         X6Xg4eKEdG5BdLEh9Kj7Ipw7NDuvThXBazt5mfQwGAfoxakT71kR6NGk/vONNVCTVgwZ
         scPOgwPKD34X2DFvWXkxVaF2yuv4hkEmoPljNCexsgwGUZXKqy2Hv5B8ohryeCOR7M8s
         4FUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701719693; x=1702324493;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JGHpcniqj4N4OVIiCaIFNQVtHMVvgMth5+0aM+Fp7ss=;
        b=mvoGvqHzFJZ5/Gk5SISTRwh/ZHeSawTEyc971lhRZMBMM8IgwK65/xDQ+8GJ817cxl
         0woK2pcEEzTjppOOFg9pbFUDf+H+H4GU08Kcn/XQmyEYqQW/HPXyTJe6W8t0OqH9tqIz
         1wJS55XIMtPK+5+iECgvcxZRr6JQtQ4lw+zRFKEyXxdpUs308V0qfbqse9SilsR+/ATR
         aGfqPI3YiqL5Af/ABmVstDjngZgvr31KycW9Pzz4YatZFZ3LFxKOi85Jcq8MRTp/uLL1
         E+yBlZhRgab1i0Ijoxq1Gvk1PCYdpw2Whx8udDUIY2pgQJU9hGZjH+yVrlHbENpDBjOc
         UJuQ==
X-Gm-Message-State: AOJu0YzVK2m8VWm4ufZxciHUrnJ5PSDwNSzFFsqW8MyRS3heeesfhGSO
	Qt/W9b+VN1QB84HuGQsGMFJsCsVMXnNX49Qr9hY=
X-Google-Smtp-Source: AGHT+IGpQzkoEjzpqYLjRrG6QQOYQ6WgA8JZOQ7QLOJykpYca9iIy4BV9JC0iVY98WV8uaPFAB+4KA==
X-Received: by 2002:ad4:58e5:0:b0:67a:c4d9:dc15 with SMTP id di5-20020ad458e5000000b0067ac4d9dc15mr18233qvb.43.1701719693130;
        Mon, 04 Dec 2023 11:54:53 -0800 (PST)
Received: from dell-precision-5540 ([50.212.55.89])
        by smtp.gmail.com with ESMTPSA id v11-20020a0cdd8b000000b0067ac1c30e80sm1459715qvk.120.2023.12.04.11.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 11:54:52 -0800 (PST)
Date: Mon, 4 Dec 2023 14:54:00 -0500
From: Ben Wolsieffer <ben.wolsieffer@hefring.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Alain Volmat <alain.volmat@foss.st.com>
Subject: Re: [PATCH] spi: stm32: enable controller before asserting CS
Message-ID: <ZW4uWBpEc2_4JR2b@dell-precision-5540>
References: <20231201214014.2539031-1-ben.wolsieffer@hefring.com>
 <b070eb2a-05d7-4e6a-8de9-15179045d192@sirena.org.uk>
 <ZWpoKEcM0ZeYAsBa@dell-precision-5540>
 <9aa5e049-bd1c-41a6-b9b8-037ebb4f54b8@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9aa5e049-bd1c-41a6-b9b8-037ebb4f54b8@sirena.org.uk>

On Mon, Dec 04, 2023 at 12:43:42PM +0000, Mark Brown wrote:
> On Fri, Dec 01, 2023 at 06:11:36PM -0500, Ben Wolsieffer wrote:
> > On Fri, Dec 01, 2023 at 09:50:33PM +0000, Mark Brown wrote:
> > > On Fri, Dec 01, 2023 at 04:40:14PM -0500, Ben Wolsieffer wrote:
> 
> > > This feels like it'd be a good fit for moving to runtime PM - that way
> > > we avoid bouncing the controller on and off between messages which is
> > > probably better anyway.  The driver already does pinctrl management for
> > > the device there.
> 
> > Yes, that probably makes sense. There are a few bits that can only be
> > configured while the controller is disabled, but it doesn't look like
> > that applies to any of the ones set in stm32_spi_prepare_msg().
> 
> > I'm a little hesitant to make big changes to the driver since I can only
> > test them on an STM32F7 though.
> 
> It doesn't seem much more complex than what you're already proposing.

I'm working on a new patch that uses runtime PM and will submit it soon.

> > > It also occurs to me that this isn't going to work for devices which
> > > chip select inverted - for them we can't stop driving chip select at all
> > > since they need it held high when idle.  There aren't that many such
> > > devices and it'd loose us the PM which is rather awkward...  I guess
> > > that's an incremental issue with a more invasive fix though.
> 
> > The driver only supports GPIO chip select rather than native, so I don't
> > think this is a problem. Also, I don't think there's any difference
> 
> So mentioning the drive seems a bit confusing then?

Yes, I should have been more specific in the patch that only MOSI and
CLK float when the controller is disabled and that CS remains driven.


