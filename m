Return-Path: <linux-spi+bounces-89-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B207FD39C
	for <lists+linux-spi@lfdr.de>; Wed, 29 Nov 2023 11:10:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72395282EE2
	for <lists+linux-spi@lfdr.de>; Wed, 29 Nov 2023 10:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302DE199B5;
	Wed, 29 Nov 2023 10:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gD9xgGfa"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 676B6E1;
	Wed, 29 Nov 2023 02:10:00 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-da37522a363so6117726276.0;
        Wed, 29 Nov 2023 02:10:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701252599; x=1701857399; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=11gO8SgbQj4fdCNrsT7TiPo7u2IjmF6eevG42IvsRSM=;
        b=gD9xgGfa1nhSE1fTGyYS+2Ke3MudRLuWlgMtZUUvUXahd8Ohaf2CoIa4A5GN4exgAH
         LN76bOLS0zLP1bU05SmQ3VsIvCuAzSqcbBcaG5qMEqZXjUCLfTP2ZOiggSXTRp33LtUD
         4xMGnpcy71d5GB9cT6/vT6388iYh1TQZ1TIp1TPLVqCpsrJ0mGd7KV07LPcNmuq1XIhY
         SjhXIunwyfbIbFFCuEKTM1gdSZsIhzd3QKDPTwrpx2nN0AvwscfCgCS9JpVNHf47JXKP
         eKc5bOUKaYlOaUqWmhPXjXGbMlOdcivh54GqrR7qWc8z+XOGnkqjONhzxY2atIAvWvQ0
         AvWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701252599; x=1701857399;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=11gO8SgbQj4fdCNrsT7TiPo7u2IjmF6eevG42IvsRSM=;
        b=Aio4I9BqkmLipIdINaGCE3iZHVgMmo+ql5qiwlMvxB+NxhGCk0nn1Yt1LDVcgc29ol
         5zj0Xt6s+QWUUDrB1EAOC/bAtaEcELVkXj/kotG2DJJCtFAt1gPwdN42abWvfXa4r8nA
         l8826Vf4z3ioyb7sWZQ0PgKUzB/eyO9r5HYo03ZMKO/PKbnK1WTxcXMXaOb9dPFcon8I
         /D5hC9mIEAVKSWaqemnrWYQLMIBNnNDyDI16pmLY5PaStoP4bWq/dzZF3RdOdDCt5oYt
         XyLQurXbeMnI6jDrfBufuGFpgwIgrhU+2WB1IUx1z2AY8XG0EfsHpWeWf+54p6ZI2ZFQ
         Fm2g==
X-Gm-Message-State: AOJu0Yy8YE9G3qj1jCnfp9NG5W54M5vzY0ehQMH++vOpz0toR1QaVBDD
	EAW3j/XioxdafBi2mNlNkec=
X-Google-Smtp-Source: AGHT+IHcuevKlD173p6VD/EwXmSKKTLMuUCitNteEbY7uJePXtNhhdHSs2NQVaKH3lVhmxpJmK8Udg==
X-Received: by 2002:a05:6902:3cd:b0:dae:e8f2:b7dd with SMTP id g13-20020a05690203cd00b00daee8f2b7ddmr19125498ybs.13.1701252599530;
        Wed, 29 Nov 2023 02:09:59 -0800 (PST)
Received: from errol.ini.cmu.edu ([72.95.245.133])
        by smtp.gmail.com with ESMTPSA id ec12-20020ad44e6c000000b0067a2b09278esm4110035qvb.7.2023.11.29.02.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 02:09:59 -0800 (PST)
Date: Wed, 29 Nov 2023 05:09:57 -0500
From: "Gabriel L. Somlo" <gsomlo@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Karol Gugala <kgugala@antmicro.com>,
	Mateusz Holenko <mholenko@antmicro.com>,
	Joel Stanley <joel@jms.id.au>, Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>, Lee Jones <lee@kernel.org>,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	Andrew Davis <afd@ti.com>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-spi@vger.kernel.org
Subject: Re: (subset) [PATCH RFC 0/5] Deprecate register_restart_handler()
Message-ID: <ZWcN9RNlk4+SB7CO@errol.ini.cmu.edu>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170110370952.2695179.559211126183016709.b4-ty@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett

Hi Mark,

On Mon, Nov 27, 2023 at 04:48:29PM +0000, Mark Brown wrote:
> On Fri, 17 Nov 2023 10:10:01 -0600, Andrew Davis wrote:
> > Explanation is in patch #1.
> > 
> > The rest of this series is a set of representative examples of converting
> > away from the old API. They should be valid and can be taken by their
> > respective maintainers even if patch #1 doesn't find acceptance.
> > 
> > Thanks,
> > Andrew
> > 
> > [...]
> 
> Applied to
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
> 
> Thanks!
> 
> [4/5] spi: sprd: adi: Use devm_register_restart_handler()
>       commit: 8e6a43961f24cf841d3c0d199521d0b284d948b9

Any chance you can also pick up

[2/5] drivers/soc/litex: Use devm_register_restart_handler()

from this series?

I'm maintaining the LiteX (FPGA SoC) related drivers, but we don't as of
yet have a dedicated "path to upstream" of our own -- we've been mostly
going through specific subsystem trees (e.g. mmc, block, networking, etc.),
for mostly device drivers, up until now...

If not, no worries, I need to dedicate some time to figuring this out
eventually anyway :)

Thanks much,
--Gabriel

> All being well this means that it will be integrated into the linux-next
> tree (usually sometime in the next 24 hours) and sent to Linus during
> the next merge window (or sooner if it is a bug fix), however if
> problems are discovered then the patch may be dropped or reverted.
> 
> You may get further e-mails resulting from automated or manual testing
> and review of the tree, please engage with people reporting problems and
> send followup patches addressing any issues that are reported if needed.
> 
> If any updates are required or you are submitting further changes they
> should be sent as incremental updates against current git, existing
> patches will not be replaced.
> 
> Please add any relevant lists and maintainers to the CCs when replying
> to this mail.
> 
> Thanks,
> Mark
> 

