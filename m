Return-Path: <linux-spi+bounces-9091-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DFFDB026D1
	for <lists+linux-spi@lfdr.de>; Sat, 12 Jul 2025 00:12:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 526695C1D75
	for <lists+linux-spi@lfdr.de>; Fri, 11 Jul 2025 22:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AAE721E0BA;
	Fri, 11 Jul 2025 22:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VRIJEror"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C973F13B590;
	Fri, 11 Jul 2025 22:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752271963; cv=none; b=BWg1tYf+c8PZkJOzEALem5qiEfs8CEcvPMBg4v8/7GO6ACn6htuF/3lt5+EmBUPttZdc5JYPmHClBGe8XttuPSvnGeCw6OdqO69+nexovzVdj/bYPI4rEwmgJbmtjD9sQt8FfntfUNQUimpkB1roLIb1zl0cDrxPJCiFQNN9gQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752271963; c=relaxed/simple;
	bh=j1aeCEllDPAkyDpyRZWGkM8NtpEx56OXqtwil4CfQ3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OA5JrPLmpZKJwkYsGoUoQAzt7SzIYD8CVEFzeByoBhDQ9PJXOXLsX33Nsd9guywBXI8OTch/FZrgqrRz9yv3Q8+78V7uRBd9We2eSs/ZOnnQej5VoGvdA9PtdRLJxoHia4omw1LYCxxSX06CNID9ka77jBeNvqZqnHj5T3PujGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VRIJEror; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7db39af4d22so269047285a.0;
        Fri, 11 Jul 2025 15:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752271961; x=1752876761; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=H3rTJuQRKWnARVRuNlp/ecDlvgAUoyYM9idM5xq25UQ=;
        b=VRIJErorPXuEdE90iRDHVClZMfQpKEMPpUumBYbzbzNVIxCV4bsFZnZj3tbbttRjJk
         087Wr92QDyRrnRHZqxf0WR8z0YN/Nh9Gk4GGFxIYRmw+kF5WqsNUkFut/ZvYcZGTmgrM
         /FRaFqNIc2Npn+/ve00/vv4Tgmeg0la1FTIErAgAX/JBBZiEiH0aqzCWzHYxw/rIf9RE
         6qtNOrarJFbiDsk14lPBjS+DZVyWvasLM1NU9pWpZqiEzMCe3YaJKWDRONdm71NSMiON
         fKdQv6urlm/EYaA7oBqHwRlM3k/NCSMZO4WegHAbTmxP3mC3CeeAhTin1uPzr3TgmC2i
         wg6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752271961; x=1752876761;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H3rTJuQRKWnARVRuNlp/ecDlvgAUoyYM9idM5xq25UQ=;
        b=q+02pHTzJ3lab8Fxfkrq37hqLls8WT4poW5/hqJRAYRk2JzHdfb42abR3G2JAXjoal
         Iq6u63mRnGGWkabsJ2maBZ3twgQm2lTA5418UB3B2IhTJWDV2Es7c9WJN3JT74Panj6F
         G0dAqZ60GxEcrls5oP+hhIL7KZDuCtQL0RV2aGD4CiDk7F3c//5slmggNN9I7VhvbuHX
         5ta/PDzYe9S27Bs0fLEIWhO+3Auh+jncHnnQ9Hwz1USt5NsfdWIBPxDMJwfK9nLvTIeL
         22MwHRRHvIq0FwRYgM2dWMsXBgovGFAXFVWtvve6XassVjadIvQCtsUvfqfu/F6a7TzA
         o6NA==
X-Forwarded-Encrypted: i=1; AJvYcCU0UnizwK2W/SuVfiGd/70LB87Ji4iWjjztVReaI6HCa2YVhKpVoHHHdnQkI9h+a2JdjnR7cHS52BnBNz0=@vger.kernel.org, AJvYcCUuvOEsPLkDRnS4RZ9mr/xa5YVoF96bmUD9SvRlBu6+rhKiqVersc/OhmE72ZaIJWLPx2c0CnkxuLbP@vger.kernel.org, AJvYcCUw1zL8e2+MbaCAa3th71AuUr1pums+R5fS2E16Vfpf8rb+IkMNoSowxham081F4PyCo81661rU8Jj63A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzHLaDyGIIejY/cq9LaXvOSc73hKmOHb4rpPROmbbi3/lZXBtbI
	tUu9vLRaH9gNHsQDTy9dW9JkSCdJOtb9gw+REfTLdHbiVn8qXoVp9ytH
X-Gm-Gg: ASbGncuB9NbnCwMftxjfIF/lAwqcGRvlRP4veXy39je+c8gYJeggJXpWlp4j1DkofAn
	LJIWuwQn3x9zOSQ22LYMDJfebk2ytYHIbINC5wQKKzS2GnOro2G0si+rn/B6hspa6J1nrYeiGiP
	Zephb5xpz/OJ41Gu2pV4L23iaLTiSY/DUOuOL3zFmVSRXcMCmwSCHWLUq5H0TsQO3DNMMfeIkoI
	nGEV9DHhFUzB0jSf5eQiSHDaciyb+2Z3+xSZ7kvDro9kYDg0kRaKdMqQTTn/0OsjHltCR4UxgZO
	488yk7+ie/I22BJqWlErCEK6K2YsIKX6AmitzEaRWQbqMa+uaCfjEheWT2nu5hxCKPH3wZb09+W
	0GspR/IzxLgzsJ8bA+XB8J+G18q66ihRp6SJr7wRtl3JMCLE65aNF5AgXAXOC3eh7DHWOCCEU74
	4ceV7OEbenuCbA
X-Google-Smtp-Source: AGHT+IF8bfHLFaE/so1vau2El37QujHD18gZE7VogT8DXaFcCCFNNZlIE4JZh87T1EP17999R+OaNw==
X-Received: by 2002:a05:620a:2985:b0:7d5:d144:87dc with SMTP id af79cd13be357-7de07286387mr755691385a.43.1752271958083;
        Fri, 11 Jul 2025 15:12:38 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7dcdbb2580fsm265906685a.1.2025.07.11.15.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 15:12:37 -0700 (PDT)
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id B6D71F40066;
	Fri, 11 Jul 2025 18:12:36 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 11 Jul 2025 18:12:36 -0400
X-ME-Sender: <xms:VIxxaGY93nSoBBDP4pJ6sGe_hZQNmEQ2kajN6-EkehDwYcPljhvVAA>
    <xme:VIxxaOZl98EUuqQRj668_VYPHmug9yW-No4DBQ8yv_g7gG6sN4m8VF1aru-l_-dO7
    gnDxIkNWCOkRsbA5g>
X-ME-Received: <xmr:VIxxaB3OV1v9ieDYRjVjeegiSEh0LcYMHoZolJJuIIhkRpHO1gHIonOAjiP9>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeggeegkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthekredttddtudenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpedtgeehleevffdujeffgedvlefghffhleekieeifeegveetjedvgeevueffieeh
    hfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsoh
    hquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedq
    udejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmh
    gvrdhnrghmvgdpnhgspghrtghpthhtohepvddupdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopehlihhnuhigseifvghishhsshgthhhuhhdrnhgvthdprhgtphhtthhopehpvg
    htvghriiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehmihhnghhosehrvggu
    hhgrthdrtghomhdprhgtphhtthhopehlohhnghhmrghnsehrvgguhhgrthdrtghomhdprh
    gtphhtthhopehvihgtvghnthhiuhdrghgrlhgrnhhophhulhhosehrvghmohhtvgdqthgv
    tghhrdgtohdruhhkpdhrtghpthhtohepfihilhhlsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopehhrghnrdiguhesnhigphdrtghomhdprhgtphhtthhopehhrghisghordgthhgv
    nhesnhigphdrtghomhdprhgtphhtthhopeihohhgvghshhhgrghurhdrkeefsehgmhgrih
    hlrdgtohhm
X-ME-Proxy: <xmx:VIxxaOYTC8XPYjociUNzD0wtW8abgp--rFJT1iPncq351S5xO72E5A>
    <xmx:VIxxaOlz2Lv4zXawcqYT8E-f2bQ88Kn5N_Tz5eQ5n78bNxEbyB_chA>
    <xmx:VIxxaNco0FNWuyniI8wr87p8XKHoG9BzKXVNazY5IDBrSXnV-aeHYA>
    <xmx:VIxxaM2UT-LfSYzCe69AOmSeSizggSqIdnebJtCAKm9emIOWRZ9JaQ>
    <xmx:VIxxaKluUDUJEb2NY7TYJq_nxNlO9-5tiYzavw5NYkjF3xRKdeXwFnGU>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Jul 2025 18:12:36 -0400 (EDT)
Date: Fri, 11 Jul 2025 15:12:35 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Waiman Long <longman@redhat.com>,
	Vicentiu Galanopulo <vicentiu.galanopulo@remote-tech.co.uk>,
	Will Deacon <will@kernel.org>, Han Xu <han.xu@nxp.com>,
	Haibo Chen <haibo.chen@nxp.com>,
	Yogesh Gaur <yogeshgaur.83@gmail.com>,
	Mark Brown <broonie@kernel.org>, Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>, Andrew Davis <afd@ti.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-spi@vger.kernel.org, imx@lists.linux.dev,
	linux-leds@vger.kernel.org
Subject: Re: [PATCH v7 0/3] locking/mutex: Mark devm_mutex_init() as
 __must_check
Message-ID: <aHGMUxA8w3-ixLeA@tardis-2.local>
References: <20250617-must_check-devm_mutex_init-v7-0-d9e449f4d224@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250617-must_check-devm_mutex_init-v7-0-d9e449f4d224@weissschuh.net>

On Tue, Jun 17, 2025 at 07:08:11PM +0200, Thomas Weiﬂschuh wrote:
> devm_mutex_init() can fail. Make sure everybody checks the return value.
> All patches should go through the mutex tree together.
> 
> It would be great if this could go in through a single tree at once.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>

Queued for v6.17, thank you all!

Regards,
Boqun

