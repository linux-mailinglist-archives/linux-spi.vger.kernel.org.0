Return-Path: <linux-spi+bounces-8622-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7019DADD455
	for <lists+linux-spi@lfdr.de>; Tue, 17 Jun 2025 18:09:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12B51188758C
	for <lists+linux-spi@lfdr.de>; Tue, 17 Jun 2025 15:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C2872F365D;
	Tue, 17 Jun 2025 15:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="HIqVRqdc"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A663B2EA14F
	for <linux-spi@vger.kernel.org>; Tue, 17 Jun 2025 15:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750175718; cv=none; b=mT55W08XeKI5DKFPCAG7JC5XebIWHm3Z3YUbNn/m/yzgjw3dU73kwtsGt/N0eWql7rVaDPpF1zzhOJ/43VeytXKD8aaQ/I0nvVdlWqGSMKDnuaNY8YulLEm7tpKLO1LCIG/yEud6C750C/6Gf5yey0q3/H5KrwTt/sRisLr7vS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750175718; c=relaxed/simple;
	bh=55IiHynz00pYy+b7hGuuDjrL2Y//CLig++XAkelZNU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XEeX0Nqx1rJ6CBXULcHOaljArerOTI4zAOEuxWimldmttKXx9KcG3SS9ynG1iFvvO2ShbcSgLOJkRO2UkrjLTmuVuwq+Me6LGM47dzSEPYC51FRPC7BPC4Og4/a3pFsLQLpJybHPWPIbsAPbA0uYqPTD9nZA8jpz12JbkACLsKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=HIqVRqdc; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4a442a3a2bfso107094031cf.1
        for <linux-spi@vger.kernel.org>; Tue, 17 Jun 2025 08:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1750175715; x=1750780515; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wx304DZ0NE2g+OOJjBg61lF2TCxnm7rjurAO1hRurAk=;
        b=HIqVRqdcOM4dDB8xrn1Py7RCcYdMa06j2fwy4Yz1zBiYGgAfO59m9m3uatw1ynKgkY
         HEF2qsGl3Ek9fyOlCEPddvdrZEMUJeZYunfJqUDC8+M1wb7Kcn1kbcgMwp8ivgAIPvhI
         w7vOd5IDMbcrC2NZf1zsK9RYMV8sA2L0CHdwLS9YDvze56bH3fKVGkJqNASxCWU20Jim
         c/89OCT2QHklTFpDlRLcDMuLvDfv2E5V3/5z4Ctb4RWB7jQLT4MTZtOHEf3nBpATz+W2
         Qi/xch2rzD46weHvEw/s8aSyXwc4qbjVTZI/8WRXWqEa6FxVbRON4IAffCFDWeNNNqiO
         JGtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750175715; x=1750780515;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wx304DZ0NE2g+OOJjBg61lF2TCxnm7rjurAO1hRurAk=;
        b=b/aLokZs2yxoWpXGBaDWAw1cK9mNHrZq7WXUAvB9L/+Wv7Moxon35YRcc0orNsOpbt
         a4laZj0MCBGBovJ1by10znngFGxvm3ggz/9oUAvAGyMhtBZfss6nCl4MzqX6Ig73yCT8
         xOTyR0j6dQ+CenaseH5NiHQZbw629ynF3VmQA82ahyCetR1D4yXtZUCmv5uecFYi2cuX
         4JxTEDmjWLPhu1iq8ivHRZF2gKGpgl0sBgvcGMh2CbSb0viswDr/EuM4tgUgLZxEfXgu
         ZmyaB9q+Nedj4TF6UEXHtn6NlyPInOPlGiIL+ClHQacU+iY89IYz8V41cCdMLrbbB80l
         zkfg==
X-Forwarded-Encrypted: i=1; AJvYcCUXniy/jGWuS5Zs1BTY37ZDCq88F9QIQAuYmDySFCrBrJv3P6qeaiS2Q1r04cFTc2/PtptMO5K2vDw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUzWvaLybUNDHBuNOqjS0qfqj/8PwKV61CXBTvFyQnW99mUDaf
	XQfja+FKqm3sUz/FTgui+UfjeqrNXGRCIybeYQhOacQ+KNvQHAU3hPFmv+jTqfsjXz+mlxXf9kn
	JgGYA
X-Gm-Gg: ASbGnctkm8w/uwysWhwqaDsHpznWbIFMT2V8FADTp9sS/ziBEeNXqczUFpjNyE9hGV5
	MZbP3/WK4N2K1vo1mjoLVcNmcMzeWaG+roxq588KymO88GefRyyR/cW9BORtxzbZwl+EdESmpVU
	265auWsOP6vZaGrq5GICp3uc30CZMaJthUNxenqTc+xHN/TNWraW6drui8fi42f9+NmV8WVgCfg
	6j/TYRYpUY9t1xDEdkJR8BqhmCLrgQCEWE8ltUEhsNF99U8NzxXpkY2RhKd3+EjVRmpMK6cNQMH
	t6q8XjnhvgYXagY4L5DaN2KWxK1uXWgoFjsedOOhOzkGF8M8DEI4Tt7erImpJqb4wKX4N4za5a6
	aamN7LbFXocj4UnBXvl2efImSyoyQTQ6BoA6OuA==
X-Google-Smtp-Source: AGHT+IFXnZTcKPgzMT86nxmrlf7kz4ru5nOzoSNqyGX+eUmWwxWkQ7vtqqAzKrLwaYYroH6Qyc+UTQ==
X-Received: by 2002:a05:6214:2682:b0:6fa:c634:dc01 with SMTP id 6a1803df08f44-6fb47786d90mr220187206d6.16.1750175715483;
        Tue, 17 Jun 2025 08:55:15 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-56-70.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.56.70])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fb35b20abasm63746496d6.1.2025.06.17.08.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 08:55:14 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uRYeY-00000006WS6-1OTF;
	Tue, 17 Jun 2025 12:55:14 -0300
Date: Tue, 17 Jun 2025 12:55:14 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Christoph Hellwig <hch@lst.de>, James Clark <james.clark@linaro.org>,
	Mark Brown <broonie@kernel.org>,
	Vladimir Oltean <olteanv@gmail.com>, oe-kbuild-all@lists.linux.dev,
	Larisa Grigore <larisa.grigore@nxp.com>,
	Frank Li <Frank.li@nxp.com>, linux-spi@vger.kernel.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev
Subject: Re: [PATCH] dma-mapping: Stub out dma_{alloc,free,map}_pages() API
Message-ID: <20250617155514.GC1376515@ziepe.ca>
References: <7cfcf919-3c7d-4f0c-911f-697ea3141080@linaro.org>
 <20250616131346.GB29838@lst.de>
 <83855c1a-c128-4762-9d6b-e17f2c4c8820@linaro.org>
 <d16bdc40-20d6-49db-bf41-18bb9b8e01fd@linaro.org>
 <20250616131944.GA30260@lst.de>
 <f723d490-c228-42d5-9f9f-158df54a092d@linaro.org>
 <9788991a-ac37-4fde-81db-c55035d00f27@app.fastmail.com>
 <20250617044833.GE1824@lst.de>
 <5de445aa-048b-4f60-9045-df5d45341436@app.fastmail.com>
 <76a8c896-d7ea-4471-99a2-34b3a7ac9804@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76a8c896-d7ea-4471-99a2-34b3a7ac9804@app.fastmail.com>

On Tue, Jun 17, 2025 at 10:26:51AM +0200, Arnd Bergmann wrote:
> On Tue, Jun 17, 2025, at 09:53, Arnd Bergmann wrote:
> 
> > Between SH72xx/SH76xx, SUN3 and M68328, I believe the
> > supported machines are all limited to between 1MB and 32MB in
> > the maximum configuration, which is obviously extremely
> > tight.
> 
> I checked the exact numbers we're talking about here: enabling
> CONFIG_HAS_DMA on rsk7269_defconfig adds 10KB of extra vmlinux
> size, which doesn't seem too bad:
> 
>    text	   data	    bss	    dec	    hex	filename
> 3295084	1111396	 112264	4518744	 44f358	vmlinux-before
> 3302836	1113652	 112264	4528752	 451a70	vmlinux-after

Long ago I ran some numbers for an ancient PPC system:

https://lore.kernel.org/all/20121119214922.GA5636@obsidianresearch.com/

The base smallest kernel was growing .text and a stripped down initrd
at a rate of 1MB evey 6 years.

Somehow I doubt that system (with 16MB ram I think it was) would even
fit a v6.x kernel. v3.6 was already challenging.

Even back then Greg was incredulous that an embedded system would run
a 6 year newer kernel. Here we are contemplating a 20 year newer
kernel?

I think you have the right direction, we just removed !SMP support,
removing !DMA also seems logical to me.

Jason

