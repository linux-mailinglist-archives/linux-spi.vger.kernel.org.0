Return-Path: <linux-spi+bounces-310-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29571815381
	for <lists+linux-spi@lfdr.de>; Fri, 15 Dec 2023 23:23:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9320286254
	for <lists+linux-spi@lfdr.de>; Fri, 15 Dec 2023 22:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C7713B126;
	Fri, 15 Dec 2023 22:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hefring-com.20230601.gappssmtp.com header.i=@hefring-com.20230601.gappssmtp.com header.b="bB+xsgXP"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F5018EB4
	for <linux-spi@vger.kernel.org>; Fri, 15 Dec 2023 22:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hefring.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=hefring.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-77f50307a1fso75632385a.3
        for <linux-spi@vger.kernel.org>; Fri, 15 Dec 2023 14:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hefring-com.20230601.gappssmtp.com; s=20230601; t=1702678973; x=1703283773; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7TFw7xg7w2M+8qc28EqEusL4T4Plz+lf2upO0JPQgw0=;
        b=bB+xsgXP0L1K1L4YdX4qXnsrdPX7OO9PVPR6hlKNra+DrFBmkHOVrtSxG791xmZB+X
         UfRkdwJJyNB0bZ6stenzFN+0piMYgor2JnZv4mrnSRd5Ce9LtdDClD5INfjXOV3w4x+T
         2lrC5+H67cppQ6NAwuEOO4/1JHkdYAfuDb860q3qUQTeVSBDu8SN9bgYrtMGMyHxnKDq
         eesA+I3ZSRvAsTUX7YUGUG9GEMSgHM/MNkqme8Adw1chfUy6BkvqSYo0DZvgtauiJxt/
         5Sh2H1bSFtHvh7nN1VaZdZ8IrpYGATZrOa3ED9pMLFIpDWNxAlQoAtpSif+kHyLEH93W
         53uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702678973; x=1703283773;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7TFw7xg7w2M+8qc28EqEusL4T4Plz+lf2upO0JPQgw0=;
        b=R8AyCRQEeuROja4PMI7Op+cLVtgavqUt9OLaO0u8s+x03ZWR0p2n+fncDWdCdOm2Nn
         D8fxo9/JPeDDh802RW7tFEKDiWiNbujJZumru5D+L156IOCFp2+xkjHg+nGq8Hl/WkhR
         kq1/0XoN8lHcQ5E7dJC4LMzoCE2VZO3l7B3gDfxInQlhLfe3eDqLdORhxi5a193KHfoL
         r5d58ml+DwaSaaZrnH2ENkQJpHRv/WhjrgyfL+LTIVB3D+lpvbS1WnTNOeMCGxYlda3Z
         g6zYIZRZSyal7z/OlTQ5Jh2iQxQW7fbwjUR63zk4MPUthxNCYa4HKIejYCclGGTELMBw
         SMUw==
X-Gm-Message-State: AOJu0Yys/EfwTbQTOyp40eSdEUu1PRagH2NLj8hAaM6BQdUFyCL4vUUP
	tl0xHGekq5BtInUjvf0dJE77PA==
X-Google-Smtp-Source: AGHT+IEJekFwo4r+H8PtOrZH0hYzvRpj9POtATtBQr7tyBiNEDTS/FAF2UzeUfuDf/WaBoIwrOUJ3A==
X-Received: by 2002:a05:620a:146d:b0:77f:878:b58 with SMTP id j13-20020a05620a146d00b0077f08780b58mr14261801qkl.153.1702678973632;
        Fri, 15 Dec 2023 14:22:53 -0800 (PST)
Received: from dell-precision-5540 ([50.212.55.89])
        by smtp.gmail.com with ESMTPSA id m1-20020ae9e701000000b007759a81d88esm6333130qka.50.2023.12.15.14.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 14:22:53 -0800 (PST)
Date: Fri, 15 Dec 2023 17:22:03 -0500
From: Ben Wolsieffer <ben.wolsieffer@hefring.com>
To: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Subject: Re: [PATCH] spi: stm32: use runtime PM to enable/disable controller
Message-ID: <ZXzRi_h2AMqEhMVw@dell-precision-5540>
References: <20231204202055.2895125-1-ben.wolsieffer@hefring.com>
 <58897511-3187-4583-bf29-11871dd4d136@sirena.org.uk>
 <20231215182739.GA96945@gnbcxd0016.gnb.st.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215182739.GA96945@gnbcxd0016.gnb.st.com>

On Fri, Dec 15, 2023 at 07:27:39PM +0100, Alain Volmat wrote:
> Hi,
> 
> sorry for the delay.
> 
> On Thu, Dec 14, 2023 at 10:58:54AM +0000, Mark Brown wrote:
> > On Mon, Dec 04, 2023 at 03:20:55PM -0500, Ben Wolsieffer wrote:
> > > Instead of disabling the SPI controller between each message, do it
> > > as part of runtime PM.
> > 
> > This doesn't apply against current code, please check and resend.
> 
> I rapidly gave a try on this patch on top of the spi/for-next branch
> (manually fixing the conflict due to the MASTER->HOST renaming).
> It turns out that with that applied, transfers on the MP13
> (compatible: st,stm32h7-spi) are not working anymore while simply
> removing it back it works again.
> (test is simply doing loopback spidev_test)

That's unfortunate; I was worried about something like this because I
only have an STM32F7 to test. If you can't easily determine what's going
wrong, it would be interesting to know if the original version of this
patch has the same problem:
https://lore.kernel.org/lkml/ZWpoKEcM0ZeYAsBa@dell-precision-5540/T/

> 
> spi mode: 0x0
> bits per word: 8
> max speed: 500000 Hz (500 kHz)
> TX | 8D D6 73 8B 9D 8B 1C 7D 8D 80 EC 32 F9 0D BA AD 9F 88 A5 9B 3F AA 48 8C 21 35 0D C1 C8 E5 6A 81  |..s....}...2........?.H.!5....j.|
> RX | 8D 00 00 00 D6 00 73 00 8B 00 00 00 9D 00 00 8B 1C 00 00 00 7D 00 00 8D F9 00 00 00 BA 00 00 00  |......s.............}...........|
> 
> The RX data contains lots of 00 between each byte.  Moreover it seems
> that with this patch applied non-dma transfer (when there is no dmas
> properties within the node) are now failing.
> 
> I'll check that and give more details but could you avoid applying this
> patch for the time being ?
> 
> Thanks.
> Alain

