Return-Path: <linux-spi+bounces-3751-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD03927B7F
	for <lists+linux-spi@lfdr.de>; Thu,  4 Jul 2024 18:59:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CF191F2395E
	for <lists+linux-spi@lfdr.de>; Thu,  4 Jul 2024 16:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE2911B373D;
	Thu,  4 Jul 2024 16:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DfDIMo5B"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3855D1B29DA;
	Thu,  4 Jul 2024 16:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720112365; cv=none; b=R0XQQU5yQKuyFOnk4iqUTOlv19TW/dH32ox7wpEn9UuIxTS2bEJWpJviEdKD7VXvL2msnGKhKd9Ihf95CeOrz2GYSBCzkINrj0eroZt89vTlmXa8ntWg8WqqwKHxa+NpvTI4Z4m2yqQaQZoAAbYSlTOyxgqN+mY/nJtJGukf3c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720112365; c=relaxed/simple;
	bh=bvh4PuQIuYwyGjq205P+pImBCUy091RMzaW7C+y2JT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZrUNK5eU0ZFNUvg5Us6tt8vCOlFhb68OPoGh34rS/8VqtOl4BMbuArdhHiygQmbbUIlTAgLDvoMaCtAilTcHkljwjZJfXhiZq0gb3mrN8uzGHCPqmiQHPMCfbvZ4jg/Z7vW5TpRT/n7yZ8VnaI6WHgQdrIYO6n9C2mIyIt9wT+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DfDIMo5B; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1f9de13d6baso5412155ad.2;
        Thu, 04 Jul 2024 09:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720112363; x=1720717163; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hbx+rexi+bkisDvN1JHt83FrZQeG/TdSXxtwh8uu4R4=;
        b=DfDIMo5BNd8DArGrFNTpCs8DElwjVWDjo1UnNf7mzHGL29EjHsZFVL8CAxGVig7uhD
         GOm1sAa4JOj/1zwYjHkfBfkCKgksH26z9u9tkD1AI5Y84M2R0Wjqlmum5DqS02Bj9PRQ
         g+E88PoHJCz3Dm7sfmiGlhhVKzojJdIKTmbkWZ+GD8YiarJtYp/CBxOXHToB5VXG4+3z
         LqlDvomi9IgxFEMN3SYhyvuYpQ51oJOoJ4guXyjcvc/sKuO06vbvqQYbyulWKIZA/BxW
         HjyjXlH8Nq0Jho9ZdXc5+4095yBeNr+rUMbQ5Skm6Dgi8zt5TV1qWi+QJf5b3Hh29hiq
         pRGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720112363; x=1720717163;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hbx+rexi+bkisDvN1JHt83FrZQeG/TdSXxtwh8uu4R4=;
        b=pjUxfXDHjz40kyJ/MTv8Nn9tkrm56AkYEwADhGQ80EOXiXu49Y7s6Xk/6iYeyL0omn
         djXgi0hkDcS8f4KftQv5GKVEtN45R7BjwT4sl8ImSQmSahYY702TwQPWeOAdQ0OJHA8u
         FFF7G799Z9CVUQoYjL+hg7FIbS3KQlvvV5DpNaNnRhphDASYScmC6CWuYapLVF0nb4He
         fMMs6PAvSSZ3bR0OJ3G+inE/CyGISEsVLdYxFL+O67LQXdtW4dsgm3EhUblAQkFwd0JN
         TPKzzl8ZzRVmOP2cs40/VPprA+PTCwnkZOJfvNDtv8okH8w6qHG+DOBkKD9Gdkx5oBHv
         3+YQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPonm81lpyuboBXTY+zmeyDJtsgzc6OWUimn7Ry4w2H45nR9FgwaH8+/0V/fKTBfL4Og0fWuMqLKJ+49kwMmSsLPJ4326NL+ct61JiEmVLJ3sy8vIDhix129TbUN/j7OW6kzriTCgRioLM+pky00HjZx1Tf2qFsJ1eGH1UAvTzsA9QXA==
X-Gm-Message-State: AOJu0Yy/inGnUVTRuHsL3Nn56E15hohlHD4rIyxq2j5DNLMfGky6OduS
	s7RMI8lg+J78FvQ1oX0TH9c5kirEVNeyKJL2u5leT2jg3gVXlruG
X-Google-Smtp-Source: AGHT+IFpNMXcHa+uUusED4LID/clJgWo2VKFAANu9IISFIFSGHyMQF87TT1HKT00VSFY3N8gXegW3A==
X-Received: by 2002:a17:903:32cb:b0:1fb:1a0f:44d3 with SMTP id d9443c01a7336-1fb33e94f14mr19752315ad.39.1720112363237;
        Thu, 04 Jul 2024 09:59:23 -0700 (PDT)
Received: from x1 ([2601:1c2:1802:170:8756:5e46:4951:e2d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fb1a596822sm34936475ad.163.2024.07.04.09.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 09:59:22 -0700 (PDT)
Date: Thu, 4 Jul 2024 09:59:20 -0700
From: Drew Fustini <pdp7pdp7@gmail.com>
To: Conor Dooley <conor@kernel.org>
Cc: Kanak Shilledar <kanakshilledar@gmail.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jisheng Zhang <jszhang@kernel.org>, Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>, Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 3/3] riscv: dts: thead: add basic spi node
Message-ID: <ZobU6K/R3pfHrK9c@x1>
References: <20240701121355.262259-2-kanakshilledar@gmail.com>
 <20240701121355.262259-5-kanakshilledar@gmail.com>
 <20240703-juice-refreeze-62c468a56ea5@spud>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240703-juice-refreeze-62c468a56ea5@spud>

On Wed, Jul 03, 2024 at 03:45:37PM +0100, Conor Dooley wrote:
> Kanak, Drew,
> 
> On Mon, Jul 01, 2024 at 05:43:54PM +0530, Kanak Shilledar wrote:
> > created spi0 node with fixed clock. the spi0 node
> > uses synopsis designware driver and has the following
> > compatible "snps,dw-apb-ssi". the spi0 node is connected
> > to a SPI NOR flash pad which is left unpopulated on the back
> > side of the board.
> > 
> > Signed-off-by: Kanak Shilledar <kanakshilledar@gmail.com>
> > ---
> > Changes in v2:
> > - Separated from a single patch file
> > ---
> >  .../boot/dts/thead/th1520-beaglev-ahead.dts      |  9 +++++++++
> >  .../boot/dts/thead/th1520-lichee-module-4a.dtsi  |  4 ++++
> >  .../riscv/boot/dts/thead/th1520-lichee-pi-4a.dts |  5 +++++
> 
> Didn't you say there was a flash on one of these two boards?
> 
> >  arch/riscv/boot/dts/thead/th1520.dtsi            | 16 ++++++++++++++++
> >  4 files changed, 34 insertions(+)
> > 
> > diff --git a/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts b/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts
> > index d9b4de9e4757..3103b74e0288 100644
> > --- a/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts
> > +++ b/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts
> > @@ -17,6 +17,7 @@ aliases {
> >  		gpio1 = &gpio1;
> >  		gpio2 = &gpio2;
> >  		gpio3 = &gpio3;
> > +		spi0 = &spi0;
> 
> "spi" would sort after "serial".
> 
> >  		serial0 = &uart0;
> >  		serial1 = &uart1;
> >  		serial2 = &uart2;
> > @@ -52,6 +53,10 @@ &sdhci_clk {
> >  	clock-frequency = <198000000>;
> >  };
> >  
> > +&spi_clk {
> > +	clock-frequency = <396000000>;
> > +};
> 
> I'm pretty sceptical about adding more of these fixed clocks, rather
> than waiting for the clock driver. Drew, what do you think? Should we
> just add one more to your fixup list or would you rather delay? Guess it
> depends on how long more you think that clock driver is likely to take.

I think the clk driver [1] is in good shape but it has not been reviewed
by the clk maintainer yet. Thus it is hard to predict any timeline for
it getting merged.

SPI support doesn't require any driver changes so I'd be inclined to
allow the fixed clock in this case. It will be simple to change it over
to a real clock once the clk driver is upstream.

Acked-by: Drew Fustini <drew@pdp7.com>

Thanks,
Drew

