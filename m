Return-Path: <linux-spi+bounces-120-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A1C4801758
	for <lists+linux-spi@lfdr.de>; Sat,  2 Dec 2023 00:12:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC467B20F21
	for <lists+linux-spi@lfdr.de>; Fri,  1 Dec 2023 23:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 139AD3F8CF;
	Fri,  1 Dec 2023 23:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hefring-com.20230601.gappssmtp.com header.i=@hefring-com.20230601.gappssmtp.com header.b="H09RgJzr"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B36BC1A6
	for <linux-spi@vger.kernel.org>; Fri,  1 Dec 2023 15:12:30 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-77eced82fcfso21410185a.3
        for <linux-spi@vger.kernel.org>; Fri, 01 Dec 2023 15:12:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hefring-com.20230601.gappssmtp.com; s=20230601; t=1701472349; x=1702077149; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a50PSVMEXWIrlF9Tli8fOmbsqWneSFikUwGhyJPwIGY=;
        b=H09RgJzrrBqhAt31MmnFbmpKmhKJL0F8hdDUk45C93jprX7WmLW41GFJNM8B+kQrqd
         V95SZf6Z8HHSdhtJvwUoV+Zp/8PZTXo4oc5Js8ns+EBMXNkpgrfdgrUBbFW//QLqdBHM
         BuCSLKOA2IdUnwXYfeH6rPI/91qOXrdmC/R8QyZy0jP2mCzCUKGVpZlh7WJ6/aXlXC9c
         YpPJ05AsMr5EypoBRCgO0Cm1dwbed749W9cuORCdq7c62Vys39XcacM9DxMSu/YzIydD
         haZIz4gVYnQx5XlmkpkTYU1W+kj/swgxTE5blBVfbUPpObUs8N79XLpdWzdq/UQru585
         MYkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701472349; x=1702077149;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a50PSVMEXWIrlF9Tli8fOmbsqWneSFikUwGhyJPwIGY=;
        b=S4K8bTRGHwasisssOiAtrclBzvuXB2nnJgO+pRVL4b1B3s9tA13bvUViKydfaLKoh7
         4R7Av5XfX9yDzP8SNqic/vvMebyBblu6NJ5QOAzRmmosJURVjBJqeXEhQGegZd/vkA6J
         kUsRxzf64u2mYZVZ9kadDqOAuTfVq98mOkZz3wz09eLcDrkPBF7jUzdFr8MNmlFq+S4R
         of89KMm0frZYaDBt77rvUHskCaC/rWfyUEP+tcmuXdU9Mtw/HiEaLNUPw8ymMo2atYRg
         LVI6sc+1EGOdVpubvkxV5G1794M3wqr0VWJVjXyUBM6NZsSvWsCJFfkOug+pE3xePf2J
         kiYA==
X-Gm-Message-State: AOJu0Yz40ne+R7HimZYd6MYUYXJ0HmBcgGohyO6uYQQk0gEjFKIqt8gt
	Oj+ceoL7v1IOzpnNGaYufZ7ce8RrLVoIE0Lew/4=
X-Google-Smtp-Source: AGHT+IF3Z3/RzfTwbCTpw0iP7Wf8/w6zwvmRXwU6DVH7OKN9elzjeew+laW1/G83KjRpnw/aIrbT5g==
X-Received: by 2002:a05:620a:8209:b0:77d:9fde:23e2 with SMTP id ow9-20020a05620a820900b0077d9fde23e2mr343467qkn.20.1701472349734;
        Fri, 01 Dec 2023 15:12:29 -0800 (PST)
Received: from dell-precision-5540 ([50.212.55.89])
        by smtp.gmail.com with ESMTPSA id bq42-20020a05620a46aa00b0077d6443ae82sm1910778qkb.83.2023.12.01.15.12.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 15:12:29 -0800 (PST)
Date: Fri, 1 Dec 2023 18:11:36 -0500
From: Ben Wolsieffer <ben.wolsieffer@hefring.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Alain Volmat <alain.volmat@foss.st.com>
Subject: Re: [PATCH] spi: stm32: enable controller before asserting CS
Message-ID: <ZWpoKEcM0ZeYAsBa@dell-precision-5540>
References: <20231201214014.2539031-1-ben.wolsieffer@hefring.com>
 <b070eb2a-05d7-4e6a-8de9-15179045d192@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b070eb2a-05d7-4e6a-8de9-15179045d192@sirena.org.uk>

On Fri, Dec 01, 2023 at 09:50:33PM +0000, Mark Brown wrote:
> On Fri, Dec 01, 2023 at 04:40:14PM -0500, Ben Wolsieffer wrote:
> 
> This feels like it'd be a good fit for moving to runtime PM - that way
> we avoid bouncing the controller on and off between messages which is
> probably better anyway.  The driver already does pinctrl management for
> the device there.

Yes, that probably makes sense. There are a few bits that can only be
configured while the controller is disabled, but it doesn't look like
that applies to any of the ones set in stm32_spi_prepare_msg().

I'm a little hesitant to make big changes to the driver since I can only
test them on an STM32F7 though.

> It also occurs to me that this isn't going to work for devices which
> chip select inverted - for them we can't stop driving chip select at all
> since they need it held high when idle.  There aren't that many such
> devices and it'd loose us the PM which is rather awkward...  I guess
> that's an incremental issue with a more invasive fix though.

The driver only supports GPIO chip select rather than native, so I don't
think this is a problem. Also, I don't think there's any difference
between inverted or uninverted here. They both either need to be driven
all the time or have pull-up/downs.

Ben

